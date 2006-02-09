Subject: [RFC][PATCH] collect security labels on user processes generating
	audit messages
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: selinux@tycho.nsa.gov, Linux Audit Discussion <linux-audit@redhat.com>
Cc: Serge Hallyn <serue@us.ibm.com>, James Morris <jmorris@namei.org>,
   Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 19:32:11 -0600
Message-Id: <1139448731.12941.30.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

This patch collects the security label for a user process generating
audit messages.  Traditionally, obtaining the security label of a
process in the kernel could be done using security_getprocattr().
However, due to the asynchronous nature of netlink, by the time the
kernel gets the audit message, the 'pid' packaged with it, may have
already been recycled.  Thus, if a task is found with 'pid', it may not
be the same task that issued the audit message, and the wrong security
label could be collected.  One solution to this problem and the solution
implemented here, is to collect the 'sid' of the process, while we are
running in that process' context.  This can be accomplished by attaching
the 'sid' to the audit message on the client-side of the netlink
interaction much like 'loginuid'.  When the message arrives to the
kernel and is processed by the audit subsystem, the 'sid' can then be
resolved to the correct security label.  One thing to keep in mind, is
that should the policy be changed and reloaded while an audit message is
in transit, the security label the 'sid' associated with that audit
message resolves to, may be invalid or incorrect.  

Notable details about this implementation:

1) A new SELinux interface was introduced to give other parts of the
kernel the ability to resolve 'sids' into security labels.  

2) SELinux and LSM were augmented to obtain the 'sid' of a task in a
similar manner to ipc and inode.

I've posted this message and patch as an RFC to solicit feedback from
the SELinux and audit communities.

I personally think that the Kconfig option could be a bit more
descriptive and selinux_getsecurity() could probably find a new home
outside of selinux/include/objsec.h, though that seemed to make sense
for me, at the time of coding.

Thank you.

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
index b4fe8aa..4178175 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -625,6 +625,11 @@ struct swap_info_struct;
  *	@p contains the task_struct for the task.
  *	@inode contains the inode structure for the inode.
  *
+ * @task_getsecurity:
+ *      Copy the security label associated with the task object into
+ *      @buffer.  @buffer may be NULL to request the size of the buffer
+ *      required.  @size indicates the size of @buffer in bytes. Return
+ *      number of bytes used/required on success.
  * Security hooks for Netlink messaging.
  *
  * @netlink_send:
@@ -1169,6 +1174,7 @@ struct security_operations {
 			   unsigned long arg5);
 	void (*task_reparent_to_init) (struct task_struct * p);
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
+	int (*task_getsecurity)(struct task_struct *tsk, void *buffer, size_t size);
 
 	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
 	int (*ipc_getsecurity)(struct kern_ipc_perm *ipcp, void *buffer, size_t size);
@@ -1817,6 +1823,11 @@ static inline void security_task_to_inod
 	security_ops->task_to_inode(p, inode);
 }
 
