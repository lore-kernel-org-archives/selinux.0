Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9JAaHWt016132
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 06:36:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9JAa60p026923
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 10:36:06 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h9JAa6r7026920
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 10:36:06 GMT
Date: Sun, 19 Oct 2003 11:36:15 +0100
From: Dale Amon <amon@vnl.com>
To: selinux@tycho.nsa.gov
Subject: File labeling in a chrooted loopback
Message-ID: <20031019103615.GB11679@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just a question to save me lots of time in case it
is a bad idea...

I'm building bootable images (well the root partition
at least) into a loopback file and I'd like to set up
the labeling in the loopback so I can just rsync the
whole thing onto a target real partition. Does this
seem feasible to do, assuming the build system has
xattr's but is not running selinux enabled? I mostly
want to confirm what I believe will be the case:

1) The labeling will work properly and not leak out
   and clobber the real file system outside  the chroot.
2) After rsyncing the target file will still contain
   the xattr data.

Hmmm. I see a problem there. I'll bet rsync doesn't
preserve it so I may be forced to dd instead. Bummer.

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
