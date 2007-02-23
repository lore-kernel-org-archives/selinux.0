Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NIxlYM025807
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 13:59:47 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1NJ150Z025514
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 19:01:06 GMT
Subject: Re: mls_trusted_object(cupsd_var_run_t) defined twice.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB30CE.5090406@redhat.com>
References: <45DB30CE.5090406@redhat.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 19:01:21 +0000
Message-Id: <1172257281.15371.82.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 12:33 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/services/cups.te      2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.4/policy/modules/services/cups.te   2007-02-20 10:37:09.000000000 -0500
> @@ -72,7 +72,6 @@
>  ifdef(`enable_mls',`
>         init_ranged_daemon_domain(cupsd_t,cupsd_exec_t,mls_systemhigh)
>  
> -       mls_trusted_object(cupsd_var_run_t)
>  ')
>  
>  ########################################

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