+static inline int security_task_getsecurity(struct task_struct *tsk,void *buffer, size_t size)
+{
+	return security_ops->task_getsecurity(tsk, buffer, size);
+}
+
 static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
 					   short flag)
 {
@@ -2457,6 +2468,11 @@ static inline void security_task_reparen
 static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
 { }
 
+static inline int security_task_getsecurity(struct task_struct *tsk, void *buffer, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
 					   short flag)
 {
diff --git a/include/linux/selinux_api.h b/include/linux/selinux_api.h
new file mode 100644
index 0000000..54102ab
--- /dev/null
+++ b/include/linux/selinux_api.h
@@ -0,0 +1,38 @@
+/*
+ * External SELinux API
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Author: Timothy R. Chavez <tinytim@us.ibm.com>
+ *
+ */
+
+#ifndef _LINUX_SELINUX_API_H
+#define _LINUX_SELINUX_API_H
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+
+#ifdef CONFIG_SECURITY_SELINUX_API
+int selinux_sid_to_context(u32 sid, void *ctx, size_t size);
+#else
+static inline int selinux_sid_to_context(u32 sid, void *ctx, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_SELINUX_API */
+#endif /* _LINUX_SELINUX_API_H */
diff --git a/kernel/audit.c b/kernel/audit.c
index d95efd6..0f158f0 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -49,6 +49,7 @@
 #include <linux/err.h>
 #include <linux/kthread.h>
 
+#include <linux/selinux_api.h>
 #include <linux/audit.h>
 
 #include <net/sock.h>
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
+	int			len;
+	char 			*ctx = NULL;
 
 	err = audit_netlink_ok(NETLINK_CB(skb).eff_cap, msg_type);
 	if (err)
@@ -409,6 +412,7 @@ static int audit_receive_msg(struct sk_b
 	pid  = NETLINK_CREDS(skb)->pid;
 	uid  = NETLINK_CREDS(skb)->uid;
 	loginuid = NETLINK_CB(skb).loginuid;
+	sid = NETLINK_CB(skb).secid;
 	seq  = nlh->nlmsg_seq;
 	data = NLMSG_DATA(nlh);
 
@@ -460,11 +464,26 @@ static int audit_receive_msg(struct sk_b
 			err = 0;
 			ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
 			if (ab) {
+				len = selinux_sid_to_context(sid, NULL, 0);
+				if (len < 0 && len != -EOPNOTSUPP)
+					return len;
+				else if (len > 0) {
+					ctx = (char *)kmalloc(len, GFP_KERNEL);
+					if (!ctx)
+						return -ENOMEM;
+					len = selinux_sid_to_context(sid, ctx, len);
+					if (len < 0) {
+						kfree(ctx);
+						return len;
+					}
+				}
 				audit_log_format(ab,
-						 "user pid=%d uid=%u auid=%u msg='%.1024s'",
-						 pid, uid, loginuid, (char *)data);
+						 "user pid=%d uid=%u auid=%u subj=%s msg='%.1024s'",
+						 pid, uid, loginuid, (!ctx ? "null" : ctx),
+						 (char *)data);
 				audit_set_pid(ab, pid);
 				audit_log_end(ab);
+				kfree(ctx);
 			}
 		}
 		break;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 96020d7..a516453 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1120,6 +1120,7 @@ static int netlink_sendmsg(struct kiocb 
 	NETLINK_CB(skb).dst_pid = dst_pid;
 	NETLINK_CB(skb).dst_group = dst_group;
 	NETLINK_CB(skb).loginuid = audit_get_loginuid(current->audit_context);
+	NETLINK_CB(skb).secid = security_task_getsid(current);
 	memcpy(NETLINK_CREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
 
 	/* What can I do? Netlink is asynchronous, so that
diff --git a/security/dummy.c b/security/dummy.c
index 75e7c4a..768a39a 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -557,6 +557,11 @@ static void dummy_task_reparent_to_init 
 static void dummy_task_to_inode(struct task_struct *p, struct inode *inode)
 { }
 
+static int dummy_task_getsecurity(struct task_struct *tsk, void *buffer, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
 static int dummy_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
 {
 	return 0;
@@ -934,6 +939,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_prctl);
 	set_to_dummy_if_null(ops, task_reparent_to_init);
  	set_to_dummy_if_null(ops, task_to_inode);
+	set_to_dummy_if_null(ops, task_getsecurity);
 	set_to_dummy_if_null(ops, ipc_permission);
 	set_to_dummy_if_null(ops, ipc_getsecurity);
 	set_to_dummy_if_null(ops, msg_msg_alloc_security);
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index b59582b..424c24e 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -95,3 +95,11 @@ config SECURITY_SELINUX_CHECKREQPROT_VAL
 	  via /selinux/checkreqprot if authorized by policy.
 
 	  If you are unsure how to answer this question, answer 1.
+
+config SECURITY_SELINUX_API
+	bool "NSA SELinux API"
+	depends on SECURITY_SELINUX
+	default n
+	help
+	 This option exposes internal SELinux concepts such as a 'security id'
+	 to other parts of the kernel.
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index b038cd0..4cf0782 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -8,5 +8,7 @@ selinux-y := avc.o hooks.o selinuxfs.o n
 
 selinux-$(CONFIG_SECURITY_NETWORK) += netif.o
 
+selinux-$(CONFIG_SECURITY_SELINUX_API) += selinux_api.o
+
 EXTRA_CFLAGS += -Isecurity/selinux/include
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 21c8aa6..88e9d87 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -118,7 +118,7 @@ static DEFINE_SPINLOCK(sb_security_lock)
 
 /* Return security context for a given sid or just the context 
    length if the buffer is null or length is 0 */
-static int selinux_getsecurity(u32 sid, void *buffer, size_t size)
+int selinux_getsecurity(u32 sid, void *buffer, size_t size)
 {
 	char *context;
 	unsigned len;
@@ -2769,6 +2769,13 @@ static void selinux_task_to_inode(struct
 	return;
 }
 
+static int selinux_task_getsecurity(struct task_struct *tsk, void *buffer, size_t size)
+{
+	struct task_security_struct *tsec = tsk->security;
+	
+	return selinux_getsecurity(tsec->sid, buffer, size);
+}
+
 #ifdef CONFIG_SECURITY_NETWORK
 
 /* Returns error only if unable to parse addresses */
@@ -4319,6 +4326,7 @@ static struct security_operations selinu
 	.task_prctl =			selinux_task_prctl,
 	.task_reparent_to_init =	selinux_task_reparent_to_init,
 	.task_to_inode =                selinux_task_to_inode,
+	.task_getsecurity =		selinux_task_getsecurity,
 
 	.ipc_permission =		selinux_ipc_permission,
 	.ipc_getsecurity =		selinux_ipc_getsecurity,
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 887937c..9fc4692 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -109,4 +109,6 @@ struct sk_security_struct {
 
 extern unsigned int selinux_checkreqprot;
 
+int selinux_getsecurity(u32 sid, void *buffer, size_t size);
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/selinux_api.c b/security/selinux/selinux_api.c
new file mode 100644
index 0000000..7604766
--- /dev/null
+++ b/security/selinux/selinux_api.c
@@ -0,0 +1,8 @@
+#include <linux/selinux_api.h>
+
+extern int selinux_getsecurity(u32 sid, void *buffer, size_t size);
+
+int selinux_sid_to_context(u32 sid, void *ctx, size_t size)
+{
+	return selinux_getsecurity(sid, ctx, size);
+}



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
