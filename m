Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21EbsJR001050
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 09:37:54 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l21EdEP5022510
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 14:39:16 GMT
Subject: Re: wpa_cupplicant-global is a socket,  Not sure if it used to be
	something different
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@localhost.localdomain
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200702261954.l1QJsu2D031905@localhost.localdomain>
References: <200702261954.l1QJsu2D031905@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 09:39:34 -0500
Message-Id: <1172759975.11157.85.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 14:54 -0500, dwalsh@localhost.localdomain wrote:
> ===File /tmp/patches/nsaserefpolicy_policy_modules_services_networkmanager.fc===
> --- nsaserefpolicy/policy/modules/services/networkmanager.fc	2006-11-16 17:15:20.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/services/networkmanager.fc	2007-02-26 11:04:23.000000000 -0500
> @@ -3,4 +3,5 @@
>  /var/run/NetworkManager\.pid	--	gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
>  /var/run/NetworkManager(/.*)?		gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
>  /var/run/wpa_supplicant(/.*)?		gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
> -/var/run/wpa_supplicant-global	--	gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
> +/var/run/wpa_supplicant-global		gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
> +

Changed it to -s.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
