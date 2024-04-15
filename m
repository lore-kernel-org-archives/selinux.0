Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977942072
	for <selinux@vger.kernel.org>; Mon, 15 Apr 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199981; cv=none; b=PmNd9cEZP/O/0F8b04hZ+4utSAE0Ttao+VV4FQt8MJuee6wESaWxq+WBzQccykHYKEjsW/cedMqFPAdwvFuI8hUzvqM4PD+rmF7p7zuwTSXCCrB8jMgkXd0c0cLgxxUSLhBCzTMoABSCj8VXYIu9c/ct5jrrjUIFSMS/Z7G8DlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199981; c=relaxed/simple;
	bh=SN7rjKYSmlRVirjvbXsEJGxxF0yzHoibKG7ZYQ0/MA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EmOlEAmq/P279bNVf0jMMC3M66P7+2YOElheMMcv+ACLlJVEHoHkWmy6K4Ag33A0jX5j19eipuygsq6puFQOkdY3JSmW91H4aL9kIAZqspg+7Xs5mBUf71P0m+R38M6TMKekWfuCf/qzcKncfVd0Z6L/vQ1KxnyFWskF5Ga92RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=SNQMrTan; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="SNQMrTan"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1713199966;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ho244Ag0/66b+nyyci1F+nQxld7qdgfUefwYF9WmXQY=;
	b=SNQMrTanOSUo1Z5zCHydiXkFAqVX7sRZj3kMzGIDaCKMZkNftieNIXyDpYdO66n880VNR1
	kPehkEWLzMRTrr1dQ5on/muhWH3QLf336VtsrvshlN2XlxoRe+c0UC0lAf4Xdiwooe3E9u
	Cy8acSfB/sozUUT+yNL6le4ZMQ5Sb3/poZkAvS7IK91Zw6xCsE3xI67rqu5YBbhZIz8G8w
	nZRA/Tzq7g7Ik5cEg3pz6S97Rk2mOUhjHd6Qm0/KJ7W4Uehpd5GV02LEuU9s2dKDfS/1e1
	PEUZYjmOWMLbisPFyQ93afLxKZh0SRLhUOrqXCRmbvNGsbuO3vzgbEWccpkAog==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2] libsepol: validate class permissions
Date: Mon, 15 Apr 2024 18:52:42 +0200
Message-ID: <20240415165242.108230-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Validate the symbol tables for permissions of security classes and
common classes:
  * check their value is valid
  * check their values are unique
  * check permission values of classes do not reuse values from
    inherited permissions

This simplifies validating permissions of access vectors a lot, since it
is now only a binary and against the valid permission mask of the class.

Use UINT32_MAX instead of 0 as the special value for validating
constraints signaling a validate-trans rule, since classes with no
permissions are permitted, but they must not have a normal constraint
attached.

Reported-by: oss-fuzz (issue 67893)
Improves: 8c64e5bb6fe7 ("libsepol: validate access vector permissions")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   - move check independent of individual constraints out of the loop
   - change nperms parameter type of validate_constraint_nodes() from
     unsigned int to uint32_t
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 104 ++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 36 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index c4f8c300..e1623172 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -11,6 +11,7 @@
 
 #define bool_xor(a, b) (!(a) != !(b))
 #define bool_xnor(a, b) (!bool_xor(a, b))
+#define PERMISSION_MASK(nprim) ((nprim) == PERM_SYMTAB_SIZE ? (~UINT32_C(0)) : ((UINT32_C(1) << (nprim)) - 1))
 
 typedef struct validate {
 	uint32_t nprim;
@@ -23,6 +24,12 @@ typedef struct map_arg {
 	const policydb_t *policy;
 } map_arg_t;
 
+typedef struct perm_arg {
+	uint32_t visited;
+	const uint32_t nprim;
+	const uint32_t inherited_nprim;
+} perm_arg_t;
+
 static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebitmap_t *gaps)
 {
 	uint32_t i;
@@ -227,17 +234,21 @@ bad:
 	return -1;
 }
 
