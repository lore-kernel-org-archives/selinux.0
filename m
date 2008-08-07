Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77ENa2k015823
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:23:36 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m77ENSjg022389
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:23:28 GMT
Subject: Re: [patch 22/35] oav policy updates
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123738.204515169@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123738.204515169@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 10:22:57 -0400
Message-Id: <1218118977.5345.34.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_services_oav.patch)
> Trivial changes...

Merged.

> Index: refpolicy/policy/modules/services/oav.te
> ===================================================================
> --- refpolicy.orig/policy/modules/services/oav.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/services/oav.te	2008-08-03 20:34:32.000000000 +0200
> @@ -12,7 +12,7 @@
>  
>  # cjp: may be collapsable to etc_t
>  type oav_update_etc_t;
> -files_type(oav_update_etc_t)
> +files_config_file(oav_update_etc_t)
>  
>  type oav_update_var_lib_t;
>  files_type(oav_update_var_lib_t)
> @@ -22,7 +22,7 @@
>  init_daemon_domain(scannerdaemon_t, scannerdaemon_exec_t)
>  
>  type scannerdaemon_etc_t;
> -files_type(scannerdaemon_etc_t)
> +files_config_file(scannerdaemon_etc_t)
>  
>  type scannerdaemon_log_t;
>  logging_log_file(scannerdaemon_log_t)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
