Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14FVuRb012520
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 10:31:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i14FUXVM006830
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 15:30:34 GMT
Date: Wed, 4 Feb 2004 10:31:51 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Alexander Viro <aviro@redhat.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>,
   <selinux@tycho.nsa.gov>, Chris Wright <chrisw@osdl.org>,
   <trond.myklebust@fys.uio.no>
Subject: [PATCH] (2/3) SELinux context mount support - NFS
In-Reply-To: <Xine.LNX.4.44.0402040931480.4796@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0402040949010.4796-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch modifies the kernel's NFS mount data structure to include 
SELinux context mount data.  It allows NFS fileystems to be labeled on a 
per-mountpoint basis, and should not affect existing versions of 
userspace mount.

(A patch to the userspace mount code is available at 
http://people.redhat.com/jmorris/selinux/context_mounts/)

 include/linux/nfs_mount.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -urN -X dontdiff linux-2.6.2.p/include/linux/nfs_mount.h linux-2.6.2.w/include/linux/nfs_mount.h
--- linux-2.6.2.p/include/linux/nfs_mount.h	2003-09-27 20:50:06.000000000 -0400
+++ linux-2.6.2.w/include/linux/nfs_mount.h	2004-02-04 09:08:10.306809336 -0500
@@ -20,7 +20,8 @@
  * mount-to-kernel version compatibility.  Some of these aren't used yet
  * but here they are anyway.
  */
-#define NFS_MOUNT_VERSION	5
+#define NFS_MOUNT_VERSION	6
+#define NFS_MAX_CONTEXT_LEN	256
 
 struct nfs_mount_data {
 	int		version;		/* 1 */
@@ -41,6 +42,7 @@
 	unsigned int	bsize;			/* 3 */
 	struct nfs3_fh	root;			/* 4 */
 	int		pseudoflavor;		/* 5 */
+	char		context[NFS_MAX_CONTEXT_LEN + 1];	/* 6 */
 };
 
 /* bits in the flags field */





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
