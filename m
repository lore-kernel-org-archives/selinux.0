Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14JMwRb014027
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 14:22:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i14JLJVK025846
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 19:21:19 GMT
Received: from Woody.fw.matav.hu ([145.236.241.98])
	by jazzswing.ncsc.mil  with ESMTP id i14JLHlx025794
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 19:21:18 GMT
Date: Wed, 4 Feb 2004 19:11:42 +0000
From: =?iso-8859-2?B?TWFnb3PhbnlpIMFycOFk?= <mag@bunuel.tii.matav.hu>
To: "Stephen C. Tweedie" <sct@redhat.com>, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Russell Coker <russell@coker.com.au>, Andreas Gruenbacher <agruen@suse.de>,
   SE Linux <selinux@tycho.nsa.gov>, ACL devel list <acl-devel@bestbits.at>,
   "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: FS crash
Message-ID: <20040204191142.GA11886@bunuel.tii.matav.hu>
References: <1074008995.7158.18.camel@kusturica> <200401142317.18958.russell@coker.com.au> <1075866064.19815.57.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1075866064.19815.57.camel@sisko.scot.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

Related to this same fs crash Theodore Y. Ts'o have found
some endiannes problems in e2fslibs code. But I cannot
get silo to use any symlinks, despite that I have recompiled
it with the patched e2fslibs.

Can it be due to this xattr bug?

Thank you all for your marvellous help.

A levelezõm azt hiszi, hogy Stephen C. Tweedie a következõeket írta:

> Found it --- there's a bug in the xattr code.  And yes, apart from the
> disk space leak, it's harmless --- *except* on symlinks.
> 
> When you have an EA block that is shared between multiple inodes; AND
> you then change an attribute in that on one inode, AND the new attribute
> value is the same as the old, then xattr computes the new EA block,
> finds it still in the cache, bumps the reference count on it (and the
> i_blocks field on the inode, incidentally), and leaves it incremented
> because we haven't changed EA block so there's no need to drop the
> refcount on the old block.
> 
> So *every* time you have more than one inode sharing an EA block and you
> perform an identical write to an EA, you get a leak on both i_blocks and
> the EA refcount.
> 
> This is a big problem for symlinks, which rely on correct i_blocks
> accounting to determine the difference between fast and slow symlinks. 
> With the leak, you end up thinking that a fast symlink (ie. one small
> enough to be stored in the inode direct blocks) is slow, so you
> dereference the ascii contents of the symlink as if they were a disk
> block address.  That typically results in EIO all over the place.
> 
> The fix is really simple: just test for (old_bh != new_bh) before
> incrementing the refcounts.  The patch below is for ext3, but ext2 needs
> the same fix.

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
