Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l733XJ37016465
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 23:33:19 -0400
Received: from web36614.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l733XIG9015804
	for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2007 03:33:18 GMT
Date: Thu, 2 Aug 2007 20:33:09 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: [PATCH][RFC] V1 Remove SELinux dependencies from linux-audit via LSM
To: LSM List <linux-security-module@vger.kernel.org>,
        SELinux List <selinux@tycho.nsa.gov>,
        Audit List <linux-audit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <600616.50420.qm@web36614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Casey Schaufler <casey@schaufler-ca.com>

This patch removes SELinux specific code from the kernel auditing
system, replacing it with LSM hook invocations that perform the
functions appropriate to those behaviors.

The LSM interface is extended to provide interfaces for a module
to add audit filters. Interfaces are added to get secids from
inodes and ipcs.

The audit code is revised to call these hooks instead of the SELinux
functions. This requires some structure definitions to change header
files.

The SELinux code is changed to export the old interfaces as LSM hooks
instead of doing so directly. The SELinux specific audit filter code
has been moved into the SELinux module.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---

I hope for some suggestions regarding how appropriate the header file
changes I've made are. My confidence level in them is fairly low. Also,
in my haste to get some feedback the testing has been limited. There
are three projects (SELinux, audit, and LSM) whose code I've changed,
and I expect there may be differences of opinion about what's right,
what's wrong, and how to go about reconciling the differences. I see
this as the start.

Thank you.


diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
linux-2.6.22-base/include/linux/audit.h
linux-2.6.22-audit/include/linux/audit.h
--- linux-2.6.22-base/include/linux/audit.h	2007-07-08 16:32:17.000000000 -0700
+++ linux-2.6.22-audit/include/linux/audit.h	2007-08-01 21:55:10.000000000
-0700
@@ -321,20 +321,63 @@ struct audit_rule {		/* for AUDIT_LIST, 
 #ifdef __KERNEL__
 #include <linux/sched.h>
 
-struct audit_sig_info {
-	uid_t		uid;
-	pid_t		pid;
-	char		ctx[0];
-};
-
 struct audit_buffer;
 struct audit_context;
+struct audit_parent;
 struct inode;
 struct netlink_skb_parms;
 struct linux_binprm;
 struct mq_attr;
 struct mqstat;
 
+struct audit_sig_info {
+	uid_t		uid;
+	pid_t		pid;
+	char		ctx[0];
+};
+
+struct audit_watch {
+	atomic_t		count;	/* reference count */
+	char			*path;	/* insertion path */
+	dev_t			dev;	/* associated superblock device */
+	unsigned long		ino;	/* associated inode number */
+	struct audit_parent	*parent; /* associated parent */
+	struct list_head	wlist;	/* entry in parent->watches list */
+	struct list_head	rules;	/* associated rules */
+};
+
+struct audit_field {
+	u32				type;
+	u32				val;
+	u32				op;
+	char				*se_str;
+	struct selinux_audit_rule	*se_rule;
+};
+
+struct audit_krule {
+	int			vers_ops;
+	u32			flags;
+	u32			listnr;
+	u32			action;
+	u32			mask[AUDIT_BITMASK_SIZE];
+	u32			buflen; /* for data alloc on list rules */
+	u32			field_count;
+	char			*filterkey; /* ties events to rules */
+	struct audit_field	*fields;
+	struct audit_field	*arch_f; /* quick access to arch field */
+	struct audit_field	*inode_f; /* quick access to an inode field */
+	struct audit_watch	*watch;	/* associated watch */
+	struct list_head	rlist;	/* entry in audit_watch.rules list */
+};
+
+struct audit_entry {
+	struct list_head	list;
+	struct rcu_head		rcu;
+	struct audit_krule	rule;
+};
+
+extern int audit_rule_update_callout(void);
+
 #define AUDITSC_INVALID 0
 #define AUDITSC_SUCCESS 1
 #define AUDITSC_FAILURE 2
diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
linux-2.6.22-base/include/linux/security.h
linux-2.6.22-audit/include/linux/security.h
--- linux-2.6.22-base/include/linux/security.h	2007-07-08 16:32:17.000000000
-0700
+++ linux-2.6.22-audit/include/linux/security.h	2007-08-01 20:14:18.000000000
-0700
@@ -35,6 +35,8 @@
 #include <net/flow.h>
 
 struct ctl_table;
