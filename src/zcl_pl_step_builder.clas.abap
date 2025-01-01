"! <p class="shorttext synchronized" lang="EN">Step Builder</p>
class zcl_pl_step_builder definition
                          public
                          create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN"></p>
    types t_error_handling type ref to zif_pl_step_error_handling.

    "! <p class="shorttext synchronized" lang="EN"></p>
    types t_skip_handling type ref to zif_pl_step_skip_handling.

    "! <p class="shorttext synchronized" lang="EN"></p>
    types t_execution type ref to zif_pl_step_execution.

    "! <p class="shorttext synchronized" lang="EN"></p>
    types t_step type ref to zcl_pl_step.

    class-methods class_constructor.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_def_error_handling | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_def_skip_handling | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_def_error_handling type zcl_pl_step_builder=>t_error_handling
                i_def_skip_handling type zcl_pl_step_builder=>t_skip_handling.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_execution | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_error_handling_ovrrd | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_skip_handling_ovrrd | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_self | <p class="shorttext synchronized" lang="EN"></p>
    methods add
              importing
                i_execution type zcl_pl_step_builder=>t_execution
                i_error_handling_ovrrd type zcl_pl_step_builder=>t_error_handling optional
                i_skip_handling_ovrrd type zcl_pl_step_builder=>t_skip_handling optional
              returning
                value(r_self) type ref to zcl_pl_step_builder.

    "! <p class="shorttext synchronized" lang="EN">Adds a pre-built step, splicing it in as-is</p>
    "!
    "! @parameter i_step | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_self | <p class="shorttext synchronized" lang="EN"></p>
    methods add_step
              importing
                i_step type zcl_pl_step_builder=>t_step
              returning
                value(r_self) type ref to zcl_pl_step_builder.

    "! <p class="shorttext synchronized" lang="EN">Returns a pipeline</p>
    "!
    "! It cannot be called twice
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods build
              returning
                value(r_val) type zcl_pl_step_builder=>t_step.

  protected section.

    types t_steps type standard table of zcl_pl_step_builder=>t_step with empty key.

    class-data _step_fty type ref to object.

    class-data _handling_picker type ref to object.

    data _default_error_handling type zcl_pl_step_builder=>t_error_handling.

    data _default_skip_handling type zcl_pl_step_builder=>t_skip_handling.

    data _steps type zcl_pl_step_builder=>t_steps.

endclass.
class zcl_pl_step_builder implementation.

  method class_constructor.

    _step_fty = new step_fty( ).

    _handling_picker = new handling_picker( ).

  endmethod.
  method constructor.

    _default_error_handling = i_def_error_handling.

    _default_skip_handling = i_def_skip_handling.

  endmethod.
  method add_step.

    _steps = value #( base _steps
                      ( i_step ) ).

    return me.

  endmethod.
  method add.

    final(step_fty) = cast step_fty( _step_fty ).

    final(picker) = cast handling_picker( _handling_picker ).

    final(new_step) = step_fty->for( i_error_handling = picker->error_handling( i_ovrrd = i_error_handling_ovrrd
                                                                                i_def = _default_error_handling )
                                     i_skip_handling = picker->skip_handling( i_ovrrd = i_skip_handling_ovrrd
                                                                              i_def = _default_skip_handling )
                                     i_execution = i_execution ).

    return add_step( new_step ).

  endmethod.
  method build.

    final(root) = reduce #( init head = value t_step( _steps[ lines( _steps ) ] optional )
                            for i = lines( _steps ) - 1 then i - 1 while i gt 0
                            next head = _steps[ i ]->next( head ) ).

    _steps = value #( ).

    return root.

  endmethod.

endclass.
