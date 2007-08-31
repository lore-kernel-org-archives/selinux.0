Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7V3vHHI012389
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 23:57:17 -0400
Received: from gateway-1237.mvista.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7V3vFDB020146
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2007 03:57:16 GMT
Message-ID: <46D79197.60502@schaufler-ca.com>
Date: Thu, 30 Aug 2007 20:57:11 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
MIME-Version: 1.0
To: linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        selinux@tycho.nsa.gov
Subject: [PATCH][RFC] V3 Remove SELinux dependencies from linux-audit via
 LSM
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Casey Schaufler <casey@schaufler-ca.com>

This patch interposes LSM interfaces between the audit system
and SELinux. This helps make SELinux a cleaner LSM and clarifies
the interfaces provided by the audit system. The audit system
no longer requires SELinux functions or data structures, making
it available for use by other LSMs.

The audit system interfaces should now be useful to any LSM that
can provide secids and text string representations that match them.
The audit system uses secids only to map to those strings and
treats them as opaque data otherwise. Audit rule information that
is specific to an LSM is maintained through a void *. 

The SELinux code uses LSM interfaces to access the audit system,
with the exception of audit_rule_update_callout(), which is
intended to be called at the descretion of an LSM to update the
LSM specific rules.

The LSM interface includes six new entries, four for audit and two
that supply secids from the LSM to networking and audit subsystems.
Also, there were several cases where SELinux code was being called
where LSM interfaces were more appropriate. These uses have been
repaired and the SELinux interfaces are no longer exported.

These changes expose the secid as an LSM interface. SELinux
already uses secids. Other LSMs that expect to interface with
audit, xfrm, and USB will have to support the notion of secids.
Smack has been adjusted to support this scheme.

This patch is relative to 2.6.23-rc4. It will not apply to 2.6.22.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---

I have approached the elimination of secids from three different
directions and while I would accept the changes required I would
not expect all parties to buy into them because of the code
disruption. The approach I am putting forward has the advantage
of directly addressing the issue at hand, which is to make it
possible for an LSM that is not SELinux to use the audit system.
As I've suggested elsewhere, maybe cleaning up the LSM interface
is a task for Linux 3.0.

 include/linux/audit.h               |   55 +++++++++-
 include/linux/security.h            |  113 +++++++++++++++++++++
 include/linux/selinux.h             |  138 --------------------------
 kernel/audit.c                      |   43 +++-----
 kernel/audit.h                      |   41 -------
 kernel/auditfilter.c                |   70 ++++---------
 kernel/auditsc.c                    |   45 ++++----
 net/netlink/af_netlink.c            |    3 
 security/selinux/exports.c          |   42 -------
 security/selinux/hooks.c            |   51 +++++++++
 security/selinux/include/security.h |   38 +++++++
 security/selinux/ss/services.c      |   19 +--
 12 files changed, 323 insertions(+), 335 deletions(-)

