Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SFHeOT014439
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 10:17:40 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1SFJ02d026804
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 15:19:00 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Additional wine executable
Date: Wed, 28 Feb 2007 10:19:10 -0500
Message-ID: <1172675950.11157.59.camel@sgc>
In-Reply-To: <200702261951.l1QJpJxL031872@localhost.localdomain>
References: <200702261951.l1QJpJxL031872@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 14:51 -0500, dwalsh@localhost.localdomain wrote:
> ===File /tmp/patches/nsaserefpolicy_policy_modules_apps_wine.fc===
> --- nsaserefpolicy/policy/modules/apps/wine.fc	2006-11-16 17:15:07.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/apps/wine.fc	2007-02-26 11:04:22.000000000 -0500
> @@ -1,2 +1,3 @@
>  /usr/bin/wine			--	gen_context(system_u:object_r:wine_exec_t,s0)
>  /opt/picasa/wine/bin/wine	--	gen_context(system_u:object_r:wine_exec_t,s0)
> +/opt/cxoffice/bin/wine		--	gen_context(system_u:object_r:wine_exec_t,s0)
> ============================================================

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
