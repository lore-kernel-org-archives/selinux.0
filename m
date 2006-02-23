Message-ID: <43FDF3EC.7000303@trustedcs.com>
Date: Thu, 23 Feb 2006 11:42:04 -0600
From: Darrel Goeddel <dgoeddel@trustedcs.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        Dustin Kirkland <dustin.kirkland@us.ibm.com>,
        Amy Griffis <amy.griffis@hp.com>, James Morris <jmorris@namei.org>
Subject: Re: [PATCH] context based audit filtering (take 4)
References: <43F49805.2000109@trustedcs.com>	 <43FB86DD.2020708@trustedcs.com> <1140619592.31467.218.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1140619592.31467.218.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-02-21 at 15:32 -0600, Darrel Goeddel wrote:
> 
>>diff --git a/security/selinux/exports.c b/security/selinux/exports.c
>>new file mode 100644
>>index 0000000..5129add
>>--- /dev/null
>>+++ b/security/selinux/exports.c
>>+int selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
>>+                            struct selinux_audit_rule **rule)
>>+{
>>+	return security_aurule_init(field, op, rulestr, rule);
>>+}
> 
> 
> I'd drop these wrapper functions, and just name the underlying functions
> in services.c with the exported names (i.e. selinux_ prefix).  The use
> of security_ prefix in the SELinux code should likely be converted in
> general to selinux_ (via separate patch) along with other namespace
> cleanups; it is a legacy of when SELinux was a kernel patch and there
> was no LSM.

Done.

