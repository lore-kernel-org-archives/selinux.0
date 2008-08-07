Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77ENdGk015853
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:23:39 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m77ENbl8009734
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:23:38 GMT
Subject: Re: [patch 16/35] usernet policy updates
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123737.235985370@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123737.235985370@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 10:22:59 -0400
Message-Id: <1218118979.5345.38.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_apps_usernetctl.patch)
> Only minor changes

Merged.

> Index: refpolicy/policy/modules/apps/usernetctl.if
> ===================================================================
> --- refpolicy.orig/policy/modules/apps/usernetctl.if	2008-08-03 16:46:56.000000000 +0200
> +++ refpolicy/policy/modules/apps/usernetctl.if	2008-08-03 18:01:40.000000000 +0200
> @@ -63,4 +63,9 @@
>  	optional_policy(`
>  		modutils_run_insmod(usernetctl_t, $2, $3)
>  	')
> +
> +
> +	optional_policy(`
> +		ppp_run(usernetctl_t,$2,$3)
> +	')
>  ')
> Index: refpolicy/policy/modules/apps/usernetctl.te
> ===================================================================
> --- refpolicy.orig/policy/modules/apps/usernetctl.te	2008-08-03 16:46:56.000000000 +0200
> +++ refpolicy/policy/modules/apps/usernetctl.te	2008-08-03 18:01:40.000000000 +0200
> @@ -49,15 +49,21 @@
>  
>  fs_search_auto_mountpoints(usernetctl_t)
>  
> +auth_use_nsswitch(usernetctl_t)
> +
>  libs_use_ld_so(usernetctl_t)
>  libs_use_shared_libs(usernetctl_t)
>  
> +logging_send_syslog_msg(usernetctl_t)
> +
>  miscfiles_read_localization(usernetctl_t)
>  
>  seutil_read_config(usernetctl_t)
>  
>  sysnet_read_config(usernetctl_t)
>  
> +term_search_ptys(usernetctl_t)
> +
>  optional_policy(`
>  	hostname_exec(usernetctl_t)
>  ')
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
