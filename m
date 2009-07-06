Subject: Re: [Patch 2/2 v2] libsemanage: maintain disable dontaudit state
 between handle commits
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A523652.2040603@redhat.com>
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
	 <4A520D47.4040708@redhat.com> <4A52100C.3010302@redhat.com>
	 <4A523652.2040603@redhat.com>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 14:07:00 -0400
Message-Id: <1246903620.28321.104.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-07-06 at 13:37 -0400, Christopher Pardy wrote:
> Currently any changes made to the policy which require committing a handle cause dontaudit rules to be disabled. This is confusing, and frustrating for users who want to edit policy with dontaudit rules turned off. This patch allows semanage to remember the last state of the dontaudit rules and apply them as default whenever a handle is created. Additionally other functions may check for the file semanage creates to determine if dontaudit rules are turned on. This knowledge can be useful for tools like SETroubleshoot which may want to change their behavior depending on the state of the dontaudit rules.
> 
> Stephen Smalley: This get function has the correct functionality as it
> gets the actual value that will be committed to memory.
> 
> Signed-off-by: Christopher Pardy <cpardy@redhat.com>
> 
> ---
>  libsemanage/include/semanage/handle.h |    3 +++
>  libsemanage/src/handle.c              |   34 ++++++++++++++++++++++++++++++++--
>  libsemanage/src/libsemanage.map       |    2 +-
>  libsemanage/src/semanage_store.c      |    1 +
>  libsemanage/src/semanage_store.h      |    1 +
>  5 files changed, 38 insertions(+), 3 deletions(-)
> 

> diff -urpN selinux.orig2/libsemanage/src/handle.c selinux/libsemanage/src/handle.c
> --- selinux.orig2/libsemanage/src/handle.c	2009-07-01 21:15:17.288238017 -0400
> @@ -59,6 +62,14 @@ semanage_handle_t *semanage_handle_creat
>  		goto err;
>  	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
>  
> +	/*set the disable dontaudit flag to system defaults*/
> +	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
> +
> +	if (access(path,F_OK) == 0)
> +		semanage_set_disable_dontaudit(sh,1);
> +	else
> +		semanage_set_disable_dontaudit(sh,0);
> +

No.  This will try to create or remove the file within the active policy
store without even having started a transaction.  And it is completely a
waste as you are merely re-creating or removing the file based on
whether it already exists.  And you aren't allowed to touch the store
from handle_create; the caller hasn't yet connected to the store via
semanage_connect().  And technically all interaction with the file store
ought to happen from the direct_api functions.

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
> +	if(disable_dontaudit == 1){
> +		FILE *touch;
> +		touch = fopen(path,"w");
> +		if (touch != NULL)
> +			fclose(touch);
> +	}else
> +		remove(path);
>  	return;
>  }
>  
> @@ -264,9 +293,10 @@ int semanage_commit(semanage_handle_t * 
>  	assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
>  	if (!sh->is_in_transaction) {
>  		ERR(sh,
> -		    "Will not commit because caller does not have a tranaction lock yet.");
> +		    "Will not commit because caller does not have a transaction lock yet.");
>  		return -1;
>  	}
> +	semanage_set_disable_dontaudit(sh,semanage_get_disable_dontaudit(sh));

This likewise doesn't make sense; if the application called
semanage_set_disable_dontaudit(), then the in-memory variable and the
flag file have already been set properly and you don't need this.

As is, this will try to re-create or remove the file 3 times on a single
sequence, once at handle_create (not legal), once when the application
itself calls semanage_set_disable_dontaudit(), and once upon commit.

>  	retval = sh->funcs->commit(sh);
>  	sh->is_in_transaction = 0;
>  	sh->modules_modified = 0;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
