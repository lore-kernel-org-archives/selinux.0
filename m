Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA21553
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2001 20:09:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA00932
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 00:07:03 GMT
Received: from localhost.localdomain (fdslppp21.dnvr.uswest.net [63.225.20.21])
	by jazzswing.ncsc.mil  with ESMTP id AAA00928
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 00:07:02 GMT
Date: Wed, 24 Oct 2001 17:51:54 -0600 (MDT)
From: Dave Nielsen <dave@technogeeks.com>
cc: "White, Tom (AZ15)" <tom.white@honeywell.com>, <selinux@tycho.nsa.gov>
Subject: Re: Problems with install
In-Reply-To: <Pine.GSO.4.33.0110241516450.10838-100000@raven>
Message-ID: <Pine.LNX.4.33.0110241746530.1787-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Wed, 24 Oct 2001, Stephen Smalley wrote:

=>
=>On Wed, 24 Oct 2001, White, Tom (AZ15) wrote:
=>
=>> I am trying to implement the SELinux patch on a Red Hat 7.1 box. I did the
=>> Kernel build following the documentation on the NSA web site.  I got to step
=>> 2 in the INSTALLING section and when I do a make install in the module
=>> directory I get the following output:
=>
=>Which release of SELinux are you using, and which download option did you
=>use?
=>
my guess is he is trying one that was before the 2.4.10 release.

=>> [root@warthog module]# make install
=>> rm -f selinux_plug/include/asm selinux_plug/arch/machine
=>> ( cd selinux_plug/include ; ln -sf asm-i386 asm)
=>> ( cd selinux_plug/arch ; ln -sf i386 machine)
=>
=>Based on this output, it looks like you are using an older release.
=>As of the most recent release, the creation of the architecture symbolic
=>links was moved into the selinux_plug Makefiles.  In any event, this
=>should have happened during the kernel build, so something is wrong here.

The out put looks like Pre 2.4.10 package. I Had these issues with both
options on the pre 2.4.10.

I would like to say I have a fix for you besides downloading the 2.4.10 or
better yet the newest one that is out right now. I had the problem and
then the next day 2.4.10 was release.

=>
=>> cd ../../lsm/include/asm; install unistd.h /usr/local/selinux/include/asm
=>> cd selinux_plug/ss; install checkpolicy /usr/local/selinux/bin
=>> install: cannot stat `checkpolicy': No such file or directory
=>> make: *** [install] Error 1
=>
=>The checkpolicy program should have been compiled during the kernel build.
=>Again, this suggests that your kernel build didn't really succeed.  Did
=>you enable SELinux in the kernel configuration?
=>

Dave


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
