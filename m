Subject: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 15:55:50 -0400
Message-Id: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Extend SELinux to allow capabilities to be granted authoritatively.
Introduces a new cap_override access vector to indicate when the
secondary module (i.e. capability or dummy) check should be skipped.
Handle the new class gracefully even if the policy does not yet have
it defined.

---

 security/selinux/hooks.c                     |   12 +++++++---
 security/selinux/include/av_perm_to_string.h |   31 +++++++++++++++++++++++++++
 security/selinux/include/av_permissions.h    |   31 +++++++++++++++++++++++++++
 security/selinux/include/class_to_string.h   |    1 
 security/selinux/include/flask.h             |    1 
 security/selinux/ss/services.c               |   11 +++------
 6 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4b0ecfd..9b200ef 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1419,11 +1419,17 @@ static void selinux_capset_set(struct task_struct *target, kernel_cap_t *effecti
 
 static int selinux_capable(struct task_struct *tsk, int cap)
 {
+	struct task_security_struct *tsec = tsk->security;
+	u32 sid = tsec->sid;
 	int rc;
 
-	rc = secondary_ops->capable(tsk, cap);
-	if (rc)
-		return rc;
+	rc = avc_has_perm_noaudit(sid, sid, SECCLASS_CAP_OVERRIDE,
+				  CAP_TO_MASK(cap), 0, NULL);
+	if (rc) {
+		rc = secondary_ops->capable(tsk, cap);
+		if (rc)
+			return rc;
+	}
 
 	return task_has_capability(tsk,cap);
 }
diff --git a/security/selinux/include/av_inherit.h b/security/selinux/include/av_inherit.h
diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index 049bf69..fc19a4d 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -159,3 +159,34 @@
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NODE_BIND, "node_bind")
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NAME_CONNECT, "name_connect")
    S_(SECCLASS_MEMPROTECT, MEMPROTECT__MMAP_ZERO, "mmap_zero")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__CHOWN, "chown")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__DAC_OVERRIDE, "dac_override")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__DAC_READ_SEARCH, "dac_read_search")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__FOWNER, "fowner")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__FSETID, "fsetid")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__KILL, "kill")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SETGID, "setgid")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SETUID, "setuid")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SETPCAP, "setpcap")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__LINUX_IMMUTABLE, "linux_immutable")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__NET_BIND_SERVICE, "net_bind_service")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__NET_BROADCAST, "net_broadcast")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__NET_ADMIN, "net_admin")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__NET_RAW, "net_raw")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__IPC_LOCK, "ipc_lock")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__IPC_OWNER, "ipc_owner")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SYS_MODULE, "sys_module")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SYS_RAWIO, "sys_rawio")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SYS_CHROOT, "sys_chroot")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SYS_PTRACE, "sys_ptrace")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SYS_PACCT, "sys_pacct")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SYS_ADMIN, "sys_admin")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SYS_BOOT, "sys_boot")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SYS_NICE, "sys_nice")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SYS_RESOURCE, "sys_resource")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SYS_TIME, "sys_time")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__SYS_TTY_CONFIG, "sys_tty_config")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__MKNOD, "mknod")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__LEASE, "lease")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__AUDIT_WRITE, "audit_write")
+   S_(SECCLASS_CAP_OVERRIDE, CAP_OVERRIDE__AUDIT_CONTROL, "audit_control")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index eda89a2..b5f01a1 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -824,3 +824,34 @@
 #define DCCP_SOCKET__NODE_BIND                    0x00400000UL
 #define DCCP_SOCKET__NAME_CONNECT                 0x00800000UL
 #define MEMPROTECT__MMAP_ZERO                     0x00000001UL
