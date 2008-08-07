Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77ENasv015830
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:23:36 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m77ENSji022389
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:23:29 GMT
Subject: Re: [patch 21/35] kismet policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123738.054090534@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123738.054090534@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 10:22:58 -0400
Message-Id: <1218118978.5345.35.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_admin_kismet.patch)
> kismet is a network sniffer so net_raw seems quite reasonable...

Merged.

> Index: refpolicy/policy/modules/admin/kismet.te
> ===================================================================
> --- refpolicy.orig/policy/modules/admin/kismet.te	2008-08-03 18:30:11.000000000 +0200
> +++ refpolicy/policy/modules/admin/kismet.te	2008-08-03 18:30:32.000000000 +0200
> @@ -25,7 +25,7 @@
>  # kismet local policy
>  #
>  
> -allow kismet_t self:capability { net_admin setuid setgid };
> +allow kismet_t self:capability { net_admin net_raw setuid setgid };
>  allow kismet_t self:packet_socket create_socket_perms;
>  
>  manage_files_pattern(kismet_t, kismet_log_t, kismet_log_t)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
