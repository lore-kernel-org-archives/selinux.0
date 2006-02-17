Subject: Re: [RFC][PATCH] collect security labels on user
	processes	generating audit messages
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <43F39797.1050602@trustedcs.com>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1139530450.12638.7.camel@localhost>
	 <1139857945.14253.112.camel@moss-spartans.epoch.ncsc.mil>
	 <1139960902.326.5.camel@localhost>  <43F39797.1050602@trustedcs.com>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 14:58:00 -0600
Message-Id: <1140209880.752.12.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-15 at 15:05 -0600, Darrel Goeddel wrote:
<snip>
> 
> Should you really be using an lsm interface for getting the sid?  The
> patch is currently allowing any security module to put a secid (whose
> comment says SELinux security id) into the netlink_skb_params struct.
> This generic item is then only used in SELinux specific calls.  It
> seems that the getsecid functionality could just fit into an SELinux
> specific API just like selinux_id_to_ctx and friends.  That would also
> avoid the overhead of lsm and all of the associated code changes.  Of
> course this is probably moot if there are other planned uses for
> security_task_getsecid().
> 

Thanks Darrel!  New patch attached... so... assuming this is good... how
are we going to do this API merger :] ?

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 6a2ccf7..a2538b4 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -143,6 +143,7 @@ struct netlink_skb_parms
 	__u32			dst_group;
 	kernel_cap_t		eff_cap;
 	__u32			loginuid;	/* Login (audit) uid */
+	u32			secid;		/* SELinux security id */
 };
 
 #define NETLINK_CB(skb)		(*(struct netlink_skb_parms*)&((skb)->cb))
diff --git a/include/linux/selinux.h b/include/linux/selinux.h
new file mode 100644
index 0000000..4d67711
--- /dev/null
+++ b/include/linux/selinux.h
@@ -0,0 +1,55 @@
+/*
+ * SELinux services exported to the rest of the kernel.
+ *
+ * Author: James Morris <jmorris@redhat.com>
+ *	   Timothy R. Chavez <tinytim@us.ibm.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ * Copyright (C) IBM Corporation, 2006
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
+/**
+ *     selinux_task_getsecid - return the SID of task
+ *	@tsk: the task whose SID will be returned
+ *
+ * 	Returns 0 if SELinux is disabled, otherwise the SID is returned.
+ */
+int selinux_task_getsecid(struct task_struct *tsk);
+
+#else
+
+static inline int selinux_id_to_ctx(u32 ctxid, char **ctx, u32 *ctxlen)
+{
+	*ctx = NULL;
+	*ctxlen = 0;
+	return 0;
+}
+
+static inline u32 selinux_task_getsecid(struct task_struct *tsk)
+{
+	return 0;
+}
+
+#endif /* CONFIG_SECURITY_SELINUX */
+
+#endif /* _LINUX_SELINUX_H */
diff --git a/kernel/audit.c b/kernel/audit.c
index d95efd6..334340d 100644
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
+	char *			ctx;
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
 
@@ -457,15 +461,18 @@ static int audit_receive_msg(struct sk_b
 
 		err = audit_filter_user(&NETLINK_CB(skb), msg_type);
 		if (err == 1) {
-			err = 0;
+			err = selinux_id_to_ctx(sid, &ctx, &len);
+			if (err < 0)
+				return err;
 			ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
 			if (ab) {
 				audit_log_format(ab,
-						 "user pid=%d uid=%u auid=%u msg='%.1024s'",
-						 pid, uid, loginuid, (char *)data);
+						 "user pid=%d uid=%u auid=%u subj=%s msg='%.1024s'",
+						 pid, uid, loginuid, ctx ? ctx : "(null)", (char *)data);
 				audit_set_pid(ab, pid);
 				audit_log_end(ab);
 			}
+			kfree(ctx);
 		}
 		break;
 	case AUDIT_ADD:
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 96020d7..f6a47a4 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -55,6 +55,7 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <linux/audit.h>
+#include <linux/selinux.h>
 
 #include <net/sock.h>
 #include <net/scm.h>
@@ -1120,6 +1121,7 @@ static int netlink_sendmsg(struct kiocb 
 	NETLINK_CB(skb).dst_pid = dst_pid;
 	NETLINK_CB(skb).dst_group = dst_group;
 	NETLINK_CB(skb).loginuid = audit_get_loginuid(current->audit_context);
+	NETLINK_CB(skb).secid = selinux_task_getsecid(current);
 	memcpy(NETLINK_CREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
 
 	/* What can I do? Netlink is asynchronous, so that
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
index 0000000..29755ba
--- /dev/null
+++ b/security/selinux/exports.c
@@ -0,0 +1,47 @@
+/*
+ * SELinux services exported to the rest of the kernel.
+ *
+ * Author: James Morris <jmorris@redhat.com>
+ * 	   Timothy R. Chavez <tinytim@us.ibm.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ * Copyright (C) IBM Corporation, 2006
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
+extern int ss_initialized;
+
+int selinux_id_to_ctx(u32 ctxid, char **ctx, u32 *ctxlen)
+{
+	if (ss_initialized)
+		return security_sid_to_context(ctxid, ctx, ctxlen);
+	else {
+		*ctx = NULL;
+		*ctxlen = 0;
+	}
+
+	return 0;
+}
+
+u32 selinux_task_getsecid(struct task_struct *tsk)
+{
+	u32 sid = 0;
+
+	if (ss_initialized)
+		sid = ((struct task_security_struct *)tsk->security)->sid;
+	
+	return sid;
+}
+
+EXPORT_SYMBOL_GPL(selinux_id_to_ctx);
+EXPORT_SYMBOL_GPL(selinux_task_getsecid);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
