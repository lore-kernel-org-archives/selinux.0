From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: apply a different permission to ptrace a child vs
	non-child
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov
Date: Fri, 30 Mar 2012 16:13:34 -0400
Message-ID: <20120330201334.23363.14917.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Some applications, like gdb, are able to ptrace both children or other
completely unrelated tasks.  We would like to be able to discern these two
things and to be able to allow gdb to ptrace it's children, but not to be
able to ptrace unrelated tasks for security reasons.

This patch implements a new permission ptrace_child which is checked
INSTEAD of ptrace if and ONLY if the ptrace_child policy capability is
enabled.  We need a seperate policy cap because we are actually reducing
the scope of ptrace.  If we used the default unknown permission handler we
would run into trouble as new kernel with old policy would be weaker than
old kernel with old policy.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c            |   38 +++++++++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |    2 +-
 security/selinux/include/security.h |    2 ++
 security/selinux/selinuxfs.c        |    3 ++-
 security/selinux/ss/services.c      |    3 +++
 5 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ba74635..5cee787 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1805,6 +1805,39 @@ static inline u32 open_file_to_av(struct file *file)
 
 /* Hook functions begin here. */
 
+/**
+ * task_is_descendant - walk up a process family tree looking for a match
+ * @parent: the process to compare against while walking up from child
+ * @child: the process to start from while looking upwards for parent
+ *
+ * Returns 1 if child is a descendant of parent, 0 if not.
+ */
+static int task_is_descendant(struct task_struct *parent,
+			      struct task_struct *child)
+{
+	int rc = 0;
+	struct task_struct *walker = child;
+
+	if (!parent || !child)
+		return 0;
+
+	rcu_read_lock();
+	if (!thread_group_leader(parent))
+		parent = rcu_dereference(parent->group_leader);
+	while (walker->pid > 0) {
+		if (!thread_group_leader(walker))
+			walker = rcu_dereference(walker->group_leader);
+		if (walker == parent) {
+			rc = 1;
+			break;
+		}
+		walker = rcu_dereference(walker->real_parent);
+	}
+	rcu_read_unlock();
+
+	return rc;
+}
+
 static int selinux_ptrace_access_check(struct task_struct *child,
 				     unsigned int mode)
 {
@@ -1820,6 +1853,9 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 		return avc_has_perm(sid, csid, SECCLASS_FILE, FILE__READ, NULL);
 	}
 
+
+	if (selinux_policycap_ptrace_child && task_is_descendant(current, child))
+		return current_has_perm(child, PROCESS__PTRACE_CHILD);
 	return current_has_perm(child, PROCESS__PTRACE);
 }
 
@@ -1831,6 +1867,8 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 	if (rc)
 		return rc;
 
+	if (selinux_policycap_ptrace_child && task_is_descendant(parent, current))
+		return task_has_perm(parent, current, PROCESS__PTRACE_CHILD);
 	return task_has_perm(parent, current, PROCESS__PTRACE);
 }
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 39e678c..72c08b9 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -29,7 +29,7 @@ struct security_class_mapping secclass_map[] = {
 	    "getattr", "setexec", "setfscreate", "noatsecure", "siginh",
 	    "setrlimit", "rlimitinh", "dyntransition", "setcurrent",
 	    "execmem", "execstack", "execheap", "setkeycreate",
-	    "setsockcreate", NULL } },
+	    "setsockcreate", "ptrace_child", NULL } },
 	{ "system",
 	  { "ipc_info", "syslog_read", "syslog_mod",
 	    "syslog_console", "module_request", NULL } },
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index dde2005..ac14b0a 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -68,12 +68,14 @@ extern int selinux_enabled;
 enum {
 	POLICYDB_CAPABILITY_NETPEER,
 	POLICYDB_CAPABILITY_OPENPERM,
+	POLICYDB_CAPABILITY_PTRACE_CHILD,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
 
 extern int selinux_policycap_netpeer;
 extern int selinux_policycap_openperm;
+extern int selinux_policycap_ptrace_child;
 
 /*
  * type_datum properties
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 9666f7b..92e311d 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -44,7 +44,8 @@
 /* Policy capability filenames */
 static char *policycap_names[] = {
 	"network_peer_controls",
-	"open_perms"
+	"open_perms",
+	"ptrace_child",
 };
 
 unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 9b7e7ed..4d12a6e 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -72,6 +72,7 @@
 
 int selinux_policycap_netpeer;
 int selinux_policycap_openperm;
+int selinux_policycap_ptrace_child;
 
 static DEFINE_RWLOCK(policy_rwlock);
 
@@ -1812,6 +1813,8 @@ static void security_load_policycaps(void)
 						  POLICYDB_CAPABILITY_NETPEER);
 	selinux_policycap_openperm = ebitmap_get_bit(&policydb.policycaps,
 						  POLICYDB_CAPABILITY_OPENPERM);
+	selinux_policycap_ptrace_child = ebitmap_get_bit(&policydb.policycaps,
+						  POLICYDB_CAPABILITY_PTRACE_CHILD);
 }
 
 static int security_preserve_bools(struct policydb *p);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
