Subject: Re: [Patch 2/2] libsemanage: maintain disable dontaudit state
 between handle commits
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A52100C.3010302@redhat.com>
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
	 <1246888018.28321.23.camel@moss-pluto.epoch.ncsc.mil>
	 <1246888326.28321.26.camel@moss-pluto.epoch.ncsc.mil>
	 <4A520D47.4040708@redhat.com>  <4A52100C.3010302@redhat.com>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 11:03:17 -0400
Message-Id: <1246892597.28321.41.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-07-06 at 10:54 -0400, Christopher Pardy wrote:
> Currently any changes made to the policy which require committing a handle cause dontaudit rules to be disabled. This is confusing, and frustrating for users who want to edit policy with dontaudit rules turned off. This patch allows semanage to remember the last state of the dontaudit rules and apply them as default whenever a handle is created. Additionally other functions may check for the file semanage creates to determine if dontaudit rules are turned on. This knowledge can be useful for tools like SETroubleshoot which may want to change their behavior depending on the state of the dontaudit rules.
> 
> Signed-off-by: Christopher Pardy <cpardy@redhat.com>
> 
> ---
>  libsemanage/include/semanage/handle.h |    3 +++
>  libsemanage/src/handle.c              |   33 +++++++++++++++++++++++++++++++--
>  libsemanage/src/libsemanage.map       |    2 +-
>  libsemanage/src/semanage_store.c      |    1 +
>  libsemanage/src/semanage_store.h      |    1 +
>  5 files changed, 37 insertions(+), 3 deletions(-)
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

Still don't see the need for this function.  The two patches I was
expecting were one to modify semanage_set_disable_dontaudit() to create
or remove the flag file, and one to update semodule to call
semanage_set_disable_dontaudit() in the build case.  No libsepol
patches.

> +
>  /* Set whether or not to disable dontaudits upon commit */
>  void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
>  
> diff -urpN selinux.orig2/libsemanage/src/handle.c selinux/libsemanage/src/handle.c
> --- selinux.orig2/libsemanage/src/handle.c	2009-07-01 21:15:17.288238017 -0400
> +++ selinux/libsemanage/src/handle.c	2009-07-06 10:28:52.492201095 -0400
> @@ -23,12 +23,14 @@
>  
>  #include <selinux/selinux.h>
>  
> +#include <unistd.h>
>  #include <stdarg.h>
>  #include <assert.h>
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <string.h>
>  #include <sys/time.h>
> +#include <limits.h>
>  
>  #include "direct_api.h"
>  #include "handle.h"
> @@ -42,6 +44,7 @@ semanage_handle_t *semanage_handle_creat
>  {
>  	semanage_handle_t *sh = NULL;
>  	const char *conf_name = NULL;
> +	char path[PATH_MAX]

No semicolon.

>  	/* Allocate handle */
>  	if ((sh = calloc(1, sizeof(semanage_handle_t))) == NULL)
> @@ -59,6 +62,14 @@ semanage_handle_t *semanage_handle_creat
>  		goto err;
>  	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
>  
> +	/*set the disable dontaudit flag to system defaults*/
> +	snprintf(path,PATH_MAX,"%s/disable_dontaudit",selinux_policy_root());
> +
> +	if (access(path,F_OK) == 0)
> +		semanage_set_disable_dontaudit(sh,1);
> +	else
> +		semanage_set_disable_dontaudit(sh,0);

No.  Now we're back to a flag file outside the policy store that isn't
managed by libsemanage.

Why do you need to do anything here at all?  What happens if you just
drop your changes to semanage_handle_create() and only modify
semanage_set_disable_dontaudit() to create or remove the in-store flag
file?

> +
>  	/* By default do not rebuild the policy on commit
>  	 * If any changes are made, this flag is ignored */
>  	sh->do_rebuild = 0;
> @@ -110,11 +121,29 @@ void semanage_set_create_store(semanage_
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
> +	const char *path;
> +
>  	assert(sh != NULL);
> -	
> +
>  	sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
> +	
> +	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
> +		if(disable_dontaudit == 1){

The entire if statement needs to be re-indented.

> +			FILE *touch;
> +			touch = fopen(path,"w");
> +			if (touch != NULL)
> +				fclose(touch);
> +		}else
> +			remove(path);
>  	return;
>  }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
