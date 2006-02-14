Subject: Re: [RFC][PATCH] collect security labels on user processes
	generating audit messages
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>
In-Reply-To: <1139857945.14253.112.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1139530450.12638.7.camel@localhost>
	 <1139857945.14253.112.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 17:48:22 -0600
Message-Id: <1139960902.326.5.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James & Stephen,

Thank you for the comments.  While implementing your feedback I came
across a pretty severe bug.  I was basically obtaining the sid and then
throwing it away (I was returning it from the function, but not actually
assigning it to anything).  New patch below.  I still need to test this
a little more.  Thanks!

-tim

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 6a2ccf7..ccd5905 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -143,6 +143,7 @@ struct netlink_skb_parms
 	__u32			dst_group;
 	kernel_cap_t		eff_cap;
 	__u32			loginuid;	/* Login (audit) uid */
+	__u32			secid;		/* SELinux security id */
 };
 
 #define NETLINK_CB(skb)		(*(struct netlink_skb_parms*)&((skb)->cb))
diff --git a/include/linux/security.h b/include/linux/security.h
index b4fe8aa..c6fe5fe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -625,6 +625,11 @@ struct swap_info_struct;
  *	@p contains the task_struct for the task.
  *	@inode contains the inode structure for the inode.
  *
+ * @task_getsecid:
+ * 	Get the SID (security id) of a task.
+ *	@tsk contains the task_struct for the task
+ *	@sid is storage for task SID
+ *
  * Security hooks for Netlink messaging.
  *
  * @netlink_send:
@@ -1169,6 +1174,7 @@ struct security_operations {
 			   unsigned long arg5);
 	void (*task_reparent_to_init) (struct task_struct * p);
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
+	void (*task_getsecid)(struct task_struct *tsk, __u32 *sid);
 
 	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
 	int (*ipc_getsecurity)(struct kern_ipc_perm *ipcp, void *buffer, size_t size);
@@ -1817,6 +1823,11 @@ static inline void security_task_to_inod
 	security_ops->task_to_inode(p, inode);
 }
 
