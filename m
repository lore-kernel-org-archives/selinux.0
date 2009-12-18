Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBIIULIR023110
	for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2009 13:30:21 -0500
Received: from g4t0017.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nBIIT8ab003222
	for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2009 18:29:08 GMT
Subject: [RFC PATCH v3] selinux: Fix security_compute_av() to not return
	unknown class errors when in permissive mode
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Cc: russell@coker.com.au, amworsley@gmail.com
Date: Fri, 18 Dec 2009 13:30:16 -0500
Message-ID: <20091218183016.9365.621.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It is possible security_compute_av() to return -EINVAL, even when in
permissive mode, due to unknown object classes and SIDs.  This patch fixes
this by doing away with the return value for security_compute_av() and
treating unknown classes and SIDs as permission denials.

NOTE: This patch has only been compile tested, and is only intended for
review.  However, if someone wants to give it a try I would appreciate it
as my time is somewhat limited since I'm technically on "vacation" as of a
few hours ago :)

Reported-by: Andrew Worsley <amworsley@gmail.com>
Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/avc.c              |   14 ++--
 security/selinux/include/security.h |    8 +-
 security/selinux/selinuxfs.c        |    4 +
 security/selinux/ss/services.c      |  113 +++++++++++++----------------------
 4 files changed, 54 insertions(+), 85 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index f2dde26..7471a0a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -731,7 +731,6 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	struct avc_node *node;
 	struct av_decision avd_entry, *avd;
 	int rc = 0;
-	u32 denied;
 
 	BUG_ON(!requested);
 
@@ -746,9 +745,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 		else
 			avd = &avd_entry;
 
-		rc = security_compute_av(ssid, tsid, tclass, requested, avd);
-		if (rc)
-			goto out;
+		security_compute_av(ssid, tsid, tclass, avd);
 		rcu_read_lock();
 		node = avc_insert(ssid, tsid, tclass, avd);
 	} else {
@@ -757,12 +754,11 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 		avd = &node->ae.avd;
 	}
 
