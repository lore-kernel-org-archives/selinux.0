Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3DEKARb016440
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 10:20:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3DEI7UZ009960
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 14:18:07 GMT
Received: from plusmx1.polkomtel.com.pl (plusmx1.polkomtel.com.pl [212.2.96.51])
	by jazzswing.ncsc.mil  with ESMTP id i3DEI6mT009957
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 14:18:06 GMT
Received: from mswwaw1.corp.plusnet (plus-96-118.polkomtel.com.pl [212.2.96.118])
	by plusmx1.polkomtel.com.pl (Postfix) with ESMTP id 25AB938012
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 16:20:08 +0200 (CEST)
Received: from E2K2.corp.plusnet (mcs1baln1.corp.plusnet) by mswwaw1.corp.plusnet
 (Content Technologies SMTPRS 4.3.12) with ESMTP id <T68f113d674c0a8011d804@mswwaw1.corp.plusnet> for <selinux@tycho.nsa.gov>;
 Tue, 13 Apr 2004 16:20:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: Problems with 2.4.24
Date: Tue, 13 Apr 2004 16:20:07 +0200
Message-ID: <2A857CE92C11FE40858689CAEC7BED490A439367@E2K2.corp.plusnet>
From: =?utf-8?Q?Jaros=C5=82aw_Nozderko?= <jaroslaw.nozderko@polkomtel.com.pl>
To: "SELinux Mailing List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen, Russell,

> 
> Did you build and installed the SELinux-patched /sbin/init program?
> >From the SysVinit package?
>  

No, my fault.

> > After reboot, the situation is as follows:
> > 
> > # ps --context
> >   PID    SID CONTEXT                                  COMMAND
> >  1414      - -                                        su
> >  1415      - -                                        bash
> >  1787      - -                                        ps --context
> 
> This implies that you never loaded a policy into the kernel.  
> Normally,
> this is handled by the patched /sbin/init program, just like the
> mounting of selinuxfs.
> 
> Unfortunately, I don't know of any up-to-date SELinux-patched packages
> for SuSE.  You might want to ask Thorsten Kukuk.

OK... Is it possible to boot in permissive mode and then manually 
switch to enforcing with loading policy or something like this,
 just for testing ?

Or is it easier to just use Fedora Core for educational purposes ?

Regards,
Jarek


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
