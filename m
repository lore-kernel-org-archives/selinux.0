Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21Ebvxr001070
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 09:37:57 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l21EdEP9022510
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 14:39:20 GMT
Subject: Re: Additional bin_t files
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@localhost.localdomain
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200702261951.l1QJpxfW031880@localhost.localdomain>
References: <200702261951.l1QJpxfW031880@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 09:39:39 -0500
Message-Id: <1172759979.11157.87.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 14:51 -0500, dwalsh@localhost.localdomain wrote:
> 
> ===File /tmp/patches/nsaserefpolicy_policy_modules_kernel_corecommands.fc===
> --- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2007-02-19 11:32:51.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/kernel/corecommands.fc	2007-02-26 11:04:22.000000000 -0500
> @@ -73,7 +73,6 @@
>  
>  ifdef(`targeted_policy',`
>  /etc/X11/prefdm			--	gen_context(system_u:object_r:bin_t,s0)
> -/usr/games/nethack-3.4.3/nethack --	gen_context(system_u:object_r:bin_t,s0)
>  ')
>  
>  #
> @@ -254,3 +253,7 @@
>  ifdef(`distro_suse',`
>  /var/lib/samba/bin/.+			gen_context(system_u:object_r:bin_t,s0)
>  ')
> +
> +/etc/security/namespace.init    --      gen_context(system_u:object_r:bin_t,s0)
> +
> +/usr/lib/bluetooth(/.*)?	--      gen_context(system_u:object_r:bin_t,s0)
> ============================================================

Merged with a little reorganization.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
