Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3DD9xRb015748
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 09:10:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3DD9wmw005589
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 13:09:59 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i3DD9w4w005583 for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 13:09:58 GMT
Subject: Re: Problems with 2.4.24
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?iso-8859-2?Q?Jaros=B3aw?= Nozderko <jaroslaw.nozderko@polkomtel.com.pl>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <2A857CE92C11FE40858689CAEC7BED490A43910D@E2K2.corp.plusnet>
References: <2A857CE92C11FE40858689CAEC7BED490A43910D@E2K2.corp.plusnet>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1081861786.21530.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 13 Apr 2004 09:09:46 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-04-13 at 05:53, Jarosław Nozderko wrote:
> I've downloaded prepatched 2.4.24 kernel and
> userland tools from NSA.

2.4.25 is the latest.

> I've created /selinux directory. README (BUILDING AND 
> INSTALLING, p. 4) says selinuxfs should be mounted by init.
> It doesn't seem to do it - I had to do it manually or to 
> add fstab entry:

Did you build and installed the SELinux-patched /sbin/init program?
>From the SysVinit package?
 
> After reboot, the situation is as follows:
> 
> # ps --context
>   PID    SID CONTEXT                                  COMMAND
>  1414      - -                                        su
>  1415      - -                                        bash
>  1787      - -                                        ps --context

This implies that you never loaded a policy into the kernel.  Normally,
this is handled by the patched /sbin/init program, just like the
mounting of selinuxfs.

Unfortunately, I don't know of any up-to-date SELinux-patched packages
for SuSE.  You might want to ask Thorsten Kukuk.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
