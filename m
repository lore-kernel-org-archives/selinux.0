Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB80456E10
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291857; cv=none; b=Vw4UFGRBPcheEEeBgMDzyInkQcDYrwEBtO34sJT4Qt0NJpIwhkaqJMnkMxjkLYl/5onkGVz2HDxN7duSlWG9Db2sIIeTFbaERgpcOqJxBSXtuycJ1sXh4njfe5+ugdr/abmxpZJ+WKwm/5RQwSAPFSqNojGuOxLbDy7U0Ji4ngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291857; c=relaxed/simple;
	bh=Sd/f/8dUIdbiNjxZpm6CYaNHo3SiQ4oBnhuhYO+kwZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gG+gDMjUbiCFuhfS16FBYH79zKePfDhuwZciXLOsKyUGLCwYVbdrVXB3hHIk5T62tYUYojLDpb3IUcva2HNbVYWmqO8IJPNToFg8DJq/9QcnhWEg43nqKm24i2NgAOgZ99WTuNbufQ6YiJm8SVbecYh7SIPlUjIt0WQbWG7IX1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9vMXufw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9vMXufw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62iLKgb2WUNUUkTrGchCYY8tPd3GAZUA5zsNQx1p/a8=;
	b=I9vMXufwPyWJ4w0+lRgckYZcIlx/+B9VXZkq0GWUpWbhj6DYdxUT089i0ZLuqpHqxm+Lxe
	7l6oBTDL0bGtwt1Dd2//wnrJZLS2hzzBsljl5KGrPG4/ufwLCGNkBbzSsUOOgHK4gzb87D
	Lqap+iN1imvcrRlDmQxEFJ2hyt+sSbs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-GIAF4_rNMtyQqUibXsYw2Q-1; Tue,
 6 Oct 2026 13:04:12 +0000
X-MC-Unique: GIAF4_rNMtyQqUibXsYw2Q-1
X-Mimecast-MFC-AGG-ID: GIAF4_rNMtyQqUibXsYw2Q_1791291851
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14313196F746;
	Tue,  6 Oct 2026 13:04:11 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4EBA1956047;
	Tue,  6 Oct 2026 13:04:09 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>,
	Juraj Marcin <juraj@jurajmarcin.com>
Subject: [RFC PATCH userspace 05/17] libsepol: add public user iterator and accessors
Date: Tue,  6 Oct 2026 15:02:03 +0200
Message-ID: <20261006130215.128405-6-jjanasek@redhat.com>
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

Add sepol_user_iter for iterating users, sepol_user_value_to_name()
and sepol_user_query_by_value() for resolving a 1-based user value,
and harden the existing user_record accessors against NULL arguments.

Co-developed-by: Juraj Marcin <juraj@jurajmarcin.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/users.h   |  65 ++++-
 libsepol/src/user_record.c       | 100 +++++++-
 libsepol/src/users.c             | 416 ++++++++++++++++++++++++++++---
 libsepol/tests/test-iter-users.c | 115 +++++++++
 libsepol/tests/test-iter-users.h |   7 +
 libsepol/tests/test-iter.c       |   7 +
 6 files changed, 659 insertions(+), 51 deletions(-)
 create mode 100644 libsepol/tests/test-iter-users.c
 create mode 100644 libsepol/tests/test-iter-users.h

diff --git a/libsepol/include/sepol/users.h b/libsepol/include/sepol/users.h
index d1c7c5ff..e7b90721 100644
--- a/libsepol/include/sepol/users.h
+++ b/libsepol/include/sepol/users.h
@@ -1,16 +1,25 @@
 #ifndef _SEPOL_USERS_H_
 #define _SEPOL_USERS_H_
 
+#include <sepol/cat_set.h>
 #include <sepol/policydb.h>
 #include <sepol/user_record.h>
 #include <sepol/handle.h>
 #include <stddef.h>
