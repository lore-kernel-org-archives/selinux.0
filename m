Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7T8Oi7S031389
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 04:24:44 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7T8OhFQ015937
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 08:24:43 GMT
Message-ID: <4E5B4CC7.2040400@windriver.com>
Date: Mon, 29 Aug 2011 16:24:39 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: <cpebenito@tresys.com>, <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 5/7] Permanently discard disabled branches of tunables
 in expansion.
References: <1314604432-12156-2-git-send-email-qingtao.cao@windriver.com> <1314604432-12156-5-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314604432-12156-5-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please ignore this patch, I would re-send it with 0/7 patch for extra 
comments for the v1 patchset.

Sorry for any inconvenience!

Thanks,
Harry

On 08/29/2011 03:53 PM, Harry Ciao wrote:
> For a cond_node_t in one decl->cond_list queue, append its
> avtrue_list or avfalse_list to the avrules list of its home decl
> depending on its state value, so that these effective rules would
> be permanently added to te_avtab hashtab.
>
> On the other hand, the rules on the disabled unused list won't be
> expanded and written to the raw policy at all.
>
> Signed-off-by: Harry Ciao<qingtao.cao@windriver.com>
> ---
>   libsepol/src/expand.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 98 insertions(+), 0 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 06f11f4..be41243 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2665,6 +2665,94 @@ int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
>   	return copy_and_expand_avrule_block(&state);
>   }
>
> +static void discard_tunables(policydb_t *pol)
> +{
> +	avrule_block_t *block;
> +	avrule_decl_t *decl;
> +	cond_node_t *cur_node;
> +	cond_expr_t *cur_expr;
> +	int cur_state;
> +	avrule_t *tail, *to_be_appended;
> +
> +	/* Iterate through all cond_node of all enabled decls, if a cond_node
> +	 * is about tunable, caculate its state value and concatenate one of
> +	 * its avrule list to the current decl->avrules list.
> +	 *
> +	 * Note, such tunable cond_node would be skipped over in expansion,
> +	 * so we won't have to worry about removing it from decl->cond_list
> +	 * here :-)
> +	 *
> +	 * If tunables and booleans co-exist in the expression of a cond_node,
> +	 * then tunables would be "transformed" as booleans.
> +	 */
> +	for (block = pol->global; block != NULL; block = block->next) {
> +		decl = block->enabled;
> +		if (decl == NULL || decl->enabled == 0)
> +			continue;
> +
> +		tail = decl->avrules;
> +		while (tail&&  tail->next)
> +			tail = tail->next;
> +
> +		for (cur_node = decl->cond_list; cur_node != NULL;
> +		     cur_node = cur_node->next) {
> +			int booleans, tunables;
> +			cond_bool_datum_t *booldatum;
> +
> +			booleans = tunables = 0;
> +
> +			for (cur_expr = cur_node->expr; cur_expr != NULL;
> +			     cur_expr = cur_expr->next) {
> +				if (cur_expr->expr_type != COND_BOOL)
> +					continue;
> +				booldatum = pol->bool_val_to_struct[cur_expr->bool - 1];
> +				if (booldatum->flags&  COND_BOOL_FLAGS_TUNABLE)
> +					tunables++;
> +				else
> +					booleans++;
> +			}
> +
> +			/* bool_copy_callback() at link phase has ensured
> +			 * that no mixture of tunables and booleans in one
> +			 * expression. */
> +			assert(!(booleans&&  tunables));
> +
> +			if (booleans) {
> +				cur_node->flags&= ~COND_NODE_FLAGS_TUNABLE;
> +			} else {
> +				cur_node->flags |= COND_NODE_FLAGS_TUNABLE;
> +				cur_state = cond_evaluate_expr(pol, cur_node->expr);
> +				if (cur_state == -1) {
> +					printf("Expression result was "
> +					       "undefined, skipping all"
> +					       "rules\n");
> +					continue;
> +				}
> +
> +				to_be_appended = (cur_state == 1) ?
> +					cur_node->avtrue_list : cur_node->avfalse_list;
> +
> +				if (tail)
> +					tail->next = to_be_appended;
> +				else
> +					tail = decl->avrules = to_be_appended;
> +
> +				/* Now that the effective branch has been
> +				 * appended, neutralize its original pointer */
> +				if (cur_state == 1)
> +					cur_node->avtrue_list = NULL;
> +				else
> +					cur_node->avfalse_list = NULL;
> +
> +				/* Update the tail of decl->avrules for
> +				 * further concatenation */
> +				while (tail&&  tail->next)
> +					tail = tail->next;
> +			}
> +		}
> +	}
> +}
> +
>   /* Linking should always be done before calling expand, even if
>    * there is only a base since all optionals are dealt with at link time
>    * the base passed in should be indexed and avrule blocks should be
> @@ -2678,6 +2766,16 @@ int expand_module(sepol_handle_t * handle,
>   	expand_state_t state;
>   	avrule_block_t *curblock;
>
> +	/* Append tunable's avtrue_list or avfalse_list to the avrules list
> +	 * of its home decl depending on its state value, so that the effect
> +	 * rules of a tunable would be added to te_avtab permanently. Whereas
> +	 * the disabled unused branch would be discarded.
> +	 *
> +	 * Originally this function is called at the very end of link phase,
> +	 * however, we need to keep the linked policy intact for analysis
> +	 * purpose. */
> +	discard_tunables(base);
> +
>   	expand_state_init(&state);
>
>   	state.verbose = verbose;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
