"! <p class="shorttext synchronized" lang="EN">Transactional Pipeline - Finalizer</p>
interface zif_txnl_pl_finalizer public.

  "! <p class="shorttext synchronized" lang="EN">Persists the transaction</p>
  methods complete.

  "! <p class="shorttext synchronized" lang="EN">Reverts the transaction</p>
  methods abort.

endinterface.
