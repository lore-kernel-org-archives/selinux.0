Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0VGQqRb024961
	for <selinux@tycho.nsa.gov>; Sat, 31 Jan 2004 11:26:52 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0VGPXVK028636
	for <selinux@tycho.nsa.gov>; Sat, 31 Jan 2004 16:25:33 GMT
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by jazzswing.ncsc.mil  with SMTP id i0VGPWlx028633
	for <selinux@tycho.nsa.gov>; Sat, 31 Jan 2004 16:25:32 GMT
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Chris PeBenito <pebenito@gentoo.org>
Subject: Re: Gentoo SELinux LiveCD
Date: Sat, 31 Jan 2004 17:25:51 +0100
References: <1075145644.1235.93.camel@chris.pebenito.net>
In-Reply-To: <1075145644.1235.93.camel@chris.pebenito.net>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200401311725.51250.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Montag, 26. Januar 2004 20:34, Chris PeBenito wrote:
> Announcing the Gentoo SELinux LiveCD
>
> The Hardened Gentoo SELinux team has put out an experimental
> SELinux LiveCD (108MB).  This is primarily meant for Gentoo users
> to install SELinux from scratch, but also it can be used to try
> out SELinux.  I have been able to successfully boot the CD in
> enforcing.  The main requirement is at least a pentium pro
> machine, since it is compiled with -march=i686.  Please keep in
> mind its experimental, and if you find bugs please report them to
> me, or Gentoo bugzilla (bugs.gentoo.org).  The only issue I know
> of is some denials with dhcpcd.

The LiveCD is great - I try it yesterday and it runs fine. 

Do you use a small specific policy? Because I can't change the role 
of root to user_r.
What do you think about adding the policy sources and the command 
line version of the setools? With this the SELinux newbies could 
use your CD to make the first steps on SELinux.

Could it be, that the unmount of loopback filesystem failed? I get 
follow message:
Unmounting loopback filesystems...
Failed to unmount filesystems

I would show your LiveCD as an part of my SELinux workshop in March 
in Chemnitz (a town in saxony), if you don't object.

Greetings

Carsten



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
