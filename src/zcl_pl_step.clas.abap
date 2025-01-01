"! <p class="shorttext synchronized" lang="EN">Step</p>
class zcl_pl_step definition
                  public
                  create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN"></p>
    types t_execution type ref to zif_pl_step_execution.

    "! <p class="shorttext synchronized" lang="EN"></p>
    types t_error_handling type ref to zif_pl_step_error_handling.

    "! <p class="shorttext synchronized" lang="EN"></p>
    types t_skip_handling type ref to zif_pl_step_skip_handling.

    "! <p class="shorttext synchronized" lang="EN">Creates a new step</p>
    "!
    "! @parameter i_execution | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_error_handling | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_skip_handling | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_execution type zcl_pl_step=>t_execution
                i_error_handling type zcl_pl_step=>t_error_handling
                i_skip_handling type zcl_pl_step=>t_skip_handling.

    "! <p class="shorttext synchronized" lang="EN">Adds a new step after this one</p>
    "!
    "! @parameter i_step | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_self | <p class="shorttext synchronized" lang="EN"></p>
    methods next
              importing
                i_step type ref to zcl_pl_step
              returning
                value(r_self) type ref to zcl_pl_step.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_context | <p class="shorttext synchronized" lang="EN"></p>
    methods start
              importing
                i_context type ref to zif_pl_step_context.

  protected section.

    data _next type ref to zcl_pl_step.

    data _execution type zcl_pl_step=>t_execution.

    data _error_handling type zcl_pl_step=>t_error_handling.

    data _skip_handling type zcl_pl_step=>t_skip_handling.

endclass.
class zcl_pl_step implementation.

  method constructor.

    _execution = i_execution.

    _error_handling = i_error_handling.

    _skip_handling = i_skip_handling.

  endmethod.
  method next.

    _next = i_step.

    return me.

  endmethod.
  method start.

    if i_context->continue( ).

      try.

        _execution->run( i_context ).

        if _next is bound.

          _next->start( i_context ).

        endif.

      catch zcx_static_check_aggr into final(e).

        _error_handling->run( i_context = i_context
                              i_exc = e ).

      endtry.

    else.

      _skip_handling->run( i_context ).

    endif.

  endmethod.

endclass.
