Message-ID: <457EFCD1.2070405@trustedcs.com>
Date: Tue, 12 Dec 2006 13:02:41 -0600
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: sds@tycho.nsa.gov, paul.moore@hp.com
Subject: [PATCH 1/1] selinux: Delete mls_copy_context - V.02
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This deletes mls_copy_context() in favor of mls_context_cpy() and
replaces mls_scopy_context() with mls_context_cpy_low().

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---
 security/selinux/ss/context.h  |   23 +++++++++++++++++++++++
 security/selinux/ss/mls.c      |   30 +++++-------------------------
 security/selinux/ss/mls.h      |   20 --------------------
 security/selinux/ss/services.c |    3 +--
 4 files changed, 29 insertions(+), 47 deletions(-)

diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 0562bac..2eee0da 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -55,6 +55,29 @@ out:
 	return rc;
 }
 
+/*
+ * Sets both levels in the MLS range of 'dst' to the low level of 'src'.
+ */
+static inline int mls_context_cpy_low(struct context *dst, struct context *src)
+{
+	int rc;
+
+	if (!selinux_mls_enabled)
+		return 0;
+
+	dst->range.level[0].sens = src->range.level[0].sens;
+	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
+	if (rc)
+		goto out;
+
+	dst->range.level[1].sens = src->range.level[0].sens;
+	rc = ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[0].cat);
+	if (rc)
+		ebitmap_destroy(&dst->range.level[0].cat);
+out:
+	return rc;
+}
+
 static inline int mls_context_cmp(struct context *c1, struct context *c2)
 {
 	if (!selinux_mls_enabled)
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index b4f682d..4a8bab2 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -270,7 +270,7 @@ int mls_context_to_sid(char oldc,
 		if (!defcon)
 			goto out;
 
-		rc = mls_copy_context(context, defcon);
+		rc = mls_context_cpy(context, defcon);
 		goto out;
 	}
 
@@ -401,26 +401,6 @@ int mls_from_string(char *str, struct co
 }
 
 /*
- * Copies the effective MLS range from `src' into `dst'.
- */
-static inline int mls_scopy_context(struct context *dst,
-                                    struct context *src)
-{
-	int l, rc = 0;
-
-	/* Copy the MLS range from the source context */
-	for (l = 0; l < 2; l++) {
-		dst->range.level[l].sens = src->range.level[0].sens;
-		rc = ebitmap_cpy(&dst->range.level[l].cat,
-				 &src->range.level[0].cat);
-		if (rc)
-			break;
-	}
-
-	return rc;
-}
-
-/*
  * Copies the MLS range `range' into `context'.
  */
 static inline int mls_range_set(struct context *context,
@@ -552,19 +532,19 @@ int mls_compute_sid(struct context *scon
 	case AVTAB_CHANGE:
 		if (tclass == SECCLASS_PROCESS)
 			/* Use the process MLS attributes. */
-			return mls_copy_context(newcontext, scontext);
+			return mls_context_cpy(newcontext, scontext);
 		else
 			/* Use the process effective MLS attributes. */
-			return mls_scopy_context(newcontext, scontext);
+			return mls_context_cpy_low(newcontext, scontext);
 	case AVTAB_MEMBER:
 		/* Only polyinstantiate the MLS attributes if
 		   the type is being polyinstantiated */
 		if (newcontext->type != tcontext->type) {
 			/* Use the process effective MLS attributes. */
-			return mls_scopy_context(newcontext, scontext);
+			return mls_context_cpy_low(newcontext, scontext);
 		} else {
 			/* Use the related object MLS attributes. */
-			return mls_copy_context(newcontext, tcontext);
+			return mls_context_cpy(newcontext, tcontext);
 		}
 	default:
 		return -EINVAL;
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index 661d6fc..096d1b4 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -24,26 +24,6 @@ #define _SS_MLS_H_
 #include "context.h"
 #include "policydb.h"
 
-/*
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
 int mls_compute_context_len(struct context *context);
 void mls_sid_to_context(struct context *context, char **scontext);
 int mls_context_isvalid(struct policydb *p, struct context *c);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index bdb7070..668bc37 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1916,11 +1916,10 @@ int security_sid_mls_copy(u32 sid, u32 m
 	newcon.user = context1->user;
 	newcon.role = context1->role;
 	newcon.type = context1->type;
-	rc = mls_copy_context(&newcon, context2);
+	rc = mls_context_cpy(&newcon, context2);
 	if (rc)
 		goto out_unlock;
 
-
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(&policydb, &newcon)) {
 		rc = convert_context_handle_invalid_context(&newcon);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
