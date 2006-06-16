Subject: Re: [PATCH [try #2] 6/6] Keys: Add a way to store the appropriate
	context for newly-created keys
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: David Howells <dhowells@redhat.com>
Cc: sds@tycho.nsa.gov, jmorris@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <20060616125708.26378.77399.stgit@warthog.cambridge.redhat.com>
References: <20060616125654.26378.36519.stgit@warthog.cambridge.redhat.com>
	 <20060616125708.26378.77399.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 10:52:03 -0400
Message-Id: <1150469523.3488.3.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I can see that we had some disagreement about whether various key
creation requests should be classified as originating from within the
kernel or userspace.  Unfortunately, neither of us is clearly correct in
our classification.  Thus, I propose removing the create check from
security_key_alloc altogether and placing it instead in setprocattr, to
restrict programs from setting disallowed key creation contexts in the
first place.  I hate to do this so late in the game, but I think it's
important.

---

diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.orig/Documentation/keys.txt linux-2.6.17-rc6-mm2.dh.keycreate/Documentation/keys.txt
--- linux-2.6.17-rc6-mm2.dh.orig/Documentation/keys.txt	2006-06-16 08:52:23.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.keycreate/Documentation/keys.txt	2006-06-16 08:54:40.000000000 -0400
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
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.orig/fs/proc/base.c linux-2.6.17-rc6-mm2.dh.keycreate/fs/proc/base.c
--- linux-2.6.17-rc6-mm2.dh.orig/fs/proc/base.c	2006-06-16 08:48:32.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.keycreate/fs/proc/base.c	2006-06-16 08:54:40.000000000 -0400
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
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.orig/security/dummy.c linux-2.6.17-rc6-mm2.dh.keycreate/security/dummy.c
--- linux-2.6.17-rc6-mm2.dh.orig/security/dummy.c	2006-06-16 08:49:05.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.keycreate/security/dummy.c	2006-06-16 08:54:40.000000000 -0400
@@ -865,7 +865,7 @@ static int dummy_setprocattr(struct task
 }
 
 #ifdef CONFIG_KEYS
-static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx)
+static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx, unsigned long flags)
 {
 	return 0;
 }
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.orig/security/keys/internal.h linux-2.6.17-rc6-mm2.dh.keycreate/security/keys/internal.h
--- linux-2.6.17-rc6-mm2.dh.orig/security/keys/internal.h	2006-06-16 08:49:05.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.keycreate/security/keys/internal.h	2006-06-16 08:54:40.000000000 -0400
@@ -99,7 +99,8 @@ extern int install_process_keyring(struc
 extern struct key *request_key_and_link(struct key_type *type,
 					const char *description,
 					const char *callout_info,
-					struct key *dest_keyring);
+					struct key *dest_keyring,
+					unsigned long flags);
 
 /*
  * request_key authorisation
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.orig/security/keys/keyctl.c linux-2.6.17-rc6-mm2.dh.keycreate/security/keys/keyctl.c
--- linux-2.6.17-rc6-mm2.dh.orig/security/keys/keyctl.c	2006-06-16 08:49:27.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.keycreate/security/keys/keyctl.c	2006-06-16 09:25:06.000000000 -0400
@@ -101,8 +101,9 @@ asmlinkage long sys_add_key(const char _
 
 	/* create or update the requested key and add it to the target
 	 * keyring */
