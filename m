MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH] keys: Kernel access key retention support for SELinux
Date: Tue, 23 May 2006 15:23:24 -0500
Message-ID: <9FD2C54661D3494AB6F269E0D4A74E83894570@DSBEXCLUSTER.ad.uiuc.edu>
From: "Michael D Lemay" <mdlemay2@cs.uiuc.edu>
To: <selinux@tycho.nsa.gov>
Cc: <sds@tycho.nsa.gov>, <jmorris@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The patch below provides SELinux support for the access key retention subsystem of the kernel.  It includes headers from a modified version of the SELinux reference policy, defining a new security class for retained keys.  I haven't modified the securiy hooks that the key subsystem already uses, and I simply introduced the permissions already defined within the key retention subsystem into SELinux: view, read, write, search, link, setattr.  More discussion may be necessary to determine if these permissions and hooks are actually sufficient to provide acceptable security.

I've tested these changes using the keyutils package distributed by David Howells at http://people.redhat.com/dhowells/keyutils/.  I created a policy module for the refpolicy that will permit sysadm_r to execute the keyctl utility that is provided by keyutils.  If anyone else is interested in that module, just send me a message.

The first part of the patch introduces a new function for translating a binary key permission mask into an explanatory character string.  The next change is located in the central function that the key system uses to perform discretionary and mandatory access control authorizations.  It simply bypasses LSM if no permissions have been requested.  The SELinux auditing framework has also been extended with support for the new security class.  The subsequent single-line change fixes a minor typing mistake in a comment.  That is followed by the most significant addition, the actual SELinux hooks for dealing with retained keys.  The remainder of the patch comprises auto-generated flask header modifications, and support structures and definitions for the rest of the additions.

---<snip>---
From: Michael LeMay <mdlemay2@cs.uiuc.edu>

Introduce SELinux hooks to support the access key retention subsystem within the kernel.  Extend the key subsystem with a function for translating binary key permissions into an explanatory character string.  Incorporate new flask headers from a modified version of the SELinux reference policy, with support for the new security class representing retained keys.  Fix a minor typing mistake in one comment.

Signed-off-by: Michael LeMay <mdlemay2@cs.uiuc.edu>

---

diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/include/linux/key-ui.h linux-2.6.17-rc4-mm1/include/linux/key-ui.h
--- linux-2.6.16/include/linux/key-ui.h	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc4-mm1/include/linux/key-ui.h	2006-05-19 13:21:07.000000000 -0400
@@ -28,6 +28,13 @@ extern spinlock_t key_serial_lock;
 #define	KEY_ALL		0x3f	/* all the above permissions */
 
 /*
+ * Produce a string explaining a key permission value
+ */
+extern void key_perm_expn (key_perm_t pm, char * buf);
+/* Maximum length of explanation: */
+#define MAX_KEY_PERM_EXPN_LEN 37
+
+/*
  * the keyring payload contains a list of the keys to which the keyring is
  * subscribed
  */
diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/keys/key.c linux-2.6.17-rc4-mm1/security/keys/key.c
--- linux-2.6.16/security/keys/key.c	2006-05-23 10:01:55.000000000 -0400
+++ linux-2.6.17-rc4-mm1/security/keys/key.c	2006-05-19 13:21:56.000000000 -0400
@@ -51,6 +51,32 @@ void __key_check(const struct key *key)
 
 /*****************************************************************************/
 /*
+ * Produce a formatted explanation of a key permission value
+ */
+void key_perm_expn (key_perm_t pm, char * buf) {
+  buf[0] = '\0';
+  if (pm & KEY_VIEW) {
+    strcat(buf, "view,");
+  }
+  if (pm & KEY_READ) {
+    strcat(buf, "read,");
+  }
+  if (pm & KEY_WRITE) {
+    strcat(buf, "write,");
+  }
+  if (pm & KEY_SEARCH) {
+    strcat(buf, "search,");
+  }
+  if (pm & KEY_LINK) {
+    strcat(buf, "link,");
+  }
+  if (pm & KEY_SETATTR) {
+    strcat(buf, "setattr,");
+  }
+}
+
+/*****************************************************************************/
+/*
  * get the key quota record for a user, allocating a new record if one doesn't
  * already exist
  */
diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/keys/permission.c linux-2.6.17-rc4-mm1/security/keys/permission.c
--- linux-2.6.16/security/keys/permission.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc4-mm1/security/keys/permission.c	2006-05-23 13:51:46.000000000 -0400
@@ -67,6 +67,10 @@ use_these_perms:
 	if (kperm != perm)
 		return -EACCES;
 
+	/* no permissions requested, don't need to consult LSM */
+	if (perm == 0)
+	  return 0;
+
 	/* let LSM be the final arbiter */
 	return security_key_permission(key_ref, context, perm);
 
diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/selinux/avc.c linux-2.6.17-rc4-mm1/security/selinux/avc.c
--- linux-2.6.16/security/selinux/avc.c	2006-05-23 10:01:12.000000000 -0400
+++ linux-2.6.17-rc4-mm1/security/selinux/avc.c	2006-05-23 10:57:58.000000000 -0400
@@ -21,6 +21,7 @@
 #include <linux/dcache.h>
 #include <linux/init.h>
 #include <linux/skbuff.h>
+#include <linux/key-ui.h>
 #include <linux/percpu.h>
 #include <net/sock.h>
 #include <linux/un.h>
@@ -567,6 +568,12 @@ void avc_audit(u32 ssid, u32 tsid,
 		case AVC_AUDIT_DATA_CAP:
 			audit_log_format(ab, " capability=%d", a->u.cap);
 			break;
+		case AVC_AUDIT_DATA_RET_KEY:
+		  {
+		        char expn[MAX_KEY_PERM_EXPN_LEN];
+			key_perm_expn(a->u.ret_key, expn);
+		        audit_log_format(ab, " key_perm=%s (%08x)", expn, a->u.ret_key);
+		  } break;
 		case AVC_AUDIT_DATA_FS:
 			if (a->u.fs.dentry) {
 				struct dentry *dentry = a->u.fs.dentry;
diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/selinux/hooks.c linux-2.6.17-rc4-mm1/security/selinux/hooks.c
--- linux-2.6.16/security/selinux/hooks.c	2006-05-23 10:01:55.000000000 -0400
+++ linux-2.6.17-rc4-mm1/security/selinux/hooks.c	2006-05-23 11:00:38.000000000 -0400
@@ -932,7 +932,7 @@ static inline u32 signal_to_av(int sig)
 	return perm;
 }
 
-/* Check permission betweeen a pair of tasks, e.g. signal checks,
+/* Check permission between a pair of tasks, e.g. signal checks,
    fork check, ptrace check, etc. */
 static int task_has_perm(struct task_struct *tsk1,
 			 struct task_struct *tsk2,
@@ -4228,6 +4228,55 @@ static int selinux_setprocattr(struct ta
 	return size;
 }
 
+#ifdef CONFIG_KEYS
+
+int selinux_key_alloc (struct key * k) {
+        struct task_security_struct *tsec = current->security;
+	struct key_security_struct *ksec;
+
+	ksec = kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
+	if (!ksec)
+		return -ENOMEM;
+
+	ksec->obj = k;
+	ksec->sid = tsec->sid;
+	k->security = ksec;
+
+	return 0;
+}
+
+void selinux_key_free (struct key * k) {
+	struct key_security_struct *ksec = k->security;
+
+	k->security = NULL;
+	kfree(ksec);
+}
+
+int selinux_key_permission (key_ref_t key_ref,
+			    struct task_struct *ctx,
+			    key_perm_t perm) {
+	int rc;
+	struct task_security_struct *tsec;
+	struct avc_audit_data ad;
+
+	tsec = ctx->security;
+
+	rc = secondary_ops->key_permission(key_ref, ctx, perm);
+	if (rc)
+		return rc;
+
+	AVC_AUDIT_DATA_INIT(&ad, RET_KEY);
+	ad.tsk = ctx;
+	ad.u.ret_key = perm;
+
+	rc = avc_has_perm(tsec->sid, tsec->sid,
+			    SECCLASS_RETAINED_KEY, perm, &ad);
+
+	return rc;
+}
+
+#endif
+
 static struct security_operations selinux_ops = {
 	.ptrace =			selinux_ptrace,
 	.capget =			selinux_capget,
@@ -4380,6 +4429,12 @@ static struct security_operations selinu
 	.xfrm_state_free_security =	selinux_xfrm_state_free,
 	.xfrm_policy_lookup = 		selinux_xfrm_policy_lookup,
 #endif
+
+#ifdef CONFIG_KEYS
+	.key_alloc = selinux_key_alloc,
+	.key_free = selinux_key_free,
+	.key_permission = selinux_key_permission,
+#endif
 };
 
 static __init int selinux_init(void)
diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/selinux/include/avc.h linux-2.6.17-rc4-mm1/security/selinux/include/avc.h
--- linux-2.6.16/security/selinux/include/avc.h	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc4-mm1/security/selinux/include/avc.h	2006-05-19 10:14:38.000000000 -0400
@@ -13,6 +13,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/in6.h>
+#include <linux/key.h>
 #include <asm/system.h>
 #include "flask.h"
 #include "av_permissions.h"
@@ -43,6 +44,7 @@ struct avc_audit_data {
 #define AVC_AUDIT_DATA_NET  2
 #define AVC_AUDIT_DATA_CAP  3
 #define AVC_AUDIT_DATA_IPC  4
+#define AVC_AUDIT_DATA_RET_KEY  5
 	struct task_struct *tsk;
 	union 	{
 		struct {
@@ -69,6 +71,7 @@ struct avc_audit_data {
 		} net;
 		int cap;
 		int ipc_id;
+	        key_perm_t ret_key;
 	} u;
 };
 
diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/selinux/include/av_permissions.h linux-2.6.17-rc4-mm1/security/selinux/include/av_permissions.h
--- linux-2.6.16/security/selinux/include/av_permissions.h	2006-05-23 10:01:55.000000000 -0400
+++ linux-2.6.17-rc4-mm1/security/selinux/include/av_permissions.h	2006-05-23 13:09:24.000000000 -0400
@@ -956,3 +956,14 @@
 #define APPLETALK_SOCKET__SEND_MSG                0x00100000UL
 #define APPLETALK_SOCKET__NAME_BIND               0x00200000UL
 
+#define PACKET__SEND                              0x00000001UL
+#define PACKET__RECV                              0x00000002UL
+#define PACKET__RELABELTO                         0x00000004UL
+
+#define RETAINED_KEY__VIEW                        0x00000001UL
+#define RETAINED_KEY__READ                        0x00000002UL
+#define RETAINED_KEY__WRITE                       0x00000004UL
+#define RETAINED_KEY__SEARCH                      0x00000008UL
+#define RETAINED_KEY__LINK                        0x00000010UL
+#define RETAINED_KEY__SETATTR                     0x00000020UL
+
diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/selinux/include/av_perm_to_string.h linux-2.6.17-rc4-mm1/security/selinux/include/av_perm_to_string.h
--- linux-2.6.16/security/selinux/include/av_perm_to_string.h	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc4-mm1/security/selinux/include/av_perm_to_string.h	2006-05-23 13:09:26.000000000 -0400
@@ -239,3 +239,12 @@
    S_(SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, "sendto")
    S_(SECCLASS_ASSOCIATION, ASSOCIATION__RECVFROM, "recvfrom")
    S_(SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT, "setcontext")
+   S_(SECCLASS_PACKET, PACKET__SEND, "send")
+   S_(SECCLASS_PACKET, PACKET__RECV, "recv")
+   S_(SECCLASS_PACKET, PACKET__RELABELTO, "relabelto")
+   S_(SECCLASS_RETAINED_KEY, RETAINED_KEY__VIEW, "view")
+   S_(SECCLASS_RETAINED_KEY, RETAINED_KEY__READ, "read")
+   S_(SECCLASS_RETAINED_KEY, RETAINED_KEY__WRITE, "write")
+   S_(SECCLASS_RETAINED_KEY, RETAINED_KEY__SEARCH, "search")
+   S_(SECCLASS_RETAINED_KEY, RETAINED_KEY__LINK, "link")
+   S_(SECCLASS_RETAINED_KEY, RETAINED_KEY__SETATTR, "setattr")
diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/selinux/include/class_to_string.h linux-2.6.17-rc4-mm1/security/selinux/include/class_to_string.h
--- linux-2.6.16/security/selinux/include/class_to_string.h	2006-05-23 10:01:55.000000000 -0400
+++ linux-2.6.17-rc4-mm1/security/selinux/include/class_to_string.h	2006-05-23 13:09:27.000000000 -0400
@@ -59,3 +59,5 @@
     S_("association")
     S_("netlink_kobject_uevent_socket")
     S_("appletalk_socket")
+    S_("packet")
+    S_("retained_key")
diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/selinux/include/flask.h linux-2.6.17-rc4-mm1/security/selinux/include/flask.h
--- linux-2.6.16/security/selinux/include/flask.h	2006-05-23 10:01:55.000000000 -0400
+++ linux-2.6.17-rc4-mm1/security/selinux/include/flask.h	2006-05-23 13:09:30.000000000 -0400
@@ -61,6 +61,8 @@
 #define SECCLASS_ASSOCIATION                             54
 #define SECCLASS_NETLINK_KOBJECT_UEVENT_SOCKET           55
 #define SECCLASS_APPLETALK_SOCKET                        56
+#define SECCLASS_PACKET                                  57
+#define SECCLASS_RETAINED_KEY                            58
 
 /*
  * Security identifier indices for initial entities
diff -uprN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/security/selinux/include/objsec.h linux-2.6.17-rc4-mm1/security/selinux/include/objsec.h
--- linux-2.6.16/security/selinux/include/objsec.h	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc4-mm1/security/selinux/include/objsec.h	2006-05-19 09:20:11.000000000 -0400
@@ -99,6 +99,11 @@ struct sk_security_struct {
 	u32 peer_sid;			/* SID of peer */
 };
 
+struct key_security_struct {
+	struct key *obj; /* back pointer */
+	u32 sid;         /* SID of key */
+};
+
 extern unsigned int selinux_checkreqprot;
 
 #endif /* _SELINUX_OBJSEC_H_ */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
