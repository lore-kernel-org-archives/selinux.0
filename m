Subject: [RFC][PATCH] selinux: change the handling of unknown classes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, russell@coker.com.au, amworsley@gmail.com,
        Paul Moore <paul.moore@hp.com>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <20091218183016.9365.621.stgit@flek.lan>
References: <20091218183016.9365.621.stgit@flek.lan>
Content-Type: text/plain
Date: Thu, 07 Jan 2010 17:01:23 -0500
Message-Id: <1262901683.2821.141.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If allow_unknown==deny, SELinux treats an undefined kernel security
class as an error condition rather than as a typical permission denial
and thus does not allow permissions on undefined classes even when in
permissive mode.  Change the SELinux logic so that this case is handled
as a typical permission denial, subject to the usual permissive mode
logic.  This change only affects the kernel permission checking;
userspace requests for access computations will still return errors upon
invalid classes, since the userspace AVC handles mapping of classes and
permissions for userspace object managers.

Also drop the 'requested' argument from security_compute_av() and
helpers as it is a legacy of the original security server interface and
is unused.

Based in part on a patch by Paul Moore <paul.moore@hp.com>.

Reported-by: Andrew Worsley <amworsley@gmail.com>
Signed-off-by: Stephen D. Smalley <sds@tycho.nsa.gov>

---

 security/selinux/avc.c              |    5 --
 security/selinux/include/security.h |    8 +---
 security/selinux/selinuxfs.c        |    5 +-
 security/selinux/ss/services.c      |   63 ++++++++----------------------------
 4 files changed, 21 insertions(+), 60 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index f2dde26..3ee9b6a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -746,9 +746,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 		else
 			avd = &avd_entry;
 
-		rc = security_compute_av(ssid, tsid, tclass, requested, avd);
-		if (rc)
-			goto out;
+		security_compute_av(ssid, tsid, tclass, avd);
 		rcu_read_lock();
 		node = avc_insert(ssid, tsid, tclass, avd);
 	} else {
@@ -770,7 +768,6 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	}
 
 	rcu_read_unlock();
-out:
 	return rc;
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 2553266..2917189 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -96,13 +96,11 @@ struct av_decision {
 /* definitions of av_decision.flags */
 #define AVD_FLAGS_PERMISSIVE	0x0001
 
-int security_compute_av(u32 ssid, u32 tsid,
-			u16 tclass, u32 requested,
-			struct av_decision *avd);
+void security_compute_av(u32 ssid, u32 tsid,
+			 u16 tclass, struct av_decision *avd);
 
 int security_compute_av_user(u32 ssid, u32 tsid,
-			     u16 tclass, u32 requested,
-			     struct av_decision *avd);
+			     u16 tclass, struct av_decision *avd);
 
 int security_transition_sid(u32 ssid, u32 tsid,
 			    u16 tclass, u32 *out_sid);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index fab36fd..d69982b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -494,7 +494,6 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	char *scon, *tcon;
 	u32 ssid, tsid;
 	u16 tclass;
-	u32 req;
 	struct av_decision avd;
 	ssize_t length;
 
@@ -512,7 +511,7 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 		goto out;
 
 	length = -EINVAL;
-	if (sscanf(buf, "%s %s %hu %x", scon, tcon, &tclass, &req) != 4)
+	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
 		goto out2;
 
 	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
@@ -522,7 +521,7 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	if (length < 0)
 		goto out2;
 
-	length = security_compute_av_user(ssid, tsid, tclass, req, &avd);
+	length = security_compute_av_user(ssid, tsid, tclass, &avd);
 	if (length < 0)
 		goto out2;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 07ddc81..1f77ce4 100644
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
@@ -705,7 +682,7 @@ static int context_struct_compute_av(struct context *scontext,
 	 * permission and notice it to userspace via audit.
 	 */
 	type_attribute_bounds_av(scontext, tcontext,
-				 tclass, requested, avd);
+				 tclass, avd);
 
 	return 0;
 }
@@ -890,7 +867,6 @@ out:
 static int security_compute_av_core(u32 ssid,
 				    u32 tsid,
 				    u16 tclass,
-				    u32 requested,
 				    struct av_decision *avd)
 {
 	struct context *scontext = NULL, *tcontext = NULL;
@@ -909,8 +885,7 @@ static int security_compute_av_core(u32 ssid,
 		return -EINVAL;
 	}
 
-	rc = context_struct_compute_av(scontext, tcontext, tclass,
-				       requested, avd);
+	rc = context_struct_compute_av(scontext, tcontext, tclass, avd);
 
 	/* permissive domain? */
 	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
@@ -924,56 +899,48 @@ static int security_compute_av_core(u32 ssid,
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
-	int rc;
 
 	read_lock(&policy_rwlock);
 
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
 	if (unlikely(orig_tclass && !tclass)) {
 		if (policydb.allow_unknown)
 			goto allow;
-		rc = -EINVAL;
 		goto out;
 	}
-	rc = security_compute_av_core(ssid, tsid, tclass, requested, avd);
+	(void) security_compute_av_core(ssid, tsid, tclass, avd);
 	map_decision(orig_tclass, avd, policydb.allow_unknown);
 out:
 	read_unlock(&policy_rwlock);
-	return rc;
+	return;
 allow:
 	avd->allowed = 0xffffffff;
-	avd->auditallow = 0;
-	avd->auditdeny = 0xffffffff;
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
@@ -987,7 +954,7 @@ int security_compute_av_user(u32 ssid,
 	}
 
 	read_lock(&policy_rwlock);
-	rc = security_compute_av_core(ssid, tsid, tclass, requested, avd);
+	rc = security_compute_av_core(ssid, tsid, tclass, avd);
 	read_unlock(&policy_rwlock);
 	return rc;
 }


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
