Subject: Re: [Patch 2/2 v4] libsemanage: maintain disable dontaudit state
 between handle commits
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A5372D6.80405@redhat.com>
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
	 <4A523652.2040603@redhat.com> <4A524C27.7020601@redhat.com>
	 <4A535240.1000900@redhat.com>  <4A5372D6.80405@redhat.com>
Content-Type: text/plain
Date: Tue, 07 Jul 2009 12:55:20 -0400
Message-Id: <1246985720.28321.261.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-07 at 12:07 -0400, Christopher Pardy wrote:
> Currently any changes made to the policy which require committing a
> handle cause dontaudit rules to be disabled.

I think you mean "re-enable dontaudit rules even if they were previously
disabled."

>  This is confusing, and frustrating for users who want to edit policy
> with dontaudit rules turned off. This patch allows semanage to
> remember the last state of the dontaudit rules and apply them as
> default whenever a handle is connected. Additionally other functions
> may check for the file semanage creates to determine if dontaudit
> rules are turned on.

Just to be clear:  anything outside of libsemanage must use
semanage_get_disable_dontaudit() to test for the flag, not directly test
for the existence of the file, as the policy store is private to
libsemanage.

>  This knowledge can be useful for tools like SETroubleshoot which may
> want to change their behavior depending on the state of the dontaudit
> rules. In the event that a the file cannot be created a call to commit
> will fail.
>   
> Signed-off-by: Christopher Pardy <cpardy@redhat.com>
> 
> ---
>  libsemanage/include/semanage/handle.h |    8 +++++++-
>  libsemanage/src/direct_api.c          |   27 +++++++++++++++++++++++++--
>  libsemanage/src/handle.c              |    9 ++++++++-
>  libsemanage/src/libsemanage.map       |    2 +-
>  libsemanage/src/semanage_store.c      |    1 +
>  libsemanage/src/semanage_store.h      |    1 +
>  6 files changed, 43 insertions(+), 5 deletions(-)
> 
> 
> diff -urpN selinux.orig2/libsemanage/include/semanage/handle.h selinux.orig3/libsemanage/include/semanage/handle.h
> --- selinux.orig2/libsemanage/include/semanage/handle.h	2009-07-01 21:15:17.224235939 -0400
> +++ selinux.orig3/libsemanage/include/semanage/handle.h	2009-07-07 09:37:35.888570766 -0400
> @@ -69,7 +69,13 @@ void semanage_set_rebuild(semanage_handl
>   * 1 for yes, 0 for no (default) */
>  void semanage_set_create_store(semanage_handle_t * handle, int create_store);
>  
> -/* Set whether or not to disable dontaudits upon commit */
> +/*Get whether or not to dontaudits will be disabled upon commit */
> +int semanage_get_disable_dontaudit(semanage_handle_t * handle);
> +
> +/* Set whether or not to disable dontaudits upon commit
> + * Sets errno to 0 if successful. Otherwise sets errno
> + * to any of the errors specified by fopen,fclose, or remove.

The errno discussion is no longer relevant here and can be removed.

> + */
>  void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
>  
>  /* Check whether policy is managed via libsemanage on this system.
> diff -urpN selinux.orig2/libsemanage/src/direct_api.c selinux.orig3/libsemanage/src/direct_api.c
> --- selinux.orig2/libsemanage/src/direct_api.c	2009-07-01 21:15:17.264236347 -0400
> +++ selinux.orig3/libsemanage/src/direct_api.c	2009-07-07 12:00:22.111349550 -0400
> @@ -641,11 +650,11 @@ static int semanage_direct_update_seuser
>   * Returns commit number on success, -1 on error.
>   */
>  static int semanage_direct_commit(semanage_handle_t * sh)
> -{
> +{

Extraneous whitespace.   Try using checkpatch.pl.
	
> @@ -669,6 +678,20 @@ static int semanage_direct_commit(semana
>  	dbase_config_t *pfcontexts = semanage_fcontext_dbase_policy(sh);
>  	dbase_config_t *seusers = semanage_seuser_dbase_local(sh);
>  
> +	/* Immediently create the disable_dontaudit flag */
> +	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
> +	if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
> +		FILE *touch;
> +		touch = fopen(path,"w");
> +		if (touch != NULL)
> +			if(fclose(touch) != 0)
> +				goto cleanup;
> +		else
> +			goto cleanup;

I think we still want an ERR() call here to let us know why it failed.
> +	} else
> +		if (remove(path) == -1 && errno != ENOENT)
> +			goto cleanup;

And likewise here.

Otherwise, looks good to me.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