+static inline void security_task_getsecid(struct task_struct *tsk, __u32 *sid)
+{
+	security_ops->task_getsecid(tsk, sid);
+}
+
 static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
 					   short flag)
 {
@@ -2457,6 +2468,9 @@ static inline void security_task_reparen
 static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
 { }
 
+static inline void security_task_getsecid(struct task_struct *tsk, __u32 *sid)
+{ }
+
 static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
 					   short flag)
 {
diff --git a/include/linux/selinux.h b/include/linux/selinux.h
new file mode 100644
index 0000000..c2e0e20
--- /dev/null
+++ b/include/linux/selinux.h
@@ -0,0 +1,52 @@
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
+#ifndef _LINUX_SELINUX_H
+#define _LINUX_SELINUX_H
+
+#ifdef CONFIG_SECURITY_SELINUX
+
+/**
+ *	selinux_available - check if SELinux is available for use.
+ *
+ *	Returns true if configured, enabled, not disabled and policy loaded.
+ */
+int selinux_available(void);
+
+/**
+ *	selinux_id_to_ctx - map a security context ID to a string
+ *	@ctxid: security context ID to be converted.
+ *	@ctx: address of context string to be returned
+ *	@ctxlen: length of returned context string.
+ *
+ *	Returns 0 if successful, -errno if not.  On success, the context
+ *	string will be allocated internally, and the caller must call
+ *	kfree() on it after use.
+ */
+int selinux_id_to_ctx(u32 ctxid, char **ctx, u32 *ctxlen);
+
+#else
+
+static inline int selinux_available(void)
+{
+	return 0;
+}
+
+static inline int selinux_id_to_ctx(u32 ctxid, char **ctx, u32 *ctxlen)
+{
+	*ctx = NULL;
+	*ctxlen = 0;
+	return 0;
+}
+
+#endif /* CONFIG_SECURITY_SELINUX */
+
+#endif /* _LINUX_SELINUX_H */
diff --git a/kernel/audit.c b/kernel/audit.c
index d95efd6..4ca77dd 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -50,6 +50,7 @@
 #include <linux/kthread.h>
 
 #include <linux/audit.h>
+#include <linux/selinux.h>
 
 #include <net/sock.h>
 #include <linux/skbuff.h>
@@ -383,7 +384,7 @@ static int audit_netlink_ok(kernel_cap_t
 
 static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 {
-	u32			uid, pid, seq;
+	u32			uid, pid, sid, seq;
 	void			*data;
 	struct audit_status	*status_get, status_set;
 	int			err;
@@ -391,6 +392,8 @@ static int audit_receive_msg(struct sk_b
 	u16			msg_type = nlh->nlmsg_type;
 	uid_t			loginuid; /* loginuid of sender */
 	struct audit_sig_info   sig_data;
+	char *			ctx = NULL;
+	u32			len;
 
 	err = audit_netlink_ok(NETLINK_CB(skb).eff_cap, msg_type);
 	if (err)
@@ -409,6 +412,7 @@ static int audit_receive_msg(struct sk_b
 	pid  = NETLINK_CREDS(skb)->pid;
 	uid  = NETLINK_CREDS(skb)->uid;
 	loginuid = NETLINK_CB(skb).loginuid;
+	sid = NETLINK_CB(skb).secid;
 	seq  = nlh->nlmsg_seq;
 	data = NLMSG_DATA(nlh);
 
@@ -458,14 +462,20 @@ static int audit_receive_msg(struct sk_b
 		err = audit_filter_user(&NETLINK_CB(skb), msg_type);
 		if (err == 1) {
 			err = 0;
+			if (selinux_available()) {
+				err = selinux_id_to_ctx(sid, &ctx, &len);
+				if (err < 0)
+					return err;
+			}
 			ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
 			if (ab) {
 				audit_log_format(ab,
-						 "user pid=%d uid=%u auid=%u msg='%.1024s'",
-						 pid, uid, loginuid, (char *)data);
+						 "user pid=%d uid=%u auid=%u subj=%s msg='%.1024s'",
+						 pid, uid, loginuid, ctx ? ctx : "null", (char *)data);
 				audit_set_pid(ab, pid);
 				audit_log_end(ab);
 			}
+			kfree(ctx);
 		}
 		break;
 	case AUDIT_ADD:
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 96020d7..1f4b241 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1120,6 +1120,7 @@ static int netlink_sendmsg(struct kiocb 
 	NETLINK_CB(skb).dst_pid = dst_pid;
 	NETLINK_CB(skb).dst_group = dst_group;
 	NETLINK_CB(skb).loginuid = audit_get_loginuid(current->audit_context);
+	security_task_getsecid(current, &NETLINK_CB(skb).secid);
 	memcpy(NETLINK_CREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
 
 	/* What can I do? Netlink is asynchronous, so that
diff --git a/security/dummy.c b/security/dummy.c
index 75e7c4a..2325823 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -557,6 +557,12 @@ static void dummy_task_reparent_to_init 
 static void dummy_task_to_inode(struct task_struct *p, struct inode *inode)
 { }
 
+static void dummy_task_getsecid(struct task_struct *tsk, __u32 *sid)
+{
+	*sid = 0;
+	return;
+}
+
 static int dummy_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
 {
 	return 0;
@@ -934,6 +940,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_prctl);
 	set_to_dummy_if_null(ops, task_reparent_to_init);
  	set_to_dummy_if_null(ops, task_to_inode);
+	set_to_dummy_if_null(ops, task_getsecid);
 	set_to_dummy_if_null(ops, ipc_permission);
 	set_to_dummy_if_null(ops, ipc_getsecurity);
 	set_to_dummy_if_null(ops, msg_msg_alloc_security);
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index b038cd0..3e3d4eb 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o ss/
 
-selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o
+selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o exports.o
 
 selinux-$(CONFIG_SECURITY_NETWORK) += netif.o
 
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
new file mode 100644
index 0000000..c4707fc
--- /dev/null
+++ b/security/selinux/exports.c
@@ -0,0 +1,32 @@
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
+
+extern int ss_initialized;
+
+int selinux_available(void)
+{
+	return ss_initialized;
+}
+
+int selinux_id_to_ctx(u32 ctxid, char **ctx, u32 *ctxlen)
+{
+	return security_sid_to_context(ctxid, ctx, ctxlen);
+}
+
+EXPORT_SYMBOL_GPL(selinux_available);
+EXPORT_SYMBOL_GPL(selinux_id_to_ctx);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 21c8aa6..d2356ad 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2769,6 +2769,14 @@ static void selinux_task_to_inode(struct
 	return;
 }
 
+static void selinux_task_getsecid(struct task_struct *tsk, __u32 *sid)
+{
+	struct task_security_struct *tsec = tsk->security;
+	
+	*sid = tsec->sid;
+	return;
+}
+
 #ifdef CONFIG_SECURITY_NETWORK
 
 /* Returns error only if unable to parse addresses */
@@ -4319,6 +4327,7 @@ static struct security_operations selinu
 	.task_prctl =			selinux_task_prctl,
 	.task_reparent_to_init =	selinux_task_reparent_to_init,
 	.task_to_inode =                selinux_task_to_inode,
+	.task_getsecid =		selinux_task_getsecid,
 
 	.ipc_permission =		selinux_ipc_permission,
 	.ipc_getsecurity =		selinux_ipc_getsecurity,
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 5f016c9..a2e5bb0 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -63,7 +63,7 @@ int security_change_sid(u32 ssid, u32 ts
 int security_sid_to_context(u32 sid, char **scontext,
 	u32 *scontext_len);
 
-int security_context_to_sid(char *scontext, u32 scontext_len,
+int security_context_to_sid(const char *scontext, u32 scontext_len,
 	u32 *out_sid);
 
 int security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *out_sid, u32 def_sid);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 2311255..c66f765 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -617,7 +617,7 @@ out:
 
 }
 
-static int security_context_to_sid_core(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
+static int security_context_to_sid_core(const char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
 {
 	char *scontext2;
 	struct context context;
@@ -743,7 +743,7 @@ out:
  * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
  * memory is available, or 0 on success.
  */
-int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
+int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
 	                                    sid, SECSID_NULL);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
