Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9GFL9Wt003471
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 11:21:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9GFL8mR000793
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 15:21:08 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9GFL6jp000784 for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 15:21:07 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: genfscon and /boot
Date: Fri, 17 Oct 2003 01:21:03 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310162109.25021.russell@coker.com.au> <200310170050.30444.russell@coker.com.au> <1066316470.25279.10.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066316470.25279.10.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310170121.03791.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 17 Oct 2003 01:01, Stephen Smalley wrote:
> On Thu, 2003-10-16 at 10:50, Russell Coker wrote:
> > OK.  Then how about an option to label all of /boot as boot_t?  There can
> > be no confusion when all of a file system has the same label, and being
> > overly restrictive should not be a problem.
>
> And we distinguish /boot from any other ext2 filesystem in what manner?

Yes, that is a problem.  However the number of other ext2 file systems is 
quite small.  The only ext2 file systems that I use are for /boot and for 
some old CDs (of course labeling CDs as boot_t would be annoying too).

Of course this can't be the default, but making it a readily accessible option 
seems to add value IMHO.

> Exactly what is broken by having xattrs on /boot?  Why does this
> interfere with the ability of old boot loaders to access /boot?

The kernel bug which prevents a 2.4 kernel without the XATTR patches from 
mounting a file system which has XATTRs affects all the boot loaders that are 
based on 2.4 kernel code.  AFAIK no-one is using a 2.6 kernel for a boot 
loader and Cobalt may be the first organization to apply XATTR patches to 
their 2.4 kernel based boot loader to fix this issue.

Given time all the boot loaders will be based on 2.6 kernels or newer 2.4 
kernels with this bug fixed.  In the mean time it is nice to be able to work 
around this.  For my personal use I have the choice between implementing this 
work-around, discarding two perfectly good servers, or waiting for Sun to 
release the new ROM.  I imagine that others will face a similar situation, 
and they may not have the same abilities to implement work-arounds and 
convince vendors to update their code as I do.

But I agree that this is a difficult issue, and I am not committed to getting 
it changed.

Finally the current plans (as I am aware of them) for Red Hat include having 
ext2 drivers compiled into the kernel without XATTR support for the initrd.  
Unless these plans are changed (which is another matter we should discuss 
now) then we will have some issues related to unlabeled ext2 file systems.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
