From: Eric Paris <eparis@redhat.com>
Subject: [RFC PATCH 2/2] SELinux: Use dentry name in new object labeling
To: selinux@tycho.nsa.gov
Cc: eparis@redhat.com, sds@tycho.nsa.gov, jmorris@namei.org,
        linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@lst.de
Date: Fri, 03 Dec 2010 16:45:25 -0500
Message-ID: <20101203214525.30001.88035.stgit@paris.rdu.redhat.com>
In-Reply-To: <20101203214518.30001.89859.stgit@paris.rdu.redhat.com>
References: <20101203214518.30001.89859.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently SELinux has rules which label new objects according to 3 criteria.
The label of the process creating the object, the label of the parent
directory, and the type of object (reg, dir, char, block, etc.)  This patch
adds a 4th criteria, the dentry name, thus we can distinguish between
creating a file in an etc_t directory called shadow and one called motd.

There is no file globbing, regex parsing, or anything mystical.  Either the
policy exactly (strcmp) matches the dentry name of the object or it doesn't.
This patch has no changes from today if policy does not implement the new
rules.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c            |   15 ++--
 security/selinux/include/security.h |    8 +-
 security/selinux/ss/avtab.h         |   22 +++---
 security/selinux/ss/policydb.c      |  130 +++++++++++++++++++++++++++++++++++
 security/selinux/ss/policydb.h      |   14 ++++
 security/selinux/ss/services.c      |   45 ++++++++----
 6 files changed, 197 insertions(+), 37 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 609e8d3..98e3497 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1301,10 +1301,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
 		/* Try to obtain a transition SID. */
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
-		rc = security_transition_sid(isec->task_sid,
-					     sbsec->sid,
-					     isec->sclass,
-					     &sid);
+		rc = security_transition_sid(isec->task_sid, sbsec->sid,
+					     isec->sclass, NULL, &sid);
 		if (rc)
 			goto out_unlock;
 		isec->sid = sid;
@@ -1579,7 +1577,7 @@ static int may_create(struct inode *dir,
 		return rc;
 
 	if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
-		rc = security_transition_sid(sid, dsec->sid, tclass, &newsid);
+		rc = security_transition_sid(sid, dsec->sid, tclass, NULL, &newsid);
 		if (rc)
 			return rc;
 	}
@@ -2061,7 +2059,8 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 	} else {
 		/* Check for a default transition on this program. */
 		rc = security_transition_sid(old_tsec->sid, isec->sid,
-					     SECCLASS_PROCESS, &new_tsec->sid);
+					     SECCLASS_PROCESS, NULL,
+					     &new_tsec->sid);
 		if (rc)
 			return rc;
 	}
@@ -2531,7 +2530,7 @@ static int selinux_inode_init_security(const struct qstr *qstr, struct inode *in
 	else if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
 		rc = security_transition_sid(sid, dsec->sid,
 					     inode_mode_to_security_class(inode->i_mode),
-					     &newsid);
+					     qstr, &newsid);
 		if (rc) {
 			printk(KERN_WARNING "%s:  "
 			       "security_transition_sid failed, rc=%d (dev=%s "
@@ -4855,7 +4854,7 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
 		 * message queue this message will be stored in
 		 */
 		rc = security_transition_sid(sid, isec->sid, SECCLASS_MSG,
-					     &msec->sid);
+					     NULL, &msec->sid);
 		if (rc)
 			return rc;
 	}
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 671273e..348eb00 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -8,6 +8,7 @@
 #ifndef _SELINUX_SECURITY_H_
 #define _SELINUX_SECURITY_H_
 
+#include <linux/dcache.h>
 #include <linux/magic.h>
 #include <linux/types.h>
 #include "flask.h"
@@ -28,13 +29,14 @@
 #define POLICYDB_VERSION_POLCAP		22
 #define POLICYDB_VERSION_PERMISSIVE	23
 #define POLICYDB_VERSION_BOUNDARY	24
