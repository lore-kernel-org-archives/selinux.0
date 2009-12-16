Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBGMA7KQ019367
	for <selinux@tycho.nsa.gov>; Wed, 16 Dec 2009 17:10:07 -0500
Received: from g5t0007.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nBGM8t89029429
	for <selinux@tycho.nsa.gov>; Wed, 16 Dec 2009 22:08:55 GMT
Subject: [RFC PATCH v2] selinux: Fix security_compute_av() to not return
	unknown class errors when in permissive mode
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Cc: russell@coker.com.au, amworsley@gmail.com
Date: Wed, 16 Dec 2009 17:10:02 -0500
Message-ID: <20091216221002.10808.67004.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It is possible security_compute_av() to return -EINVAL, even when in
permissive mode, due to unknown object classes and SIDs.  This patch fixes
this by doing away with the return value for security_compute_av() and
treating unknown classes and SIDs as permission denials.

NOTE: I've only tested this on Fedora/Rawhide using the standard policy,
so while I'm fairly confident there are no regressions in the common case
the error case hasn't been fully tested yet; I'm posting this to solicit
comments on the basic approach.

Reported-by: Andrew Worsley <amworsley@gmail.com>
Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/avc.c              |   11 +++--------
 security/selinux/include/security.h |    6 +++---
 security/selinux/ss/services.c      |   27 ++++++++++++++-------------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index f2dde26..648a263 100644
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
+		security_compute_av(ssid, tsid, tclass, requested, avd);
 		rcu_read_lock();
 		node = avc_insert(ssid, tsid, tclass, avd);
 	} else {
@@ -757,9 +754,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 		avd = &node->ae.avd;
 	}
 
-	denied = requested & ~(avd->allowed);
-
-	if (denied) {
+	if (requested & ~(avd->allowed)) {
 		if (flags & AVC_STRICT)
 			rc = -EACCES;
 		else if (!selinux_enforcing || (avd->flags & AVD_FLAGS_PERMISSIVE))
@@ -770,7 +765,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	}
 
 	rcu_read_unlock();
-out:
+
 	return rc;
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 2553266..7dab870 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -96,9 +96,9 @@ struct av_decision {
 /* definitions of av_decision.flags */
 #define AVD_FLAGS_PERMISSIVE	0x0001
 
-int security_compute_av(u32 ssid, u32 tsid,
-			u16 tclass, u32 requested,
-			struct av_decision *avd);
+void security_compute_av(u32 ssid, u32 tsid,
+			 u16 tclass, u32 requested,
+			 struct av_decision *avd);
 
 int security_compute_av_user(u32 ssid, u32 tsid,
 			     u16 tclass, u32 requested,
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b3efae2..6e4904d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -632,7 +632,7 @@ static int context_struct_compute_av(struct context *scontext,
 	avd->flags = 0;
 
 	if (unlikely(!tclass || tclass > policydb.p_classes.nprim)) {
-		if (printk_ratelimit())
+		if (!policydb.allow_unknown && printk_ratelimit())
 			printk(KERN_WARNING "SELinux:  Invalid class %hu\n", tclass);
 		return -EINVAL;
 	}
@@ -929,14 +929,12 @@ static int security_compute_av_core(u32 ssid,
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
+			 u32 orig_requested,
+			 struct av_decision *avd)
 {
 	u16 tclass;
 	u32 requested;
@@ -949,24 +947,27 @@ int security_compute_av(u32 ssid,
 
 	requested = unmap_perm(orig_tclass, orig_requested);
 	tclass = unmap_class(orig_tclass);
-	if (unlikely(orig_tclass && !tclass)) {
+	rc = security_compute_av_core(ssid, tsid, tclass, requested, avd);
+	if (unlikely(rc != 0)) {
 		if (policydb.allow_unknown)
 			goto allow;
-		rc = -EINVAL;
+		avd->allowed = 0;
+		avd->auditallow = 0;
+		avd->auditdeny = 0xffffffff;
+		avd->seqno = latest_granting;
+		/* preserve any avd->flags from security_compute_av_core() */
 		goto out;
 	}
-	rc = security_compute_av_core(ssid, tsid, tclass, requested, avd);
 	map_decision(orig_tclass, avd, policydb.allow_unknown);
 out:
 	read_unlock(&policy_rwlock);
-	return rc;
+	return;
 allow:
 	avd->allowed = 0xffffffff;
 	avd->auditallow = 0;
 	avd->auditdeny = 0xffffffff;
 	avd->seqno = latest_granting;
 	avd->flags = 0;
-	rc = 0;
 	goto out;
 }
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
