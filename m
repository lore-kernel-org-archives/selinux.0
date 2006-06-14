Subject: [PATCH] selinux: add /proc/pid/attr/keycreate
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, dhowells@redhat.com, sds@tycho.nsa.gov,
        jmorris@redhat.com
Content-Type: text/plain
Date: Wed, 14 Jun 2006 12:40:29 -0400
Message-Id: <1150303229.3408.10.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This update resolves another issue: the unconditional call to "may_create_key"
within security_key_alloc may cause breakage in the kernel, since alloc_uid and the
SELinux initialization routines both invoke security_key_alloc.  We don't want
SELinux to ever block the creation of a key at those points.

---<snip>---
From: Michael LeMay <mdlemay@epoch.ncsc.mil>

Add a /proc/<pid>/attr/keycreate entry that stores the appropriate
context for newly-created keys.  Modify the selinux_key_alloc
hook to make use of the new entry.  Update the flask headers to
include a new "setkeycreate" permission for processes.  Update the
flask headers to include a new "create" permission for keys.  Use
the create permission to restrict which SIDs each task can assign
to newly-created keys.  Add a new parameter to the security hook
"security_key_alloc" to indicate whether it is being invoked by
the kernel, or from userspace.  If it is being invoked by the
kernel, the security hook should never fail.  Update the
documentation to reflect these changes.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

---

 Documentation/keys.txt                       |   29 ++++++++++++--------
 fs/proc/base.c                               |    6 ++++
 include/linux/key.h                          |    3 +-
 include/linux/security.h                     |    9 +++---
 security/dummy.c                             |    2 -
 security/keys/key.c                          |    6 ++--
 security/keys/keyring.c                      |    4 +-
 security/keys/process_keys.c                 |   12 ++++----
 security/keys/request_key.c                  |    4 +-
 security/keys/request_key_auth.c             |    2 -
 security/selinux/hooks.c                     |   38 +++++++++++++++++++++++----
 security/selinux/include/av_perm_to_string.h |    2 +
 security/selinux/include/av_permissions.h    |    2 +
 security/selinux/include/objsec.h            |    1
 14 files changed, 83 insertions(+), 37 deletions(-)

diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/Documentation/keys.txt linux-2.6.17-rc6-mm2.keycreate/Documentation/keys.txt
--- linux-2.6.17-rc6-mm2.orig/Documentation/keys.txt	2006-06-13 09:14:59.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/Documentation/keys.txt	2006-06-14 10:21:34.000000000 -0400
@@ -241,25 +241,30 @@ The security class "key" has been added 
 controls can be applied to keys created within various contexts.  This support
 is preliminary, and is likely to change quite significantly in the near future.
 Currently, all of the basic permissions explained above are provided in SELinux
-as well; SE Linux is simply invoked after all basic permission checks have been
+as well; SELinux is simply invoked after all basic permission checks have been
 performed.
 
-Each key is labeled with the same context as the task to which it belongs.
-Typically, this is the same task that was running when the key was created.
-The default keyrings are handled differently, but in a way that is very
-intuitive:
-
- (*) The user and user session keyrings that are created when the user logs in
-     are currently labeled with the context of the login manager.
-
- (*) The keyrings associated with new threads are each labeled with the context
-     of their associated thread, and both session and process keyrings are
-     handled similarly.
+The value of the file /proc/self/attr/keycreate influences the labeling of
+newly-created keys.  If the contents of that file correspond to an SELinux
+security context, then the key will be assigned that context.  Otherwise, the
+key will be assigned the current context of the task that invoked the key
+creation request.  Tasks must be granted explicit permission to assign a
+particular context to newly-created keys, using the "create" permission in the
+key security class.
+
+The default keyrings associated with users will be labeled with the default
+context of the user if and only if the login programs have been instrumented to
+properly initialize keycreate during the login process.  Otherwise, they will
+be labeled with the context of the login program itself.
 
 Note, however, that the default keyrings associated with the root user are
 labeled with the default kernel context, since they are created early in the
 boot process, before root has a chance to log in.
 
