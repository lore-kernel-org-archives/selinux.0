Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t97N8nmd015984
 for <selinux@tycho.nsa.gov>; Wed, 7 Oct 2015 19:08:50 -0400
Subject: [RFC PATCH v3 2/5] lsm: introduce hooks for kdbus
From: Paul Moore <pmoore@redhat.com>
To: linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 selinux@tycho.nsa.gov
Cc: Paul Osmialowski <p.osmialowsk@samsung.com>
Date: Wed, 07 Oct 2015 19:08:29 -0400
Message-ID: <20151007230829.7823.14385.stgit@localhost>
In-Reply-To: <20151007230615.7823.74519.stgit@localhost>
References: <20151007230615.7823.74519.stgit@localhost>
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
 * security_kdbus_init_inode
   Set the security label on a kdbusfs inode

Signed-off-by: Paul Moore <pmoore@redhat.com>

---
ChangeLog:
- v3
 * Ported to the 4.3-rc4 based kdbus tree
- v2
 * Implemented suggestions by Stephen Smalley
   * call security_kdbus_conn_new() sooner
   * reworked hook inside kdbus_conn_policy_own_name()
   * fixed if-conditional in kdbus_conn_policy_talk()
   * reworked hook inside kdbus_conn_policy_see_name_unlocked()
   * reworked hook inside kdbus_conn_policy_see()
   * reworked hook inside kdbus_conn_policy_see_notification()
   * added the security_kdbus_init_inode() hook
- v1
 * Initial draft
---
 include/linux/lsm_hooks.h |   63 +++++++++++++++++++++++++++++++++++++++
 include/linux/security.h  |   71 ++++++++++++++++++++++++++++++++++++++++++++
 ipc/kdbus/connection.c    |   73 +++++++++++++++++++++++++++++----------------
 ipc/kdbus/fs.c            |    6 ++++
 ipc/kdbus/message.c       |   19 +++++++++---
 ipc/kdbus/metadata.c      |    6 +---
 security/security.c       |   62 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 265 insertions(+), 35 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ec3a6ba..36d4e5d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1138,6 +1138,45 @@
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
+ * @kdbus_init_inode
+ *	Set the security label on a kdbusfs inode
+ *	@inode kdbusfs inode
+ *	@creds inode owner credentials
+ *
  * @ptrace_access_check:
  *	Check permission before allowing the current process to trace the
  *	@child process.
@@ -1310,6 +1349,22 @@ union security_list_options {
 					struct task_struct *to,
 					struct file *file);
 
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
+	int (*kdbus_init_inode)(struct inode *inode, const struct cred *creds);
+
 	int (*ptrace_access_check)(struct task_struct *child,
 					unsigned int mode);
 	int (*ptrace_traceme)(struct task_struct *parent);
