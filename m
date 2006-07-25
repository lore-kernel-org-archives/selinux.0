Subject: Re: [PATCH 2/2] Refactor expansion of avtab
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <1153839387.19259.18.camel@twoface>
References: <1153839387.19259.18.camel@twoface>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 12:16:26 -0400
Message-Id: <1153844186.12141.34.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-07-25 at 10:56 -0400, Joshua Brindle wrote:

> diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' -x '*.o' -x '*.lo' ../../../trunk/libsepol/include/sepol/policydb/expand.h ./include/sepol/policydb/expand.h
> --- trunk/libsepol/include/sepol/policydb/expand.h	2006-07-13 10:19:14.000000000 -0400
> +++ trunk/libsepol/include/sepol/policydb/expand.h	2006-07-19 13:04:03.000000000 -0400
> @@ -29,6 +29,9 @@
>  #include <sepol/handle.h>
>  #include <sepol/policydb/conditional.h>
>  
> +extern int expand_module_avrules(sepol_handle_t *handle, policydb_t *base,
> +				policydb_t *out, uint32_t *typemap, 
> +				int verbose, int expand_neverallow);

Poorly named function - are neverallows av rules or not? If they are not
the function needs a more generic name. This is continuing the confusing
practice of sometimes calling just allow and audit rules av rules and
sometimes using it to mean more rule types.

This can be in place or out of place (i.e., out can be the same as
base)? A comment describing how this function can be used is needed,
including the fact that the typemap must be "special" for an in-place
expand, correct?

Object classes and permissions will never need to be mapped for an out
of place expansion?

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

The refactoring is nice even without the exported function.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
