Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB0457E69
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291871; cv=none; b=gOBBTkTm7XKfG0vSnMA9rpa2FyYpjQj8Y4aE6PQHZAxTNeP/RmYMIn9KFKdyYh6ozm1dVHGNWHVGaYOqogWCMOUc7iOcBJOV+2AitGEyCKpFxuqAY6v3qVHqlVVP3IOcSDW4OUwEWlP91WPmdZtOQ7MQ9X0w4H/F7VCfeC2jkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291871; c=relaxed/simple;
	bh=HU0IY9mYNH3qWl6+MTiTp4pqD4HqSUa2GSTBhTpW2To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHNpDZeG0CrKl8pSvtqeq2UTWLdwkXmeDOp9BeArdIwj08Cu2lKov9PnH56rksBVyVp+o6Ik+7vfsYbhpwurYdNhYBsXGwYC6KPBfUeFTpd08DZiPLejXoEWCEFbIsP6McJ1/+ylUhxuiUsAp/55I/zY/D3iipje0nV0bwRuqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J78pli/l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J78pli/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnsXFmdjfDavItFNmoEpfh/spJLvV+OjRlz44IaL8X8=;
	b=J78pli/lZMjE1uRdUx6OELqfSBB9uWnzNLhbz4jezZehGeh8cKi1J2xtgo87HmKai39ud5
	VtyKuCO9fvFPmcgezOd3yRnrTqNCzNwW2Gc/0FtL9o5a60RIzfvhH6ZOY+T5Vh5YwlgeiX
	+sE2aHXTfSnRY3RAX4ZiDiIYB7iG5z8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-9Mto5lkoNymnq5gmgfy8fQ-1; Tue,
 06 Oct 2026 09:04:25 -0400
X-MC-Unique: 9Mto5lkoNymnq5gmgfy8fQ-1
X-Mimecast-MFC-AGG-ID: 9Mto5lkoNymnq5gmgfy8fQ_1791291864
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A855196C40B
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:24 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0B431944CC0;
	Tue,  6 Oct 2026 13:04:23 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>
Subject: [RFC PATCH userspace 10/17] libsepol: add context resolution from policy values and SIDs
Date: Tue,  6 Oct 2026 15:02:08 +0200
Message-ID: <20261006130215.128405-11-jjanasek@redhat.com>
In-Reply-To: <20261006130215.128405-1-jjanasek@redhat.com>
References: <20261006130215.128405-1-jjanasek@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add sepol_values_to_context_string()/sepol_values_to_context_record()
to build a security context string or sepol_context_t from raw
user/role/type values plus an optional MLS range string, without the
caller ever touching context_struct_t.

Add sepol_sid_table_t, an opaque wrapper around sidtab_t
(sepol_sid_table_new/load_isids/set_opaque/free), so callers can load
and install a policy's initial-SID table without including
policydb/sidtab.h directly.

Add sepol_policydb_sid_to_context_string()/_record() to resolve a SID
to a context using only a given sepol_policydb_t, without requiring a
process-global active policydb/sidtab via sepol_set_policydb()/
sepol_set_sidtab().

Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/context.h              |  42 +++
 libsepol/include/sepol/flask.h                |  34 +++
 libsepol/include/sepol/policydb/flask_types.h |  55 +---
 libsepol/include/sepol/sid_table.h            |  43 +++
 libsepol/src/context.c                        | 279 ++++++++++++++++-
 libsepol/src/context_record.c                 |  62 +++-
 libsepol/src/services.c                       |  33 ++
 libsepol/src/sidtab.c                         |  78 +++++
 libsepol/tests/libsepol-tests.c               |   2 +
 libsepol/tests/policies/test-iter/iter.conf   |  10 +
 libsepol/tests/test-context-api.c             | 289 ++++++++++++++++++
 libsepol/tests/test-context-api.h             |  10 +
 12 files changed, 865 insertions(+), 72 deletions(-)
 create mode 100644 libsepol/include/sepol/flask.h
 create mode 100644 libsepol/include/sepol/sid_table.h
 create mode 100644 libsepol/tests/test-context-api.c
 create mode 100644 libsepol/tests/test-context-api.h

diff --git a/libsepol/include/sepol/context.h b/libsepol/include/sepol/context.h
index b0e8701b..b79793b4 100644
--- a/libsepol/include/sepol/context.h
+++ b/libsepol/include/sepol/context.h
@@ -4,6 +4,7 @@
 #include <sepol/context_record.h>
 #include <sepol/policydb.h>
 #include <sepol/handle.h>
+#include <stdint.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -27,6 +28,47 @@ extern int sepol_mls_contains(sepol_handle_t *handle,
 extern int sepol_mls_check(sepol_handle_t *handle,
 			   const sepol_policydb_t *policydb, const char *mls);
 
