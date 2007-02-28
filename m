Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SEw7kN013367
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 09:58:07 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1SExT2u005224
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 14:59:29 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [SPAM]   mdadm does a ls of /dev
Date: Wed, 28 Feb 2007 09:59:48 -0500
Message-ID: <1172674788.11157.57.camel@sgc>
In-Reply-To: <200702261805.l1QI56qf030862@localhost.localdomain>
References: <200702261805.l1QI56qf030862@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 13:05 -0500, dwalsh@localhost.localdomain wrote:
> Dontaudit stuff it should not be looking at
> 
> 
> 
> ===File /tmp/patches/done/nsaserefpolicy_policy_modules_system_raid.patch===
> --- nsaserefpolicy/policy/modules/system/raid.te	2007-01-02 12:57:49.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/system/raid.te	2007-02-26 11:02:34.000000000 -0500
> @@ -93,3 +93,7 @@
>  optional_policy(`
>  	udev_read_db(mdadm_t)
>  ')
> +
> +optional_policy(`
> +	gpm_dontaudit_getattr_gpmctl(mdadm_t)
> +')
> ============================================================

Already there, a few lines up.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
