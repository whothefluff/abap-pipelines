"! <p class="shorttext synchronized" lang="EN">Step Error Handling</p>
interface zif_pl_step_error_handling public.

  "! <p class="shorttext synchronized" lang="EN"></p>
  "!
  "! @parameter i_context | <p class="shorttext synchronized" lang="EN"></p>
  "! @parameter i_exc | <p class="shorttext synchronized" lang="EN"></p>
  methods run
            importing
              i_context type ref to zif_pl_step_context
              i_exc type ref to zcx_static_check_aggr.

endinterface.
