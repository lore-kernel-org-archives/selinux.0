Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1LLX6Gt012140
	for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2006 16:33:06 -0500
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1LLVcSL008326
	for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2006 21:31:39 GMT
Message-ID: <43FB86DD.2020708@trustedcs.com>
Date: Tue, 21 Feb 2006 15:32:13 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        Dustin Kirkland <dustin.kirkland@us.ibm.com>,
        Amy Griffis <amy.griffis@hp.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
        James Morris <jmorris@namei.org>
Subject: [PATCH] context based audit filtering (take 3)
References: <43F49805.2000109@trustedcs.com>
In-Reply-To: <43F49805.2000109@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for everyone's feedback on the original patch.  This is basically
a rewrite that does the following:

1) Add a callback mechanism for the audit facility to rebuild the selinux
   audit filters upon policy reload.  This callback should re-init the
   selinux rules to sync them with the currently loaded policy.
2) Make the matching function read-only.  This is accomplished with the help
   of #1.  If a stale rule (on that does not match the current policy) is
   used, the matching function will return an error - I think this should
   be treated as a match by audit to avoid potential data loss.
3) The whole "skip" mechanism has been removed (I think this idea should be
   retained and implemented in the audit code, for reason previously stated).
   This means that -EINVAL is returned for when adding a rule for an item
   that are not valid in the currently loaded policy.
5) The private copies of the operator, field, and target string have been
   removed.  The op and field are now passed in via the matching function and
   the string is no longer necessary after #3.
6) Fixed mls comparison logic.
7) Also fixed a bug when processing mls levels.

The outstanding things I can think of are:

1) Add role <, >, <=, and >= operations.
2) Implement the callback function in the audit code.  I have a functional
   version that does not follow proper locking - I just need to get that
   cleaned up.
3) Update Dustin's work to the latest API.  I already did this along with
   my start at #2.  I'll post that all in a follow-up.

Anything else that I forgot on that list?

I believe that this patch should be sufficient and that only additional work
in the selinux code would be to add the role dominance support.  I'd say that
we should wait on that until we do the object filter support.  I think this
patch is ready to go, barring negative feedback here.

-- 

Darrel


Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>


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
index 0000000..7b8cb41
--- /dev/null
+++ b/include/linux/selinux.h
@@ -0,0 +1,108 @@
+/*
+ * SELinux services exported to the rest of the kernel.
+ *
+ * Author: James Morris <jmorris@redhat.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ * Copyright (C) 2006 Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
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
+struct selinux_audit_rule;
+
+/**
+ *	selinux_audit_rule_init - alloc/init an selinux audit rule structure.
+ *	@field: the field this rule refers to
+ *	@op: the operater the rule uses
+ *	@rulestr: the text "target" of the rule
+ *	@rule: pointer to the new rule structure returned via this
+ *
+ *	Returns 0 if successful, -errno if not.  On success, the rule structure
+ *	will be allocated internally.  The caller must free this structure with
+ *	selinux_audit_rule_free() after use.
+ */
+int selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
+                            struct selinux_audit_rule **rule);
+
+/**
+ *	selinux_audit_rule_free - free an selinux audit rule structure.
+ *	@rule: pointer to the audit rule to be freed
+ *
+ *	This will free all memory associated with the given rule.
+ *	If @rule is NULL, no operation is performed.
+ */
+void selinux_audit_rule_free(struct selinux_audit_rule *rule);
+
+/**
+ *	selinux_audit_rule_match - determine if a context ID matches a rule.
+ *	@ctxid: the context ID to check
+ *	@field: the field this rule refers to
+ *	@op: the operater the rule uses
+ *	@rule: pointer to the audit rule to check against
+ *
+ *	Returns 1 if the context id matches the rule, 0 if it does not, and
+ *	-errno on failure.
+ */
+int selinux_audit_rule_match(u32 ctxid, u32 field, u32 op,
+                             struct selinux_audit_rule *rule);
+
+/**
+ *	selinux_audit_set_callback - set the callback for policy reloads.
+ *	@callback: the function to call when the policy is reloaded
+ *
+ *	This sets the function callback function that will update the rules
+ *	upon policy reloads.  This callback should rebuild all existing rules
+ *	using selinux_audit_rule_init().
+ */
+void selinux_audit_set_callback(int (*callback)(void));
+
+/**
+ *	selinux_task_ctxid - determine a context ID for a process.
+ *	@tsk: the task object
+ *	@ctxid: ID value returned via this
+ *
+ *	On return, ctxid will contain an ID for the context.  This value
+ *	should only be used opaquely.
+ */
+void selinux_task_ctxid(struct task_struct *tsk, u32 *ctxid);
+
+#else
+
+static inline int selinux_audit_rule_init(u32 field, u32 op,
+                                          char *rulestr,
+                                          struct selinux_audit_rule **rule)
+{
+	return -ENOTSUPP;
+}
+
+static inline void selinux_audit_rule_free(struct selinux_audit_rule *rule)
+{
+	return;
+}
+
+static inline int selinux_audit_rule_match(u32 ctxid, u32 field, u32 op,
+                                           struct selinux_audit_rule *rule)
+{
+	return 0;
+}
+
+static inline void selinux_audit_set_callback(int (*callback)(void))
+{
+	return;
+}
+
+static inline void selinux_task_ctxid(struct task_struct *tsk, u32 *ctxid)
+{
+	*ctxid = 0;
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
index 0000000..5129add
--- /dev/null
+++ b/security/selinux/exports.c
@@ -0,0 +1,48 @@
+/*
+ * SELinux services exported to the rest of the kernel.
+ *
+ * Author: James Morris <jmorris@redhat.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ * Copyright (C) 2006 Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
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
+int selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
+                            struct selinux_audit_rule **rule)
+{
+	return security_aurule_init(field, op, rulestr, rule);
+}
+
+void selinux_audit_rule_free(struct selinux_audit_rule *rule)
+{
+	return security_aurule_free(rule);
+}
+
+int selinux_audit_rule_match(u32 ctxid, u32 field, u32 op,
+                             struct selinux_audit_rule *rule)
+{
+	return security_aurule_match(ctxid, field, op, rule);
+}
+
+void selinux_audit_set_callback(int (*callback)(void))
+{
+	security_aurule_set_callback(callback);
+}
+
+void selinux_task_ctxid(struct task_struct *tsk, u32 *ctxid)
+{
+	struct task_security_struct *tsec = tsk->security;
+	*ctxid = tsec->sid;
+}
+EXPORT_SYMBOL_GPL(selinux_task_ctxid);
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 5f016c9..bc75a26 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -96,5 +96,13 @@ int security_fs_use(const char *fstype, 
 int security_genfs_sid(const char *fstype, char *name, u16 sclass,
 	u32 *sid);
 
+struct selinux_audit_rule;
+int security_aurule_init(u32 field, u32 op, char *rulestr,
+                         struct selinux_audit_rule **rule);
+void security_aurule_free(struct selinux_audit_rule *rule);
+int security_aurule_match(u32 ctxid, u32 field, u32 op,
+                          struct selinux_audit_rule *rule);
+void security_aurule_set_callback(int (*callback)(void));
+
 #endif /* _SELINUX_SECURITY_H_ */
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d877cd1..5e05c5a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -7,12 +7,13 @@
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
  *
  *	Support for enhanced MLS infrastructure.
+ *	Support for context based audit filters.
  *
  * Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
  *
  * 	Added conditional policy language extensions
  *
- * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
+ * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *	This program is free software; you can redistribute it and/or modify
@@ -1810,3 +1811,238 @@ out:
 	POLICY_RDUNLOCK;
 	return rc;
 }
