Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBMEhfRb022049
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 09:43:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBMEghjx028413
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 14:42:43 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id hBMEghSR028410
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 14:42:43 GMT
Subject: [patch] linux-2.4 Ext2/3 compatibility problem with EAs on symlinks
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
   SE Linux <selinux@tycho.nsa.gov>, ACL devel list <acl-devel@bestbits.at>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
   Stephen Tweedie <sct@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>,
   Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Content-Type: multipart/mixed; boundary="=-UiS1Ied3ufhI5OSOI9my"
Message-Id: <1072104195.1967.49.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 22 Dec 2003 14:43:17 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-UiS1Ied3ufhI5OSOI9my
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all, 

I found why people running SELinux on 2.6 were having trouble booting
again on 2.4 kernels, and it's nothing to do with SELinux per-se.  It's
a compatibility problem with extended attributes.  

The trouble is that setting an EA on a fast symlink upsets the kernel's
symlink detection code.  Older kernels will see a symlink with non-zero
i_blocks, and will assume that the symlink is a slow one --- ie. that
the first direct block of the inode points to the symlink contents ---
and will end up doing a block lookup from what is in fact the first four
ascii chars from the symlink path.

2.6 kernels deal with this by detecting a non-zero i_file_acl field and
subtracting the EA's blocks from i_blocks before checking if the block
count is zero.  The patch below adds the same compatibility code to
2.4.  Booting a SELinux partition results in immediate death via access
beyond end-of-device as soon as the kernel tries to dereference /bin/sh
(a symlink to /bin/bash on this box); with the fix, it's fine.

Any kernel built with EA patches will be immune to this, even if the EA
config is not set.  So, 2.6 is simply not vulnerable.

There are a couple of questions left over.  First, should we be adding a
compatibility flag so that mounting filesystems with EAs on symlinks is
rejected on older kernels?  Secondly, there's the problem of getting EA
refcounts out-of-sync if you delete an inode with EAs on an older,
non-EA-aware kernel.  Even with the fix, the old kernel will still fail
to update the refcount on the EA block so we'd need a fsck to fix things
up; setting a readonly compatibility bit when EAs are present would
avoid that, but it's not clear whether the underlying problem is bad
enough to justify the hit in usability.

Cheers,
 Stephen


--=-UiS1Ied3ufhI5OSOI9my
Content-Disposition: inline; filename=4208-ext23-symlink-ea-compat.patch
Content-Type: text/plain; name=4208-ext23-symlink-ea-compat.patch; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D fs/ext3/inode.c 1.16 vs edited =3D=3D=3D=3D=3D
--- linux-2.4-tmp/fs/ext2/inode.c.=3DK0000=3D.orig
+++ linux-2.4-tmp/fs/ext2/inode.c
@@ -35,6 +35,17 @@ MODULE_AUTHOR("Remy Card and others");
 MODULE_DESCRIPTION("Second Extended Filesystem");
 MODULE_LICENSE("GPL");
=20
+/*
+ * Test whether an inode is a fast symlink.
+ */
+static inline int ext2_inode_is_fast_symlink(struct inode *inode)
+{
+	int ea_blocks =3D inode->u.ext2_i.i_file_acl ?
+		(inode->i_sb->s_blocksize >> 9) : 0;
+
+	return (S_ISLNK(inode->i_mode) &&
+		inode->i_blocks - ea_blocks =3D=3D 0);
+}
=20
 static int ext2_update_inode(struct inode * inode, int do_sync);
=20
@@ -801,6 +812,8 @@ void ext2_truncate (struct inode * inode
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode)))
 		return;
+	if (ext2_inode_is_fast_symlink(inode))
+		return;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
=20
@@ -1001,7 +1014,7 @@ void ext2_read_inode (struct inode * ino
 		inode->i_fop =3D &ext2_dir_operations;
 		inode->i_mapping->a_ops =3D &ext2_aops;
 	} else if (S_ISLNK(inode->i_mode)) {
-		if (!inode->i_blocks)
+		if (ext2_inode_is_fast_symlink(inode))
 			inode->i_op =3D &ext2_fast_symlink_inode_operations;
 		else {
 			inode->i_op =3D &page_symlink_inode_operations;
--- linux-2.4-tmp/fs/ext3/inode.c.=3DK0000=3D.orig
+++ linux-2.4-tmp/fs/ext3/inode.c
@@ -39,6 +39,18 @@
  */
 #undef SEARCH_FROM_ZERO
=20
+/*
+ * Test whether an inode is a fast symlink.
+ */
+static inline int ext3_inode_is_fast_symlink(struct inode *inode)
+{
+	int ea_blocks =3D EXT3_I(inode)->i_file_acl ?
+		(inode->i_sb->s_blocksize >> 9) : 0;
+
+	return (S_ISLNK(inode->i_mode) &&
+		inode->i_blocks - ea_blocks =3D=3D 0);
+}
+
 /* The ext3 forget function must perform a revoke if we are freeing data
  * which has been journaled.  Metadata (eg. indirect blocks) must be
  * revoked in all cases.=20
@@ -1870,6 +1882,8 @@ void ext3_truncate(struct inode * inode)
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode)))
 		return;
+	if (ext3_inode_is_fast_symlink(inode))
+		return;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
=20
@@ -2170,7 +2184,7 @@ void ext3_read_inode(struct inode * inod
 		inode->i_op =3D &ext3_dir_inode_operations;
 		inode->i_fop =3D &ext3_dir_operations;
 	} else if (S_ISLNK(inode->i_mode)) {
-		if (!inode->i_blocks)
+		if (ext3_inode_is_fast_symlink(inode))
 			inode->i_op =3D &ext3_fast_symlink_inode_operations;
 		else {
 			inode->i_op =3D &page_symlink_inode_operations;

--=-UiS1Ied3ufhI5OSOI9my--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
