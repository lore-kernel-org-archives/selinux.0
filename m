From: David Howells <dhowells@redhat.com>
In-Reply-To: <1150901165.3256.46.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1150901165.3256.46.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, dhowells@redhat.com, sds@tycho.nsa.gov,
        jmorris@namei.org
Subject: Re: [RFC][PATCH] selinux: add an unlink permission on keys 
Date: Wed, 21 Jun 2006 16:46:39 +0100
Message-ID: <29242.1150904799@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> @@ -932,7 +942,18 @@ int keyring_clear(struct key *keyring)
> -		if (klist) {
> +
> +		if (klist && klist->nkeys > 0) {

I'd rather you didn't do that.  The for-loop will just do nothing if nkeys is
zero.

> +			int loop;
> +
> +			for (loop = klist->nkeys - 1; loop >= 0; loop--) {
> +				/* check unlink permissions */
> +				ret = security_key_unlink(klist->keys[loop],
> +							  keyring, current);

I think clearing a keyring should filter out the unlinkable keys rather than
returning an error if one of them is unlinkable.

> @@ -246,6 +248,11 @@ static int install_session_keyring(struc
>  	/* install the keyring */
>  	spin_lock_irq(&tsk->sighand->siglock);
>  	old = tsk->signal->session_keyring;
> +	if (old) {
> +		ret = security_key_unlink(old, NULL, current);
> +		if (ret < 0)
> +			goto error2;
> +	}

I'm tempted to say that should be a separate security op since it's really a
different operation.

I've attached my take on your patch (I've just adjusted a few things, but no
substantial changes).

David


diff --git a/include/linux/security.h b/include/linux/security.h
index d4aa1bf..1913e29 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -868,6 +868,13 @@ #ifdef CONFIG_SECURITY
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
@@ -1319,6 +1326,9 @@ #ifdef CONFIG_KEYS
 	int (*key_permission)(key_ref_t key_ref,
 			      struct task_struct *context,
 			      key_perm_t perm);
+	int (*key_unlink)(struct key *key,
+			  struct key *keyring,
+			  struct task_struct *context);
 
 #endif	/* CONFIG_KEYS */
 
@@ -3028,6 +3038,13 @@ static inline int security_key_permissio
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
@@ -3048,6 +3065,13 @@ static inline int security_key_permissio
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
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index e8d02ac..cab3b9e 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -658,6 +658,47 @@ static void keyring_unlink_rcu_disposal(
 
 /*****************************************************************************/
 /*
+ * replace a link to a matched key in a keyring with a link to the new key
+ */
+static int __key_unlink_do_replace(struct key *keyring, struct key *key,
+				   struct keyring_list *klist, int index)
+{
+	struct keyring_list *nklist;
+	size_t size;
+	int ret;
+
+	/* check permissions */
+	ret = security_key_unlink(klist->keys[index], keyring, current);
+	if (ret < 0)
+		return ret;
+
+	/* replace with new key */
+	size = sizeof(struct key *) * klist->maxkeys;
+	size += sizeof(*klist);
+	BUG_ON(size > PAGE_SIZE);
+
+	nklist = kmalloc(size, GFP_KERNEL);
+	if (!nklist)
+		return -ENOMEM;
+
+	memcpy(nklist, klist, size);
+
+	/* replace matched key */
+	atomic_inc(&key->usage);
+	nklist->keys[index] = key;
+
+	rcu_assign_pointer(keyring->payload.subscriptions, nklist);
+
+	/* dispose of the old keyring list and the
+	 * displaced key */
+	klist->delkey = index;
+	call_rcu(&klist->rcu, keyring_unlink_rcu_disposal);
+	return 0;
+
+} /* end __key_unlink_do_replace() */
+
+/*****************************************************************************/
+/*
  * link a key into to a keyring
  * - must be called with the keyring's semaphore write-locked
  * - discard already extant link to matching key if there is one
@@ -700,33 +741,9 @@ int __key_link(struct key *keyring, stru
 			    strcmp(klist->keys[loop]->description,
 				   key->description) == 0
 			    ) {
-				/* found a match - replace with new key */
-				size = sizeof(struct key *) * klist->maxkeys;
-				size += sizeof(*klist);
-				BUG_ON(size > PAGE_SIZE);
-
-				ret = -ENOMEM;
-				nklist = kmalloc(size, GFP_KERNEL);
-				if (!nklist)
-					goto error2;
-
-				memcpy(nklist, klist, size);
-
-				/* replace matched key */
-				atomic_inc(&key->usage);
-				nklist->keys[loop] = key;
-
-				rcu_assign_pointer(
-					keyring->payload.subscriptions,
-					nklist);
-
-				/* dispose of the old keyring list and the
-				 * displaced key */
-				klist->delkey = loop;
-				call_rcu(&klist->rcu,
-					 keyring_unlink_rcu_disposal);
-
-				goto done;
+				ret = __key_unlink_do_replace(keyring, key,
+							      klist, loop);
+				goto out;
 			}
 		}
 	}
@@ -786,8 +803,8 @@ int __key_link(struct key *keyring, stru
 			call_rcu(&klist->rcu, keyring_link_rcu_disposal);
 	}
 
-done:
 	ret = 0;
+out:
 error2:
 	up_write(&keyring_serialise_link_sem);
 error:
@@ -795,8 +812,7 @@ error:
 
 error3:
 	/* undo the quota changes */
-	key_payload_reserve(keyring,
-			    keyring->datalen - KEYQUOTA_LINK_BYTES);
+	key_payload_reserve(keyring, keyring->datalen - KEYQUOTA_LINK_BYTES);
 	goto error2;
 
 } /* end __key_link() */