+
+struct selinux_audit_rule {
+	u32 au_seqno;
+	struct context au_ctxt;
+};
+
+int security_aurule_init(u32 field, u32 op, char *rulestr,
+                         struct selinux_audit_rule **rule)
+{
+	struct selinux_audit_rule *tmprule;
+	struct role_datum *roledatum;
+	struct type_datum *typedatum;
+	struct user_datum *userdatum;
+	char *tmpstr, *freestr;
+	int rc = 0;
+
+	*rule = NULL;
+
+	if (!ss_initialized)
+		return -ENOTSUPP;
+
+	switch (field) {
+	case AUDIT_SE_USER:
+	case AUDIT_SE_ROLE:
+	case AUDIT_SE_TYPE:
+		/* only 'equals' and 'not equals' fit user, role, and type */
+		if (op != AUDIT_EQUAL && op != AUDIT_NOT_EQUAL)
+			return -EINVAL;
+		break;
+	case AUDIT_SE_SEN:
+	case AUDIT_SE_CLR:
+		/* we do not allow a range, indicated by the presense of '-' */
+		if (strchr(rulestr, '-'))
+			return -EINVAL;
+		break;
+	default:
+		/* only the above fileds are valid */
+		return -EINVAL;
+	}
+
+	tmprule = kzalloc(sizeof(struct selinux_audit_rule), GFP_KERNEL);
+	if (!tmprule)
+		return -ENOMEM;
+
+	context_init(&tmprule->au_ctxt);
+
+	POLICY_RDLOCK;
+
+	tmprule->au_seqno = latest_granting;
+
+	switch (field) {
+	case AUDIT_SE_USER:
+		userdatum = hashtab_search(policydb.p_users.table, rulestr);
+		if (!userdatum)
+			rc = -EINVAL;
+		else
+			tmprule->au_ctxt.user = userdatum->value;
+		break;
+	case AUDIT_SE_ROLE:
+		roledatum = hashtab_search(policydb.p_roles.table, rulestr);
+		if (!roledatum)
+			rc = -EINVAL;
+		else
+			tmprule->au_ctxt.role = roledatum->value;
+		break;
+	case AUDIT_SE_TYPE:
+		typedatum = hashtab_search(policydb.p_types.table, rulestr);
+		if (!typedatum)
+			rc = -EINVAL;
+		else
+			tmprule->au_ctxt.type = typedatum->value;
+		break;
+	case AUDIT_SE_SEN:
+	case AUDIT_SE_CLR:
+		/* we need freestr because mls_context_to_sid will change
+		   the value of tmpstr */
+		tmpstr = freestr = kstrdup(rulestr, GFP_ATOMIC);
+		if (!tmpstr) {
+			rc = -ENOMEM;
+		} else {
+			rc = mls_context_to_sid(':', &tmpstr, &tmprule->au_ctxt,
+			                        NULL, SECSID_NULL);
+			kfree(freestr);
+		}
+		break;
+	}
+
+	POLICY_RDUNLOCK;
+
+	if (rc) {
+		security_aurule_free(tmprule);
+		tmprule = NULL;
+	}
+
+	*rule = tmprule;
+
+	return rc;
+}
+
+void security_aurule_free(struct selinux_audit_rule *rule)
+{
+	if (rule) {
+		context_destroy(&rule->au_ctxt);
+		kfree(rule);
+	}
+}
+
+int security_aurule_match(u32 ctxid, u32 field, u32 op,
+                          struct selinux_audit_rule *rule)
+{
+	struct context *ctxt;
+	struct mls_level *level;
+	int match = 0;
+
+	if (!rule)
+		return 0;
+
+	POLICY_RDLOCK;
+
+	if (rule->au_seqno < latest_granting) {
+		match = -ESTALE;
+		goto out;
+	}
+
+	ctxt = sidtab_search(&sidtab, ctxid);
+	if (!ctxt) {
+		printk(KERN_ERR "security_aurule_match: unrecognized SID %d\n",
+		       ctxid);
+		match = -EINVAL;
+		goto out;
+	}
+
+	/* a field/op pair that is not caught here will simply fall through
+	   without a match */
+	switch (field) {
+	case AUDIT_SE_USER:
+		switch (op) {
+		case AUDIT_EQUAL:
+			match = (ctxt->user == rule->au_ctxt.user);
+			break;
+		case AUDIT_NOT_EQUAL:
+			match = (ctxt->user != rule->au_ctxt.user);
+			break;
+		}
+		break;
+	case AUDIT_SE_ROLE:
+		switch (op) {
+		case AUDIT_EQUAL:
+			match = (ctxt->role == rule->au_ctxt.role);
+			break;
+		case AUDIT_NOT_EQUAL:
+			match = (ctxt->role != rule->au_ctxt.role);
+			break;
+		}
+		break;
+	case AUDIT_SE_TYPE:
+		switch (op) {
+		case AUDIT_EQUAL:
+			match = (ctxt->type == rule->au_ctxt.type);
+			break;
+		case AUDIT_NOT_EQUAL:
+			match = (ctxt->type != rule->au_ctxt.type);
+			break;
+		}
+		break;
+	case AUDIT_SE_SEN:
+	case AUDIT_SE_CLR:
+		level = (op == AUDIT_SE_SEN ?
+		         &ctxt->range.level[0] : &ctxt->range.level[1]);
+		switch (op) {
+		case AUDIT_EQUAL:
+			match = mls_level_eq(&rule->au_ctxt.range.level[0],
+			                     level);
+			break;
+		case AUDIT_NOT_EQUAL:
+			match = !mls_level_eq(&rule->au_ctxt.range.level[0],
+			                      level);
+			break;
+		case AUDIT_LESS_THAN:
+			match = (mls_level_dom(&rule->au_ctxt.range.level[0],
+			                       level) &&
+			         !mls_level_eq(&rule->au_ctxt.range.level[0],
+			                       level));
+			break;
+		case AUDIT_LESS_THAN_OR_EQUAL:
+			match = mls_level_dom(&rule->au_ctxt.range.level[0],
+			                      level);
+			break;
+		case AUDIT_GREATER_THAN:
+			match = (mls_level_dom(level,
+			                      &rule->au_ctxt.range.level[0]) &&
+			         !mls_level_eq(level,
+			                       &rule->au_ctxt.range.level[0]));
+			break;
+		case AUDIT_GREATER_THAN_OR_EQUAL:
+			match = mls_level_dom(level,
+			                      &rule->au_ctxt.range.level[0]);
+			break;
+		}
+	}
+
+out:
+	POLICY_RDUNLOCK;
+	return match;
+}
+
+static int (*aurule_callback)(void) = NULL;
+
+static int aurule_avc_callback(u32 event, u32 ssid, u32 tsid,
+                               u16 class, u32 perms, u32 *retained)
+{
+	int err = 0;
+
+	if (event == AVC_CALLBACK_RESET && aurule_callback)
+		err = aurule_callback();
+	return err;
+}
+
+static int __init aurule_init(void)
+{
+	int err;
+
+	err = avc_add_callback(aurule_avc_callback, AVC_CALLBACK_RESET,
+	                       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
+	if (err)
+		panic("avc_add_callback() failed, error %d\n", err);
+
+	return err;
+}
+__initcall(aurule_init);
+
+void security_aurule_set_callback(int (*callback)(void))
+{
+	aurule_callback = callback;
+}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
