Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FId6Wt027663
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:39:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FId5mR018536
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:39:05 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9FId5jp018533 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:39:05 GMT
Subject: Re: Filesystem problems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031015183629.GB5967@suse.de>
References: <1066191058.3f8cc8d257e4c@eaglemail.unt.edu>
	 <20031015072949.GA12602@suse.de>
	 <1066242128.7399.91.camel@moss-spartans.epoch.ncsc.mil>
	 <20031015183629.GB5967@suse.de>
Content-Type: text/plain
Message-Id: <1066243143.7399.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Oct 2003 14:39:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-15 at 14:36, Thorsten Kukuk wrote:
> If I make a clean shutdown and run a fsck.ext3 -f on the ext3
> partition from a rescue system, fsck finds all kind of errors on
> this device. Lost blocks, wrong number of blocks, ...
> Sometimes grub is not able to read it at all.

What version of fsck?  There were issues with the EA support in older
versions of fsck, IIRC.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