+The keyrings associated with new threads are each labeled with the context of
+their associated thread, and both session and process keyrings are handled
+similarly.
+
 
 ================
 NEW PROCFS FILES
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/fs/proc/base.c linux-2.6.17-rc6-mm2.keycreate/fs/proc/base.c
--- linux-2.6.17-rc6-mm2.orig/fs/proc/base.c	2006-06-13 09:15:01.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/fs/proc/base.c	2006-06-14 10:21:34.000000000 -0400
@@ -132,6 +132,7 @@ enum pid_directory_inos {
 	PROC_TGID_ATTR_PREV,
 	PROC_TGID_ATTR_EXEC,
 	PROC_TGID_ATTR_FSCREATE,
+	PROC_TGID_ATTR_KEYCREATE,
 #endif
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TGID_LOGINUID,
@@ -173,6 +174,7 @@ enum pid_directory_inos {
 	PROC_TID_ATTR_PREV,
 	PROC_TID_ATTR_EXEC,
 	PROC_TID_ATTR_FSCREATE,
+	PROC_TID_ATTR_KEYCREATE,
 #endif
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TID_LOGINUID,
@@ -289,6 +291,7 @@ static struct pid_entry tgid_attr_stuff[
 	E(PROC_TGID_ATTR_PREV,     "prev",     S_IFREG|S_IRUGO),
 	E(PROC_TGID_ATTR_EXEC,     "exec",     S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_attr_stuff[] = {
@@ -296,6 +299,7 @@ static struct pid_entry tid_attr_stuff[]
 	E(PROC_TID_ATTR_PREV,      "prev",     S_IFREG|S_IRUGO),
 	E(PROC_TID_ATTR_EXEC,      "exec",     S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
 	{0,0,NULL,0}
 };
 #endif
@@ -1759,6 +1763,8 @@ static struct dentry *proc_pident_lookup
 		case PROC_TGID_ATTR_EXEC:
 		case PROC_TID_ATTR_FSCREATE:
 		case PROC_TGID_ATTR_FSCREATE:
+		case PROC_TID_ATTR_KEYCREATE:
+		case PROC_TGID_ATTR_KEYCREATE:
 			inode->i_fop = &proc_pid_attr_operations;
 			break;
 #endif
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/include/linux/key.h linux-2.6.17-rc6-mm2.keycreate/include/linux/key.h
--- linux-2.6.17-rc6-mm2.orig/include/linux/key.h	2006-06-13 09:15:02.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/include/linux/key.h	2006-06-14 10:35:17.000000000 -0400
@@ -248,7 +248,8 @@ extern struct key *key_alloc(struct key_
 			     const char *desc,
 			     uid_t uid, gid_t gid,
 			     struct task_struct *ctx,
-			     key_perm_t perm, int not_in_quota);
+			     key_perm_t perm, int not_in_quota,
+			     int krn);
 extern int key_payload_reserve(struct key *key, size_t datalen);
 extern int key_instantiate_and_link(struct key *key,
 				    const void *data,
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/include/linux/security.h linux-2.6.17-rc6-mm2.keycreate/include/linux/security.h
--- linux-2.6.17-rc6-mm2.orig/include/linux/security.h	2006-06-13 09:15:02.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/include/linux/security.h	2006-06-14 10:26:30.000000000 -0400
@@ -858,6 +858,7 @@ struct swap_info_struct;
  *	Permit allocation of a key and assign security data. Note that key does
  *	not have a serial number assigned at this point.
  *	@key points to the key.
+ *	@krn indicates whether the key was requested by the kernel or a syscall.
  *	Return 0 if permission is granted, -ve error otherwise.
  * @key_free:
  *	Notification of destruction; free security data.
@@ -1319,7 +1320,7 @@ struct security_operations {
 
 	/* key management security hooks */
 #ifdef CONFIG_KEYS
-	int (*key_alloc)(struct key *key, struct task_struct *tsk);
+	int (*key_alloc)(struct key *key, struct task_struct *tsk, int krn);
 	void (*key_free)(struct key *key);
 	int (*key_permission)(key_ref_t key_ref,
 			      struct task_struct *context,
@@ -3025,9 +3026,9 @@ static inline int security_xfrm_policy_l
 #ifdef CONFIG_KEYS
 #ifdef CONFIG_SECURITY
 static inline int security_key_alloc(struct key *key,
-				     struct task_struct *tsk)
+				     struct task_struct *tsk, int krn)
 {
-	return security_ops->key_alloc(key, tsk);
+	return security_ops->key_alloc(key, tsk, krn);
 }
 
 static inline void security_key_free(struct key *key)
@@ -3045,7 +3046,7 @@ static inline int security_key_permissio
 #else
 
 static inline int security_key_alloc(struct key *key,
-				     struct task_struct *tsk)
+				     struct task_struct *tsk, int krn)
 {
 	return 0;
 }
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/dummy.c linux-2.6.17-rc6-mm2.keycreate/security/dummy.c
--- linux-2.6.17-rc6-mm2.orig/security/dummy.c	2006-06-13 09:15:03.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/security/dummy.c	2006-06-14 10:27:15.000000000 -0400
@@ -865,7 +865,7 @@ static int dummy_setprocattr(struct task
 }
 
 #ifdef CONFIG_KEYS
-static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx)
+static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx, int krn)
 {
 	return 0;
 }
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/keys/key.c linux-2.6.17-rc6-mm2.keycreate/security/keys/key.c
--- linux-2.6.17-rc6-mm2.orig/security/keys/key.c	2006-06-13 09:15:03.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/security/keys/key.c	2006-06-14 10:47:59.000000000 -0400
@@ -249,7 +249,7 @@ static inline void key_alloc_serial(stru
  */
 struct key *key_alloc(struct key_type *type, const char *desc,
 		      uid_t uid, gid_t gid, struct task_struct *ctx,
-		      key_perm_t perm, int not_in_quota)
+		      key_perm_t perm, int not_in_quota, int krn)
 {
 	struct key_user *user = NULL;
 	struct key *key;
@@ -319,7 +319,7 @@ struct key *key_alloc(struct key_type *t
 #endif
 
 	/* let the security module know about the key */
-	ret = security_key_alloc(key, ctx);
+	ret = security_key_alloc(key, ctx, krn);
 	if (ret < 0)
 		goto security_error;
 
@@ -823,7 +823,7 @@ key_ref_t key_create_or_update(key_ref_t
 
 	/* allocate a new key */
 	key = key_alloc(ktype, description, current->fsuid, current->fsgid,
-			current, perm, not_in_quota);
+			current, perm, not_in_quota, 0);
 	if (IS_ERR(key)) {
 		key_ref = ERR_PTR(PTR_ERR(key));
 		goto error_3;
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/keys/keyring.c linux-2.6.17-rc6-mm2.keycreate/security/keys/keyring.c
--- linux-2.6.17-rc6-mm2.orig/security/keys/keyring.c	2006-06-13 09:15:03.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/security/keys/keyring.c	2006-06-14 10:28:36.000000000 -0400
@@ -241,7 +241,7 @@ static long keyring_read(const struct ke
  */
 struct key *keyring_alloc(const char *description, uid_t uid, gid_t gid,
 			  struct task_struct *ctx, int not_in_quota,
-			  struct key *dest)
+			  struct key *dest, int krn)
 {
 	struct key *keyring;
 	int ret;
@@ -249,7 +249,7 @@ struct key *keyring_alloc(const char *de
 	keyring = key_alloc(&key_type_keyring, description,
 			    uid, gid, ctx,
 			    (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_ALL,
-			    not_in_quota);
+			    not_in_quota, krn);
 
 	if (!IS_ERR(keyring)) {
 		ret = key_instantiate_and_link(keyring, NULL, 0, dest, NULL);
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/keys/process_keys.c linux-2.6.17-rc6-mm2.keycreate/security/keys/process_keys.c
--- linux-2.6.17-rc6-mm2.orig/security/keys/process_keys.c	2006-06-13 09:15:03.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/security/keys/process_keys.c	2006-06-14 10:52:28.000000000 -0400
@@ -77,7 +77,7 @@ int alloc_uid_keyring(struct user_struct
 	/* concoct a default session keyring */
 	sprintf(buf, "_uid_ses.%u", user->uid);
 
-	session_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, ctx, 0, NULL);
+	session_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, ctx, 0, NULL, 1);
 	if (IS_ERR(session_keyring)) {
 		ret = PTR_ERR(session_keyring);
 		goto error;
@@ -88,7 +88,7 @@ int alloc_uid_keyring(struct user_struct
 	sprintf(buf, "_uid.%u", user->uid);
 
 	uid_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, ctx, 0,
-				    session_keyring);
+				    session_keyring, 1);
 	if (IS_ERR(uid_keyring)) {
 		key_put(session_keyring);
 		ret = PTR_ERR(uid_keyring);
@@ -144,7 +144,7 @@ int install_thread_keyring(struct task_s
 
 	sprintf(buf, "_tid.%u", tsk->pid);
 
-	keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk, 1, NULL);
+	keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk, 1, NULL, 0);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error;
@@ -178,7 +178,7 @@ int install_process_keyring(struct task_
 	if (!tsk->signal->process_keyring) {
 		sprintf(buf, "_pid.%u", tsk->tgid);
 
-		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk, 1, NULL);
+		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk, 1, NULL, 0);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error;
@@ -218,7 +218,7 @@ static int install_session_keyring(struc
 	if (!keyring) {
 		sprintf(buf, "_ses.%u", tsk->tgid);
 
-		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk, 1, NULL);
+		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk, 1, NULL, 0);
 		if (IS_ERR(keyring))
 			return PTR_ERR(keyring);
 	}
@@ -728,7 +728,7 @@ long join_session_keyring(const char *na
 	keyring = find_keyring_by_name(name, 0);
 	if (PTR_ERR(keyring) == -ENOKEY) {
 		/* not found - try and create a new one */
-		keyring = keyring_alloc(name, tsk->uid, tsk->gid, tsk, 0, NULL);
+		keyring = keyring_alloc(name, tsk->uid, tsk->gid, tsk, 0, NULL, 0);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error2;
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/keys/request_key_auth.c linux-2.6.17-rc6-mm2.keycreate/security/keys/request_key_auth.c
--- linux-2.6.17-rc6-mm2.orig/security/keys/request_key_auth.c	2006-06-13 09:15:03.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/security/keys/request_key_auth.c	2006-06-14 10:31:46.000000000 -0400
@@ -187,7 +187,7 @@ struct key *request_key_auth_new(struct 
 	authkey = key_alloc(&key_type_request_key_auth, desc,
 			    current->fsuid, current->fsgid, current,
 			    KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH |
-			    KEY_USR_VIEW, 1);
+			    KEY_USR_VIEW, 1, 0);
 	if (IS_ERR(authkey)) {
 		ret = PTR_ERR(authkey);
 		goto error_alloc;
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/keys/request_key.c linux-2.6.17-rc6-mm2.keycreate/security/keys/request_key.c
--- linux-2.6.17-rc6-mm2.orig/security/keys/request_key.c	2006-06-13 09:15:03.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/security/keys/request_key.c	2006-06-14 10:53:13.000000000 -0400
@@ -49,7 +49,7 @@ static int call_sbin_request_key(struct 
 	sprintf(desc, "_req.%u", key->serial);
 
 	keyring = keyring_alloc(desc, current->fsuid, current->fsgid,
-				current, 1, NULL);
+				current, 1, NULL, 0);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error_alloc;
@@ -139,7 +139,7 @@ static struct key *__request_key_constru
 	/* create a key and add it to the queue */
 	key = key_alloc(type, description,
 			current->fsuid, current->fsgid,
-			current, KEY_POS_ALL, 0);
+			current, KEY_POS_ALL, 0, 0);
 	if (IS_ERR(key))
 		goto alloc_failed;
 
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/selinux/hooks.c linux-2.6.17-rc6-mm2.keycreate/security/selinux/hooks.c
--- linux-2.6.17-rc6-mm2.orig/security/selinux/hooks.c	2006-06-13 09:15:03.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/security/selinux/hooks.c	2006-06-14 10:32:50.000000000 -0400
@@ -1099,6 +1099,19 @@ static int may_create(struct inode *dir,
 			    FILESYSTEM__ASSOCIATE, &ad);
 }
 
+/* Check whether a task can create a key. */
+static int may_create_key(struct key *k,
+			  struct task_struct *ctx)
+{
+	struct task_security_struct *tsec;
+	struct key_security_struct *ksec;
+
+	tsec = ctx->security;
+	ksec = k->security;
+
+	return avc_has_perm(tsec->sid, ksec->sid, SECCLASS_KEY, KEY__CREATE, NULL);
+}
+
 #define MAY_LINK   0
 #define MAY_UNLINK 1
 #define MAY_RMDIR  2
@@ -4145,6 +4158,8 @@ static int selinux_getprocattr(struct ta
 		sid = tsec->exec_sid;
 	else if (!strcmp(name, "fscreate"))
 		sid = tsec->create_sid;
+	else if (!strcmp(name, "keycreate"))
+		sid = tsec->keycreate_sid;
 	else
 		return -EINVAL;
 
@@ -4177,6 +4192,8 @@ static int selinux_setprocattr(struct ta
 		error = task_has_perm(current, p, PROCESS__SETEXEC);
 	else if (!strcmp(name, "fscreate"))
 		error = task_has_perm(current, p, PROCESS__SETFSCREATE);
+	else if (!strcmp(name, "keycreate"))
+		error = task_has_perm(current, p, PROCESS__SETKEYCREATE);
 	else if (!strcmp(name, "current"))
 		error = task_has_perm(current, p, PROCESS__SETCURRENT);
 	else
@@ -4206,6 +4223,8 @@ static int selinux_setprocattr(struct ta
 		tsec->exec_sid = sid;
 	else if (!strcmp(name, "fscreate"))
 		tsec->create_sid = sid;
+	else if (!strcmp(name, "keycreate"))
+		tsec->keycreate_sid = sid;
 	else if (!strcmp(name, "current")) {
 		struct av_decision avd;
 
@@ -4259,7 +4278,8 @@ static int selinux_setprocattr(struct ta
 
 #ifdef CONFIG_KEYS
 
-static int selinux_key_alloc(struct key *k, struct task_struct *tsk)
+static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
+			     int krn)
 {
 	struct task_security_struct *tsec = tsk->security;
 	struct key_security_struct *ksec;
@@ -4269,10 +4289,18 @@ static int selinux_key_alloc(struct key 
 		return -ENOMEM;
 
 	ksec->obj = k;
-	ksec->sid = tsec->sid;
+	if (tsec->keycreate_sid)
+		ksec->sid = tsec->keycreate_sid;
+	else
+		ksec->sid = tsec->sid;
 	k->security = ksec;
 
-	return 0;
+	/* if we are allocating a key at the kernel's behest,
+	   make sure we don't fail */
+	if (krn)
+		return 0;
+
+	return may_create_key(k, tsk);
 }
 
 static void selinux_key_free(struct key *k)
@@ -4507,8 +4535,8 @@ static __init int selinux_init(void)
 
 #ifdef CONFIG_KEYS
 	/* Add security information to initial keyrings */
-	security_key_alloc(&root_user_keyring, current);
-	security_key_alloc(&root_session_keyring, current);
+	selinux_key_alloc(&root_user_keyring, current, 1);
+	selinux_key_alloc(&root_session_keyring, current, 1);
 #endif
 
 	return 0;
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/selinux/include/av_permissions.h linux-2.6.17-rc6-mm2.keycreate/security/selinux/include/av_permissions.h
--- linux-2.6.17-rc6-mm2.orig/security/selinux/include/av_permissions.h	2006-06-13 09:15:03.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/security/selinux/include/av_permissions.h	2006-06-14 10:21:34.000000000 -0400
@@ -467,6 +467,7 @@
 #define PROCESS__EXECMEM                          0x02000000UL
 #define PROCESS__EXECSTACK                        0x04000000UL
 #define PROCESS__EXECHEAP                         0x08000000UL
+#define PROCESS__SETKEYCREATE                     0x10000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
@@ -966,4 +967,5 @@
 #define KEY__SEARCH                               0x00000008UL
 #define KEY__LINK                                 0x00000010UL
 #define KEY__SETATTR                              0x00000020UL
+#define KEY__CREATE                               0x00000040UL
 
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/selinux/include/av_perm_to_string.h linux-2.6.17-rc6-mm2.keycreate/security/selinux/include/av_perm_to_string.h
--- linux-2.6.17-rc6-mm2.orig/security/selinux/include/av_perm_to_string.h	2006-06-13 09:15:03.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/security/selinux/include/av_perm_to_string.h	2006-06-14 10:21:34.000000000 -0400
@@ -72,6 +72,7 @@
    S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
    S_(SECCLASS_PROCESS, PROCESS__EXECSTACK, "execstack")
    S_(SECCLASS_PROCESS, PROCESS__EXECHEAP, "execheap")
+   S_(SECCLASS_PROCESS, PROCESS__SETKEYCREATE, "setkeycreate")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
@@ -248,3 +249,4 @@
    S_(SECCLASS_KEY, KEY__SEARCH, "search")
    S_(SECCLASS_KEY, KEY__LINK, "link")
    S_(SECCLASS_KEY, KEY__SETATTR, "setattr")
+   S_(SECCLASS_KEY, KEY__CREATE, "create")
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/selinux/include/objsec.h linux-2.6.17-rc6-mm2.keycreate/security/selinux/include/objsec.h
--- linux-2.6.17-rc6-mm2.orig/security/selinux/include/objsec.h	2006-06-13 09:15:03.000000000 -0400
+++ linux-2.6.17-rc6-mm2.keycreate/security/selinux/include/objsec.h	2006-06-14 10:21:34.000000000 -0400
@@ -32,6 +32,7 @@ struct task_security_struct {
 	u32 sid;             /* current SID */
 	u32 exec_sid;        /* exec SID */
 	u32 create_sid;      /* fscreate SID */
+	u32 keycreate_sid;   /* keycreate SID */
 	u32 ptrace_sid;      /* SID of ptrace parent */
 };
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
