Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EEQUN6003865
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 10:26:31 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m7EEQGaK008167
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 14:26:16 GMT
Subject: Re: [patch 20/35] rpc policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123737.907994731@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123737.907994731@hardeman.nu>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 10:25:20 -0400
Message-Id: <1218723920.8095.77.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_services_rpc.patch)
> Partial merge of RedHat rpc changes (mostly a few read permissions and
> a couple of dontaudit rules).

Comments inline

> Depends on policy_modules_kernel_storage.patch
> 
> Index: refpolicy/policy/modules/services/rpc.te
> ===================================================================
> --- refpolicy.orig/policy/modules/services/rpc.te	2008-08-03 18:18:31.000000000 +0200
> +++ refpolicy/policy/modules/services/rpc.te	2008-08-04 13:18:47.000000000 +0200
> @@ -62,10 +62,10 @@
>  
>  # rpc.statd executes sm-notify
>  can_exec(rpcd_t, rpcd_exec_t)
> -corecmd_search_bin(rpcd_t)
> +corecmd_exec_bin(rpcd_t)
>  
>  kernel_read_system_state(rpcd_t) 
> -kernel_search_network_state(rpcd_t) 
> +kernel_read_network_state(rpcd_t)
>  # for rpc.rquotad
>  kernel_read_sysctl(rpcd_t)  
>  kernel_rw_fs_sysctls(rpcd_t)
> @@ -82,6 +82,7 @@
>  miscfiles_read_certs(rpcd_t)
>  
>  seutil_dontaudit_search_config(rpcd_t)
> +selinux_dontaudit_read_fs(rpcd_t)
>  
>  optional_policy(`
>  	nis_read_ypserv_config(rpcd_t)
> @@ -97,6 +98,12 @@
>  allow nfsd_t exports_t:file { getattr read };
>  allow nfsd_t { nfsd_rw_t nfsd_ro_t }:dir list_dir_perms;
>  
> +dev_dontaudit_getattr_all_blk_files(nfsd_t)
> +dev_dontaudit_getattr_all_chr_files(nfsd_t)
> +
> +dev_rw_lvm_control(nfsd_t)
> +storage_dontaudit_raw_read_fixed_disk(nfsd_t)
> +
>  # for /proc/fs/nfs/exports - should we have a new type?
>  kernel_read_system_state(nfsd_t) 
>  kernel_read_network_state(nfsd_t) 
> @@ -107,6 +114,7 @@
>  fs_mount_nfsd_fs(nfsd_t) 
>  fs_search_nfsd_fs(nfsd_t) 
>  fs_getattr_all_fs(nfsd_t) 
> +fs_getattr_all_dirs(nfsd_t)
>  fs_rw_nfsd_fs(nfsd_t) 
>  
>  term_use_controlling_term(nfsd_t) 
> @@ -149,6 +157,7 @@
>  manage_files_pattern(gssd_t, gssd_tmp_t, gssd_tmp_t)
>  files_tmp_filetrans(gssd_t, gssd_tmp_t, { file dir })
>  
> +kernel_read_system_state(gssd_t)
>  kernel_read_network_state(gssd_t)
>  kernel_read_network_state_symlinks(gssd_t)	
>  kernel_search_network_sysctl(gssd_t)	
> @@ -162,6 +171,9 @@
>  files_list_tmp(gssd_t) 
>  files_read_usr_symlinks(gssd_t) 
>  
> +auth_use_nsswitch(gssd_t)


> +auth_manage_cache(gssd_t)

Interface does not exist.

>  miscfiles_read_certs(gssd_t)
>  
>  tunable_policy(`allow_gssd_read_tmp',`

The remainder is merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