+#define CAP_OVERRIDE__CHOWN                       0x00000001UL
+#define CAP_OVERRIDE__DAC_OVERRIDE                0x00000002UL
+#define CAP_OVERRIDE__DAC_READ_SEARCH             0x00000004UL
+#define CAP_OVERRIDE__FOWNER                      0x00000008UL
+#define CAP_OVERRIDE__FSETID                      0x00000010UL
+#define CAP_OVERRIDE__KILL                        0x00000020UL
+#define CAP_OVERRIDE__SETGID                      0x00000040UL
+#define CAP_OVERRIDE__SETUID                      0x00000080UL
+#define CAP_OVERRIDE__SETPCAP                     0x00000100UL
+#define CAP_OVERRIDE__LINUX_IMMUTABLE             0x00000200UL
+#define CAP_OVERRIDE__NET_BIND_SERVICE            0x00000400UL
+#define CAP_OVERRIDE__NET_BROADCAST               0x00000800UL
+#define CAP_OVERRIDE__NET_ADMIN                   0x00001000UL
+#define CAP_OVERRIDE__NET_RAW                     0x00002000UL
+#define CAP_OVERRIDE__IPC_LOCK                    0x00004000UL
+#define CAP_OVERRIDE__IPC_OWNER                   0x00008000UL
+#define CAP_OVERRIDE__SYS_MODULE                  0x00010000UL
+#define CAP_OVERRIDE__SYS_RAWIO                   0x00020000UL
+#define CAP_OVERRIDE__SYS_CHROOT                  0x00040000UL
+#define CAP_OVERRIDE__SYS_PTRACE                  0x00080000UL
+#define CAP_OVERRIDE__SYS_PACCT                   0x00100000UL
+#define CAP_OVERRIDE__SYS_ADMIN                   0x00200000UL
+#define CAP_OVERRIDE__SYS_BOOT                    0x00400000UL
+#define CAP_OVERRIDE__SYS_NICE                    0x00800000UL
+#define CAP_OVERRIDE__SYS_RESOURCE                0x01000000UL
+#define CAP_OVERRIDE__SYS_TIME                    0x02000000UL
+#define CAP_OVERRIDE__SYS_TTY_CONFIG              0x04000000UL
+#define CAP_OVERRIDE__MKNOD                       0x08000000UL
+#define CAP_OVERRIDE__LEASE                       0x10000000UL
+#define CAP_OVERRIDE__AUDIT_WRITE                 0x20000000UL
+#define CAP_OVERRIDE__AUDIT_CONTROL               0x40000000UL
diff --git a/security/selinux/include/class_to_string.h b/security/selinux/include/class_to_string.h
index e77de0e..442a188 100644
--- a/security/selinux/include/class_to_string.h
+++ b/security/selinux/include/class_to_string.h
@@ -64,3 +64,4 @@
     S_(NULL)
     S_("dccp_socket")
     S_("memprotect")
+    S_("cap_override")
diff --git a/security/selinux/include/common_perm_to_string.h b/security/selinux/include/common_perm_to_string.h
diff --git a/security/selinux/include/flask.h b/security/selinux/include/flask.h
index a9c2b20..ab1b861 100644
--- a/security/selinux/include/flask.h
+++ b/security/selinux/include/flask.h
@@ -50,6 +50,7 @@
 #define SECCLASS_KEY                                     58
 #define SECCLASS_DCCP_SOCKET                             60
 #define SECCLASS_MEMPROTECT                              61
+#define SECCLASS_CAP_OVERRIDE                            62
 
 /*
  * Security identifier indices for initial entities
diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b5f017f..d16c809 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -305,13 +305,6 @@ static int context_struct_compute_av(struct context *scontext,
 		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
 			tclass = SECCLASS_NETLINK_SOCKET;
 
-	if (!tclass || tclass > policydb.p_classes.nprim) {
-		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
-		       tclass);
-		return -EINVAL;
-	}
-	tclass_datum = policydb.class_val_to_struct[tclass - 1];
-
 	/*
 	 * Initialize the access vectors to the default values.
 	 */
@@ -321,6 +314,9 @@ static int context_struct_compute_av(struct context *scontext,
 	avd->auditdeny = 0xffffffff;
 	avd->seqno = latest_granting;
 
+	if (!tclass || tclass > policydb.p_classes.nprim)
+		return 0;
+
 	/*
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
@@ -358,6 +354,7 @@ static int context_struct_compute_av(struct context *scontext,
 	 * Remove any permissions prohibited by a constraint (this includes
 	 * the MLS policy).
 	 */
+	tclass_datum = policydb.class_val_to_struct[tclass - 1];
 	constraint = tclass_datum->constraints;
 	while (constraint) {
 		if ((constraint->permissions & (avd->allowed)) &&

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