-static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms, const constraint_node_t *cons, validate_t flavors[])
+static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms, const constraint_node_t *cons, validate_t flavors[])
 {
 	const constraint_expr_t *cexp;
+	const int is_validatetrans = (nperms == UINT32_MAX);
 	int depth;
 
+	if (cons && nperms == 0)
+		goto bad;
+
 	for (; cons; cons = cons->next) {
-		if (nperms == 0 && cons->permissions != 0)
+		if (is_validatetrans && cons->permissions != 0)
 			goto bad;
-		if (nperms > 0 && cons->permissions == 0)
+		if (!is_validatetrans && cons->permissions == 0)
 			goto bad;
-		if (nperms > 0 && nperms != PERM_SYMTAB_SIZE && cons->permissions >= (UINT32_C(1) << nperms))
+		if (!is_validatetrans && nperms != PERM_SYMTAB_SIZE && cons->permissions >= (UINT32_C(1) << nperms))
 			goto bad;
 
 		if (!cons->expr)
@@ -251,7 +262,7 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 					goto bad;
 				depth++;
 
-				if (cexp->attr & CEXPR_XTARGET && nperms != 0)
+				if (cexp->attr & CEXPR_XTARGET && !is_validatetrans)
 					goto bad;
 				if (!(cexp->attr & CEXPR_TYPE)) {
 					if (validate_empty_type_set(cexp->type_names))
@@ -366,11 +377,49 @@ bad:
 	return -1;
 }
 
+static int perm_visit(__attribute__((__unused__)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	perm_arg_t *pargs = args;
+	const perm_datum_t *perdatum = d;
+
+	if (!value_isvalid(perdatum->s.value, pargs->nprim))
+		return -1;
+
+	if (pargs->inherited_nprim != 0 && value_isvalid(perdatum->s.value, pargs->inherited_nprim))
+		return -1;
+
+	if ((UINT32_C(1) << (perdatum->s.value - 1)) & pargs->visited)
+		return -1;
+
+	pargs->visited |= (UINT32_C(1) << (perdatum->s.value - 1));
+	return 0;
+}
+
+static int validate_permission_symtab(sepol_handle_t *handle, const symtab_t *permissions, uint32_t inherited_nprim)
+{
+	/* Check each entry has a different valid value and is not overriding an inherited one */
+
+	perm_arg_t pargs = { .visited = 0, .nprim = permissions->nprim, .inherited_nprim = inherited_nprim };
+
+	if (hashtab_map(permissions->table, perm_visit, &pargs))
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid permission table");
+	return -1;
+}
+
 static int validate_common_datum(sepol_handle_t *handle, const common_datum_t *common, validate_t flavors[])
 {
 	if (validate_value(common->s.value, &flavors[SYM_COMMONS]))
 		goto bad;
-	if (common->permissions.table->nel == 0 || common->permissions.nprim > PERM_SYMTAB_SIZE)
+	if (common->permissions.nprim == 0 || common->permissions.nprim > PERM_SYMTAB_SIZE)
+		goto bad;
+	if (common->permissions.nprim != common->permissions.table->nel)
+		goto bad;
+	if (validate_permission_symtab(handle, &common->permissions, 0))
 		goto bad;
 
 	return 0;
@@ -393,11 +442,17 @@ static int validate_class_datum(sepol_handle_t *handle, const class_datum_t *cla
 		goto bad;
 	if (class->comdatum && validate_common_datum(handle, class->comdatum, flavors))
 		goto bad;
-	if (class->permissions.nprim > PERM_SYMTAB_SIZE)
+	/* empty classes are permitted */
+	if (class->permissions.nprim > PERM_SYMTAB_SIZE || class->permissions.table->nel > PERM_SYMTAB_SIZE)
+		goto bad;
+	if (class->permissions.nprim !=
+	    (class->permissions.table->nel + (class->comdatum ? class->comdatum->permissions.table->nel : 0)))
+		goto bad;
+	if (validate_permission_symtab(handle, &class->permissions, class->comdatum ? class->comdatum->permissions.nprim : 0))
 		goto bad;
 	if (validate_constraint_nodes(handle, class->permissions.nprim, class->constraints, flavors))
 		goto bad;
-	if (validate_constraint_nodes(handle, 0, class->validatetrans, flavors))
+	if (validate_constraint_nodes(handle, UINT32_MAX, class->validatetrans, flavors))
 		goto bad;
 
 	switch (class->default_user) {
@@ -877,46 +932,23 @@ bad:
 	return -1;
 }
 
-static int perm_match(__attribute__ ((unused)) hashtab_key_t key, hashtab_datum_t datum, void *data)
-{
-	const uint32_t *v = data;
-	const perm_datum_t *perdatum = datum;
-
-	return *v == perdatum->s.value;
-}
-
 static int validate_access_vector(sepol_handle_t *handle, const policydb_t *p, sepol_security_class_t tclass,
 				  sepol_access_vector_t av)
 {
 	const class_datum_t *cladatum = p->class_val_to_struct[tclass - 1];
-	uint32_t i;
 
 	/*
 	 * Check that at least one permission bit is valid.
 	 * Older compilers might set invalid bits for the wildcard permission.
 	 */
-	for (i = 0; i < cladatum->permissions.nprim; i++) {
-		if (av & (UINT32_C(1) << i)) {
-			uint32_t v = i + 1;
-			int rc;
-
-			rc = hashtab_map(cladatum->permissions.table, perm_match, &v);
-			if (rc == 1)
-				goto good;
-
-			if (cladatum->comdatum) {
-				rc = hashtab_map(cladatum->comdatum->permissions.table, perm_match, &v);
-				if (rc == 1)
-					goto good;
-			}
-		}
-	}
+	if (!(av & PERMISSION_MASK(cladatum->permissions.nprim)))
+		goto bad;
 
+	return 0;
+
+bad:
 	ERR(handle, "Invalid access vector");
 	return -1;
-
-good:
-	return 0;
 }
 
 static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d, void *args)
-- 
2.43.0

