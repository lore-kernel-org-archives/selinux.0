Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBKqmX9013286
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 15:52:48 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lBBKqlEe012430
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 20:52:47 GMT
Subject: Re: [PATCH] Debian refpolicy-trunk xen
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Litwiniec Robert <linio@wonder.pl>
Cc: SELinux list <selinux@tycho.nsa.gov>
In-Reply-To: <20071208151514.GA7703@asterix.wonder.pl>
References: <20071208151514.GA7703@asterix.wonder.pl>
Content-Type: text/plain
Date: Tue, 11 Dec 2007 15:52:23 -0500
Message-Id: <1197406343.12626.190.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-12-08 at 16:15 +0100, Litwiniec Robert wrote:
> Hello, patch for xen:
> 
> --- refpolicy.orig/policy/modules/system/xen.fc 2007-10-02 20:17:33.000000000 +0200
> +++ refpolicy/policy/modules/system/xen.fc      2007-11-17 16:39:12.755643344 +0100
> @@ -24,3 +24,10 @@
>  /var/run/xenstored(/.*)?       gen_context(system_u:object_r:xenstored_var_run_t,s0)
> 
>  /xen(/.*)?                     gen_context(system_u:object_r:xen_image_t,s0)
> +
> +ifdef(`distro_debian',`
> +/usr/lib/xen-(.*)?/bin/xenstored       --      gen_context(system_u:object_r:xenstored_exec_t,s0)
> +/usr/lib/xen-(.*)?/bin/xend            --      gen_context(system_u:object_r:xend_exec_t,s0)
> +/usr/lib/xen-(.*)?/bin/xenconsoled     --      gen_context(system_u:object_r:xenconsoled_exec_t,s0)
> +/usr/lib/xen-(.*)?/bin/xm              --      gen_context(system_u:object_r:xm_exec_t,s0)
> +')

The regex is redundant.  The * already makes it optional, so the ? isn't
needed, but I don't think we want it optional anyway.  I'm guessing you
want to match /usr/lib/xen-[version number]/ ?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
