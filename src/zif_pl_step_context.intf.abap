"! <p class="shorttext synchronized" lang="EN">Step Context</p>
interface zif_pl_step_context public.

  "! <p class="shorttext synchronized" lang="EN"></p>
  "!
  "! @parameter i_val | <p class="shorttext synchronized" lang="EN"></p>
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
  methods continue
            importing
              i_val type xsdboolean optional
            returning
              value(r_val) type xsdboolean.

  "! <p class="shorttext synchronized" lang="EN">Returns all errors occurred so far</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
  methods errors
            returning
              value(r_val) type ref to zcx_static_check_aggr.

  "! <p class="shorttext synchronized" lang="EN">Returns all messages so far</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
  methods messages
            returning
              value(r_val) type ref to zcl_message_aggr.

endinterface.
