Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3C6dNRb006655
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2004 02:39:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3C6dMmw020209
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2004 06:39:22 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i3C6dL4w020191 for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2004 06:39:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Rogelio Serrano <rogelio@smsglobal.net>
Subject: Re: booting in enforcing mode
Date: Mon, 12 Apr 2004 16:37:57 +1000
Cc: selinux@tycho.nsa.gov
References: <7fd841b7e6c6f8d9ef80c9a1e2f9eb62@debian>
In-Reply-To: <7fd841b7e6c6f8d9ef80c9a1e2f9eb62@debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404121637.57839.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 11 Apr 2004 23:35, Rogelio Serrano <rogelio@smsglobal.net> wrote:
> >> I rewrote mount, syslogd, and klogd to have the bare
> >> minimum priviledges.
> >
> > What did you change?
>
> Im using an lfs derived distro. it uses uClibc.
>
> These are all my own versions of those utilities. useful only
> from boot scripts. mount is just a wrapper around the mount
> syscall. and unmount also a wrapper around the unmount syscall.
> they dont need fstab or /proc/mounts. the original versions are
> causing too much noise in the logs. i was having lot of

Reading a file of type etc_t is not going to do any great harm.  Almost 
everything has read access to such files (think of all the things that break 
if /etc/passwd is not readable).

If I made it a tunable for whether /proc/mounts and /etc/mtab are accessible 
would that satisfy your needs?  I really want to keep everyone on the same 
policy tree as much as possible.  That will allow you to upgrade to newer 
releases of SE Linux with less effort and also allow me to incorporate any 
improvements you make without any difficulty.

> im using busybox for most of the network stuff and logging. in
> enforcing mode i was having a lot of difficulty to run syslogd
> in the proper context.

You might want to read my previous messages on this topic to this list, and 
the paper I presented at OLS 2003 on running SE Linux on an iPaQ.

> i was having difficulty with the busybox 
> code so i ripped out the relevant parts and built my own
> syslogd from that. same for klogd. i then tested these programs
> and took out some code that caused problems.

My conclusion was that doing such things was best.  I think that having 
syslogd and klogd running in different domains provides minimal benefit and 
for a small machine you might want to combine them (the policy supports this 
if you remove klogd.te).

> One area im having a lot irritation with is the hotplug
> scripts. everytime they run bash opens /proc/kmem /dev/random
> /dev/pts /dev/ptmx and countless other devices and files that
> is not even mentioned anywhere in the relevant sources. now i
> dont know which to allow and which to deny. so now im going to
> write small prgrams to replace the scripts.

Shell scripts always require access to more things than they should.  One 
thing you might investigate is using a smaller shell than bash.  Shells with 
less features request less access to the system...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
