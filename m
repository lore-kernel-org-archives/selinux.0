Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i09Fh8Rb000527
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 10:43:08 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i09Fh6iV005332
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 15:43:06 GMT
Received: from thoron.boston.redhat.com (nat-pool-bos.redhat.com [66.187.230.200])
        by jazzband.ncsc.mil  with ESMTP id i09Fh308005324 for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 15:43:05 GMT
Date: Fri, 9 Jan 2004 10:43:02 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
   <selinux@tycho.nsa.gov>
Subject: [PATCH][SELINUX] 7/7 Add dname to audit output when a path cannot
 be generated.
In-Reply-To: <Xine.LNX.4.44.0401091023430.21309@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0401091035010.21309-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch against 2.6.1-mm1 adds dname to audit output when a path cannot 
be generated.  This makes analysis of SELinux audit logs easier.

Patch by Stephen Smalley <sds@epoch.ncsc.mil>.

Please apply.

 avc.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/avc.c linux-2.6.1-rc2.w1/security/selinux/avc.c
--- linux-2.6.1-rc2.pending/security/selinux/avc.c	2004-01-07 11:50:22.567223632 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/avc.c	2004-01-07 12:00:02.522057096 -0500
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
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
