From: Richard Haines <richard_c_haines@btinternet.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/2] libsepol: Add sepol_validate_transition_reason_buffer function
Date: Sun,  3 Nov 2013 19:11:56 +0000
Message-Id: <1383505916-2599-1-git-send-email-richard_c_haines@btinternet.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This will return mls/validatetrans constraint information for each
expression in a buffer. If POLICY_KERN version is >=
POLICYDB_VERSION_CONSTRAINT_NAMES then the policy defined types/attributes
will be returned.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libsepol/include/sepol/policydb/services.h | 14 ++++++
 libsepol/src/services.c                    | 80 ++++++++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index 8b2065f..e4e8362 100644
--- a/libsepol/include/sepol/policydb/services.h
+++ b/libsepol/include/sepol/policydb/services.h
@@ -75,6 +75,20 @@ extern int sepol_compute_av_reason_buffer(sepol_security_id_t ssid,
 				   unsigned int *reason,
 				   char **reason_buf,
 				   unsigned int flags);
+
+/*
+ * Returns the mls/validatetrans constraint expression calculations in
+ * a buffer that must be free'd by the caller using free(3).
+ * If the SHOW_GRANTED flag is set it will show granted and denied
+ * mls/validatetrans (the default is to show only those denied).
+ */
+extern int sepol_validate_transition_reason_buffer(sepol_security_id_t oldsid,
+					sepol_security_id_t newsid,
+					sepol_security_id_t tasksid,
+					sepol_security_class_t tclass,
+					char **reason_buf,
+					unsigned int flags);
+
 /*
  * Return a class ID associated with the class string representation
  * specified by `class_name'.
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 73faa05..e7af71e 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -344,11 +344,16 @@ static char *get_class_info(sepol_security_class_t tclass,
 		if (len < 0 || len >= class_buf_len - buf_used)
 			continue;
 
-		/* Add permission entries */
+		/* Add permission entries (validatetrans does not have perms) */
 		p += len;
 		buf_used += len;
-		len = snprintf(p, class_buf_len - buf_used, "{%s } (",
-				sepol_av_to_string(policydb, tclass, constraint->permissions));
+		if (state_num < 2) {
+			len = snprintf(p, class_buf_len - buf_used, "{%s } (",
+			sepol_av_to_string(policydb, tclass,
+				constraint->permissions));
+		} else {
+			len = snprintf(p, class_buf_len - buf_used, "(");
+		}
 		if (len < 0 || len >= class_buf_len - buf_used)
 			continue;
 		break;
@@ -750,8 +755,11 @@ mls_ops:
 	/* Get the final answer from tos and build constraint text */
 	a = pop();
 
-	/* Constraint calculation: rc = 0 is denied, rc = 1 is granted */
-	sprintf(tmp_buf, "Constraint %s\n", s[0] ? "GRANTED" : "DENIED");
+	/* validatetrans / constraint calculation:
+				rc = 0 is denied, rc = 1 is granted */
+	sprintf(tmp_buf, "%s %s\n",
+			xcontext ? "Validatetrans" : "Constraint",
+			s[0] ? "GRANTED" : "DENIED");
 
 	int len, new_buf_len;
 	char *p, **new_buf = r_buf;
@@ -982,6 +990,68 @@ int hidden sepol_validate_transition(sepol_security_id_t oldsid,
 	return 0;
 }
 
+/*
+ * sepol_validate_transition_reason_buffer - the reason buffer is realloc'd
+ * in the constraint_expr_eval_reason() function.
+ */
+int hidden sepol_validate_transition_reason_buffer(sepol_security_id_t oldsid,
+				     sepol_security_id_t newsid,
+				     sepol_security_id_t tasksid,
+				     sepol_security_class_t tclass,
+				     char **reason_buf,
+				     unsigned int flags)
+{
+	context_struct_t *ocontext;
+	context_struct_t *ncontext;
+	context_struct_t *tcontext;
+	class_datum_t *tclass_datum;
+	constraint_node_t *constraint;
+
+	if (!tclass || tclass > policydb->p_classes.nprim) {
+		ERR(NULL, "unrecognized class %d", tclass);
+		return -EINVAL;
+	}
+	tclass_datum = policydb->class_val_to_struct[tclass - 1];
+
+	ocontext = sepol_sidtab_search(sidtab, oldsid);
+	if (!ocontext) {
+		ERR(NULL, "unrecognized SID %d", oldsid);
+		return -EINVAL;
+	}
+
+	ncontext = sepol_sidtab_search(sidtab, newsid);
+	if (!ncontext) {
+		ERR(NULL, "unrecognized SID %d", newsid);
+		return -EINVAL;
+	}
+
+	tcontext = sepol_sidtab_search(sidtab, tasksid);
+	if (!tcontext) {
+		ERR(NULL, "unrecognized SID %d", tasksid);
+		return -EINVAL;
+	}
+
+	/*
+	 * Set the buffer to NULL as mls/validatetrans may not be processed.
+	 * If a buffer is required, then the routines in
+	 * constraint_expr_eval_reason will realloc in REASON_BUF_SIZE
+	 * chunks (as it gets called for each mls/validatetrans processed).
+	 * We just make sure these start from zero.
+	 */
+	*reason_buf = NULL;
+	reason_buf_used = 0;
+	reason_buf_len = 0;
+	constraint = tclass_datum->validatetrans;
+	while (constraint) {
+		if (!constraint_expr_eval_reason(ocontext, ncontext, tcontext,
+				tclass, constraint, reason_buf, flags)) {
+			return -EPERM;
+		}
+		constraint = constraint->next;
+	}
+	return 0;
+}
+
 int hidden sepol_compute_av_reason(sepol_security_id_t ssid,
 				   sepol_security_id_t tsid,
 				   sepol_security_class_t tclass,
-- 
1.8.3.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