@@ -1620,6 +1675,14 @@ struct security_hook_heads {
 	struct list_head binder_transaction;
 	struct list_head binder_transfer_binder;
 	struct list_head binder_transfer_file;
+	struct list_head kdbus_conn_new;
+	struct list_head kdbus_own_name;
+	struct list_head kdbus_conn_talk;
+	struct list_head kdbus_conn_see;
+	struct list_head kdbus_conn_see_name;
+	struct list_head kdbus_conn_see_notification;
+	struct list_head kdbus_proc_permission;
+	struct list_head kdbus_init_inode;
 	struct list_head ptrace_access_check;
 	struct list_head ptrace_traceme;
 	struct list_head capget;
diff --git a/include/linux/security.h b/include/linux/security.h
index 2f4c1f7..68d83dd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -53,6 +53,9 @@ struct msg_queue;
 struct xattr;
 struct xfrm_sec_ctx;
 struct mm_struct;
+struct kdbus_creds;
+struct kdbus_pids;
+struct pid;
 
 /* If capable should audit the security request */
 #define SECURITY_CAP_NOAUDIT 0
@@ -189,6 +192,21 @@ int security_binder_transfer_binder(struct task_struct *from,
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
+int security_kdbus_init_inode(struct inode *inode, const struct cred *creds);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
 int security_capget(struct task_struct *target,
@@ -402,6 +420,59 @@ static inline int security_binder_transfer_file(struct task_struct *from,
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
+static inline int security_kdbus_init_inode(struct inode *inode,
+					    const struct *creds)
+{
+	return 0;
+}
+
 static inline int security_ptrace_access_check(struct task_struct *child,
 					     unsigned int mode)
 {
diff --git a/ipc/kdbus/connection.c b/ipc/kdbus/connection.c
index ef63d65..1cb87b3 100644
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
@@ -108,6 +109,14 @@ static struct kdbus_conn *kdbus_conn_new(struct kdbus_ep *ep,
 	if (!owner && (creds || pids || seclabel))
 		return ERR_PTR(-EPERM);
 
+	ret = security_kdbus_conn_new(get_cred(file->f_cred),
+				      creds, pids, seclabel,
+				      owner, privileged,
+				      is_activator, is_monitor,
+				      is_policy_holder);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
 	ret = kdbus_sanitize_attach_flags(hello->attach_flags_send,
 					  &attach_flags_send);
 	if (ret < 0)
@@ -1435,12 +1444,12 @@ bool kdbus_conn_policy_own_name(struct kdbus_conn *conn,
 			return false;
 	}
 
-	if (conn->owner)
-		return true;
+	if (!conn->owner &&
+	    kdbus_policy_query(&conn->ep->bus->policy_db, conn_creds, name,
+			       hash) < KDBUS_POLICY_OWN)
+		return false;
 
-	res = kdbus_policy_query(&conn->ep->bus->policy_db, conn_creds,
-				 name, hash);
-	return res >= KDBUS_POLICY_OWN;
+	return (security_kdbus_own_name(conn_creds, name) == 0);
 }
 
 /**
@@ -1465,14 +1474,13 @@ bool kdbus_conn_policy_talk(struct kdbus_conn *conn,
 					 to, KDBUS_POLICY_TALK))
 		return false;
 
-	if (conn->owner)
-		return true;
-	if (uid_eq(conn_creds->euid, to->cred->uid))
-		return true;
+	if (!conn->owner && !uid_eq(conn_creds->euid, to->cred->uid) &&
+	    !kdbus_conn_policy_query_all(conn, conn_creds,
+					 &conn->ep->bus->policy_db, to,
+					 KDBUS_POLICY_TALK))
+		return false;
 
-	return kdbus_conn_policy_query_all(conn, conn_creds,
-					   &conn->ep->bus->policy_db, to,
-					   KDBUS_POLICY_TALK);
+	return (security_kdbus_conn_talk(conn_creds, to->cred) == 0);
 }
 
 /**
@@ -1491,19 +1499,19 @@ bool kdbus_conn_policy_see_name_unlocked(struct kdbus_conn *conn,
 					 const struct cred *conn_creds,
 					 const char *name)
 {
-	int res;
+	if (!conn_creds)
+		conn_creds = conn->cred;
 
 	/*
 	 * By default, all names are visible on a bus. SEE policies can only be
 	 * installed on custom endpoints, where by default no name is visible.
 	 */
-	if (!conn->ep->user)
-		return true;
+	if (conn->ep->user &&
+	    kdbus_policy_query_unlocked(&conn->ep->policy_db, conn_creds, name,
+					kdbus_strhash(name)) < KDBUS_POLICY_SEE)
+		return false;
 
-	res = kdbus_policy_query_unlocked(&conn->ep->policy_db,
-					  conn_creds ? : conn->cred,
-					  name, kdbus_strhash(name));
-	return res >= KDBUS_POLICY_SEE;
+	return (security_kdbus_conn_see_name(conn_creds, name) == 0);
 }
 
 static bool kdbus_conn_policy_see_name(struct kdbus_conn *conn,
@@ -1523,6 +1531,9 @@ static bool kdbus_conn_policy_see(struct kdbus_conn *conn,
 				  const struct cred *conn_creds,
 				  struct kdbus_conn *whom)
 {
+	if (!conn_creds)
+		conn_creds = conn->cred;
+
 	/*
 	 * By default, all names are visible on a bus, so a connection can
 	 * always see other connections. SEE policies can only be installed on
@@ -1530,10 +1541,13 @@ static bool kdbus_conn_policy_see(struct kdbus_conn *conn,
 	 * peers from each other, unless you see at least _one_ name of the
 	 * peer.
 	 */
-	return !conn->ep->user ||
-	       kdbus_conn_policy_query_all(conn, conn_creds,
-					   &conn->ep->policy_db, whom,
-					   KDBUS_POLICY_SEE);
+	if (conn->ep->user &&
+	    !kdbus_conn_policy_query_all(conn, conn_creds,
+					 &conn->ep->policy_db, whom,
+					 KDBUS_POLICY_SEE))
+		return false;
+
+	return (security_kdbus_conn_see(conn_creds, whom->cred) == 0);
 }
 
 /**
@@ -1551,6 +1565,9 @@ bool kdbus_conn_policy_see_notification(struct kdbus_conn *conn,
 					const struct cred *conn_creds,
 					const struct kdbus_msg *msg)
 {
+	if (!conn_creds)
+		conn_creds = conn->cred;
+
 	/*
 	 * Depending on the notification type, broadcasted kernel notifications
 	 * have to be filtered:
@@ -1567,18 +1584,22 @@ bool kdbus_conn_policy_see_notification(struct kdbus_conn *conn,
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
+	return (security_kdbus_conn_see_notification(conn_creds) == 0);
 }
 
 /**
diff --git a/ipc/kdbus/fs.c b/ipc/kdbus/fs.c
index 68818a8..4e84e89 100644
--- a/ipc/kdbus/fs.c
+++ b/ipc/kdbus/fs.c
@@ -23,6 +23,7 @@
 #include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/sched.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 
 #include "bus.h"
@@ -192,6 +193,7 @@ static const struct inode_operations fs_inode_iops = {
 static struct inode *fs_inode_get(struct super_block *sb,
 				  struct kdbus_node *node)
 {
+	int ret;
 	struct inode *inode;
 
 	inode = iget_locked(sb, node->id);
@@ -200,6 +202,10 @@ static struct inode *fs_inode_get(struct super_block *sb,
 	if (!(inode->i_state & I_NEW))
 		return inode;
 
+	ret = security_kdbus_init_inode(inode, node->creds);
+	if (ret)
+		return ERR_PTR(ret);
+
 	inode->i_private = kdbus_node_ref(node);
 	inode->i_mapping->a_ops = &empty_aops;
 	inode->i_mode = node->mode & S_IALLUGO;
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
index 46f405c..1caf005 100644
--- a/security/security.c
+++ b/security/security.c
@@ -153,6 +153,55 @@ int security_binder_transfer_file(struct task_struct *from,
 	return call_int_hook(binder_transfer_file, 0, from, to, file);
 }
 
+int security_kdbus_conn_new(const struct cred *creds,
+			    const struct kdbus_creds *fake_creds,
+			    const struct kdbus_pids *fake_pids,
+			    const char *fake_seclabel,
+			    bool owner, bool privileged, bool is_activator,
+			    bool is_monitor, bool is_policy_holder)
+{
+	return call_int_hook(kdbus_conn_new, 0, creds, fake_creds, fake_pids,
+			     fake_seclabel, owner, privileged,
+			     is_activator, is_monitor, is_policy_holder);
+}
+
+int security_kdbus_own_name(const struct cred *creds, const char *name)
+{
+	return call_int_hook(kdbus_own_name, 0, creds, name);
+}
+
+int security_kdbus_conn_talk(const struct cred *creds,
+			     const struct cred *creds_peer)
+{
+	return call_int_hook(kdbus_conn_talk, 0, creds, creds_peer);
+}
+
+int security_kdbus_conn_see(const struct cred *creds,
+			    const struct cred *creds_peer)
+{
+	return call_int_hook(kdbus_conn_see, 0, creds, creds_peer);
+}
+
+int security_kdbus_conn_see_name(const struct cred *creds, const char *name)
+{
+	return call_int_hook(kdbus_conn_see_name, 0, creds, name);
+}
+
+int security_kdbus_conn_see_notification(const struct cred *creds)
+{
+	return call_int_hook(kdbus_conn_see_notification, 0, creds);
+}
+
+int security_kdbus_proc_permission(const struct cred *creds, struct pid *pid)
+{
+	return call_int_hook(kdbus_proc_permission, 0, creds, pid);
+}
+
+int security_kdbus_init_inode(struct inode *inode, const struct cred *creds)
+{
+	return call_int_hook(kdbus_init_inode, 0, inode, creds);
+}
+
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
 {
 	return call_int_hook(ptrace_access_check, 0, child, mode);
@@ -1548,6 +1597,19 @@ struct security_hook_heads security_hook_heads = {
 	.binder_transfer_file =
 		LIST_HEAD_INIT(security_hook_heads.binder_transfer_file),
 
+	.kdbus_conn_new = LIST_HEAD_INIT(security_hook_heads.kdbus_conn_new),
+	.kdbus_own_name = LIST_HEAD_INIT(security_hook_heads.kdbus_own_name),
+	.kdbus_conn_talk = LIST_HEAD_INIT(security_hook_heads.kdbus_conn_talk),
+	.kdbus_conn_see = LIST_HEAD_INIT(security_hook_heads.kdbus_conn_see),
+	.kdbus_conn_see_name =
+		LIST_HEAD_INIT(security_hook_heads.kdbus_conn_see_name),
+	.kdbus_conn_see_notification =
+		LIST_HEAD_INIT(security_hook_heads.kdbus_conn_see_notification),
+	.kdbus_proc_permission =
+		LIST_HEAD_INIT(security_hook_heads.kdbus_proc_permission),
+	.kdbus_init_inode =
+		LIST_HEAD_INIT(security_hook_heads.kdbus_init_inode),
+
 	.ptrace_access_check =
 		LIST_HEAD_INIT(security_hook_heads.ptrace_access_check),
 	.ptrace_traceme =
