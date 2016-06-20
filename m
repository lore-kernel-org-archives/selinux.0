From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: brindle@quarksecurity.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol: rewrite sepol_string_to_security_class to use
 hashtab_search
Date: Mon, 20 Jun 2016 16:35:46 -0400
Message-Id: <1466454946-5713-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/services.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 665fcaa..d2b80b4 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1152,22 +1152,16 @@ int hidden sepol_compute_av(sepol_security_id_t ssid,
 int hidden sepol_string_to_security_class(const char *class_name,
 			sepol_security_class_t *tclass)
 {
-	char *class = NULL;
-	sepol_security_class_t id;
-
-	for (id = 1; id <= policydb->p_classes.nprim; id++) {
-		class = policydb->p_class_val_to_name[id - 1];
-		if (class == NULL) {
-			ERR(NULL, "could not convert %s to class id", class_name);
-			return STATUS_ERR;
-		}
-		if ((strcmp(class, class_name)) == 0) {
-			*tclass = id;
-			return STATUS_SUCCESS;
-		}
+	class_datum_t *tclass_datum;
+
+	tclass_datum = hashtab_search(policydb->p_classes.table,
+				      (hashtab_key_t) class_name);
+	if (!tclass_datum) {
+		ERR(NULL, "unrecognized class %s", class_name);
+		return STATUS_ERR;
 	}
-	ERR(NULL, "unrecognized class %s", class_name);
-	return -EINVAL;
+	*tclass = tclass_datum->s.value;
+	return STATUS_SUCCESS;
 }
 
 /*
-- 
2.5.5
