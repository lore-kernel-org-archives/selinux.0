Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5KINhuD004790
	for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2006 14:23:43 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5KINg9b028769
	for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2006 18:23:42 GMT
Message-ID: <44983D2A.6040706@trustedcs.com>
Date: Tue, 20 Jun 2006 13:23:38 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH 02/06] MLSXFRM: Define new SELinux service routine
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This defines a routine that combines the Type Enforcement portion of one sid
with the MLS portion from the other sid to arrive at a new sid. This is currently
used to define a sid for a security association that is to be negotiated by IKE.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---

 security/selinux/include/security.h |    2 +
 security/selinux/ss/mls.c           |   20 ----------
 security/selinux/ss/mls.h           |   20 ++++++++++
 security/selinux/ss/services.c      |   48 ++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 20 deletions(-)


--- linux-2.6.16.vanilla/security/selinux/ss/mls.c	2006-06-12 17:38:25.000000000 -0500
+++ linux-2.6.16/security/selinux/ss/mls.c	2006-06-19 19:48:24.000000000 -0500
@@ -212,26 +212,6 @@ int mls_context_isvalid(struct policydb 
 }
 
 /*
- * Copies the MLS range from `src' into `dst'.
- */
-static inline int mls_copy_context(struct context *dst,
-				   struct context *src)
-{
-	int l, rc = 0;
-
-	/* Copy the MLS range from the source context */
-	for (l = 0; l < 2; l++) {
-		dst->range.level[l].sens = src->range.level[l].sens;
-		rc = ebitmap_cpy(&dst->range.level[l].cat,
-				 &src->range.level[l].cat);
-		if (rc)
-			break;
-	}
-
-	return rc;
-}
-
-/*
  * Set the MLS fields in the security context structure
  * `context' based on the string representation in
  * the string `*scontext'.  Update `*scontext' to
--- linux-2.6.16.vanilla/security/selinux/ss/mls.h	2006-06-12 17:38:25.000000000 -0500
+++ linux-2.6.16/security/selinux/ss/mls.h	2006-06-19 19:48:24.000000000 -0500
@@ -17,6 +17,26 @@
 #include "context.h"
 #include "policydb.h"
 
+/*
+ * Copies the MLS range from `src' into `dst'.
+ */
+static inline int mls_copy_context(struct context *dst,
+				   struct context *src)
+{
+	int l, rc = 0;
+
+	/* Copy the MLS range from the source context */
+	for (l = 0; l < 2; l++) {
+		dst->range.level[l].sens = src->range.level[l].sens;
+		rc = ebitmap_cpy(&dst->range.level[l].cat,
+				 &src->range.level[l].cat);
+		if (rc)
+			break;
+	}
+
+	return rc;
+}
+
 int mls_compute_context_len(struct context *context);
 void mls_sid_to_context(struct context *context, char **scontext);
 int mls_context_isvalid(struct policydb *p, struct context *c);
--- linux-2.6.16.vanilla/security/selinux/ss/services.c	2006-06-12 17:49:44.000000000 -0500
+++ linux-2.6.16/security/selinux/ss/services.c	2006-06-19 19:48:24.000000000 -0500
@@ -1817,6 +1817,54 @@ out:
 	return rc;
 }
 
+/*
+ * security_sid_mls_copy() - computes a new sid based on the given
+ * sid and the mls portion of mls_sid.
+ */
+int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
+{
+	struct context *context1 = NULL;
+	struct context *context2 = NULL;
+	struct context newcon;
+	int rc = 0;
+
+	if (!ss_initialized) {
+		*new_sid = sid;
+		goto out;
+	}
+
+	POLICY_RDLOCK;
+	context1 = sidtab_search(&sidtab, sid);
+	if (!context1) {
+		printk(KERN_ERR "security_sid_mls_copy:  unrecognized SID "
+		       "%d\n", sid);
+		rc = -EINVAL;
+		goto out_unlock;
+	}
+
+	context2 = sidtab_search(&sidtab, mls_sid);
+	if (!context2) {
+		printk(KERN_ERR "security_sid_mls_copy:  unrecognized SID "
+		       "%d\n", mls_sid);
+		rc = -EINVAL;
+		goto out_unlock;
+	}
+
+	newcon.user = context1->user;
+	newcon.role = context1->role;
+	newcon.type = context1->type;
+	rc = mls_copy_context(&newcon, context2);
+	if (rc)
+		goto out_unlock;
+
+	rc = sidtab_context_to_sid(&sidtab, &newcon, new_sid);
+
+out_unlock:
+	POLICY_RDUNLOCK;
+out:
+	return rc;
+}
+
 struct selinux_audit_rule {
 	u32 au_seqno;
 	struct context au_ctxt;
--- linux-2.6.16.vanilla/security/selinux/include/security.h	2006-06-12 17:38:25.000000000 -0500
+++ linux-2.6.16/security/selinux/include/security.h	2006-06-19 19:48:24.000000000 -0500
@@ -78,6 +78,8 @@ int security_node_sid(u16 domain, void *
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
                                  u16 tclass);
 
+int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
+
 #define SECURITY_FS_USE_XATTR		1 /* use xattr */
 #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
 #define SECURITY_FS_USE_TASK		3 /* use task SIDs, e.g. pipefs/sockfs */

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
