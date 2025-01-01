"! <p class="shorttext synchronized" lang="EN">Transactional Pipeline Builder</p>
class zcl_txnl_pl_builder definition
                          public
                          create public.

  public section.

    interfaces: zif_txnl_pl_intr_ph_builder.

    class-methods class_constructor.

    "! <p class="shorttext synchronized" lang="EN">Initializes the Transactional Pipeline Builder</p>
    "!
    "! This automatically injects the Controlled LUW Interaction Phase start step.
    "!
    "! @parameter i_def_error_handling | <p class="shorttext synchronized" lang="EN">Default policy for handled step exceptions</p>
    "! @parameter i_def_skip_handling | <p class="shorttext synchronized" lang="EN">Default policy for skipped steps</p>
    methods constructor
              importing
                i_def_error_handling type ref to zif_pl_step_error_handling
                i_def_skip_handling type ref to zif_pl_step_skip_handling.

  protected section.

    data _adapted type ref to zcl_pl_step_builder.

    data _save_phase_start type ref to zif_pl_step_execution.

    data _save_phase_builder_fty type ref to object.

    class-data _interaction_phase_start_fty type ref to object.

    class-data _step_builder_f type ref to zcl_pl_step_builder_fty.

endclass.
class zcl_txnl_pl_builder implementation.

  method class_constructor.

    _interaction_phase_start_fty = new interaction_phase_start_fty( ).

    _step_builder_f = new zcl_pl_step_builder_fty( ).

  endmethod.
  method constructor.

    final(interaction_phase_start_fty) = cast interaction_phase_start_fty( _interaction_phase_start_fty ).

    _save_phase_builder_fty = new save_phase_builder_fty( ).

    _save_phase_start = new save_phase_start( ).

    _adapted = _step_builder_f->from( i_def_error_handling = i_def_error_handling
                                      i_def_skip_handling = i_def_skip_handling ).

    _adapted->add( interaction_phase_start_fty->get( ) ).

  endmethod.
  method zif_txnl_pl_intr_ph_builder~add_interaction_phase_step.

    _adapted->add_step( i_step ).

    return me.

  endmethod.
  method zif_txnl_pl_intr_ph_builder~add_to_interaction_phase.

    _adapted->add( i_execution = i_execution
                   i_error_handling_ovrrd = i_error_handling_ovrrd
                   i_skip_handling_ovrrd = i_skip_handling_ovrrd ).

    return me.

  endmethod.
  method zif_txnl_pl_intr_ph_builder~continue.

    final(save_phase_builder_fty) = cast save_phase_builder_fty( _save_phase_builder_fty ).

    _adapted->add( _save_phase_start ).

    return save_phase_builder_fty->from( _adapted ).

  endmethod.

endclass.
