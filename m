Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w21NqE7v027293
 for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2018 18:52:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E99F340FB657
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 23:52:08 +0000 (UTC)
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 01 Mar 2018 18:52:08 -0500
Message-ID: <151994832810.32269.8035664161422596677.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] selinux: rename the {is,set}_enforcing() functions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Rename is_enforcing() to enforcing_enabled() and
enforcing_set() to set_enforcing().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/avc.c              |    2 +-
 security/selinux/hooks.c            |    4 ++--
 security/selinux/include/security.h |    8 ++++----
 security/selinux/selinuxfs.c        |    6 +++---
 security/selinux/ss/services.c      |    6 +++---
 security/selinux/ss/status.c        |    2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 36124f48a5ff..54b09cc03b55 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -985,7 +985,7 @@ static noinline int avc_denied(u32 ssid, u32 tsid,
 	if (flags & AVC_STRICT)
 		return -EACCES;
 
-	if (is_enforcing(&selinux_state) &&
+	if (enforcing_enabled(&selinux_state) &&
 	    !(avd->flags & AVD_FLAGS_PERMISSIVE))
 		return -EACCES;
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d78f9e2f6df0..337fb325e5cc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5407,7 +5407,7 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 			       sk->sk_protocol, nlh->nlmsg_type,
 			       secclass_map[sksec->sclass - 1].name,
 			       task_pid_nr(current), current->comm);
-			if (!is_enforcing(&selinux_state) ||
+			if (!enforcing_enabled(&selinux_state) ||
 			    security_get_allow_unknown(&selinux_state))
 				err = 0;
 		}
@@ -6937,7 +6937,7 @@ static __init int selinux_init(void)
 	printk(KERN_INFO "SELinux:  Initializing.\n");
 
 	memset(&selinux_state, 0, sizeof(selinux_state));
-	set_enforcing(&selinux_state, selinux_enforcing_boot);
+	enforcing_set(&selinux_state, selinux_enforcing_boot);
 	selinux_state.checkreqprot = selinux_checkreqprot_boot;
 	selinux_ss_init(&selinux_state.ss);
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index c3a1ef10e710..f1db09a5f521 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -111,22 +111,22 @@ void selinux_ss_init(struct selinux_ss **ss);
 extern struct selinux_state selinux_state;
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
-static inline bool is_enforcing(struct selinux_state *state)
+static inline bool enforcing_enabled(struct selinux_state *state)
 {
 	return state->enforcing;
 }
 
-static inline void set_enforcing(struct selinux_state *state, bool value)
+static inline void enforcing_set(struct selinux_state *state, bool value)
 {
 	state->enforcing = value;
 }
 #else
-static inline bool is_enforcing(struct selinux_state *state)
+static inline bool enforcing_enabled(struct selinux_state *state)
 {
 	return true;
 }
 
-static inline void set_enforcing(struct selinux_state *state, bool value)
+static inline void enforcing_set(struct selinux_state *state, bool value)
 {
 }
 #endif
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 98492755adbf..0dbd5fd6a396 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -98,7 +98,7 @@ static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
 	ssize_t length;
 
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
-			   is_enforcing(&selinux_state));
+			   enforcing_enabled(&selinux_state));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
@@ -128,7 +128,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 
 	new_value = !!new_value;
 
-	old_value = is_enforcing(&selinux_state);
+	old_value = enforcing_enabled(&selinux_state);
 
 	if (new_value != old_value) {
 		length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
@@ -141,7 +141,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 			new_value, old_value,
 			from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			audit_get_sessionid(current));
-		set_enforcing(&selinux_state, new_value);
+		enforcing_set(&selinux_state, new_value);
 		if (new_value)
 			avc_ss_reset(0);
 		selnl_notify_setenforce(new_value);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3698352213d7..4785ca552d51 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -752,7 +752,7 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
 	kfree(n);
 	kfree(t);
 
-	if (!is_enforcing(state))
+	if (!enforcing_enabled(state))
 		return 0;
 	return -EPERM;
 }
@@ -1596,7 +1596,7 @@ static int compute_sid_handle_invalid_context(
 	kfree(s);
 	kfree(t);
 	kfree(n);
-	if (!is_enforcing(state))
+	if (!enforcing_enabled(state))
 		return 0;
 	return -EACCES;
 }
@@ -1907,7 +1907,7 @@ static inline int convert_context_handle_invalid_context(
 	char *s;
 	u32 len;
 
-	if (is_enforcing(state))
+	if (enforcing_enabled(state))
 		return -EINVAL;
 
 	if (!context_struct_to_string(policydb, context, &s, &len)) {
diff --git a/security/selinux/ss/status.c b/security/selinux/ss/status.c
index 043efc59f8e4..a121de45ac0e 100644
--- a/security/selinux/ss/status.c
+++ b/security/selinux/ss/status.c
@@ -56,7 +56,7 @@ struct page *selinux_kernel_status_page(struct selinux_state *state)
 
 			status->version = SELINUX_KERNEL_STATUS_VERSION;
 			status->sequence = 0;
-			status->enforcing = is_enforcing(state);
+			status->enforcing = enforcing_enabled(state);
 			/*
 			 * NOTE: the next policyload event shall set
 			 * a positive value on the status->policyload,
