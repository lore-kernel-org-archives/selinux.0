Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8SLhArT011318
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 17:43:11 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8SLg8uK012274
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 21:42:08 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id D80F1BF7E
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 22:43:03 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CCPvO-0001eS-Dm
	for selinux@tycho.nsa.gov; Tue, 28 Sep 2004 22:54:18 +0100
Date: Tue, 28 Sep 2004 22:54:18 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: fuse and selinux
Message-ID: <20040928215418.GA6287@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ah ha!  a week ago i asked on the list if there was anything "special"
that i might have to do in order to get fuse to work with selinux.

1) add xattrs (done)
2) write an selinux policy for fusexmp (doing)
3) add a type for "fuse" to fs_use....

it was 3) that i was conceptually missing... and having
added "fs_use_xattr fuse system_u:object_r:fs_t" to fs_use,
i now find that i get:

SELinux: (dev fuse, type fuse) getxattr errno 512

... what's _that_ all about?

btw if i don't do this, i end up with the root of the fuse
filesystem being marked unlabeled_t [and i cannot set it either,
due to the way that the fuse kernel module locks out all other
users, it even locks out _root_ from accessing a mount point]

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
