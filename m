Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3IGWVki019769
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 12:32:31 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m3IGWTSc029417
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 16:32:30 GMT
Subject: Re: [refpolicy] lvm runs shell scripts
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Martin Orr <martin@martinorr.name>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <47EB7AA5.1030502@martinorr.name>
References: <47EB7AA5.1030502@martinorr.name>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 11:22:08 -0400
Message-Id: <1208532128.7113.0.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-03-27 at 10:44 +0000, Martin Orr wrote:
> crytpsetup, for setting up encrypted volumes, runs shell scripts during this
> process which gives me:
> 
> Mar 27 10:16:41 caligula kernel: audit(1206612989.635:4): avc:  denied  {
> execute } for  pid=2929 comm="cryptsetup" name="dash" dev=dm-0 ino=470542
> scontext=system_u:system_r:lvm_t:s0
> tcontext=system_u:object_r:shell_exec_t:s0 tclass=file

Sorry for the delay; merged.

> plain text document attachment (113_cryptsetup_shell)
> Written by: Martin Orr
> 
> Allow cryptsetup to run shell scripts
> 
> Mar 27 10:16:41 caligula kernel: audit(1206612989.635:4): avc:  denied  { execute } for  pid=2929 comm="cryptsetup" name="dash" dev=dm-0 ino=470542 scontext=system_u:system_r:lvm_t:s0 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
> 
> Index: policy/modules/system/lvm.te
> ===================================================================
> --- policy/modules/system/lvm.te.orig
> +++ policy/modules/system/lvm.te
> @@ -247,6 +247,7 @@
>  term_list_ptys(lvm_t)
>  
>  corecmd_exec_bin(lvm_t)
> +corecmd_exec_shell(lvm_t)
>  
>  domain_use_interactive_fds(lvm_t)
>  
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
