Subject: Re: [Patch 2/2] libsemanage: create a don't audit flag
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A51EEA5.4070802@redhat.com>
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>
	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>
	 <4A4C17D1.3060208@redhat.com>
	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CBC6C.5090709@redhat.com>
	 <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CC469.3050805@redhat.com>
	 <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CD320.2090706@redhat.com>
	 <1246554554.13464.356.camel@moss-pluto.epoch.ncsc.mil>
	 <4A51ED89.8010001@redhat.com>  <4A51EEA5.4070802@redhat.com>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 09:46:58 -0400
Message-Id: <1246888018.28321.23.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-07-06 at 08:31 -0400, Christopher Pardy wrote:
> Ignore previous version it was missing semicolons.
> 
> This patch provides the new function semanage_get_disable_dontaudit in libsemanage. 
> 
> The justification for this patch is that there is currently no way to know if dontaudit rules are  enabled. This patch provides a way to check on both the pending state of the dontaudit rules and it creates a flag file which can be looked for to determine the state of dontaudit rule on the last rebuild.
> 
> Signed-off-by Christopher Pardy <cpardy@redhat.com>
> 
> ---
>  libsemanage/include/semanage/handle.h |    3 +++
>  libsemanage/src/handle.c              |   26 +++++++++++++++++++++++---
>  libsemanage/src/libsemanage.map       |    2 +-
>  libsemanage/src/semanage_store.c      |    1 +
>  libsemanage/src/semanage_store.h      |    1 +
>  5 files changed, 29 insertions(+), 4 deletions(-)
> 
> 
> diff -urpN selinux.orig2/libsemanage/include/semanage/handle.h selinux/libsemanage/include/semanage/handle.h
> --- selinux.orig2/libsemanage/include/semanage/handle.h	2009-07-01 21:15:17.224235939 -0400
> +++ selinux/libsemanage/include/semanage/handle.h	2009-07-02 11:09:06.982262194 -0400
> @@ -69,6 +69,9 @@ void semanage_set_rebuild(semanage_handl
>   * 1 for yes, 0 for no (default) */
>  void semanage_set_create_store(semanage_handle_t * handle, int create_store);
>  
> +/*Get whether or not to dontaudits will be disabled upon commit */
> +int semanage_get_disable_dontaudit(semanage_handle_t * handle);
> +
>  /* Set whether or not to disable dontaudits upon commit */
>  void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
>  
> diff -urpN selinux.orig2/libsemanage/src/handle.c selinux/libsemanage/src/handle.c
> --- selinux.orig2/libsemanage/src/handle.c	2009-07-01 21:15:17.288238017 -0400
> +++ selinux/libsemanage/src/handle.c	2009-07-06 08:27:57.859443250 -0400
> @@ -29,6 +29,7 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <sys/time.h>
> +#include <limits.h>
>  
>  #include "direct_api.h"
>  #include "handle.h"
> @@ -59,6 +60,9 @@ semanage_handle_t *semanage_handle_creat
>  		goto err;
>  	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
>  
> +	/*make sure our flags are set right*/
> +	semanage_set_disable_dontaudit(sh,semanage_get_disable_dontaudit(sh));
> +

I don't believe that this is right.  semanage_get_disable_dontaudit()
calls sepol_get_disable_dontaudit() which will always return 0 when the
handle is first created and it cannot have been set yet since we are
only just now creating the handle.  Then you'll pass that zero to
semanage_set_disable_dontaudit() and always remove the flag file on
handle creation.  Not what you want.

>  	/* By default do not rebuild the policy on commit
>  	 * If any changes are made, this flag is ignored */
>  	sh->do_rebuild = 0;
> @@ -75,7 +79,7 @@ semanage_handle_t *semanage_handle_creat
>  	/* Set callback */
>  	sh->msg_callback = semanage_msg_default_handler;
>  	sh->msg_callback_arg = NULL;
> -
> +	
>  	return sh;
>  
>        err:

Spurious whitespace change?

> @@ -110,11 +114,27 @@ void semanage_set_create_store(semanage_
>  	return;
>  }
>  
> +int semanage_get_disable_dontaudit(semanage_handle_t * sh)
> +{
> +	assert(sh != NULL);
> +
> +	return sepol_get_disable_dontaudit(sh->sepolh);
> +}
> +
>  void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudit)
>  {
>  	assert(sh != NULL);
> -	
> +
>  	sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
> +	
> +	const char *path;

local var decls go at the beginning of the function.

> +	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
> +		if(disable_dontaudit == 1){
> +			FILE *touch;
> +			touch = fopen(path,"w");
> +			fclose(touch);

What if the fopen() fails and returns NULL?

> +		}else
> +			remove(path);

Indentation needs to be fixed.
Do we care if the remove() fails?  Need to report an ERR() message?

> diff -urpN selinux.orig2/libsemanage/src/semanage_store.c selinux/libsemanage/src/semanage_store.c
> --- selinux.orig2/libsemanage/src/semanage_store.c	2009-07-01 21:15:17.271236564 -0400
> +++ selinux/libsemanage/src/semanage_store.c	2009-07-06 08:21:49.374412534 -0400
> @@ -114,6 +114,7 @@ static const char *semanage_sandbox_path
>  	"/users_extra",
>  	"/netfilter_contexts",
>  	"/file_contexts.homedirs",
> +	"/modules/disable_dontaudit",

No, just use "/disable_dontaudit".  It will automatically put into the
sandbox subdirectory, just like the rest.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
