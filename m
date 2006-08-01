Subject: Re: [PATCH 1/2] put neverallows in avtab, propagate errors in
	policydb
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
In-Reply-To: <1154452452.25566.3.camel@twoface.columbia.tresys.com>
References: <1154452452.25566.3.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 14:24:31 -0400
Message-Id: <1154456671.3582.135.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-01 at 13:14 -0400, Joshua Brindle wrote:
> This is a rebase of the patch sent recently to allow neverallow rules to
> be put in the avtab. The suggestions including using
> policydb->unsupported_format and adding defined error codes to policydb
> read and write have been added.

> diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' trunk/libsepol/include/sepol/policydb/policydb.h branch/setools_public-policydb-components/libsepol/include/sepol/policydb/policydb.h
> --- trunk/libsepol/include/sepol/policydb/policydb.h	2006-08-01 09:22:41.000000000 -0400
> +++ trunk/libsepol/include/sepol/policydb/policydb.h	2006-08-01 09:56:18.000000000 -0400
> @@ -65,6 +65,10 @@
>  
>  #define ERRMSG_LEN 1024
>  
> +#define POLICYDB_SUCCESS      0
> +#define POLICYDB_ERROR       -1;
> +#define POLICYDB_UNSUPPORTED -2;

Spurious semicolons.

> diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' trunk/libsepol/src/link.c branch/setools_public-policydb-components/libsepol/src/link.c
> --- trunk/libsepol/src/link.c	2006-08-01 09:22:41.000000000 -0400
> +++ trunk/libsepol/src/link.c	2006-08-01 09:50:25.000000000 -0400
> @@ -964,8 +964,7 @@ static int copy_avrule_list(avrule_t * l
>  			    module->map[SYM_CLASSES][cur_perm->class - 1];
>  			assert(new_perm->class);
>  
> -			if (new_rule->
> -			    specified & (AVRULE_AV | AVRULE_NEVERALLOW)) {
> +			if (new_rule->specified & (AVRULE_AV)) {

Spurious parens.

> diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' trunk/libsepol/src/expand.c branch/setools_public-policydb-components/libsepol/src/expand.c
> --- trunk/libsepol/src/expand.c	2006-07-13 13:57:39.000000000 -0400
> +++ trunk/libsepol/src/expand.c	2006-08-01 11:05:06.000000000 -0400
> @@ -1007,6 +1008,10 @@ static avtab_ptr_t find_avtab_node(sepol
>  	return node;
>  }
>  
> +#define EXPAND_RULE_SUCCESS   0
> +#define EXPAND_RULE_CONFLICT  1
> +#define EXPAND_RULE_ERROR    -1

You are switching the current return values, but not all return
statements and caller tests appear to have been updated, e.g.
expand_rule still returns 1 on a "success" path, and expand_rule_helper
still tests for != 1 as an indication of error.

> @@ -2033,13 +2046,17 @@ int expand_module(sepol_handle_t * handl
>  		/* copy rules */
>  		cur_avrule = decl->avrules;
>  		while (cur_avrule != NULL) {
> -			if (cur_avrule->specified & AVRULE_NEVERALLOW) {
> +			if (!(state->expand_neverallow)

This doesn't compile (next patch happens to eliminate it as part of the
refactoring, but one would like each patch to leave things in a working
state).

> +			    && cur_avrule->specified & AVRULE_NEVERALLOW) {
>  				/* copy this over directly so that assertions are checked later */
>  				if (copy_neverallow
>  				    (out, state.typemap, cur_avrule))
>  					ERR(handle,
>  					    "Error while copying neverallow.");
>  			} else {
> +				if (cur_avrule->specified & AVRULE_NEVERALLOW) {
> +					state->out->unsupported_format = 1;

Ditto.

> +				}
>  				if (convert_and_expand_rule
>  				    (state.handle, out, state.typemap,
>  				     cur_avrule, &out->te_avtab, NULL, NULL,

Ditto.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
