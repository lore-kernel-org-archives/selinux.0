Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FIaVWt027632
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:36:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FIaUmR018378
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:36:30 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
        by jazzband.ncsc.mil  with ESMTP id h9FIaTjp018374 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:36:29 GMT
Date: Wed, 15 Oct 2003 20:36:29 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: Filesystem problems
Message-ID: <20031015183629.GB5967@suse.de>
References: <1066191058.3f8cc8d257e4c@eaglemail.unt.edu> <20031015072949.GA12602@suse.de> <1066242128.7399.91.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066242128.7399.91.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 15, Stephen Smalley wrote:

> On Wed, 2003-10-15 at 03:29, Thorsten Kukuk wrote:
> > With kernel 2.6.0-test7, I have a lot of ext3 problems with SELinux
> > enabled, which always ends in a filesystem crash and a necessary
> > fsck.ext3 run at the next boot. Don't know if this comes from the
> > usage of extended attributes or if ext3 itself is broken in 2.6.
> 
> Details?  I haven't seen this yet with 2.6.0-test7 and ext3.  Did it
> occur with 2.6.0-test6?

I don't know if it occur with 2.6.0-test6, normally I use reiserfs
or ext2 (with both I have no problems). It is the first time that
I use ext3 with 2.6.0.

If I make a clean shutdown and run a fsck.ext3 -f on the ext3
partition from a rescue system, fsck finds all kind of errors on
this device. Lost blocks, wrong number of blocks, ...
Sometimes grub is not able to read it at all.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
