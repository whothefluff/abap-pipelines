*"* use this source file for your ABAP unit test classes

"! Testing {@link .STEP_FTY}
class _step_fty definition
                final
                for testing
                risk level harmless
                duration short.

  private section.

    methods for_returns_instance for testing.

endclass.
class _step_fty implementation.

  method for_returns_instance.

    "arrange
    final(o) = new step_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_bound( o->for( i_execution = value #( )
                                               i_error_handling = value #( )
                                               i_skip_handling = value #( ) ) ).

  endmethod.

endclass.

"! Testing {@link .HANDLING_PICKER}
class _handling_picker definition
                       final
                       for testing
                       risk level harmless
                       duration short.

  private section.

    methods error_handling_rets_default for testing.

    methods error_handling_rets_override for testing.

    methods skip_handling_rets_default for testing.

    methods skip_handling_rets_override for testing.

endclass.
class _handling_picker implementation.

  method error_handling_rets_default.

    "arrange
    final(err) = cast zif_pl_step_error_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) ).

    final(o) = new handling_picker( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = err
                                        act = o->error_handling( i_ovrrd = value #( )
                                                                 i_def = err ) ).

  endmethod.
  method error_handling_rets_override.

    "arrange
    final(err) = cast zif_pl_step_error_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) ).

    final(err_ovrrd) = cast zif_pl_step_error_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) ).

    final(o) = new handling_picker( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = err_ovrrd
                                        act = o->error_handling( i_ovrrd = err_ovrrd
                                                                 i_def = err ) ).

  endmethod.
  method skip_handling_rets_default.

    "arrange
    final(skip) = cast zif_pl_step_skip_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ).

    final(o) = new handling_picker( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = skip
                                        act = o->skip_handling( i_ovrrd = value #( )
                                                                i_def = skip ) ).

  endmethod.
  method skip_handling_rets_override.

    "arrange
    final(skip) = cast zif_pl_step_skip_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ).

    final(skip_ovrrd) = cast zif_pl_step_skip_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ).

    final(o) = new handling_picker( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = skip_ovrrd
                                        act = o->skip_handling( i_ovrrd = skip_ovrrd
                                                                i_def = skip ) ).

  endmethod.

endclass.

class _step_fty_stub definition ##CLASS_FINAL
                     inheriting from step_fty
                     create public
                     for testing.

  public section.

    types: begin of t_args,
             begin of expected,
               execution type ref to zif_pl_step_execution,
               err_hdlg type ref to zif_pl_step_error_handling,
               skip_hdlg type ref to zif_pl_step_skip_handling,
             end of expected,
             canned_answer type ref to zcl_pl_step,
           end of t_args.

    methods constructor
              importing
                i_args type _step_fty_stub=>t_args.

    methods for redefinition.

  protected section.

    data _args type _step_fty_stub=>t_args.

endclass.
class _step_fty_stub implementation.

  method constructor.

    super->constructor( ).

    _args = i_args.

  endmethod.
  method for.

    return cond #( when i_execution eq _args-expected-execution
                        and i_error_handling eq _args-expected-err_hdlg
                        and i_skip_handling eq _args-expected-skip_hdlg
                   then _args-canned_answer ).

  endmethod.

endclass.

class _handling_picker_stub definition ##CLASS_FINAL
                            inheriting from handling_picker
                            create public
                            for testing.

  public section.

    types: begin of t_args,
             begin of error_handling,
               begin of expected,
                 ovrrd type ref to zif_pl_step_error_handling,
                 def type ref to zif_pl_step_error_handling,
               end of expected,
               canned_answer type ref to zif_pl_step_error_handling,
             end of error_handling,
             begin of skip_handling,
               begin of expected,
                 ovrrd type ref to zif_pl_step_skip_handling,
                 def type ref to zif_pl_step_skip_handling,
               end of expected,
               canned_answer type ref to zif_pl_step_skip_handling,
             end of skip_handling,
           end of t_args.

    methods constructor
              importing
                i_args type _handling_picker_stub=>t_args.

    methods error_handling redefinition.

    methods skip_handling redefinition.

  protected section.

    data _args type _handling_picker_stub=>t_args.

endclass.
class _handling_picker_stub implementation.

  method constructor.

    super->constructor( ).

    _args = i_args.

  endmethod.
  method error_handling.

    return cond #( when i_ovrrd eq _args-error_handling-expected-ovrrd
                        and i_def eq _args-error_handling-expected-def
                   then _args-error_handling-canned_answer ).

  endmethod.
  method skip_handling.

    return cond #( when i_ovrrd eq _args-skip_handling-expected-ovrrd
                        and i_def eq _args-skip_handling-expected-def
                   then _args-skip_handling-canned_answer ).

  endmethod.

