Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h82IK8La018576
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 14:20:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h82IIapQ022868
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 18:18:36 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h82IIaQX022865
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 18:18:36 GMT
Subject: Re: new SE Linux and avc messages
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: James Morris <jmorris@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1062506053.18568.21.camel@moss-spartans.epoch.ncsc.mil>
References: <200309021720.04027.russell@coker.com.au>
	 <1062506053.18568.21.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1062526796.18568.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Sep 2003 14:19:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-09-02 at 08:34, Stephen Smalley wrote:
> The auditing code will generate and include pathname information when it
> can be done reliably, i.e. when a (vfsmount, dentry) pair is available. 
> Unfortunately, it is often the case that a pair is not available, and
> trying to generate a pathname from just a dentry or just an inode was
> considered a hack that had to be dropped as part of the code cleanup for
> mainline integration.  If a dentry is available, we could include the
> d_name.name in the audit message (i.e. the last component of the
> pathname), but generating a full path isn't possible in any reliable
> manner.

The patch below will include the component name from the dentry in the
audit message when a vfsmount is not available.  This might be
acceptable in the mainline kernel.  The patch does not attempt to
traverse the parent links of the dentry to reconstruct a path up to the
root of the mount, unlike the old avc_d_path code from the older
SELinux; I doubt that would be acceptable in mainline.

Index: linux-2.6/security/selinux/avc.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/avc.c,v
retrieving revision 1.34
diff -u -r1.34 avc.c
--- linux-2.6/security/selinux/avc.c	12 Aug 2003 14:45:14 -0000	1.34
+++ linux-2.6/security/selinux/avc.c	2 Sep 2003 18:04:44 -0000
@@ -575,17 +575,26 @@
 			break;
 		case AVC_AUDIT_DATA_FS:
 			if (a->u.fs.dentry) {
+				struct dentry *dentry = a->u.fs.dentry;
 				if (a->u.fs.mnt) {
-					p = d_path(a->u.fs.dentry,
+					p = d_path(dentry,
 						   a->u.fs.mnt,
 						   avc_audit_buffer,
 						   PAGE_SIZE);
 					if (p)
 						printk(" path=%s", p);
+				} else {
+					printk(" name=%s", dentry->d_name.name);
 				}
-				inode = a->u.fs.dentry->d_inode;
+				inode = dentry->d_inode;
 			} else if (a->u.fs.inode) {
+				struct dentry *dentry;
 				inode = a->u.fs.inode;
+				dentry = d_find_alias(inode);
+				if (dentry) {
+					printk(" name=%s", dentry->d_name.name);
+					dput(dentry);
+				}
 			}
 			if (inode)
 				printk(" dev=%s ino=%ld",


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
