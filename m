Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7MHNerT013833
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 13:23:41 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7MHNdV1009881
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 17:23:40 GMT
Date: Sun, 22 Aug 2004 18:34:57 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: russell@coker.com.au, SE Linux <selinux@tycho.nsa.gov>,
   fedora-selinux-list@redhat.com, gregkh@gentoo.org
Subject: Re: Fedora and udev
Message-ID: <20040822173457.GD13842@lkcl.net>
References: <200408222125.38169.russell@coker.com.au> <4128B637.8040900@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4128B637.8040900@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 22, 2004 at 11:05:27AM -0400, Joshua Brindle wrote:
> I posted a patch here that pebenito did a while back for ramfs and lkcl 
> also did one for tmpfs (which may be better for /dev since it's swappable)
> both are mostly cut and paste jobs but they add the necessary support.
> 
> I'd like to reiterate though, that udev support for selinux is *broken*! 
> if the correct policy isn't in place you will cause race conditions
 
 udev is so completely full of race conditions - known to the
 developers even _without_ selinux - that the general consensus
 seems to be that a few more really won't hurt.

 plus, i patched udev (0.030) to add in proper support for selinux
 (attached previously in first response to russell's post).

 that patch ensures (without saving any extra time) that the device
 inodes created, and any directories, _and_ any symlinks (which the
 /etc/udev/default/selinux thing most definitely didn't do) all use
 setfscreatecon rather than doing a restorecon-or-equiv.


 without this patch you will most likely come across issues or end
 up developing an incorrect policy (that ended up with a mismatch
 of default permissions from file_contexts for subdirectories and
 symlinks).

 
 joshua, when you used ramfs, can you remember what the
 fscontext was for /dev when it was mounted?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
