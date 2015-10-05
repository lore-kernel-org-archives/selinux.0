Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t95Kg7pH000880
 for <selinux@tycho.nsa.gov>; Mon, 5 Oct 2015 16:42:08 -0400
Subject: [RFC PATCH v2 5/5] selinux: introduce kdbus access controls
From: Paul Moore <pmoore@redhat.com>
To: linux-security-module@vger.kernel.org
Cc: linux-audit@redhat.com, selinux@tycho.nsa.gov
Date: Mon, 05 Oct 2015 16:41:37 -0400
Message-ID: <20151005204137.32023.7198.stgit@localhost>
In-Reply-To: <20151005203358.32023.88592.stgit@localhost>
References: <20151005203358.32023.88592.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add the SELinux access control implementation for the new kdbus LSM
hooks using the new kdbus object class and the following permissions:

 [NOTE: permissions below are based on kdbus code from Aug 2015]

 * kdbus:impersonate
   Send a different security label to kdbus peers.
 * kdbus:fakecreds
   Send different DAC credentials to kdbus peers.
 * kdbus:fakepids
   Send a different PID to kdbus peers.
 * kdbus:owner
   Act as a kdbus bus owner.
 * kdbus:privileged
   Act as a privileged endpoint.
 * kdbus:activator
   Act as a kdbus activator.
 * kdbus:monitor
   Act as a kdbus monitor.
 * kdbus:policy_holder
   Act as a kdbus policy holder.
 * kdbus:connect
   Create a new kdbus connection.
 * kdbus:own
   Own a kdbus service name.
 * kdbus:talk
   Talk between two kdbus endpoints.
 * kdbus:see
   See another kdbus endpoint.
 * kdbus:see_name
   See a kdbus service name.
 * kdbus:see_notification
   See a kdbus notification.

Signed-off-by: Paul Moore <pmoore@redhat.com>

---
ChangeLog:
- v2
 * Add the selinux_kdbus_init_inode() hook
 * Add some very basic info on the permissions to the description
 * Add kdbus service name auditing in the AVC records
- v1
 * Initial draft
---
 security/selinux/hooks.c            |  152 +++++++++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |    4 +
 2 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4d7e602..29341dd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -9,8 +9,10 @@
  *	      James Morris <jmorris@redhat.com>
  *
  *  Copyright (C) 2001,2002 Networks Associates Technology, Inc.
- *  Copyright (C) 2003-2008 Red Hat, Inc., James Morris <jmorris@redhat.com>
- *					   Eric Paris <eparis@redhat.com>
+ *  Copyright (C) 2003-2008,2015 Red Hat, Inc.
+ *					James Morris <jmorris@redhat.com>
+ *					Eric Paris <eparis@redhat.com>
+ *					Paul Moore <paul@paul-moore.com>
  *  Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  *			    <dgoeddel@trustedcs.com>
  *  Copyright (C) 2006, 2007, 2009 Hewlett-Packard Development Company, L.P.
@@ -1987,6 +1989,143 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 			    &ad);
 }
 
