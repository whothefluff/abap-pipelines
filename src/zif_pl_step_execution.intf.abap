"! <p class="shorttext synchronized" lang="EN">Step Execution</p>
interface zif_pl_step_execution public.

  "! <p class="shorttext synchronized" lang="EN"></p>
  "!
  "! @parameter i_context | <p class="shorttext synchronized" lang="EN"></p>
  "! @raising zcx_static_check_aggr | <p class="shorttext synchronized" lang="EN"></p>
  methods run
            importing
              i_context type ref to zif_pl_step_context
            raising
              zcx_static_check_aggr.

endinterface.