>>diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>>index d877cd1..5e05c5a 100644
>>--- a/security/selinux/ss/services.c
>>+++ b/security/selinux/ss/services.c
> 
> <snip>
> 
>>+int security_aurule_init(u32 field, u32 op, char *rulestr,
>>+                         struct selinux_audit_rule **rule)
>>+{
> 
> <snip>
> 
>>+	case AUDIT_SE_SEN:
>>+	case AUDIT_SE_CLR:
>>+		/* we need freestr because mls_context_to_sid will change
>>+		   the value of tmpstr */
>>+		tmpstr = freestr = kstrdup(rulestr, GFP_ATOMIC);
>>+		if (!tmpstr) {
>>+			rc = -ENOMEM;
>>+		} else {
>>+			rc = mls_context_to_sid(':', &tmpstr, &tmprule->au_ctxt,
>>+			                        NULL, SECSID_NULL);
>>+			kfree(freestr);
>>+		}
> 
> 
> Let's move this into a helper in mls.c with a nicer interface, similar
> to what Ivan has done in libsepol (mls_from_string).

Done.

>>+int security_aurule_match(u32 ctxid, u32 field, u32 op,
>>+                          struct selinux_audit_rule *rule)
>>+{
>>+	struct context *ctxt;
>>+	struct mls_level *level;
>>+	int match = 0;
>>+
>>+	if (!rule)
>>+		return 0;
> 
> 
> Should this be an error?

I'll treat this as an error here.  If we decide to go with allowing invalid
to hang around waiting to become valid, we can conditionally call
selinux_audit_rule_match.

> 
>>+	ctxt = sidtab_search(&sidtab, ctxid);
>>+	if (!ctxt) {
>>+		printk(KERN_ERR "security_aurule_match: unrecognized SID %d\n",
>>+		       ctxid);
> 
> 
> Should we be using printk(KERN_ERR...) or
> audit_log(...AUDIT_SELINUX_ERR) for SELinux errors for all new code?

Switched to audit log.  I also now pass in the audit_context to
selinux_audit_rule_match so it gets used for the logging.

>>+		case AUDIT_LESS_THAN:
>>+			match = (mls_level_dom(&rule->au_ctxt.range.level[0],
>>+			                       level) &&
>>+			         !mls_level_eq(&rule->au_ctxt.range.level[0],
>>+			                       level));
>>+			break;
>>+		case AUDIT_LESS_THAN_OR_EQUAL:
>>+			match = mls_level_dom(&rule->au_ctxt.range.level[0],
>>+			                      level);
>>+			break;
> 
> 
> I'm not clear as to why we truly need both sets of operators in the
> audit filters (<= n versus just < (n+1)), but that is unrelated to
> SELinux per se.
> 
> I take it that you either decided against leveraging the constraint code
> or haven't looked at that option yet?  IOW, convert an audit filter to a
> constraint expression when the rule is initialized, and later just call
> a common helper shared with constraint_expr_eval?

I have briefly look into it.  No huge benefit jumped out at me right away,
but it is something I'll look into more later.

>>+static int (*aurule_callback)(void) = NULL;
>>+
>>+static int aurule_avc_callback(u32 event, u32 ssid, u32 tsid,
>>+                               u16 class, u32 perms, u32 *retained)
>>+{
>>+	int err = 0;
>>+
>>+	if (event == AVC_CALLBACK_RESET && aurule_callback)
>>+		err = aurule_callback();
>>+	return err;
>>+}
> 
> 
> Hmm...on an error return, we will stop walking the callback list
> presently on avc_ss_reset, which could prevent other callbacks (like the
> netif one) from occurring.  Likely should change that.  
> 

Done.

Here is a new one:


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
index 0000000..5abe524
--- /dev/null
+++ b/include/linux/selinux.h
@@ -0,0 +1,112 @@
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
+struct audit_context;
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
+ *	@actx: the audit context (can be NULL) associated with the check
+ *
+ *	Returns 1 if the context id matches the rule, 0 if it does not, and
+ *	-errno on failure.
+ */
+int selinux_audit_rule_match(u32 ctxid, u32 field, u32 op,
+                             struct selinux_audit_rule *rule,
+                             struct audit_context *actx);
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
+                                           struct selinux_audit_rule *rule,
+                                           struct audit_context *actx)
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
 
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index ac5d69b..a300702 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -800,7 +800,7 @@ out:
 int avc_ss_reset(u32 seqno)
 {
 	struct avc_callback_node *c;
-	int i, rc = 0;
+	int i, rc = 0, tmprc;
 	unsigned long flag;
 	struct avc_node *node;
 
@@ -813,15 +813,16 @@ int avc_ss_reset(u32 seqno)
 
 	for (c = avc_callbacks; c; c = c->next) {
 		if (c->events & AVC_CALLBACK_RESET) {
-			rc = c->callback(AVC_CALLBACK_RESET,
-					 0, 0, 0, 0, NULL);
-			if (rc)
-				goto out;
+			tmprc = c->callback(AVC_CALLBACK_RESET,
+			                    0, 0, 0, 0, NULL);
+			/* save the first error encountered for the return
+			   value and continue processing the callbacks */
+			if (!rc)
+				rc = tmprc;
 		}
 	}
 
 	avc_latest_notif_update(seqno, 0);
-out:
 	return rc;
 }
 
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
new file mode 100644
index 0000000..26ff66d
--- /dev/null
+++ b/security/selinux/exports.c
@@ -0,0 +1,25 @@
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
+void selinux_task_ctxid(struct task_struct *tsk, u32 *ctxid)
+{
+	struct task_security_struct *tsec = tsk->security;
+	*ctxid = tsec->sid;
+}
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 640d0bf..df358be 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -8,7 +8,7 @@
  *
  *	Support for enhanced MLS infrastructure.
  *
- * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
+ * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
  */
 
 #include <linux/kernel.h>
@@ -385,6 +385,31 @@ out:
 }
 
 /*
+ * Set the MLS fields in the security context structure
+ * `context' based on the string representation in
+ * the string `str'.  This function will allocate temporary memory with the
+ * given constraints of gfp_mask.
+ */
+int mls_from_string(char *str, struct context *context, gfp_t gfp_mask)
+{
+	char *tmpstr, *freestr;
+	int rc;
+
+	/* we need freestr because mls_context_to_sid will change
+	   the value of tmpstr */
+	tmpstr = freestr = kstrdup(str, gfp_mask);
+	if (!tmpstr) {
+		rc = -ENOMEM;
+	} else {
+		rc = mls_context_to_sid(':', &tmpstr, context,
+		                        NULL, SECSID_NULL);
+		kfree(freestr);
+	}
+
+	return rc;
+}
+
+/*
  * Copies the effective MLS range from `src' into `dst'.
  */
 static inline int mls_scopy_context(struct context *dst,
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index 03de697..fbb42f0 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -8,7 +8,7 @@
  *
  *	Support for enhanced MLS infrastructure.
  *
- * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
+ * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
  */
 
 #ifndef _SS_MLS_H_
@@ -27,6 +27,8 @@ int mls_context_to_sid(char oldc,
 		       struct sidtab *s,
 		       u32 def_sid);
 
+int mls_from_string(char *str, struct context *context, gfp_t gfp_mask);
+
 int mls_convert_context(struct policydb *oldp,
 			struct policydb *newp,
 			struct context *context);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d877cd1..a2ad2cd 100644
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
@@ -1810,3 +1811,235 @@ out:
 	POLICY_RDUNLOCK;
 	return rc;
 }
+
+struct selinux_audit_rule {
+	u32 au_seqno;
+	struct context au_ctxt;
+};
+
+void selinux_audit_rule_free(struct selinux_audit_rule *rule)
+{
+	if (rule) {
+		context_destroy(&rule->au_ctxt);
+		kfree(rule);
+	}
+}
+
+int selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
+                            struct selinux_audit_rule **rule)
+{
+	struct selinux_audit_rule *tmprule;
+	struct role_datum *roledatum;
+	struct type_datum *typedatum;
+	struct user_datum *userdatum;
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
+		rc = mls_from_string(rulestr, &tmprule->au_ctxt, GFP_ATOMIC);
+		break;
+	}
+
+	POLICY_RDUNLOCK;
+
+	if (rc) {
+		selinux_audit_rule_free(tmprule);
+		tmprule = NULL;
+	}
+
+	*rule = tmprule;
+
+	return rc;
+}
+
+int selinux_audit_rule_match(u32 ctxid, u32 field, u32 op,
+                             struct selinux_audit_rule *rule,
+                             struct audit_context *actx)
+{
+	struct context *ctxt;
+	struct mls_level *level;
+	int match = 0;
+
+	if (!rule) {
+		audit_log(actx, GFP_ATOMIC, AUDIT_SELINUX_ERR,
+		          "selinux_audit_rule_match: missing rule\n");
+		return -ENOENT;
+	}
+
+	POLICY_RDLOCK;
+
+	if (rule->au_seqno < latest_granting) {
+		audit_log(actx, GFP_ATOMIC, AUDIT_SELINUX_ERR,
+		          "selinux_audit_rule_match: stale rule\n");
+		match = -ESTALE;
+		goto out;
+	}
+
+	ctxt = sidtab_search(&sidtab, ctxid);
+	if (!ctxt) {
+		audit_log(actx, GFP_ATOMIC, AUDIT_SELINUX_ERR,
+		          "selinux_audit_rule_match: unrecognized SID %d\n",
+		          ctxid);
+		match = -ENOENT;
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
+void selinux_audit_set_callback(int (*callback)(void))
+{
+	aurule_callback = callback;
+}


-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
