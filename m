Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5DJoSgA009163
	for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2005 15:50:28 -0400 (EDT)
Subject: Re: [PATCH] devpts xattr support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>,
   Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
In-Reply-To: <Xine.LNX.4.44.0410271428590.10702-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0410271428590.10702-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 15:32:41 -0400
Message-Id: <1118691161.24565.147.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-10-27 at 14:31 -0400, James Morris wrote:
> On Wed, 27 Oct 2004, Darrel Goeddel wrote:
> 
> > I'm all for that.  I will play around with a few ideas and see if I can 
> > come with anything useful.  I'm thinking along the lines of the 
> > permission call which uses i_op->permission if it exists and falls back 
> > to vfs_permission if it does not.  Maybe we can create a fallback for 
> > *xattr...
> 
> Yes, it seems logical that we could have a generic fallback in the VFS
> code for getxattr and listxattr, although I guess this would have been
> considered before and rejected for some reason (possibly advice from
> upstream?).

Below is a simple patch that does this for getxattr.  ls -Z then works
for e.g. /proc /dev/pts /selinux.

Index: linux-2.6/fs/xattr.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/fs/xattr.c,v
retrieving revision 1.9
diff -u -p -r1.9 xattr.c
--- linux-2.6/fs/xattr.c	27 Dec 2004 15:09:17 -0000	1.9
+++ linux-2.6/fs/xattr.c	31 May 2005 12:56:27 -0000
@@ -142,15 +142,19 @@ getxattr(struct dentry *d, char __user *
 		if (error)
 			goto out;
 		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size);
-		if (error > 0) {
-			if (size && copy_to_user(value, kvalue, error))
-				error = -EFAULT;
-		} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
-			/* The file system tried to returned a value bigger
-			   than XATTR_SIZE_MAX bytes. Not possible. */
-			error = -E2BIG;
-		}
+	} else if (!strncmp(kname, XATTR_SECURITY_PREFIX, sizeof XATTR_SECURITY_PREFIX - 1)) {
+		const char *suffix = kname + sizeof XATTR_SECURITY_PREFIX - 1;
+		error = security_inode_getsecurity(d->d_inode, suffix, kvalue, size);
 	}
+	if (error > 0) {
+		if (size && copy_to_user(value, kvalue, error))
+			error = -EFAULT;
+	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
+		/* The file system tried to returned a value bigger
+		   than XATTR_SIZE_MAX bytes. Not possible. */
+		error = -E2BIG;
+	} 
+
 out:
 	if (kvalue)
 		kfree(kvalue);


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
