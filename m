Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA07109
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 11:24:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA09591
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 15:22:32 GMT
Received: from athena-new.evoserve.com (athena-new.evoserve.com [210.16.10.134])
        by jazzband.ncsc.mil  with ESMTP id PAA09587 for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 15:22:26 GMT
Received: from evoworks.evoserve.com ([210.16.10.5])
	by athena-new.evoserve.com (8.11.0/8.11.0) with ESMTP id g6AFUk428404
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 23:30:58 +0800
Message-ID: <3D2C4F46.1040408@evoworks.evoserve.com>
Date: Wed, 10 Jul 2002 23:14:14 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [PATCH] atuomatic type transitions for pts in devfs
Content-Type: multipart/mixed;
 boundary="------------090305080803050202000806"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090305080803050202000806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch only works properly with a devfsd less system. Devfsd needs 
to be patched for this to work on systems using it.

--------------090305080803050202000806
Content-Type: text/plain;
 name="automatic_transition_in_devfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="automatic_transition_in_devfs.diff"

--- /root/tmp/lsm-2.4/security/selinux/hooks.c	Wed Jul 10 01:11:11 2002
+++ security/selinux/hooks.c	Wed Jul 10 03:45:14 2002
@@ -689,7 +689,7 @@
 {
 	struct superblock_security_struct *sbsec = NULL; 
 	struct inode_security_struct *isec = inode->i_security;
-	security_id_t sid;
+	security_id_t sid, devfs_pts_sid;
 	char *buffer, *path;
 	struct dentry *dentry;
 	int rc;
@@ -779,10 +779,21 @@
 				path = avc_d_path(dentry, buffer,
 						  PAGE_SIZE);
 				if (path) {
+
+                            if ( (!memcmp(inode->i_sb->s_type->name, "devfs", 5)) && (!memcmp(path, "/pts/", 5)) ) {
+                                security_genfs_sid("devfs", "/pts", SECCLASS_DIR, &devfs_pts_sid);
+		                /* Try to obtain a transition SID. */
+		                rc = security_transition_sid(isec->task_sid, 
+                                                             devfs_pts_sid, 
+					                     isec->sclass,
+					                     &sid);
+
+                            } else {
 					rc = security_genfs_sid(inode->i_sb->s_type->name,
 								path, 
 								isec->sclass,
 								&sid);
+			    }
 					if (!rc)
 						isec->sid = sid;
 				}

--------------090305080803050202000806--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