diff -uprN -X linux-2.6.23-rc4-base/Documentation/dontdiff linux-2.6.23-rc4-base/include/linux/audit.h linux-2.6.23-rc4-audit/include/linux/audit.h
--- linux-2.6.23-rc4-base/include/linux/audit.h	2007-08-26 23:51:46.000000000 -0700
+++ linux-2.6.23-rc4-audit/include/linux/audit.h	2007-08-27 00:52:10.000000000 -0700
@@ -333,20 +333,63 @@ struct audit_rule {		/* for AUDIT_LIST, 
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
+	u32	type;
+	u32	val;
+	u32	op;
+	char	*se_str;
+	void	*se_rule;
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
diff -uprN -X linux-2.6.23-rc4-base/Documentation/dontdiff linux-2.6.23-rc4-base/include/linux/security.h linux-2.6.23-rc4-audit/include/linux/security.h
--- linux-2.6.23-rc4-base/include/linux/security.h	2007-08-26 23:51:46.000000000 -0700
+++ linux-2.6.23-rc4-audit/include/linux/security.h	2007-08-29 20:24:19.000000000 -0700
@@ -35,6 +35,7 @@
 #include <net/flow.h>
 
 struct ctl_table;
+struct audit_krule;
 
 /*
  * These functions are in security/capability.c and are used
@@ -1138,6 +1139,8 @@ struct request_sock;
  *	@name contains the name of the security module being unstacked.
  *	@ops contains a pointer to the struct security_operations of the module to unstack.
  * 
+ * Hooks for the export of secids
+ *
  * @secid_to_secctx:
  *	Convert secid to security context.
  *	@secid contains the security ID.
@@ -1148,6 +1151,38 @@ struct request_sock;
  *	@secdata contains the security context.
  *	@seclen contains the length of the security context.
  *
+ * @inode_getsecid:
+ * 	get the secid associated with the inode
+ * 	@inode contains a pointer to the inode
+ * 	@secid contains a pointer to the location to store the result
+ *
+ * @ipc_getsecid:
+ * 	get the secid associated with the ipc object
+ * 	@inode contains a pointer to the ipc object
+ * 	@secid contains a pointer to the location to store the result
+ *	
+ * Security hooks for the audit system
+ *
+ * @audit_rule_supplied:
+ *	identify audit rules interesting to this LSM
+ *	@rule contains a pointer to the rule in question
+ * @audit_rule_match:
+ * 	checks if the LSM would have a record generated
+ * 	@sid contains the secid in question
+ * 	@field contains what to check
+ * 	@op contains the operation
+ * 	@rule contains a pointer to the audit rule
+ * 	@actx contains a pointer to the audit context
+ * @audit_rule_init:
+ * 	establish an audit rule
+ * 	@field contains the action of interest
+ * 	@op contains the operation
+ * 	@rulestr contains a pointer to the rule string
+ * 	@rule contains a pointer to receive the result
+ * @audit_rule_free:
+ * 	reclaim the rule
+ * 	@rule the data to free
+ *
  * This is the main security structure.
  */
 struct security_operations {
@@ -1331,6 +1366,14 @@ struct security_operations {
  	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_t size);
 	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
 	void (*release_secctx)(char *secdata, u32 seclen);
+	void (*inode_getsecid) (const struct inode *inode, u32 *secid);
+	void (*ipc_getsecid) (const struct kern_ipc_perm *p, u32 *secid);
+	int (*audit_rule_supplied) (struct audit_krule *rule);
+	int (*audit_rule_match) (u32 sid, u32 field, u32 op, void *rule,
+                      	         struct audit_context *actx);
+	int (*audit_rule_init) (u32 field, u32 op, char *rulestr, void **rule);
+	void (*audit_rule_free) (void *rule);
+
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
@@ -2132,6 +2175,43 @@ static inline void security_release_secc
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
+                      			    void *rule,
+                      			    struct audit_context *actx)
+{
+	return security_ops->audit_rule_match(sid, field, op, rule, actx);
+}
+
+static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
+					   void **rule)
+{
+	return security_ops->audit_rule_init(field, op, rulestr, rule);
+}
+
+static inline void security_audit_rule_free(void *rule)
+{
+	security_ops->audit_rule_free(rule);
+	return;
+}
+
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -2813,6 +2893,39 @@ static inline int security_secid_to_secc
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
+                       			    void *rule,
+                      			    struct audit_context *actx)
+{
+	return;
+}
+
+static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
+					   void **rule)
+{
+	return 0;
+}
+
+static inline void security_audit_rule_free(void *rule)
+{
+	return;
+}
+
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff -uprN -X linux-2.6.23-rc4-base/Documentation/dontdiff linux-2.6.23-rc4-base/include/linux/selinux.h linux-2.6.23-rc4-audit/include/linux/selinux.h
--- linux-2.6.23-rc4-base/include/linux/selinux.h	2007-07-08 16:32:17.000000000 -0700
+++ linux-2.6.23-rc4-audit/include/linux/selinux.h	2007-08-27 00:52:10.000000000 -0700
@@ -14,101 +14,9 @@
 #ifndef _LINUX_SELINUX_H
 #define _LINUX_SELINUX_H
 
