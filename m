Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA20248
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2001 15:24:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA21659
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2001 19:24:11 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id TAA21655
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2001 19:24:10 GMT
Date: Wed, 24 Oct 2001 15:23:55 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "White, Tom (AZ15)" <tom.white@honeywell.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Problems with install
In-Reply-To: <4B2A46240C7CD311830C0090279C31E301D77363@az15m09.iac.honeywell.com>
Message-ID: <Pine.GSO.4.33.0110241516450.10838-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 24 Oct 2001, White, Tom (AZ15) wrote:

> I am trying to implement the SELinux patch on a Red Hat 7.1 box. I did the
> Kernel build following the documentation on the NSA web site.  I got to step
> 2 in the INSTALLING section and when I do a make install in the module
> directory I get the following output:

Which release of SELinux are you using, and which download option did you
use?

> [root@warthog module]# make install
> rm -f selinux_plug/include/asm selinux_plug/arch/machine
> ( cd selinux_plug/include ; ln -sf asm-i386 asm)
> ( cd selinux_plug/arch ; ln -sf i386 machine)

Based on this output, it looks like you are using an older release.
As of the most recent release, the creation of the architecture symbolic
links was moved into the selinux_plug Makefiles.  In any event, this
should have happened during the kernel build, so something is wrong here.

> cd ../../lsm/include/asm; install unistd.h /usr/local/selinux/include/asm
> cd selinux_plug/ss; install checkpolicy /usr/local/selinux/bin
> install: cannot stat `checkpolicy': No such file or directory
> make: *** [install] Error 1

The checkpolicy program should have been compiled during the kernel build.
Again, this suggests that your kernel build didn't really succeed.  Did
you enable SELinux in the kernel configuration?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
