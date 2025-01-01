"! <p class="shorttext synchronized" lang="EN">Step Context - Continuation Flow</p>
class zcl_pl_step_ctx_cnt_flow definition
                               public
                               create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Returns current value if no arg. supplied. Arg. otherwise</p>
    "!
    "! @parameter i_val | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods continue
              importing
                i_val type xsdboolean optional
              returning
                value(r_val) type xsdboolean.

  protected section.

    data _continue type xsdboolean value abap_true.

endclass.
class zcl_pl_step_ctx_cnt_flow implementation.

  method continue.

    if i_val is supplied.

      _continue = i_val.

    endif.

    return _continue.

  endmethod.

endclass.
