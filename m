Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1NEFqHi010091
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2006 09:15:52 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1NEFoOb027810
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2006 14:15:50 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43FA4076.5020908@redhat.com>
References: <43FA4076.5020908@redhat.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 09:18:53 -0500
Message-Id: <1140704334.30819.89.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-02-20 at 17:19 -0500, Daniel J Walsh wrote:
> Fixed up semodule policy; although matchpathcon does not seem to be 
> returning the correct labels

Renamed semodule to semanage per the semodule policy discussion.

> plain text document attachment (diff)
> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.te serefpolicy-2.2.17/policy/modules/services/spamassassin.te
> --- nsaserefpolicy/policy/modules/services/spamassassin.te	2006-02-20 14:07:37.000000000 -0500
> +++ serefpolicy-2.2.17/policy/modules/services/spamassassin.te	2006-02-20 16:22:06.000000000 -0500
> @@ -124,6 +124,7 @@
>  	term_dontaudit_use_generic_ptys(spamd_t)
>  	files_dontaudit_read_root_files(spamd_t)
>  	tunable_policy(`spamd_enable_home_dirs',`
> +		userdom_search_unpriv_user_home_dirs(spamd_t)
>  		userdom_manage_generic_user_home_dirs(spamd_t)
>  		userdom_manage_generic_user_home_files(spamd_t)
>  		userdom_manage_generic_user_home_symlinks(spamd_t)

Fixed the userdom_manage_* interfaces to provide search on
user_home_dir_t instead.

> @@ -137,6 +137,8 @@
>  	samba_domtrans_smbmount(mount_t)
>  ')
>  
> +userdom_mounton_generic_user_home_dir(mount_t)
> +
>  ifdef(`TODO',`
>  # TODO: Need to examine this further. Not sure how to handle this
>  #type sysadm_mount_source_t, file_type, sysadmfile, $1_file_type;

Made user_home_dir_t and user_home_t mount points with
files_mountpoint() instead.

> @@ -526,12 +526,74 @@
>  
>  miscfiles_read_localization(setfiles_t)
>  
> +seutil_module_get_trans_lock(setfiles_t)
> +seutil_module_get_read_lock(setfiles_t)
> +
>  userdom_use_all_users_fd(setfiles_t)
>  # for config files in a home directory
>  userdom_read_all_user_files(setfiles_t)

I dropped the trans lock for now, I don't see setfiles getting a trans
lock in the code.

> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.17/policy/modules/system/userdomain.te
> --- nsaserefpolicy/policy/modules/system/userdomain.te	2006-02-16 14:46:56.000000000 -0500
> +++ serefpolicy-2.2.17/policy/modules/system/userdomain.te	2006-02-20 16:22:06.000000000 -0500
> @@ -358,6 +358,8 @@
>  			seutil_run_checkpolicy(secadm_t,secadm_r,admin_terminal)
>  			seutil_run_loadpolicy(secadm_t,secadm_r,admin_terminal)
>  			seutil_run_setfiles(secadm_t,secadm_r,admin_terminal)
> +			semodule_domtrans(secadm_t)
> +			role secadm_r types semodule_t;
>  			seutil_run_restorecon(secadm_t,secadm_r,admin_terminal)
>  		', `
>  			selinux_set_enforce_mode(sysadm_t)

Changed this to a run interface.  Added a call for sysadm_t if mls is
disabled.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
