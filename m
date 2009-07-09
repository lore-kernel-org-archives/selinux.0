Subject: [PATCH 2/3] Make lsm_priv union in lsm_audit.h anonymous
From: Thomas Liu <tliu@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: chrisw@sous-sol.org, sds@tycho.nsa.gov, eparis@parisplace.org,
        jmorris@namei.org, etienne.basset@numericable.fr,
        casey@schaufler-ca.com
Content-Type: text/plain
Date: Thu, 09 Jul 2009 10:00:30 -0400
Message-Id: <1247148030.2276.10.camel@Ares>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Made the lsm_priv union in include/linux/lsm_audit.h
anonymous.

Signed-off-by: Thomas Liu <tliu@redhat.com>
---

 include/linux/lsm_audit.h     |    2 +-
 security/smack/smack.h        |    2 +-
 security/smack/smack_access.c |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)


diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 68f7bce..40d1b84 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -86,7 +86,7 @@ struct common_audit_data {
 			struct av_decision *avd;
 			int result;
 		} selinux_audit_data;
-	} lsm_priv;
+	};
 	/* these callback will be implemented by a specific LSM */
 	void (*lsm_pre_audit)(struct audit_buffer *, void *);
 	void (*lsm_post_audit)(struct audit_buffer *, void *);
diff --git a/security/smack/smack.h b/security/smack/smack.h
index ff180ed..c6e9aca 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -275,7 +275,7 @@ static inline void smk_ad_init(struct smk_audit_info *a, const char *func,
 {
 	memset(a, 0, sizeof(*a));
 	a->a.type = type;
-	a->a.lsm_priv.smack_audit_data.function = func;
+	a->a.smack_audit_data.function = func;
 }
 
 static inline void smk_ad_setfield_u_tsk(struct smk_audit_info *a,
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index dd84877..0f9ac81 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -240,9 +240,9 @@ static inline void smack_str_from_perm(char *string, int access)
 static void smack_log_callback(struct audit_buffer *ab, void *a)
 {
 	struct common_audit_data *ad = a;
-	struct smack_audit_data *sad = &ad->lsm_priv.smack_audit_data;
+	struct smack_audit_data *sad = &ad->smack_audit_data;
 	audit_log_format(ab, "lsm=SMACK fn=%s action=%s",
-			 ad->lsm_priv.smack_audit_data.function,
+			 ad->smack_audit_data.function,
 			 sad->result ? "denied" : "granted");
 	audit_log_format(ab, " subject=");
 	audit_log_untrustedstring(ab, sad->subject);
@@ -275,11 +275,11 @@ void smack_log(char *subject_label, char *object_label, int request,
 	if (result == 0 && (log_policy & SMACK_AUDIT_ACCEPT) == 0)
 		return;
 
-	if (a->lsm_priv.smack_audit_data.function == NULL)
-		a->lsm_priv.smack_audit_data.function = "unknown";
+	if (a->smack_audit_data.function == NULL)
+		a->smack_audit_data.function = "unknown";
 
 	/* end preparing the audit data */
-	sad = &a->lsm_priv.smack_audit_data;
+	sad = &a->smack_audit_data;
 	smack_str_from_perm(request_buffer, request);
 	sad->subject = subject_label;
 	sad->object  = object_label;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
