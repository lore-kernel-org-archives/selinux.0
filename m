Subject: Re: [PATCH] libsepol: sepol_check_context correct error handling
	behavior
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4676CB4A.80203@tycho.nsa.gov>
References: <4676CB4A.80203@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 20 Jun 2007 11:16:32 -0400
Message-Id: <1182352592.15064.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-18 at 14:13 -0400, Eamon Walsh wrote:
> Returns EINVAL, EEXIST as appropriate.  Also fixed man page.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
> 
>  man/man3/sepol_check_context.3 |    2 +-
>  src/context.c                  |    1 +
>  src/context_record.c           |    2 ++
>  src/sidtab.c                   |    4 +++-
>  4 files changed, 7 insertions(+), 2 deletions(-)

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

> 
> 
> Index: libsepol/src/sidtab.c
> ===================================================================
> --- libsepol/src/sidtab.c	(revision 2474)
> +++ libsepol/src/sidtab.c	(working copy)
> @@ -56,8 +56,10 @@
>  		cur = cur->next;
>  	}
>  
> -	if (cur && sid == cur->sid)
> +	if (cur && sid == cur->sid) {
> +		errno = EEXIST;
>  		return -EEXIST;
> +	}
>  
>  	newnode = (sidtab_node_t *) malloc(sizeof(sidtab_node_t));
>  	if (newnode == NULL)
> Index: libsepol/src/context_record.c
> ===================================================================
> --- libsepol/src/context_record.c	(revision 2474)
> +++ libsepol/src/context_record.c	(working copy)
> @@ -1,3 +1,4 @@
> +#include <errno.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <stdio.h>
> @@ -260,6 +261,7 @@
>  	return STATUS_SUCCESS;
>  
>        mcontext:
> +	errno = EINVAL;
>  	ERR(handle, "malformed context \"%s\"", str);
>  
>        err:
> Index: libsepol/src/context.c
> ===================================================================
> --- libsepol/src/context.c	(revision 2474)
> +++ libsepol/src/context.c	(working copy)
> @@ -224,6 +224,7 @@
>  	return STATUS_SUCCESS;
>  
>        err_destroy:
> +	errno = EINVAL;
>  	context_destroy(scontext);
>  
>        err:
> Index: libsepol/man/man3/sepol_check_context.3
> ===================================================================
> --- libsepol/man/man3/sepol_check_context.3	(revision 2474)
> +++ libsepol/man/man3/sepol_check_context.3	(working copy)
> @@ -22,4 +22,4 @@
>  from libselinux instead.
>  
>  .SH "RETURN VALUE"
> -Returns 0 on success or -EINVAL otherwise.
> +Returns 0 on success or -1 with errno set otherwise.
> 
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
