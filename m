Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77ENYbX015811
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:23:34 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m77ENQjg022373
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:23:26 GMT
Subject: Re: [patch 30/35] fetchmail policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123739.512964567@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123739.512964567@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 10:22:56 -0400
Message-Id: <1218118976.5345.32.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment
> (policy_modules_services_fetchmail.patch)
> Trivial change to the fetchmail module...

Merged.

> Index: refpolicy/policy/modules/services/fetchmail.te
> ===================================================================
> --- refpolicy.orig/policy/modules/services/fetchmail.te	2008-08-03 21:45:04.000000000 +0200
> +++ refpolicy/policy/modules/services/fetchmail.te	2008-08-03 21:45:45.000000000 +0200
> @@ -14,7 +14,7 @@
>  files_pid_file(fetchmail_var_run_t)
>  
>  type fetchmail_etc_t;
> -files_type(fetchmail_etc_t)
> +files_config_file(fetchmail_etc_t)
>  
>  type fetchmail_uidl_cache_t;
>  files_type(fetchmail_uidl_cache_t)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
