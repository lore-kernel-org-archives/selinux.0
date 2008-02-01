Message-ID: <47A33D20.8080907@manicmethod.com>
Date: Fri, 01 Feb 2008 10:39:12 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, "Todd C. Miller" <tmiller@tresys.com>
Subject: Re: [patch] libsemanage:  free base immediately after expand
References: <1201875066.4568.149.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1201875066.4568.149.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Drop the base module immediately after expanding, so that the memory can
> be reused for the remainder of the transaction.
>
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
>
>   

Acked-By: Joshua Brindle <method@manicmethod.com>

> ---
>
>  libsemanage/src/direct_api.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Index: trunk/libsemanage/src/direct_api.c
> ===================================================================
> --- trunk/libsemanage/src/direct_api.c	(revision 2774)
> +++ trunk/libsemanage/src/direct_api.c	(working copy)
> @@ -642,6 +642,9 @@
>  		retval = semanage_expand_sandbox(sh, base, &out);
>  		if (retval < 0)
>  			goto cleanup;
> +	
> +		sepol_module_package_free(base);
> +		base = NULL;
>  
>  		dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase,
>  				      out);
> @@ -718,7 +721,6 @@
>  	dbase_policydb_detach((dbase_policydb_t *) pbools->dbase);
>  
>  	free(mod_filenames);
> -	sepol_module_package_free(base);
>  	sepol_policydb_free(out);
>  	semanage_release_trans_lock(sh);
>  
>
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
