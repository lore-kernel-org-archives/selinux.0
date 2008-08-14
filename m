Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EEQToY003838
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 10:26:29 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m7EEQEaK008149
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 14:26:14 GMT
Subject: Re: [patch 25/35] rdisc policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123738.744174540@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123738.744174540@hardeman.nu>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 10:25:18 -0400
Message-Id: <1218723918.8095.75.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_services_rdisc.patch)
> Minor changes to the rdisc module, the interface that is added is used
> in later RH patches (not part of the current patchset)...

Merged the .te change, drop the .if change since the type doesn't exist.

> Index: refpolicy/policy/modules/services/rdisc.if
> ===================================================================
> --- refpolicy.orig/policy/modules/services/rdisc.if	2008-07-19 19:15:41.000000000 +0200
> +++ refpolicy/policy/modules/services/rdisc.if	2008-08-03 21:17:42.000000000 +0200
> @@ -1 +1,20 @@
>  ## <summary>Network router discovery daemon</summary>
> +
> +########################################
> +## <summary>
> +##	Execute rdisc server in the rdisc domain.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	The type of the process performing this action.
> +##	</summary>
> +## </param>
> +#
> +#
> +interface(`rdisc_script_domtrans',`
> +	gen_require(`
> +		type rdisc_script_exec_t;
> +	')
> +
> +	init_script_domtrans_spec($1,rdisc_script_exec_t)
> +')
> Index: refpolicy/policy/modules/services/rdisc.te
> ===================================================================
> --- refpolicy.orig/policy/modules/services/rdisc.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/services/rdisc.te	2008-08-03 21:17:42.000000000 +0200
> @@ -45,6 +45,8 @@
>  libs_use_ld_so(rdisc_t)
>  libs_use_shared_libs(rdisc_t)
>  
> +miscfiles_read_localization(rdisc_t)
> +
>  logging_send_syslog_msg(rdisc_t)
>  
>  sysnet_read_config(rdisc_t)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
