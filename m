Message-ID: <407E7111.506@snu.edu>
Date: Thu, 15 Apr 2004 06:25:05 -0500
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: extra secondary_ops for digsig
Content-Type: multipart/mixed;
 boundary="------------060603030305010508040703"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060603030305010508040703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I started playing with digsig and quickly found out that selinux doesn't 
support all the secondary ops that it requires (it isn't even set up to 
be a secondary module, I had to fix that too so this is expected)..

Digsig is an LSM that verifies signatures on ELF binaries before they 
are allowed to run. It requires inode_permission, file_mmap, 
bprm_check_security and inode_unlink, I've attached a patch to add 
these, it'd be nice to get it upstream so that this module will run as a 
secondary to selinux without hacking (I'll send the patch for digsig to 
their authors as well)

Just out of curiousity, why are there so few secondary_ops available? 
Was it just decided to add them as they were required or is there a 
different reason?

Joshua Brindle



--------------060603030305010508040703
Content-Type: text/plain;
 name="extra_sec_ops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="extra_sec_ops.patch"

--- linux-2.6.4/security/selinux/hooks.c	2004-04-13 00:51:48.225259424 -0500
+++ linux-2.6.5-hardened/security/selinux/hooks.c	2004-04-13 00:34:15.067464600 -0500
@@ -1673,6 +1673,11 @@
 
 static int selinux_bprm_check_security (struct linux_binprm *bprm)
 {
+	int rc;
+
+	rc = secondary_ops->bprm_check_security(bprm);
+	if (rc) 
+		return rc;
 	return 0;
 }
 
@@ -2013,6 +2018,11 @@
 
 static int selinux_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
+	int rc;
+	
+	rc = secondary_ops->inode_unlink(dir, dentry);
+	if (rc)
+		return rc;
 	return may_link(dir, dentry, MAY_UNLINK);
 }
 
@@ -2081,11 +2091,17 @@
 static int selinux_inode_permission(struct inode *inode, int mask,
 				    struct nameidata *nd)
 {
+	int rc;
+
 	if (!mask) {
 		/* No permission to check.  Existence test. */
 		return 0;
 	}
 
+	rc = secondary_ops->inode_permission(inode, mask, nd);
+	if (rc)
+		return rc;
+
 	return inode_has_perm(current, inode,
 			       file_mask_to_av(inode->i_mode, mask), NULL, NULL);
 }
@@ -2358,6 +2374,7 @@
 static int selinux_file_mmap(struct file *file, unsigned long prot, unsigned long flags)
 {
 	u32 av;
+	int rc;
 
 	if (file) {
 		/* read access is always possible with a mapping */
@@ -2369,6 +2386,10 @@
 
 		if (prot & PROT_EXEC)
 			av |= FILE__EXECUTE;
+	
+		rc = secondary_ops->file_mmap(file, prot, flags);
+		if (rc)
+			return rc;
 
 		return file_has_perm(current, file, av);
 	}

--------------060603030305010508040703--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
