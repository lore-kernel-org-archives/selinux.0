Subject: Dealing with 64-bit capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 11:41:04 -0400
Message-Id: <1192549264.8702.113.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Given that Serge has put out a RFC patch on lsm and lkml for extending
capabilities to 64 bits, we should likely finalize how we want to handle
them in SELinux.

Extending the access vector to 64-bits isn't a good idea IMHO, as it
will waste quite a bit of space throughout the AVC and the security
server policydb.

In the past we've talked about introducing a second capability class and
access vector for the higher 32 capabilities, and optionally providing
syntactic sugar in checkpolicy so the user doesn't have to think about
it as two separate classes.

Possible kernel patch below to define the new class and change
task_has_capability to use it for the higher capabilities.  Comments?


diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0753b20..2e2f6f8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1043,6 +1045,9 @@ static int task_has_capability(struct task_struct *tsk,
 {
 	struct task_security_struct *tsec;
 	struct avc_audit_data ad;
+	kernel_cap_t mask = CAP_TO_MASK(cap);
+	u16 sclass;
+	u32 av;	
 
 	tsec = tsk->security;
 
@@ -1050,8 +1055,14 @@ static int task_has_capability(struct task_struct *tsk,
 	ad.tsk = tsk;
 	ad.u.cap = cap;
 
-	return avc_has_perm(tsec->sid, tsec->sid,
-			    SECCLASS_CAPABILITY, CAP_TO_MASK(cap), &ad);
+	if (cap < 32) {
+		sclass = SECCLASS_CAPABILITY;
+		av = mask;
+	} else {
+		sclass = SECCLASS_CAPABILITY2;
+		av = mask >> 32;
+	}
+	return avc_has_perm(tsec->sid, tsec->sid, sclass, av, &ad);
 }
 
 /* Check whether a task is allowed to use a system operation. */
diff --git a/security/selinux/include/class_to_string.h b/security/selinux/include/class_to_string.h
index e77de0e..30d5cf6 100644
--- a/security/selinux/include/class_to_string.h
+++ b/security/selinux/include/class_to_string.h
@@ -64,3 +64,10 @@
     S_(NULL)
     S_("dccp_socket")
     S_("memprotect")
+    S_(NULL)
+    S_(NULL)
+    S_(NULL)
+    S_(NULL)
+    S_(NULL)
+    S_(NULL)
+    S_("capability2")
diff --git a/security/selinux/include/flask.h b/security/selinux/include/flask.h
index a9c2b20..a19c166 100644
--- a/security/selinux/include/flask.h
+++ b/security/selinux/include/flask.h
@@ -50,6 +50,7 @@
 #define SECCLASS_KEY                                     58
 #define SECCLASS_DCCP_SOCKET                             60
 #define SECCLASS_MEMPROTECT                              61
+#define SECCLASS_CAPABILITY2                             68
 
 /*
  * Security identifier indices for initial entities

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
