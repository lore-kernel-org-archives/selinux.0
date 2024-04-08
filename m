Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BC9127B54
	for <selinux@vger.kernel.org>; Mon,  8 Apr 2024 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588749; cv=none; b=B/Cidjvq2gQCwD39mnvjvS4QDXXe6Wudz1CFw8JObfMQ2uX9xag+LxguASAVYkPzjwsdLvRpXM5RXlSYx1p/x1iNU4jy6zGfsLOCqH/R2CbXgjo0uaeY+9B+9BoLji7P+W9kIDhr5miVPVpl/IvXJD1j1JZ55r+3NyuH/stYlqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588749; c=relaxed/simple;
	bh=ZxlauoWsjXDiiU5xbNXoJoUVvB5eFanxbU9ujSGV/eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bppink9KKTDpMEx62ZdhRKdG1em67tpaFXbkXdrHiSkLDg3MH2aISyWQfsCED5mIy85M5Aa1j4iOsYz7BmlvQ5Xjd6QINEl392iz+D55SH+d2W4OBhnVI6+UXA5bFjRHVDGIbMrcXJFk8YuvnOzXyqiTzsk4Lo8kjH0Zv/EhqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=H4rzUEU4; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="H4rzUEU4"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712588736;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4oe9a0XyiaUHzyngMKpaSqYuXfB9z8O4k5AMBDzQ+YA=;
	b=H4rzUEU4NSOLvi01fji9eBoa41Mgyy1RYgZ0SZq+LogIoKVlTRD7RI9t/UfWTC0iZZNBh0
	wEEXbJtG9SlpP5HLIep97Q7LV1xs3HYSz+Lk6x8fm71QPWNhtYU7ZG1CMOv+XTYZuNcCS+
	2ZKfF77wRu5Gx9o5nUDvJAnoiYZE1Cerd54bKRWsGw02rXiGnjxp+8vZEfBr/HS6nqIR+S
	96xMz9rHKgfOiI43Q+s4SjpLhmRPoaNzEOVQIvLFwzjpC17JTBTLBy9cCTLoz+9SFci8H4
	Xu5qZ3hjDas+vWTwV7Ni4FXhRgxEHVegPQF6+YyHtqLfmDpA6iRRhfvMRH966A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsepol: validate class permissions
Date: Mon,  8 Apr 2024 17:05:20 +0200
Message-ID: <20240408150531.63085-1-cgoettsche@seltendoof.de>
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
 libsepol/src/policydb_validate.c | 101 ++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 35 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index c4f8c300..a5051416 100644
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
@@ -230,14 +237,17 @@ bad:
 static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms, const constraint_node_t *cons, validate_t flavors[])
 {
 	const constraint_expr_t *cexp;
+	const int is_validatetrans = (nperms == UINT32_MAX);
 	int depth;
 
 	for (; cons; cons = cons->next) {
-		if (nperms == 0 && cons->permissions != 0)
+		if (is_validatetrans && cons->permissions != 0)
+			goto bad;
+		if (!is_validatetrans && nperms == 0)
 			goto bad;
-		if (nperms > 0 && cons->permissions == 0)
+		if (!is_validatetrans && cons->permissions == 0)
 			goto bad;
-		if (nperms > 0 && nperms != PERM_SYMTAB_SIZE && cons->permissions >= (UINT32_C(1) << nperms))
+		if (!is_validatetrans && nperms != PERM_SYMTAB_SIZE && cons->permissions >= (UINT32_C(1) << nperms))
 			goto bad;
 
 		if (!cons->expr)
@@ -251,7 +261,7 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 					goto bad;
 				depth++;
 
-				if (cexp->attr & CEXPR_XTARGET && nperms != 0)
+				if (cexp->attr & CEXPR_XTARGET && !is_validatetrans)
 					goto bad;
 				if (!(cexp->attr & CEXPR_TYPE)) {
 					if (validate_empty_type_set(cexp->type_names))
@@ -366,11 +376,49 @@ bad:
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
@@ -393,11 +441,17 @@ static int validate_class_datum(sepol_handle_t *handle, const class_datum_t *cla
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
@@ -877,46 +931,23 @@ bad:
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

