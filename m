Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77ENd1u015857
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:23:39 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m77ENblA009734
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:23:39 GMT
Subject: Re: [patch 11/35] hotplug policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123736.418748193@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123736.418748193@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 10:23:00 -0400
Message-Id: <1218118980.5345.39.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_system_hotplug.patch)
> Should all be trivial changes

Merged.

> Index: refpolicy/policy/modules/system/hotplug.te
> ===================================================================
> --- refpolicy.orig/policy/modules/system/hotplug.te	2008-07-19 19:15:43.000000000 +0200
> +++ refpolicy/policy/modules/system/hotplug.te	2008-08-03 17:52:58.000000000 +0200
> @@ -121,6 +121,7 @@
>  	optional_policy(`
>  		# for arping used for static IP addresses on PCMCIA ethernet
>  		netutils_domtrans(hotplug_t)
> +		netutils_signal(hotplug_t)
>  		fs_rw_tmpfs_chr_files(hotplug_t)
>  	')
>  	files_getattr_generic_locks(hotplug_t)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