+#include <stdint.h>
 
 #ifdef __cplusplus
 extern "C" {
 #endif
 
-/* Modify the user, or add it, if the key is not found */
+struct sepol_user_iter;
+typedef struct sepol_user_iter sepol_user_iter_t;
+
+/* Modify the user, or add it, if the key is not found.
+ * On failure when adding a new user, the user may still have been inserted
+ * into the policydb with an incomplete role set; the policydb remains
+ * memory-safe to use and destroy, but should not be relied upon to be
+ * fully consistent for that user. */
 extern int sepol_user_modify(sepol_handle_t *handle, sepol_policydb_t *policydb,
 			     const sepol_user_key_t *key,
 			     const sepol_user_t *data);
@@ -29,6 +38,17 @@ extern int sepol_user_query(sepol_handle_t *handle, const sepol_policydb_t *p,
 			    const sepol_user_key_t *key,
 			    sepol_user_t **response);
 
+/* Resolve a user value to its name.  Returns non-zero on invalid value.
+ * The returned pointer is borrowed from the policydb; do not free. */
+extern int sepol_user_value_to_name(sepol_handle_t *handle,
+				    const sepol_policydb_t *p, uint32_t value,
+				    const char **name);
+
+/* Query a user by value - returns the user or NULL if not found */
+extern int sepol_user_query_by_value(sepol_handle_t *handle,
+				     const sepol_policydb_t *p, uint32_t value,
+				     sepol_user_t **response);
+
 /* Iterate the users
  * The handler may return:
  * -1 to signal an error condition,
@@ -39,6 +59,49 @@ extern int sepol_user_iterate(sepol_handle_t *handle,
 			      int (*fn)(const sepol_user_t *user, void *fn_arg),
 			      void *arg);
 
+/*
+ * Users iterator. Iteration order follows ascending internal value
+ * assignment, which typically -- but is not guaranteed to -- match
+ * declaration order; callers should not treat it as a stable guarantee
+ * across policydb versions.
+ */
+extern int sepol_user_iter_create(sepol_handle_t *handle,
+				  const sepol_policydb_t *p,
+				  sepol_user_iter_t **iter);
+extern void sepol_user_iter_destroy(sepol_user_iter_t *iter);
+extern int sepol_user_iter_next(sepol_handle_t *handle, sepol_user_iter_t *iter,
+				sepol_user_t **item);
+
+extern uint32_t sepol_user_get_dflt_level_sens(const sepol_policydb_t *p,
+					       uint32_t user_value);
+
+/*
+ * NOTE on sepol_cat_set_iter_t **cat_iter parameters below: see the
+ * ownership contract documented in cat_set.h. The callee always allocates
+ * a new, caller-owned iterator that must be freed with
+ * sepol_cat_set_iter_destroy().
+ */
+extern int sepol_user_get_dflt_level_cat(sepol_handle_t *handle,
+					 const sepol_policydb_t *p,
+					 uint32_t user_value,
+					 sepol_cat_set_iter_t **cat_iter);
+
+extern uint32_t sepol_user_get_range_low_sens(const sepol_policydb_t *p,
+					      uint32_t user_value);
+
+extern uint32_t sepol_user_get_range_high_sens(const sepol_policydb_t *p,
+					       uint32_t user_value);
+
+extern int sepol_user_get_range_low_cat(sepol_handle_t *handle,
+					const sepol_policydb_t *p,
+					uint32_t user_value,
+					sepol_cat_set_iter_t **cat_iter);
+
+extern int sepol_user_get_range_high_cat(sepol_handle_t *handle,
+					 const sepol_policydb_t *p,
+					 uint32_t user_value,
+					 sepol_cat_set_iter_t **cat_iter);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libsepol/src/user_record.c b/libsepol/src/user_record.c
index 4e14cbd4..87b2c629 100644
--- a/libsepol/src/user_record.c
+++ b/libsepol/src/user_record.c
@@ -1,4 +1,5 @@
 #include <errno.h>
+#include <limits.h>
 #include <stdlib.h>
 #include <string.h>
 
@@ -31,12 +32,21 @@ struct sepol_user_key {
 int sepol_user_key_create(sepol_handle_t *handle, const char *name,
 			  sepol_user_key_t **key_ptr)
 {
+	if (!key_ptr)
+		return STATUS_ERR;
+	if (!name) {
+		ERR(handle, "name is NULL");
+		*key_ptr = NULL;
+		return STATUS_ERR;
+	}
+
 	sepol_user_key_t *tmp_key =
 		(sepol_user_key_t *)malloc(sizeof(sepol_user_key_t));
 
 	if (!tmp_key) {
 		ERR(handle, "out of memory, "
 			    "could not create selinux user key");
+		*key_ptr = NULL;
 		return STATUS_ERR;
 	}
 
@@ -44,6 +54,7 @@ int sepol_user_key_create(sepol_handle_t *handle, const char *name,
 	if (!tmp_key->name) {
 		ERR(handle, "out of memory, could not create selinux user key");
 		free(tmp_key);
+		*key_ptr = NULL;
 		return STATUS_ERR;
 	}
 
@@ -53,12 +64,17 @@ int sepol_user_key_create(sepol_handle_t *handle, const char *name,
 
 void sepol_user_key_unpack(const sepol_user_key_t *key, const char **name)
 {
-	*name = key->name;
+	*name = key ? key->name : NULL;
 }
 
 int sepol_user_key_extract(sepol_handle_t *handle, const sepol_user_t *user,
 			   sepol_user_key_t **key_ptr)
 {
+	if (!user || !user->name) {
+		ERR(handle, "user name is NULL");
+		return STATUS_ERR;
+	}
+
 	if (sepol_user_key_create(handle, user->name, key_ptr) < 0) {
 		ERR(handle, "could not extract key from user %s", user->name);
 		return STATUS_ERR;
@@ -77,23 +93,31 @@ void sepol_user_key_free(sepol_user_key_t *key)
 
 int sepol_user_compare(const sepol_user_t *user, const sepol_user_key_t *key)
 {
+	if (!user || !key || !user->name || !key->name)
+		return -1;
 	return strcmp(user->name, key->name);
 }
 
 int sepol_user_compare2(const sepol_user_t *user, const sepol_user_t *user2)
 {
+	if (!user || !user2 || !user->name || !user2->name)
+		return -1;
 	return strcmp(user->name, user2->name);
 }
 
 /* Name */
 const char *sepol_user_get_name(const sepol_user_t *user)
 {
-	return user->name;
+	return user ? user->name : NULL;
 }
 
 int sepol_user_set_name(sepol_handle_t *handle, sepol_user_t *user,
 			const char *name)
 {
+	if (!user || !name) {
+		ERR(handle, "user or name is NULL");
+		return STATUS_ERR;
+	}
 	char *tmp_name = strdup(name);
 	if (!tmp_name) {
 		ERR(handle, "out of memory, could not set name");
@@ -107,12 +131,16 @@ int sepol_user_set_name(sepol_handle_t *handle, sepol_user_t *user,
 /* MLS */
 const char *sepol_user_get_mlslevel(const sepol_user_t *user)
 {
-	return user->mls_level;
+	return user ? user->mls_level : NULL;
 }
 
 int sepol_user_set_mlslevel(sepol_handle_t *handle, sepol_user_t *user,
 			    const char *mls_level)
 {
+	if (!user || !mls_level) {
+		ERR(handle, "user or mls_level is NULL");
+		return STATUS_ERR;
+	}
 	char *tmp_mls_level = strdup(mls_level);
 	if (!tmp_mls_level) {
 		ERR(handle, "out of memory, "
@@ -126,12 +154,16 @@ int sepol_user_set_mlslevel(sepol_handle_t *handle, sepol_user_t *user,
 
 const char *sepol_user_get_mlsrange(const sepol_user_t *user)
 {
-	return user->mls_range;
+	return user ? user->mls_range : NULL;
 }
 
 int sepol_user_set_mlsrange(sepol_handle_t *handle, sepol_user_t *user,
 			    const char *mls_range)
 {
+	if (!user || !mls_range) {
+		ERR(handle, "user or mls_range is NULL");
+		return STATUS_ERR;
+	}
 	char *tmp_mls_range = strdup(mls_range);
 	if (!tmp_mls_range) {
 		ERR(handle, "out of memory, "
@@ -146,18 +178,26 @@ int sepol_user_set_mlsrange(sepol_handle_t *handle, sepol_user_t *user,
 /* Roles */
 int sepol_user_get_num_roles(const sepol_user_t *user)
 {
-	return user->num_roles;
+	return user ? (int)user->num_roles : 0;
 }
 
 int sepol_user_add_role(sepol_handle_t *handle, sepol_user_t *user,
 			const char *role)
 {
-	char *role_cp;
+	char *role_cp = NULL;
 	char **roles_realloc = NULL;
 
+	if (!user || !role) {
+		ERR(handle, "user or role is NULL");
+		return STATUS_ERR;
+	}
+
 	if (sepol_user_has_role(user, role))
 		return STATUS_SUCCESS;
 
+	if (user->num_roles == UINT_MAX)
+		goto omem;
+
 	role_cp = strdup(role);
 	if (!role_cp)
 		goto omem;
@@ -184,6 +224,9 @@ int sepol_user_has_role(const sepol_user_t *user, const char *role)
 {
 	unsigned int i;
 
+	if (!user || !role)
+		return 0;
+
 	for (i = 0; i < user->num_roles; i++)
 		if (!strcmp(user->roles[i], role))
 			return 1;
@@ -196,9 +239,14 @@ int sepol_user_set_roles(sepol_handle_t *handle, sepol_user_t *user,
 	unsigned int i;
 	char **tmp_roles = NULL;
 
+	if (!user || (num_roles > 0 && !roles_arr)) {
+		ERR(handle, "user or roles_arr is NULL");
+		return STATUS_ERR;
+	}
+
 	if (num_roles > 0) {
 		/* First, make a copy */
-		tmp_roles = (char **)calloc(1, sizeof(char *) * num_roles);
+		tmp_roles = (char **)calloc(num_roles, sizeof(char *));
 		if (!tmp_roles)
 			goto omem;
 
@@ -238,8 +286,23 @@ int sepol_user_get_roles(sepol_handle_t *handle, const sepol_user_t *user,
 			 const char ***roles_arr, unsigned int *num_roles)
 {
 	unsigned int i;
-	const char **tmp_roles =
-		(const char **)calloc(user->num_roles, sizeof(char *));
+	const char **tmp_roles;
+
+	if (!roles_arr || !num_roles)
+		return STATUS_ERR;
+	if (!user) {
+		*roles_arr = NULL;
+		*num_roles = 0;
+		return STATUS_ERR;
+	}
+
+	if (user->num_roles == 0) {
+		*roles_arr = NULL;
+		*num_roles = 0;
+		return STATUS_SUCCESS;
+	}
+
+	tmp_roles = (const char **)calloc(user->num_roles, sizeof(char *));
 	if (!tmp_roles)
 		goto omem;
 
@@ -262,6 +325,10 @@ omem:
 void sepol_user_del_role(sepol_user_t *user, const char *role)
 {
 	unsigned int i;
+
+	if (!user || !role)
+		return;
+
 	for (i = 0; i < user->num_roles; i++) {
 		if (!strcmp(user->roles[i], role)) {
 			free(user->roles[i]);
@@ -275,11 +342,16 @@ void sepol_user_del_role(sepol_user_t *user, const char *role)
 /* Create */
 int sepol_user_create(sepol_handle_t *handle, sepol_user_t **user_ptr)
 {
-	sepol_user_t *user = (sepol_user_t *)malloc(sizeof(sepol_user_t));
+	sepol_user_t *user;
+
+	if (!user_ptr)
+		return STATUS_ERR;
 
+	user = (sepol_user_t *)malloc(sizeof(sepol_user_t));
 	if (!user) {
 		ERR(handle, "out of memory, "
 			    "could not create selinux user record");
+		*user_ptr = NULL;
 		return STATUS_ERR;
 	}
 
@@ -300,6 +372,13 @@ int sepol_user_clone(sepol_handle_t *handle, const sepol_user_t *user,
 	sepol_user_t *new_user = NULL;
 	unsigned int i;
 
+	if (!user_ptr)
+		return STATUS_ERR;
+	if (!user) {
+		*user_ptr = NULL;
+		return STATUS_ERR;
+	}
+
 	if (sepol_user_create(handle, &new_user) < 0)
 		goto err;
 
@@ -325,6 +404,7 @@ int sepol_user_clone(sepol_handle_t *handle, const sepol_user_t *user,
 err:
 	ERR(handle, "could not clone selinux user record");
 	sepol_user_free(new_user);
+	*user_ptr = NULL;
 	return STATUS_ERR;
 }
 
diff --git a/libsepol/src/users.c b/libsepol/src/users.c
index bd257dcd..d3e045ce 100644
--- a/libsepol/src/users.c
+++ b/libsepol/src/users.c
@@ -1,3 +1,6 @@
+#include <sepol/users.h>
+
+#include <stdint.h>
 #include <stdlib.h>
 #include <stddef.h>
 #include <string.h>
@@ -9,20 +12,33 @@
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/expand.h>
+#include "sepol/policydb/util.h"
 #include "user_internal.h"
+#include "cat_set_internal.h"
 #include "mls.h"
 
+struct sepol_user_iter {
+	const policydb_t *policydb;
+	uint32_t idx;
+};
+
 static int user_to_record(sepol_handle_t *handle, const policydb_t *policydb,
-			  int user_idx, sepol_user_t **record)
+			  uint32_t user_idx, sepol_user_t **record)
 {
-	const char *name = policydb->p_user_val_to_name[user_idx];
-	user_datum_t *usrdatum = policydb->user_val_to_struct[user_idx];
+	const char *name;
+	user_datum_t *usrdatum;
 	ebitmap_t *roles;
 	ebitmap_node_t *rnode;
 	unsigned bit;
 
 	sepol_user_t *tmp_record = NULL;
 
+	if (user_idx >= policydb->p_users.nprim)
+		goto err;
+
+	name = policydb->p_user_val_to_name[user_idx];
+	usrdatum = policydb->user_val_to_struct[user_idx];
+
 	if (!usrdatum)
 		goto err;
 
@@ -36,6 +52,8 @@ static int user_to_record(sepol_handle_t *handle, const policydb_t *policydb,
 
 	/* Extract roles */
 	ebitmap_for_each_positive_bit(roles, rnode, bit) {
+		if (bit >= policydb->p_roles.nprim)
+			goto err;
 		char *role = policydb->p_role_val_to_name[bit];
 		if (sepol_user_add_role(handle, tmp_record, role) < 0)
 			goto err;
@@ -94,7 +112,7 @@ static int user_to_record(sepol_handle_t *handle, const policydb_t *policydb,
 	return STATUS_SUCCESS;
 
 err:
-	/* FIXME: handle error */
+	*record = NULL;
 	sepol_user_free(tmp_record);
 	return STATUS_ERR;
 }
@@ -102,7 +120,7 @@ err:
 int sepol_user_modify(sepol_handle_t *handle, sepol_policydb_t *p,
 		      const sepol_user_key_t *key, const sepol_user_t *user)
 {
-	policydb_t *policydb = &p->p;
+	policydb_t *policydb;
 
 	/* For user data */
 	const char *cname, *cmls_level, *cmls_range;
@@ -116,14 +134,45 @@ int sepol_user_modify(sepol_handle_t *handle, sepol_policydb_t *p,
 	role_datum_t *roldatum;
 	unsigned int i;
 
+	hashtab_key_t scope_key = NULL;
+	scope_datum_t *scope_datum = NULL;
+
 	context_struct_t context;
 	unsigned bit;
 	int new = 0;
+	int have_mls = 0;
 
 	ebitmap_node_t *rnode;
 
+	/*
+	 * Resolved/validated new state, built up before touching any
+	 * existing user_datum. This way a validation failure (e.g. an
+	 * undefined role name, or a malformed MLS level/range -- both
+	 * trivially caused by a bad caller argument, not just OOM) never
+	 * leaves a previously-valid user blanked out or partially updated
+	 * in the live policydb.
+	 */
+	ebitmap_t new_roles;
+	ebitmap_t new_cache;
+	mls_level_t new_dfltlevel;
+	mls_range_t new_range;
+
+	ebitmap_init(&new_roles);
+	ebitmap_init(&new_cache);
+	mls_level_init(&new_dfltlevel);
+	mls_range_init(&new_range);
+
+	if (!handle || !p || !key || !user)
+		return STATUS_ERR;
+
+	policydb = &p->p;
+
 	/* First, extract all the data */
 	sepol_user_key_unpack(key, &cname);
+	if (!cname) {
+		ERR(handle, "user key name is NULL");
+		return STATUS_ERR;
+	}
 
 	cmls_level = sepol_user_get_mlslevel(user);
 	cmls_range = sepol_user_get_mlsrange(user);
@@ -132,25 +181,6 @@ int sepol_user_modify(sepol_handle_t *handle, sepol_policydb_t *p,
 	if (sepol_user_get_roles(handle, user, &roles, &num_roles) < 0)
 		goto err;
 
-	/* Now, see if a user exists */
-	usrdatum = hashtab_search(policydb->p_users.table, cname);
-
-	/* If it does, we will modify it */
-	if (usrdatum) {
-		int value_cp = usrdatum->s.value;
-		user_datum_destroy(usrdatum);
-		user_datum_init(usrdatum);
-		usrdatum->s.value = value_cp;
-
-		/* Otherwise, create a new one */
-	} else {
-		usrdatum = (user_datum_t *)malloc(sizeof(user_datum_t));
-		if (!usrdatum)
-			goto omem;
-		user_datum_init(usrdatum);
-		new = 1;
-	}
-
 	/* For every role */
 	for (i = 0; i < num_roles; i++) {
 		/* Search for the role */
@@ -164,7 +194,7 @@ int sepol_user_modify(sepol_handle_t *handle, sepol_policydb_t *p,
 		/* Set the role and every role it dominates */
 		ebitmap_for_each_positive_bit(&roldatum->dominates, rnode,
 					      bit) {
-			if (ebitmap_set_bit(&(usrdatum->roles.roles), bit, 1))
+			if (ebitmap_set_bit(&new_roles, bit, 1))
 				goto omem;
 		}
 	}
@@ -186,8 +216,8 @@ int sepol_user_modify(sepol_handle_t *handle, sepol_policydb_t *p,
 			context_destroy(&context);
 			goto err;
 		}
-		if (mls_level_cpy(&usrdatum->exp_dfltlevel,
-				  &context.range.level[0]) < 0) {
+		if (mls_level_cpy(&new_dfltlevel, &context.range.level[0]) <
+		    0) {
 			ERR(handle, "could not copy MLS level %s", cmls_level);
 			context_destroy(&context);
 			goto err;
@@ -197,7 +227,7 @@ int sepol_user_modify(sepol_handle_t *handle, sepol_policydb_t *p,
 		/* MLS range */
 		if (cmls_range == NULL) {
 			ERR(handle,
-			    "MLS is enabled, but no MLS"
+			    "MLS is enabled, but no MLS "
 			    "range was defined for user %s",
 			    cname);
 			goto err;
@@ -209,12 +239,14 @@ int sepol_user_modify(sepol_handle_t *handle, sepol_policydb_t *p,
 			context_destroy(&context);
 			goto err;
 		}
-		if (mls_range_cpy(&usrdatum->exp_range, &context.range) < 0) {
+		if (mls_range_cpy(&new_range, &context.range) < 0) {
 			ERR(handle, "could not copy MLS range %s", cmls_range);
 			context_destroy(&context);
 			goto err;
 		}
 		context_destroy(&context);
+
+		have_mls = 1;
 	} else if (cmls_level != NULL || cmls_range != NULL) {
 		ERR(handle,
 		    "MLS is disabled, but MLS level/range "
@@ -223,10 +255,97 @@ int sepol_user_modify(sepol_handle_t *handle, sepol_policydb_t *p,
 		goto err;
 	}
 
+	/*
+	 * Pre-compute the expanded role cache from the validated,
+	 * already-fully-expanded new_roles bitmap (flags=0, so this is
+	 * just an OOM-checked deep copy -- see role_set_expand()). Doing
+	 * this before touching the live user_datum means a failure here
+	 * (the only way role_set_expand can fail with flags=0 and no
+	 * rolemap) never leaves an existing, previously-valid user with
+	 * its roles/MLS replaced but its cache blanked.
+	 */
+	{
+		role_set_t tmp_role_set = { .roles = new_roles, .flags = 0 };
+		if (role_set_expand(&tmp_role_set, &new_cache, policydb, NULL,
+				    NULL)) {
+			ERR(handle, "unable to expand role set for user %s",
+			    cname);
+			goto omem;
+		}
+	}
+
+	/*
+	 * All names and MLS strings are validated; only now do we look up
+	 * (and possibly destroy/reinitialize) the target user_datum.
+	 */
+	usrdatum = hashtab_search(policydb->p_users.table, cname);
+
+	/* If it does, we will modify it */
+	if (usrdatum) {
+		uint32_t value_cp = usrdatum->s.value;
+		user_datum_destroy(usrdatum);
+		user_datum_init(usrdatum);
+		usrdatum->s.value = value_cp;
+
+		/* Otherwise, create a new one */
+	} else {
+		usrdatum = (user_datum_t *)malloc(sizeof(user_datum_t));
+		if (!usrdatum)
+			goto omem;
+		user_datum_init(usrdatum);
+		new = 1;
+	}
+
+	/* Transfer ownership of the validated roles/MLS/cache data to usrdatum */
+	usrdatum->roles.roles = new_roles;
+	ebitmap_init(&new_roles);
+	usrdatum->cache = new_cache;
+	ebitmap_init(&new_cache);
+	if (have_mls) {
+		usrdatum->exp_dfltlevel = new_dfltlevel;
+		usrdatum->exp_range = new_range;
+		mls_level_init(&new_dfltlevel);
+		mls_range_init(&new_range);
+	}
+
 	/* If there are no errors, and this is a new user, add the user to policy */
 	if (new) {
 		void *tmp_ptr;
 
+		if (policydb->p_users.nprim == UINT32_MAX) {
+			ERR(handle, "too many users");
+			goto err;
+		}
+
+		/*
+		 * Prepare (but do not yet insert) a scope_datum for the new
+		 * user up front, mirroring sepol_type_modify()'s scope
+		 * bookkeeping in types.c (which in turn mirrors
+		 * symtab_insert() in policydb.c): without a scope_datum,
+		 * is_id_enabled() (avrule_block.c) treats a user as "not
+		 * declared", so it would otherwise be silently dropped by
+		 * any later expand_module()/link_modules() call even though
+		 * it is fully present in p_users/user_val_to_struct. A user
+		 * added through this public API is always an unconditional,
+		 * top-level declaration -- there is no avrule-block/
+		 * conditional context here -- which is exactly decl_id 1,
+		 * the id checkpolicy assigns to the first declaration of a
+		 * policy's global avrule block (see module_compiler.c's
+		 * init_decl_stack()).
+		 */
+		scope_key = strdup(cname);
+		if (!scope_key)
+			goto omem;
+		scope_datum = malloc(sizeof(*scope_datum));
+		if (!scope_datum)
+			goto omem;
+		scope_datum->scope = SCOPE_DECL;
+		scope_datum->decl_ids = NULL;
+		scope_datum->decl_ids_len = 0;
+		if (add_i_to_a(1, &scope_datum->decl_ids_len,
+			       &scope_datum->decl_ids) == -1)
+			goto omem;
+
 		/* Ensure reverse lookup array has enough space */
 		tmp_ptr = reallocarray(policydb->user_val_to_struct,
 				       policydb->p_users.nprim + 1,
@@ -250,22 +369,36 @@ int sepol_user_modify(sepol_handle_t *handle, sepol_policydb_t *p,
 			goto omem;
 
 		/* Store user */
-		usrdatum->s.value = ++policydb->p_users.nprim;
+		usrdatum->s.value = policydb->p_users.nprim + 1;
 		if (hashtab_insert(policydb->p_users.table, name,
 				   (hashtab_datum_t)usrdatum) < 0)
 			goto omem;
+		policydb->p_users.nprim++;
 
 		/* Set up reverse entry */
 		policydb->p_user_val_to_name[usrdatum->s.value - 1] = name;
 		policydb->user_val_to_struct[usrdatum->s.value - 1] = usrdatum;
 		name = NULL;
 
-		/* Expand roles */
-		if (role_set_expand(&usrdatum->roles, &usrdatum->cache,
-				    policydb, NULL, NULL)) {
-			ERR(handle, "unable to expand role set");
-			goto err;
-		}
+		/* policydb now owns usrdatum; prevent error path from freeing */
+		new = 0;
+
+		/*
+		 * The user itself is now fully committed above; register
+		 * its scope so it survives a later expand/link pass. This
+		 * insert can only fail on OOM here -- scope[SYM_USERS].table
+		 * and p_users.table are kept in lockstep by every insertion
+		 * path in this file and in policydb.c, so `cname` cannot
+		 * already be present. On that (OOM) failure the user is
+		 * left in the pre-existing documented, memory-safe-but-
+		 * inconsistent partially-populated state described in
+		 * users.h.
+		 */
+		if (hashtab_insert(policydb->scope[SYM_USERS].table, scope_key,
+				   scope_datum) < 0)
+			goto omem;
+		scope_key = NULL;
+		scope_datum = NULL;
 	}
 
 	free(roles);
@@ -275,27 +408,66 @@ omem:
 	ERR(handle, "out of memory");
 
 err:
-	ERR(handle, "could not load %s into policy", name);
+	ERR(handle, "could not load %s into policy", cname);
 
 	free(name);
 	free(roles);
+	ebitmap_destroy(&new_roles);
+	ebitmap_destroy(&new_cache);
+	mls_level_destroy(&new_dfltlevel);
+	mls_range_destroy(&new_range);
+	free(scope_key);
+	if (scope_datum) {
+		free(scope_datum->decl_ids);
+		free(scope_datum);
+	}
 	if (new && usrdatum) {
-		role_set_destroy(&usrdatum->roles);
+		user_datum_destroy(usrdatum);
 		free(usrdatum);
 	}
 	return STATUS_ERR;
 }
 
+DEFINE_VALUE_TO_NAME(sepol_user_value_to_name, "user", p_users,
+		     p_user_val_to_name)
+
+int sepol_user_query_by_value(sepol_handle_t *handle, const sepol_policydb_t *p,
+			      uint32_t value, sepol_user_t **response)
+{
+	if (!response)
+		return STATUS_ERR;
+	if (!p) {
+		*response = NULL;
+		return STATUS_ERR;
+	}
+
+	if (value < 1 || value > p->p.p_users.nprim) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	if (!p->p.user_val_to_struct[value - 1]) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	return user_to_record(handle, &p->p, value - 1, response);
+}
+
 int sepol_user_exists(sepol_handle_t *handle __attribute__((unused)),
 		      const sepol_policydb_t *p, const sepol_user_key_t *key,
 		      int *response)
 {
+	if (!p || !response)
+		return STATUS_ERR;
+
 	const policydb_t *policydb = &p->p;
 
 	const char *cname;
 	sepol_user_key_unpack(key, &cname);
 
-	*response = (hashtab_search(policydb->p_users.table, cname) != NULL);
+	*response = cname &&
+		    (hashtab_search(policydb->p_users.table, cname) != NULL);
 
 	return STATUS_SUCCESS;
 }
@@ -303,8 +475,11 @@ int sepol_user_exists(sepol_handle_t *handle __attribute__((unused)),
 int sepol_user_count(sepol_handle_t *handle __attribute__((unused)),
 		     const sepol_policydb_t *p, unsigned int *response)
 {
+	if (!p || !response)
+		return STATUS_ERR;
+
 	const policydb_t *policydb = &p->p;
-	*response = policydb->p_users.nprim;
+	*response = policydb->p_users.table->nel;
 
 	return STATUS_SUCCESS;
 }
@@ -312,12 +487,24 @@ int sepol_user_count(sepol_handle_t *handle __attribute__((unused)),
 int sepol_user_query(sepol_handle_t *handle, const sepol_policydb_t *p,
 		     const sepol_user_key_t *key, sepol_user_t **response)
 {
+	if (!response)
+		return STATUS_ERR;
+	if (!p) {
+		*response = NULL;
+		return STATUS_ERR;
+	}
+
 	const policydb_t *policydb = &p->p;
 	user_datum_t *usrdatum = NULL;
 
 	const char *cname;
 	sepol_user_key_unpack(key, &cname);
 
+	if (!cname) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
 	usrdatum = hashtab_search(policydb->p_users.table, cname);
 
 	if (!usrdatum) {
@@ -340,6 +527,11 @@ int sepol_user_iterate(sepol_handle_t *handle, const sepol_policydb_t *p,
 		       int (*fn)(const sepol_user_t *user, void *fn_arg),
 		       void *arg)
 {
+	if (!p || !fn) {
+		ERR(handle, "policydb or callback is NULL");
+		return STATUS_ERR;
+	}
+
 	const policydb_t *policydb = &p->p;
 	unsigned int nusers = policydb->p_users.nprim;
 	sepol_user_t *user = NULL;
@@ -372,3 +564,147 @@ err:
 	sepol_user_free(user);
 	return STATUS_ERR;
 }
+
+/* Users iterator */
+int sepol_user_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			   sepol_user_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_user_iter_t *new_iter = malloc(sizeof(sepol_user_iter_t));
+	if (!new_iter) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+	new_iter->policydb = &p->p;
+	new_iter->idx = 0;
+
+	*iter = new_iter;
+	return STATUS_SUCCESS;
+}
+
+void sepol_user_iter_destroy(sepol_user_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_user_iter_next(sepol_handle_t *handle, sepol_user_iter_t *iter,
+			 sepol_user_t **item)
+{
+	if (!item)
+		return STATUS_ERR;
+	if (!iter) {
+		*item = NULL;
+		return STATUS_ERR;
+	}
+
+	while (iter->idx < iter->policydb->p_users.nprim) {
+		unsigned int idx = iter->idx;
+		iter->idx++;
+		if (iter->policydb->user_val_to_struct[idx]) {
+			sepol_user_t *user;
+			int status = user_to_record(handle, iter->policydb, idx,
+						    &user);
+			*item = user;
+			if (status)
+				return status;
+			return STATUS_SUCCESS;
+		}
+	}
+
+	*item = NULL;
+	return STATUS_SUCCESS;
+}
+
+static const user_datum_t *user_datum_by_value(const sepol_policydb_t *p,
+					       uint32_t value)
+{
+	if (!p || value < 1 || value > p->p.p_users.nprim)
+		return NULL;
+	return p->p.user_val_to_struct[value - 1];
+}
+
+uint32_t sepol_user_get_dflt_level_sens(const sepol_policydb_t *p,
+					uint32_t user_value)
+{
+	const user_datum_t *u = user_datum_by_value(p, user_value);
+	if (!u)
+		return 0;
+	return u->exp_dfltlevel.sens;
+}
+
+int sepol_user_get_dflt_level_cat(sepol_handle_t *handle
+				  __attribute__((unused)),
+				  const sepol_policydb_t *p,
+				  uint32_t user_value,
+				  sepol_cat_set_iter_t **cat_iter)
+{
+	if (!cat_iter)
+		return STATUS_ERR;
+
+	const user_datum_t *u = user_datum_by_value(p, user_value);
+	if (!u) {
+		*cat_iter = NULL;
+		return STATUS_SUCCESS;
+	}
+	return cat_set_iter_create_from_ebitmap(&u->exp_dfltlevel.cat,
+						cat_iter);
+}
+
+uint32_t sepol_user_get_range_low_sens(const sepol_policydb_t *p,
+				       uint32_t user_value)
+{
+	const user_datum_t *u = user_datum_by_value(p, user_value);
+	if (!u)
+		return 0;
+	return u->exp_range.level[0].sens;
+}
+
+uint32_t sepol_user_get_range_high_sens(const sepol_policydb_t *p,
+					uint32_t user_value)
+{
+	const user_datum_t *u = user_datum_by_value(p, user_value);
+	if (!u)
+		return 0;
+	return u->exp_range.level[1].sens;
+}
+
+int sepol_user_get_range_low_cat(sepol_handle_t *handle __attribute__((unused)),
+				 const sepol_policydb_t *p, uint32_t user_value,
+				 sepol_cat_set_iter_t **cat_iter)
+{
+	if (!cat_iter)
+		return STATUS_ERR;
+
+	const user_datum_t *u = user_datum_by_value(p, user_value);
+	if (!u) {
+		*cat_iter = NULL;
+		return STATUS_SUCCESS;
+	}
+	return cat_set_iter_create_from_ebitmap(&u->exp_range.level[0].cat,
+						cat_iter);
+}
+
+int sepol_user_get_range_high_cat(sepol_handle_t *handle
+				  __attribute__((unused)),
+				  const sepol_policydb_t *p,
+				  uint32_t user_value,
+				  sepol_cat_set_iter_t **cat_iter)
+{
+	if (!cat_iter)
+		return STATUS_ERR;
+
+	const user_datum_t *u = user_datum_by_value(p, user_value);
+	if (!u) {
+		*cat_iter = NULL;
+		return STATUS_SUCCESS;
+	}
+	return cat_set_iter_create_from_ebitmap(&u->exp_range.level[1].cat,
+						cat_iter);
+}
diff --git a/libsepol/tests/test-iter-users.c b/libsepol/tests/test-iter-users.c
new file mode 100644
index 00000000..626a26f4
--- /dev/null
+++ b/libsepol/tests/test-iter-users.c
@@ -0,0 +1,115 @@
+#include "test-iter-users.h"
+#include "helpers.h"
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <sepol/types.h>
+#include <sepol/user_record.h>
+#include <sepol/users.h>
+#include <CUnit/CUnit.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+extern sepol_handle_t *handle;
+extern sepol_policydb_t *empty_policy;
+extern sepol_policydb_t *iter_policy;
+
+struct expected_user {
+	int seen;
+
+	const char *name;
+	const char *mls_level;
+	const char *mls_range;
+	size_t nroles;
+	const char *roles[32];
+};
+
+struct expected_user expected_users[] = {
+	{ 0, "USER1", "s0", "s0-s0:c0.c3", 1, { "ROLE1" } },
+	{ 0, NULL, NULL, NULL, 0, {} },
+};
+
+static void unseen(void)
+{
+	for (struct expected_user *e = expected_users; e->name; e++) {
+		e->seen = 0;
+	}
+}
+
+static void seen(sepol_user_t *item)
+{
+	const char *actual_name = sepol_user_get_name(item);
+	const char *actual_mls_level = sepol_user_get_mlslevel(item);
+	const char *actual_mls_range = sepol_user_get_mlsrange(item);
+	uint32_t nactual_roles;
+	const char **actual_roles;
+	CU_ASSERT_EQUAL_FATAL(sepol_user_get_roles(handle, item, &actual_roles,
+						   &nactual_roles),
+			      0);
+
+	struct expected_user *e;
+	for (e = expected_users; e->name; e++) {
+		if (!strcmp(actual_name, e->name))
+			break;
+	}
+	CU_ASSERT_PTR_NOT_NULL_FATAL(e->name);
+	e->seen = 1;
+
+	if (iter_policy->p.mls) {
+		CU_ASSERT_STRING_EQUAL(actual_mls_level, e->mls_level);
+		CU_ASSERT_STRING_EQUAL(actual_mls_range, e->mls_range);
+	}
+
+	CU_ASSERT_EQUAL(nactual_roles, e->nroles);
+	/* qsort()'s base is declared nonnull; skip the call entirely for
+	 * an empty (possibly NULL) array rather than relying on nmemb==0
+	 * making the NULL harmless. */
+	if (nactual_roles > 0)
+		qsort(actual_roles, nactual_roles, sizeof(char *), qstrcmp);
+	for (size_t i = 0; i < nactual_roles && i < e->nroles; i++) {
+		CU_ASSERT_STRING_EQUAL(actual_roles[i], e->roles[i]);
+	}
+
+	free(actual_roles);
+}
+
+void test_iter_users_empty(void)
+{
+	unseen();
+	sepol_user_iter_t *iter;
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_user_iter_create(handle, empty_policy, &iter), 0);
+
+	sepol_user_t *item;
+	CU_ASSERT_EQUAL(sepol_user_iter_next(handle, iter, &item), 0);
+	CU_ASSERT_PTR_NULL(item);
+	/* all values after end should return NULL as item */
+	CU_ASSERT_EQUAL(sepol_user_iter_next(handle, iter, &item), 0);
+	CU_ASSERT_PTR_NULL(item);
+
+	sepol_user_iter_destroy(iter);
+}
+
+void test_iter_users_non_empty(void)
+{
+	unseen();
+	sepol_user_iter_t *iter;
+	CU_ASSERT_EQUAL_FATAL(
+		sepol_user_iter_create(handle, iter_policy, &iter), 0);
+
+	sepol_user_t *item;
+	while (1) {
+		CU_ASSERT_EQUAL(sepol_user_iter_next(handle, iter, &item), 0);
+		if (!item)
+			break;
+		seen(item);
+		sepol_user_free(item);
+	}
+	CU_ASSERT_EQUAL(sepol_user_iter_next(handle, iter, &item), 0);
+	CU_ASSERT_PTR_NULL(item);
+
+	for (struct expected_user *e = expected_users; e->name; e++) {
+		CU_ASSERT_TRUE(e->seen);
+	}
+
+	sepol_user_iter_destroy(iter);
+}
diff --git a/libsepol/tests/test-iter-users.h b/libsepol/tests/test-iter-users.h
new file mode 100644
index 00000000..de6cb6ee
--- /dev/null
+++ b/libsepol/tests/test-iter-users.h
@@ -0,0 +1,7 @@
+#ifndef TEST_ITER_USERS_H
+#define TEST_ITER_USERS_H
+
+void test_iter_users_empty(void);
+void test_iter_users_non_empty(void);
+
+#endif
diff --git a/libsepol/tests/test-iter.c b/libsepol/tests/test-iter.c
index f9b8880f..83308d4d 100644
--- a/libsepol/tests/test-iter.c
+++ b/libsepol/tests/test-iter.c
@@ -11,6 +11,7 @@
 
 #include "parse_util.h"
 #include "test-iter-types.h"
+#include "test-iter-users.h"
 
 extern int mls;
 
@@ -92,5 +93,11 @@ int iter_add_tests(CU_pSuite suite)
 	if (CU_add_test(suite, "iter_types_non_empty",
 			test_iter_types_non_empty) == NULL)
 		return CU_get_error();
+	if (CU_add_test(suite, "iter_users_empty", test_iter_users_empty) ==
+	    NULL)
+		return CU_get_error();
+	if (CU_add_test(suite, "iter_users_non_empty",
+			test_iter_users_non_empty) == NULL)
+		return CU_get_error();
 	return 0;
 }
-- 
2.55.0

