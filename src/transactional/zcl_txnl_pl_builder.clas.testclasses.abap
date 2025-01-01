*"* use this source file for your ABAP unit test classes

"! Testing {@link .INTERACTION_PHASE_START_FTY}
class _interaction_phase_start_fty definition
                                   final
                                   for testing
                                   risk level harmless
                                   duration short.

  private section.

    methods get_returns_instance for testing.

endclass.
class _interaction_phase_start_fty implementation.

  method get_returns_instance.

    "arrange
    final(o) = new interaction_phase_start_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_bound( o->get( ) ).

  endmethod.

endclass.

"! Testing {@link .SAVE_PHASE_START}
class _save_phase_start definition
                        final
                        for testing
                        risk level harmless
                        duration short.

  private section.

    methods constructor_sets_attr for testing.

endclass.
class _save_phase_start implementation.

  method constructor_sets_attr.

    "act
    final(o) = new save_phase_start( ).

    "assert
    cl_abap_unit_assert=>assert_bound( o->_aggr_exc_fty ).

  endmethod.

endclass.

"! Testing {@link .SAVE_PHASE_BUILDER_FTY}
class _save_phase_builder_fty definition
                              final
                              for testing
                              risk level harmless
                              duration short.

  private section.

    methods from_returns_instance for testing.

