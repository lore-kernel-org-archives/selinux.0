Subject: Re: [Patch 2/2 v3] libsemanage: maintain disable dontaudit state
 between handle commits
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A524C27.7020601@redhat.com>
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
	 <4A523652.2040603@redhat.com>  <4A524C27.7020601@redhat.com>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 15:30:28 -0400
Message-Id: <1246908628.28321.135.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-07-06 at 15:10 -0400, Christopher Pardy wrote:
> Currently any changes made to the policy which require committing a handle cause dontaudit rules to be disabled. This is confusing, and frustrating for users who want to edit policy with dontaudit rules turned off. This patch allows semanage to remember the last state of the dontaudit rules and apply them as default whenever a handle is created. Additionally other functions may check for the file semanage creates to determine if dontaudit rules are turned on. This knowledge can be useful for tools like SETroubleshoot which may want to change their behavior depending on the state of the dontaudit rules.
>  
> Stephen Smalley: No longer attempt to create or destroy the file in the handle create, all store functionality has been moved to direct_api.c all functions now use sepol versions. The reason for needing to create the file in the commit statement is because changes to the flag in sepol directly may be reflected in the commited policy but not the flags.
> 
> Signed-off-by: Christopher Pardy <cpardy@redhat.com>
> 
> ---
>  libsemanage/include/semanage/handle.h |    3 +++
>  libsemanage/src/direct_api.c          |   33 +++++++++++++++++++++++++++++++++
>  libsemanage/src/direct_api.h          |    4 ++++
>  libsemanage/src/handle.c              |   19 +++++++++++++++++--
>  libsemanage/src/libsemanage.map       |    2 +-
>  libsemanage/src/semanage_store.c      |    1 +
>  libsemanage/src/semanage_store.h      |    1 +
>  7 files changed, 60 insertions(+), 3 deletions(-)

> diff -uprN selinux.orig2/libsemanage/src/direct_api.c selinux.orig3/libsemanage/src/direct_api.c
> --- selinux.orig2/libsemanage/src/direct_api.c	2009-07-01 21:15:17.264236347 -0400
> +++ selinux.orig3/libsemanage/src/direct_api.c	2009-07-06 15:01:10.811163179 -0400
> @@ -293,6 +293,39 @@ static int semanage_direct_begintrans(se
>  	return 0;
>  }
>  
> +/*********Dont audit functions*************/
> +
> +/* Creates, removes, and tests for the existance of a dont audit flag.
> + */
> +
> +int get_disable_dontaudit_flag(void)

Should follow the naming convention of this file, i.e.
semanage_direct_get_disable_dontaudit_flag().

> +{
> +	const char *path;
> +	
> +	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
> +	if(access(path,F_OK) == 0)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +void set_disable_dontaudit_flag(int setting)

Ditto.

> +{
> +	const char *path;
> +
> +	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
> +	if(setting == 1){
> +		FILE *touch;
> +		touch = fopen(path,"w");

I suspect we want to log an ERR() if this fails.

> +		if (touch != NULL)
> +			fclose(touch);
> +	}else
> +		remove(path);

Ditto.

> +	
> +	return;
> +}
> +
> +
>  /********************* utility functions *********************/
>  
>  /* Takes a module stored in 'module_data' and parses its headers.
<snip>
> diff -uprN selinux.orig2/libsemanage/src/handle.c selinux.orig3/libsemanage/src/handle.c
> --- selinux.orig2/libsemanage/src/handle.c	2009-07-01 21:15:17.288238017 -0400
> +++ selinux.orig3/libsemanage/src/handle.c	2009-07-06 15:04:18.442166837 -0400
> @@ -59,6 +59,9 @@ semanage_handle_t *semanage_handle_creat
>  		goto err;
>  	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
>  
> +	/*set the disable dontaudit flag to system defaults*/
> +	sepol_set_disable_dontaudit(sh->sepolh,get_disable_dontaudit_flag());

Shouldn't be done here, as I said - has to be done from
semanage_direct_connect() after we've already set up the connection
since it accesses a file in the store.


> @@ -66,6 +69,7 @@ semanage_handle_t *semanage_handle_creat
>  	/* By default always reload policy after commit if SELinux is enabled. */
>  	sh->do_reload = (is_selinux_enabled() > 0);
>  
> +
>  	/* By default do not create store */
>  	sh->create_store = 0;

Avoid spurious whitespace changes.

 
> @@ -264,9 +278,10 @@ int semanage_commit(semanage_handle_t * 
>  	assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
>  	if (!sh->is_in_transaction) {
>  		ERR(sh,
> -		    "Will not commit because caller does not have a tranaction lock yet.");
> +		    "Will not commit because caller does not have a transaction lock yet.");
>  		return -1;
>  	}
> +	set_disable_dontaudit_flag(sepol_get_disable_dontaudit(sh->sepolh));

Not justified AFAICS - the only way that the sepol disable dontaudit
flag can change is if the application called
semanage_set_disable_dontaudit() on the semanage handle (sepol handle is
private to libsemanage), so you can track changes there and do not need
to re-fetch here.

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
