Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1GFJpXf028008
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 10:19:51 -0500 (EST)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1GFJm8P021603
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 15:19:48 GMT
Message-ID: <43F49805.2000109@trustedcs.com>
Date: Thu, 16 Feb 2006 09:19:33 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>
Subject: [RFC] [PATCH] 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

This patch provides the selinux "backend" for the audit system to perform
filtering based on the process context.  Dustin Kirkland has previously
a portion of this functionality here:

http://www.redhat.com/archives/linux-audit/2006-February/msg00004.html

This interfaces included in this patch will allow selinux to perform more
efficient matches based on lower level constructs within the selinux module,
rather than relying on string comparisons.  It also allows for dominance checks
on the mls portion of the contexts that are impossible with only string
comparisons.  Dustin's previous patch will be modified to take advantage of
the new interface.

This is still a work in progress (I'm guessing that the conversion of Dustin's
earlier work will point out some improvements to these interfaces).  I also
need to check the context of memory allocations.

I'm only allow == and != for type, role, and user because they seemed to be
the only ones that make sense, is that OK, or should I take them all even
though they may not do anything useful?  Does the general approach seem acceptable?

The patch is against Al Viro's audit tree:
http://www.kernel.org/git/?p=linux/kernel/git/viro/audit-current.git;a=summary


diff --git a/include/linux/audit.h b/include/linux/audit.h
index 4bb4b9f..dd4f759 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -140,6 +140,11 @@
 #define AUDIT_PERS	10
 #define AUDIT_ARCH	11
 #define AUDIT_MSGTYPE	12
+#define AUDIT_SE_USER	13	/* security label user */
+#define AUDIT_SE_ROLE	14	/* security label role */
+#define AUDIT_SE_TYPE	15	/* security label type */
+#define AUDIT_SE_SEN	16	/* security label sensitivity label */
+#define AUDIT_SE_CLR	17	/* security label clearance label */
 
 				/* These are ONLY useful when checking
 				 * at syscall exit time (AUDIT_AT_EXIT). */
diff --git a/include/linux/selinux.h b/include/linux/selinux.h
new file mode 100644
index 0000000..5a402a5
--- /dev/null
+++ b/include/linux/selinux.h
@@ -0,0 +1,83 @@
+/*
+ * SELinux services exported to the rest of the kernel.
+ *
+ * Author: James Morris <jmorris@redhat.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ * Copyright (C) 2006 Trusted Computer Solutions <dgoeddel@trustedcs.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2,
+ * as published by the Free Software Foundation.
+ */
+#ifndef _LINUX_SELINUX_H
+#define _LINUX_SELINUX_H
+
+#ifdef CONFIG_SECURITY_SELINUX
+
+/**
+ *	selinux_audit_rule_init - alloc/init an selinux audit rule structure.
+ *	@field: the field this rule refers to
+ *	@op: the operater the rule uses
+ *	@rulestr: the text "target" of the rule
+ *	@rule: address of the rule structure pointer to be returned
+ *
+ *	Returns 0 if successful, -errno if not.  On success, the rule structure
+ *	will be allocated internally.  The caller must free this structure with
+ *	selinux_audit_rule_free() after use.
+ */
+int selinux_audit_rule_init(u32 field, u32 op, const char *rulestr,
+                            void **rule);
+
+/**
+ *	selinux_audit_rule_free - free an selinux audit rule structure.
+ *	@rule: address of the seliux_audit_rule structure to be freed
+ *
+ *	This will free all memory associated with the given rule.
+ */
+void selinux_audit_rule_free(void *rule);
+
+/**
+ *	selinux_audit_rule_match - determine if a context ID matches a rule.
+ *	@ctxid: the context ID to check
+ *	@rule: the audit rule created by selinux_audit_rule_init()
+ *
+ *	Returns 1 if the context id matches the rule, 0 if it does not, and
+ *	-errno on failure.
+ */
+int selinux_audit_rule_match(u32 ctxid, void *rule);
+
+/**
+ *	selinux_task_getsecid - retrieve the context ID of a process.
+ *	@tsk: the task_struct of the process we are interested in
+ *
+ *	Returns the context ID of the process.
+ */
+
+int selinux_task_getsecid(struct task_struct *tsk);
+
+#else
+
+int selinux_audit_rule_init(u32 field, u32 op, const char *rulestr, void **rule)
+{
+	return -ENOTSUPP;
+}
+
+void selinux_audit_rule_free(void *rule)
+{
+	return;
+}
+
+int selinux_audit_rule_match(u32 ctxid, void *rule)
+{
+	return 0;
+}
+
+int selinux_task_getsecid(struct task_struct *tsk)
+{
+	return 0;
+}
+
+#endif	/* CONFIG_SECURITY_SELINUX */
+
+#endif /* _LINUX_SELINUX_H */
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 688c0a2..faf2e02 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o ss/
 
-selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o
+selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o exports.o
 
 selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
 
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
new file mode 100644
index 0000000..a44e301
--- /dev/null
+++ b/security/selinux/exports.c
@@ -0,0 +1,44 @@
+/*
+ * SELinux services exported to the rest of the kernel.
+ *
+ * Author: James Morris <jmorris@redhat.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2,
+ * as published by the Free Software Foundation.
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/selinux.h>
+
+#include "security.h"
+#include "objsec.h"
+
+int selinux_audit_rule_init(u32 field, u32 op, const char *rulestr, void **rule)
+{
+	return security_aurule_init(field, op, rulestr, rule);
+}
+
+void selinux_audit_rule_free(void *rule)
+{
+	return security_aurule_free(rule);
+}
+
+int selinux_audit_rule_match(u32 ctxid, void *rule)
+{
+	return security_aurule_match(ctxid, rule);
+}
+
+int selinux_task_getsecid(struct task_struct *tsk)
+{
+	struct task_security_struct *tsec = tsk->security;
+	return tsec->sid;
+}
+
+EXPORT_SYMBOL_GPL(selinux_audit_rule_init);
+EXPORT_SYMBOL_GPL(selinux_audit_rule_free);
+EXPORT_SYMBOL_GPL(selinux_audit_rule_match);
+EXPORT_SYMBOL_GPL(selinux_task_getsecid);
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 5f016c9..bfea536 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -96,5 +96,9 @@ int security_fs_use(const char *fstype, 
 int security_genfs_sid(const char *fstype, char *name, u16 sclass,
 	u32 *sid);
 
+int security_aurule_init(u32 field, u32 op, const char *rulestr, void **rule);
+void security_aurule_free(void *rule);
+int security_aurule_match(u32 ctxid, void *rule);
+
 #endif /* _SELINUX_SECURITY_H_ */
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d877cd1..480df81 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1810,3 +1810,250 @@ out:
 	POLICY_RDUNLOCK;
 	return rc;
 }