-	key_ref = key_create_or_update(keyring_ref, type, description,
-				       payload, plen, 0);
+	key_ref = key_create_or_update(
+		keyring_ref, type, description, payload, plen,
+		KEY_ALLOC_IN_QUOTA);
 	if (!IS_ERR(key_ref)) {
 		ret = key_ref_to_ptr(key_ref)->serial;
 		key_ref_put(key_ref);
@@ -184,7 +185,8 @@ asmlinkage long sys_request_key(const ch
 
 	/* do the search */
 	key = request_key_and_link(ktype, description, callout_info,
-				   key_ref_to_ptr(dest_ref));
+				   key_ref_to_ptr(dest_ref),
+				   KEY_ALLOC_IN_QUOTA);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto error5;
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.orig/security/keys/process_keys.c linux-2.6.17-rc6-mm2.dh.keycreate/security/keys/process_keys.c
--- linux-2.6.17-rc6-mm2.dh.orig/security/keys/process_keys.c	2006-06-16 08:49:17.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.keycreate/security/keys/process_keys.c	2006-06-16 09:26:11.000000000 -0400
@@ -77,8 +77,10 @@ int alloc_uid_keyring(struct user_struct
 	/* concoct a default session keyring */
 	sprintf(buf, "_uid_ses.%u", user->uid);
 
-	session_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, ctx,
-					KEY_ALLOC_IN_QUOTA, NULL);
+	session_keyring = keyring_alloc(
+		buf, user->uid, (gid_t) -1, ctx,
+		KEY_ALLOC_IN_QUOTA,
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
+		KEY_ALLOC_IN_QUOTA,
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
+		KEY_ALLOC_QUOTA_OVERRUN,
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
+			KEY_ALLOC_QUOTA_OVERRUN,
+			NULL);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error;
@@ -737,8 +745,10 @@ long join_session_keyring(const char *na
 	keyring = find_keyring_by_name(name, 0);
 	if (PTR_ERR(keyring) == -ENOKEY) {
 		/* not found - try and create a new one */
-		keyring = keyring_alloc(name, tsk->uid, tsk->gid, tsk,
-					KEY_ALLOC_IN_QUOTA, NULL);
+		keyring = keyring_alloc(
+			name, tsk->uid, tsk->gid, tsk,
+			KEY_ALLOC_IN_QUOTA,
+			NULL);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error2;
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.orig/security/keys/request_key.c linux-2.6.17-rc6-mm2.dh.keycreate/security/keys/request_key.c
--- linux-2.6.17-rc6-mm2.dh.orig/security/keys/request_key.c	2006-06-16 08:49:17.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.keycreate/security/keys/request_key.c	2006-06-16 09:27:08.000000000 -0400
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
 
@@ -485,7 +490,8 @@ struct key *request_key(struct key_type 
 			const char *description,
 			const char *callout_info)
 {
-	return request_key_and_link(type, description, callout_info, NULL);
+	return request_key_and_link(type, description, callout_info, NULL,
+				    KEY_ALLOC_IN_QUOTA);
 
 } /* end request_key() */
 
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.orig/security/selinux/hooks.c linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/hooks.c
--- linux-2.6.17-rc6-mm2.dh.orig/security/selinux/hooks.c	2006-06-16 08:49:05.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/hooks.c	2006-06-16 10:38:14.000000000 -0400
@@ -1099,6 +1099,17 @@ static int may_create(struct inode *dir,
 			    FILESYSTEM__ASSOCIATE, &ad);
 }
 
+/* Check whether a task can create a key. */
+static int may_create_key(u32 ksid,
+			  struct task_struct *ctx)
+{
+	struct task_security_struct *tsec;
+
+	tsec = ctx->security;
+
+	return avc_has_perm(tsec->sid, ksid, SECCLASS_KEY, KEY__CREATE, NULL);
+}
+
 #define MAY_LINK   0
 #define MAY_UNLINK 1
 #define MAY_RMDIR  2
@@ -4145,6 +4156,8 @@ static int selinux_getprocattr(struct ta
 		sid = tsec->exec_sid;
 	else if (!strcmp(name, "fscreate"))
 		sid = tsec->create_sid;
+	else if (!strcmp(name, "keycreate"))
+		sid = tsec->keycreate_sid;
 	else
 		return -EINVAL;
 
@@ -4177,6 +4190,8 @@ static int selinux_setprocattr(struct ta
 		error = task_has_perm(current, p, PROCESS__SETEXEC);
 	else if (!strcmp(name, "fscreate"))
 		error = task_has_perm(current, p, PROCESS__SETFSCREATE);
+	else if (!strcmp(name, "keycreate"))
+		error = task_has_perm(current, p, PROCESS__SETKEYCREATE);
 	else if (!strcmp(name, "current"))
 		error = task_has_perm(current, p, PROCESS__SETCURRENT);
 	else
@@ -4206,7 +4221,12 @@ static int selinux_setprocattr(struct ta
 		tsec->exec_sid = sid;
 	else if (!strcmp(name, "fscreate"))
 		tsec->create_sid = sid;
-	else if (!strcmp(name, "current")) {
+	else if (!strcmp(name, "keycreate")) {
+		error = may_create_key(sid, p);
+		if (error)
+			return error;
+		tsec->keycreate_sid = sid;
+	} else if (!strcmp(name, "current")) {
 		struct av_decision avd;
 
 		if (sid == 0)
@@ -4259,7 +4279,8 @@ static int selinux_setprocattr(struct ta
 
 #ifdef CONFIG_KEYS
 
-static int selinux_key_alloc(struct key *k, struct task_struct *tsk)
+static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
+			     unsigned long flags)
 {
 	struct task_security_struct *tsec = tsk->security;
 	struct key_security_struct *ksec;
@@ -4269,7 +4290,10 @@ static int selinux_key_alloc(struct key 
 		return -ENOMEM;
 
 	ksec->obj = k;
-	ksec->sid = tsec->sid;
+	if (tsec->keycreate_sid)
+		ksec->sid = tsec->keycreate_sid;
+	else
+		ksec->sid = tsec->sid;
 	k->security = ksec;
 
 	return 0;
@@ -4507,8 +4531,10 @@ static __init int selinux_init(void)
 
 #ifdef CONFIG_KEYS
 	/* Add security information to initial keyrings */
-	security_key_alloc(&root_user_keyring, current);
-	security_key_alloc(&root_session_keyring, current);
+	selinux_key_alloc(&root_user_keyring, current,
+			  KEY_ALLOC_NOT_IN_QUOTA);
+	selinux_key_alloc(&root_session_keyring, current,
+			  KEY_ALLOC_NOT_IN_QUOTA);
 #endif
 
 	return 0;
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.orig/security/selinux/include/av_permissions.h linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/include/av_permissions.h
--- linux-2.6.17-rc6-mm2.dh.orig/security/selinux/include/av_permissions.h	2006-06-16 08:49:05.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/include/av_permissions.h	2006-06-16 08:55:48.000000000 -0400
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
 
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.orig/security/selinux/include/av_perm_to_string.h linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/include/av_perm_to_string.h
--- linux-2.6.17-rc6-mm2.dh.orig/security/selinux/include/av_perm_to_string.h	2006-06-16 08:49:05.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/include/av_perm_to_string.h	2006-06-16 08:54:40.000000000 -0400
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
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.dh.orig/security/selinux/include/objsec.h linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/include/objsec.h
--- linux-2.6.17-rc6-mm2.dh.orig/security/selinux/include/objsec.h	2006-06-16 08:49:05.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.keycreate/security/selinux/include/objsec.h	2006-06-16 08:54:40.000000000 -0400
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
