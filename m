Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21EbxXH001080
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 09:37:59 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l21EdEPB022510
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 14:39:22 GMT
Subject: Re: Additional localtime files
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@localhost.localdomain
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200702261956.l1QJuMpl031919@localhost.localdomain>
References: <200702261956.l1QJuMpl031919@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 09:39:40 -0500
Message-Id: <1172759980.11157.88.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 14:56 -0500, dwalsh@localhost.localdomain wrote:
> ===File /tmp/patches/nsaserefpolicy_policy_modules_system_miscfiles.fc===
> --- nsaserefpolicy/policy/modules/system/miscfiles.fc	2007-01-02 12:57:49.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/system/miscfiles.fc	2007-02-26 11:04:23.000000000 -0500
> @@ -74,3 +74,5 @@
>  /var/lib/msttcorefonts(/.*)?	gen_context(system_u:object_r:fonts_t,s0)
>  /var/lib/usbutils(/.*)?		gen_context(system_u:object_r:hwdata_t,s0)
>  ')
> +/var/spool/postfix/etc/localtime -- gen_context(system_u:object_r:locale_t,s0)
> +/var/empty/sshd/etc/localtime  -- gen_context(system_u:object_r:locale_t,s0)

Merged with some reorg.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
