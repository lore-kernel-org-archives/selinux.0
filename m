Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5IFBcI4026429
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2003 11:11:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5IFAdss028161
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2003 15:10:39 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h5IFAchY028148
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2003 15:10:39 GMT
Subject: Enabling glibc secure mode for role/domain transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>, Brian May <bam@snoopy.apana.org.au>,
   Jack <jack@rapturesecurity.com>
Content-Type: multipart/mixed; boundary="=-gk/isM2RvkJ+vIi1pNvv"
Message-Id: <1055948616.3362.333.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 18 Jun 2003 11:03:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-gk/isM2RvkJ+vIi1pNvv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

Earlier this week, I submitted a patch for the mainline 2.5 kernel on
lkml (cc'd to lsm) to allow security modules like SELinux to convey a
boolean flag via the auxiliary ELF table to userland to indicate whether
libc secure mode should be enabled (i.e. sanitize the environment,
initial descriptors, etc) so that secure mode can be requested upon
changes to other security attributes such as capabilities, roles,
domains, etc.  This change is to address the underlying issue identified
in Rafal Wojtczuk's report.  The patch has been taken into Andrew
Morton's 2.5.72-mm series, and there have been no objections to it so
far.

Below I've attached a corresponding patch for the lsm-2.4 tree and a
patch for glibc (based on glibc-2.3.2-27.9 for RH9) to cause glibc to
use the boolean flag when it is provided by the kernel.  The SELinux
code in the kernel patch presently requests libc secure mode for any SID
transition (as well as preserving the legacy logic); we may want to
replace this with a new permission check to provide greater flexibility.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-gk/isM2RvkJ+vIi1pNvv
Content-Disposition: attachment; filename=2.4atsecure.patch
Content-Type: text/x-patch; name=2.4atsecure.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: lsm-2.4/fs/binfmt_elf.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.4/fs/binfmt_elf.c,v
retrieving revision 1.3
diff -u -r1.3 binfmt_elf.c
--- lsm-2.4/fs/binfmt_elf.c	14 Aug 2002 16:53:25 -0000	1.3
+++ lsm-2.4/fs/binfmt_elf.c	17 Jun 2003 18:44:34 -0000
@@ -33,6 +33,7 @@
 #include <linux/smp_lock.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/param.h>
@@ -107,12 +108,15 @@
 }
 
 static elf_addr_t * 
