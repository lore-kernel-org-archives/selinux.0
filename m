Message-ID: <44C8D22D.40807@mentalrootkit.com>
Date: Thu, 27 Jul 2006 10:48:13 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH RETRY 3/3] Refactor expansion of avtab
References: <1153937506.5393.7.camel@twoface>
In-Reply-To: <1153937506.5393.7.camel@twoface>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> <snip>
>  
> +static int expand_avrule_decls(expand_state_t * state)
> +{
> +	avrule_block_t *curblock;
> +	int retval = -1;
> +
> +	for (curblock = state->base->global; curblock != NULL;
> +	     curblock = curblock->next) {
> +		avrule_decl_t *decl = curblock->enabled;
> +		avrule_t *cur_avrule;
> +
> +		if (decl == NULL) {
> +			/* nothing was enabled within this block */
> +			continue;
> +		}
> +
> +		/* copy role allows and role trans */
> +		if (copy_role_allows(state, decl->role_allow_rules) != 0 ||
> +		    copy_role_trans(state, decl->role_tr_rules) != 0) {
> +			goto cleanup;
> +		}
> +
> +		/* copy rules */
> +		cur_avrule = decl->avrules;
> +		while (cur_avrule != NULL) {
> +			if (!(state->expand_neverallow)
> +			    && cur_avrule->specified & AVRULE_NEVERALLOW) {
> +				/* copy this over directly so that assertions are checked later */
> +				if (copy_neverallow
> +				    (state->out, state->typemap, cur_avrule))
> +					ERR(state->handle,
> +					    "Error while copying neverallow.");
> +			} else {
>   

My objection to this copying is really based on the function name - it 
is called expand_avrule_decls, but it is really copying or expanding all 
TE rules. Change the name (copy_and_expand_avrule_block?) would make my 
objection go away. I won't even bring up what misleading names 
avrule_decl and avrule_block are and how long this function is.

Karl

> +				if (convert_and_expand_rule
> +				    (state->handle, state->out, state->typemap,
> +				     cur_avrule, &state->out->te_avtab, NULL,
> +				     NULL, 0,
> +				     state->expand_neverallow) !=
> +				    EXPAND_RULE_SUCCESS) {
> +					goto cleanup;
> +				}
> +			}
> +			cur_avrule = cur_avrule->next;
> +		}
> +
> +		/* copy conditional rules */
> +		if (cond_node_copy(state, decl->cond_list))
> +			goto cleanup;
> +	}
> +
> +	retval = 0;
> +
> +      cleanup:
> +	return retval;
> +}
> +
> +int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
> +			  policydb_t * out, uint32_t * typemap, int verbose,
> +			  int expand_neverallow)
> +{
> +	expand_state_t state;
> +
> +	expand_state_init(&state);
> +
> +	state.base = base;
> +	state.out = out;
> +	state.typemap = typemap;
> +	state.handle = handle;
> +	state.verbose = verbose;
> +	state.expand_neverallow = expand_neverallow;
> +
> +	return expand_avrule_decls(&state);
> +}
> +
>  /* Linking should always be done before calling expand, even if
>   * there is only a base since all optionals are dealt with at link time
>   * the base passed in should be indexed and avrule blocks should be 
> @@ -1905,6 +1990,8 @@ int expand_module(sepol_handle_t * handl
>  	expand_state_t state;
>  	avrule_block_t *curblock;
>  
> +	expand_state_init(&state);
> +
>  	state.verbose = verbose;
>  	state.typemap = NULL;
>  	state.base = base;
> @@ -2021,47 +2108,9 @@ int expand_module(sepol_handle_t * handl
>  
>  	}
>  
> -	/* then loop through delcs to copy and expand rules */
> -	for (curblock = state.base->global; curblock != NULL;
> -	     curblock = curblock->next) {
> -		avrule_decl_t *decl = curblock->enabled;
> -		avrule_t *cur_avrule;
> -
> -		if (decl == NULL) {
> -			/* nothing was enabled within this block */
> -			continue;
> -		}
> -
> -		/* copy role allows and role trans */
> -		if (copy_role_allows(&state, decl->role_allow_rules) != 0 ||
> -		    copy_role_trans(&state, decl->role_tr_rules) != 0) {
> -			goto cleanup;
> -		}
> -
> -		/* copy rules */
> -		cur_avrule = decl->avrules;
> -		while (cur_avrule != NULL) {
> -			if (!(state->expand_neverallow)
> -			    && cur_avrule->specified & AVRULE_NEVERALLOW) {
> -				/* copy this over directly so that assertions are checked later */
> -				if (copy_neverallow
> -				    (out, state.typemap, cur_avrule))
> -					ERR(handle,
> -					    "Error while copying neverallow.");
>   

> -			} else {
> -				if (convert_and_expand_rule
> -				    (state.handle, out, state.typemap,
> -				     cur_avrule, &out->te_avtab, NULL, NULL,
> -				     0) != 1) {
> -					goto cleanup;
> -				}
> -			}
> -			cur_avrule = cur_avrule->next;
> -		}
> -
> -		/* copy conditional rules */
> -		if (cond_node_copy(&state, decl->cond_list))
> -			goto cleanup;
> +	if (expand_avrule_decls(&state) < 0) {
> +		ERR(handle, "Error during expand");
> +		goto cleanup;
>  	}
>  
>  	/* copy constraints */
>
>
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
