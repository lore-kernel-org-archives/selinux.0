Subject: Re: [PATCH 1/2] put neverallows in avtab, propagate errors in
	policydb
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <1154452452.25566.3.camel@twoface.columbia.tresys.com>
References: <1154452452.25566.3.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 11:48:00 -0400
Message-Id: <1154965681.6799.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-01 at 13:14 -0400, Joshua Brindle wrote:
> This is a rebase of the patch sent recently to allow neverallow rules to
> be put in the avtab. The suggestions including using
> policydb->unsupported_format and adding defined error codes to policydb
> read and write have been added.
> 

Almost everything looks good to me except:

> @@ -2033,13 +2046,17 @@ int expand_module(sepol_handle_t * handl
>  		/* copy rules */
>  		cur_avrule = decl->avrules;
>  		while (cur_avrule != NULL) {
> -			if (cur_avrule->specified & AVRULE_NEVERALLOW) {
> +			if (!(state->expand_neverallow)
> +			    && cur_avrule->specified & AVRULE_NEVERALLOW) {
>  				/* copy this over directly so that assertions are checked later */
>  				if (copy_neverallow
>  				    (out, state.typemap, cur_avrule))
>  					ERR(handle,
>  					    "Error while copying neverallow.");
>  			} else {
> +				if (cur_avrule->specified & AVRULE_NEVERALLOW) {
> +					state->out->unsupported_format = 1;
> +				}
>  				if (convert_and_expand_rule
>  				    (state.handle, out, state.typemap,

As I mentioned before, isn't it possible that you would want the
expanded and unexpanded neverallow rules? This is a surprising side
effect - it at least needs documentation.

>  				     cur_avrule, &out->te_avtab, NULL, NULL,
> @@ -2098,7 +2115,7 @@ int expand_module(sepol_handle_t * handl
>  		goto cleanup;
>  	hashtab_map_remove_on_error(state.out->p_types.table,
>  				    type_attr_remove, type_destroy, state.out);
> -	if (check) {
> +	if (check && !(out->unsupported_format)) {
>  		if (hierarchy_check_constraints(handle, state.out))
>  			goto cleanup;
>  
> 

I thought that this was going to be removed so that the check would
happen if requested. You said:


> 
> I guess I can see this, I doubt that someone who requests an 
> unsupported_format would also request checking so the explicit check
> is 
> not necessary.
> 

Did I parse this incorrectly?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
