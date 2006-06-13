Subject: [PATCH] selinux: add /proc/pid/attr/keycreate to convey key
	creation context
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, dhowells@redhat.com, sds@tycho.nsa.gov,
        jmorris@redhat.com
Content-Type: text/plain
Date: Tue, 13 Jun 2006 08:42:34 -0400
Message-Id: <1150202554.3677.5.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an updated version of my previous patch that incorporates Steve's
suggestion to provide a "create" permission for keys.  Hopefully my mailer
leaves the subject line intact this time.

---<snip>---
From: Michael LeMay <mdlemay@epoch.ncsc.mil>

Add a /proc/<pid>/attr/keycreate entry that stores the appropriate
context for newly-created keys.  Modify the selinux_key_alloc
hook to make use of the new entry.  Update the flask headers to
include a new "setkeycreate" permission for processes.  Update the
flask headers to include a new "create" permission for keys.  Use
the create permission to restrict which SIDs each task can assign
to newly-created keys.  Update the documentation to reflect these
changes.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

---

 Documentation/keys.txt                       |   29 +++++++++++++++------------ fs/proc/base.c                               |    6 +++++
 security/selinux/hooks.c                     |   26 ++++++++++++++++++++++--
 security/selinux/include/av_perm_to_string.h |    2 +
 security/selinux/include/av_permissions.h    |    2 +
 security/selinux/include/objsec.h            |    1
 6 files changed, 52 insertions(+), 14 deletions(-)

diff -uprN -X linux-2.6.17-rc6-mm1.orig/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/Documentation/keys.txt linux-2.6.17-rc6-mm1.keycreate/Documentation/keys.txt
--- linux-2.6.17-rc6-mm1.orig/Documentation/keys.txt	2006-06-13 08:10:50.000000000 -0400
+++ linux-2.6.17-rc6-mm1.keycreate/Documentation/keys.txt	2006-06-13 08:29:56.000000000 -0400
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
diff -uprN -X linux-2.6.17-rc6-mm1.orig/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/fs/proc/base.c linux-2.6.17-rc6-mm1.keycreate/fs/proc/base.c
--- linux-2.6.17-rc6-mm1.orig/fs/proc/base.c	2006-06-13 08:10:52.000000000 -0400
+++ linux-2.6.17-rc6-mm1.keycreate/fs/proc/base.c	2006-06-13 08:25:53.000000000 -0400
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
diff -uprN -X linux-2.6.17-rc6-mm1.orig/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/security/selinux/hooks.c linux-2.6.17-rc6-mm1.keycreate/security/selinux/hooks.c
--- linux-2.6.17-rc6-mm1.orig/security/selinux/hooks.c	2006-06-13 08:10:53.000000000 -0400
+++ linux-2.6.17-rc6-mm1.keycreate/security/selinux/hooks.c	2006-06-13 08:27:59.000000000 -0400
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
 
@@ -4269,10 +4288,13 @@ static int selinux_key_alloc(struct key 
 		return -ENOMEM;
 
 	ksec->obj = k;
-	ksec->sid = tsec->sid;
+	if (tsec->keycreate_sid)
+		ksec->sid = tsec->keycreate_sid;
+	else
+		ksec->sid = tsec->sid;
 	k->security = ksec;
 
-	return 0;
+	return may_create_key(k, tsk);
 }
 
 static void selinux_key_free(struct key *k)
diff -uprN -X linux-2.6.17-rc6-mm1.orig/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/security/selinux/include/av_permissions.h linux-2.6.17-rc6-mm1.keycreate/security/selinux/include/av_permissions.h
--- linux-2.6.17-rc6-mm1.orig/security/selinux/include/av_permissions.h	2006-06-13 08:10:53.000000000 -0400
+++ linux-2.6.17-rc6-mm1.keycreate/security/selinux/include/av_permissions.h	2006-06-13 07:48:37.000000000 -0400
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
 
diff -uprN -X linux-2.6.17-rc6-mm1.orig/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/security/selinux/include/av_perm_to_string.h linux-2.6.17-rc6-mm1.keycreate/security/selinux/include/av_perm_to_string.h
--- linux-2.6.17-rc6-mm1.orig/security/selinux/include/av_perm_to_string.h	2006-06-13 08:10:53.000000000 -0400
+++ linux-2.6.17-rc6-mm1.keycreate/security/selinux/include/av_perm_to_string.h	2006-06-13 07:48:37.000000000 -0400
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
diff -uprN -X linux-2.6.17-rc6-mm1.orig/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/security/selinux/include/objsec.h linux-2.6.17-rc6-mm1.keycreate/security/selinux/include/objsec.h
--- linux-2.6.17-rc6-mm1.orig/security/selinux/include/objsec.h	2006-06-13 08:10:53.000000000 -0400
+++ linux-2.6.17-rc6-mm1.keycreate/security/selinux/include/objsec.h	2006-06-09 09:37:24.000000000 -0400
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
