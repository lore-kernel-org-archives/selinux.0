Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8E6pxLa005546
	for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2003 02:52:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8E6pwmw020673
	for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2003 06:51:59 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8E6pu9d020664 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2003 06:51:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: trelane@digitasaru.net, selinux@tycho.nsa.gov
Subject: Re: New Potential Research Area for SELinux
Date: Sun, 14 Sep 2003 16:51:42 +1000
References: <20030914043007.GD5651@digitasaru.net>
In-Reply-To: <20030914043007.GD5651@digitasaru.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309141651.42416.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 14 Sep 2003 14:30, Joseph Pingenot wrote:
> While this is already done to an extent in some systems (e.g. Gentoo's
>   portage system can "sandbox"), usually through a special kernel code
>   and/or playing with dynamic linking (e.g. making programs load special
>   libraris), to my knowledge.  The problem with playing with dynamic
> linking is apparent if you consider sandboxing statically linked
> applications. The problem with special kernel code is that you have to play

My SE Linux policy for chroot environments does most of what you would desire 
in this regard.

> system.  A much faster solution would be to create a virtual machine type
> system, like VMWare.  My knowlege in this area is quite hazy, but it is my
> understanding that the Linux kernel has hooks to allow a process to act as
> a virtual machine if the underlying hardware allows, and that interrupts
> and traps can then be, well, trapped and redirected or modified. This would
> be much faster than complete emulation, at the cost of extra work to ensure
> the security of the system.

You should probably investigate UML, see:
http://sourceforge.net/projects/user-mode-linux/

> Hope I'm not too far off my rocker; I think this would be an excellent
>   system for running untrusted code (or even "trusted" code. ;)  Examples
>   which immediately come to mind are executable email attachments and
>   networked collaboration/p2p environments (part of my netshard project,

Regular SE Linux functionality should be enough for such things IMHO.  Why do 
you think you need more than a separate domain for such untrusted code?

The biggest problem we have at the moment (IMHO) is that Security Enhanced X 
isn't implemented yet.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
