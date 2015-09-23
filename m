Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8NLi8Yd032688
 for <selinux@tycho.nsa.gov>; Wed, 23 Sep 2015 17:44:17 -0400
Subject: [RFC PATCH v1 1/3] lsm: introduce hooks for kdbus
From: Paul Moore <pmoore@redhat.com>
To: Paul Osmialowski <p.osmialowsk@samsung.com>,
 linux-security-module@vger.kernel.org,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>, selinux@tycho.nsa.gov
Date: Wed, 23 Sep 2015 17:44:13 -0400
Message-ID: <20150923214413.25616.29131.stgit@localhost>
In-Reply-To: <20150923213043.25616.43422.stgit@localhost>
References: <20150923213043.25616.43422.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add LSM access control hooks to kdbus; several new hooks are added and
the existing security_file_receive() hook is reused.  The new hooks
are listed below:

 * security_kdbus_conn_new
   Check if the current task is allowed to create a new kdbus
   connection.
 * security_kdbus_own_name
   Check if a connection is allowed to own a kdbus service name.
 * security_kdbus_conn_talk
   Check if a connection is allowed to talk to a kdbus peer.
 * security_kdbus_conn_see
   Check if a connection can see a kdbus peer.
 * security_kdbus_conn_see_name
   Check if a connection can see a kdbus service name.
 * security_kdbus_conn_see_notification
   Check if a connection can receive notifications.
 * security_kdbus_proc_permission
   Check if a connection can access another task's pid namespace info.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 include/linux/security.h |  113 ++++++++++++++++++++++++++++++++++++++++++++++
 ipc/kdbus/connection.c   |   73 ++++++++++++++++++++----------
 ipc/kdbus/message.c      |   19 ++++++--
 ipc/kdbus/metadata.c     |    6 +-
 security/security.c      |   45 ++++++++++++++++++
 5 files changed, 223 insertions(+), 33 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 18264ea..ff3559f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -53,6 +53,8 @@ struct msg_queue;
 struct xattr;
 struct xfrm_sec_ctx;
 struct mm_struct;
+struct kdbus_creds;
+struct kdbus_pids;
 
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
@@ -1300,6 +1302,41 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *	@file contains the struct file being transferred.
  *	@to contains the task_struct for the receiving task.
  *
+ * @kdbus_conn_new
+ *	Check if the current task is allowed to create a new kdbus connection.
+ *	@creds credentials for the new connection
+ *	@fake_creds kdbus faked credentials
+ *	@fake_pids kdbus faked pids
+ *	@fake_seclabel kdbus faked security label
+ *	@owner kdbus owner
+ *	@privileged kdbus privileged
+ *	@is_activator kdbus activator boolean
+ *	@is_monitor kdbus monitor boolean
+ *	@is_policy_holder kdbus policy holder boolean
+ * @kdbus_own_name
+ *	Check if a connection is allowed to own a kdbus service name.
+ *	@creds requestor's credentials
+ *	@name service name
+ * @kdbus_conn_talk
+ *	Check if a connection is allowed to talk to a kdbus peer.
+ *	@creds requestor's credentials
+ *	@creds_peer peer credentials
+ * @kdbus_conn_see
+ *	Check if a connection can see a kdbus peer.
+ *	@creds requestor's credentials
+ *	@creds_peer peer credentials
+ * @kdbus_conn_see_name
+ *	Check if a connection can see a kdbus service name.
+ *	@creds requestor's credentials
+ *	@name service name
+ * @kdbus_conn_see_notification
+ *	Check if a connection can receive notifications.
+ *	@creds requestor's credentials
+ * @kdbus_proc_permission
+ *	Check if a connection can access another task's pid namespace info.
+ *	@cred requestor's credentials
+ *	@pid target task's pid struct
+ *
  * @ptrace_access_check:
  *	Check permission before allowing the current process to trace the
  *	@child process.