+/*
+ * Build a security context string from policy-internal symbol values (1-based)
+ * and optional MLS range string (same MLS syntax as in full context strings).
+ * When MLS is disabled for the policy, mls_range must be NULL or empty.
+ */
+extern int sepol_values_to_context_string(sepol_handle_t *handle,
+					  const sepol_policydb_t *policydb,
+					  uint32_t user_val, uint32_t role_val,
+					  uint32_t type_val,
+					  const char *mls_range, char **out,
+					  size_t *out_len);
+
+extern int sepol_values_to_context_record(sepol_handle_t *handle,
+					  const sepol_policydb_t *policydb,
+					  uint32_t user_val, uint32_t role_val,
+					  uint32_t type_val,
+					  const char *mls_range,
+					  sepol_context_t **record);
+
+/*
+ * Resolve a SID to a context using only the given policydb (no process-global
+ * sepol_set_policydb / sepol_set_sidtab). Builds a temporary SID table from
+ * the policy's initial SID contexts on each call; for many lookups prefer
+ * sepol_sid_table_t with sepol_sid_table_load_isids().
+ */
+extern int
+sepol_policydb_sid_to_context_string(sepol_handle_t *handle,
+				     const sepol_policydb_t *policydb,
+				     uint32_t sid, char **out, size_t *out_len);
+
+extern int
+sepol_policydb_sid_to_context_record(sepol_handle_t *handle,
+				     const sepol_policydb_t *policydb,
+				     uint32_t sid, sepol_context_t **record);
+
+/*
+ * Legacy security-server helpers (sepol_sid_to_context,
+ * sepol_sid_to_context_record) remain in <sepol/policydb/services.h> and
+ * require an active process-global policydb and sidtab.
+ */
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libsepol/include/sepol/flask.h b/libsepol/include/sepol/flask.h
new file mode 100644
index 00000000..510af392
--- /dev/null
+++ b/libsepol/include/sepol/flask.h
@@ -0,0 +1,34 @@
+#ifndef _SEPOL_FLASK_H_
+#define _SEPOL_FLASK_H_
+
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+typedef char *sepol_security_context_t;
+typedef const char *sepol_const_security_context_t;
+typedef uint32_t sepol_access_vector_t;
+typedef uint16_t sepol_security_class_t;
+#define SEPOL_SECCLASS_NULL 0x0000
+
+#define SELINUX_MAGIC 0xf97cff8c
+#define SELINUX_MOD_MAGIC 0xf97cff8d
+
+typedef uint32_t sepol_security_id_t;
+#define SEPOL_SECSID_NULL 0
+
+struct sepol_av_decision {
+	sepol_access_vector_t allowed;
+	sepol_access_vector_t decided;
+	sepol_access_vector_t auditallow;
+	sepol_access_vector_t auditdeny;
+	uint32_t seqno;
+};
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/include/sepol/policydb/flask_types.h b/libsepol/include/sepol/policydb/flask_types.h
index 4675f36f..f948db61 100644
--- a/libsepol/include/sepol/policydb/flask_types.h
+++ b/libsepol/include/sepol/policydb/flask_types.h
@@ -9,58 +9,11 @@
 
 /*
  * The basic Flask types and constants.
+ *
+ * This header re-exports the public definitions from <sepol/flask.h>
+ * for backward compatibility.
  */
 
-#include <sys/types.h>
-#include <stdint.h>
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/*
- * A security context is a set of security attributes 
- * associated with each subject and object controlled
- * by the security policy.  The security context type
- * is defined as a variable-length string that can be
- * interpreted by any application or user with an 
- * understanding of the security policy.
- */
-typedef char *sepol_security_context_t;
-typedef const char *sepol_const_security_context_t;
-
-/*
- * An access vector (AV) is a collection of related permissions
- * for a pair of SIDs.  The bits within an access vector
- * are interpreted differently depending on the class of
- * the object.  The access vector interpretations are specified
- * in policy.
- */
-typedef uint32_t sepol_access_vector_t;
-
-/*
- * Each object class is identified by a fixed-size value.
- * The set of security classes is specified in policy.
- */
-typedef uint16_t sepol_security_class_t;
-#define SEPOL_SECCLASS_NULL 0x0000 /* no class */
-
-#define SELINUX_MAGIC 0xf97cff8c
-#define SELINUX_MOD_MAGIC 0xf97cff8d
-
-typedef uint32_t sepol_security_id_t;
-#define SEPOL_SECSID_NULL 0
-
-struct sepol_av_decision {
-	sepol_access_vector_t allowed;
-	sepol_access_vector_t decided;
-	sepol_access_vector_t auditallow;
-	sepol_access_vector_t auditdeny;
-	uint32_t seqno;
-};
-
-#ifdef __cplusplus
-}
-#endif
+#include <sepol/flask.h>
 
 #endif
diff --git a/libsepol/include/sepol/sid_table.h b/libsepol/include/sepol/sid_table.h
new file mode 100644
index 00000000..64d08fc7
--- /dev/null
+++ b/libsepol/include/sepol/sid_table.h
@@ -0,0 +1,43 @@
+#ifndef _SEPOL_SID_TABLE_H_
+#define _SEPOL_SID_TABLE_H_
+
+#include <sepol/policydb.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Opaque SID table for use with the security server helpers (sepol_sid_to_context,
+ * sepol_context_to_sid, etc.) without exposing sidtab_t.
+ */
+
+typedef struct sepol_sid_table sepol_sid_table_t;
+
+extern sepol_sid_table_t *sepol_sid_table_new(void);
+
+/*
+ * Frees a SID table created by sepol_sid_table_new(). If this table is
+ * currently installed as the process-global active table (via
+ * sepol_sid_table_set_opaque()), it is automatically uninstalled first,
+ * so subsequent calls into the security server helpers (sepol_sid_to_context,
+ * sepol_context_to_sid, etc.) will not dereference the freed table.
+ */
+extern void sepol_sid_table_free(sepol_sid_table_t *tab);
+
+extern int sepol_sid_table_load_isids(sepol_sid_table_t *tab,
+				      sepol_policydb_t *policydb);
+
+/*
+ * Installs tab as the process-global active SID table used internally by
+ * the security server helpers (sepol_sid_to_context, sepol_context_to_sid,
+ * etc.). Only one table can be active at a time; calling this again with
+ * a different table replaces the previous one as the active table.
+ */
+extern int sepol_sid_table_set_opaque(sepol_sid_table_t *tab);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/src/context.c b/libsepol/src/context.c
index 23be7139..fbe07aac 100644
--- a/libsepol/src/context.c
+++ b/libsepol/src/context.c
@@ -2,8 +2,10 @@
 #include <string.h>
 #include <errno.h>
 
+#include <sepol/context.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
+#include <sepol/policydb/sidtab.h>
 #include "context_internal.h"
 
 #include "debug.h"
