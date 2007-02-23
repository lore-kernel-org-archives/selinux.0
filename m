Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NIcjqi024901
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 13:38:45 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1NIe40Z020315
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 18:40:04 GMT
Subject: Re: Policy patch apmd needs to call telinit to change runlevel.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB2729.9000201@redhat.com>
References: <45DB2729.9000201@redhat.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 18:40:19 +0000
Message-Id: <1172256019.15371.72.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 11:51 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/services/apm.te       2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.4/policy/modules/services/apm.te    2007-02-20 10:25:41.000000000 -0500
> @@ -126,7 +126,7 @@
>  init_use_fds(apmd_t)
>  init_use_script_ptys(apmd_t)
>  init_rw_utmp(apmd_t)
> -init_write_initctl(apmd_t)
> +init_telinit(apmd_t)
>  
>  libs_exec_ld_so(apmd_t)
>  libs_use_ld_so(apmd_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
