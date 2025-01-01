"! <p class="shorttext synchronized" lang="EN">Step Builder Factory</p>
"!
"! Wraps un-mockable behavior
class zcl_pl_step_builder_fty definition
                              public
                              create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_def_error_handling | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_def_skip_handling | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods from
              importing
                i_def_error_handling type zcl_pl_step_builder=>t_error_handling
                i_def_skip_handling type zcl_pl_step_builder=>t_skip_handling
              returning
                value(r_val) type ref to zcl_pl_step_builder.

  protected section.

endclass.
class zcl_pl_step_builder_fty implementation.

  method from.

    return new zcl_pl_step_builder( i_def_error_handling = i_def_error_handling
                                    i_def_skip_handling = i_def_skip_handling ).

  endmethod.

endclass.
