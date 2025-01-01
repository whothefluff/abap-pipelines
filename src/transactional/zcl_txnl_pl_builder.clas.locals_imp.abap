*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

class interaction_phase_start definition ##CLASS_FINAL
                              create public.

  public section.

    interfaces: zif_pl_step_execution.

endclass.

class interaction_phase_start_fty definition ##CLASS_FINAL
                                  create public.

  public section.

    methods get
              returning
                value(r_val) type ref to zif_pl_step_execution.

endclass.

class _save_phase_start definition deferred.

class save_phase_start definition ##CLASS_FINAL
                       create public
                       friends _save_phase_start.

  public section.

    interfaces: zif_pl_step_execution.

    methods constructor.

  protected section.

    data _aggr_exc_fty type ref to zcl_static_check_exc_aggr_fty.

endclass.

class txnl_pipeline_finalizer definition ##CLASS_FINAL
                              create public.

  public section.

    interfaces: zif_txnl_pl_finalizer.

endclass.

class save_phase_builder_fty definition ##CLASS_FINAL
                             create public.

  public section.

    methods from
              importing
                i_builder type ref to zcl_pl_step_builder
              returning
                value(r_val) type ref to zif_txnl_pl_save_ph_builder.

endclass.

class _txnl_pipeline definition deferred.

class txnl_pipeline definition ##CLASS_FINAL
                    create public
                    friends _txnl_pipeline.

  public section.

    interfaces: zif_txnl_pl.

    methods constructor
              importing
                i_pl_to_adapt type ref to zcl_pl_step.

  protected section.

    data _adapted type ref to zcl_pl_step.

    data _finalizer type ref to zif_txnl_pl_finalizer.

endclass.

class txnl_pipeline_fty definition ##CLASS_FINAL
                        create public.

  public section.

    methods from
              importing
                i_pipeline type ref to zcl_pl_step
              returning
                value(r_val) type ref to zif_txnl_pl.

endclass.

class _save_phase_builder definition deferred.

class save_phase_builder definition ##CLASS_FINAL
                         create public
                         friends _save_phase_builder.

  public section.

    interfaces: zif_txnl_pl_save_ph_builder.

    methods constructor
              importing
                i_to_adapt type ref to zcl_pl_step_builder.

  protected section.

    data _adapted type ref to zcl_pl_step_builder.

    data _txnl_pipeline_fty type ref to txnl_pipeline_fty.

endclass.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

class interaction_phase_start implementation.

  method zif_pl_step_execution~run.

    cl_abap_tx=>modify( ).

  endmethod.

endclass.
class interaction_phase_start_fty implementation.

  method get.

    return new interaction_phase_start( ).

  endmethod.

endclass.
class save_phase_start implementation.

  method constructor.

    _aggr_exc_fty = new zcl_static_check_exc_aggr_fty( ).

  endmethod.
  method zif_pl_step_execution~run.

    try.

      cl_abap_tx=>save( ).

    catch cx_root into final(e) ##CATCH_ALL. "CX_ABAP_BEHV_SAVE_FAILED can occur

      raise exception _aggr_exc_fty->from( value #( ( e ) ) ).

    endtry.

  endmethod.

endclass.
class txnl_pipeline_finalizer implementation.

  method zif_txnl_pl_finalizer~abort.

    rollback work.

  endmethod.
  method zif_txnl_pl_finalizer~complete.

    commit work.

  endmethod.

endclass.
class save_phase_builder implementation.

  method constructor.

    _adapted = i_to_adapt.

    _txnl_pipeline_fty = new txnl_pipeline_fty( ).

  endmethod.
  method zif_txnl_pl_save_ph_builder~add_to_save_phase.

    _adapted->add( i_execution = i_execution
                   i_error_handling_ovrrd = i_error_handling_ovrrd
                   i_skip_handling_ovrrd = i_skip_handling_ovrrd ).

    return me.

  endmethod.
  method zif_txnl_pl_save_ph_builder~add_save_phase_step.

    _adapted->add_step( i_step ).

    return me.

  endmethod.
  method zif_txnl_pl_save_ph_builder~build.

    return _txnl_pipeline_fty->from( _adapted->build( ) ).

  endmethod.

endclass.
class save_phase_builder_fty implementation.

  method from.

    return new save_phase_builder( i_builder ).

  endmethod.

endclass.
class txnl_pipeline implementation.

  method constructor.

    _adapted = i_pl_to_adapt.

    _finalizer = new txnl_pipeline_finalizer( ).

  endmethod.
  method zif_txnl_pl~apply.

    _adapted->start( i_context ).

    return _finalizer.

  endmethod.

endclass.
class txnl_pipeline_fty implementation.

  method from.

    return new txnl_pipeline( i_pipeline ).

  endmethod.

endclass.