+
+struct selinux_audit_rule {
+	u32 au_skip;
+	u32 au_op;
+	u32 au_field;
+	u32 au_seqno;
+	struct context au_ctxt;
+	char *au_str;
+};
+
+/* needs policy read lock held */
+static void aurule_init_context(struct selinux_audit_rule *aurule)
+{
+	struct role_datum *roledatum;
+	struct type_datum *typedatum;
+	struct user_datum *userdatum;
+	char *tmpstr;
+	int rc = 0;
+
+	switch (aurule->au_field) {
+	case AUDIT_SE_USER:
+		userdatum = hashtab_search(policydb.p_users.table,
+		                           aurule->au_str);
+		if (!userdatum)
+			rc = -EINVAL;
+		else
+			aurule->au_ctxt.user = userdatum->value;
+		break;
+	case AUDIT_SE_ROLE:
+		roledatum = hashtab_search(policydb.p_roles.table,
+		                           aurule->au_str);
+		if (!roledatum)
+			rc = -EINVAL;
+		else
+			aurule->au_ctxt.role = roledatum->value;
+		break;
+	case AUDIT_SE_TYPE:
+		typedatum = hashtab_search(policydb.p_types.table,
+		                           aurule->au_str);
+		if (!typedatum)
+			rc = -EINVAL;
+		else
+			aurule->au_ctxt.type = typedatum->value;
+		break;
+	case AUDIT_SE_SEN:
+	case AUDIT_SE_CLR:
+		/* TODO:figure out proper allocation below */
+		tmpstr = kstrdup(aurule->au_str, GFP_KERNEL);
+		rc = mls_context_to_sid(':', &tmpstr, &aurule->au_ctxt, NULL,
+		                        SECSID_NULL);
+		kfree(tmpstr);
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+
+	if (rc) {
+		aurule->au_skip = 1;
+		context_destroy(&aurule->au_ctxt);
+	} else {
+		/* we merely flags this rule to not be processed - the role,
+		   user, type, or level of the rule may not be valid now, but
+		   may be after a future policy reload. */
+		aurule->au_skip = 0;
+	}
+
+	return;
+}
+
+int security_aurule_init(u32 field, u32 op, const char *rulestr, void **rule)
+{
+	struct selinux_audit_rule *tmprule;
+
+	*rule = NULL;
+
+	switch (field) {
+	case AUDIT_SE_USER:
+	case AUDIT_SE_ROLE:
+	case AUDIT_SE_TYPE:
+		/* only 'equals' and 'not equals' make sense */
+		if (op != AUDIT_EQUAL && op != AUDIT_NOT_EQUAL)
+			return -EINVAL;
+	case AUDIT_SE_SEN:
+	case AUDIT_SE_CLR:
+		/* we do not allow a range, indicated by '-' */
+		if (strchr(rulestr, '-'))
+			return -EINVAL;
+	}
+
+	/* TODO:figure out proper allocations below */
+	tmprule = kzalloc(sizeof(struct selinux_audit_rule), GFP_KERNEL);
+	if (!tmprule)
+		return -ENOMEM;
+	tmprule->au_str = kstrdup(rulestr, GFP_KERNEL);
+	if (!tmprule->au_str) {
+		kfree(tmprule);
+		return -ENOMEM;
+	}
+	tmprule->au_op = op;
+	tmprule->au_field = field;
+	context_init(&tmprule->au_ctxt);
+
+	if (!ss_initialized) {
+		tmprule->au_seqno = latest_granting;
+		tmprule->au_skip = 1;
+		*rule = tmprule;
+		return 0;
+	}
+
+	POLICY_RDLOCK;
+
+	tmprule->au_seqno = latest_granting;
+	aurule_init_context(tmprule);
+
+	POLICY_RDUNLOCK;
+
+	*rule = tmprule;
+
+	return 0;
+}
+
+void security_aurule_free(void *rule)
+{
+	struct selinux_audit_rule *aurule = rule;
+
+	kfree(aurule->au_str);
+	context_destroy(&aurule->au_ctxt);
+	kfree(aurule);
+}
+
+int security_aurule_match(u32 ctxid, void *rule)
+{
+	struct selinux_audit_rule *aurule = rule;
+	struct context *ctxt;
+	struct mls_level *level;
+	int match = 0;
+
+	if (!rule || !ss_initialized)
+		return 0;
+
+	POLICY_RDLOCK;
+
+	if (aurule->au_seqno < latest_granting) {
+		context_destroy(&aurule->au_ctxt);
+		aurule->au_seqno = latest_granting;
+		aurule_init_context(aurule);
+	}
+
+	if (aurule->au_skip)
+		goto out;
+
+	ctxt = sidtab_search(&sidtab, ctxid);
+	if (!ctxt) {
+		/* TODO: what to do? */
+		printk(KERN_ERR "security_aurule_match: unrecognized SID %d\n",
+		       ctxid);
+		match = -EINVAL;
+		goto out;
+	}
+
+	switch (aurule->au_field) {
+	case AUDIT_SE_USER:
+		switch (aurule->au_op) {
+		case AUDIT_EQUAL:
+			match = (ctxt->user == aurule->au_ctxt.user);
+			break;
+		case AUDIT_NOT_EQUAL:
+			match = (ctxt->user != aurule->au_ctxt.user);
+			break;
+		default:
+			match = -EINVAL;
+			break;
+		}
+		break;
+	case AUDIT_SE_ROLE:
+		switch (aurule->au_op) {
+		case AUDIT_EQUAL:
+			match = (ctxt->role == aurule->au_ctxt.role);
+			break;
+		case AUDIT_NOT_EQUAL:
+			match = (ctxt->role != aurule->au_ctxt.role);
+			break;
+		default:
+			match = -EINVAL;
+			break;
+		}
+		break;
+	case AUDIT_SE_TYPE:
+		switch (aurule->au_op) {
+		case AUDIT_EQUAL:
+			match = (ctxt->type == aurule->au_ctxt.type);
+			break;
+		case AUDIT_NOT_EQUAL:
+			match = (ctxt->type != aurule->au_ctxt.type);
+			break;
+		default:
+			match = -EINVAL;
+			break;
+		}
+		break;
+	case AUDIT_SE_SEN:
+	case AUDIT_SE_CLR:
+		level = (aurule->au_op == AUDIT_SE_SEN ?
+		         &ctxt->range.level[0] : &ctxt->range.level[1]);
+		switch (aurule->au_op) {
+		case AUDIT_EQUAL:
+			match = mls_level_eq(&aurule->au_ctxt.range.level[0],
+			                     level);
+			break;
+		case AUDIT_NOT_EQUAL:
+			match = !mls_level_eq(&aurule->au_ctxt.range.level[0],
+			                      level);
+			break;
+		case AUDIT_LESS_THAN:
+			match = mls_level_dom(&aurule->au_ctxt.range.level[0],
+			                      level);
+			break;
+		case AUDIT_LESS_THAN_OR_EQUAL:
+			match = (mls_level_eq(&aurule->au_ctxt.range.level[0],
+			                      level) ||
+			         mls_level_dom(&aurule->au_ctxt.range.level[0],
+			                       level));
+			break;
+		case AUDIT_GREATER_THAN:
+			match = mls_level_dom(level,
+			                      &aurule->au_ctxt.range.level[0]);
+			break;
+		case AUDIT_GREATER_THAN_OR_EQUAL:
+			match = (mls_level_eq(&aurule->au_ctxt.range.level[0],
+			                      level) ||
+			         mls_level_dom(level,
+			                      &aurule->au_ctxt.range.level[0]));
+			break;
+		default:
+			match = -EINVAL;
+			break;
+		}
+	default:
+		match = -EINVAL;
+		break;
+	}
+
+out:
+	POLICY_RDUNLOCK;
+	return match;
+}

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
