Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OE7NrT026614
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 10:07:23 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OE6bMZ007622
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 14:06:37 GMT
Date: Tue, 24 Aug 2004 15:18:28 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Joshua Brindle <jbrindle@tresys.com>, Greg KH <greg@kroah.com>,
   SE Linux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
Subject: Re: Fedora and udev
Message-ID: <20040824141828.GA4698@lkcl.net>
References: <200408222125.38169.russell@coker.com.au> <412A74A6.9070206@tresys.com> <20040824092853.GD25356@lkcl.net> <200408242006.41591.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408242006.41591.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 24, 2004 at 08:06:41PM +1000, Russell Coker wrote:
> On Tue, 24 Aug 2004 19:28, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> >  2) it ONLY set the permissions on the inode NOT on any symlinks and NOT
> >     on any directories or subdirectories created.
> 
> This part is OK.  We have moved to using device_t (the default) as the context 
> for all directories and sym-links under /dev.
 
 great, then the policy modifications i've made will be of some
 value in pointing you in the right direction, i'll endeavour to
 clean them up, sort them out [dammit i just did that and ended
 up accidentally deleting it, i _must_ try to stop the habit of
 reusing filenames f g h x y and z]

 i'm attaching also my modified /etc/init.d/udev file.

 as you can see it calls /sbin/restoredevicefiles (sent earlier)
 after the make_extra_nodes() call has been made.

 why?  because it is necessary to do a restorecon on every item
 created in /dev, and this is _before_ udev is running, and it is
 _to_ get udev running!

 i mean, sure, it's fine to grant udev permission to do stuff to
 device_t:file/directory instead (or as well?) such that it can
 "get started" and then "replace" or "re-restore" permissions on
 entries listed in /etc/udev/links.conf, that's another approach
 i imagine could be taken.


> >  if the file_contexts stuff was somehow pre-munged and
> >  transferred into kernel, and the regexp matching code (or
> >  something similar) was _also_ transferred into the kernel,
> >  then this problem would go away.
> 
> I think it's already been decided not to do that.

 oh.  right.  ah well.  Next :)

 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
