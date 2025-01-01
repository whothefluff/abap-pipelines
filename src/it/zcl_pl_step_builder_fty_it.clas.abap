"! <p class="shorttext synchronized" lang="EN">Step Builder Factory - Integration tests</p>
"!
"! @testing ZCL_PL_STEP_BUILDER_FTY
class zcl_pl_step_builder_fty_it definition
                                 public
                                 create private
                                 for testing
                                 risk level harmless
                                 duration short.

  public section.

    methods from_rets_inst for testing.

  protected section.

endclass.
class zcl_pl_step_builder_fty_it implementation.

  method from_rets_inst.

    "arrange
    final(o) = new zcl_pl_step_builder_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_bound( o->from( i_def_error_handling = value #( )
                                                i_def_skip_handling = value #( ) ) ).

  endmethod.

endclass.
