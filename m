Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1JJPIVD021063
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 14:25:20 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1JJPHsY003499
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 19:25:18 GMT
Subject: Re: [refpolicy] pam_mount
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1202029806.2674.4.camel@vogon>
References: <1202029806.2674.4.camel@vogon>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 14:22:50 -0500
Message-Id: <1203448970.13618.103.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2008-02-03 at 10:10 +0100, Stefan Schulze Frielinghaus wrote:
> pam_mount needs proper labeling. Tested on Fedora 8

Merged.

> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (authlogin.fc.patch)
> 
> --- /usr/src/refpolicy-20071214/policy/modules/system/authlogin.fc      2007-12-12 16:55:21.000000000 +0100
> +++ policy/modules/system/authlogin.fc  2008-02-01 21:40:10.000000000
> +0100
> @@ -40,5 +40,5 @@
>  /var/log/wtmp.*                --      gen_context(system_u:object_r:wtmp_t,s0)
>  
>  /var/run/console(/.*)?         gen_context(system_u:object_r:pam_var_console_t,s0)
> -
> +/var/run/pam_mount(/.*)?       gen_context(system_u:object_r:pam_var_run_t,s0)
>  /var/run/sudo(/.*)?
> gen_context(system_u:object_r:pam_var_run_t,s0)
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