+#define POLICYDB_VERSION_FILENAME_TRANS	25
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
 #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
 #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
 #else
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_BOUNDARY
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_FILENAME_TRANS
 #endif
 
 /* Mask for just the mount related flags */
@@ -106,8 +108,8 @@ void security_compute_av(u32 ssid, u32 tsid,
 void security_compute_av_user(u32 ssid, u32 tsid,
 			     u16 tclass, struct av_decision *avd);
 
-int security_transition_sid(u32 ssid, u32 tsid,
-			    u16 tclass, u32 *out_sid);
+int security_transition_sid(u32 ssid, u32 tsid, u16 tclass,
+			    const struct qstr *qstr, u32 *out_sid);
 
 int security_transition_sid_user(u32 ssid, u32 tsid,
 				 u16 tclass, u32 *out_sid);
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index dff0c75..39aae08 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -14,7 +14,7 @@
  *
  * Copyright (C) 2003 Tresys Technology, LLC
  *	This program is free software; you can redistribute it and/or modify
- *  	it under the terms of the GNU General Public License as published by
+ *	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
  *
  * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
@@ -27,16 +27,16 @@ struct avtab_key {
 	u16 source_type;	/* source type */
 	u16 target_type;	/* target type */
 	u16 target_class;	/* target object class */
-#define AVTAB_ALLOWED     1
-#define AVTAB_AUDITALLOW  2
-#define AVTAB_AUDITDENY   4
-#define AVTAB_AV         (AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
-#define AVTAB_TRANSITION 16
-#define AVTAB_MEMBER     32
-#define AVTAB_CHANGE     64
-#define AVTAB_TYPE       (AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
-#define AVTAB_ENABLED_OLD    0x80000000 /* reserved for used in cond_avtab */
-#define AVTAB_ENABLED    0x8000 /* reserved for used in cond_avtab */
+#define AVTAB_ALLOWED		0x0001
+#define AVTAB_AUDITALLOW	0x0002
+#define AVTAB_AUDITDENY		0x0004
+#define AVTAB_AV		(AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
+#define AVTAB_TRANSITION	0x0010
+#define AVTAB_MEMBER		0x0020
+#define AVTAB_CHANGE		0x0040
+#define AVTAB_TYPE		(AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
+#define AVTAB_ENABLED_OLD   0x80000000 /* reserved for used in cond_avtab */
+#define AVTAB_ENABLED		0x8000 /* reserved for used in cond_avtab */
 	u16 specified;	/* what field is specified */
 };
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index be9de38..159c818 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -123,6 +123,11 @@ static struct policydb_compat_info policydb_compat[] = {
 		.sym_num	= SYM_NUM,
 		.ocon_num	= OCON_NUM,
 	},
+	{
+		.version	= POLICYDB_VERSION_FILENAME_TRANS,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
+	},
 };
 
 static struct policydb_compat_info *policydb_lookup_compat(int version)
@@ -704,6 +709,7 @@ void policydb_destroy(struct policydb *p)
 	int i;
 	struct role_allow *ra, *lra = NULL;
 	struct role_trans *tr, *ltr = NULL;
+	struct filename_trans *ft, *nft;
 
 	for (i = 0; i < SYM_NUM; i++) {
 		cond_resched();
@@ -781,6 +787,15 @@ void policydb_destroy(struct policydb *p)
 		}
 		flex_array_free(p->type_attr_map_array);
 	}
+
+	ft = p->filename_trans;
+	while (ft) {
+		nft = ft->next;
+		kfree(ft->name);
+		kfree(ft);
+		ft = nft;
+	}
+
 	ebitmap_destroy(&p->policycaps);
 	ebitmap_destroy(&p->permissive_map);
 
@@ -1788,6 +1803,76 @@ out:
 	return rc;
 }
 
