Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7O9kurT024807
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 05:46:56 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7O9kAMZ024516
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 09:46:11 GMT
Date: Tue, 24 Aug 2004 10:28:53 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Greg KH <greg@kroah.com>, russell@coker.com.au,
   SE Linux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
Subject: Re: Fedora and udev
Message-ID: <20040824092853.GD25356@lkcl.net>
References: <200408222125.38169.russell@coker.com.au> <4128B637.8040900@tresys.com> <20040822173457.GD13842@lkcl.net> <20040823224444.GI4694@kroah.com> <412A74A6.9070206@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <412A74A6.9070206@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 23, 2004 at 06:50:14PM -0400, Joshua Brindle wrote:

> Greg KH wrote:
> 
> >Please fix that patch up to:
> >	- not have any ifdef in the .c files
> >	- use the proper coding style
> >	- use the same convention as the other build flags have.
> >
> >Actually, what was wrong with the older selinux support in udev that was
> >there?  Why not just dig that stuff up and see if it works or not (I bet
> >it does...)  If so, I'll be glad to add it back in, it's just that too
> >many people complained about it when it was in there...
> > 
> >
> Who complained and why? When selinux support wasn't built in the 
> functions were just stubs, how could that have possibly had any effect 
> whatsoever on anyone else?

 there was a bugreport on debian.org complaining about the d-bus support
 which took ONE SECOND per inode created (most probably due to poor
 design of d-bus, e.g. not having a prefork'd server like apache does)

 due to the multi-exe design of udev (udevd, udev, udevsend) it is quite
 difficult to maintain persistent network or socket connections such
 that both d-bus and libselinux1 "cacheing" can be taken advantage of.

 [libselinux1 does cacheing of file context lookups - this can only
  be taken advantage of IF you use a single process, of course - and
  udevsend is only given ONE device name to create, and then it exits]

 consequently, d-bus support was ripped out and disabled.

 and it looks like the selinux support, which wasn't very good anyway,
 was also removed and turned into a script that ran "restorecon"
 post-inode creation, see /etc/udev.d/default/selinux.


> If you could, please paste a patch from the older version so that we can 
> see here whether it should work right (it's possible that the libselinux 
> api changed between then and now)
 
 udev-0.024 was the last version containing selinux support, i had to
 track it down.

 iirc:
 
 1) it used setfilecon() not setfscreatecon().

 2) it ONLY set the permissions on the inode NOT on any symlinks and NOT
    on any directories or subdirectories created.


 the patch i created is at least an attempt to GetThingsWorking(tm).

 if time REALLY IS a major concern:

 what _should_ be done is that udev (or udevd) should be patched to
 popen("setfiles -q -s", "w") and then when each device inode is
 created (and a udevsend is exec'd to do it), the filename of the
 device inode is ALSO sent down the pipe to setfiles.

 i say should, what i mean is, this is the most non-nasty solution
 with the tools and options presently available.

 if the file_contexts stuff was somehow pre-munged and
 transferred into kernel, and the regexp matching code (or
 something similar) was _also_ transferred into the kernel,
 then this problem would go away.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
