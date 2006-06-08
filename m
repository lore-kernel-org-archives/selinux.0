Subject: [PATCH] selinux: add /proc/pid/attr/keycreate to convey key
	creation context
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, dhowells@redhat.com
Content-Type: text/plain
Date: Thu, 08 Jun 2006 14:55:11 -0400
Message-Id: <1149792912.14467.24.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David (and the rest of the list),

This patch adds the /proc/<pid>/attr/keycreate entry that Steve discussed earlier.
It's very simple, but please check it out and make sure it does what you think it
should.  Essentially, the intended usage of this entry is to have all of the
various login programs (util-linux/login, ssh, gdm, ...) extract a user's default
context and store it in this entry before invoking setuid to initiate their session.
Then, when setuid eventually invokes alloc_uid -> keyring_alloc -> selinux_key_alloc, 
the default keyrings will be assigned the default context for the user, rather than
the context of the login program.  The entry could potentially be used for other
purposes, since it is checked every time the security structure for a new key is
allocated, but I can't think of any interesting examples right now.

Of course, this change sends ripples through quite a few other systems, which is why
it's taken me so long to get this patch out.  First, I had to add a "setkeycreate"
permission to the "process" security class in serefpolicy.  Then, I had to augment
the SELinux library with a "setkeycreatecon" operation, which is analogous to
"setfscreatecon" (it seems those functions requires some refactoring, but I haven't
done anything yet).

Then, I concentrated on GDM, login, and SSH, to make sure they're compatible with the
new entry.  Surprisingly, SSH sets its execution context early enough that this patch
isn't necessary.  However, the other two programs don't, so I had to add a simple invocation
to each of them to set the entry before performing setuid.

I'll send the other patches along after we discuss this one.

---<snip>---
From: Michael LeMay <mdlemay@epoch.ncsc.mil>

Add a /proc/<pid>/attr/keycreate entry that stores the appropriate
context for newly-created keys.  Modify the selinux_key_alloc
hook to make use of the new entry.  Update the flask headers to
include a new "setkeycreate" permission for processes.  Update the
documentation to reflect these changes.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

---

 Documentation/keys.txt                       |    2 +-
 fs/proc/base.c                               |   22 ++++++++++++++--------
 security/selinux/hooks.c                     |   11 ++++++++++-
 security/selinux/include/av_perm_to_string.h |    1 +
 security/selinux/include/av_permissions.h    |    1 +
 security/selinux/include/objsec.h            |    1 +
 6 files changed, 28 insertions(+), 10 deletions(-)

diff -uprN -X linux-2.6.17-rc6-mm1/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/Documentation/keys.txt linux-2.6.17-rc6-mm1/Documentation/keys.txt
--- linux-2.6.17-rc6-mm1.orig/Documentation/keys.txt	2006-06-08 09:41:42.000000000 -0400
+++ linux-2.6.17-rc6-mm1/Documentation/keys.txt	2006-06-08 14:46:07.000000000 -0400
@@ -250,7 +250,7 @@ The default keyrings are handled differe
 intuitive:
 
  (*) The user and user session keyrings that are created when the user logs in
-     are currently labeled with the context of the login manager.
+     are labeled with the user's default context.
 
  (*) The keyrings associated with new threads are each labeled with the context
      of their associated thread, and both session and process keyrings are
