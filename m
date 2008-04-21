Message-ID: <480CA12C.1090403@tresys.com>
Date: Mon, 21 Apr 2008 10:14:04 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [patch] libsemanage:  don't call genhomedircon if policy was
 not	rebuilt
References: <1208785275.15796.45.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1208785275.15796.45.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> See:
> https://bugzilla.redhat.com/show_bug.cgi?id=441379
> 
> It appears to me that what is happening here is we have a case where
> nothing is being rebuilt (semanage boolean -D is being applied but there
> are no local boolean definitions and thus no change), and thus
> semanage_direct_commit() does not rebuild the policy (conditional on
> sh->do_rebuild || modified), leaving the out policydb == NULL.  Then
> when it calls semanage_genhomedircon(sh, out, 1) the NULL policydb
> pointer ultimately gets passed down to libsepol and that then triggers a
> seg fault upon the attempted dereference.
> 
> This patch ensures that we do not call genhomedircon if the policy was
> not rebuilt, as there is no need to regenerate home directory contexts
> in that situation.  This avoids the bug for semanage boolean -D while
> still properly handling semodule -Bn aka genhomedircon or other
> operations.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Acked-By: Joshua Brindle <method@manicmethod.com>

> 
> ---
> 
>  libsemanage/src/direct_api.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: trunk/libsemanage/src/direct_api.c
> ===================================================================
> --- trunk/libsemanage/src/direct_api.c	(revision 2860)
> +++ trunk/libsemanage/src/direct_api.c	(working copy)
> @@ -708,7 +708,7 @@
>  	/* run genhomedircon if its enabled, this should be the last operation
>  	 * which requires the out policydb */
>  	if (!sh->conf->disable_genhomedircon) {
> -		if ((retval =
> +		if (out && (retval =
>  		     semanage_genhomedircon(sh, out, 1)) != 0) {
>  			ERR(sh, "semanage_genhomedircon returned error code %d.",
>  			    retval);
> 
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
