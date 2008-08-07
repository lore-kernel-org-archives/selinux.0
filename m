Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77DmWZI008877
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 09:48:32 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m77DmKjg012824
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 13:48:20 GMT
Subject: Re: [patch 17/35] brctl policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123737.432616785@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123737.432616785@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 09:47:49 -0400
Message-Id: <1218116869.5345.18.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_admin_brctl.patch)
> One minor change

I need justification for this change.

> Index: refpolicy/policy/modules/admin/brctl.te
> ===================================================================
> --- refpolicy.orig/policy/modules/admin/brctl.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/admin/brctl.te	2008-08-03 18:01:42.000000000 +0200
> @@ -33,6 +33,8 @@
>  
>  files_read_etc_files(brctl_t)
>  
> +term_use_console(brctl_t)
> +
>  libs_use_ld_so(brctl_t)
>  libs_use_shared_libs(brctl_t)
>  
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
