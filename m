Message-ID: <403CF8AB.5080309@snu.edu>
Date: Wed, 25 Feb 2004 13:34:03 -0600
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: PaX + selinux integration update
Content-Type: multipart/mixed;
 boundary="------------080208070804090406080903"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080208070804090406080903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

These are the fixed up versions thanks to Chris Pebenito, the kernel 
patch no longer specifies defaults, so now all decisions come directly 
from policy.

Also the excess amount of denials will not be displayed per policy


--------------080208070804090406080903
Content-Type: text/plain;
 name="pax-selinux-hooks-2.4.24-hardened-r1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pax-selinux-hooks-2.4.24-hardened-r1"

diff -urN linux-2.4.24-hardened-r1.orig/security/selinux/hooks.c linux-2.4.24-hardened-r1/security/selinux/hooks.c
--- linux-2.4.24-hardened-r1.orig/security/selinux/hooks.c	2004-02-22 23:03:26.000000000 -0600
+++ linux-2.4.24-hardened-r1/security/selinux/hooks.c	2004-02-22 23:46:53.000000000 -0600
@@ -3190,6 +3190,68 @@
 	return size;
 }
 
+#ifdef CONFIG_PAX_HOOK_ACL_FLAGS
+static void avc_pax_set_flags(struct linux_binprm * bprm)
+{
+	struct inode_security_struct *isec;
+	unsigned long flags = 0;
+	int rc;
+
+	char *scontext;
+	u32 scontext_len;
+
+	/*
+	 * get the security struct from the inode of the file 
+	 * since the bprm security struct will just point to 
+	 * the user running the binary
+	 */
+	struct inode *inode = bprm->file->f_dentry->d_inode;
+	isec = inode->i_security;
+
+	rc = avc_has_perm(isec->sid, isec->sid, SECCLASS_PAX, PAX__PAGEEXEC, &isec->avcr,NULL);
+	if (!rc) {
+		flags |= PF_PAX_PAGEEXEC;
+	}
+	rc = avc_has_perm(isec->sid, isec->sid, SECCLASS_PAX, PAX__EMUTRAMP, &isec->avcr, NULL);
+	if (!rc) {
+		flags |= PF_PAX_EMUTRAMP;
+	}
+	rc = avc_has_perm(isec->sid, isec->sid, SECCLASS_PAX, PAX__RANDEXEC, &isec->avcr, NULL);
+	if (!rc) {
+		flags |= PF_PAX_RANDEXEC;
+	}
+	rc = avc_has_perm(isec->sid, isec->sid, SECCLASS_PAX, PAX__MPROTECT, &isec->avcr, NULL);
+	if (!rc) {
+		flags |= PF_PAX_MPROTECT;
+	}
+	rc = avc_has_perm(isec->sid, isec->sid, SECCLASS_PAX, PAX__RANDMMAP, &isec->avcr, NULL);
+	if (!rc) {
+		flags |= PF_PAX_RANDMMAP;
+	}
+	rc = avc_has_perm(isec->sid, isec->sid, SECCLASS_PAX, PAX__SEGMEXEC, &isec->avcr, NULL);
+	if (!rc) {
+		flags |= PF_PAX_SEGMEXEC;
+	}
+
+	if (selinux_enforcing) {
+		/* pull all the pax flags in current */
+		current->flags &= ~(PF_PAX_PAGEEXEC | PF_PAX_EMUTRAMP | PF_PAX_MPROTECT | PF_PAX_RANDMMAP | PF_PAX_RANDEXEC | PF_PAX_SEGMEXEC);
+		/* and add ours */
+		current->flags |= flags;
+
+		if (pax_check_flags(&current->flags) < 0) {
+			security_sid_to_context(isec->sid, &scontext, &scontext_len);
+			printk(KERN_WARNING "avc: PaX flags overridden to %lx for %s (%s)\n",
+				current->flags,
+				scontext,
+				bprm->filename);
+			kfree(scontext);
+		}
+	}
+}
+#endif /* CONFIG_PAX_HOOK_ACL_FLAGS */
+
+
 struct security_operations selinux_ops = {
 	.ptrace =			selinux_ptrace,
 	.capget =			selinux_capget,
@@ -3370,6 +3432,11 @@
 {
 	printk(KERN_INFO "SELinux:  Completing initialization.\n");
 
+	#ifdef CONFIG_PAX_HOOK_ACL_FLAGS
+	printk(KERN_INFO "SELinux:  Setting PaX callback function.\n");
+	pax_set_flags_func = avc_pax_set_flags;
+	#endif
+
 	/* Set up any superblocks initialized prior to the policy load. */
 	printk(KERN_INFO "SELinux:  Setting up existing superblocks.\n");
 	spin_lock(&sb_security_lock);
diff -urN linux-2.4.24-hardened-r1.orig/security/selinux/include/av_perm_to_string.h linux-2.4.24-hardened-r1/security/selinux/include/av_perm_to_string.h
--- linux-2.4.24-hardened-r1.orig/security/selinux/include/av_perm_to_string.h	2004-02-22 23:03:26.000000000 -0600
+++ linux-2.4.24-hardened-r1/security/selinux/include/av_perm_to_string.h	2004-02-20 16:50:39.000000000 -0600
@@ -114,6 +120,12 @@
    { SECCLASS_PASSWD, PASSWD__PASSWD, "passwd" },
    { SECCLASS_PASSWD, PASSWD__CHFN, "chfn" },
    { SECCLASS_PASSWD, PASSWD__CHSH, "chsh" },
+   { SECCLASS_PAX, PAX__PAGEEXEC, "pageexec" },
+   { SECCLASS_PAX, PAX__EMUTRAMP, "emutramp" },
+   { SECCLASS_PAX, PAX__MPROTECT, "mprotect" },
+   { SECCLASS_PAX, PAX__RANDMMAP, "randmmap" },
+   { SECCLASS_PAX, PAX__RANDEXEC, "randexec" },
+   { SECCLASS_PAX, PAX__SEGMEXEC, "segmexec" },
 };
 
 
diff -urN linux-2.4.24-hardened-r1.orig/security/selinux/include/av_permissions.h linux-2.4.24-hardened-r1/security/selinux/include/av_permissions.h
--- linux-2.4.24-hardened-r1.orig/security/selinux/include/av_permissions.h	2004-02-22 23:03:26.000000000 -0600
+++ linux-2.4.24-hardened-r1/security/selinux/include/av_permissions.h	2004-02-20 16:50:40.000000000 -0600
@@ -546,5 +554,12 @@
 #define PASSWD__CHFN                              0x00000002UL
 #define PASSWD__CHSH                              0x00000004UL
 
+#define PAX__PAGEEXEC                             0x00000001UL
+#define PAX__EMUTRAMP                             0x00000002UL
+#define PAX__MPROTECT                             0x00000004UL
+#define PAX__RANDMMAP                             0x00000008UL
+#define PAX__RANDEXEC                             0x00000010UL
+#define PAX__SEGMEXEC                             0x00000020UL
+
 
 /* FLASK */
diff -urN linux-2.4.24-hardened-r1.orig/security/selinux/include/class_to_string.h linux-2.4.24-hardened-r1/security/selinux/include/class_to_string.h
--- linux-2.4.24-hardened-r1.orig/security/selinux/include/class_to_string.h	2004-02-22 23:03:26.000000000 -0600
+++ linux-2.4.24-hardened-r1/security/selinux/include/class_to_string.h	2004-02-20 16:50:40.000000000 -0600
@@ -35,5 +35,6 @@
     "shm",
     "ipc",
     "passwd",
+    "pax",
 };
 
