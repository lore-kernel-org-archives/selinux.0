Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77ENbx7015833
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:23:37 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m77ENSjk022389
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:23:29 GMT
Subject: Re: [patch 19/35] kernel storage module policy updates
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123737.744813517@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123737.744813517@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 10:22:58 -0400
Message-Id: <1218118978.5345.36.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_kernel_storage.patch)
> A few new paths and a new interface which is used by later patches

Merged.  In the future, when a new interface is created and then called,
both changes should be in the same patch.

> Index: refpolicy/policy/modules/kernel/storage.fc
> ===================================================================
> --- refpolicy.orig/policy/modules/kernel/storage.fc	2008-07-19 19:15:34.000000000 +0200
> +++ refpolicy/policy/modules/kernel/storage.fc	2008-08-03 18:09:53.000000000 +0200
> @@ -13,6 +13,7 @@
>  /dev/cm20.*		-b	gen_context(system_u:object_r:removable_device_t,s0)
>  /dev/dasd[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
>  /dev/dm-[0-9]+		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
> +/dev/drbd[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
>  /dev/fd[^/]+		-b	gen_context(system_u:object_r:removable_device_t,s0)
>  /dev/flash[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
>  /dev/gscd		-b	gen_context(system_u:object_r:removable_device_t,s0)
> @@ -48,6 +49,7 @@
>  /dev/tw[a-z][^/]+	-c	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
>  /dev/ub[a-z][^/]+	-b	gen_context(system_u:object_r:removable_device_t,mls_systemhigh)
>  /dev/ubd[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
> +/dev/vd[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
>  /dev/xvd[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
>  
>  /dev/ataraid/.*		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
> Index: refpolicy/policy/modules/kernel/storage.if
> ===================================================================
> --- refpolicy.orig/policy/modules/kernel/storage.if	2008-08-03 16:46:56.000000000 +0200
> +++ refpolicy/policy/modules/kernel/storage.if	2008-08-03 18:09:53.000000000 +0200
> @@ -81,6 +81,26 @@
>  
>  ########################################
>  ## <summary>
> +##	dontaudit the caller attempts to read from a fixed disk.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	The type of the process performing this action.
> +##	</summary>
> +## </param>
> +#
> +interface(`storage_dontaudit_raw_read_fixed_disk',`
> +	gen_require(`
> +		attribute fixed_disk_raw_read;
> +		type fixed_disk_device_t;
> +	')
> +
> +	dontaudit $1 fixed_disk_device_t:blk_file read_blk_file_perms;
> +	dontaudit $1 fixed_disk_device_t:chr_file read_chr_file_perms;
> +')
> +
> +########################################
> +## <summary>
>  ##	Allow the caller to directly read from a fixed disk.
>  ##	This is extremly dangerous as it can bypass the
>  ##	SELinux protections for filesystem objects, and
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
