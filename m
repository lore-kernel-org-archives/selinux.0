Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77ENZxx015820
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:23:35 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m77ENYl6009724
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:23:34 GMT
Subject: Re: [patch 26/35] stunnel policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123738.902590483@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123738.902590483@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 10:22:56 -0400
Message-Id: <1218118976.5345.33.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_services_stunnel.patch)
> Changes to the stunnel module which shouldn't be controversial, the interface
> is used by later RH patches to the inetd module.

Merged.

> Index: refpolicy/policy/modules/services/stunnel.if
> ===================================================================
> --- refpolicy.orig/policy/modules/services/stunnel.if	2008-07-19 19:15:41.000000000 +0200
> +++ refpolicy/policy/modules/services/stunnel.if	2008-08-03 21:21:31.000000000 +0200
> @@ -1 +1,25 @@
>  ## <summary>SSL Tunneling Proxy</summary>
> +
> +########################################
> +## <summary>
> +##	Define the specified domain as a stunnel inetd service.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	The type associated with the stunnel inetd service process.
> +##	</summary>
> +## </param>
> +## <param name="entrypoint">
> +##	<summary>
> +##	The type associated with the process program.
> +##	</summary>
> +## </param>
> +#
> +interface(`stunnel_service_domain',`
> +	gen_require(`
> +		type stunnel_t;
> +	')
> +
> +	domtrans_pattern(stunnel_t,$2,$1)
> +	allow $1 stunnel_t:tcp_socket rw_socket_perms;
> +')
> Index: refpolicy/policy/modules/services/stunnel.te
> ===================================================================
> --- refpolicy.orig/policy/modules/services/stunnel.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/services/stunnel.te	2008-08-03 21:21:31.000000000 +0200
> @@ -20,7 +20,7 @@
>  ')
>  
>  type stunnel_etc_t;
> -files_type(stunnel_etc_t)
> +files_config_file(stunnel_etc_t)
>  
>  type stunnel_tmp_t;
>  files_tmp_file(stunnel_tmp_t)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
