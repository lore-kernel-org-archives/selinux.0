Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EEQWaC003891
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 10:26:32 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m7EEQHaK008176
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 14:26:17 GMT
Subject: Re: [patch 12/35] getty policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123736.576821217@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123736.576821217@hardeman.nu>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 10:25:21 -0400
Message-Id: <1218723921.8095.78.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_system_getty.patch)
> Hopefully trivial changes

Merged.

> Index: refpolicy/policy/modules/system/getty.fc
> ===================================================================
> --- refpolicy.orig/policy/modules/system/getty.fc	2008-07-19 19:15:43.000000000 +0200
> +++ refpolicy/policy/modules/system/getty.fc	2008-08-03 18:01:20.000000000 +0200
> @@ -8,5 +8,5 @@
>  
>  /var/run/mgetty\.pid.*	--	gen_context(system_u:object_r:getty_var_run_t,s0)
>  
> -/var/spool/fax		--	gen_context(system_u:object_r:getty_var_run_t,s0)
> -/var/spool/voice	--	gen_context(system_u:object_r:getty_var_run_t,s0)
> +/var/spool/fax(/.*)?		gen_context(system_u:object_r:getty_var_run_t,s0)
> +/var/spool/voice(/.*)?		gen_context(system_u:object_r:getty_var_run_t,s0)
> Index: refpolicy/policy/modules/system/getty.te
> ===================================================================
> --- refpolicy.orig/policy/modules/system/getty.te	2008-07-19 19:15:43.000000000 +0200
> +++ refpolicy/policy/modules/system/getty.te	2008-08-03 18:01:20.000000000 +0200
> @@ -9,6 +9,7 @@
>  type getty_t;
>  type getty_exec_t;
>  init_domain(getty_t,getty_exec_t)
> +init_system_domain(getty_t,getty_exec_t)
>  domain_interactive_fd(getty_t)
>  
>  type getty_etc_t;
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
