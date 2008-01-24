Subject: Re: [patch 1/1] libsemanage: genhomedircon remove error on missing
	HOME_DIR or HOME_ROOT v2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1201208744.17236.10.camel@olympus.columbia.tresys.com>
References: <1201208744.17236.10.camel@olympus.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 16:22:57 -0500
Message-Id: <1201209777.21288.177.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-24 at 16:05 -0500, Caleb Case wrote:
> Replacing failure condition in write_context_file when HOME_DIR or
> HOME_ROOT are not found in the contexts. This condition is not needed
> (the case where the lists are empty is handled correctly) and stops
> otherwise valid operations:
> 
> On a fresh policy store, without any modules loaded:
> 
> # semodule -s refpolicy -b /usr/share/selinux/refpolicy/base.pp
> libsemanage.semanage_install_sandbox: semanage_genhomedircon returned
> error code -1. No such file or directory.
> semodule:  Failed!
> 
> Failure is replaced with an early success return which happens when
> HOME_DIR, HOME_ROOT, or USER are not found.
> 
> The list of homedirs is computed only if needed (HOME_DIR or HOME_ROOT
> exist).

Ah, I'll queue this one up and revert the prior one after making such it
works.

> 
> ---
>  src/genhomedircon.c |   72 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 38 insertions(+), 34 deletions(-)
> 
> Index: libsemanage/src/genhomedircon.c
> ===================================================================
> --- libsemanage.orig/src/genhomedircon.c
> +++ libsemanage/src/genhomedircon.c
> @@ -779,21 +779,15 @@ static int write_context_file(genhomedir
>  	semanage_list_t *homeroot_context_tpl = NULL;
>  	int retval = STATUS_SUCCESS;
>  
> -	homedirs = get_home_dirs(s);
> -	if (!homedirs) {
> -		WARN(s->h_semanage,
> -		     "no home directories were available, exiting without writing");
> -		return STATUS_ERR;	/* No homedirs so no output */
> -	}
> -
> -	if (write_file_context_header(s, out) != STATUS_SUCCESS)
> -		return STATUS_ERR;
> -
>  	homedir_context_tpl = make_template(s, &HOME_DIR_PRED);
>  	homeroot_context_tpl = make_template(s, &HOME_ROOT_PRED);
>  	user_context_tpl = make_template(s, &USER_CONTEXT_PRED);
> -	if (!homedir_context_tpl || !homeroot_context_tpl) {
> -		retval = STATUS_ERR;
> +
> +	if (!homedir_context_tpl && !homeroot_context_tpl && !user_context_tpl)
> +		goto done;
> +
> +	if (write_file_context_header(s, out) != STATUS_SUCCESS) {
> +		return STATUS_ERR;
>  		goto done;
>  	}
>  
> @@ -801,34 +795,44 @@ static int write_context_file(genhomedir
>  		retval = STATUS_ERR;
>  		goto done;
>  	}
> -	for (h = homedirs; h; h = h->next) {
> -		Ustr *temp = ustr_dup_cstr(h->data);
>  
> -		if (!temp || !ustr_add_cstr(&temp, "/[^/]*")) {
> -			ustr_sc_free(&temp);
> -			retval = STATUS_ERR;
> +	if (homedir_context_tpl || homeroot_context_tpl) {
> +		homedirs = get_home_dirs(s);
> +		if (!homedirs) {
> +			WARN(s->h_semanage,
> +			     "no home directories were available, exiting without writing");
>  			goto done;
>  		}
>  
> -		if (write_home_dir_context(s, out,
> -					   homedir_context_tpl,
> -					   s->fallback_user, s->fallback_user,
> -					   ustr_cstr(temp),
> -					   s->fallback_user_prefix) !=
> -		    STATUS_SUCCESS) {
> -			ustr_sc_free(&temp);
> -			retval = STATUS_ERR;
> -			goto done;
> -		}
> -		if (write_home_root_context(s, out,
> -					    homeroot_context_tpl,
> -					    h->data) != STATUS_SUCCESS) {
> +		for (h = homedirs; h; h = h->next) {
> +			Ustr *temp = ustr_dup_cstr(h->data);
> +
> +			if (!temp || !ustr_add_cstr(&temp, "/[^/]*")) {
> +				ustr_sc_free(&temp);
> +				retval = STATUS_ERR;
> +				goto done;
> +			}
> +
> +			if (write_home_dir_context(s, out,
> +						   homedir_context_tpl,
> +						   s->fallback_user, s->fallback_user,
> +						   ustr_cstr(temp),
> +						   s->fallback_user_prefix) !=
> +			    STATUS_SUCCESS) {
> +				ustr_sc_free(&temp);
> +				retval = STATUS_ERR;
> +				goto done;
> +			}
> +			if (write_home_root_context(s, out,
> +						    homeroot_context_tpl,
> +						    h->data) != STATUS_SUCCESS) {
> +				ustr_sc_free(&temp);
> +				retval = STATUS_ERR;
> +				goto done;
> +			}
> +
>  			ustr_sc_free(&temp);
> -			retval = STATUS_ERR;
> -			goto done;
>  		}
> -
> -		ustr_sc_free(&temp);
>  	}
>  	if (user_context_tpl) {
>  		if (write_user_context(s, out, user_context_tpl,
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