-struct selinux_audit_rule;
-struct audit_context;
-struct inode;
-struct kern_ipc_perm;
-
 #ifdef CONFIG_SECURITY_SELINUX
 
 /**
- *	selinux_audit_rule_init - alloc/init an selinux audit rule structure.
- *	@field: the field this rule refers to
- *	@op: the operater the rule uses
- *	@rulestr: the text "target" of the rule
- *	@rule: pointer to the new rule structure returned via this
- *
- *	Returns 0 if successful, -errno if not.  On success, the rule structure
- *	will be allocated internally.  The caller must free this structure with
- *	selinux_audit_rule_free() after use.
- */
-int selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
-                            struct selinux_audit_rule **rule);
-
-/**
- *	selinux_audit_rule_free - free an selinux audit rule structure.
- *	@rule: pointer to the audit rule to be freed
- *
- *	This will free all memory associated with the given rule.
- *	If @rule is NULL, no operation is performed.
- */
-void selinux_audit_rule_free(struct selinux_audit_rule *rule);
-
-/**
- *	selinux_audit_rule_match - determine if a context ID matches a rule.
- *	@sid: the context ID to check
- *	@field: the field this rule refers to
- *	@op: the operater the rule uses
- *	@rule: pointer to the audit rule to check against
- *	@actx: the audit context (can be NULL) associated with the check
- *
- *	Returns 1 if the context id matches the rule, 0 if it does not, and
- *	-errno on failure.
- */
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
-                             struct selinux_audit_rule *rule,
-                             struct audit_context *actx);
-
-/**
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
- *     selinux_sid_to_string - map a security context ID to a string
- *     @sid: security context ID to be converted.
- *     @ctx: address of context string to be returned
- *     @ctxlen: length of returned context string.
- *
- *     Returns 0 if successful, -errno if not.  On success, the context
- *     string will be allocated internally, and the caller must call
- *     kfree() on it after use.
- */
-int selinux_sid_to_string(u32 sid, char **ctx, u32 *ctxlen);
-
-/**
- *     selinux_get_inode_sid - get the inode's security context ID
- *     @inode: inode structure to get the sid from.
- *     @sid: pointer to security context ID to be filled in.
- *
- *     Returns nothing
- */
-void selinux_get_inode_sid(const struct inode *inode, u32 *sid);
-
-/**
- *     selinux_get_ipc_sid - get the ipc security context ID
- *     @ipcp: ipc structure to get the sid from.
- *     @sid: pointer to security context ID to be filled in.
- *
- *     Returns nothing
- */
-void selinux_get_ipc_sid(const struct kern_ipc_perm *ipcp, u32 *sid);
-
-/**
- *     selinux_get_task_sid - return the SID of task
- *     @tsk: the task whose SID will be returned
- *     @sid: pointer to security context ID to be filled in.
- *
- *     Returns nothing
- */
-void selinux_get_task_sid(struct task_struct *tsk, u32 *sid);
-
-/**
  *     selinux_string_to_sid - map a security context string to a security ID
  *     @str: the security context string to be mapped
  *     @sid: ID value returned via this.
@@ -132,52 +40,6 @@ int selinux_relabel_packet_permission(u3
 
 #else
 
-static inline int selinux_audit_rule_init(u32 field, u32 op,
-                                          char *rulestr,
-                                          struct selinux_audit_rule **rule)
-{
-	return -ENOTSUPP;
-}
-
-static inline void selinux_audit_rule_free(struct selinux_audit_rule *rule)
-{
-	return;
-}
-
-static inline int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
-                                           struct selinux_audit_rule *rule,
-                                           struct audit_context *actx)
-{
-	return 0;
-}
-
-static inline void selinux_audit_set_callback(int (*callback)(void))
-{
-	return;
-}
-
-static inline int selinux_sid_to_string(u32 sid, char **ctx, u32 *ctxlen)
-{
-       *ctx = NULL;
-       *ctxlen = 0;
-       return 0;
-}
-
-static inline void selinux_get_inode_sid(const struct inode *inode, u32 *sid)
-{
-	*sid = 0;
-}
-
-static inline void selinux_get_ipc_sid(const struct kern_ipc_perm *ipcp, u32 *sid)
-{
-	*sid = 0;
-}
-
-static inline void selinux_get_task_sid(struct task_struct *tsk, u32 *sid)
-{
-	*sid = 0;
-}
-
 static inline int selinux_string_to_sid(const char *str, u32 *sid)
 {
        *sid = 0;
diff -uprN -X linux-2.6.23-rc4-base/Documentation/dontdiff linux-2.6.23-rc4-base/kernel/audit.c linux-2.6.23-rc4-audit/kernel/audit.c
--- linux-2.6.23-rc4-base/kernel/audit.c	2007-08-26 23:51:47.000000000 -0700
+++ linux-2.6.23-rc4-audit/kernel/audit.c	2007-08-27 00:52:10.000000000 -0700
@@ -55,7 +55,6 @@
 #include <net/netlink.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
-#include <linux/selinux.h>
 #include <linux/inotify.h>
 #include <linux/freezer.h>
 #include <linux/tty.h>
@@ -253,12 +252,12 @@ static int audit_set_rate_limit(int limi
 	if (sid) {
 		char *ctx = NULL;
 		u32 len;
-		if ((rc = selinux_sid_to_string(sid, &ctx, &len)) == 0) {
+		if ((rc = security_secid_to_secctx(sid, &ctx, &len)) == 0) {
 			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 				"audit_rate_limit=%d old=%d by auid=%u"
 				" subj=%s res=%d",
 				limit, old, loginuid, ctx, res);
-			kfree(ctx);
+			security_release_secctx(ctx, len);
 		} else
 			res = 0; /* Something weird, deny request */
 	}
