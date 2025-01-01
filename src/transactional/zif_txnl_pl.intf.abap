"! <p class="shorttext synchronized" lang="EN">Transactional Pipeline</p>
interface zif_txnl_pl public.

  "! <p class="shorttext synchronized" lang="EN">Executes the Transactional Pipeline</p>
  "!
  "! Runs all steps chronologically across both Controlled LUW phases and yields a
  "! terminator to manually terminate the database transaction based on the context
  "! status.
  "!
  "! @parameter i_context | <p class="shorttext synchronized" lang="EN">Palyoad</p>
  "! @parameter r_finalizer | <p class="shorttext synchronized" lang="EN">The transaction terminator</p>
  methods apply
            importing
              i_context type ref to zif_pl_step_context
            returning
              value(r_finalizer) type ref to zif_txnl_pl_finalizer.

endinterface.
