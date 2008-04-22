From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: objsec.h whitespace, syntax, and other cleanups
Date: Tue, 22 Apr 2008 17:46:10 -0400
Message-Id: <12089007782327-git-send-email-eparis@redhat.com>
In-Reply-To: <1208900778580-git-send-email-eparis@redhat.com>
References: <12089007782175-git-send-email-eparis@redhat.com>
 <1208900778580-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes objsec.h to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

whitespace at end of lines
spaces followed by tabs
spaces used instead of tabs
spacing around parenthesis
location of { around structs and else clauses
location of * in pointer declarations
removal of initialization of static data to keep it in the right section
useless {} in if statemetns
useless checking for NULL before kfree
fixing of the indentation depth of switch statements
no assignments in if statements
and any number of other things I forgot to mention

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/include/objsec.h |   60 ++++++++++++++++++------------------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 300b61b..032c235 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -4,16 +4,16 @@
  *  This file contains the SELinux security data structures for kernel objects.
  *
  *  Author(s):  Stephen Smalley, <sds@epoch.ncsc.mil>
- *              Chris Vance, <cvance@nai.com>
- *              Wayne Salamon, <wsalamon@nai.com>
- *              James Morris <jmorris@redhat.com>
+ *		Chris Vance, <cvance@nai.com>
+ *		Wayne Salamon, <wsalamon@nai.com>
+ *		James Morris <jmorris@redhat.com>
  *
  *  Copyright (C) 2001,2002 Networks Associates Technology, Inc.
  *  Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License version 2,
- *      as published by the Free Software Foundation.
+ *	as published by the Free Software Foundation.
  */
 #ifndef _SELINUX_OBJSEC_H_
 #define _SELINUX_OBJSEC_H_
@@ -28,58 +28,58 @@
 #include "avc.h"
 
 struct task_security_struct {
-	u32 osid;            /* SID prior to last execve */
-	u32 sid;             /* current SID */
-	u32 exec_sid;        /* exec SID */
-	u32 create_sid;      /* fscreate SID */
-	u32 keycreate_sid;   /* keycreate SID */
-	u32 sockcreate_sid;  /* fscreate SID */
+	u32 osid;		/* SID prior to last execve */
+	u32 sid;		/* current SID */
+	u32 exec_sid;		/* exec SID */
+	u32 create_sid;		/* fscreate SID */
+	u32 keycreate_sid;	/* keycreate SID */
+	u32 sockcreate_sid;	/* fscreate SID */
 };
 
 struct inode_security_struct {
-        struct inode *inode;           /* back pointer to inode object */
-	struct list_head list;         /* list of inode_security_struct */
-	u32 task_sid;        /* SID of creating task */
-	u32 sid;             /* SID of this object */
-	u16 sclass;       /* security class of this object */
-	unsigned char initialized;     /* initialization flag */
+	struct inode *inode;	/* back pointer to inode object */
+	struct list_head list;	/* list of inode_security_struct */
+	u32 task_sid;		/* SID of creating task */
+	u32 sid;		/* SID of this object */
+	u16 sclass;		/* security class of this object */
+	unsigned char initialized;	/* initialization flag */
 	struct mutex lock;
-	unsigned char inherit;         /* inherit SID from parent entry */
+	unsigned char inherit;	/* inherit SID from parent entry */
 };
 
 struct file_security_struct {
-	u32 sid;              /* SID of open file description */
-	u32 fown_sid;         /* SID of file owner (for SIGIO) */
-	u32 isid;             /* SID of inode at the time of file open */
-	u32 pseqno;           /* Policy seqno at the time of file open */
+	u32 sid;		/* SID of open file description */
+	u32 fown_sid;		/* SID of file owner (for SIGIO) */
+	u32 isid;		/* SID of inode at the time of file open */
+	u32 pseqno;		/* Policy seqno at the time of file open */
 };
 
 struct superblock_security_struct {
-	struct super_block *sb;         /* back pointer to sb object */
-	struct list_head list;          /* list of superblock_security_struct */
+	struct super_block *sb;		/* back pointer to sb object */
+	struct list_head list;		/* list of superblock_security_struct */
 	u32 sid;			/* SID of file system superblock */
 	u32 def_sid;			/* default SID for labeling */
 	u32 mntpoint_sid;		/* SECURITY_FS_USE_MNTPOINT context for files */
-	unsigned int behavior;          /* labeling behavior */
-	unsigned char initialized;      /* initialization flag */
+	unsigned int behavior;		/* labeling behavior */
+	unsigned char initialized;	/* initialization flag */
 	unsigned char flags;		/* which mount options were specified */
-	unsigned char proc;             /* proc fs */
+	unsigned char proc;		/* proc fs */
 	struct mutex lock;
 	struct list_head isec_head;
 	spinlock_t isec_lock;
 };
 
 struct msg_security_struct {
-	u32 sid;              /* SID of message */
+	u32 sid;	/* SID of message */
 };
 
 struct ipc_security_struct {
 	u16 sclass;	/* security class of this object */
-	u32 sid;              /* SID of IPC resource */
+	u32 sid;	/* SID of IPC resource */
 };
 
 struct bprm_security_struct {
-	u32 sid;                       /* SID for transformed process */
+	u32 sid;		/* SID for transformed process */
 	unsigned char set;
 
 	/*
@@ -123,7 +123,7 @@ struct sk_security_struct {
 };
 
 struct key_security_struct {
-	u32 sid;         /* SID of key */
+	u32 sid;	/* SID of key */
 };
 
 extern unsigned int selinux_checkreqprot;
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
