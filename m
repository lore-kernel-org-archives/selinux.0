Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14FS1Rb012445
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 10:28:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i14FQdVK006451
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 15:26:39 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i14FQQlx006433
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 15:26:38 GMT
Subject: [patch] Fix block device inode list corruptions
From: "Stephen C. Tweedie" <sct@redhat.com>
To: SE Linux <selinux@tycho.nsa.gov>,
   linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Stephen Tweedie <sct@redhat.com>, Alexander Viro <aviro@redhat.com>
Content-Type: multipart/mixed; boundary="=-1GDsjsoyCsrEqlF1QLMW"
Message-Id: <1075908464.1998.189.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 04 Feb 2004 15:27:44 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1GDsjsoyCsrEqlF1QLMW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I've been chasing a weird SELinux bug which shows up mostly when doing
installs of a dev-* rpm (ie. creating and overwriting lots of block
device inodes), but which I've also seen when doing mkinitrd.

It turned out not to be an SELinux problem at all, but a core VFS
S_ISBLK bug.  It seems that SELinux simply widens the race window.

The code at fault is fs/fs-writeback.c:__mark_inode_dirty():

		/*
		 * Only add valid (hashed) inodes to the superblock's
		 * dirty list.  Add blockdev inodes as well.
		 */
		if (!S_ISBLK(inode->i_mode)) {
			if (hlist_unhashed(&inode->i_hash))
				goto out;
			if (inode->i_state & (I_FREEING|I_CLEAR))
				goto out;
		}

The "I_FREEING|I_CLEAR" condition was added after the ISBLK/unhashed
tests were already in the source, but I can't see any reason why we'd
want the I_FREEING test not to apply to block devices.  And indeed, this
results in all sorts of inode list corruptions.  Simply moving the
I_FREEING|I_CLEAR test out of the protection of the S_ISBLK() condition
fixes things entirely.  

The exiting 2.6 kernel will reliably fail on me in about 2 seconds once
"rpm -Uvh --force dev*.rpm" starts its actual installation of the new
inodes.  With the patch below I can't reproduce it at all.

--Stephen






--=-1GDsjsoyCsrEqlF1QLMW
Content-Disposition: inline; filename=vfs-blkdev-list.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=vfs-blkdev-list.patch; charset=ISO-8859-15

--- linux-2.6.1/fs/fs-writeback.c.=3DK0001=3D.orig
+++ linux-2.6.1/fs/fs-writeback.c
@@ -87,12 +87,11 @@ void __mark_inode_dirty(struct inode *in
 		 * Only add valid (hashed) inodes to the superblock's
 		 * dirty list.  Add blockdev inodes as well.
 		 */
-		if (!S_ISBLK(inode->i_mode)) {
+		if (!S_ISBLK(inode->i_mode))
 			if (hlist_unhashed(&inode->i_hash))
 				goto out;
-			if (inode->i_state & (I_FREEING|I_CLEAR))
-				goto out;
-		}
+		if (inode->i_state & (I_FREEING|I_CLEAR))
+			goto out;
=20
 		/*
 		 * If the inode was already on s_dirty or s_io, don't

--=-1GDsjsoyCsrEqlF1QLMW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
