"! <p class="shorttext synchronized" lang="EN">Transactional Pipeline - Save Phase Builder</p>
interface zif_txnl_pl_save_ph_builder public.

  "! <p class="shorttext synchronized" lang="EN">Adds a step to the Save Phase</p>
  "!
  "! Database modifications are expected
  "!
  "! @parameter i_execution | <p class="shorttext synchronized" lang="EN"></p>
  "! @parameter i_error_handling_ovrrd | <p class="shorttext synchronized" lang="EN"></p>
  "! @parameter i_skip_handling_ovrrd | <p class="shorttext synchronized" lang="EN"></p>
  "! @parameter r_self | <p class="shorttext synchronized" lang="EN">The builder instance for chaining</p>
  methods add_to_save_phase
            importing
              i_execution type ref to zif_pl_step_execution
              i_error_handling_ovrrd type ref to zif_pl_step_error_handling optional
              i_skip_handling_ovrrd type ref to zif_pl_step_skip_handling optional
            returning
              value(r_self) type ref to zif_txnl_pl_save_ph_builder.

  "! <p class="shorttext synchronized" lang="EN">Adds a pre-built step to the Save Phase</p>
  "!
  "! Database modifications are expected
  "!
  "! @parameter i_step | <p class="shorttext synchronized" lang="EN">The execution step to append</p>
  "! @parameter r_self | <p class="shorttext synchronized" lang="EN">The builder instance for chaining</p>
  methods add_save_phase_step
            importing
              i_step type ref to zcl_pl_step
            returning
              value(r_self) type ref to zif_txnl_pl_save_ph_builder.

  "! <p class="shorttext synchronized" lang="EN">Builds and returns the Transactional Pipeline</p>
  "!
  "! @parameter r_pipeline | <p class="shorttext synchronized" lang="EN">The executable pipeline</p>
  methods build
            returning
              value(r_pipeline) type ref to zif_txnl_pl.

endinterface.
