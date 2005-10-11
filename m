Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9BH7NNs003349
	for <selinux@tycho.nsa.gov>; Tue, 11 Oct 2005 13:07:24 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9BH5w8n003621
	for <selinux@tycho.nsa.gov>; Tue, 11 Oct 2005 17:05:59 GMT
Date: Tue, 11 Oct 2005 18:05:44 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SELinux@tycho.nsa.gov
Subject: Re: System hang during boot on Debian Sid
Message-ID: <20051011170544.GE8829@lkcl.net>
References: <20051009083426.GA10995@localhost.localdomain> <1129033658.3308.48.camel@moss-spartans.epoch.ncsc.mil> <20051011132002.GA6249@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051011132002.GA6249@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 11, 2005 at 08:20:02PM +0700, Dave Patterson wrote:
> * Stephen Smalley <sds@tycho.nsa.gov> [2005-10-11 08:27:38 -0400]:
> 
> 
> > > and the system hangs.  Any suggestions?
> > 
> > That change was included in the 2.6.13-selinux1.patch and is going to be
> > part of 2.6.14 upstream (already in 2.6.14-rcX, and has been in Fedora
> > rawhide kernels for a while).
> Ah. OK... 
> > I don't know about the state of SELinux in Debian sid, but Russell's
> > message indicated that udev doesn't work well with SELinux in Debian
> > yet.  
> > 
> And I can see why - Debian's initrd is archaic, so I don't use it
> unless I have to, and udev in our distro is indeed grumpy.
> No, the main cause of my problems so far lie in my policy
> configuration at the moment (the boot process was hanging at INIT) -
> Russel's package is the strict policy, and I haven't edited it well
> enough yet.  I'm attempting a prototype multiuser, multilingual
> desktop install using this, and I've banged my shins on a few things so far.

 yes, you will.

 not least of those will be if you use kdm.

 xdm, kdm, gdm, wdm, all seem to derive from the same codebase at some
 point.  they've been hacked about rather badly since, and the
 authorisation code has been shuffled.

 gdm is fairly sorted (because it's the default on FC) but kdm?  naah.

 the last time i mentioned this, i believe it was russell who mentioned
 that there needs to be some work done in creating a modified policy to
 deal with kdm.

 specifically, there is a part of kdm which communicates via a socket to
 the user desktop bit, which allows kde to shut down the system.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