@@ -838,6 +854,10 @@ int key_unlink(struct key *keyring, stru
 	if (keyring->type != &key_type_keyring)
 		goto error;
 
+	ret = security_key_unlink(key, keyring, current);
+	if (ret < 0)
+		goto error;
+
 	down_write(&keyring->sem);
 
 	klist = keyring->payload.subscriptions;
@@ -932,7 +952,18 @@ int keyring_clear(struct key *keyring)
 		down_write(&keyring->sem);
 
 		klist = keyring->payload.subscriptions;
+
 		if (klist) {
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
@@ -950,7 +981,14 @@ int keyring_clear(struct key *keyring)
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
 
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index f5fbc37..3304fc8 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -19,6 +19,7 @@ #include <linux/err.h>
 #include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include "internal.h"
+#include <linux/security.h>
 
 /* session keyring create vs join semaphore */
 static DEFINE_MUTEX(key_session_mutex);
@@ -215,6 +216,7 @@ static int install_session_keyring(struc
 	unsigned long flags;
 	struct key *old;
 	char buf[20];
+	int ret;
 
 	might_sleep();
 
@@ -238,7 +240,13 @@ static int install_session_keyring(struc
 	/* install the keyring */
 	spin_lock_irq(&tsk->sighand->siglock);
 	old = tsk->signal->session_keyring;
-	rcu_assign_pointer(tsk->signal->session_keyring, keyring);
+	if (old) {
+		ret = security_key_unlink(old, NULL, current);
+		if (ret < 0)
+			goto security_error;
+
+		rcu_assign_pointer(tsk->signal->session_keyring, keyring);
+	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 
 	/* we're using RCU on the pointer, but there's no point synchronising
@@ -250,6 +258,11 @@ static int install_session_keyring(struc
 
 	return 0;
 
+security_error:
+	spin_unlock_irq(&tsk->sighand->siglock);
+	key_put(keyring);
+	return ret;
+
 } /* end install_session_keyring() */
 
 /*****************************************************************************/
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8c1e1d5..a1cc9f6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4325,6 +4325,20 @@ static int selinux_key_permission(key_re
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
@@ -4486,6 +4500,7 @@ #ifdef CONFIG_KEYS
 	.key_alloc =                    selinux_key_alloc,
 	.key_free =                     selinux_key_free,
 	.key_permission =               selinux_key_permission,
+	.key_unlink =                   selinux_key_unlink,
 #endif
 };
 
diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index e777578..d6ac8fe 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -250,3 +250,4 @@
    S_(SECCLASS_KEY, KEY__LINK, "link")
    S_(SECCLASS_KEY, KEY__SETATTR, "setattr")
    S_(SECCLASS_KEY, KEY__CREATE, "create")
+   S_(SECCLASS_KEY, KEY__UNLINK, "unlink")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index ba5ef05..173ba08 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -967,3 +967,4 @@ #define KEY__SEARCH                     
 #define KEY__LINK                                 0x00000010UL
 #define KEY__SETATTR                              0x00000020UL
 #define KEY__CREATE                               0x00000040UL
+#define KEY__UNLINK                               0x00000080UL

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