-	denied = requested & ~(avd->allowed);
-
-	if (denied) {
+	if (requested & ~(avd->allowed)) {
 		if (flags & AVC_STRICT)
 			rc = -EACCES;
-		else if (!selinux_enforcing || (avd->flags & AVD_FLAGS_PERMISSIVE))
+		else if (!selinux_enforcing ||
+			 (avd->flags & AVD_FLAGS_PERMISSIVE))
 			avc_update_node(AVC_CALLBACK_GRANT, requested, ssid,
 					tsid, tclass, avd->seqno);
 		else
@@ -770,7 +766,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	}
 
 	rcu_read_unlock();
-out:
+
 	return rc;
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 2553266..609334d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -96,12 +96,10 @@ struct av_decision {
 /* definitions of av_decision.flags */
 #define AVD_FLAGS_PERMISSIVE	0x0001
 
-int security_compute_av(u32 ssid, u32 tsid,
-			u16 tclass, u32 requested,
-			struct av_decision *avd);
+void security_compute_av(u32 ssid, u32 tsid, u16 tclass,
+			 struct av_decision *avd);
 
-int security_compute_av_user(u32 ssid, u32 tsid,
-			     u16 tclass, u32 requested,
+int security_compute_av_user(u32 ssid, u32 tsid, u16 tclass,
 			     struct av_decision *avd);
 
 int security_transition_sid(u32 ssid, u32 tsid,
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index fab36fd..a45ac7c 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -511,6 +511,8 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	if (!tcon)
 		goto out;
 
+	/* note: we don't currently use "req" anymore but we'll leave it here
+	 *       just to preserve/enforce the existing userspace API */
 	length = -EINVAL;
 	if (sscanf(buf, "%s %s %hu %x", scon, tcon, &tclass, &req) != 4)
 		goto out2;
@@ -522,7 +524,7 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	if (length < 0)
 		goto out2;
 
-	length = security_compute_av_user(ssid, tsid, tclass, req, &avd);
+	length = security_compute_av_user(ssid, tsid, tclass, &avd);
 	if (length < 0)
 		goto out2;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b3efae2..e789b34 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -90,7 +90,6 @@ static int context_struct_to_string(struct context *context, char **scontext,
 static int context_struct_compute_av(struct context *scontext,
 				     struct context *tcontext,
 				     u16 tclass,
-				     u32 requested,
 				     struct av_decision *avd);
 
 struct selinux_mapping {
@@ -196,23 +195,6 @@ static u16 unmap_class(u16 tclass)
 	return tclass;
 }
 
-static u32 unmap_perm(u16 tclass, u32 tperm)
-{
-	if (tclass < current_mapping_size) {
-		unsigned i;
-		u32 kperm = 0;
-
-		for (i = 0; i < current_mapping[tclass].num_perms; i++)
-			if (tperm & (1<<i)) {
-				kperm |= current_mapping[tclass].perms[i];
-				tperm &= ~(1<<i);
-			}
-		return kperm;
-	}
-
-	return tperm;
-}
-
 static void map_decision(u16 tclass, struct av_decision *avd,
 			 int allow_unknown)
 {
@@ -532,7 +514,6 @@ out:
 static void type_attribute_bounds_av(struct context *scontext,
 				     struct context *tcontext,
 				     u16 tclass,
-				     u32 requested,
 				     struct av_decision *avd)
 {
 	struct context lo_scontext;
@@ -553,7 +534,6 @@ static void type_attribute_bounds_av(struct context *scontext,
 		context_struct_compute_av(&lo_scontext,
 					  tcontext,
 					  tclass,
-					  requested,
 					  &lo_avd);
 		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
 			return;		/* no masked permission */
@@ -569,7 +549,6 @@ static void type_attribute_bounds_av(struct context *scontext,
 		context_struct_compute_av(scontext,
 					  &lo_tcontext,
 					  tclass,
-					  requested,
 					  &lo_avd);
 		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
 			return;		/* no masked permission */
@@ -586,7 +565,6 @@ static void type_attribute_bounds_av(struct context *scontext,
 		context_struct_compute_av(&lo_scontext,
 					  &lo_tcontext,
 					  tclass,
-					  requested,
 					  &lo_avd);
 		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
 			return;		/* no masked permission */
@@ -610,7 +588,6 @@ static void type_attribute_bounds_av(struct context *scontext,
 static int context_struct_compute_av(struct context *scontext,
 				     struct context *tcontext,
 				     u16 tclass,
-				     u32 requested,
 				     struct av_decision *avd)
 {
 	struct constraint_node *constraint;
@@ -622,20 +599,8 @@ static int context_struct_compute_av(struct context *scontext,
 	struct ebitmap_node *snode, *tnode;
 	unsigned int i, j;
 
-	/*
-	 * Initialize the access vectors to the default values.
-	 */
-	avd->allowed = 0;
-	avd->auditallow = 0;
-	avd->auditdeny = 0xffffffff;
-	avd->seqno = latest_granting;
-	avd->flags = 0;
-
-	if (unlikely(!tclass || tclass > policydb.p_classes.nprim)) {
-		if (printk_ratelimit())
-			printk(KERN_WARNING "SELinux:  Invalid class %hu\n", tclass);
+	if (unlikely(!tclass || tclass > policydb.p_classes.nprim))
 		return -EINVAL;
-	}
 
 	tclass_datum = policydb.class_val_to_struct[tclass - 1];
 
@@ -704,8 +669,7 @@ static int context_struct_compute_av(struct context *scontext,
 	 * constraint, lazy checks have to mask any violated
 	 * permission and notice it to userspace via audit.
 	 */
-	type_attribute_bounds_av(scontext, tcontext,
-				 tclass, requested, avd);
+	type_attribute_bounds_av(scontext, tcontext, tclass, avd);
 
 	return 0;
 }
@@ -890,11 +854,11 @@ out:
 static int security_compute_av_core(u32 ssid,
 				    u32 tsid,
 				    u16 tclass,
-				    u32 requested,
+				    int allow_unknown,
 				    struct av_decision *avd)
 {
 	struct context *scontext = NULL, *tcontext = NULL;
-	int rc = 0;
+	int rc;
 
 	scontext = sidtab_search(&sidtab, ssid);
 	if (!scontext) {
@@ -909,8 +873,9 @@ static int security_compute_av_core(u32 ssid,
 		return -EINVAL;
 	}
 
-	rc = context_struct_compute_av(scontext, tcontext, tclass,
-				       requested, avd);
+	rc = context_struct_compute_av(scontext, tcontext, tclass, avd);
+	if (rc == -EINVAL && !allow_unknown && printk_ratelimit())
+		printk(KERN_WARNING "SELinux:  Invalid class %hu\n", tclass);
 
 	/* permissive domain? */
 	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
@@ -924,70 +889,78 @@ static int security_compute_av_core(u32 ssid,
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
- * @requested: requested permissions
  * @avd: access vector decisions
  *
  * Compute a set of access vector decisions based on the
  * SID pair (@ssid, @tsid) for the permissions in @tclass.
- * Return -%EINVAL if any of the parameters are invalid or %0
- * if the access vector decisions were computed successfully.
  */
-int security_compute_av(u32 ssid,
-			u32 tsid,
-			u16 orig_tclass,
-			u32 orig_requested,
-			struct av_decision *avd)
+void security_compute_av(u32 ssid,
+			 u32 tsid,
+			 u16 orig_tclass,
+			 struct av_decision *avd)
 {
 	u16 tclass;
-	u32 requested;
 	int rc;
 
 	read_lock(&policy_rwlock);
 
+	/* Initialize the access vectors to the default values. */
+	avd->allowed = 0;
+	avd->auditallow = 0;
+	avd->auditdeny = 0xffffffff;
+	avd->seqno = latest_granting;
+	avd->flags = 0;
+
 	if (!ss_initialized)
 		goto allow;
 
-	requested = unmap_perm(orig_tclass, orig_requested);
 	tclass = unmap_class(orig_tclass);
-	if (unlikely(orig_tclass && !tclass)) {
-		if (policydb.allow_unknown)
-			goto allow;
-		rc = -EINVAL;
-		goto out;
-	}
-	rc = security_compute_av_core(ssid, tsid, tclass, requested, avd);
+	if (unlikely(orig_tclass && !tclass))
+		goto error;
+	rc = security_compute_av_core(ssid, tsid, tclass,
+				      policydb.allow_unknown, avd);
+	if (unlikely(rc != 0))
+		goto error;
 	map_decision(orig_tclass, avd, policydb.allow_unknown);
 out:
 	read_unlock(&policy_rwlock);
-	return rc;
+	return;
 allow:
 	avd->allowed = 0xffffffff;
+	goto out;
+error:
+	if (policydb.allow_unknown)
+		goto allow;
+	avd->allowed = 0;
 	avd->auditallow = 0;
 	avd->auditdeny = 0xffffffff;
-	avd->seqno = latest_granting;
-	avd->flags = 0;
-	rc = 0;
 	goto out;
 }
 
 int security_compute_av_user(u32 ssid,
 			     u32 tsid,
 			     u16 tclass,
-			     u32 requested,
 			     struct av_decision *avd)
 {
 	int rc;
 
+	read_lock(&policy_rwlock);
+
+	/* Initialize the access vectors to the default values. */
+	avd->allowed = 0;
+	avd->auditallow = 0;
+	avd->auditdeny = 0xffffffff;
+	avd->seqno = latest_granting;
+	avd->flags = 0;
+
 	if (!ss_initialized) {
 		avd->allowed = 0xffffffff;
-		avd->auditallow = 0;
-		avd->auditdeny = 0xffffffff;
-		avd->seqno = latest_granting;
-		return 0;
+		rc = 0;
+		goto out;
 	}
 
-	read_lock(&policy_rwlock);
-	rc = security_compute_av_core(ssid, tsid, tclass, requested, avd);
+	rc = security_compute_av_core(ssid, tsid, tclass, 0, avd);
+out:
 	read_unlock(&policy_rwlock);
 	return rc;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
