Subject: [RFC][PATCH] selinux: add an unlink permission on keys
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, dhowells@redhat.com, sds@tycho.nsa.gov,
        jmorris@namei.org
Content-Type: text/plain
Date: Wed, 21 Jun 2006 10:46:05 -0400
Message-Id: <1150901165.3256.46.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David and the rest of the list,

This patch isn't targeted at 2.6.18, but I'd like to start discussing it.
This patch must be applied to a kernel that has been updated using
David's latest series of six patches, but I don't anticipate anyone
needing to do so at this point.

---<snip>---
From: Michael LeMay <mdlemay@epoch.ncsc.mil>

This patch adds an unlink permission on keys, which restricts explicit
as well as (most) implicit unlink operations.  It regulates the
implicit unlink operation that occurs when a key is linked into a
keyring that already contains a key with the same description.  It also
regulates the keyring_clear operation, causing the entire operation
to abort without changing the keyring if any of the keys is
non-unlinkable.  Finally, it checks the unlink permission on any existing
session keyring that is about to be unlinked in install_session_keyring.

The unlink permission is checked using a new LSM call that takes
three arguments: the key being unlinked, the parent keyring, and
the task context for the operation.  The parent keyring may be
NULL, and is currently not used by SELinux.  However, it could
conceivably be useful to future security modules.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

---

 include/linux/security.h                     |   24 ++++++++++++++++++++
 security/keys/keyring.c                      |   32 +++++++++++++++++++++++++--
 security/keys/process_keys.c                 |   18 ++++++++++++++-
 security/selinux/hooks.c                     |   15 ++++++++++++
 security/selinux/include/av_perm_to_string.h |    1
 security/selinux/include/av_permissions.h    |    1
 6 files changed, 88 insertions(+), 3 deletions(-)

diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.keycreate/include/linux/security.h linux-2.6.17-rc6-mm2.dh.unlink/include/linux/security.h
--- linux-2.6.17-rc6-mm2.dh.keycreate/include/linux/security.h	2006-06-16 08:53:18.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.unlink/include/linux/security.h	2006-06-21 10:17:12.000000000 -0400
@@ -873,6 +873,13 @@ struct swap_info_struct;
  *	@perm describes the combination of permissions required of this key.
  *	Return 1 if permission granted, 0 if permission denied and -ve it the
  *      normal permissions model should be effected.
+ * @key_unlink:
+ *	See whether a process is permitted to unlink a key.
+ *	@key points to the key.
+ *	@keyring points to the parent keyring, if any.
+ *	@context points to the process to provide the context against which to
+ *       evaluate the security data on the key.
+ *	Return 0 if permission is granted.
  *
  * Security hooks affecting all System V IPC operations.
  *
@@ -1325,6 +1332,9 @@ struct security_operations {
 	int (*key_permission)(key_ref_t key_ref,
 			      struct task_struct *context,
 			      key_perm_t perm);
+	int (*key_unlink)(struct key *key,
+			  struct key *keyring,
+			  struct task_struct *context);
 
 #endif	/* CONFIG_KEYS */
 
@@ -3044,6 +3054,13 @@ static inline int security_key_permissio
 	return security_ops->key_permission(key_ref, context, perm);
 }
 
+static inline int security_key_unlink(struct key *key,
+				      struct key *keyring,
+				      struct task_struct *context)
+{
+	return security_ops->key_unlink(key, keyring, context);
+}
+
 #else
 
 static inline int security_key_alloc(struct key *key,
@@ -3064,6 +3081,13 @@ static inline int security_key_permissio
 	return 0;
 }
 
