Subject: [PATCH 1/3] Move variable function in lsm_audit.h into SMACK
 private space
From: Thomas Liu <tliu@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: chrisw@sous-sol.org, sds@tycho.nsa.gov, jmorris@namei.org,
        eparis@parisplace.org, casey@schaufler-ca.com,
        etienne.basset@numericable.fr
Content-Type: text/plain
Date: Thu, 09 Jul 2009 10:00:29 -0400
Message-Id: <1247148029.2276.9.camel@Ares>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Moved variable function in include/linux/lsm_audit.h into the
smack_audit_data struct since it is never used outside of it.

Also removed setting of function in the COMMON_AUDIT_DATA_INIT
macro because that variable is now private to SMACK.

Signed-off-by: Thomas Liu <tliu@redhat.com>
---

 include/linux/lsm_audit.h     |    4 ++--
 security/smack/smack.h        |    2 +-
 security/smack/smack_access.c |    7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)


diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index e461b2c..68f7bce 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -66,11 +66,11 @@ struct common_audit_data {
 		} key_struct;
 #endif
 	} u;
-	const char *function;
 	/* this union contains LSM specific data */
 	union {
 		/* SMACK data */
 		struct smack_audit_data {
+			const char *function;
 			char *subject;
 			char *object;
 			char *request;
@@ -104,7 +104,7 @@ int ipv6_skb_to_auditdata(struct sk_buff *skb,
 /* Initialize an LSM audit data structure. */
 #define COMMON_AUDIT_DATA_INIT(_d, _t) \
 	{ memset((_d), 0, sizeof(struct common_audit_data)); \
-	 (_d)->type = LSM_AUDIT_DATA_##_t; (_d)->function = __func__; }
+	 (_d)->type = LSM_AUDIT_DATA_##_t; }
 
 void common_lsm_audit(struct common_audit_data *a);
 
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 243bec1..ff180ed 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -275,7 +275,7 @@ static inline void smk_ad_init(struct smk_audit_info *a, const char *func,
 {
 	memset(a, 0, sizeof(*a));
 	a->a.type = type;
-	a->a.function = func;
+	a->a.lsm_priv.smack_audit_data.function = func;
 }
 
 static inline void smk_ad_setfield_u_tsk(struct smk_audit_info *a,
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 513dc1a..dd84877 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -241,7 +241,8 @@ static void smack_log_callback(struct audit_buffer *ab, void *a)
 {
 	struct common_audit_data *ad = a;
 	struct smack_audit_data *sad = &ad->lsm_priv.smack_audit_data;
-	audit_log_format(ab, "lsm=SMACK fn=%s action=%s", ad->function,
+	audit_log_format(ab, "lsm=SMACK fn=%s action=%s",
+			 ad->lsm_priv.smack_audit_data.function,
 			 sad->result ? "denied" : "granted");
 	audit_log_format(ab, " subject=");
 	audit_log_untrustedstring(ab, sad->subject);
@@ -274,8 +275,8 @@ void smack_log(char *subject_label, char *object_label, int request,
 	if (result == 0 && (log_policy & SMACK_AUDIT_ACCEPT) == 0)
 		return;
 
-	if (a->function == NULL)
-		a->function = "unknown";
+	if (a->lsm_priv.smack_audit_data.function == NULL)
+		a->lsm_priv.smack_audit_data.function = "unknown";
 
 	/* end preparing the audit data */
 	sad = &a->lsm_priv.smack_audit_data;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
