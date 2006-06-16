From: David Howells <dhowells@redhat.com>
Subject: [PATCH [try #2] 6/6] Keys: Add a way to store the appropriate context for newly-created keys
Date: Fri, 16 Jun 2006 13:57:08 +0100
To: mdlemay@epoch.ncsc.mil, sds@tycho.nsa.gov, jmorris@redhat.com
Cc: selinux@tycho.nsa.gov, dhowells@redhat.com
Message-Id: <20060616125708.26378.77399.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060616125654.26378.36519.stgit@warthog.cambridge.redhat.com>
References: <20060616125654.26378.36519.stgit@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/keys.txt                       |   27 +++++++++++-------
 fs/proc/base.c                               |    6 ++++
 include/linux/key.h                          |    8 +++--
 security/keys/internal.h                     |    3 +-
 security/keys/keyctl.c                       |    9 ++++--
 security/keys/process_keys.c                 |   34 +++++++++++++++--------
 security/keys/request_key.c                  |   23 ++++++++++-----
 security/selinux/hooks.c                     |   39 ++++++++++++++++++++++----
 security/selinux/include/av_perm_to_string.h |    2 +
 security/selinux/include/av_permissions.h    |    2 +
 security/selinux/include/objsec.h            |    1 +
 11 files changed, 110 insertions(+), 44 deletions(-)

diff --git a/Documentation/keys.txt b/Documentation/keys.txt
index 70e83cf..61c0fad 100644
--- a/Documentation/keys.txt
+++ b/Documentation/keys.txt
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
+The value of the file /proc/self/attr/keycreate influences the labeling of
+newly-created keys.  If the contents of that file correspond to an SELinux
+security context, then the key will be assigned that context.  Otherwise, the
+key will be assigned the current context of the task that invoked the key
+creation request.  Tasks must be granted explicit permission to assign a
+particular context to newly-created keys, using the "create" permission in the
+key security class.
 
- (*) The user and user session keyrings that are created when the user logs in
-     are currently labeled with the context of the login manager.
-
- (*) The keyrings associated with new threads are each labeled with the context
-     of their associated thread, and both session and process keyrings are
-     handled similarly.
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
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6cc77dc..5334e07 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -121,6 +121,7 @@ #ifdef CONFIG_SECURITY
 	PROC_TGID_ATTR_PREV,
 	PROC_TGID_ATTR_EXEC,
 	PROC_TGID_ATTR_FSCREATE,
+	PROC_TGID_ATTR_KEYCREATE,
 #endif
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TGID_LOGINUID,
@@ -162,6 +163,7 @@ #ifdef CONFIG_SECURITY
 	PROC_TID_ATTR_PREV,
 	PROC_TID_ATTR_EXEC,
 	PROC_TID_ATTR_FSCREATE,
+	PROC_TID_ATTR_KEYCREATE,
 #endif
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TID_LOGINUID,
@@ -275,6 +277,7 @@ static struct pid_entry tgid_attr_stuff[
 	E(PROC_TGID_ATTR_PREV,     "prev",     S_IFREG|S_IRUGO),
 	E(PROC_TGID_ATTR_EXEC,     "exec",     S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_attr_stuff[] = {
@@ -282,6 +285,7 @@ static struct pid_entry tid_attr_stuff[]
 	E(PROC_TID_ATTR_PREV,      "prev",     S_IFREG|S_IRUGO),
 	E(PROC_TID_ATTR_EXEC,      "exec",     S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
 	{0,0,NULL,0}
 };
 #endif
@@ -1800,6 +1804,8 @@ #ifdef CONFIG_SECURITY
 		case PROC_TGID_ATTR_EXEC:
 		case PROC_TID_ATTR_FSCREATE:
 		case PROC_TGID_ATTR_FSCREATE:
+		case PROC_TID_ATTR_KEYCREATE:
+		case PROC_TGID_ATTR_KEYCREATE:
 			inode->i_fop = &proc_pid_attr_operations;
 			break;
 #endif
diff --git a/include/linux/key.h b/include/linux/key.h
index e693e72..3fbe27a 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -252,9 +252,11 @@ extern struct key *key_alloc(struct key_
 			     unsigned long flags);
 
 
-#define KEY_ALLOC_IN_QUOTA	0x0000	/* add to quota, reject if would overrun */
-#define KEY_ALLOC_QUOTA_OVERRUN	0x0001	/* add to quota, permit even if overrun */
-#define KEY_ALLOC_NOT_IN_QUOTA	0x0002	/* not in quota */
+#define KEY_ALLOC_IN_QUOTA		0x0000	/* add to quota, reject if would overrun */
+#define KEY_ALLOC_QUOTA_OVERRUN		0x0001	/* add to quota, permit even if overrun */
+#define KEY_ALLOC_NOT_IN_QUOTA		0x0002	/* not in quota */
+#define KEY_ALLOC_KERNEL_REQUEST	0x0000	/* key requested by kernel */
+#define KEY_ALLOC_USER_REQUEST		0x0004	/* key requested directly by user */
 
 extern int key_payload_reserve(struct key *key, size_t datalen);
 extern int key_instantiate_and_link(struct key *key,
diff --git a/security/keys/internal.h b/security/keys/internal.h
index e066e60..3c2877f 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -99,7 +99,8 @@ extern int install_process_keyring(struc
 extern struct key *request_key_and_link(struct key_type *type,
 					const char *description,
 					const char *callout_info,
-					struct key *dest_keyring);
+					struct key *dest_keyring,
+					unsigned long flags);
 
 /*
  * request_key authorisation
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 7c9a6b0..a324a3e 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -101,8 +101,9 @@ asmlinkage long sys_add_key(const char _
 
 	/* create or update the requested key and add it to the target
 	 * keyring */
-	key_ref = key_create_or_update(keyring_ref, type, description,
-				       payload, plen, 0);
+	key_ref = key_create_or_update(
+		keyring_ref, type, description, payload, plen,
+		KEY_ALLOC_IN_QUOTA | KEY_ALLOC_USER_REQUEST);
 	if (!IS_ERR(key_ref)) {
 		ret = key_ref_to_ptr(key_ref)->serial;
 		key_ref_put(key_ref);
@@ -184,7 +185,9 @@ asmlinkage long sys_request_key(const ch
 
 	/* do the search */
 	key = request_key_and_link(ktype, description, callout_info,
-				   key_ref_to_ptr(dest_ref));
+				   key_ref_to_ptr(dest_ref),
+				   KEY_ALLOC_IN_QUOTA |
+				   KEY_ALLOC_KERNEL_REQUEST);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto error5;
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index f5fbc37..cb8f057 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -77,8 +77,10 @@ int alloc_uid_keyring(struct user_struct
 	/* concoct a default session keyring */
 	sprintf(buf, "_uid_ses.%u", user->uid);
 
-	session_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, ctx,
-					KEY_ALLOC_IN_QUOTA, NULL);
+	session_keyring = keyring_alloc(
+		buf, user->uid, (gid_t) -1, ctx,
+		KEY_ALLOC_IN_QUOTA | KEY_ALLOC_KERNEL_REQUEST,
+		NULL);
 	if (IS_ERR(session_keyring)) {
 		ret = PTR_ERR(session_keyring);
 		goto error;
@@ -88,8 +90,10 @@ int alloc_uid_keyring(struct user_struct
 	 * keyring */
 	sprintf(buf, "_uid.%u", user->uid);
 
-	uid_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, ctx,
-				    KEY_ALLOC_IN_QUOTA, session_keyring);
+	uid_keyring = keyring_alloc(
+		buf, user->uid, (gid_t) -1, ctx,
+		KEY_ALLOC_IN_QUOTA | KEY_ALLOC_KERNEL_REQUEST,
+		session_keyring);
 	if (IS_ERR(uid_keyring)) {
 		key_put(session_keyring);
 		ret = PTR_ERR(uid_keyring);
@@ -145,8 +149,10 @@ int install_thread_keyring(struct task_s
 
 	sprintf(buf, "_tid.%u", tsk->pid);
 
-	keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk,
-				KEY_ALLOC_QUOTA_OVERRUN, NULL);
+	keyring = keyring_alloc(
+		buf, tsk->uid, tsk->gid, tsk,
+		KEY_ALLOC_QUOTA_OVERRUN | KEY_ALLOC_KERNEL_REQUEST,
+		NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error;
@@ -180,8 +186,10 @@ int install_process_keyring(struct task_
 	if (!tsk->signal->process_keyring) {
 		sprintf(buf, "_pid.%u", tsk->tgid);
 
-		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk,
-					KEY_ALLOC_QUOTA_OVERRUN, NULL);
+		keyring = keyring_alloc(
+			buf, tsk->uid, tsk->gid, tsk,
+			KEY_ALLOC_QUOTA_OVERRUN | KEY_ALLOC_KERNEL_REQUEST,
+			NULL);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error;
@@ -222,9 +230,9 @@ static int install_session_keyring(struc
 	if (!keyring) {
 		sprintf(buf, "_ses.%u", tsk->tgid);
 
-		flags = KEY_ALLOC_QUOTA_OVERRUN;
+		flags = KEY_ALLOC_QUOTA_OVERRUN | KEY_ALLOC_KERNEL_REQUEST;
 		if (tsk->signal->session_keyring)
-			flags = KEY_ALLOC_IN_QUOTA;
+			flags = KEY_ALLOC_IN_QUOTA | KEY_ALLOC_USER_REQUEST;
 
 		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk,
 					flags, NULL);
@@ -738,8 +746,10 @@ long join_session_keyring(const char *na
 	keyring = find_keyring_by_name(name, 0);
 	if (PTR_ERR(keyring) == -ENOKEY) {
 		/* not found - try and create a new one */
-		keyring = keyring_alloc(name, tsk->uid, tsk->gid, tsk,
-					KEY_ALLOC_IN_QUOTA, NULL);
+		keyring = keyring_alloc(
+			name, tsk->uid, tsk->gid, tsk,
+			KEY_ALLOC_IN_QUOTA | KEY_ALLOC_USER_REQUEST,
+			NULL);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error2;
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index bc84cb7..a618d63 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -49,7 +49,7 @@ static int call_sbin_request_key(struct 
 	sprintf(desc, "_req.%u", key->serial);
 
 	keyring = keyring_alloc(desc, current->fsuid, current->fsgid, current,
-				KEY_ALLOC_NOT_IN_QUOTA, NULL);
+				KEY_ALLOC_QUOTA_OVERRUN, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error_alloc;
@@ -126,7 +126,8 @@ error_alloc:
  */
 static struct key *__request_key_construction(struct key_type *type,
 					      const char *description,
-					      const char *callout_info)
+					      const char *callout_info,
+					      unsigned long flags)
 {
 	request_key_actor_t actor;
 	struct key_construction cons;
@@ -139,7 +140,7 @@ static struct key *__request_key_constru
 	/* create a key and add it to the queue */
 	key = key_alloc(type, description,
 			current->fsuid, current->fsgid, current, KEY_POS_ALL,
-			KEY_ALLOC_IN_QUOTA);
+			flags);
 	if (IS_ERR(key))
 		goto alloc_failed;
 
@@ -258,7 +259,8 @@ alloc_failed:
 static struct key *request_key_construction(struct key_type *type,
 					    const char *description,
 					    struct key_user *user,
-					    const char *callout_info)
+					    const char *callout_info,
+					    unsigned long flags)
 {
 	struct key_construction *pcons;
 	struct key *key, *ckey;
@@ -282,7 +284,8 @@ static struct key *request_key_construct
 	}
 
 	/* see about getting userspace to construct the key */
-	key = __request_key_construction(type, description, callout_info);
+	key = __request_key_construction(type, description, callout_info,
+					 flags);
  error:
 	kleave(" = %p", key);
 	return key;
@@ -389,7 +392,8 @@ static void request_key_link(struct key 
 struct key *request_key_and_link(struct key_type *type,
 				 const char *description,
 				 const char *callout_info,
-				 struct key *dest_keyring)
+				 struct key *dest_keyring,
+				 unsigned long flags)
 {
 	struct key_user *user;
 	struct key *key;
@@ -429,7 +433,8 @@ struct key *request_key_and_link(struct 
 			/* ask userspace (returns NULL if it waited on a key
 			 * being constructed) */
 			key = request_key_construction(type, description,
-						       user, callout_info);
+						       user, callout_info,
+						       flags);
 			if (key)
 				break;
 
@@ -485,7 +490,9 @@ struct key *request_key(struct key_type 
 			const char *description,
 			const char *callout_info)
 {
-	return request_key_and_link(type, description, callout_info, NULL);
+	return request_key_and_link(type, description, callout_info, NULL,
+				    KEY_ALLOC_IN_QUOTA |
+				    KEY_ALLOC_KERNEL_REQUEST);
 
 } /* end request_key() */
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 28a702b..555194a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1096,6 +1096,19 @@ static int may_create(struct inode *dir,
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
@@ -4114,6 +4127,8 @@ static int selinux_getprocattr(struct ta
 		sid = tsec->exec_sid;
 	else if (!strcmp(name, "fscreate"))
 		sid = tsec->create_sid;
+	else if (!strcmp(name, "keycreate"))
+		sid = tsec->keycreate_sid;
 	else
 		return -EINVAL;
 
@@ -4146,6 +4161,8 @@ static int selinux_setprocattr(struct ta
 		error = task_has_perm(current, p, PROCESS__SETEXEC);
 	else if (!strcmp(name, "fscreate"))
 		error = task_has_perm(current, p, PROCESS__SETFSCREATE);
+	else if (!strcmp(name, "keycreate"))
+		error = task_has_perm(current, p, PROCESS__SETKEYCREATE);
 	else if (!strcmp(name, "current"))
 		error = task_has_perm(current, p, PROCESS__SETCURRENT);
 	else
@@ -4175,6 +4192,8 @@ static int selinux_setprocattr(struct ta
 		tsec->exec_sid = sid;
 	else if (!strcmp(name, "fscreate"))
 		tsec->create_sid = sid;
+	else if (!strcmp(name, "keycreate"))
+		tsec->keycreate_sid = sid;
 	else if (!strcmp(name, "current")) {
 		struct av_decision avd;
 
@@ -4239,10 +4258,18 @@ static int selinux_key_alloc(struct key 
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
+	if (!(flags & KEY_ALLOC_USER_REQUEST))
+		return 0;
+
+	return may_create_key(k, tsk);
 }
 
 static void selinux_key_free(struct key *k)
@@ -4474,10 +4501,10 @@ static __init int selinux_init(void)
 
 #ifdef CONFIG_KEYS
 	/* Add security information to initial keyrings */
-	security_key_alloc(&root_user_keyring, current,
-			   KEY_ALLOC_NOT_IN_QUOTA);
-	security_key_alloc(&root_session_keyring, current,
-			   KEY_ALLOC_NOT_IN_QUOTA);
+	selinux_key_alloc(&root_user_keyring, current,
+			  KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_KERNEL_REQUEST);
+	selinux_key_alloc(&root_session_keyring, current,
+			  KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_KERNEL_REQUEST);
 #endif
 
 	return 0;
diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index 47b997e..4dbb50a 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -72,6 +72,7 @@
    S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
    S_(SECCLASS_PROCESS, PROCESS__EXECSTACK, "execstack")
    S_(SECCLASS_PROCESS, PROCESS__EXECHEAP, "execheap")
+   S_(SECCLASS_PROCESS, PROCESS__SETKEYCREATE, "setkeycreate")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
@@ -245,3 +246,4 @@
    S_(SECCLASS_KEY, KEY__SEARCH, "search")
    S_(SECCLASS_KEY, KEY__LINK, "link")
    S_(SECCLASS_KEY, KEY__SETATTR, "setattr")
+   S_(SECCLASS_KEY, KEY__CREATE, "create")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index 158b028..da7ad72 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -467,6 +467,7 @@ #define PROCESS__SETCURRENT             
 #define PROCESS__EXECMEM                          0x02000000UL
 #define PROCESS__EXECSTACK                        0x04000000UL
 #define PROCESS__EXECHEAP                         0x08000000UL
+#define PROCESS__SETKEYCREATE                     0x10000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
@@ -939,3 +940,4 @@ #define KEY__WRITE                      
 #define KEY__SEARCH                               0x00000008UL
 #define KEY__LINK                                 0x00000010UL
 #define KEY__SETATTR                              0x00000020UL
+#define KEY__CREATE                               0x00000040UL
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 8f5547a..191b3e4 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
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