+static int selinux_kdbus_conn_new(const struct cred *creds,
+				  const struct kdbus_creds *fake_creds,
+				  const struct kdbus_pids *fake_pids,
+				  const char *fake_seclabel,
+				  bool owner, bool privileged,
+				  bool is_activator, bool is_monitor,
+				  bool is_policy_holder)
+{
+	int rc;
+	u32 tsid = current_sid();
+	u32 av = KDBUS__CONNECT;
+
+	if (fake_creds)
+		av |= KDBUS__FAKECREDS;
+	if (fake_pids)
+		av |= KDBUS__FAKEPIDS;
+	if (owner)
+		av |= KDBUS__OWNER;
+	if (privileged)
+		av |= KDBUS__PRIVILEGED;
+	if (is_activator)
+		av |= KDBUS__ACTIVATOR;
+	if (is_monitor)
+		av |= KDBUS__MONITOR;
+	if (is_policy_holder)
+		av |= KDBUS__POLICY_HOLDER;
+
+	rc = avc_has_perm(tsid, cred_sid(creds), SECCLASS_KDBUS, av, NULL);
+	if (rc)
+		return rc;
+
+	if (fake_seclabel) {
+		u32 sid;
+		if (security_context_to_sid(fake_seclabel,
+					    strlen(fake_seclabel),
+					    &sid, GFP_KERNEL))
+			return -EINVAL;
+
+		rc = avc_has_perm(tsid, sid,
+				  SECCLASS_KDBUS, KDBUS__IMPERSONATE, NULL);
+	}
+
+	return rc;
+}
+
+static int selinux_kdbus_own_name(const struct cred *creds, const char *name)
+{
+	int rc;
+	u32 name_sid;
+	struct common_audit_data ad;
+
+	rc = security_kdbus_sid(name, &name_sid);
+	if (rc)
+		return rc;
+
+	ad.type = LSM_AUDIT_DATA_KDBUS;
+	ad.u.kdbus_name = name;
+
+	return avc_has_perm(cred_sid(creds), name_sid,
+			    SECCLASS_KDBUS, KDBUS__OWN, &ad);
+}
+
+static int selinux_kdbus_conn_talk(const struct cred *creds,
+				   const struct cred *creds_to)
+{
+	return avc_has_perm(cred_sid(creds), cred_sid(creds_to),
+			    SECCLASS_KDBUS, KDBUS__TALK, NULL);
+}
+
+static int selinux_kdbus_conn_see(const struct cred *creds,
+				  const struct cred *creds_whom)
+{
+	return avc_has_perm(cred_sid(creds), cred_sid(creds_whom),
+			    SECCLASS_KDBUS, KDBUS__SEE, NULL);
+}
+
+static int selinux_kdbus_conn_see_name(const struct cred *creds,
+				       const char *name)
+{
+	int rc;
+	u32 name_sid;
+	struct common_audit_data ad;
+
+	rc = security_kdbus_sid(name, &name_sid);
+	if (rc)
+		return rc;
+
+	ad.type = LSM_AUDIT_DATA_KDBUS;
+	ad.u.kdbus_name = name;
+
+	return avc_has_perm(cred_sid(creds), name_sid,
+			    SECCLASS_KDBUS, KDBUS__SEE_NAME, &ad);
+}
+
+static int selinux_kdbus_conn_see_notification(const struct cred *creds)
+{
+	return avc_has_perm(SECINITSID_KERNEL, cred_sid(creds),
+			    SECCLASS_KDBUS, KDBUS__SEE_NOTIFICATION, NULL);
+}
+
+static int selinux_kdbus_proc_permission(const struct cred *creds,
+					 struct pid *pid)
+{
+	int rc;
+	struct task_struct *task;
+
+	rcu_read_lock();
+	task = pid_task(pid, PIDTYPE_PID);
+	rc = avc_has_perm(cred_sid(creds), task_sid(task),
+			  SECCLASS_PROCESS, PROCESS__GETATTR, NULL);
+	rcu_read_unlock();
+
+	return rc;
+}
+
+static int selinux_kdbus_init_inode(struct inode *inode,
+				    const struct cred *creds)
+{
+	struct inode_security_struct *isec = inode->i_security;
+	u32 sid = cred_sid(creds);
+
+	/* XXX - this is very simple, e.g. no transitions, no special object
+	 *       class, etc. since this inode is basically an IPC socket ...
+	 *       however, is this too simple?  do we want transitions?  if we
+	 *       do, we should do the transition in kdbus_node_init() and not
+	 *       here so that endpoint is labeled correctly and not just this
+	 *       inode */
+
+	isec->inode = inode;
+	isec->task_sid = sid;
+	isec->sid = sid;
+	isec->sclass = SECCLASS_FILE;
+	isec->initialized = 1;
+
+	return 0;
+}
+
 static int selinux_ptrace_access_check(struct task_struct *child,
 				     unsigned int mode)
 {
@@ -5888,6 +6027,15 @@ static struct security_operations selinux_ops = {
 	.binder_transfer_binder =	selinux_binder_transfer_binder,
 	.binder_transfer_file =		selinux_binder_transfer_file,
 
+	.kdbus_conn_new =		selinux_kdbus_conn_new,
+	.kdbus_own_name =		selinux_kdbus_own_name,
+	.kdbus_conn_talk =		selinux_kdbus_conn_talk,
+	.kdbus_conn_see_name = 		selinux_kdbus_conn_see_name,
+	.kdbus_conn_see =		selinux_kdbus_conn_see,
+	.kdbus_conn_see_notification =	selinux_kdbus_conn_see_notification,
+	.kdbus_proc_permission =	selinux_kdbus_proc_permission,
+	.kdbus_init_inode =		selinux_kdbus_init_inode,
+
 	.ptrace_access_check =		selinux_ptrace_access_check,
 	.ptrace_traceme =		selinux_ptrace_traceme,
 	.capget =			selinux_capget,
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index eccd61b..31e4435 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -153,5 +153,9 @@ struct security_class_mapping secclass_map[] = {
 	  { COMMON_SOCK_PERMS, "attach_queue", NULL } },
 	{ "binder", { "impersonate", "call", "set_context_mgr", "transfer",
 		      NULL } },
+	{ "kdbus", { "impersonate", "fakecreds", "fakepids", "owner",
+		     "privileged", "activator", "monitor", "policy_holder",
+		     "connect", "own", "talk", "see", "see_name",
+		     "see_notification" } },
 	{ NULL }
   };
