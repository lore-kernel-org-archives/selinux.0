Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5A1HKgA015286
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 21:17:20 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5A19npU007478
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 01:09:49 GMT
Subject: Re: http://www.golden-gryphon.com/software/security/selinux.xhtml
From: antoine <antoine@nagafix.co.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>, debian-devel@lists.debian.org,
   Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>
In-Reply-To: <20050609232031.GU8525@lkcl.net>
References: <20050609192026.GM8525@lkcl.net>
	 <1118356920.10190.175.camel@localhost>  <20050609232031.GU8525@lkcl.net>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 02:21:36 +0100
Message-Id: <1118366496.10190.239.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>  i was under the impression, from the above, that somehow
>  debian cannot run selinux/uml.
I haven't tried selinux on my debian uml instances.

>  i was therefore recommending an alternative that is, by
>  comparison, just... okay: xen takes a source code download,
>  two kernel compiles, create a guest-machine-config, and
>  a guest-machine-install (unless like me you're prepared to
>  copy the drive images of an existing machine and hack it into
>  submission from there :) and you're done, up, running.
> 
>  by contrast: i once installed uml...
Example with Gentoo-SELinux:
* make a Gentoo SELinux filesystem (loopback mounted + chroot)
 and add /dev/ubd devices (uml block devices) adjust fstab and inittab
* build a kernel (make ARCH=um vmlinux)
* run it:
 ./vmlinux mem=512 ubd0=./root_fs root=/dev/ubda selinux=1 enforcing=0
* selinux relabel
(optional: reboot guest in enforcing mode, add skas to host, etc)

It cannot be easier than this, can it?

>  in theory, it can be done (and i haven't been mad enough to switch on
>  selinux in the xen master domain yet...)
It is the most critical system to secure: One ring to rule them all...

>  management of xen (communication between domains) is done
>  via a python-based HTTP web server (twisted python) running on a high
>  port number.
I'm not here to have a go at xen/python (or start a holy war) but I
prefer the way uml is managed: like a normal process, which means you
can apply normal tools to control it (ie: selinux if you want to). Any
linux system can run uml instances without a single reboot (albeit
without skas). On the other hand, uml is linux only, xen virtualises the
whole system and has some nice features (live migration particularly)

> the above URL gives an impression other than that.
When it comes to performance benchmarks (that's part of my job) it is
very difficult to compare accurately unless you know all the products
very well. If you are referring to this benchmark:
http://www.cl.cam.ac.uk/Research/SRG/netos/xen/performance.html
* It uses kernel 2.4.22 which is *very* old.
* I/O is the main difference but it does not mention what method was
used for the filesystems backing store. There are many tricks that can
drastically improve performance if you know what you are doing (even for
VMWare). Xen generally uses raw disks whereas uml generally uses files
as disk images, this overhead alone will create a huge difference in
performance. I believe Xen can probably achieve better I/O performance
than uml, but not by the margins shown above.
* It was authored by people working on Xen, I am not trying to discredit
the results in any way, just pointing out that they clearly knew Xen
better than the others...

Now, don't get me started on database performance...

Cheers
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
