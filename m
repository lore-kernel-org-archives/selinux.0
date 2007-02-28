Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SFtq7X016435
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 10:55:52 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1SFvF2d003924
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 15:57:15 GMT
Subject: Re: Changes to ftp policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@localhost.localdomain
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200702261716.l1QHGrqw030567@localhost.localdomain>
References: <200702261716.l1QHGrqw030567@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 10:57:33 -0500
Message-Id: <1172678253.11157.68.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:16 -0500, dwalsh@localhost.localdomain wrote:
> kerberized ftp needs to read keytab file
> 
> Needs to be able to rw_faillog,
> 
> If you allow ftp to login to homedirs, you would expect to be able to ftp off the entire the system.  Perhaps this should be a boolean or only targeted policy.
> 
> 
> ===File /tmp/patches/done/nsaserefpolicy_policy_modules_services_ftp.patch===
> --- nsaserefpolicy/policy/modules/services/ftp.te	2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/services/ftp.te	2007-02-26 11:02:34.000000000 -0500
> @@ -125,7 +125,7 @@
>  auth_append_login_records(ftpd_t)
>  #kerberized ftp requires the following
>  auth_write_login_records(ftpd_t)
> -auth_append_faillog(ftpd_t)
> +auth_rw_faillog(ftpd_t)
>  
>  init_use_fds(ftpd_t)
>  init_use_script_ptys(ftpd_t)
> @@ -190,10 +190,15 @@
>  	userdom_manage_all_users_home_content_dirs(ftpd_t)
>  	userdom_manage_all_users_home_content_files(ftpd_t)
>  	userdom_manage_all_users_home_content_symlinks(ftpd_t)
> +	auth_manage_all_files_except_shadow(ftpd_t)
>  
>  	ifdef(`targeted_policy',`
>  		userdom_generic_user_home_dir_filetrans_generic_user_home_content(ftpd_t,{ dir file lnk_file sock_file fifo_file })
> +		files_manage_generic_tmp_files(ftpd_t)
>  	')
> +	auth_read_all_dirs_except_shadow(ftpd_t)
> +	auth_read_all_files_except_shadow(ftpd_t)
> +	auth_read_all_symlinks_except_shadow(ftpd_t)
>  ')
>  
>  tunable_policy(`ftp_home_dir && use_nfs_home_dirs',`
> @@ -214,6 +219,10 @@
>  ')
>  
>  optional_policy(`
> +	kerberos_read_keytab(ftpd_t)
> +')
> +
> +optional_policy(`
>  	tunable_policy(`ftp_home_dir',`
>  		apache_search_sys_content(ftpd_t)
>  	')
> ============================================================

Merged the first and last hunks (last one moved down).  I don't
understand the logic behind logging into a home dir as implying access
to other files on the system.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
