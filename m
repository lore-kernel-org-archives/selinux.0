Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i143g7Rb009872
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 22:42:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i143efVK004185
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 03:40:41 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i143eflx004182
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 03:40:41 GMT
Subject: Re: FS crash
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Russell Coker <russell@coker.com.au>, Andreas Gruenbacher <agruen@suse.de>
Cc: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
   SE Linux <selinux@tycho.nsa.gov>, ACL devel list <acl-devel@bestbits.at>,
   "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
In-Reply-To: <200401142317.18958.russell@coker.com.au>
References: <1074008995.7158.18.camel@kusturica>
	 <200401142317.18958.russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-O0nA17TT/7hj6s6txPPR"
Message-Id: <1075866064.19815.57.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 04 Feb 2004 03:41:04 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-O0nA17TT/7hj6s6txPPR
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2004-01-14 at 12:17, Russell Coker wrote:
> On Wed, 14 Jan 2004 02:49, Magos=E1nyi =C1rp=E1d <mag@bunuel.tii.matav.hu=
> wrote:
> > Pass 1: Checking inodes, blocks, and sizes
> > Extended attribute block 246069 has reference count 1020, should be
> > 1018.  Fix<y>? yes
>=20
> I've seen this many times on i386 machines.  So far no problems have occu=
rred,=20
> so I conclude that it's moderately harmless.

Found it --- there's a bug in the xattr code.  And yes, apart from the
disk space leak, it's harmless --- *except* on symlinks.

When you have an EA block that is shared between multiple inodes; AND
you then change an attribute in that on one inode, AND the new attribute
value is the same as the old, then xattr computes the new EA block,
finds it still in the cache, bumps the reference count on it (and the
i_blocks field on the inode, incidentally), and leaves it incremented
because we haven't changed EA block so there's no need to drop the
refcount on the old block.

So *every* time you have more than one inode sharing an EA block and you
perform an identical write to an EA, you get a leak on both i_blocks and
the EA refcount.

This is a big problem for symlinks, which rely on correct i_blocks
accounting to determine the difference between fast and slow symlinks.=20
With the leak, you end up thinking that a fast symlink (ie. one small
enough to be stored in the inode direct blocks) is slow, so you
dereference the ascii contents of the symlink as if they were a disk
block address.  That typically results in EIO all over the place.

The fix is really simple: just test for (old_bh !=3D new_bh) before
incrementing the refcounts.  The patch below is for ext3, but ext2 needs
the same fix.

Cheers,
 Stephen



--=-O0nA17TT/7hj6s6txPPR
Content-Disposition: inline; filename=ext3-xattr-refcnt.patch
Content-Type: text/plain; name=ext3-xattr-refcnt.patch; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.1/fs/ext3/xattr.c.~1~	2004-01-09 06:59:44.000000000 +0000
+++ linux-2.6.1/fs/ext3/xattr.c	2004-02-04 01:04:22.000000000 +0000
@@ -763,15 +763,17 @@
 				(unsigned long) new_bh->b_blocknr);
=20
 			error =3D -EDQUOT;
-			if (DQUOT_ALLOC_BLOCK(inode, 1)) {
-				unlock_buffer(new_bh);
-				journal_release_buffer(handle, new_bh, credits);
-				goto cleanup;
+			if (new_bh !=3D old_bh) {
+				if (DQUOT_ALLOC_BLOCK(inode, 1)) {
+					unlock_buffer(new_bh);
+					journal_release_buffer(handle, new_bh, credits);
+					goto cleanup;
+				}
+				HDR(new_bh)->h_refcount =3D cpu_to_le32(
+					le32_to_cpu(HDR(new_bh)->h_refcount) + 1);
+				ea_bdebug(new_bh, "refcount now=3D%d",
+					  le32_to_cpu(HDR(new_bh)->h_refcount));
 			}
-			HDR(new_bh)->h_refcount =3D cpu_to_le32(
-				le32_to_cpu(HDR(new_bh)->h_refcount) + 1);
-			ea_bdebug(new_bh, "refcount now=3D%d",
-				le32_to_cpu(HDR(new_bh)->h_refcount));
 			unlock_buffer(new_bh);
 		} else if (old_bh && header =3D=3D HDR(old_bh)) {
 			/* Keep this block. No need to lock the block as we

--=-O0nA17TT/7hj6s6txPPR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