@@ -33,10 +35,7 @@ int context_is_valid(const policydb_t *p, const context_struct_t *c)
 {
 	role_datum_t *role;
 	user_datum_t *usrdatum;
-	ebitmap_t types, roles;
 
-	ebitmap_init(&types);
-	ebitmap_init(&roles);
 	if (!c->role || c->role > p->p_roles.nprim)
 		return 0;
 
@@ -88,6 +87,11 @@ int context_to_string(sepol_handle_t *handle, const policydb_t *policydb,
 	size_t scontext_len = 0;
 	char *ptr;
 
+	if (!context->user || context->user > policydb->p_users.nprim ||
+	    !context->role || context->role > policydb->p_roles.nprim ||
+	    !context->type || context->type > policydb->p_types.nprim)
+		return STATUS_ERR;
+
 	/* Compute the size of the context. */
 	scontext_len +=
 		strlen(policydb->p_user_val_to_name[context->user - 1]) + 1;
@@ -142,10 +146,24 @@ int context_from_record(sepol_handle_t *handle, const policydb_t *policydb,
 	role_datum_t *roldatum;
 	type_datum_t *typdatum;
 
+	*cptr = NULL;
+
+	if (!record) {
+		ERR(handle, "context record is NULL");
+		return STATUS_ERR;
+	}
+
+	const char *user_str = sepol_context_get_user(record);
+	const char *role_str = sepol_context_get_role(record);
+	const char *type_str = sepol_context_get_type(record);
+	if (!user_str || !role_str || !type_str) {
+		ERR(handle, "context record has NULL user, role, or type");
+		return STATUS_ERR;
+	}
 	/* Hashtab keys are not constant - suppress warnings */
-	char *user = strdup(sepol_context_get_user(record));
-	char *role = strdup(sepol_context_get_role(record));
-	char *type = strdup(sepol_context_get_type(record));
+	char *user = strdup(user_str);
+	char *role = strdup(role_str);
+	char *type = strdup(type_str);
 	const char *mls = sepol_context_get_mls(record);
 
 	scontext = (context_struct_t *)malloc(sizeof(context_struct_t));
@@ -281,6 +299,8 @@ int context_from_string(sepol_handle_t *handle, const policydb_t *policydb,
 	char *con_cpy = NULL;
 	sepol_context_t *ctx_record = NULL;
 
+	*cptr = NULL;
+
 	if (zero_or_saturated(con_str_len)) {
 		ERR(handle, "Invalid context length");
 		goto err;
@@ -318,9 +338,252 @@ int sepol_context_check(sepol_handle_t *handle,
 			const sepol_policydb_t *policydb,
 			const sepol_context_t *context)
 {
+	if (!policydb || !context)
+		return STATUS_ERR;
+
 	context_struct_t *con = NULL;
 	int ret = context_from_record(handle, &policydb->p, &con, context);
-	context_destroy(con);
-	free(con);
+	if (con) {
+		context_destroy(con);
+		free(con);
+	}
 	return ret;
 }
+
+/*
+ * Populate ctx from policy-internal values (1-based) and optional MLS range text.
+ */
+static int values_prepare_context(sepol_handle_t *handle, const policydb_t *p,
+				  uint32_t user_val, uint32_t role_val,
+				  uint32_t type_val, const char *mls_range,
+				  context_struct_t *ctx)
+{
+	type_datum_t *typdatum;
+
+	if (user_val < 1 || user_val > p->p_users.nprim ||
+	    !p->p_user_val_to_name[user_val - 1]) {
+		ERR(handle, "invalid user value %u", user_val);
+		errno = EINVAL;
+		return STATUS_ERR;
+	}
+
+	if (role_val < 1 || role_val > p->p_roles.nprim ||
+	    !p->p_role_val_to_name[role_val - 1]) {
+		ERR(handle, "invalid role value %u", role_val);
+		errno = EINVAL;
+		return STATUS_ERR;
+	}
+
+	if (type_val < 1 || type_val > p->p_types.nprim ||
+	    !p->p_type_val_to_name[type_val - 1]) {
+		ERR(handle, "invalid type value %u", type_val);
+		errno = EINVAL;
+		return STATUS_ERR;
+	}
+
+	typdatum = p->type_val_to_struct[type_val - 1];
+	if (!typdatum || typdatum->flavor == TYPE_ATTRIB) {
+		ERR(handle, "invalid type value %u", type_val);
+		errno = EINVAL;
+		return STATUS_ERR;
+	}
+
+	ctx->user = user_val;
+	ctx->role = role_val;
+	ctx->type = type_val;
+
+	if (p->mls) {
+		if (!mls_range || !*mls_range) {
+			ERR(handle, "MLS is enabled but MLS range is missing");
+			errno = EINVAL;
+			return STATUS_ERR;
+		}
+		if (mls_from_string(handle, p, mls_range, ctx) < 0)
+			return STATUS_ERR;
+	} else {
+		if (mls_range && *mls_range) {
+			ERR(handle,
+			    "MLS is disabled, but MLS range \"%s\" was supplied",
+			    mls_range);
+			errno = EINVAL;
+			return STATUS_ERR;
+		}
+	}
+
+	if (!context_is_valid(p, ctx)) {
+		ERR(handle, "invalid security context from values");
+		errno = EINVAL;
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+int sepol_values_to_context_string(sepol_handle_t *handle,
+				   const sepol_policydb_t *policydb,
+				   uint32_t user_val, uint32_t role_val,
+				   uint32_t type_val, const char *mls_range,
+				   char **out, size_t *out_len)
+{
+	const policydb_t *p;
+	context_struct_t ctx;
+	int rc;
+
+	if (!policydb || !out || !out_len)
+		return STATUS_ERR;
+
+	*out = NULL;
+	*out_len = 0;
+
+	p = &policydb->p;
+	context_init(&ctx);
+
+	rc = values_prepare_context(handle, p, user_val, role_val, type_val,
+				    mls_range, &ctx);
+	if (rc < 0)
+		goto out;
+
+	rc = context_to_string(handle, p, &ctx, out, out_len);
+out:
+	context_destroy(&ctx);
+	return rc;
+}
+
+int sepol_values_to_context_record(sepol_handle_t *handle,
+				   const sepol_policydb_t *policydb,
+				   uint32_t user_val, uint32_t role_val,
+				   uint32_t type_val, const char *mls_range,
+				   sepol_context_t **record)
+{
+	const policydb_t *p;
+	context_struct_t ctx;
+	int rc;
+
+	if (!policydb || !record)
+		return STATUS_ERR;
+
+	*record = NULL;
+
+	p = &policydb->p;
+	context_init(&ctx);
+
+	rc = values_prepare_context(handle, p, user_val, role_val, type_val,
+				    mls_range, &ctx);
+	if (rc < 0)
+		goto out;
+
+	rc = context_to_record(handle, p, &ctx, record);
+out:
+	context_destroy(&ctx);
+	return rc;
+}
+
+static int policydb_sid_lookup_context(sepol_handle_t *handle,
+				       const sepol_policydb_t *policydb,
+				       uint32_t sid, context_struct_t **ctx_out)
+{
+	sidtab_t sidtab;
+	context_struct_t *ctx;
+	int rc;
+
+	/*
+	 * handle may legitimately be NULL here, same as in
+	 * sepol_values_to_context_string()/_record() above: ERR()
+	 * (via msg_write()) falls back to sepol_compat_handle when handle
+	 * is NULL, and nothing else in this function dereferences handle
+	 * directly.
+	 */
+	if (!policydb || !ctx_out)
+		return STATUS_ERR;
+
+	*ctx_out = NULL;
+	memset(&sidtab, 0, sizeof(sidtab));
+
+	rc = policydb_load_isids((policydb_t *)&policydb->p, &sidtab);
+	if (rc < 0) {
+		ERR(handle, "failed to load initial SID table from policy");
+		/*
+		 * policydb_load_isids() may have partially populated sidtab
+		 * (sepol_sidtab_init() succeeded, then a later insert failed)
+		 * before returning an error; destroy it to avoid leaking the
+		 * hash table and any contexts already inserted into it.
+		 */
+		sepol_sidtab_destroy(&sidtab);
+		return STATUS_ERR;
+	}
+
+	ctx = sepol_sidtab_search(&sidtab, sid);
+	if (!ctx) {
+		ERR(handle, "SID %u not found in policy", sid);
+		sepol_sidtab_destroy(&sidtab);
+		return STATUS_ERR;
+	}
+
+	/*
+	 * context_to_string/record only read fields from ctx; deep-copy the
+	 * struct (context_cpy(), not a shallow assignment) so we can destroy
+	 * sidtab before returning without leaving *ctx_out's MLS range
+	 * pointing at ebitmap nodes that sepol_sidtab_destroy() just freed.
+	 */
+	*ctx_out = malloc(sizeof(**ctx_out));
+	if (!*ctx_out) {
+		ERR(handle, "out of memory");
+		sepol_sidtab_destroy(&sidtab);
+		return STATUS_ERR;
+	}
+	if (context_cpy(*ctx_out, ctx) < 0) {
+		ERR(handle, "out of memory");
+		free(*ctx_out);
+		*ctx_out = NULL;
+		sepol_sidtab_destroy(&sidtab);
+		return STATUS_ERR;
+	}
+	sepol_sidtab_destroy(&sidtab);
+	return STATUS_SUCCESS;
+}
+
+int sepol_policydb_sid_to_context_string(sepol_handle_t *handle,
+					 const sepol_policydb_t *policydb,
+					 uint32_t sid, char **out,
+					 size_t *out_len)
+{
+	context_struct_t *ctx = NULL;
+	int rc;
+
+	if (!out || !out_len)
+		return STATUS_ERR;
+
+	*out = NULL;
+	*out_len = 0;
+
+	rc = policydb_sid_lookup_context(handle, policydb, sid, &ctx);
+	if (rc < 0)
+		return rc;
+
+	rc = context_to_string(handle, &policydb->p, ctx, out, out_len);
+	context_destroy(ctx);
+	free(ctx);
+	return rc;
+}
+
+int sepol_policydb_sid_to_context_record(sepol_handle_t *handle,
+					 const sepol_policydb_t *policydb,
+					 uint32_t sid, sepol_context_t **record)
+{
+	context_struct_t *ctx = NULL;
+	int rc;
+
+	if (!record)
+		return STATUS_ERR;
+
+	*record = NULL;
+
+	rc = policydb_sid_lookup_context(handle, policydb, sid, &ctx);
+	if (rc < 0)
+		return rc;
+
+	rc = context_to_record(handle, &policydb->p, ctx, record);
+	context_destroy(ctx);
+	free(ctx);
+	return rc;
+}
diff --git a/libsepol/src/context_record.c b/libsepol/src/context_record.c
index 00beb334..2c3c0e89 100644
--- a/libsepol/src/context_record.c
+++ b/libsepol/src/context_record.c
@@ -24,12 +24,14 @@ struct sepol_context {
 /* User */
 const char *sepol_context_get_user(const sepol_context_t *con)
 {
-	return con->user;
+	return con ? con->user : NULL;
 }
 
 int sepol_context_set_user(sepol_handle_t *handle, sepol_context_t *con,
 			   const char *user)
 {
+	if (!con || !user)
+		return STATUS_ERR;
 	char *tmp_user = strdup(user);
 	if (!tmp_user) {
 		ERR(handle,
@@ -47,12 +49,14 @@ int sepol_context_set_user(sepol_handle_t *handle, sepol_context_t *con,
 /* Role */
 const char *sepol_context_get_role(const sepol_context_t *con)
 {
-	return con->role;
+	return con ? con->role : NULL;
 }
 
 int sepol_context_set_role(sepol_handle_t *handle, sepol_context_t *con,
 			   const char *role)
 {
+	if (!con || !role)
+		return STATUS_ERR;
 	char *tmp_role = strdup(role);
 	if (!tmp_role) {
 		ERR(handle,
@@ -69,12 +73,14 @@ int sepol_context_set_role(sepol_handle_t *handle, sepol_context_t *con,
 /* Type */
 const char *sepol_context_get_type(const sepol_context_t *con)
 {
-	return con->type;
+	return con ? con->type : NULL;
 }
 
 int sepol_context_set_type(sepol_handle_t *handle, sepol_context_t *con,
 			   const char *type)
 {
+	if (!con || !type)
+		return STATUS_ERR;
 	char *tmp_type = strdup(type);
 	if (!tmp_type) {
 		ERR(handle,
@@ -91,12 +97,14 @@ int sepol_context_set_type(sepol_handle_t *handle, sepol_context_t *con,
 /* MLS */
 const char *sepol_context_get_mls(const sepol_context_t *con)
 {
-	return con->mls;
+	return con ? con->mls : NULL;
 }
 
 int sepol_context_set_mls(sepol_handle_t *handle, sepol_context_t *con,
 			  const char *mls)
 {
+	if (!con || !mls)
+		return STATUS_ERR;
 	char *tmp_mls = strdup(mls);
 	if (!tmp_mls) {
 		ERR(handle,
@@ -113,11 +121,15 @@ int sepol_context_set_mls(sepol_handle_t *handle, sepol_context_t *con,
 /* Create */
 int sepol_context_create(sepol_handle_t *handle, sepol_context_t **con_ptr)
 {
-	sepol_context_t *con =
-		(sepol_context_t *)malloc(sizeof(sepol_context_t));
+	sepol_context_t *con;
+
+	if (!con_ptr)
+		return STATUS_ERR;
 
+	con = (sepol_context_t *)malloc(sizeof(sepol_context_t));
 	if (!con) {
 		ERR(handle, "out of memory, could not create context");
+		*con_ptr = NULL;
 		return STATUS_ERR;
 	}
 
@@ -135,21 +147,29 @@ int sepol_context_clone(sepol_handle_t *handle, const sepol_context_t *con,
 {
 	sepol_context_t *new_con = NULL;
 
+	if (!con_ptr)
+		return STATUS_ERR;
+
+	/*
+	 * Unlike other _clone() functions, a NULL source is not an error
+	 * here: sepol_{port,node,ibpkey,ibendport,iface}_set_con() rely on
+	 * this to implement "pass NULL to clear the (optional) context".
+	 */
 	if (!con) {
 		*con_ptr = NULL;
-		return 0;
+		return STATUS_SUCCESS;
 	}
 
 	if (sepol_context_create(handle, &new_con) < 0)
 		goto err;
 
-	if (!(new_con->user = strdup(con->user)))
+	if (con->user && !(new_con->user = strdup(con->user)))
 		goto omem;
 
-	if (!(new_con->role = strdup(con->role)))
+	if (con->role && !(new_con->role = strdup(con->role)))
 		goto omem;
 
-	if (!(new_con->type = strdup(con->type)))
+	if (con->type && !(new_con->type = strdup(con->type)))
 		goto omem;
 
 	if (con->mls && !(new_con->mls = strdup(con->mls)))
@@ -164,6 +184,7 @@ omem:
 err:
 	ERR(handle, "could not clone context record");
 	sepol_context_free(new_con);
+	*con_ptr = NULL;
 	return STATUS_ERR;
 }
 
@@ -186,11 +207,18 @@ int sepol_context_from_string(sepol_handle_t *handle, const char *str,
 	char *tmp = NULL, *low, *high;
 	sepol_context_t *tmp_con = NULL;
 
-	if (!strcmp(str, "<<none>>")) {
-		*con = NULL;
-		return STATUS_SUCCESS;
+	if (!con)
+		return STATUS_ERR;
+	*con = NULL;
+
+	if (!str) {
+		ERR(handle, "context string is NULL");
+		return STATUS_ERR;
 	}
 
+	if (!strcmp(str, "<<none>>"))
+		return STATUS_SUCCESS;
+
 	if (sepol_context_create(handle, &tmp_con) < 0)
 		goto err;
 
@@ -257,6 +285,14 @@ int sepol_context_to_string(sepol_handle_t *handle, const sepol_context_t *con,
 	int rc;
 	char *str = NULL;
 	size_t total_sz = 0, i;
+	if (!str_ptr)
+		return STATUS_ERR;
+	*str_ptr = NULL;
+	if (!con || !con->user || !con->role || !con->type) {
+		ERR(handle, "incomplete context record");
+		return STATUS_ERR;
+	}
+
 	const size_t sizes[] = {
 		strlen(con->user), /* user length */
 		strlen(con->role), /* role length */
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index fdd84078..a44eb395 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -48,6 +48,7 @@
 #define EXPR_BUF_SIZE 1024
 #define STACK_LEN 32
 
+#include <errno.h>
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/socket.h>
@@ -127,6 +128,18 @@ int sepol_set_sidtab(sidtab_t *s)
 	return 0;
 }
 
+/*
+ * Returns the sidtab currently installed via sepol_set_sidtab(), or NULL
+ * if none is active. Used internally (e.g. by sepol_sid_table_free()) to
+ * detect whether a given sidtab is the one actually in use, since
+ * sepol_set_sidtab() can be called directly and bypass any bookkeeping
+ * done by higher-level wrappers such as sepol_sid_table_set_opaque().
+ */
+sidtab_t *sepol_get_sidtab(void)
+{
+	return sidtab;
+}
+
 int sepol_set_policydb(policydb_t *p)
 {
 	policydb = p;
@@ -1307,6 +1320,26 @@ out:
 	return rc;
 }
 
+int sepol_sid_to_context_record(sepol_handle_t *handle, sepol_security_id_t sid,
+				sepol_context_t **record)
+{
+	context_struct_t *context;
+	int rc;
+
+	if (!record)
+		return STATUS_ERR;
+	*record = NULL;
+
+	context = sepol_sidtab_search(sidtab, sid);
+	if (!context) {
+		ERR(handle, "unrecognized SID %u", sid);
+		return STATUS_ERR;
+	}
+
+	rc = context_to_record(handle, policydb, context, record);
+	return rc;
+}
+
 /*
  * Return a SID associated with the security context that
  * has the string representation specified by `scontext'.
diff --git a/libsepol/src/sidtab.c b/libsepol/src/sidtab.c
index b301c7cd..f959e279 100644
--- a/libsepol/src/sidtab.c
+++ b/libsepol/src/sidtab.c
@@ -12,11 +12,21 @@
 #include <limits.h>
 #include <stdio.h>
 
+#include <sepol/policydb/policydb.h>
 #include <sepol/policydb/sidtab.h>
+#include <sepol/sid_table.h>
 
+#include "debug.h"
 #include "flask.h"
 #include "private.h"
 
+extern int sepol_set_sidtab(sidtab_t *s);
+extern sidtab_t *sepol_get_sidtab(void);
+
+struct sepol_sid_table {
+	sidtab_t tab;
+};
+
 #define SIDTAB_HASH(sid) (sid & SIDTAB_HASH_MASK)
 
 #define INIT_SIDTAB_LOCK(s)
@@ -288,4 +298,72 @@ void sepol_sidtab_shutdown(sidtab_t *s)
 	SIDTAB_UNLOCK(s);
 }
 
+sepol_sid_table_t *sepol_sid_table_new(void)
+{
+	sepol_sid_table_t *st;
+
+	st = calloc(1, sizeof(*st));
+	if (!st)
+		return NULL;
+	if (sepol_sidtab_init(&st->tab) < 0) {
+		free(st);
+		return NULL;
+	}
+	return st;
+}
+
+void sepol_sid_table_free(sepol_sid_table_t *tab)
+{
+	if (!tab)
+		return;
+	/*
+	 * Compare against the actual, currently-installed sidtab rather
+	 * than tracking "did we last install this via
+	 * sepol_sid_table_set_opaque()" in a separate variable: the latter
+	 * can desynchronize from reality if sepol_set_sidtab() is later
+	 * called directly (it is a separate public API), which would
+	 * otherwise cause this function to incorrectly clear an unrelated,
+	 * still-active global sidtab.
+	 */
+	if (sepol_get_sidtab() == &tab->tab)
+		sepol_set_sidtab(NULL);
+	sepol_sidtab_destroy(&tab->tab);
+	free(tab);
+}
+
+int sepol_sid_table_load_isids(sepol_sid_table_t *tab,
+			       sepol_policydb_t *policydb)
+{
+	sidtab_t tmp;
+	int rc;
+
+	if (!tab || !policydb)
+		return STATUS_ERR;
+
+	/*
+	 * Build the reloaded table into a local temporary first. Destroying
+	 * the caller's existing table before knowing whether the reload
+	 * even succeeds (policydb_load_isids() can fail on OOM or on a
+	 * malformed policydb with duplicate initial SIDs) would permanently
+	 * blank out a previously-valid SID table on failure, breaking every
+	 * subsequent sepol_sidtab_search() lookup with no way to recover.
+	 */
+	rc = policydb_load_isids(&policydb->p, &tmp);
+	if (rc) {
+		sepol_sidtab_destroy(&tmp);
+		return STATUS_ERR;
+	}
+
+	sepol_sidtab_destroy(&tab->tab);
+	sepol_sidtab_set(&tab->tab, &tmp);
+	return 0;
+}
+
+int sepol_sid_table_set_opaque(sepol_sid_table_t *tab)
+{
+	if (!tab)
+		return STATUS_ERR;
+	return sepol_set_sidtab(&tab->tab);
+}
+
 /* FLASK */
diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index a73686b9..c404937b 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -26,6 +26,7 @@
 #include "test-downgrade.h"
 #include "test-neverallow.h"
 #include "test-iter.h"
+#include "test-context-api.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -76,6 +77,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(downgrade);
 	DECLARE_SUITE(neverallow);
 	DECLARE_SUITE(iter);
+	DECLARE_SUITE(context_api);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsepol/tests/policies/test-iter/iter.conf b/libsepol/tests/policies/test-iter/iter.conf
index fd27f5e0..6bfeeec0 100644
--- a/libsepol/tests/policies/test-iter/iter.conf
+++ b/libsepol/tests/policies/test-iter/iter.conf
@@ -7,6 +7,15 @@ class CLASS05
 class CLASS06
 
 sid kernel
+#
+# A second initial SID whose context carries an actual (non-empty)
+# category set under MLS, so tests can verify MLS category handling
+# (e.g. the ebitmap deep-copy in policydb_sid_lookup_context()) without
+# having to fabricate an ad hoc SID at runtime. Under non-MLS builds
+# gen_context() below drops the category argument entirely, so this
+# just gets the same context as "kernel".
+#
+sid isid_mls_cat
 
 common COMMON1 { COMMONPERM1 }
 
@@ -105,6 +114,7 @@ constrain CLASS1 { PERM1 } (
 );
 
 sid kernel	gen_context(USER1:ROLE1:TYPE1, s0)
+sid isid_mls_cat	gen_context(USER1:ROLE1:TYPE1, `s0:c0,c1')
 
 fs_use_xattr ext3 gen_context(USER1:ROLE1:TYPE1, s0);
 fs_use_trans devpts gen_context(USER1:ROLE1:TYPE1, s0);
diff --git a/libsepol/tests/test-context-api.c b/libsepol/tests/test-context-api.c
new file mode 100644
index 00000000..4bf706aa
--- /dev/null
+++ b/libsepol/tests/test-context-api.c
@@ -0,0 +1,289 @@
+#include "test-context-api.h"
+
+#include <limits.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <CUnit/CUnit.h>
+
+#include <sepol/context.h>
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <sepol/policydb/hashtab.h>
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/services.h>
+#include <sepol/policydb/sidtab.h>
+#include <sepol/sid_table.h>
+
+#include "parse_util.h"
+
+extern int mls;
+
+static sepol_handle_t *handle;
+static sepol_policydb_t *policy;
+
+int context_api_test_init(void)
+{
+	char filename[PATH_MAX];
+
+	handle = sepol_handle_create();
+	if (!handle)
+		return -1;
+
+	if (sepol_policydb_create(&policy)) {
+		sepol_handle_destroy(handle);
+		handle = NULL;
+		return -1;
+	}
+
+	policydb_t *p = &policy->p;
+	p->policy_type = POLICY_BASE;
+	p->policyvers = MOD_POLICYDB_VERSION_MAX;
+	p->mls = mls;
+
+	if (snprintf(filename, PATH_MAX, "policies/test-iter/%s%s", "iter.conf",
+		     mls ? ".mls" : ".std") < 0)
+		goto err;
+
+	if (read_source_policy(p, filename, "test-context-api"))
+		goto err;
+
+	return 0;
+
+err:
+	sepol_policydb_free(policy);
+	policy = NULL;
+	sepol_handle_destroy(handle);
+	handle = NULL;
+	return -1;
+}
+
+int context_api_test_cleanup(void)
+{
+	/*
+	 * Tests in this suite install `policy` as the process-global active
+	 * policydb via sepol_set_policydb(). Reset it before freeing the
+	 * policydb so no dangling global pointer is left behind for other
+	 * test suites (or later runs) to dereference.
+	 */
+	sepol_set_policydb(NULL);
+	sepol_policydb_free(policy);
+	sepol_handle_destroy(handle);
+	return 0;
+}
+
+static void test_values_to_context_string(void)
+{
+	policydb_t *p = &policy->p;
+	user_datum_t *u =
+		hashtab_search(p->p_users.table, (hashtab_key_t) "USER1");
+	role_datum_t *r =
+		hashtab_search(p->p_roles.table, (hashtab_key_t) "ROLE1");
+	type_datum_t *t =
+		hashtab_search(p->p_types.table, (hashtab_key_t) "TYPE1");
+
+	CU_ASSERT_PTR_NOT_NULL_FATAL(u);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(r);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(t);
+
+	char *str = NULL;
+	size_t len = 0;
+	const char *mls_part = mls ? "s0" : NULL;
+
+	CU_ASSERT_EQUAL(sepol_values_to_context_string(
+				handle, policy, u->s.value, r->s.value,
+				t->s.value, mls_part, &str, &len),
+			0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(str);
+
+	if (!mls) {
+		CU_ASSERT_STRING_EQUAL(str, "USER1:ROLE1:TYPE1");
+	} else {
+		CU_ASSERT(strncmp(str, "USER1:ROLE1:TYPE1:", 18) == 0);
+		CU_ASSERT(strlen(str) > 18);
+	}
+
+	free(str);
+}
+
+static void test_values_to_context_record(void)
+{
+	policydb_t *p = &policy->p;
+	user_datum_t *u =
+		hashtab_search(p->p_users.table, (hashtab_key_t) "USER1");
+	role_datum_t *r =
+		hashtab_search(p->p_roles.table, (hashtab_key_t) "ROLE1");
+	type_datum_t *t =
+		hashtab_search(p->p_types.table, (hashtab_key_t) "TYPE1");
+
+	CU_ASSERT_PTR_NOT_NULL_FATAL(u);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(r);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(t);
+
+	sepol_context_t *rec = NULL;
+	const char *mls_part = mls ? "s0" : NULL;
+
+	CU_ASSERT_EQUAL(sepol_values_to_context_record(
+				handle, policy, u->s.value, r->s.value,
+				t->s.value, mls_part, &rec),
+			0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rec);
+
+	CU_ASSERT_STRING_EQUAL(sepol_context_get_user(rec), "USER1");
+	CU_ASSERT_STRING_EQUAL(sepol_context_get_role(rec), "ROLE1");
+	CU_ASSERT_STRING_EQUAL(sepol_context_get_type(rec), "TYPE1");
+	if (mls) {
+		CU_ASSERT_PTR_NOT_NULL(sepol_context_get_mls(rec));
+		CU_ASSERT(strlen(sepol_context_get_mls(rec)) > 0);
+	}
+
+	sepol_context_free(rec);
+}
+
+static void test_sid_to_context_record(void)
+{
+	sidtab_t sidtab;
+
+	memset(&sidtab, 0, sizeof(sidtab));
+	CU_ASSERT_EQUAL(policydb_load_isids(&policy->p, &sidtab), 0);
+
+	sepol_set_policydb(&policy->p);
+	sepol_set_sidtab(&sidtab);
+
+	const char *ctxstr = mls ? "USER1:ROLE1:TYPE1:s0" : "USER1:ROLE1:TYPE1";
+	sepol_security_id_t sid;
+
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_context_to_sid(ctxstr, strlen(ctxstr) + 1, &sid), 0);
+
+	sepol_context_t *rec = NULL;
+	CU_ASSERT_EQUAL(sepol_sid_to_context_record(handle, sid, &rec), 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rec);
+
+	CU_ASSERT_STRING_EQUAL(sepol_context_get_user(rec), "USER1");
+	CU_ASSERT_STRING_EQUAL(sepol_context_get_role(rec), "ROLE1");
+	CU_ASSERT_STRING_EQUAL(sepol_context_get_type(rec), "TYPE1");
+
+	sepol_context_free(rec);
+	sepol_set_sidtab(NULL);
+	sepol_sidtab_destroy(&sidtab);
+}
+
+static void test_sid_table_opaque(void)
+{
+	sepol_sid_table_t *st = sepol_sid_table_new();
+	sepol_sid_table_t *st2;
+
+	CU_ASSERT_PTR_NOT_NULL_FATAL(st);
+	CU_ASSERT_EQUAL(sepol_sid_table_load_isids(st, policy), 0);
+
+	sepol_set_policydb(&policy->p);
+	CU_ASSERT_EQUAL(sepol_sid_table_set_opaque(st), 0);
+
+	st2 = sepol_sid_table_new();
+	CU_ASSERT_PTR_NOT_NULL_FATAL(st2);
+	CU_ASSERT_EQUAL(sepol_sid_table_load_isids(st2, policy), 0);
+	CU_ASSERT_EQUAL(sepol_sid_table_set_opaque(st2), 0);
+
+	sepol_sid_table_free(st);
+
+	const char *ctxstr = mls ? "USER1:ROLE1:TYPE1:s0" : "USER1:ROLE1:TYPE1";
+	sepol_security_id_t sid;
+
+	CU_ASSERT_EQUAL(sepol_context_to_sid(ctxstr, strlen(ctxstr) + 1, &sid),
+			0);
+
+	sepol_context_t *rec = NULL;
+	CU_ASSERT_EQUAL(sepol_sid_to_context_record(handle, sid, &rec), 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rec);
+	sepol_context_free(rec);
+
+	sepol_sid_table_free(st2);
+}
+
+/*
+ * Look up the numeric SID of a declared initial SID by name directly from
+ * the policy's OCON_ISID ocontext list, rather than trying to (re)derive it
+ * via sepol_context_to_sid(): that function resolves against whatever
+ * sidtab happens to be globally installed at the time, and if the exact
+ * context string isn't already present there, it *allocates a brand new,
+ * dynamic SID* rather than an error. Since
+ * sepol_policydb_sid_to_context_string()/_record() (via
+ * policydb_sid_lookup_context()) only ever resolve SIDs against a sidtab
+ * rebuilt strictly from the policy's *declared* initial SIDs
+ * (policydb_load_isids()), a dynamically-minted SID that happens not to
+ * match any declared initial SID's context would never be found there --
+ * that's a test-construction bug, not a libsepol bug. Reading the SID
+ * number straight out of the policy's own ocontexts list sidesteps that
+ * mismatch entirely.
+ */
+static sepol_security_id_t find_isid(const char *name)
+{
+	const ocontext_t *c;
+
+	for (c = policy->p.ocontexts[OCON_ISID]; c; c = c->next) {
+		if (!strcmp(c->u.name, name))
+			return c->sid[0];
+	}
+	CU_FAIL_FATAL("initial SID not found in test policy");
+	return 0;
+}
+
+static void test_policydb_sid_to_context_without_globals(void)
+{
+	/*
+	 * Under MLS, resolve the dedicated "isid_mls_cat" initial SID, whose
+	 * context carries an actual (non-empty) category set: policydb_sid_
+	 * lookup_context() copies the resolved context's MLS range out of a
+	 * temporary sidtab that it destroys before returning, and a category
+	 * set is the only field of context_struct_t that owns its own heap
+	 * allocation (an ebitmap). A context with an empty category set
+	 * would not exercise that allocation at all and would silently pass
+	 * even if the copy were a shallow one sharing (and thus later
+	 * dangling into) the destroyed sidtab's freed ebitmap nodes.
+	 */
+	const char *ctxstr = mls ? "USER1:ROLE1:TYPE1:s0:c0,c1" :
+				   "USER1:ROLE1:TYPE1";
+	sepol_security_id_t sid = find_isid(mls ? "isid_mls_cat" : "kernel");
+	char *str = NULL;
+	size_t len = 0;
+	sepol_context_t *rec = NULL;
+
+	CU_ASSERT_EQUAL(sepol_policydb_sid_to_context_string(handle, policy,
+							     sid, &str, &len),
+			0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(str);
+	CU_ASSERT_STRING_EQUAL(str, ctxstr);
+	free(str);
+
+	CU_ASSERT_EQUAL(sepol_policydb_sid_to_context_record(handle, policy,
+							     sid, &rec),
+			0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rec);
+	CU_ASSERT_STRING_EQUAL(sepol_context_get_user(rec), "USER1");
+	if (mls) {
+		CU_ASSERT_PTR_NOT_NULL(sepol_context_get_mls(rec));
+		CU_ASSERT_STRING_EQUAL(sepol_context_get_mls(rec), "s0:c0,c1");
+	}
+	sepol_context_free(rec);
+}
+
+int context_api_add_tests(CU_pSuite suite)
+{
+	if (CU_add_test(suite, "values_to_context_string",
+			test_values_to_context_string) == NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "values_to_context_record",
+			test_values_to_context_record) == NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "sid_to_context_record",
+			test_sid_to_context_record) == NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "sid_table_opaque", test_sid_table_opaque) ==
+	    NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "policydb_sid_to_context_without_globals",
+			test_policydb_sid_to_context_without_globals) == NULL)
+		return CU_get_error();
+	return 0;
+}
diff --git a/libsepol/tests/test-context-api.h b/libsepol/tests/test-context-api.h
new file mode 100644
index 00000000..fb5ec841
--- /dev/null
+++ b/libsepol/tests/test-context-api.h
@@ -0,0 +1,10 @@
+#ifndef TEST_CONTEXT_API_H
+#define TEST_CONTEXT_API_H
+
+#include <CUnit/Basic.h>
+
+int context_api_test_init(void);
+int context_api_test_cleanup(void);
+int context_api_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.55.0

