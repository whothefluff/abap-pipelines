*"* use this source file for your ABAP unit test classes

class _ definition deferred.

class zcl_pl_step_ctx_cnt_flow definition local friends _.

"! <p class="shorttext synchronized" lang="EN">Tests</p>
class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    methods constructor_sets_attr for testing.

    methods continue_sets_attr for testing.

    methods continue_rets_attr for testing.

endclass.
class _ implementation.

  method constructor_sets_attr.

    "act
    final(o) = new zcl_pl_step_ctx_cnt_flow( ).

    "assert
    cl_abap_unit_assert=>assert_true( o->_continue ).

  endmethod.
  method continue_sets_attr.

    "arrange
    final(o) = new zcl_pl_step_ctx_cnt_flow( ).

    final(some_val) = 'Z'.

    "act
    o->continue( some_val ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_val
                                        act = o->continue( ) ).

  endmethod.
  method continue_rets_attr.

    "arrange
    final(o) = new zcl_pl_step_ctx_cnt_flow( ).

    final(some_val) = 'Z'.

    o->_continue = some_val.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_val
                                        act = o->continue( ) ).

  endmethod.

endclass.
