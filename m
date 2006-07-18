Subject: [PATCH] SELinux: new /proc/self/attr/ipccreate for explicite ipc
	object labeling
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Tue, 18 Jul 2006 15:36:03 -0400
Message-Id: <1153251363.2915.76.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At this point in time IPC objects (semaphores, message queues, etc) were
labeled with the label of the process which created them.  This patch
introduces a new /proc/self/attr/ipccreate which will allow a program to
set the label on ipc objects it is about to create.  This may be useful
in future trusted applications but at this time I do not know of any
application which needs this functionality, but it should allow better
more understandable policy to control access to ipc objects.

In security/selinux/include/av_permissions.h the patch also adds a blank
line at the end.  This was the output after the change to the
access_vectors in policy and I did not edit that file by hand.

Signed-off-by: Eric Paris <eparis@redhat.com>

 fs/proc/base.c                               |    6 ++++++
 security/selinux/hooks.c                     |   12 ++++++++++--
 security/selinux/include/av_perm_to_string.h |    1 +
 security/selinux/include/av_permissions.h    |    2 ++
 security/selinux/include/objsec.h            |    1 +

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 243a94a..5b8ed50 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -132,6 +132,7 @@ #ifdef CONFIG_SECURITY
 	PROC_TGID_ATTR_FSCREATE,
 	PROC_TGID_ATTR_KEYCREATE,
 	PROC_TGID_ATTR_SOCKCREATE,
+	PROC_TGID_ATTR_IPCCREATE,
 #endif
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TGID_LOGINUID,
@@ -175,6 +176,7 @@ #ifdef CONFIG_SECURITY
 	PROC_TID_ATTR_FSCREATE,
 	PROC_TID_ATTR_KEYCREATE,
 	PROC_TID_ATTR_SOCKCREATE,
+	PROC_TID_ATTR_IPCCREATE,
 #endif
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TID_LOGINUID,
@@ -293,6 +295,7 @@ static struct pid_entry tgid_attr_stuff[
 	E(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TGID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TGID_ATTR_SOCKCREATE, "sockcreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_IPCCREATE, "ipccreate", S_IFREG|S_IRUGO|S_IWUGO),
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_attr_stuff[] = {
@@ -302,6 +305,7 @@ static struct pid_entry tid_attr_stuff[]
 	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TID_ATTR_SOCKCREATE, "sockcreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_IPCCREATE, "ipccreate", S_IFREG|S_IRUGO|S_IWUGO),
 	{0,0,NULL,0}
 };
 #endif
@@ -1769,6 +1773,8 @@ #ifdef CONFIG_SECURITY
 		case PROC_TGID_ATTR_KEYCREATE:
 		case PROC_TID_ATTR_SOCKCREATE:
 		case PROC_TGID_ATTR_SOCKCREATE:
+		case PROC_TID_ATTR_IPCCREATE:
+		case PROC_TGID_ATTR_IPCCREATE:
 			inode->i_fop = &proc_pid_attr_operations;
 			break;
 #endif
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2e8b4df..717c6c8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1618,10 +1618,11 @@ static int selinux_bprm_set_security(str
 	/* Default to the current task SID. */
 	bsec->sid = tsec->sid;
 
-	/* Reset fs, key, and sock SIDs on execve. */
+	/* Reset fs, key, ipc, and sock SIDs on execve. */
 	tsec->create_sid = 0;
 	tsec->keycreate_sid = 0;
 	tsec->sockcreate_sid = 0;
+	tsec->ipccreate_sid = 0;
 
 	if (tsec->exec_sid) {
 		newsid = tsec->exec_sid;
@@ -2679,6 +2680,7 @@ static int selinux_task_alloc_security(s
 	tsec2->create_sid = tsec1->create_sid;
 	tsec2->keycreate_sid = tsec1->keycreate_sid;
 	tsec2->sockcreate_sid = tsec1->sockcreate_sid;
+	tsec2->ipccreate_sid = tsec1->ipccreate_sid;
 
 	/* Retain ptracer SID across fork, if any.
 	   This will be reset by the ptrace hook upon any
@@ -3789,7 +3791,7 @@ static int ipc_alloc_security(struct tas
 
 	isec->sclass = sclass;
 	isec->ipc_perm = perm;
-	isec->sid = tsec->sid;
+	isec->sid = tsec->ipccreate_sid ? : tsec->sid;
 	perm->security = isec;
 
 	return 0;
@@ -4280,6 +4282,8 @@ static int selinux_getprocattr(struct ta
 		sid = tsec->keycreate_sid;
 	else if (!strcmp(name, "sockcreate"))
 		sid = tsec->sockcreate_sid;
+	else if (!strcmp(name, "ipccreate"))
+		sid = tsec->ipccreate_sid;
 	else
 		return -EINVAL;
 
@@ -4316,6 +4320,8 @@ static int selinux_setprocattr(struct ta
 		error = task_has_perm(current, p, PROCESS__SETKEYCREATE);
 	else if (!strcmp(name, "sockcreate"))
 		error = task_has_perm(current, p, PROCESS__SETSOCKCREATE);
+	else if (!strcmp(name, "ipccreate"))
+		error = task_has_perm(current, p, PROCESS__SETIPCCREATE);
 	else if (!strcmp(name, "current"))
 		error = task_has_perm(current, p, PROCESS__SETCURRENT);
 	else
@@ -4352,6 +4358,8 @@ static int selinux_setprocattr(struct ta
 		tsec->keycreate_sid = sid;
 	} else if (!strcmp(name, "sockcreate"))
 		tsec->sockcreate_sid = sid;
+	else if (!strcmp(name, "ipccreate"))
+		tsec->ipccreate_sid = sid;
 	else if (!strcmp(name, "current")) {
 		struct av_decision avd;
 
diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index 7c9b583..08a26db 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -74,6 +74,7 @@
    S_(SECCLASS_PROCESS, PROCESS__EXECHEAP, "execheap")
    S_(SECCLASS_PROCESS, PROCESS__SETKEYCREATE, "setkeycreate")
    S_(SECCLASS_PROCESS, PROCESS__SETSOCKCREATE, "setsockcreate")
+   S_(SECCLASS_PROCESS, PROCESS__SETIPCCREATE, "setipccreate")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index 69fd4b4..0bc6fca 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -469,6 +469,7 @@ #define PROCESS__EXECSTACK              
 #define PROCESS__EXECHEAP                         0x08000000UL
 #define PROCESS__SETKEYCREATE                     0x10000000UL
 #define PROCESS__SETSOCKCREATE                    0x20000000UL
+#define PROCESS__SETIPCCREATE                     0x40000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
@@ -969,3 +970,4 @@ #define KEY__SEARCH                     
 #define KEY__LINK                                 0x00000010UL
 #define KEY__SETATTR                              0x00000020UL
 #define KEY__CREATE                               0x00000040UL
+
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 9401788..a14c2f5 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -34,6 +34,7 @@ struct task_security_struct {
 	u32 create_sid;      /* fscreate SID */
 	u32 keycreate_sid;   /* keycreate SID */
 	u32 sockcreate_sid;  /* fscreate SID */
+	u32 ipccreate_sid;   /* ipccreate SID */
 	u32 ptrace_sid;      /* SID of ptrace parent */
 };
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