+static int filename_trans_read(struct policydb *p, void *fp)
+{
+	struct filename_trans *ft, *last;
+	u32 nel, len;
+	char *name;
+	__le32 buf[4];
+	int rc, i;
+
+	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
+		return 0;
+
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc)
+		goto out;
+	nel = le32_to_cpu(buf[0]);
+
+	printk(KERN_ERR "%s: nel=%d\n", __func__, nel);
+
+	last = p->filename_trans;
+	while (last && last->next)
+		last = last->next;
+
+	for (i = 0; i < nel; i++) {
+		rc = -ENOMEM;
+		ft = kzalloc(sizeof(*ft), GFP_KERNEL);
+		if (!ft)
+			goto out;
+
+		/* add it to the tail of the list */
+		if (!last)
+			p->filename_trans = ft;
+		else
+			last->next = ft;
+		last = ft;
+
+		/* length of the path component string */
+		rc = next_entry(buf, fp, sizeof(u32));
+		if (rc)
+			goto out;
+		len = le32_to_cpu(buf[0]);
+
+		rc = -ENOMEM;
+		name = kmalloc(len + 1, GFP_KERNEL);
+		if (!name)
+			goto out;
+
+		ft->name = name;
+
+		/* path component string */
+		rc = next_entry(name, fp, len);
+		if (rc)
+			goto out;
+		name[len] = 0;
+
+		printk(KERN_ERR "%s: ft=%p ft->name=%p ft->name=%s\n", __func__, ft, ft->name, ft->name);
+
+		rc = next_entry(buf, fp, sizeof(u32) * 4);
+		if (rc)
+			goto out;
+
+		ft->stype = le32_to_cpu(buf[0]);
+		ft->ttype = le32_to_cpu(buf[1]);
+		ft->tclass = le32_to_cpu(buf[2]);
+		ft->otype = le32_to_cpu(buf[3]);
+	}
+	rc = 0;
+out:
+	return rc;
+}
+
 static int genfs_read(struct policydb *p, void *fp)
 {
 	int i, j, rc;
@@ -2251,6 +2336,10 @@ int policydb_read(struct policydb *p, void *fp)
 		lra = ra;
 	}
 
+	rc = filename_trans_read(p, fp);
+	if (rc)
+		goto bad;
+
 	rc = policydb_index(p);
 	if (rc)
 		goto bad;
@@ -3025,6 +3114,43 @@ static int range_write(struct policydb *p, void *fp)
 	return 0;
 }
 