+static inline int security_key_unlink(struct key *key,
+				      struct key *keyring,
+				      struct task_struct *context)
+{
+	return 0;
+}
+
 #endif
 #endif /* CONFIG_KEYS */
 
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.keycreate/security/keys/keyring.c linux-2.6.17-rc6-mm2.dh.unlink/security/keys/keyring.c
--- linux-2.6.17-rc6-mm2.dh.keycreate/security/keys/keyring.c	2006-06-16 08:53:23.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.unlink/security/keys/keyring.c	2006-06-21 10:17:12.000000000 -0400
@@ -700,7 +700,13 @@ int __key_link(struct key *keyring, stru
 			    strcmp(klist->keys[loop]->description,
 				   key->description) == 0
 			    ) {
-				/* found a match - replace with new key */
+				/* found a match - check permissions */
+				ret = security_key_unlink(klist->keys[loop],
+							  keyring, current);
+				if (ret < 0)
+					goto error2;
+
+				/* replace with new key */
 				size = sizeof(struct key *) * klist->maxkeys;
 				size += sizeof(*klist);
 				BUG_ON(size > PAGE_SIZE);
@@ -838,6 +844,10 @@ int key_unlink(struct key *keyring, stru
 	if (keyring->type != &key_type_keyring)
 		goto error;
 
+	ret = security_key_unlink(key, keyring, current);
+	if (ret < 0)
+		goto error;
+
 	down_write(&keyring->sem);
 
 	klist = keyring->payload.subscriptions;
@@ -932,7 +942,18 @@ int keyring_clear(struct key *keyring)
 		down_write(&keyring->sem);
 
 		klist = keyring->payload.subscriptions;
-		if (klist) {
+
+		if (klist && klist->nkeys > 0) {
+			int loop;
+
+			for (loop = klist->nkeys - 1; loop >= 0; loop--) {
+				/* check unlink permissions */
+				ret = security_key_unlink(klist->keys[loop],
+							  keyring, current);
+				if (ret < 0)
+					goto error;
+			}
+			
 			/* adjust the quota */
 			key_payload_reserve(keyring,
 					    sizeof(struct keyring_list));
@@ -950,7 +971,14 @@ int keyring_clear(struct key *keyring)
 		ret = 0;
 	}
 
+
+done:
 	return ret;
+	
+error:
+	up_write(&keyring->sem);
+
+	goto done;
 
 } /* end keyring_clear() */
 
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.keycreate/security/keys/process_keys.c linux-2.6.17-rc6-mm2.dh.unlink/security/keys/process_keys.c
--- linux-2.6.17-rc6-mm2.dh.keycreate/security/keys/process_keys.c	2006-06-16 09:26:11.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.unlink/security/keys/process_keys.c	2006-06-21 10:17:12.000000000 -0400
@@ -19,6 +19,7 @@
 #include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include "internal.h"
+#include <linux/security.h>
 
 /* session keyring create vs join semaphore */
 static DEFINE_MUTEX(key_session_mutex);
@@ -223,6 +224,7 @@ static int install_session_keyring(struc
 	unsigned long flags;
 	struct key *old;
 	char buf[20];
+	int ret;
 
 	might_sleep();
 
@@ -246,6 +248,11 @@ static int install_session_keyring(struc
 	/* install the keyring */
 	spin_lock_irq(&tsk->sighand->siglock);
 	old = tsk->signal->session_keyring;
+	if (old) {
+		ret = security_key_unlink(old, NULL, current);
+		if (ret < 0)
+			goto error2;
+	}
 	rcu_assign_pointer(tsk->signal->session_keyring, keyring);
 	spin_unlock_irq(&tsk->sighand->siglock);
 
@@ -256,7 +263,16 @@ static int install_session_keyring(struc
 		key_put(old);
 	}
 
-	return 0;
+	ret = 0;
+
+error:
+	return ret;
+
+error2:
+	spin_unlock_irq(&tsk->sighand->siglock);
+	key_put(keyring);
+
+	goto error;
 
 } /* end install_session_keyring() */
 
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/hooks.c linux-2.6.17-rc6-mm2.dh.unlink/security/selinux/hooks.c
--- linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/hooks.c	2006-06-16 10:38:14.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.unlink/security/selinux/hooks.c	2006-06-21 10:17:12.000000000 -0400
@@ -4330,6 +4330,20 @@ static int selinux_key_permission(key_re
 			    SECCLASS_KEY, perm, NULL);
 }
 
+static int selinux_key_unlink(struct key *key,
+			      struct key *keyring,
+			      struct task_struct *ctx)
+{
+	struct task_security_struct *tsec;
+	struct key_security_struct *ksec;
+
+	tsec = ctx->security;
+	ksec = key->security;
+
+	return avc_has_perm(tsec->sid, ksec->sid,
+			    SECCLASS_KEY, KEY__UNLINK, NULL);
+}
+
 #endif
 
 static struct security_operations selinux_ops = {
@@ -4492,6 +4506,7 @@ static struct security_operations selinu
 	.key_alloc =                    selinux_key_alloc,
 	.key_free =                     selinux_key_free,
 	.key_permission =               selinux_key_permission,
+	.key_unlink =                   selinux_key_unlink,
 #endif
 };
 
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/include/av_permissions.h linux-2.6.17-rc6-mm2.dh.unlink/security/selinux/include/av_permissions.h
--- linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/include/av_permissions.h	2006-06-16 08:55:48.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.unlink/security/selinux/include/av_permissions.h	2006-06-21 10:17:12.000000000 -0400
@@ -968,4 +968,5 @@
 #define KEY__LINK                                 0x00000010UL
 #define KEY__SETATTR                              0x00000020UL
 #define KEY__CREATE                               0x00000040UL
+#define KEY__UNLINK                               0x00000080UL
 
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/include/av_perm_to_string.h linux-2.6.17-rc6-mm2.dh.unlink/security/selinux/include/av_perm_to_string.h
--- linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/include/av_perm_to_string.h	2006-06-16 08:54:40.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.unlink/security/selinux/include/av_perm_to_string.h	2006-06-21 10:17:12.000000000 -0400
@@ -250,3 +250,4 @@
    S_(SECCLASS_KEY, KEY__LINK, "link")
    S_(SECCLASS_KEY, KEY__SETATTR, "setattr")
    S_(SECCLASS_KEY, KEY__CREATE, "create")
+   S_(SECCLASS_KEY, KEY__UNLINK, "unlink")



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
