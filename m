Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FIMCWt027490
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:22:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FIMBmR017259
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:22:11 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9FIMAjp017256 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:22:10 GMT
Subject: Re: Filesystem problems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031015072949.GA12602@suse.de>
References: <1066191058.3f8cc8d257e4c@eaglemail.unt.edu>
	 <20031015072949.GA12602@suse.de>
Content-Type: text/plain
Message-Id: <1066242128.7399.91.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Oct 2003 14:22:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-15 at 03:29, Thorsten Kukuk wrote:
> With kernel 2.6.0-test7, I have a lot of ext3 problems with SELinux
> enabled, which always ends in a filesystem crash and a necessary
> fsck.ext3 run at the next boot. Don't know if this comes from the
> usage of extended attributes or if ext3 itself is broken in 2.6.

Details?  I haven't seen this yet with 2.6.0-test7 and ext3.  Did it
occur with 2.6.0-test6?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