+static int filename_trans_write(struct policydb *p, void *fp)
+{
+	struct filename_trans *ft;
+	u32 len, nel = 0;
+	__le32 buf[4];
+	int rc;
+
+	for (ft = p->filename_trans; ft; ft = ft->next)
+		nel++;
+
+	buf[0] = cpu_to_le32(nel);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	for (ft = p->filename_trans; ft; ft = ft->next) {
+		len = strlen(ft->name);
+		buf[0] = cpu_to_le32(len);
+		rc = put_entry(buf, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+
+		rc = put_entry(ft->name, sizeof(char), len, fp);
+		if (rc)
+			return rc;
+
+		buf[0] = ft->stype;
+		buf[1] = ft->ttype;
+		buf[2] = ft->tclass;
+		buf[3] = ft->otype;
+
+		rc = put_entry(buf, sizeof(u32), 4, fp);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
 /*
  * Write the configuration data in a policy database
  * structure to a policy database binary representation
@@ -3135,6 +3261,10 @@ int policydb_write(struct policydb *p, void *fp)
 	if (rc)
 		return rc;
 
+	rc = filename_trans_write(p, fp);
+	if (rc)
+		return rc;
+
 	rc = ocontext_write(p, info, fp);
 	if (rc)
 		return rc;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 4e3ab9d..732ea4a 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -77,6 +77,15 @@ struct role_trans {
 	struct role_trans *next;
 };
 
+struct filename_trans {
+	struct filename_trans *next;
+	u32 stype;		/* current process */
+	u32 ttype;		/* parent dir context */
+	u16 tclass;		/* class of new object */
+	const char *name;	/* last path component */
+	u32 otype;		/* expected of new object */
+};
+
 struct role_allow {
 	u32 role;		/* current role */
 	u32 new_role;		/* new role */
@@ -217,6 +226,9 @@ struct policydb {
 	/* role transitions */
 	struct role_trans *role_tr;
 
+	/* file transitions with the last path component */
+	struct filename_trans *filename_trans;
+
 	/* bools indexed by (value - 1) */
 	struct cond_bool_datum **bool_val_to_struct;
 	/* type enforcement conditional access vectors and transitions */
@@ -302,7 +314,7 @@ static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)
 	return 0;
 }
 
-static inline int put_entry(void *buf, size_t bytes, int num, struct policy_file *fp)
+static inline int put_entry(const void *buf, size_t bytes, int num, struct policy_file *fp)
 {
 	size_t len = bytes * num;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a03cfaf..2e36e03 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1343,10 +1343,27 @@ out:
 	return -EACCES;
 }
 
+static void filename_compute_type(struct policydb *p, struct context *newcontext,
+				  u32 scon, u32 tcon, u16 tclass,
+				  const struct qstr *qstr)
+{
+	struct filename_trans *ft;
+	for (ft = p->filename_trans; ft; ft = ft->next) {
+		if (ft->stype == scon &&
+		    ft->ttype == tcon &&
+		    ft->tclass == tclass &&
+		    !strcmp(ft->name, qstr->name)) {
+			newcontext->type = ft->otype;
+			return;
+		}
+	}
+}
+
 static int security_compute_sid(u32 ssid,
 				u32 tsid,
 				u16 orig_tclass,
 				u32 specified,
+				const struct qstr *qstr,
 				u32 *out_sid,
 				bool kern)
 {
@@ -1442,6 +1459,11 @@ static int security_compute_sid(u32 ssid,
 		newcontext.type = avdatum->data;
 	}
 
+	/* if we have a qstr this is a file trans check so check those rules */
+	if (qstr)
+		filename_compute_type(&policydb, &newcontext, scontext->type,
+				      tcontext->type, tclass, qstr);
+
 	/* Check for class-specific changes. */
 	if  (tclass == policydb.process_class) {
 		if (specified & AVTAB_TRANSITION) {
@@ -1495,22 +1517,17 @@ out:
  * if insufficient memory is available, or %0 if the new SID was
  * computed successfully.
  */
-int security_transition_sid(u32 ssid,
-			    u32 tsid,
-			    u16 tclass,
-			    u32 *out_sid)
+int security_transition_sid(u32 ssid, u32 tsid, u16 tclass,
+			    const struct qstr *qstr, u32 *out_sid)
 {
 	return security_compute_sid(ssid, tsid, tclass, AVTAB_TRANSITION,
-				    out_sid, true);
+				    qstr, out_sid, true);
 }
 
-int security_transition_sid_user(u32 ssid,
-				 u32 tsid,
-				 u16 tclass,
-				 u32 *out_sid)
+int security_transition_sid_user(u32 ssid, u32 tsid, u16 tclass, u32 *out_sid)
 {
 	return security_compute_sid(ssid, tsid, tclass, AVTAB_TRANSITION,
-				    out_sid, false);
+				    NULL, out_sid, false);
 }
 
 /**
@@ -1531,8 +1548,8 @@ int security_member_sid(u32 ssid,
 			u16 tclass,
 			u32 *out_sid)
 {
-	return security_compute_sid(ssid, tsid, tclass, AVTAB_MEMBER, out_sid,
-				    false);
+	return security_compute_sid(ssid, tsid, tclass, AVTAB_MEMBER, NULL,
+				    out_sid, false);
 }
 
 /**
@@ -1553,8 +1570,8 @@ int security_change_sid(u32 ssid,
 			u16 tclass,
 			u32 *out_sid)
 {
-	return security_compute_sid(ssid, tsid, tclass, AVTAB_CHANGE, out_sid,
-				    false);
+	return security_compute_sid(ssid, tsid, tclass, AVTAB_CHANGE, NULL,
+				    out_sid, false);
 }
 
 /* Clone the SID into the new SID table. */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
