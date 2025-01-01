*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

"! Wraps un-mockable behavior
class step_fty definition ##CLASS_FINAL
               create public.

  public section.

    methods for
              importing
                i_execution type ref to zif_pl_step_execution
                i_error_handling type ref to zif_pl_step_error_handling
                i_skip_handling type ref to zif_pl_step_skip_handling
              returning
                value(r_val) type ref to zcl_pl_step.

endclass.

class handling_picker definition ##CLASS_FINAL
                      create public.

  public section.

    methods error_handling
              importing
                i_ovrrd type ref to zif_pl_step_error_handling
                i_def type ref to zif_pl_step_error_handling
              returning
                value(r_val) type ref to zif_pl_step_error_handling.

    methods skip_handling
              importing
                i_ovrrd type ref to zif_pl_step_skip_handling
                i_def type ref to zif_pl_step_skip_handling
              returning
                value(r_val) type ref to zif_pl_step_skip_handling.

endclass.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

class step_fty implementation.

  method for.

    return new zcl_pl_step( i_execution = i_execution
                            i_error_handling = i_error_handling
                            i_skip_handling = i_skip_handling ).

  endmethod.

endclass.
class handling_picker implementation.

  method error_handling.

    return cond #( when i_ovrrd is bound
                   then i_ovrrd
                   else i_def ).

  endmethod.
  method skip_handling.

    return cond #( when i_ovrrd is bound
                   then i_ovrrd
                   else i_def ).

  endmethod.

endclass.
