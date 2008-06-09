Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m59E2gaq011954
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 10:02:42 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m59E2ftb014734
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 14:02:41 GMT
Subject: Re: kernel/kernel.* diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4836D603.1000506@redhat.com>
References: <4836D603.1000506@redhat.com>
Content-Type: text/plain
Date: Mon, 09 Jun 2008 10:02:29 -0400
Message-Id: <1213020149.27496.3.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-05-23 at 10:34 -0400, Daniel J Walsh wrote:
> Mainly adding additional dontaudits for permissive domains.

> Subject: [PATCH] refpolicy: kernel_kernel changes
> --text follows this line--
> --- nsaserefpolicy/policy/modules/kernel/kernel.if	2008-05-23 09:15:06.224337000 -0400
> +++ serefpolicy-3.4.1/policy/modules/kernel/kernel.if	2008-05-23 10:29:05.107838000 -0400
> @@ -1198,6 +1198,7 @@
>  	')
>  
>  	dontaudit $1 proc_type:dir list_dir_perms;
> +	dontaudit $1 proc_type:file getattr;
>  ')
>  
>  ########################################
> @@ -1768,6 +1769,7 @@
>  	')
>  
>  	dontaudit $1 sysctl_type:dir list_dir_perms;
> +	dontaudit $1 sysctl_type:file read_file_perms;
>  ')
>  
>  ########################################

These two violate the intention of the interface.

> --- nsaserefpolicy/policy/modules/kernel/kernel.te	2008-05-23 09:15:06.211350000 -0400
> +++ serefpolicy-3.4.1/policy/modules/kernel/kernel.te	2008-05-23 10:27:34.127426000 -0400
> @@ -231,6 +231,7 @@
>  # Mount root file system.  Used when loading a policy
>  # from initrd, then mounting the root filesystem
>  fs_mount_all_fs(kernel_t)
> +fs_unmount_all_fs(kernel_t)
>  
>  selinux_load_policy(kernel_t)
>  
> @@ -253,6 +254,8 @@
>  
>  mls_process_read_up(kernel_t)
>  mls_process_write_down(kernel_t)
> +mls_file_write_all_levels(kernel_t)
> +mls_file_read_all_levels(kernel_t) 
>  
>  ifdef(`distro_redhat',`
>  	# Bugzilla 222337

These are merged.

> @@ -372,3 +375,6 @@
>  allow kern_unconfined unlabeled_t:association *;
>  allow kern_unconfined unlabeled_t:packet *;
>  allow kern_unconfined unlabeled_t:process ~{ transition dyntransition execmem execstack execheap };
> +
> +kernel_rw_all_sysctls(kern_unconfined)
> +

This one is redundant.  A few lines up is:

allow kern_unconfined sysctl_type:{ dir file } *;

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