@@ -288,12 +287,12 @@ static int audit_set_backlog_limit(int l
 	if (sid) {
 		char *ctx = NULL;
 		u32 len;
-		if ((rc = selinux_sid_to_string(sid, &ctx, &len)) == 0) {
+		if ((rc = security_secid_to_secctx(sid, &ctx, &len)) == 0) {
 			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 				"audit_backlog_limit=%d old=%d by auid=%u"
 				" subj=%s res=%d",
 				limit, old, loginuid, ctx, res);
-			kfree(ctx);
+			security_release_secctx(ctx, len);
 		} else
 			res = 0; /* Something weird, deny request */
 	}
@@ -326,12 +325,12 @@ static int audit_set_enabled(int state, 
 	if (sid) {
 		char *ctx = NULL;
 		u32 len;
-		if ((rc = selinux_sid_to_string(sid, &ctx, &len)) == 0) {
+		if ((rc = security_secid_to_secctx(sid, &ctx, &len)) == 0) {
 			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 				"audit_enabled=%d old=%d by auid=%u"
 				" subj=%s res=%d",
 				state, old, loginuid, ctx, res);
-			kfree(ctx);
+			security_release_secctx(ctx, len);
 		} else
 			res = 0; /* Something weird, deny request */
 	}
@@ -366,12 +365,12 @@ static int audit_set_failure(int state, 
 	if (sid) {
 		char *ctx = NULL;
 		u32 len;
-		if ((rc = selinux_sid_to_string(sid, &ctx, &len)) == 0) {
+		if ((rc = security_secid_to_secctx(sid, &ctx, &len)) == 0) {
 			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 				"audit_failure=%d old=%d by auid=%u"
 				" subj=%s res=%d",
 				state, old, loginuid, ctx, res);
-			kfree(ctx);
+			security_release_secctx(ctx, len);
 		} else
 			res = 0; /* Something weird, deny request */
 	}
@@ -619,7 +618,7 @@ static int audit_receive_msg(struct sk_b
 		if (status_get->mask & AUDIT_STATUS_PID) {
 			int old   = audit_pid;
 			if (sid) {
-				if ((err = selinux_sid_to_string(
+				if ((err = security_secid_to_secctx(
 						sid, &ctx, &len)))
 					return err;
 				else
@@ -628,7 +627,7 @@ static int audit_receive_msg(struct sk_b
 						"audit_pid=%d old=%d by auid=%u subj=%s",
 						status_get->pid, old,
 						loginuid, ctx);
-				kfree(ctx);
+				security_release_secctx(ctx, len);
 			} else
 				audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 					"audit_pid=%d old=%d by auid=%u",
@@ -662,7 +661,7 @@ static int audit_receive_msg(struct sk_b
 						 "user pid=%d uid=%u auid=%u",
 						 pid, uid, loginuid);
 				if (sid) {
-					if (selinux_sid_to_string(
+					if (security_secid_to_secctx(
 							sid, &ctx, &len)) {
 						audit_log_format(ab, 
 							" ssid=%u", sid);
@@ -670,7 +669,7 @@ static int audit_receive_msg(struct sk_b
 					} else
 						audit_log_format(ab, 
 							" subj=%s", ctx);
-					kfree(ctx);
+					security_release_secctx(ctx, len);
 				}
 				if (msg_type != AUDIT_USER_TTY)
 					audit_log_format(ab, " msg='%.1024s'",
@@ -700,7 +699,7 @@ static int audit_receive_msg(struct sk_b
 						 "pid=%d uid=%u auid=%u",
 						 pid, uid, loginuid);
 				if (sid) {
-					if (selinux_sid_to_string(
+					if (security_secid_to_secctx(
 							sid, &ctx, &len)) {
 						audit_log_format(ab,
 							" ssid=%u", sid);
@@ -708,7 +707,7 @@ static int audit_receive_msg(struct sk_b
 					} else
 						audit_log_format(ab,
 							" subj=%s", ctx);
-					kfree(ctx);
+					security_release_secctx(ctx, len);
 				}
 				audit_log_format(ab, " audit_enabled=%d res=0",
 					audit_enabled);
@@ -734,7 +733,7 @@ static int audit_receive_msg(struct sk_b
 						 "pid=%d uid=%u auid=%u",
 						 pid, uid, loginuid);
 				if (sid) {
-					if (selinux_sid_to_string(
+					if (security_secid_to_secctx(
 							sid, &ctx, &len)) {
 						audit_log_format(ab,
 							" ssid=%u", sid);
@@ -742,7 +741,7 @@ static int audit_receive_msg(struct sk_b
 					} else
 						audit_log_format(ab,
 							" subj=%s", ctx);
-					kfree(ctx);
+					security_release_secctx(ctx, len);
 				}
 				audit_log_format(ab, " audit_enabled=%d res=0",
 					audit_enabled);
@@ -757,18 +756,18 @@ static int audit_receive_msg(struct sk_b
 					   loginuid, sid);
 		break;
 	case AUDIT_SIGNAL_INFO:
-		err = selinux_sid_to_string(audit_sig_sid, &ctx, &len);
+		err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
 		if (err)
 			return err;
 		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
 		if (!sig_data) {
-			kfree(ctx);
+			security_release_secctx(ctx, len);
 			return -ENOMEM;
 		}
 		sig_data->uid = audit_sig_uid;
 		sig_data->pid = audit_sig_pid;
 		memcpy(sig_data->ctx, ctx, len);
-		kfree(ctx);
+		security_release_secctx(ctx, len);
 		audit_send_reply(NETLINK_CB(skb).pid, seq, AUDIT_SIGNAL_INFO, 
 				0, 0, sig_data, sizeof(*sig_data) + len);
 		kfree(sig_data);
@@ -887,10 +886,6 @@ static int __init audit_init(void)
 	audit_initialized = 1;
 	audit_enabled = audit_default;
 
-	/* Register the callback with selinux.  This callback will be invoked
-	 * when a new policy is loaded. */
-	selinux_audit_set_callback(&selinux_audit_rule_update);
-
 	audit_log(NULL, GFP_KERNEL, AUDIT_KERNEL, "initialized");
 
 #ifdef CONFIG_AUDITSYSCALL
diff -uprN -X linux-2.6.23-rc4-base/Documentation/dontdiff linux-2.6.23-rc4-base/kernel/auditfilter.c linux-2.6.23-rc4-audit/kernel/auditfilter.c
--- linux-2.6.23-rc4-base/kernel/auditfilter.c	2007-08-26 23:51:47.000000000 -0700
+++ linux-2.6.23-rc4-audit/kernel/auditfilter.c	2007-08-27 00:52:10.000000000 -0700
@@ -28,7 +28,7 @@
 #include <linux/netlink.h>
 #include <linux/sched.h>
 #include <linux/inotify.h>
-#include <linux/selinux.h>
+#include <linux/security.h>
 #include "audit.h"
 
 /*
@@ -38,7 +38,7 @@
  * 		Synchronizes writes and blocking reads of audit's filterlist
  * 		data.  Rcu is used to traverse the filterlist and access
  * 		contents of structs audit_entry, audit_watch and opaque
- * 		selinux rules during filtering.  If modified, these structures
+ * 		LSM rules during filtering.  If modified, these structures
  * 		must be copied and replace their counterparts in the filterlist.
  * 		An audit_parent struct is not accessed during filtering, so may
  * 		be written directly provided audit_filter_mutex is held.
@@ -138,7 +138,7 @@ static inline void audit_free_rule(struc
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
 			kfree(f->se_str);
-			selinux_audit_rule_free(f->se_rule);
+			security_audit_rule_free(f->se_rule);
 		}
 	kfree(e->rule.fields);
 	kfree(e->rule.filterkey);
@@ -595,12 +595,12 @@ static struct audit_entry *audit_data_to
 				goto exit_free;
 			entry->rule.buflen += f->val;
 
-			err = selinux_audit_rule_init(f->type, f->op, str,
+			err = security_audit_rule_init(f->type, f->op, str,
 						      &f->se_rule);
 			/* Keep currently invalid fields around in case they
 			 * become valid after a policy reload. */
 			if (err == -EINVAL) {
-				printk(KERN_WARNING "audit rule for selinux "
+				printk(KERN_WARNING "audit rule for LSM "
 				       "\'%s\' is invalid\n",  str);
 				err = 0;
 			}
@@ -839,10 +839,10 @@ out:
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
@@ -854,12 +854,12 @@ static inline int audit_dupe_selinux_fie
 	df->se_str = se_str;
 
 	/* our own (refreshed) copy of se_rule */
-	ret = selinux_audit_rule_init(df->type, df->op, df->se_str,
-				      &df->se_rule);
+	ret = security_audit_rule_init(df->type, df->op, df->se_str,
+				       &df->se_rule);
 	/* Keep currently invalid fields around in case they
 	 * become valid after a policy reload. */
 	if (ret == -EINVAL) {
-		printk(KERN_WARNING "audit rule for selinux \'%s\' is "
+		printk(KERN_WARNING "audit rule for LSM \'%s\' is "
 		       "invalid\n", df->se_str);
 		ret = 0;
 	}
@@ -868,7 +868,7 @@ static inline int audit_dupe_selinux_fie
 }
 
 /* Duplicate an audit rule.  This will be a deep copy with the exception
- * of the watch - that pointer is carried over.  The selinux specific fields
+ * of the watch - that pointer is carried over.  The LSM specific fields
  * will be updated in the copy.  The point is to be able to replace the old
  * rule with the new rule in the filterlist, then free the old rule.
  * The rlist element is undefined; list manipulations are handled apart from
@@ -913,8 +913,8 @@ static struct audit_entry *audit_dupe_ru
 		case AUDIT_OBJ_TYPE:
 		case AUDIT_OBJ_LEV_LOW:
 		case AUDIT_OBJ_LEV_HIGH:
-			err = audit_dupe_selinux_field(&new->fields[i],
-						       &old->fields[i]);
+			err = audit_dupe_security_field(&new->fields[i],
+						        &old->fields[i]);
 			break;
 		case AUDIT_FILTERKEY:
 			fk = kstrdup(old->filterkey, GFP_KERNEL);
@@ -1456,11 +1456,11 @@ static void audit_log_rule_change(uid_t 
 	if (sid) {
 		char *ctx = NULL;
 		u32 len;
-		if (selinux_sid_to_string(sid, &ctx, &len))
+		if (security_secid_to_secctx(sid, &ctx, &len))
 			audit_log_format(ab, " ssid=%u", sid);
 		else
 			audit_log_format(ab, " subj=%s", ctx);
-		kfree(ctx);
+		security_release_secctx(ctx, len);
 	}
 	audit_log_format(ab, " op=%s rule key=", action);
 	if (rule->filterkey)
@@ -1702,38 +1702,12 @@ unlock_and_return:
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
- * It will traverse the filter lists serarching for rules that contain selinux
+ * It will traverse the filter lists serarching for rules that contain LSM
  * specific filter fields.  When such a rule is found, it is copied, the
- * selinux field is re-initialized, and the old rule is replaced with the
+ * LSM field is re-initialized, and the old rule is replaced with the
  * updated rule. */
-int selinux_audit_rule_update(void)
+int audit_rule_update_callout(void)
 {
 	struct audit_entry *entry, *n, *nentry;
 	struct audit_watch *watch;
@@ -1744,7 +1718,7 @@ int selinux_audit_rule_update(void)
 
 	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
 		list_for_each_entry_safe(entry, n, &audit_filter_list[i], list) {
-			if (!audit_rule_has_selinux(&entry->rule))
+			if (!security_audit_rule_supplied(&entry->rule))
 				continue;
 
 			watch = entry->rule.watch;
@@ -1754,7 +1728,7 @@ int selinux_audit_rule_update(void)
 				 * return value */
 				if (!err)
 					err = PTR_ERR(nentry);
-				audit_panic("error updating selinux filters");
+				audit_panic("error updating LSM filters");
 				if (watch)
 					list_del(&entry->rule.rlist);
 				list_del_rcu(&entry->list);
diff -uprN -X linux-2.6.23-rc4-base/Documentation/dontdiff linux-2.6.23-rc4-base/kernel/audit.h linux-2.6.23-rc4-audit/kernel/audit.h
--- linux-2.6.23-rc4-base/kernel/audit.h	2007-08-26 23:51:47.000000000 -0700
+++ linux-2.6.23-rc4-audit/kernel/audit.h	2007-08-27 00:52:10.000000000 -0700
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
@@ -128,7 +88,6 @@ struct inotify_watch;
 extern void audit_free_parent(struct inotify_watch *);
 extern void audit_handle_ievent(struct inotify_watch *, u32, u32, u32,
 				const char *, struct inode *);
-extern int selinux_audit_rule_update(void);
 
 #ifdef CONFIG_AUDITSYSCALL
 extern int __audit_signal_info(int sig, struct task_struct *t);
diff -uprN -X linux-2.6.23-rc4-base/Documentation/dontdiff linux-2.6.23-rc4-base/kernel/auditsc.c linux-2.6.23-rc4-audit/kernel/auditsc.c
--- linux-2.6.23-rc4-base/kernel/auditsc.c	2007-08-26 23:51:47.000000000 -0700
+++ linux-2.6.23-rc4-audit/kernel/auditsc.c	2007-08-27 00:52:10.000000000 -0700
@@ -62,7 +62,6 @@
 #include <linux/security.h>
 #include <linux/list.h>
 #include <linux/tty.h>
-#include <linux/selinux.h>
 #include <linux/binfmts.h>
 #include <linux/highmem.h>
 #include <linux/syscalls.h>
@@ -397,10 +396,10 @@ static int audit_filter_rules(struct tas
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
@@ -416,12 +415,12 @@ static int audit_filter_rules(struct tas
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
@@ -437,7 +436,7 @@ static int audit_filter_rules(struct tas
 					     aux = aux->next) {
 						if (aux->type == AUDIT_IPC) {
 							struct audit_aux_data_ipcctl *axi = (void *)aux;
-							if (selinux_audit_rule_match(axi->osid, f->type, f->op, f->se_rule, ctx)) {
+							if (security_audit_rule_match(axi->osid, f->type, f->op, f->se_rule, ctx)) {
 								++result;
 								break;
 							}
@@ -744,11 +743,11 @@ void audit_log_task_context(struct audit
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
@@ -756,7 +755,7 @@ void audit_log_task_context(struct audit
 	}
 
 	audit_log_format(ab, " subj=%s", ctx);
-	kfree(ctx);
+	security_release_secctx(ctx, len);
 	return;
 
 error_path:
@@ -808,7 +807,7 @@ static int audit_log_pid_context(struct 
 	if (!ab)
 		return 1;
 
-	if (selinux_sid_to_string(sid, &s, &len)) {
+	if (security_secid_to_secctx(sid, &s, &len)) {
 		audit_log_format(ab, "opid=%d obj=(none)", pid);
 		rc = 1;
 	} else
@@ -990,14 +989,14 @@ static void audit_log_exit(struct audit_
 			if (axi->osid != 0) {
 				char *ctx = NULL;
 				u32 len;
-				if (selinux_sid_to_string(
+				if (security_secid_to_secctx(
 						axi->osid, &ctx, &len)) {
 					audit_log_format(ab, " osid=%u",
 							axi->osid);
 					call_panic = 1;
 				} else
 					audit_log_format(ab, " obj=%s", ctx);
-				kfree(ctx);
+				security_release_secctx(ctx, len);
 			}
 			break; }
 
@@ -1106,13 +1105,13 @@ static void audit_log_exit(struct audit_
 		if (n->osid != 0) {
 			char *ctx = NULL;
 			u32 len;
-			if (selinux_sid_to_string(
+			if (security_secid_to_secctx(
 				n->osid, &ctx, &len)) {
 				audit_log_format(ab, " osid=%u", n->osid);
 				call_panic = 2;
 			} else
 				audit_log_format(ab, " obj=%s", ctx);
-			kfree(ctx);
+			security_release_secctx(ctx, len);
 		}
 
 		audit_log_end(ab);
@@ -1394,7 +1393,7 @@ static void audit_copy_inode(struct audi
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	selinux_get_inode_sid(inode, &name->osid);
+	security_inode_getsecid(inode, &name->osid);
 }
 
 /**
@@ -1812,7 +1811,7 @@ int __audit_ipc_obj(struct kern_ipc_perm
 	ax->uid = ipcp->uid;
 	ax->gid = ipcp->gid;
 	ax->mode = ipcp->mode;
-	selinux_get_ipc_sid(ipcp, &ax->osid);
+	security_ipc_getsecid(ipcp, &ax->osid);
 
 	ax->d.type = AUDIT_IPC;
 	ax->d.next = context->aux;
@@ -1972,7 +1971,7 @@ void __audit_ptrace(struct task_struct *
 	struct audit_context *context = current->audit_context;
 
 	context->target_pid = t->pid;
-	selinux_get_task_sid(t, &context->target_sid);
+	security_task_getsecid(t, &context->target_sid);
 }
 
 /**
@@ -1999,7 +1998,7 @@ int __audit_signal_info(int sig, struct 
 				audit_sig_uid = ctx->loginuid;
 			else
 				audit_sig_uid = tsk->uid;
-			selinux_get_task_sid(tsk, &audit_sig_sid);
+			security_task_getsecid(tsk, &audit_sig_sid);
 		}
 		if (!audit_signals || audit_dummy_context())
 			return 0;
@@ -2009,7 +2008,7 @@ int __audit_signal_info(int sig, struct 
 	 * in audit_context */
 	if (!ctx->target_pid) {
 		ctx->target_pid = t->tgid;
-		selinux_get_task_sid(t, &ctx->target_sid);
+		security_task_getsecid(t, &ctx->target_sid);
 		return 0;
 	}
 
@@ -2026,7 +2025,7 @@ int __audit_signal_info(int sig, struct 
 	BUG_ON(axp->pid_count >= AUDIT_AUX_PIDS);
 
 	axp->target_pid[axp->pid_count] = t->tgid;
-	selinux_get_task_sid(t, &axp->target_sid[axp->pid_count]);
+	security_task_getsecid(t, &axp->target_sid[axp->pid_count]);
 	axp->pid_count++;
 
 	return 0;
@@ -2054,16 +2053,16 @@ void audit_core_dumps(long signr)
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
-		kfree(ctx);
+		security_release_secctx(ctx, len);
 	}
 	audit_log_format(ab, " pid=%d comm=", current->pid);
 	audit_log_untrustedstring(ab, current->comm);
diff -uprN -X linux-2.6.23-rc4-base/Documentation/dontdiff linux-2.6.23-rc4-base/net/netlink/af_netlink.c linux-2.6.23-rc4-audit/net/netlink/af_netlink.c
--- linux-2.6.23-rc4-base/net/netlink/af_netlink.c	2007-08-26 23:51:49.000000000 -0700
+++ linux-2.6.23-rc4-audit/net/netlink/af_netlink.c	2007-08-27 00:52:10.000000000 -0700
@@ -54,7 +54,6 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <linux/audit.h>
-#include <linux/selinux.h>
 #include <linux/mutex.h>
 
 #include <net/sock.h>
@@ -1190,7 +1189,7 @@ static int netlink_sendmsg(struct kiocb 
 	NETLINK_CB(skb).pid	= nlk->pid;
 	NETLINK_CB(skb).dst_group = dst_group;
 	NETLINK_CB(skb).loginuid = audit_get_loginuid(current->audit_context);
-	selinux_get_task_sid(current, &(NETLINK_CB(skb).sid));
+	security_task_getsecid(current, &(NETLINK_CB(skb).sid));
 	memcpy(NETLINK_CREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
 
 	/* What can I do? Netlink is asynchronous, so that
diff -uprN -X linux-2.6.23-rc4-base/Documentation/dontdiff linux-2.6.23-rc4-base/security/selinux/exports.c linux-2.6.23-rc4-audit/security/selinux/exports.c
--- linux-2.6.23-rc4-base/security/selinux/exports.c	2007-07-08 16:32:17.000000000 -0700
+++ linux-2.6.23-rc4-audit/security/selinux/exports.c	2007-08-27 00:52:10.000000000 -0700
@@ -21,48 +21,6 @@
 #include "security.h"
 #include "objsec.h"
 
-int selinux_sid_to_string(u32 sid, char **ctx, u32 *ctxlen)
-{
-	if (selinux_enabled)
-		return security_sid_to_context(sid, ctx, ctxlen);
-	else {
-		*ctx = NULL;
-		*ctxlen = 0;
-	}
-
-	return 0;
-}
-
-void selinux_get_inode_sid(const struct inode *inode, u32 *sid)
-{
-	if (selinux_enabled) {
-		struct inode_security_struct *isec = inode->i_security;
-		*sid = isec->sid;
-		return;
-	}
-	*sid = 0;
-}
-
-void selinux_get_ipc_sid(const struct kern_ipc_perm *ipcp, u32 *sid)
-{
-	if (selinux_enabled) {
-		struct ipc_security_struct *isec = ipcp->security;
-		*sid = isec->sid;
-		return;
-	}
-	*sid = 0;
-}
-
-void selinux_get_task_sid(struct task_struct *tsk, u32 *sid)
-{
-	if (selinux_enabled) {
-		struct task_security_struct *tsec = tsk->security;
-		*sid = tsec->sid;
-		return;
-	}
-	*sid = 0;
-}
-
 int selinux_string_to_sid(char *str, u32 *sid)
 {
 	if (selinux_enabled)
diff -uprN -X linux-2.6.23-rc4-base/Documentation/dontdiff linux-2.6.23-rc4-base/security/selinux/hooks.c linux-2.6.23-rc4-audit/security/selinux/hooks.c
--- linux-2.6.23-rc4-base/security/selinux/hooks.c	2007-08-26 23:51:49.000000000 -0700
+++ linux-2.6.23-rc4-audit/security/selinux/hooks.c	2007-08-27 00:52:10.000000000 -0700
@@ -2722,6 +2722,13 @@ static int selinux_file_receive(struct f
 
 /* task security operations */
 
+static void selinux_get_task_sid(struct task_struct *tsk, u32 *sid)
+{
+	struct task_security_struct *tsec = tsk->security;
+	*sid = tsec->sid;
+	return;
+}
+
 static int selinux_task_create(unsigned long clone_flags)
 {
 	int rc;
@@ -3688,6 +3695,13 @@ out:	
 	return err;
 }
 
+static void selinux_get_inode_sid(const struct inode *inode, u32 *sid)
+{
+	struct inode_security_struct *isec = inode->i_security;
+	*sid = isec->sid;
+	return;
+}
+
 static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
 {
 	u32 peer_secid = SECSID_NULL;
@@ -4020,6 +4034,13 @@ static int selinux_netlink_recv(struct s
 	                    SECCLASS_CAPABILITY, CAP_TO_MASK(capability), &ad);
 }
 
+static void selinux_get_ipc_sid(const struct kern_ipc_perm *ipcp, u32 *sid)
+{
+	struct ipc_security_struct *isec = ipcp->security;
+	*sid = isec->sid;
+	return;
+}
+
 static int ipc_alloc_security(struct task_struct *task,
 			      struct kern_ipc_perm *perm,
 			      u16 sclass)
@@ -4661,6 +4682,30 @@ static void selinux_release_secctx(char 
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
@@ -4843,6 +4888,12 @@ static struct security_operations selinu
 
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
diff -uprN -X linux-2.6.23-rc4-base/Documentation/dontdiff linux-2.6.23-rc4-base/security/selinux/include/security.h linux-2.6.23-rc4-audit/security/selinux/include/security.h
--- linux-2.6.23-rc4-base/security/selinux/include/security.h	2007-08-26 23:51:50.000000000 -0700
+++ linux-2.6.23-rc4-audit/security/selinux/include/security.h	2007-08-27 00:52:10.000000000 -0700
@@ -129,5 +129,43 @@ static inline int security_netlbl_sid_to
 
 const char *security_get_initial_sid_context(u32 sid);
 
+/**
+ *      selinux_audit_rule_init - alloc/init an selinux audit rule structure.
+ *      @field: the field this rule refers to
+ *      @op: the operater the rule uses
+ *      @rulestr: the text "target" of the rule
+ *      @vpp: pointer to the new rule structure returned via this
+ *
+ *      Returns 0 if successful, -errno if not.  On success, the rule structure
+ *      will be allocated internally.  The caller must free this structure with
+ *      selinux_audit_rule_free() after use.
+ */
+int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vpp);
+
+/**
+ *      selinux_audit_rule_free - free an selinux audit rule structure.
+ *      @vp: pointer to the audit rule to be freed
+ *
+ *      This will free all memory associated with the given rule.
+ *      If @rule is NULL, no operation is performed.
+ */
+void selinux_audit_rule_free(void *vp);
+
+struct audit_context;
+/**
+ *      selinux_audit_rule_match - determine if a context ID matches a rule.
+ *      @sid: the context ID to check
+ *      @field: the field this rule refers to
+ *      @op: the operater the rule uses
+ *      @vp: pointer to the audit rule to check against
+ *      @actx: the audit context (can be NULL) associated with the check
+ *
+ *      Returns 1 if the context id matches the rule, 0 if it does not, and
+ *      -errno on failure.
+ */
+int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vp,
+                             struct audit_context *actx);
+
+
 #endif /* _SELINUX_SECURITY_H_ */
 
diff -uprN -X linux-2.6.23-rc4-base/Documentation/dontdiff linux-2.6.23-rc4-base/security/selinux/ss/services.c linux-2.6.23-rc4-audit/security/selinux/ss/services.c
--- linux-2.6.23-rc4-base/security/selinux/ss/services.c	2007-08-26 23:51:50.000000000 -0700
+++ linux-2.6.23-rc4-audit/security/selinux/ss/services.c	2007-08-27 00:52:10.000000000 -0700
@@ -2107,17 +2107,19 @@ struct selinux_audit_rule {
 	struct context au_ctxt;
 };
 
-void selinux_audit_rule_free(struct selinux_audit_rule *rule)
+void selinux_audit_rule_free(void *vp)
 {
+	struct selinux_audit_rule *rule = (struct selinux_audit_rule*)vp;
+
 	if (rule) {
 		context_destroy(&rule->au_ctxt);
 		kfree(rule);
 	}
 }
 
-int selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
-                            struct selinux_audit_rule **rule)
+int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vpp)
 {
+	struct selinux_audit_rule **rule = (struct selinux_audit_rule**)vpp;
 	struct selinux_audit_rule *tmprule;
 	struct role_datum *roledatum;
 	struct type_datum *typedatum;
@@ -2208,10 +2210,10 @@ int selinux_audit_rule_init(u32 field, u
 	return rc;
 }
 
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
-                             struct selinux_audit_rule *rule,
+int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vp,
                              struct audit_context *actx)
 {
+	struct selinux_audit_rule *rule = (struct selinux_audit_rule*)vp;
 	struct context *ctxt;
 	struct mls_level *level;
 	int match = 0;
@@ -2320,7 +2322,7 @@ out:
 	return match;
 }
 
-static int (*aurule_callback)(void) = NULL;
+static int (*aurule_callback)(void) = audit_rule_update_callout;
 
 static int aurule_avc_callback(u32 event, u32 ssid, u32 tsid,
                                u16 class, u32 perms, u32 *retained)
@@ -2345,11 +2347,6 @@ static int __init aurule_init(void)
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



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