endclass.

class _pl_step_next_spy definition ##CLASS_FINAL
                        inheriting from zcl_pl_step
                        create public
                        for testing.

  public section.

    methods constructor.

    methods next redefinition.

    data last_arg type ref to zcl_pl_step read-only.

endclass.
class _pl_step_next_spy implementation.

  method constructor.

    super->constructor( i_execution = value #( )
                        i_error_handling = value #( )
                        i_skip_handling = value #( ) ).

  endmethod.
  method next.

    last_arg = i_step.

    return me.

  endmethod.

endclass.

class _step_builder_add_spy_stub definition ##CLASS_FINAL
                                 inheriting from zcl_pl_step_builder
                                 create public
                                 for testing.

  public section.

    types: begin of t_args,
             begin of defaults,
               error_handling type zcl_pl_step_builder=>t_error_handling,
               skip_handling type zcl_pl_step_builder=>t_skip_handling,
             end of defaults,
             begin of add_step,
               canned_answer type ref to zcl_pl_step_builder,
             end of add_step,
           end of t_args.

    methods constructor
              importing
                i_args type _step_builder_add_spy_stub=>t_args.

    methods add_step redefinition.

    data last_arg type zcl_pl_step_builder=>t_step read-only.

  protected section.

    data _args type _step_builder_add_spy_stub=>t_args.

endclass.
class _step_builder_add_spy_stub implementation.

  method constructor.

    super->constructor( i_def_error_handling = value #( )
                        i_def_skip_handling = value #( ) ).

    _default_error_handling = i_args-defaults-error_handling.

    _default_skip_handling = i_args-defaults-skip_handling.

    _args = i_args.

  endmethod.
  method add_step.

    last_arg = i_step.

    return _args-add_step-canned_answer.

  endmethod.

endclass.

class _ definition deferred.

class zcl_pl_step_builder definition local friends _.

"! <p class="shorttext synchronized" lang="EN">Tests</p>
class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    class-methods class_setup.

    methods setup.

    methods class_constructor_sets_attr for testing.

    methods constructor_sets_attr for testing.

    methods add_delegates_to_add_step for testing.

    methods add_step_appends for testing.

    methods add_step_is_chainable for testing.

    methods build_links_steps for testing.

    methods build_returns_first for testing.

    methods build_rets_nothing_when_empty for testing.

    methods build_clears_steps for testing.

    class-methods class_teardown.

    class-data _step_fty_backup type ref to step_fty.

    class-data _handling_picker_backup type ref to handling_picker.

endclass.
class _ implementation.

  method class_setup.

    _step_fty_backup = cast #( zcl_pl_step_builder=>_step_fty ).

    _handling_picker_backup = cast #( zcl_pl_step_builder=>_handling_picker ).

  endmethod.
  method setup.

    zcl_pl_step_builder=>_step_fty = _step_fty_backup.

    zcl_pl_step_builder=>_handling_picker = _handling_picker_backup.

  endmethod.
  method class_constructor_sets_attr.

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( zcl_pl_step_builder=>_step_fty is bound
                                               and zcl_pl_step_builder=>_handling_picker is bound ) ).

  endmethod.
  method constructor_sets_attr.

    "arrange
    final(err) = cast zif_pl_step_error_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) ).

    final(skip) = cast zif_pl_step_skip_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ).

    "act
    final(o) = new zcl_pl_step_builder( i_def_error_handling = err
                                        i_def_skip_handling = skip ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->_default_error_handling eq err
                                               and o->_default_skip_handling eq skip ) ).

  endmethod.
  method add_delegates_to_add_step.

    "arrange
    final(some_exe_sty) = cast zif_pl_step_execution( cl_abap_testdouble=>create( 'ZIF_PL_STEP_EXECUTION' ) ).

    final(some_err_ovrrd) = cast zif_pl_step_error_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) ).

    final(some_skip_ovrrd) = cast zif_pl_step_skip_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ).

    final(some_err_def) = cast zif_pl_step_error_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) ).

    final(some_skip_def) = cast zif_pl_step_skip_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ).

    final(some_err_sty) = cast zif_pl_step_error_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_ERROR_HANDLING' ) ).

    final(some_skip_sty) = cast zif_pl_step_skip_handling( cl_abap_testdouble=>create( 'ZIF_PL_STEP_SKIP_HANDLING' ) ).

    final(some_step) = new zcl_pl_step( i_execution = value #( )
                                        i_error_handling = value #( )
                                        i_skip_handling = value #( ) ).

    final(some_canned_answer) = new zcl_pl_step_builder( i_def_error_handling = value #( )
                                                         i_def_skip_handling = value #( ) ).

    final(o) = new _step_builder_add_spy_stub( value #( defaults = value #( error_handling = some_err_def
                                                                            skip_handling = some_skip_def )
                                                        add_step = value #( canned_answer = some_canned_answer ) ) ).

    zcl_pl_step_builder=>_handling_picker = new _handling_picker_stub( value #( error_handling = value #( expected = value #( ovrrd = some_err_ovrrd
                                                                                                                              def = some_err_def )
                                                                                                          canned_answer = some_err_sty )
                                                                                skip_handling = value #( expected = value #( ovrrd = some_skip_ovrrd
                                                                                                                             def = some_skip_def )
                                                                                                         canned_answer = some_skip_sty ) ) ).

    zcl_pl_step_builder=>_step_fty = new _step_fty_stub( value #( expected = value #( execution = some_exe_sty
                                                                                      err_hdlg = some_err_sty
                                                                                      skip_hdlg = some_skip_sty )
                                                                  canned_answer = some_step ) ).

    "act
    final(result) = o->add( i_execution = some_exe_sty
                            i_error_handling_ovrrd = some_err_ovrrd
                            i_skip_handling_ovrrd = some_skip_ovrrd ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->last_arg eq some_step
                                               and result eq some_canned_answer ) ).

  endmethod.
  method add_step_appends.

    "arrange
    final(o) = new zcl_pl_step_builder( i_def_error_handling = value #( )
                                        i_def_skip_handling = value #( ) ).

    final(some_previous_step) = new zcl_pl_step( i_execution = value #( )
                                                 i_error_handling = value #( )
                                                 i_skip_handling = value #( ) ).

    final(some_new_step) = new zcl_pl_step( i_execution = value #( )
                                            i_error_handling = value #( )
                                            i_skip_handling = value #( ) ).

    o->_steps = value #( ( some_previous_step ) ).

    "act
    o->add_step( some_new_step ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = value zcl_pl_step_builder=>t_steps( ( some_previous_step )
                                                                                  ( some_new_step ) )
                                        act = o->_steps ).

  endmethod.
  method add_step_is_chainable.

    "arrange
    final(o) = new zcl_pl_step_builder( i_def_error_handling = value #( )
                                        i_def_skip_handling = value #( ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = o
                                        act = o->add_step( value #( ) ) ).

  endmethod.
  method build_links_steps.

    "arrange
    final(o) = new zcl_pl_step_builder( i_def_error_handling = value #( )
                                        i_def_skip_handling = value #( ) ).

    final(some_first_step) = new _pl_step_next_spy( ).

    final(some_second_step) = new _pl_step_next_spy( ).

    final(some_third_step) = new _pl_step_next_spy( ).

    o->_steps = value #( ( some_first_step )
                         ( some_second_step )
                         ( some_third_step ) ).

    "act
    o->build( ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( some_first_step->last_arg eq some_second_step
                                               and some_second_step->last_arg eq some_third_step
                                               and some_third_step->last_arg is not bound ) ).

  endmethod.
  method build_returns_first.

    "arrange
    final(o) = new zcl_pl_step_builder( i_def_error_handling = value #( )
                                        i_def_skip_handling = value #( ) ).

    final(some_first_step) = new _pl_step_next_spy( ).

    final(some_second_step) = new _pl_step_next_spy( ).

    o->_steps = value #( ( some_first_step )
                         ( some_second_step ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_first_step
                                        act = o->build( ) ).

  endmethod.
  method build_rets_nothing_when_empty.

    "arrange
    final(o) = new zcl_pl_step_builder( i_def_error_handling = value #( )
                                        i_def_skip_handling = value #( ) ).

    "act & assert
    cl_abap_unit_assert=>assert_not_bound( o->build( ) ).

  endmethod.
  method build_clears_steps.

    "arrange
    final(o) = new zcl_pl_step_builder( i_def_error_handling = value #( )
                                        i_def_skip_handling = value #( ) ).

    final(some_step) = new zcl_pl_step( i_execution = value #( )
                                        i_error_handling = value #( )
                                        i_skip_handling = value #( ) ).

    o->_steps = value #( ( some_step ) ).

    "act
    o->build( ).

    "assert
    cl_abap_unit_assert=>assert_initial( o->_steps ).

  endmethod.
  method class_teardown.

    zcl_pl_step_builder=>_step_fty = _step_fty_backup.

    zcl_pl_step_builder=>_handling_picker = _handling_picker_backup.

  endmethod.

endclass.
