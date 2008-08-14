Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EEQU6x003850
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 10:26:30 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m7EEQFaK008156
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 14:26:15 GMT
Subject: Re: [patch 24/35] bootloader policy updates
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123738.570715413@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123738.570715413@hardeman.nu>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 10:25:19 -0400
Message-Id: <1218723919.8095.76.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_admin_bootloader.patch)
> Most of the changes here are in a distro_redhat block and shouldn't be
> controversial...

Merged.  I moved the unconfined into the distro_redhat.

> Index: refpolicy/policy/modules/admin/bootloader.if
> ===================================================================
> --- refpolicy.orig/policy/modules/admin/bootloader.if	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/admin/bootloader.if	2008-08-03 21:09:17.000000000 +0200
> @@ -49,6 +49,11 @@
>  
>  	role $2 types bootloader_t;
>  	allow bootloader_t $3:chr_file rw_term_perms;
> +
> +	ifdef(`distro_redhat',`
> +		# for mke2fs
> +		mount_run(bootloader_t, $2, $3)
> +	')
>  ')
>  
>  ########################################
> Index: refpolicy/policy/modules/admin/bootloader.te
> ===================================================================
> --- refpolicy.orig/policy/modules/admin/bootloader.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/admin/bootloader.te	2008-08-03 21:09:17.000000000 +0200
> @@ -218,3 +218,7 @@
>  optional_policy(`
>  	sysadm_dontaudit_search_home_dirs(bootloader_t)
>  ')
> +
> +optional_policy(`
> +	unconfined_domain(bootloader_t)
> +')
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
