Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3HGVCRb021974
	for <selinux@tycho.nsa.gov>; Sat, 17 Apr 2004 12:31:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3HGVBmw027752
	for <selinux@tycho.nsa.gov>; Sat, 17 Apr 2004 16:31:11 GMT
Received: from kokytos.rz.informatik.uni-muenchen.de (kokytos.rz.informatik.uni-muenchen.de [141.84.214.13])
        by jazzband.ncsc.mil  with ESMTP id i3HGVA4w027749 for <selinux@tycho.nsa.gov>; Sat, 17 Apr 2004 16:31:11 GMT
Received: from rom.cip.ifi.lmu.de (rom.cip.informatik.uni-muenchen.de [141.84.214.183])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id DD26B43620
	for <selinux@tycho.nsa.gov>; Sat, 17 Apr 2004 18:31:09 +0200 (CEST)
Date: Sat, 17 Apr 2004 18:31:09 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: Problems with 2.4.24
Message-ID: <20040417163109.GA11214@rom.cip.ifi.lmu.de>
References: <2A857CE92C11FE40858689CAEC7BED490A439367@E2K2.corp.plusnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <2A857CE92C11FE40858689CAEC7BED490A439367@E2K2.corp.plusnet>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Jaros??aw Nozderko <jaroslaw.nozderko@polkomtel.com.pl> [2004-04-13 18:01]:
> > Did you build and installed the SELinux-patched /sbin/init program?
> > >From the SysVinit package?
> >  
> 
> No, my fault.
 
> > Unfortunately, I don't know of any up-to-date SELinux-patched packages
> > for SuSE.  You might want to ask Thorsten Kukuk.

I have worked on packages for SuSE, they are available from
http://www.cip.ifi.lmu.de/~bleher/selinux/suse/

> 
> OK... Is it possible to boot in permissive mode and then manually 
> switch to enforcing with loading policy or something like this,
>  just for testing ?
> 
> Or is it easier to just use Fedora Core for educational purposes ?

I'd definitely recommend Fedora if you have the choice, because it is
officially supported and SELinux is integrated into the distro.

If you don't want to switch or have to use SuSE, you can use my packages
which should work fine. My current work is on adjusting the policy to
the system (most of the differences are in the boot process). I should
have something ready in two weeks or so; you can also ask me for a
snapshot of my policy, most of the stuff works in my tree, it just needs
more cleanup.

Thomas

-- 
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7
"Work like you don't need the money, love like you've never been hurt
and dance like you do when nobody's watching."


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