+struct audit_krule;
+struct selinux_audit_rule;
 
 /*
  * These functions are in security/capability.c and are used
@@ -1328,6 +1330,16 @@ struct security_operations {
  	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_t
size);
 	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
 	void (*release_secctx)(char *secdata, u32 seclen);
+	void (*inode_getsecid) (const struct inode *inode, u32 *secid);
+	void (*ipc_getsecid) (struct kern_ipc_perm *p, u32 *secid);
+	int (*audit_rule_supplied) (struct audit_krule *rule);
+	int (*audit_rule_match) (u32 sid, u32 field, u32 op,
+                          	 struct selinux_audit_rule *rule,
+                      	         struct audit_context *actx);
+	int (*audit_rule_init) (u32 field, u32 op, char *rulestr,
+                                struct selinux_audit_rule **rule);
+	void (*audit_rule_free) (struct selinux_audit_rule *rule);
+
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
@@ -2122,6 +2134,44 @@ static inline void security_release_secc
 	return security_ops->release_secctx(secdata, seclen);
 }
 
+static inline void security_inode_getsecid(const struct inode *inode,
+					    u32 *secid)
+{
+	security_ops->inode_getsecid(inode, secid);
+	return;
+}
+
+static inline void security_ipc_getsecid(struct kern_ipc_perm *p, u32 *secid)
+{
+	security_ops->ipc_getsecid(p, secid);
+	return;
+}
+
+static inline int security_audit_rule_supplied(struct audit_krule *rule)
+{
+	return security_ops->audit_rule_supplied(rule);
+}
+
+static inline int security_audit_rule_match(u32 sid, u32 field, u32 op,
+                      			    struct selinux_audit_rule *rule,
+                      			    struct audit_context *actx)
+{
+	return security_ops->audit_rule_match(sid, field, op, rule, actx);
+}
+
+static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
+					   struct selinux_audit_rule **rule)
+{
+	return security_ops->audit_rule_init(field, op, rulestr, rule);
+}
+
+static inline void security_audit_rule_free(struct selinux_audit_rule *rule)
+{
+	security_ops->audit_rule_free(rule);
+	return;
+}
+
+
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -2796,6 +2846,39 @@ static inline int security_secid_to_secc
 static inline void security_release_secctx(char *secdata, u32 seclen)
 {
 }
+
+static inline void security_inode_getsecid(const struct inode *inode,
+					    u32 *secid);
+{
+}
+
+static inline void security_ipc_getsecid(struct kern_ipc_perm *p, u32 *secid)
+{
+}
+
+static inline int security_audit_rule_supplied(struct audit_krule *rule)
+{
+	return 0;
+}
+
+static inline int security_audit_rule_match(u32 sid, u32 field, u32 op,
+                       			    struct selinux_audit_rule *rule,
+                      			    struct audit_context *actx)
+{
+	return;
+}
+
+static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
+					   struct selinux_audit_rule **rule)
+{
+	return 0;
+}
+
+static inline void security_audit_rule_free(struct selinux_audit_rule *rule)
+{
+	return;
+}
+
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
linux-2.6.22-base/include/linux/selinux.h
linux-2.6.22-audit/include/linux/selinux.h
--- linux-2.6.22-base/include/linux/selinux.h	2007-07-08 16:32:17.000000000
-0700
+++ linux-2.6.22-audit/include/linux/selinux.h	2007-08-01 12:21:16.000000000
-0700
@@ -60,16 +60,6 @@ int selinux_audit_rule_match(u32 sid, u3
                              struct audit_context *actx);
 
 /**
- *	selinux_audit_set_callback - set the callback for policy reloads.
- *	@callback: the function to call when the policy is reloaded
- *
- *	This sets the function callback function that will update the rules
- *	upon policy reloads.  This callback should rebuild all existing rules
- *	using selinux_audit_rule_init().
- */
-void selinux_audit_set_callback(int (*callback)(void));
-
-/**
  *     selinux_sid_to_string - map a security context ID to a string
  *     @sid: security context ID to be converted.
  *     @ctx: address of context string to be returned
@@ -151,11 +141,6 @@ static inline int selinux_audit_rule_mat
 	return 0;
 }
 
-static inline void selinux_audit_set_callback(int (*callback)(void))
-{
-	return;
-}
-
 static inline int selinux_sid_to_string(u32 sid, char **ctx, u32 *ctxlen)
 {
        *ctx = NULL;
diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
linux-2.6.22-base/kernel/audit.c linux-2.6.22-audit/kernel/audit.c
--- linux-2.6.22-base/kernel/audit.c	2007-07-08 16:32:17.000000000 -0700
+++ linux-2.6.22-audit/kernel/audit.c	2007-08-01 12:16:36.000000000 -0700
@@ -252,7 +252,7 @@ static int audit_set_rate_limit(int limi
 	if (sid) {
 		char *ctx = NULL;
 		u32 len;
-		if ((rc = selinux_sid_to_string(sid, &ctx, &len)) == 0) {
+		if ((rc = security_secid_to_secctx(sid, &ctx, &len)) == 0) {
 			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 				"audit_rate_limit=%d old=%d by auid=%u"
 				" subj=%s res=%d",
@@ -287,7 +287,7 @@ static int audit_set_backlog_limit(int l
 	if (sid) {
 		char *ctx = NULL;
 		u32 len;
-		if ((rc = selinux_sid_to_string(sid, &ctx, &len)) == 0) {
+		if ((rc = security_secid_to_secctx(sid, &ctx, &len)) == 0) {
 			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 				"audit_backlog_limit=%d old=%d by auid=%u"
 				" subj=%s res=%d",
@@ -325,7 +325,7 @@ static int audit_set_enabled(int state, 
 	if (sid) {
 		char *ctx = NULL;
 		u32 len;
-		if ((rc = selinux_sid_to_string(sid, &ctx, &len)) == 0) {
+		if ((rc = security_secid_to_secctx(sid, &ctx, &len)) == 0) {
 			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 				"audit_enabled=%d old=%d by auid=%u"
 				" subj=%s res=%d",
@@ -365,7 +365,7 @@ static int audit_set_failure(int state, 
 	if (sid) {
 		char *ctx = NULL;
 		u32 len;
-		if ((rc = selinux_sid_to_string(sid, &ctx, &len)) == 0) {
+		if ((rc = security_secid_to_secctx(sid, &ctx, &len)) == 0) {
 			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 				"audit_failure=%d old=%d by auid=%u"
 				" subj=%s res=%d",
@@ -590,7 +590,7 @@ static int audit_receive_msg(struct sk_b
 		if (status_get->mask & AUDIT_STATUS_PID) {
 			int old   = audit_pid;
 			if (sid) {
-				if ((err = selinux_sid_to_string(
+				if ((err = security_secid_to_secctx(
 						sid, &ctx, &len)))
 					return err;
 				else
@@ -628,7 +628,7 @@ static int audit_receive_msg(struct sk_b
 						 "user pid=%d uid=%u auid=%u",
 						 pid, uid, loginuid);
 				if (sid) {
-					if (selinux_sid_to_string(
+					if (security_secid_to_secctx(
 							sid, &ctx, &len)) {
 						audit_log_format(ab, 
 							" ssid=%u", sid);
@@ -657,7 +657,7 @@ static int audit_receive_msg(struct sk_b
 						 "pid=%d uid=%u auid=%u",
 						 pid, uid, loginuid);
 				if (sid) {
-					if (selinux_sid_to_string(
+					if (security_secid_to_secctx(
 							sid, &ctx, &len)) {
 						audit_log_format(ab,
 							" ssid=%u", sid);
@@ -691,7 +691,7 @@ static int audit_receive_msg(struct sk_b
 						 "pid=%d uid=%u auid=%u",
 						 pid, uid, loginuid);
 				if (sid) {
-					if (selinux_sid_to_string(
+					if (security_secid_to_secctx(
 							sid, &ctx, &len)) {
 						audit_log_format(ab,
 							" ssid=%u", sid);
@@ -714,7 +714,7 @@ static int audit_receive_msg(struct sk_b
 					   loginuid, sid);
 		break;
 	case AUDIT_SIGNAL_INFO:
-		err = selinux_sid_to_string(audit_sig_sid, &ctx, &len);
+		err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
 		if (err)
 			return err;
 		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
@@ -805,10 +805,6 @@ static int __init audit_init(void)
 	audit_initialized = 1;
 	audit_enabled = audit_default;
 
-	/* Register the callback with selinux.  This callback will be invoked
-	 * when a new policy is loaded. */
-	selinux_audit_set_callback(&selinux_audit_rule_update);
-
 	audit_log(NULL, GFP_KERNEL, AUDIT_KERNEL, "initialized");
 
 #ifdef CONFIG_AUDITSYSCALL
diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
linux-2.6.22-base/kernel/auditfilter.c linux-2.6.22-audit/kernel/auditfilter.c
--- linux-2.6.22-base/kernel/auditfilter.c	2007-07-08 16:32:17.000000000 -0700
+++ linux-2.6.22-audit/kernel/auditfilter.c	2007-08-01 20:22:36.000000000 -0700
@@ -29,6 +29,7 @@
 #include <linux/sched.h>
 #include <linux/inotify.h>
 #include <linux/selinux.h>
+#include <linux/security.h>
 #include "audit.h"
 
 /*
@@ -138,7 +139,7 @@ static inline void audit_free_rule(struc
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
 			kfree(f->se_str);
-			selinux_audit_rule_free(f->se_rule);
+			security_audit_rule_free(f->se_rule);
 		}
 	kfree(e->rule.fields);
 	kfree(e->rule.filterkey);
@@ -588,8 +589,8 @@ static struct audit_entry *audit_data_to
 				goto exit_free;
 			entry->rule.buflen += f->val;
 
-			err = selinux_audit_rule_init(f->type, f->op, str,
-						      &f->se_rule);
+			err = security_audit_rule_init(f->type, f->op, str,
+						       &f->se_rule);
 			/* Keep currently invalid fields around in case they
 			 * become valid after a policy reload. */
 			if (err == -EINVAL) {
@@ -832,10 +833,10 @@ out:
 	return new;
 }
 
