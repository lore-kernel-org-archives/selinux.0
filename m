Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8NLiwhl032740
 for <selinux@tycho.nsa.gov>; Wed, 23 Sep 2015 17:44:58 -0400
Subject: [RFC PATCH v1 3/3] selinux: introduce kdbus access controls
From: Paul Moore <pmoore@redhat.com>
To: Paul Osmialowski <p.osmialowsk@samsung.com>,
 linux-security-module@vger.kernel.org,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>, selinux@tycho.nsa.gov
Date: Wed, 23 Sep 2015 17:44:25 -0400
Message-ID: <20150923214425.25616.41841.stgit@localhost>
In-Reply-To: <20150923213043.25616.43422.stgit@localhost>
References: <20150923213043.25616.43422.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add the SELinux access control implementation for the new kdbus LSM
hooks.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/hooks.c            |  121 ++++++++++++++++++++++++++++++++++-
 security/selinux/include/classmap.h |    4 +
 2 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7dade28..1257ba4 100644
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
@@ -1987,6 +1989,113 @@ static int selinux_binder_transfer_file(struct task_struct *from,
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
+
+	rc = security_kdbus_sid(name, &name_sid);
+	if (rc)
+		return rc;
+
+	return avc_has_perm(cred_sid(creds), name_sid,
+			    SECCLASS_KDBUS, KDBUS__OWN, NULL);
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
+
+	rc = security_kdbus_sid(name, &name_sid);
+	if (rc)
+		return rc;
+
+	return avc_has_perm(cred_sid(creds), name_sid,
+			    SECCLASS_KDBUS, KDBUS__SEE_NAME, NULL);
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
 static int selinux_ptrace_access_check(struct task_struct *child,
 				     unsigned int mode)
 {
@@ -5848,6 +5957,14 @@ static struct security_operations selinux_ops = {
 	.binder_transfer_binder =	selinux_binder_transfer_binder,
 	.binder_transfer_file =		selinux_binder_transfer_file,
 
+	.kdbus_conn_new =		selinux_kdbus_conn_new,
+	.kdbus_own_name =		selinux_kdbus_own_name,
+	.kdbus_conn_talk =		selinux_kdbus_conn_talk,
+	.kdbus_conn_see_name = 		selinux_kdbus_conn_see_name,
+	.kdbus_conn_see =		selinux_kdbus_conn_see,
+	.kdbus_conn_see_notification =	selinux_kdbus_conn_see_notification,
+	.kdbus_proc_permission =	selinux_kdbus_proc_permission,
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
