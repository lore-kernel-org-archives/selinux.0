Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77ENbxn015841
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:23:37 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m77ENbl6009734
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:23:37 GMT
Subject: Re: [patch 13/35] ricci policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123736.746197981@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123736.746197981@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 10:22:59 -0400
Message-Id: <1218118979.5345.37.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_services_ricci.patch)
> One trivial change

Merged.

> Index: refpolicy/policy/modules/services/ricci.te
> ===================================================================
> --- refpolicy.orig/policy/modules/services/ricci.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/services/ricci.te	2008-08-03 18:01:32.000000000 +0200
> @@ -443,6 +443,7 @@
>  create_files_pattern(ricci_modstorage_t, ricci_modstorage_lock_t, ricci_modstorage_lock_t)
>  files_lock_filetrans(ricci_modstorage_t, ricci_modstorage_lock_t, file)
>  
> +corecmd_exec_shell(ricci_modstorage_t)
>  corecmd_exec_bin(ricci_modstorage_t)
>  
>  dev_read_sysfs(ricci_modstorage_t)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
