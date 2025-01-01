*"* use this source file for your ABAP unit test classes

class _step_spy definition ##CLASS_FINAL
                inheriting from zcl_pl_step
                create public
                for testing.

  public section.

    methods constructor.

    methods start redefinition.

    data times_called type i.

endclass.
class _step_spy implementation.

  method constructor.

    super->constructor( i_execution = value #( )
                        i_error_handling = value #( )
                        i_skip_handling = value #( ) ).

  endmethod.
  method start.

    times_called += 1.

  endmethod.

endclass.

class _ definition deferred.

class zcl_pl_step definition local friends _.

"! <p class="shorttext synchronized" lang="EN">Tests</p>
class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    methods constructor_sets_attr for testing.

    methods next_sets_attr for testing.

    methods next_is_chainable for testing.

    methods start_delegates_to_execution for testing
              raising
                zcx_static_check_aggr.

    methods start_delegates_to_skip_hdlg for testing.

    methods start_delegates_to_error_hdlg for testing
              raising
                zcx_static_check_aggr.

    methods start_calls_next_run_if_bound for testing.

    methods start_stops_if_next_not_bound for testing.

endclass.
class _ implementation.

  method constructor_sets_attr.

    "arrange
    final(execution) = cast zif_pl_step_execution( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) ).

    final(error_handling) = cast zif_pl_step_error_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) ).

    final(skip_handling) = cast zif_pl_step_skip_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ).

    "act
    final(o) = new zcl_pl_step( i_execution = execution
                                i_error_handling = error_handling
                                i_skip_handling = skip_handling ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->_execution eq execution
                                               and o->_error_handling eq error_handling
                                               and o->_skip_handling eq skip_handling ) ).

  endmethod.
  method next_sets_attr.

    "arrange
    final(o) = new zcl_pl_step( i_execution = cast #( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) )
                                i_error_handling = cast #( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) )
                                i_skip_handling = cast #( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ) ).

    final(some_step) = new zcl_pl_step( i_execution = cast #( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) )
                                        i_error_handling = cast #( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) )
                                        i_skip_handling = cast #( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ) ).

    "act
    o->next( some_step ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_step
                                        act = o->_next ).

  endmethod.
  method next_is_chainable.

    "arrange
    final(o) = new zcl_pl_step( i_execution = cast #( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) )
                                i_error_handling = cast #( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) )
                                i_skip_handling = cast #( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = o
                                        act = o->next( value #( ) ) ).

  endmethod.
  method start_delegates_to_execution.

    "arrange
    final(exec) = cast zif_pl_step_execution( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) ).

    final(o) = new zcl_pl_step( i_execution = value #( )
                                i_error_handling = value #( )
                                i_skip_handling = value #( ) ).

    final(ctx) = cast zif_pl_step_context( cl_abap_testdouble=>create( 'ZIF_PL_STEP_CONTEXT' ) ).

    cl_abap_testdouble=>configure_call( ctx )->returning( abap_true ).

    ctx->continue( ).

    cl_abap_testdouble=>configure_call( exec )->and_expect( )->is_called_once( ).

    exec->run( ctx ).

    o->_execution = exec.

    "act
    o->start( ctx ).

    "assert
    cl_abap_testdouble=>verify_expectations( exec ).

  endmethod.
  method start_delegates_to_skip_hdlg.

    "arrange
    final(skip) = cast zif_pl_step_skip_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ).

    final(o) = new zcl_pl_step( i_execution = value #( )
                                i_error_handling = value #( )
                                i_skip_handling = value #( ) ).

    final(ctx) = cast zif_pl_step_context( cl_abap_testdouble=>create( 'ZIF_PL_STEP_CONTEXT' ) ).

    cl_abap_testdouble=>configure_call( ctx )->returning( abap_false ).

    ctx->continue( ).

    cl_abap_testdouble=>configure_call( skip )->and_expect( )->is_called_once( ).

    skip->run( ctx ).

    o->_skip_handling = skip.

    "act
    o->start( ctx ).

    "assert
    cl_abap_testdouble=>verify_expectations( skip ).

  endmethod.
  method start_delegates_to_error_hdlg.

    "arrange
    final(exec) = cast zif_pl_step_execution( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) ).

    final(err) = cast zif_pl_step_error_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) ).

    final(o) = new zcl_pl_step( i_execution = value #( )
                                i_error_handling = value #( )
                                i_skip_handling = value #( ) ).

    final(ctx) = cast zif_pl_step_context( cl_abap_testdouble=>create( 'ZIF_PL_STEP_CONTEXT' ) ).

    final(e) = new zcx_static_check_aggr( value #( ) ).

    cl_abap_testdouble=>configure_call( ctx )->returning( abap_true ).

    ctx->continue( ).

    cl_abap_testdouble=>configure_call( exec )->raise_exception( e ).

    exec->run( ctx ).

    cl_abap_testdouble=>configure_call( err )->and_expect( )->is_called_once( ).

    err->run( i_context = ctx
              i_exc = e ).

    o->_execution = exec.

    o->_error_handling = err.

    "act
    o->start( ctx ).

    "assert
    cl_abap_testdouble=>verify_expectations( err ).

  endmethod.
  method start_calls_next_run_if_bound.

    "arrange
    final(o) = new zcl_pl_step( i_execution = value #( )
                                i_error_handling = value #( )
                                i_skip_handling = value #( ) ).

    final(next) = new _step_spy( ).

    final(ctx) = cast zif_pl_step_context( cl_abap_testdouble=>create( 'ZIF_PL_STEP_CONTEXT' ) ).

    cl_abap_testdouble=>configure_call( ctx )->returning( abap_true ).

    ctx->continue( ).

    o->_execution = cast #( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) ).

    o->_next = next.

    "act
    o->start( ctx ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 1
                                        act = next->times_called ).

  endmethod.
  method start_stops_if_next_not_bound.

    "arrange
    final(o) = new zcl_pl_step( i_execution = value #( )
                                i_error_handling = value #( )
                                i_skip_handling = value #( ) ).

    final(ctx) = cast zif_pl_step_context( cl_abap_testdouble=>create( 'ZIF_PL_STEP_CONTEXT' ) ).

    cl_abap_testdouble=>configure_call( ctx )->returning( abap_true ).

    ctx->continue( ).

    o->_execution = cast #( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) ).

    "act
    o->start( ctx ).

    "assert
    "no CX_SY_REF_IS_INITIAL is assertion enough

  endmethod.

endclass.
