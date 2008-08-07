Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77DnuM6009152
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 09:49:56 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m77Dnmjg013149
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 13:49:48 GMT
Subject: Re: [patch 18/35] fsadm policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123737.588838945@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123737.588838945@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 09:49:18 -0400
Message-Id: <1218116958.5345.20.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_system_fstools.patch)
> Mostly to allow xen/cifs/nfs file management

Comments inline

> Index: refpolicy/policy/modules/system/fstools.if
> ===================================================================
> --- refpolicy.orig/policy/modules/system/fstools.if	2008-07-19 19:15:43.000000000 +0200
> +++ refpolicy/policy/modules/system/fstools.if	2008-08-03 18:06:57.000000000 +0200
> @@ -142,3 +142,21 @@
>  
>  	allow $1 swapfile_t:file getattr;
>  ')
> +
> +########################################
> +## <summary>
> +##	Send signal to fsadm process
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`fstools_signal',`
> +	gen_require(`
> +		type fsadm_t;
> +	')
> +
> +	allow $1 fsadm_t:process signal;
> +')

This needs to be moved after fstools_exec()

> Index: refpolicy/policy/modules/system/fstools.te
> ===================================================================
> --- refpolicy.orig/policy/modules/system/fstools.te	2008-07-19 19:15:43.000000000 +0200
> +++ refpolicy/policy/modules/system/fstools.te	2008-08-03 18:06:57.000000000 +0200
> @@ -97,6 +97,10 @@
>  fs_getattr_tmpfs_dirs(fsadm_t)
>  fs_read_tmpfs_symlinks(fsadm_t)
>  
> +fs_manage_nfs_files(fsadm_t)
> +
> +fs_manage_cifs_files(fsadm_t)

I need justification for these.

>  mls_file_read_all_levels(fsadm_t)
>  mls_file_write_all_levels(fsadm_t)
>  
> @@ -184,4 +188,9 @@
>  
>  optional_policy(`
>  	xen_append_log(fsadm_t)
> +	xen_rw_image_files(fsadm_t)
> +')
> +
> +optional_policy(`
> +	unconfined_domain(fsadm_t)
>  ')
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