endclass.
class _save_phase_builder_fty implementation.

  method from_returns_instance.

    "arrange
    final(o) = new save_phase_builder_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_bound( o->from( value #( ) ) ).

  endmethod.

endclass.

"! Testing {@link .TXNL_PIPELINE_FTY}
class _txnl_pipeline_fty definition
                         final
                         for testing
                         risk level harmless
                         duration short.

  private section.

    methods from_returns_instance for testing.

endclass.
class _txnl_pipeline_fty implementation.

  method from_returns_instance.

    "arrange
    final(o) = new txnl_pipeline_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_bound( o->from( value #( ) ) ).

  endmethod.

endclass.

class _pl_step_start_spy definition ##CLASS_FINAL
                         inheriting from zcl_pl_step
                         create public
                         for testing.

  public section.

    methods constructor.

    methods start redefinition.

    data last_arg type ref to zif_pl_step_context read-only.

endclass.
class _pl_step_start_spy implementation.

  method constructor.

    super->constructor( i_execution = value #( )
                        i_error_handling = value #( )
                        i_skip_handling = value #( ) ).

  endmethod.
  method start.

    last_arg = i_context.

  endmethod.

endclass.

"! Testing {@link .TXNL_PIPELINE}
class _txnl_pipeline definition
                     final
                     for testing
                     risk level harmless
                     duration short.

  private section.

    methods constructor_sets_attr for testing.

    methods apply_starts_adapted for testing.

    methods apply_returns_finalizer for testing.

endclass.
class _txnl_pipeline implementation.

  method constructor_sets_attr.

    "arrange
    final(some_pipeline) = new zcl_pl_step( i_execution = value #( )
                                            i_error_handling = value #( )
                                            i_skip_handling = value #( ) ).

    "act
    final(o) = new txnl_pipeline( some_pipeline ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->_adapted eq some_pipeline
                                               and o->_finalizer is bound ) ).

  endmethod.
  method apply_starts_adapted.

    "arrange
    final(some_ctx) = cast zif_pl_step_context( cl_abap_testdouble=>create( 'ZIF_PL_STEP_CONTEXT' ) ).

    final(pipeline_spy) = new _pl_step_start_spy( ).

    final(o) = new txnl_pipeline( value #( ) ).

    o->_adapted = pipeline_spy.

    "act
    cast zif_txnl_pl( o )->apply( some_ctx ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_ctx
                                        act = pipeline_spy->last_arg ).

  endmethod.
  method apply_returns_finalizer.

    "arrange
    final(some_finalizer) = cast zif_txnl_pl_finalizer( cl_abap_testdouble=>create( 'ZIF_TXNL_PL_FINALIZER' ) ).

    final(o) = new txnl_pipeline( value #( ) ).

    o->_adapted = new _pl_step_start_spy( ).

    o->_finalizer = some_finalizer.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_finalizer
                                        act = cast zif_txnl_pl( o )->apply( value #( ) ) ).

  endmethod.

endclass.

class _step_builder_spy_stub definition ##CLASS_FINAL
                             inheriting from zcl_pl_step_builder
                             create public
                             for testing.

  public section.

    types t_canned_answer type zcl_pl_step_builder=>t_step.

    methods constructor
              importing
                i_build_canned_answer type _step_builder_spy_stub=>t_canned_answer optional.

    methods add redefinition.

    methods add_step redefinition.

    methods build redefinition.

    data last_execution type zcl_pl_step_builder=>t_execution read-only.

    data last_error_handling_ovrrd type zcl_pl_step_builder=>t_error_handling read-only.

    data last_skip_handling_ovrrd type zcl_pl_step_builder=>t_skip_handling read-only.

    data last_step type zcl_pl_step_builder=>t_step read-only.

  protected section.

    data _build_canned_answer type _step_builder_spy_stub=>t_canned_answer.

endclass.
class _step_builder_spy_stub implementation.

  method constructor.

    super->constructor( i_def_error_handling = value #( )
                        i_def_skip_handling = value #( ) ).

    _build_canned_answer = i_build_canned_answer.

  endmethod.
  method add.

    last_execution = i_execution.

    last_error_handling_ovrrd = i_error_handling_ovrrd.

    last_skip_handling_ovrrd = i_skip_handling_ovrrd.

    return me.

  endmethod.
  method add_step.

    last_step = i_step.

    return me.

  endmethod.
  method build.

    return _build_canned_answer.

  endmethod.

endclass.

class _txnl_pipeline_fty_stub definition ##CLASS_FINAL
                              inheriting from txnl_pipeline_fty
                              create public
                              for testing.

  public section.

    types: begin of t_args,
             begin of expected,
               pipeline type ref to zcl_pl_step,
             end of expected,
             canned_answer type ref to zif_txnl_pl,
           end of t_args.

    methods constructor
              importing
                i_args type _txnl_pipeline_fty_stub=>t_args.

    methods from redefinition.

  protected section.

    data _args type _txnl_pipeline_fty_stub=>t_args.

endclass.
class _txnl_pipeline_fty_stub implementation.

  method constructor.

    super->constructor( ).

    _args = i_args.

  endmethod.
  method from.

    return cond #( when i_pipeline eq _args-expected-pipeline
                   then _args-canned_answer ).

  endmethod.

endclass.

"! Testing {@link .SAVE_PHASE_BUILDER}
class _save_phase_builder definition
                          final
                          for testing
                          risk level harmless
                          duration short.

  private section.

    methods constructor_sets_attr for testing.

    methods add_to_save_phase_delegates for testing.

    methods add_to_save_phase_is_chainable for testing.

    methods add_save_phase_step_delegates for testing.

    methods add_save_ph_step_is_chainable for testing.

    methods build_rets_pipeline_of_built for testing.

endclass.
class _save_phase_builder implementation.

  method constructor_sets_attr.

    "arrange
    final(some_builder) = new zcl_pl_step_builder( i_def_error_handling = value #( )
                                                   i_def_skip_handling = value #( ) ).

    "act
    final(o) = new save_phase_builder( some_builder ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->_adapted eq some_builder
                                               and o->_txnl_pipeline_fty is bound ) ).

  endmethod.
  method add_to_save_phase_delegates.

    "arrange
    final(some_exe_sty) = cast zif_pl_step_execution( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) ).

    final(some_err_ovrrd) = cast zif_pl_step_error_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) ).

    final(some_skip_ovrrd) = cast zif_pl_step_skip_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ).

    final(builder_spy) = new _step_builder_spy_stub( ).

    final(o) = new save_phase_builder( value #( ) ).

    o->_adapted = builder_spy.

    "act
    cast zif_txnl_pl_save_ph_builder( o )->add_to_save_phase( i_execution = some_exe_sty
                                                              i_error_handling_ovrrd = some_err_ovrrd
                                                              i_skip_handling_ovrrd = some_skip_ovrrd ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( builder_spy->last_execution eq some_exe_sty
                                               and builder_spy->last_error_handling_ovrrd eq some_err_ovrrd
                                               and builder_spy->last_skip_handling_ovrrd eq some_skip_ovrrd ) ).

  endmethod.
  method add_to_save_phase_is_chainable.

    "arrange
    final(o) = new save_phase_builder( value #( ) ).

    o->_adapted = new _step_builder_spy_stub( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = o
                                        act = cast zif_txnl_pl_save_ph_builder( o )->add_to_save_phase( value #( ) ) ).

  endmethod.
  method add_save_phase_step_delegates.

    "arrange
    final(some_step) = new zcl_pl_step( i_execution = value #( )
                                        i_error_handling = value #( )
                                        i_skip_handling = value #( ) ).

    final(builder_spy) = new _step_builder_spy_stub( ).

    final(o) = new save_phase_builder( value #( ) ).

    o->_adapted = builder_spy.

    "act
    cast zif_txnl_pl_save_ph_builder( o )->add_save_phase_step( some_step ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_step
                                        act = builder_spy->last_step ).

  endmethod.
  method add_save_ph_step_is_chainable.

    "arrange
    final(o) = new save_phase_builder( value #( ) ).

    o->_adapted = new _step_builder_spy_stub( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = o
                                        act = cast zif_txnl_pl_save_ph_builder( o )->add_save_phase_step( value #( ) ) ).

  endmethod.
  method build_rets_pipeline_of_built.

    "arrange
    final(some_root_step) = new zcl_pl_step( i_execution = value #( )
                                             i_error_handling = value #( )
                                             i_skip_handling = value #( ) ).

    final(some_pipeline) = cast zif_txnl_pl( cl_abap_testdouble=>create( 'ZIF_TXNL_PL' ) ).

    final(o) = new save_phase_builder( value #( ) ).

    o->_adapted = new _step_builder_spy_stub( some_root_step ).

    o->_txnl_pipeline_fty = new _txnl_pipeline_fty_stub( value #( expected = value #( pipeline = some_root_step )
                                                                  canned_answer = some_pipeline ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_pipeline
                                        act = cast zif_txnl_pl_save_ph_builder( o )->build( ) ).

  endmethod.

endclass.

class _intr_phase_start_fty_stub definition ##CLASS_FINAL
                                 inheriting from interaction_phase_start_fty
                                 create public
                                 for testing.

  public section.

    types t_canned_answer type ref to zif_pl_step_execution.

    methods constructor
              importing
                i_canned_answer type _intr_phase_start_fty_stub=>t_canned_answer.

    methods get redefinition.

  protected section.

    data _canned_answer type _intr_phase_start_fty_stub=>t_canned_answer.

endclass.
class _intr_phase_start_fty_stub implementation.

  method constructor.

    super->constructor( ).

    _canned_answer = i_canned_answer.

  endmethod.
  method get.

    return _canned_answer.

  endmethod.

endclass.

class _save_ph_builder_fty_stub definition ##CLASS_FINAL
                                inheriting from save_phase_builder_fty
                                create public
                                for testing.

  public section.

    types: begin of t_args,
             begin of expected,
               builder type ref to zcl_pl_step_builder,
             end of expected,
             canned_answer type ref to zif_txnl_pl_save_ph_builder,
           end of t_args.

    methods constructor
              importing
                i_args type _save_ph_builder_fty_stub=>t_args.

    methods from redefinition.

  protected section.

    data _args type _save_ph_builder_fty_stub=>t_args.

endclass.
class _save_ph_builder_fty_stub implementation.

  method constructor.

    super->constructor( ).

    _args = i_args.

  endmethod.
  method from.

    return cond #( when i_builder eq _args-expected-builder
                   then _args-canned_answer ).

  endmethod.

endclass.

class _step_builder_fty_stub definition ##CLASS_FINAL
                             inheriting from zcl_pl_step_builder_fty
                             create public
                             for testing.

  public section.

    types: begin of t_args,
             begin of expected,
               def_error_handling type zcl_pl_step_builder=>t_error_handling,
               def_skip_handling type zcl_pl_step_builder=>t_skip_handling,
             end of expected,
             canned_answer type ref to zcl_pl_step_builder,
           end of t_args.

    methods constructor
              importing
                i_args type _step_builder_fty_stub=>t_args.

    methods from redefinition.

  protected section.

    data _args type _step_builder_fty_stub=>t_args.

endclass.
class _step_builder_fty_stub implementation.

  method constructor.

    super->constructor( ).

    _args = i_args.

  endmethod.
  method from.

    return cond #( when i_def_error_handling eq _args-expected-def_error_handling
                        and i_def_skip_handling eq _args-expected-def_skip_handling
                   then _args-canned_answer ).

  endmethod.

endclass.

class _ definition deferred.

class zcl_txnl_pl_builder definition local friends _.

"! <p class="shorttext synchronized" lang="EN">Tests</p>
class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    "! Returns an instance built on stubbed collaborators, so that only the test of the class constructor depends on it
    methods txnl_builder_adapting
              importing
                i_builder type ref to zcl_pl_step_builder
              returning
                value(r_val) type ref to zcl_txnl_pl_builder.

    class-methods class_setup.

    methods setup.

    methods class_constructor_sets_attr for testing.

    methods constructor_sets_attr for testing.

    "! Verifies a side-effect, which is why it's a separate test
    methods const_adds_intr_phase_start for testing.

    methods add_to_intr_phase_delegates for testing.

    methods add_to_intr_phase_is_chainable for testing.

    methods add_intr_phase_step_delegates for testing.

    methods add_intr_ph_step_is_chainable for testing.

    methods continue_rets_save_ph_builder for testing.

    class-methods class_teardown.

    class-data _intr_phase_start_fty_backup type ref to interaction_phase_start_fty.

    class-data _step_builder_f_backup type ref to zcl_pl_step_builder_fty.

endclass.
class _ implementation.

  method txnl_builder_adapting.

    zcl_txnl_pl_builder=>_interaction_phase_start_fty = new _intr_phase_start_fty_stub( value #( ) ).

    zcl_txnl_pl_builder=>_step_builder_f = new _step_builder_fty_stub( value #( canned_answer = i_builder ) ).

    return new zcl_txnl_pl_builder( i_def_error_handling = value #( )
                                    i_def_skip_handling = value #( ) ).

  endmethod.
  method class_setup.

    _intr_phase_start_fty_backup = cast #( zcl_txnl_pl_builder=>_interaction_phase_start_fty ).

    _step_builder_f_backup = zcl_txnl_pl_builder=>_step_builder_f.

  endmethod.
  method setup.

    zcl_txnl_pl_builder=>_interaction_phase_start_fty = _intr_phase_start_fty_backup.

    zcl_txnl_pl_builder=>_step_builder_f = _step_builder_f_backup.

  endmethod.
  method class_constructor_sets_attr.

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( zcl_txnl_pl_builder=>_interaction_phase_start_fty is bound
                                               and zcl_txnl_pl_builder=>_step_builder_f is bound ) ).

  endmethod.
  method constructor_sets_attr.

    "arrange
    final(err) = cast zif_pl_step_error_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) ).

    final(skip) = cast zif_pl_step_skip_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ).

    final(some_builder) = new _step_builder_spy_stub( ).

    zcl_txnl_pl_builder=>_interaction_phase_start_fty = new _intr_phase_start_fty_stub( value #( ) ).

    zcl_txnl_pl_builder=>_step_builder_f = new _step_builder_fty_stub( value #( expected = value #( def_error_handling = err
                                                                                                    def_skip_handling = skip )
                                                                                canned_answer = some_builder ) ).

    "act
    final(o) = new zcl_txnl_pl_builder( i_def_error_handling = err
                                        i_def_skip_handling = skip ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->_adapted eq some_builder
                                               and o->_save_phase_builder_fty is bound
                                               and o->_save_phase_start is bound ) ).

  endmethod.
  method const_adds_intr_phase_start.

    "arrange
    final(some_start) = cast zif_pl_step_execution( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) ).

    zcl_txnl_pl_builder=>_interaction_phase_start_fty = new _intr_phase_start_fty_stub( some_start ).

    final(builder_spy) = new _step_builder_spy_stub( ).

    zcl_txnl_pl_builder=>_step_builder_f = new _step_builder_fty_stub( value #( canned_answer = builder_spy ) ).

    "act
    new zcl_txnl_pl_builder( i_def_error_handling = value #( )
                             i_def_skip_handling = value #( ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_start
                                        act = builder_spy->last_execution ).

  endmethod.
  method add_to_intr_phase_delegates.

    "arrange
    final(some_exe_sty) = cast zif_pl_step_execution( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) ).

    final(some_err_ovrrd) = cast zif_pl_step_error_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) ).

    final(some_skip_ovrrd) = cast zif_pl_step_skip_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ).

    final(builder_spy) = new _step_builder_spy_stub( ).

    final(o) = txnl_builder_adapting( builder_spy ).

    "act
    cast zif_txnl_pl_intr_ph_builder( o )->add_to_interaction_phase( i_execution = some_exe_sty
                                                                     i_error_handling_ovrrd = some_err_ovrrd
                                                                     i_skip_handling_ovrrd = some_skip_ovrrd ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( builder_spy->last_execution eq some_exe_sty
                                               and builder_spy->last_error_handling_ovrrd eq some_err_ovrrd
                                               and builder_spy->last_skip_handling_ovrrd eq some_skip_ovrrd ) ).

  endmethod.
  method add_to_intr_phase_is_chainable.

    "arrange
    final(o) = txnl_builder_adapting( new _step_builder_spy_stub( ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = o
                                        act = cast zif_txnl_pl_intr_ph_builder( o )->add_to_interaction_phase( value #( ) ) ).

  endmethod.
  method add_intr_phase_step_delegates.

    "arrange
    final(some_step) = new zcl_pl_step( i_execution = value #( )
                                        i_error_handling = value #( )
                                        i_skip_handling = value #( ) ).

    final(builder_spy) = new _step_builder_spy_stub( ).

    final(o) = txnl_builder_adapting( builder_spy ).

    "act
    cast zif_txnl_pl_intr_ph_builder( o )->add_interaction_phase_step( some_step ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_step
                                        act = builder_spy->last_step ).

  endmethod.
  method add_intr_ph_step_is_chainable.

    "arrange
    final(o) = txnl_builder_adapting( new _step_builder_spy_stub( ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = o
                                        act = cast zif_txnl_pl_intr_ph_builder( o )->add_interaction_phase_step( value #( ) ) ).

  endmethod.
  method continue_rets_save_ph_builder.

    "arrange
    final(some_start) = cast zif_pl_step_execution( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) ).

    final(some_save_ph_builder) = cast zif_txnl_pl_save_ph_builder( cl_abap_testdouble=>create( 'ZIF_TXNL_PL_SAVE_PH_BUILDER' ) ).

    final(builder_spy) = new _step_builder_spy_stub( ).

    final(o) = txnl_builder_adapting( builder_spy ).

    o->_save_phase_start = some_start.

    o->_save_phase_builder_fty = new _save_ph_builder_fty_stub( value #( expected = value #( builder = builder_spy )
                                                                         canned_answer = some_save_ph_builder ) ).

    "act
    final(result) = cast zif_txnl_pl_intr_ph_builder( o )->continue( ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( builder_spy->last_execution eq some_start
                                               and result eq some_save_ph_builder ) ).

  endmethod.
  method class_teardown.

    zcl_txnl_pl_builder=>_interaction_phase_start_fty = _intr_phase_start_fty_backup.

    zcl_txnl_pl_builder=>_step_builder_f = _step_builder_f_backup.

  endmethod.

endclass.