-create_elf_tables(char *p, int argc, int envc,
+create_elf_tables(struct linux_binprm *bprm,
 		  struct elfhdr * exec,
 		  unsigned long load_addr,
 		  unsigned long load_bias,
 		  unsigned long interp_load_addr, int ibcs)
 {
+        char *p = bprm->p;
+        int argc = bprm->argc;
+        int envc = bprm->envc;
 	elf_caddr_t *argv;
 	elf_caddr_t *envp;
 	elf_addr_t *sp, *csp;
@@ -196,6 +200,7 @@
 	NEW_AUX_ENT(10, AT_EUID, (elf_addr_t) current->euid);
 	NEW_AUX_ENT(11, AT_GID, (elf_addr_t) current->gid);
 	NEW_AUX_ENT(12, AT_EGID, (elf_addr_t) current->egid);
+  	NEW_AUX_ENT(13, AT_SECURE, (elf_addr_t) security_bprm_secureexec(bprm));
 #ifdef ARCH_DLINFO
 	/* 
 	 * ARCH_DLINFO must come last so platform specific code can enforce
@@ -725,9 +730,7 @@
 	compute_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
 	bprm->p = (unsigned long)
-	  create_elf_tables((char *)bprm->p,
-			bprm->argc,
-			bprm->envc,
+	  create_elf_tables(bprm,
 			&elf_ex,
 			load_addr, load_bias,
 			interp_load_addr,
Index: lsm-2.4/include/linux/elf.h
===================================================================
RCS file: /home/pal/CVS/lsm-2.4/include/linux/elf.h,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 elf.h
--- lsm-2.4/include/linux/elf.h	29 Nov 2002 14:43:19 -0000	1.1.1.3
+++ lsm-2.4/include/linux/elf.h	17 Jun 2003 18:30:40 -0000
@@ -174,6 +174,8 @@
 #define AT_HWCAP  16    /* arch dependent hints at CPU capabilities */
 #define AT_CLKTCK 17	/* frequency at which times() increments */
 
+#define AT_SECURE 23   /* secure mode boolean */
+
 typedef struct dynamic{
   Elf32_Sword d_tag;
   union{
Index: lsm-2.4/include/linux/security.h
===================================================================
RCS file: /home/pal/CVS/lsm-2.4/include/linux/security.h,v
retrieving revision 1.70
diff -u -r1.70 security.h
--- lsm-2.4/include/linux/security.h	28 Jan 2003 18:57:02 -0000	1.70
+++ lsm-2.4/include/linux/security.h	17 Jun 2003 19:01:04 -0000
@@ -50,6 +50,7 @@
 extern void cap_capset_set (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
 extern int cap_bprm_set_security (struct linux_binprm *bprm);
 extern void cap_bprm_compute_creds (struct linux_binprm *bprm);
+extern int cap_bprm_secureexec(struct linux_binprm *bprm);
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
 extern void cap_task_kmod_set_label (void);
 extern void cap_task_reparent_to_init (struct task_struct *p);
@@ -129,6 +130,12 @@
  * 	first.
  * 	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
+ * @bprm_secureexec:
+ *      Return a boolean value (0 or 1) indicating whether a "secure exec" 
+ *      is required.  The flag is passed in the auxiliary table
+ *      on the initial stack to the ELF interpreter to indicate whether libc 
+ *      should enable secure mode.
+ *      @bprm contains the linux_binprm structure.
  *
  * Security hooks for filesystem operations.
  *
@@ -1243,6 +1250,7 @@
 	void (*bprm_compute_creds) (struct linux_binprm * bprm);
 	int (*bprm_set_security) (struct linux_binprm * bprm);
 	int (*bprm_check_security) (struct linux_binprm * bprm);
+	int (*bprm_secureexec) (struct linux_binprm * bprm);
 
 	int (*sb_alloc_security) (struct super_block * sb);
 	void (*sb_free_security) (struct super_block * sb);
@@ -1613,11 +1621,17 @@
 {
 	return security_ops->bprm_set_security (bprm);
 }
+
 static inline int security_bprm_check (struct linux_binprm *bprm)
 {
 	return security_ops->bprm_check_security (bprm);
 }
 
+static inline int security_bprm_secureexec (struct linux_binprm *bprm)
+{
+	return security_ops->bprm_secureexec (bprm);
+}
+
 static inline int security_sb_alloc (struct super_block *sb)
 {
 	return security_ops->sb_alloc_security (sb);
@@ -2327,6 +2341,11 @@
 static inline int security_bprm_check (struct linux_binprm *bprm)
 {
 	return 0;
+}
+
+static inline int security_bprm_secureexec (struct linux_binprm *bprm)
+{
+	return cap_bprm_secureexec(bprm);
 }
 
 static inline int security_sb_alloc (struct super_block *sb)
Index: lsm-2.4/security/capability.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.4/security/capability.c,v
retrieving revision 1.18
diff -u -r1.18 capability.c
--- lsm-2.4/security/capability.c	24 Jan 2003 22:11:41 -0000	1.18
+++ lsm-2.4/security/capability.c	17 Jun 2003 18:30:41 -0000
@@ -182,6 +182,17 @@
 	current->keep_capabilities = 0;
 }
 
+int cap_bprm_secureexec (struct linux_binprm *bprm)
+{
+	/* If/when this module is enhanced to incorporate capability
+	   bits on files, the test below should be extended to also perform a 
+	   test between the old and new capability sets.  For now,
+	   it simply preserves the legacy decision algorithm used by
+	   the old userland. */
+	return (current->euid != current->uid ||
+		current->egid != current->gid);
+}
+
 /* moved from kernel/sys.c. */
 /* 
  * cap_emulate_setxuid() fixes the effective / permitted capabilities of
@@ -311,6 +322,7 @@
 EXPORT_SYMBOL(cap_capset_set);
 EXPORT_SYMBOL(cap_bprm_set_security);
 EXPORT_SYMBOL(cap_bprm_compute_creds);
+EXPORT_SYMBOL(cap_bprm_secureexec);
 EXPORT_SYMBOL(cap_task_post_setuid);
 EXPORT_SYMBOL(cap_task_kmod_set_label);
 EXPORT_SYMBOL(cap_task_reparent_to_init);
@@ -332,6 +344,7 @@
 
 	.bprm_compute_creds =		cap_bprm_compute_creds,
 	.bprm_set_security =		cap_bprm_set_security,
+	.bprm_secureexec =		cap_bprm_secureexec,
 
 	.task_post_setuid =		cap_task_post_setuid,
 	.task_kmod_set_label =		cap_task_kmod_set_label,
Index: lsm-2.4/security/dummy.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.4/security/dummy.c,v
retrieving revision 1.28
diff -u -r1.28 dummy.c
--- lsm-2.4/security/dummy.c	28 Jan 2003 18:57:04 -0000	1.28
+++ lsm-2.4/security/dummy.c	17 Jun 2003 19:01:04 -0000
@@ -210,6 +210,16 @@
 	return 0;
 }
 
+static int dummy_bprm_secureexec (struct linux_binprm *bprm)
+{
+	/* The new userland will simply use the value provided
+	   in the AT_SECURE field to decide whether secure mode
+	   is required.  Hence, this logic is required to preserve
+	   the legacy decision algorithm used by the old userland. */
+	return (current->euid != current->uid ||
+		current->egid != current->gid);
+}
+
 static int dummy_sb_alloc_security (struct super_block *sb)
 {
 	return 0;
@@ -955,6 +965,7 @@
 	set_to_dummy_if_null(ops, bprm_compute_creds);
 	set_to_dummy_if_null(ops, bprm_set_security);
 	set_to_dummy_if_null(ops, bprm_check_security);
+	set_to_dummy_if_null(ops, bprm_secureexec);
 	set_to_dummy_if_null(ops, sb_alloc_security);
 	set_to_dummy_if_null(ops, sb_free_security);
 	set_to_dummy_if_null(ops, sb_kern_mount);
Index: lsm-2.4/security/selinux/hooks.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.4/security/selinux/hooks.c,v
retrieving revision 1.90
diff -u -r1.90 hooks.c
--- lsm-2.4/security/selinux/hooks.c	2 May 2003 18:57:19 -0000	1.90
+++ lsm-2.4/security/selinux/hooks.c	17 Jun 2003 19:09:04 -0000
@@ -1673,11 +1673,24 @@
 	return 0;
 }
 
-static int selinux_binprm_check_security (struct linux_binprm *bprm)
+static int selinux_bprm_check_security (struct linux_binprm *bprm)
 {
 	return 0;
 }
 
+static int selinux_bprm_secureexec (struct linux_binprm *bprm)
+{       
+        struct task_security_struct *tsec = current->security;
+        
+        /* Note that we must include the legacy uid/gid test below
+           to retain it, as the new userland will simply use the
+           value passed by AT_SECURE to decide whether to enable
+           secure mode. */
+        return (tsec->sid != tsec->osid ||
+                current->euid != current->uid ||
+                current->egid != current->gid);
+}       
+
 static void selinux_bprm_free_security(struct linux_binprm *bprm)
 {
 	/* Nothing to do - not dynamically allocated. */
@@ -4022,7 +4035,8 @@
 	bprm_free_security:		selinux_bprm_free_security,
 	bprm_compute_creds:		selinux_bprm_compute_creds,
 	bprm_set_security:		selinux_bprm_set_security,
-	bprm_check_security:		selinux_binprm_check_security,
+	bprm_check_security:		selinux_bprm_check_security,
+	bprm_secureexec:		selinux_bprm_secureexec,
 
 	sb_alloc_security:		selinux_sb_alloc_security,
 	sb_free_security:		selinux_sb_free_security,

--=-gk/isM2RvkJ+vIi1pNvv
Content-Disposition: attachment; filename=glibc-secureexec.patch
Content-Type: text/x-patch; name=glibc-secureexec.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -X /home/sds/dontdiff -ru glibc-2.3.2-200304020432.orig/elf/elf.h glibc-2.3.2-200304020432/elf/elf.h
--- glibc-2.3.2-200304020432.orig/elf/elf.h	2003-03-02 06:41:51.000000000 -0500
+++ glibc-2.3.2-200304020432/elf/elf.h	2003-06-10 14:55:10.000000000 -0400
@@ -946,6 +946,8 @@
    interpretation of the AUXV. Must be > 16.  */
 #define AT_IGNOREPPC	22		/* Entry should be ignored */
 
+#define AT_SECURE	23		/* Secure mode boolean */
+
 /* Pointer to the global system page used for system calls and other
    nice things.  */
 #define AT_SYSINFO	32
diff -X /home/sds/dontdiff -ru glibc-2.3.2-200304020432.orig/sysdeps/generic/dl-sysdep.c glibc-2.3.2-200304020432/sysdeps/generic/dl-sysdep.c
--- glibc-2.3.2-200304020432.orig/sysdeps/generic/dl-sysdep.c	2003-03-15 18:09:21.000000000 -0500
+++ glibc-2.3.2-200304020432/sysdeps/generic/dl-sysdep.c	2003-06-10 15:27:04.000000000 -0400
@@ -81,6 +81,7 @@
   ElfW(auxv_t) *av;
   uid_t uid = 0;
   gid_t gid = 0;
+  long secure = -1;
 #ifdef HAVE_AUX_XID
 # define set_seen(tag) (tag) /* Evaluate for the side effects.  */
 #else
@@ -123,6 +124,9 @@
       case AT_EGID:
 	gid ^= av->a_un.a_val;
 	break;
+      case AT_SECURE:
+	secure = av->a_un.a_val;
+	break;
       case AT_PLATFORM:
 	GL(dl_platform) = av->a_un.a_ptr;
 	break;
@@ -149,6 +153,9 @@
   DL_SYSDEP_OSCHECK (dl_fatal);
 #endif
 
+  if (secure != -1) {
+      INTUSE(__libc_enable_secure) = secure;
+  } else {
   /* Fill in the values we have not gotten from the kernel through the
      auxiliary vector.  */
 #ifndef HAVE_AUX_XID
@@ -163,6 +170,7 @@
   /* If one of the two pairs of IDs does not mattch this is a setuid
      or setgid run.  */
   INTUSE(__libc_enable_secure) = uid | gid;
+  }
 
 #ifndef HAVE_AUX_PAGESIZE
   if (GL(dl_pagesize) == 0)

--=-gk/isM2RvkJ+vIi1pNvv--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