@@ -1468,6 +1505,21 @@ struct security_operations {
 	int (*binder_transfer_file) (struct task_struct *from,
 				     struct task_struct *to, struct file *file);
 
+	int (*kdbus_conn_new)(const struct cred *creds,
+			      const struct kdbus_creds *fake_creds,
+			      const struct kdbus_pids *fake_pids,
+			      const char *fake_seclabel,
+			      bool owner, bool privileged, bool is_activator,
+			      bool is_monitor, bool is_policy_holder);
+	int (*kdbus_own_name)(const struct cred *creds, const char *name);
+	int (*kdbus_conn_talk)(const struct cred *creds,
+			       const struct cred *creds_peer);
+	int (*kdbus_conn_see)(const struct cred *creds,
+			      const struct cred *creds_peer);
+	int (*kdbus_conn_see_name)(const struct cred *creds, const char *name);
+	int (*kdbus_conn_see_notification)(const struct cred *creds);
+	int (*kdbus_proc_permission)(const struct cred *creds, struct pid *pid);
+
 	int (*ptrace_access_check) (struct task_struct *child, unsigned int mode);
 	int (*ptrace_traceme) (struct task_struct *parent);
 	int (*capget) (struct task_struct *target,
@@ -1772,6 +1824,20 @@ int security_binder_transfer_binder(struct task_struct *from,
 				    struct task_struct *to);
 int security_binder_transfer_file(struct task_struct *from,
 				  struct task_struct *to, struct file *file);
+int security_kdbus_conn_new(const struct cred *creds,
+			    const struct kdbus_creds *fake_creds,
+			    const struct kdbus_pids *fake_pids,
+			    const char *fake_seclabel,
+			    bool owner, bool privileged, bool is_activator,
+			    bool is_monitor, bool is_policy_holder);
+int security_kdbus_own_name(const struct cred *creds, const char *name);
+int security_kdbus_conn_talk(const struct cred *creds,
+			     const struct cred *creds_peer);
+int security_kdbus_conn_see(const struct cred *creds,
+			    const struct cred *creds_peer);
+int security_kdbus_conn_see_name(const struct cred *creds, const char *name);
+int security_kdbus_conn_see_notification(const struct cred *creds);
+int security_kdbus_proc_permission(const struct cred *creds, struct pid *pid);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
 int security_capget(struct task_struct *target,
@@ -1984,6 +2050,53 @@ static inline int security_binder_transfer_file(struct task_struct *from,
 	return 0;
 }
 
+static inline int security_kdbus_conn_new(const struct cred *creds,
+					  const struct kdbus_creds *fake_creds,
+					  const struct kdbus_pids *fake_pids,
+					  const char *fake_seclabel,
+					  bool owner, bool privileged,
+					  bool is_activator,
+					  bool is_monitor,
+					  bool is_policy_holder)
+{
+	return 0;
+}
+
+static inline int security_kdbus_own_name(const struct cred *creds,
+					  const char *name)
+{
+	return 0;
+}
+
+static inline int security_kdbus_conn_talk(const struct cred *creds,
+					   const struct cred *creds_peer)
+{
+	return 0;
+}
+
+static inline int security_kdbus_conn_see(const struct cred *creds,
+					  const struct cred *creds_peer)
+{
+	return 0;
+}
+
+static inline int security_kdbus_conn_see_name(const struct cred *creds,
+					       const char *name)
+{
+	return 0;
+}
+
+static inline int security_kdbus_conn_see_notification(const struct cred *creds)
+{
+	return 0;
+}
+
+static inline int security_kdbus_proc_permission)(const struct cred *creds,
+						  struct pid *pid)
+{
+	return 0;
+}
+
 static inline int security_ptrace_access_check(struct task_struct *child,
 					     unsigned int mode)
 {
diff --git a/ipc/kdbus/connection.c b/ipc/kdbus/connection.c
index ef63d65..be8d210 100644
--- a/ipc/kdbus/connection.c
+++ b/ipc/kdbus/connection.c
@@ -26,6 +26,7 @@
 #include <linux/path.h>
 #include <linux/poll.h>
 #include <linux/sched.h>
+#include <linux/security.h>
 #include <linux/shmem_fs.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -213,6 +214,13 @@ static struct kdbus_conn *kdbus_conn_new(struct kdbus_ep *ep,
 			goto exit_unref;
 	}
 
+	ret = security_kdbus_conn_new(conn->cred, creds, pids, seclabel,
+				      owner, privileged,
+				      is_activator, is_monitor,
+				      is_policy_holder);
+	if (ret < 0)
+		goto exit_unref;
+
 	/*
 	 * Account the connection against the current user (UID), or for
 	 * custom endpoints use the anonymous user assigned to the endpoint.
@@ -1435,12 +1443,12 @@ bool kdbus_conn_policy_own_name(struct kdbus_conn *conn,
 			return false;
 	}
 
-	if (conn->owner)
-		return true;
-
 	res = kdbus_policy_query(&conn->ep->bus->policy_db, conn_creds,
 				 name, hash);
-	return res >= KDBUS_POLICY_OWN;
+	if (conn->owner || res >= KDBUS_POLICY_OWN)
+		return security_kdbus_own_name(conn_creds, name) == 0;
+
+	return false;
 }
 
 /**
@@ -1465,14 +1473,13 @@ bool kdbus_conn_policy_talk(struct kdbus_conn *conn,
 					 to, KDBUS_POLICY_TALK))
 		return false;
 
-	if (conn->owner)
-		return true;
-	if (uid_eq(conn_creds->euid, to->cred->uid))
-		return true;
+	if (conn->owner || uid_eq(conn_creds->euid, to->cred->uid) ||
+	    kdbus_conn_policy_query_all(conn, conn_creds,
+					&conn->ep->bus->policy_db, to,
+					KDBUS_POLICY_TALK) == 0)
+		return security_kdbus_conn_talk(conn_creds, to->cred) == 0;
 
-	return kdbus_conn_policy_query_all(conn, conn_creds,
-					   &conn->ep->bus->policy_db, to,
-					   KDBUS_POLICY_TALK);
+	return false;
 }
 
 /**
@@ -1493,17 +1500,19 @@ bool kdbus_conn_policy_see_name_unlocked(struct kdbus_conn *conn,
 {
 	int res;
 
+	if (!conn_creds)
+		conn_creds = conn->cred;
+
 	/*
 	 * By default, all names are visible on a bus. SEE policies can only be
 	 * installed on custom endpoints, where by default no name is visible.
 	 */
-	if (!conn->ep->user)
-		return true;
-
-	res = kdbus_policy_query_unlocked(&conn->ep->policy_db,
-					  conn_creds ? : conn->cred,
+	res = kdbus_policy_query_unlocked(&conn->ep->policy_db, conn_creds,
 					  name, kdbus_strhash(name));
-	return res >= KDBUS_POLICY_SEE;
+	if (!conn->ep->user || res >= KDBUS_POLICY_SEE)
+		return security_kdbus_conn_see_name(conn_creds, name) == 0;
+
+	return false;
 }
 
 static bool kdbus_conn_policy_see_name(struct kdbus_conn *conn,
@@ -1523,6 +1532,9 @@ static bool kdbus_conn_policy_see(struct kdbus_conn *conn,
 				  const struct cred *conn_creds,
 				  struct kdbus_conn *whom)
 {
+	if (!conn_creds)
+		conn_creds = conn->cred;
+
 	/*
 	 * By default, all names are visible on a bus, so a connection can
 	 * always see other connections. SEE policies can only be installed on
@@ -1530,10 +1542,13 @@ static bool kdbus_conn_policy_see(struct kdbus_conn *conn,
 	 * peers from each other, unless you see at least _one_ name of the
 	 * peer.
 	 */
-	return !conn->ep->user ||
-	       kdbus_conn_policy_query_all(conn, conn_creds,
-					   &conn->ep->policy_db, whom,
-					   KDBUS_POLICY_SEE);
+	if (!conn->ep->user ||
+	    kdbus_conn_policy_query_all(conn, conn_creds,
+					&conn->ep->policy_db, whom,
+					KDBUS_POLICY_SEE))
+		return security_kdbus_conn_see(conn_creds, whom->cred) == 0;
+
+	return false;
 }
 
 /**
@@ -1551,6 +1566,9 @@ bool kdbus_conn_policy_see_notification(struct kdbus_conn *conn,
 					const struct cred *conn_creds,
 					const struct kdbus_msg *msg)
 {
+	if (!conn_creds)
+		conn_creds = conn->cred;
+
 	/*
 	 * Depending on the notification type, broadcasted kernel notifications
 	 * have to be filtered:
@@ -1567,18 +1585,25 @@ bool kdbus_conn_policy_see_notification(struct kdbus_conn *conn,
 	case KDBUS_ITEM_NAME_ADD:
 	case KDBUS_ITEM_NAME_REMOVE:
 	case KDBUS_ITEM_NAME_CHANGE:
-		return kdbus_conn_policy_see_name(conn, conn_creds,
-					msg->items[0].name_change.name);
+		if (!kdbus_conn_policy_see_name(conn, conn_creds,
+						msg->items[0].name_change.name))
+			return false;
 
 	case KDBUS_ITEM_ID_ADD:
 	case KDBUS_ITEM_ID_REMOVE:
-		return true;
+		/* fall through for the LSM check */
+		break;
 
 	default:
 		WARN(1, "Invalid type for notification broadcast: %llu\n",
 		     (unsigned long long)msg->items[0].type);
 		return false;
 	}
+
+	if (security_kdbus_conn_see_notification(conn_creds) < 0)
+		return false;
+
+	return true;
 }
 
 /**
diff --git a/ipc/kdbus/message.c b/ipc/kdbus/message.c
index ae565cd..acbe981 100644
--- a/ipc/kdbus/message.c
+++ b/ipc/kdbus/message.c
@@ -150,12 +150,17 @@ int kdbus_gaps_install(struct kdbus_gaps *gaps, struct kdbus_pool_slice *slice,
 		for (i = 0; i < gaps->n_fds; ++i) {
 			int fd;
 
+			ret = security_file_receive(gaps->fd_files[i]);
+			if (ret) {
+				incomplete_fds = true;
+				fds[n_fds++] = -1;
+				continue;
+			}
+
 			fd = get_unused_fd_flags(O_CLOEXEC);
 			if (fd < 0)
 				incomplete_fds = true;
 
-			WARN_ON(!gaps->fd_files[i]);
-
 			fds[n_fds++] = fd < 0 ? -1 : fd;
 		}
 
@@ -178,6 +183,13 @@ int kdbus_gaps_install(struct kdbus_gaps *gaps, struct kdbus_pool_slice *slice,
 	for (i = 0; i < gaps->n_memfds; ++i) {
 		int memfd;
 
+		ret = security_file_receive(gaps->memfd_files[i]);
+		if (ret) {
+			incomplete_fds = true;
+			fds[n_fds++] = -1;
+			continue;
+		}
+
 		memfd = get_unused_fd_flags(O_CLOEXEC);
 		if (memfd < 0) {
 			incomplete_fds = true;
@@ -194,9 +206,6 @@ int kdbus_gaps_install(struct kdbus_gaps *gaps, struct kdbus_pool_slice *slice,
 		 * message.
 		 */
 
-		WARN_ON(!gaps->memfd_offsets[i]);
-		WARN_ON(!gaps->memfd_files[i]);
-
 		kvec.iov_base = &memfd;
 		kvec.iov_len = sizeof(memfd);
 		ret = kdbus_pool_slice_copy_kvec(slice, gaps->memfd_offsets[i],
diff --git a/ipc/kdbus/metadata.c b/ipc/kdbus/metadata.c
index 71ca475..07c45d7 100644
--- a/ipc/kdbus/metadata.c
+++ b/ipc/kdbus/metadata.c
@@ -1182,11 +1182,9 @@ static unsigned int kdbus_proc_permission(const struct pid_namespace *pid_ns,
 					  const struct cred *cred,
 					  struct pid *target)
 {
-	if (pid_ns->hide_pid < 1)
-		return KDBUS_META_PROC_NORMAL;
-
 	/* XXX: we need groups_search() exported for aux-groups */
-	if (gid_eq(cred->egid, pid_ns->pid_gid))
+	if ((pid_ns->hide_pid < 1 || gid_eq(cred->egid, pid_ns->pid_gid)) &&
+	    security_kdbus_proc_permission(cred, target) == 0)
 		return KDBUS_META_PROC_NORMAL;
 
 	/*
diff --git a/security/security.c b/security/security.c
index 8e9b1f4..16cfa08 100644
--- a/security/security.c
+++ b/security/security.c
@@ -158,6 +158,51 @@ int security_binder_transfer_file(struct task_struct *from,
 	return security_ops->binder_transfer_file(from, to, file);
 }
 
+int security_kdbus_conn_new(const struct cred *creds,
+			    const struct kdbus_creds *fake_creds,
+			    const struct kdbus_pids *fake_pids,
+			    const char *fake_seclabel,
+			    bool owner, bool privileged, bool is_activator,
+			    bool is_monitor, bool is_policy_holder)
+{
+	return security_ops->kdbus_conn_new(creds, fake_creds, fake_pids,
+					    fake_seclabel, owner, privileged,
+					    is_activator, is_monitor,
+					    is_policy_holder);
+}
+
+int security_kdbus_own_name(const struct cred *creds, const char *name)
+{
+	return security_ops->kdbus_own_name(creds, name);
+}
+
+int security_kdbus_conn_talk(const struct cred *creds,
+			     const struct cred *creds_peer)
+{
+	return security_ops->kdbus_conn_talk(creds, creds_peer);
+}
+
+int security_kdbus_conn_see(const struct cred *creds,
+			    const struct cred *creds_peer)
+{
+	return security_ops->kdbus_conn_see(creds, creds_peer);
+}
+
+int security_kdbus_conn_see_name(const struct cred *creds, const char *name)
+{
+	return security_ops->kdbus_conn_see_name(creds, name);
+}
+
+int security_kdbus_conn_see_notification(const struct cred *creds)
+{
+	return security_ops->kdbus_conn_see_notification(creds);
+}
+
+int security_kdbus_proc_permission(const struct cred *creds, struct pid *pid)
+{
+	return security_ops->kdbus_proc_permission(creds, pid);
+}
+
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
 {
 #ifdef CONFIG_SECURITY_YAMA_STACKED