diff -urN linux-2.4.24-hardened-r1.orig/security/selinux/include/flask.h linux-2.4.24-hardened-r1/security/selinux/include/flask.h
--- linux-2.4.24-hardened-r1.orig/security/selinux/include/flask.h	2004-02-22 23:03:26.000000000 -0600
+++ linux-2.4.24-hardened-r1/security/selinux/include/flask.h	2004-02-20 16:50:41.000000000 -0600
@@ -35,6 +35,7 @@
 #define SECCLASS_SHM                                     28
 #define SECCLASS_IPC                                     29
 #define SECCLASS_PASSWD                                  30
+#define SECCLASS_PAX                                     31
 
 /*
  * Security identifier indices for initial entities

--------------080208070804090406080903
Content-Type: text/plain;
 name="pax-selinux-hooks-policy"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pax-selinux-hooks-policy"

diff --exclude=users --exclude=users.fc -ur cvs/assert.te policy-dev/assert.te
--- cvs/assert.te	2003-12-07 20:50:37.000000000 -0600
+++ policy-dev/assert.te	2004-02-22 22:15:56.000000000 -0600
@@ -157,3 +157,21 @@
 neverallow * domain:file_class_set ~rw_file_perms;
 neverallow * file_type:process *;
 neverallow ~{ domain unlabeled_t } *:process *;
+
+ifdef(`pax.te',`
+#
+# PaX flags only on executables.  However not all executables
+# are exec_type, so limit to file_types
+#
+neverallow ~file_type self:pax { pageexec segmexec mprotect randmmap emutramp randexec };
+
+#
+# Enforce flag exemptions
+#
+neverallow nopageexec self:pax pageexec;
+neverallow noemutramp self:pax emutramp;
+neverallow nomprotect self:pax mprotect;
+neverallow norandmmap self:pax randmmap;
+neverallow norandexec self:pax randexec;
+neverallow nosegmexec self:pax segmexec;
+')
diff --exclude=users --exclude=users.fc -ur cvs/attrib.te policy-dev/attrib.te
--- cvs/attrib.te	2003-12-07 20:50:37.000000000 -0600
+++ policy-dev/attrib.te	2004-02-22 22:19:15.000000000 -0600
@@ -319,3 +319,25 @@
 
 # For a mail server process that takes TCP connections on port 25
 attribute mail_server_domain;
+
+############################
+# Attributes for PaX flags:
+#
+
+# Do not enforce paging based non-executable pages
+attribute nopageexec;
+
+# Do not enforce segmentation based non-executable pages
+attribute nosegmexec;
+
+# Do not restrict mprotect()
+attribute nomprotect;
+
+# Do not randomize mmap() base [ELF only]
+attribute norandmmap;
+
+# Do not emulate trampolines
+attribute noemutramp;
+
+# Do not randomize ET_EXEC base [ELF only]
+attribute norandexec;
diff --exclude=users --exclude=users.fc -ur cvs/domains/program/pax.te policy-dev/domains/program/pax.te
--- cvs/domains/program/pax.te	2004-02-21 01:16:20.000000000 -0600
+++ policy-dev/domains/program/pax.te	2004-02-22 22:29:11.000000000 -0600
@@ -0,0 +1,41 @@
+##########################
+# Default PaX Flags
+#
+# Set flags for all file_type's since not all
+# executables are exec_type.  It is suggested that
+# users become familiar with each flag before
+# enabling it on all executables.
+#
+
+# Paging based non-executable pages
+#allow { file_type -nopageexec } self:pax pageexec;
+
+# Segmentation based non-executable pages
+#allow { file_type -nosegmexec } self:pax segmexec;
+
+# Restrict mprotect()
+#allow { file_type -nomprotect } self:pax mprotect;
+
+# Randomize mmap() base
+#allow { file_type -norandmmap } self:pax randmmap;
+
+# Emulate trampolines
+#allow { file_type -noemutramp } self:pax emutramp;
+
+# Randomize ET_EXEC base
+#allow { file_type -norandexec } self:pax randexec;
+
+# Do not need to audit disabled flags
+dontaudit file_type self:pax { pageexec segmexec mprotect randmmap emutramp randexec };
+
+##########################
+# Set flags for specific executables:
+#
+
+
+##########################
+# Paxtest policy
+#
+type paxtest_exec_t, file_type, noemutramp;
+allow paxtest_exec_t self:pax { segmexec mprotect randmmap randexec };
+can_exec(sysadm_t,paxtest_exec_t)
diff --exclude=users --exclude=users.fc -ur cvs/file_contexts/program/pax.fc policy-dev/file_contexts/program/pax.fc
--- cvs/file_contexts/program/pax.fc	2004-02-21 01:16:33.000000000 -0600
+++ policy-dev/file_contexts/program/pax.fc	2004-02-21 00:57:21.000000000 -0600
@@ -0,0 +1,2 @@
+# paxtest programs
+/usr/lib/paxtest/.*		--	system_u:object_r:paxtest_exec_t
diff --exclude=users --exclude=users.fc -ur cvs/flask/access_vectors policy-dev/flask/access_vectors
--- cvs/flask/access_vectors	2003-12-07 20:50:37.000000000 -0600
+++ policy-dev/flask/access_vectors	2004-02-19 20:16:44.000000000 -0600
@@ -353,3 +353,17 @@
 	chfn
 	chsh
 }
+
+#
+# Define the access vector interpretation for controlling
+# PaX flags
+#
+class pax
+{
+	pageexec	# Paging based non-executable pages
+	emutramp	# Emulate trampolines
+	mprotect	# Restrict mprotect()
+	randmmap	# Randomize mmap() base
+	randexec	# Randomize ET_EXEC base
+	segmexec	# Segmentation based non-executable pages
+}
diff --exclude=users --exclude=users.fc -ur cvs/flask/security_classes policy-dev/flask/security_classes
--- cvs/flask/security_classes	2003-12-07 20:50:37.000000000 -0600
+++ policy-dev/flask/security_classes	2004-02-19 20:16:44.000000000 -0600
@@ -47,4 +47,7 @@
 # passwd/chfn/chsh
 class passwd
 
+# pax flags
+class pax
+
 # FLASK

--------------080208070804090406080903--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