-/* Duplicate selinux field information.  The se_rule is opaque, so must be
- * re-initialized. */
-static inline int audit_dupe_selinux_field(struct audit_field *df,
-					   struct audit_field *sf)
+/* Duplicate security module field information.
+ * The se_rule is opaque, so must be re-initialized. */
+static inline int audit_dupe_security_field(struct audit_field *df,
+					    struct audit_field *sf)
 {
 	int ret = 0;
 	char *se_str;
@@ -847,8 +848,8 @@ static inline int audit_dupe_selinux_fie
 	df->se_str = se_str;
 
 	/* our own (refreshed) copy of se_rule */
-	ret = selinux_audit_rule_init(df->type, df->op, df->se_str,
-				      &df->se_rule);
+	ret = security_audit_rule_init(df->type, df->op, df->se_str,
+				       &df->se_rule);
 	/* Keep currently invalid fields around in case they
 	 * become valid after a policy reload. */
 	if (ret == -EINVAL) {
@@ -906,7 +907,7 @@ static struct audit_entry *audit_dupe_ru
 		case AUDIT_OBJ_TYPE:
 		case AUDIT_OBJ_LEV_LOW:
 		case AUDIT_OBJ_LEV_HIGH:
-			err = audit_dupe_selinux_field(&new->fields[i],
+			err = audit_dupe_security_field(&new->fields[i],
 						       &old->fields[i]);
 			break;
 		case AUDIT_FILTERKEY:
@@ -1210,7 +1211,8 @@ static inline int audit_add_rule(struct 
 	struct audit_entry *e;
 	struct audit_field *inode_f = entry->rule.inode_f;
 	struct audit_watch *watch = entry->rule.watch;
-	struct nameidata *ndp, *ndw;
+	struct nameidata *ndp = NULL;
+	struct nameidata *ndw = NULL;
 	int h, err, putnd_needed = 0;
 #ifdef CONFIG_AUDITSYSCALL
 	int dont_count = 0;
@@ -1453,7 +1455,7 @@ static void audit_log_rule_change(uid_t 
 	if (sid) {
 		char *ctx = NULL;
 		u32 len;
-		if (selinux_sid_to_string(sid, &ctx, &len))
+		if (security_secid_to_secctx(sid, &ctx, &len))
 			audit_log_format(ab, " ssid=%u", sid);
 		else
 			audit_log_format(ab, " subj=%s", ctx);
@@ -1695,38 +1697,12 @@ unlock_and_return:
 	return result;
 }
 
-/* Check to see if the rule contains any selinux fields.  Returns 1 if there
-   are selinux fields specified in the rule, 0 otherwise. */
-static inline int audit_rule_has_selinux(struct audit_krule *rule)
-{
-	int i;
-
-	for (i = 0; i < rule->field_count; i++) {
-		struct audit_field *f = &rule->fields[i];
-		switch (f->type) {
-		case AUDIT_SUBJ_USER:
-		case AUDIT_SUBJ_ROLE:
-		case AUDIT_SUBJ_TYPE:
-		case AUDIT_SUBJ_SEN:
-		case AUDIT_SUBJ_CLR:
-		case AUDIT_OBJ_USER:
-		case AUDIT_OBJ_ROLE:
-		case AUDIT_OBJ_TYPE:
-		case AUDIT_OBJ_LEV_LOW:
-		case AUDIT_OBJ_LEV_HIGH:
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
 /* This function will re-initialize the se_rule field of all applicable rules.
  * It will traverse the filter lists serarching for rules that contain selinux
  * specific filter fields.  When such a rule is found, it is copied, the
  * selinux field is re-initialized, and the old rule is replaced with the
  * updated rule. */
-int selinux_audit_rule_update(void)
+int audit_rule_update_callout(void)
 {
 	struct audit_entry *entry, *n, *nentry;
 	struct audit_watch *watch;
@@ -1737,7 +1713,7 @@ int selinux_audit_rule_update(void)
 
 	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
 		list_for_each_entry_safe(entry, n, &audit_filter_list[i], list) {
-			if (!audit_rule_has_selinux(&entry->rule))
+			if (!security_audit_rule_supplied(&entry->rule))
 				continue;
 
 			watch = entry->rule.watch;
diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
linux-2.6.22-base/kernel/audit.h linux-2.6.22-audit/kernel/audit.h
--- linux-2.6.22-base/kernel/audit.h	2007-07-08 16:32:17.000000000 -0700
+++ linux-2.6.22-audit/kernel/audit.h	2007-08-01 21:55:27.000000000 -0700
@@ -55,46 +55,6 @@ enum audit_state {
 /* Rule lists */
 struct audit_parent;
 
-struct audit_watch {
-	atomic_t		count;	/* reference count */
-	char			*path;	/* insertion path */
-	dev_t			dev;	/* associated superblock device */
-	unsigned long		ino;	/* associated inode number */
-	struct audit_parent	*parent; /* associated parent */
-	struct list_head	wlist;	/* entry in parent->watches list */
-	struct list_head	rules;	/* associated rules */
-};
-
-struct audit_field {
-	u32				type;
-	u32				val;
-	u32				op;
-	char				*se_str;
-	struct selinux_audit_rule	*se_rule;
-};
-
-struct audit_krule {
-	int			vers_ops;
-	u32			flags;
-	u32			listnr;
-	u32			action;
-	u32			mask[AUDIT_BITMASK_SIZE];
-	u32			buflen; /* for data alloc on list rules */
-	u32			field_count;
-	char			*filterkey; /* ties events to rules */
-	struct audit_field	*fields;
-	struct audit_field	*arch_f; /* quick access to arch field */
-	struct audit_field	*inode_f; /* quick access to an inode field */
-	struct audit_watch	*watch;	/* associated watch */
-	struct list_head	rlist;	/* entry in audit_watch.rules list */
-};
-
-struct audit_entry {
-	struct list_head	list;
-	struct rcu_head		rcu;
-	struct audit_krule	rule;
-};
-
 extern int audit_pid;
 
 #define AUDIT_INODE_BUCKETS	32
@@ -129,7 +89,6 @@ struct inotify_watch;
 extern void audit_free_parent(struct inotify_watch *);
 extern void audit_handle_ievent(struct inotify_watch *, u32, u32, u32,
 				const char *, struct inode *);
-extern int selinux_audit_rule_update(void);
 
 #ifdef CONFIG_AUDITSYSCALL
 extern int __audit_signal_info(int sig, struct task_struct *t);
diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
linux-2.6.22-base/kernel/auditsc.c linux-2.6.22-audit/kernel/auditsc.c
--- linux-2.6.22-base/kernel/auditsc.c	2007-07-08 16:32:17.000000000 -0700
+++ linux-2.6.22-audit/kernel/auditsc.c	2007-08-01 19:50:23.000000000 -0700
@@ -406,10 +406,10 @@ static int audit_filter_rules(struct tas
 			   logged upon error */
 			if (f->se_rule) {
 				if (need_sid) {
-					selinux_get_task_sid(tsk, &sid);
+					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
-				result = selinux_audit_rule_match(sid, f->type,
+				result = security_audit_rule_match(sid, f->type,
 				                                  f->op,
 				                                  f->se_rule,
 				                                  ctx);
@@ -425,12 +425,12 @@ static int audit_filter_rules(struct tas
 			if (f->se_rule) {
 				/* Find files that match */
 				if (name) {
-					result = selinux_audit_rule_match(
+					result = security_audit_rule_match(
 					           name->osid, f->type, f->op,
 					           f->se_rule, ctx);
 				} else if (ctx) {
 					for (j = 0; j < ctx->name_count; j++) {
-						if (selinux_audit_rule_match(
+						if (security_audit_rule_match(
 						      ctx->names[j].osid,
 						      f->type, f->op,
 						      f->se_rule, ctx)) {
@@ -446,7 +446,7 @@ static int audit_filter_rules(struct tas
 					     aux = aux->next) {
 						if (aux->type == AUDIT_IPC) {
 							struct audit_aux_data_ipcctl *axi = (void *)aux;
-							if (selinux_audit_rule_match(axi->osid, f->type, f->op, f->se_rule,
ctx)) {
+							if (security_audit_rule_match(axi->osid, f->type, f->op, f->se_rule,
ctx)) {
 								++result;
 								break;
 							}
@@ -759,11 +759,11 @@ void audit_log_task_context(struct audit
 	int error;
 	u32 sid;
 
-	selinux_get_task_sid(current, &sid);
+	security_task_getsecid(current, &sid);
 	if (!sid)
 		return;
 
-	error = selinux_sid_to_string(sid, &ctx, &len);
+	error = security_secid_to_secctx(sid, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
@@ -823,7 +823,7 @@ static int audit_log_pid_context(struct 
 	if (!ab)
 		return 1;
 
-	if (selinux_sid_to_string(sid, &s, &len)) {
+	if (security_secid_to_secctx(sid, &s, &len)) {
 		audit_log_format(ab, "opid=%d obj=(none)", pid);
 		rc = 1;
 	} else
@@ -954,7 +954,7 @@ static void audit_log_exit(struct audit_
 			if (axi->osid != 0) {
 				char *ctx = NULL;
 				u32 len;
-				if (selinux_sid_to_string(
+				if (security_secid_to_secctx(
 						axi->osid, &ctx, &len)) {
 					audit_log_format(ab, " osid=%u",
 							axi->osid);
@@ -1081,7 +1081,7 @@ static void audit_log_exit(struct audit_
 		if (n->osid != 0) {
 			char *ctx = NULL;
 			u32 len;
-			if (selinux_sid_to_string(
+			if (security_secid_to_secctx(
 				n->osid, &ctx, &len)) {
 				audit_log_format(ab, " osid=%u", n->osid);
 				call_panic = 2;
@@ -1369,7 +1369,7 @@ static void audit_copy_inode(struct audi
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	selinux_get_inode_sid(inode, &name->osid);
+	security_inode_getsecid(inode, &name->osid);
 }
 
 /**
@@ -1787,7 +1787,7 @@ int __audit_ipc_obj(struct kern_ipc_perm
 	ax->uid = ipcp->uid;
 	ax->gid = ipcp->gid;
 	ax->mode = ipcp->mode;
-	selinux_get_ipc_sid(ipcp, &ax->osid);
+	security_ipc_getsecid(ipcp, &ax->osid);
 
 	ax->d.type = AUDIT_IPC;
 	ax->d.next = context->aux;
@@ -1948,7 +1948,7 @@ void __audit_ptrace(struct task_struct *
 	struct audit_context *context = current->audit_context;
 
 	context->target_pid = t->pid;
-	selinux_get_task_sid(t, &context->target_sid);
+	security_task_getsecid(t, &context->target_sid);
 }
 
 /**
@@ -2005,7 +2005,7 @@ int __audit_signal_info(int sig, struct 
 			audit_sig_uid = ctx->loginuid;
 		else
 			audit_sig_uid = tsk->uid;
-		selinux_get_task_sid(tsk, &audit_sig_sid);
+		security_task_getsecid(tsk, &audit_sig_sid);
 	}
 
 	if (!audit_signals) /* audit_context checked in wrapper */
@@ -2015,7 +2015,7 @@ int __audit_signal_info(int sig, struct 
 	 * in audit_context */
 	if (!ctx->target_pid) {
 		ctx->target_pid = t->tgid;
-		selinux_get_task_sid(t, &ctx->target_sid);
+		security_task_getsecid(t, &ctx->target_sid);
 		return 0;
 	}
 
@@ -2032,7 +2032,7 @@ int __audit_signal_info(int sig, struct 
 	BUG_ON(axp->pid_count > AUDIT_AUX_PIDS);
 
 	axp->target_pid[axp->pid_count] = t->tgid;
-	selinux_get_task_sid(t, &axp->target_sid[axp->pid_count]);
+	security_task_getsecid(t, &axp->target_sid[axp->pid_count]);
 	axp->pid_count++;
 
 	return 0;
@@ -2060,12 +2060,12 @@ void audit_core_dumps(long signr)
 	audit_log_format(ab, "auid=%u uid=%u gid=%u",
 			audit_get_loginuid(current->audit_context),
 			current->uid, current->gid);
-	selinux_get_task_sid(current, &sid);
+	security_task_getsecid(current, &sid);
 	if (sid) {
 		char *ctx = NULL;
 		u32 len;
 
-		if (selinux_sid_to_string(sid, &ctx, &len))
+		if (security_secid_to_secctx(sid, &ctx, &len))
 			audit_log_format(ab, " ssid=%u", sid);
 		else
 			audit_log_format(ab, " subj=%s", ctx);
diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
linux-2.6.22-base/security/selinux/hooks.c
linux-2.6.22-audit/security/selinux/hooks.c
--- linux-2.6.22-base/security/selinux/hooks.c	2007-07-08 16:32:17.000000000
-0700
+++ linux-2.6.22-audit/security/selinux/hooks.c	2007-08-01 21:42:32.000000000
-0700
@@ -4656,6 +4656,30 @@ static void selinux_release_secctx(char 
 		kfree(secdata);
 }
 
+static int selinux_audit_rule_supplied(struct audit_krule *rule)
+{
+	int i;
+
+	for (i = 0; i < rule->field_count; i++) {
+		struct audit_field *f = &rule->fields[i];
+		switch (f->type) {
+		case AUDIT_SUBJ_USER:
+		case AUDIT_SUBJ_ROLE:
+		case AUDIT_SUBJ_TYPE:
+		case AUDIT_SUBJ_SEN:
+		case AUDIT_SUBJ_CLR:
+		case AUDIT_OBJ_USER:
+		case AUDIT_OBJ_ROLE:
+		case AUDIT_OBJ_TYPE:
+		case AUDIT_OBJ_LEV_LOW:
+		case AUDIT_OBJ_LEV_HIGH:
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
@@ -4838,6 +4862,12 @@ static struct security_operations selinu
 
 	.secid_to_secctx =		selinux_secid_to_secctx,
 	.release_secctx =		selinux_release_secctx,
+	.inode_getsecid =		selinux_get_inode_sid,
+	.ipc_getsecid = 		selinux_get_ipc_sid,
+	.audit_rule_supplied = 		selinux_audit_rule_supplied,
+	.audit_rule_match = 		selinux_audit_rule_match,
+	.audit_rule_init = 		selinux_audit_rule_init,
+	.audit_rule_free = 		selinux_audit_rule_free,
 
         .unix_stream_connect =		selinux_socket_unix_stream_connect,
 	.unix_may_send =		selinux_socket_unix_may_send,
diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
linux-2.6.22-base/security/selinux/ss/services.c
linux-2.6.22-audit/security/selinux/ss/services.c
--- linux-2.6.22-base/security/selinux/ss/services.c	2007-07-08
16:32:17.000000000 -0700
+++ linux-2.6.22-audit/security/selinux/ss/services.c	2007-08-01
17:48:17.000000000 -0700
@@ -2214,7 +2214,7 @@ out:
 	return match;
 }
 
-static int (*aurule_callback)(void) = NULL;
+static int (*aurule_callback)(void) = audit_rule_update_callout;
 
 static int aurule_avc_callback(u32 event, u32 ssid, u32 tsid,
                                u16 class, u32 perms, u32 *retained)
@@ -2239,11 +2239,6 @@ static int __init aurule_init(void)
 }
 __initcall(aurule_init);
 
-void selinux_audit_set_callback(int (*callback)(void))
-{
-	aurule_callback = callback;
-}
-
 #ifdef CONFIG_NETLABEL
 /*
  * NetLabel cache structure



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