diff -uprN -X linux-2.6.17-rc6-mm1/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/fs/proc/base.c linux-2.6.17-rc6-mm1/fs/proc/base.c
--- linux-2.6.17-rc6-mm1.orig/fs/proc/base.c	2006-06-08 09:41:47.000000000 -0400
+++ linux-2.6.17-rc6-mm1/fs/proc/base.c	2006-06-08 10:14:50.000000000 -0400
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
@@ -285,17 +287,19 @@ static struct pid_entry tid_base_stuff[]
 
 #ifdef CONFIG_SECURITY
 static struct pid_entry tgid_attr_stuff[] = {
-	E(PROC_TGID_ATTR_CURRENT,  "current",  S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TGID_ATTR_PREV,     "prev",     S_IFREG|S_IRUGO),
-	E(PROC_TGID_ATTR_EXEC,     "exec",     S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_CURRENT,   "current",   S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_PREV,      "prev",      S_IFREG|S_IRUGO),
+	E(PROC_TGID_ATTR_EXEC,      "exec",      S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_FSCREATE,  "fscreate",  S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_attr_stuff[] = {
-	E(PROC_TID_ATTR_CURRENT,   "current",  S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TID_ATTR_PREV,      "prev",     S_IFREG|S_IRUGO),
-	E(PROC_TID_ATTR_EXEC,      "exec",     S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_CURRENT,   "current",   S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_PREV,      "prev",      S_IFREG|S_IRUGO),
+	E(PROC_TID_ATTR_EXEC,      "exec",      S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_FSCREATE,  "fscreate",  S_IFREG|S_IRUGO|S_IWUGO),
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
diff -uprN -X linux-2.6.17-rc6-mm1/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/security/selinux/hooks.c linux-2.6.17-rc6-mm1/security/selinux/hooks.c
--- linux-2.6.17-rc6-mm1.orig/security/selinux/hooks.c	2006-06-08 09:41:50.000000000 -0400
+++ linux-2.6.17-rc6-mm1/security/selinux/hooks.c	2006-06-08 10:14:50.000000000 -0400
@@ -4145,6 +4145,8 @@ static int selinux_getprocattr(struct ta
 		sid = tsec->exec_sid;
 	else if (!strcmp(name, "fscreate"))
 		sid = tsec->create_sid;
+	else if (!strcmp(name, "keycreate"))
+		sid = tsec->keycreate_sid;
 	else
 		return -EINVAL;
 
@@ -4177,6 +4179,8 @@ static int selinux_setprocattr(struct ta
 		error = task_has_perm(current, p, PROCESS__SETEXEC);
 	else if (!strcmp(name, "fscreate"))
 		error = task_has_perm(current, p, PROCESS__SETFSCREATE);
+	else if (!strcmp(name, "keycreate"))
+		error = task_has_perm(current, p, PROCESS__SETKEYCREATE);
 	else if (!strcmp(name, "current"))
 		error = task_has_perm(current, p, PROCESS__SETCURRENT);
 	else
@@ -4206,6 +4210,8 @@ static int selinux_setprocattr(struct ta
 		tsec->exec_sid = sid;
 	else if (!strcmp(name, "fscreate"))
 		tsec->create_sid = sid;
+	else if (!strcmp(name, "keycreate"))
+		tsec->keycreate_sid = sid;
 	else if (!strcmp(name, "current")) {
 		struct av_decision avd;
 
@@ -4269,7 +4275,10 @@ static int selinux_key_alloc(struct key 
 		return -ENOMEM;
 
 	ksec->obj = k;
-	ksec->sid = tsec->sid;
+	if (tsec->keycreate_sid)
+		ksec->sid = tsec->keycreate_sid;
+	else
+		ksec->sid = tsec->sid;
 	k->security = ksec;
 
 	return 0;
diff -uprN -X linux-2.6.17-rc6-mm1/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/security/selinux/include/av_permissions.h linux-2.6.17-rc6-mm1/security/selinux/include/av_permissions.h
--- linux-2.6.17-rc6-mm1.orig/security/selinux/include/av_permissions.h	2006-06-08 09:41:50.000000000 -0400
+++ linux-2.6.17-rc6-mm1/security/selinux/include/av_permissions.h	2006-06-08 14:27:44.000000000 -0400
@@ -467,6 +467,7 @@
 #define PROCESS__EXECMEM                          0x02000000UL
 #define PROCESS__EXECSTACK                        0x04000000UL
 #define PROCESS__EXECHEAP                         0x08000000UL
+#define PROCESS__SETKEYCREATE                     0x10000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
diff -uprN -X linux-2.6.17-rc6-mm1/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/security/selinux/include/av_perm_to_string.h linux-2.6.17-rc6-mm1/security/selinux/include/av_perm_to_string.h
--- linux-2.6.17-rc6-mm1.orig/security/selinux/include/av_perm_to_string.h	2006-06-08 09:41:50.000000000 -0400
+++ linux-2.6.17-rc6-mm1/security/selinux/include/av_perm_to_string.h	2006-06-08 14:27:44.000000000 -0400
@@ -72,6 +72,7 @@
    S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
    S_(SECCLASS_PROCESS, PROCESS__EXECSTACK, "execstack")
    S_(SECCLASS_PROCESS, PROCESS__EXECHEAP, "execheap")
+   S_(SECCLASS_PROCESS, PROCESS__SETKEYCREATE, "setkeycreate")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
diff -uprN -X linux-2.6.17-rc6-mm1/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/security/selinux/include/objsec.h linux-2.6.17-rc6-mm1/security/selinux/include/objsec.h
--- linux-2.6.17-rc6-mm1.orig/security/selinux/include/objsec.h	2006-06-08 09:41:50.000000000 -0400
+++ linux-2.6.17-rc6-mm1/security/selinux/include/objsec.h	2006-06-08 10:14:50.000000000 -0400
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
