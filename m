Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE801EBA11
	for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785719; cv=none; b=idUtg61R5szzLZZEgfWXZnHVD3Gx9OmS0Gg3oRlwwNdKADOtPoTdwBHcXtVpDqrmvZ+bfs90EnWeSAwCGm/Ounlw/WhEnqKYy9F/H1R1JJOyNDjtyutgitAMRJjy59VNhu9qcoQuT79wXunChJT3TSoqMa/3qEZRnkPmXX+ppik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785719; c=relaxed/simple;
	bh=PqqVgtul1m4AJmGVZ8zsXyDSgFXmfI1tB+DLozJI45E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lcjNdXI0Cu0RQ2FGA6ZSUkw1meHI4YyEeKrvJFwFh2zLhqPisagi78emjyidLeLPNgK8Vw9x6kY8uYMePE6WVv4yhwhgjyYUUXI6APQAy3k9bKxIbnRQdJbG4iHlNKvvi2gC9ipgHi3CoJzyiSb3wPiKa+2dUvaHuOPcJ77/Jxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=erD0ZYHl; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="erD0ZYHl"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1729785705;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yZeDc1JaGiTaZcUeesphhCM0rR3jHGBHnelyOXa4wiI=;
	b=erD0ZYHlkSOQd7MhJh7gmiYhSaGeD4D+gr8Z+i3fXpbQkIHKJkii0M4mvLvlCEJZfw1wig
	0vmyQZx5QQEqx2dRg9PLYlpW9M0ILiBfPUmu7mWuIL5BXmz1HTLtbhateIbmqDDnbtbgUL
	BaFUY+hmzsvRM/qmxDCgOisx8EgUVEGOZTlOLjx3RY04lP9LxZ/pBWtL2wgdpoRVs3rKv9
	Sz9iZ2/uknhHmxZyygN4inM71uFI0x+IVFpFa8EEtA/dj3YsPK6mA+eAfkffWE0/4kBz7s
	wJNYtGo9A9eZ0ZfBl+j756mwc+CL9B8DRjhb3Jgyh1Kgo13r/13oMzbl0YgdHA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 1/4] libsepol: misc assertion cleanup
Date: Thu, 24 Oct 2024 18:01:37 +0200
Message-ID: <20241024160140.71347-1-cgoettsche@seltendoof.de>
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

Use const parameters where applicable to signal immutability.

Rename the passed iterator avrule from avrule to narule, to make clear
its the neverallow rule to assert against, not the allow rule to check.

Drop needless branch in check_assertions(), since in the case avrules is
NULL the for loop won't execute and errors will stay at 0, so 0 will be
returned regardless. Also there is no call to free() as mentioned in the
outdated comment.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Note: this patch (and the whole patchset) is based onto the proposed
patch "libsepol: Support nlmsg xperms in assertions" by Thiébaud
Weksteen.

v2:
  add patch
---
 libsepol/include/sepol/policydb/policydb.h |   4 +-
 libsepol/src/assertion.c                   | 155 ++++++++++-----------
 2 files changed, 76 insertions(+), 83 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index f73e21fc..88fb3672 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -698,9 +698,9 @@ extern void level_datum_init(level_datum_t * x);
 extern void level_datum_destroy(level_datum_t * x);
 extern void cat_datum_init(cat_datum_t * x);
 extern void cat_datum_destroy(cat_datum_t * x);
-extern int check_assertion(policydb_t *p, avrule_t *avrule);
+extern int check_assertion(policydb_t *p, const avrule_t *avrule);
 extern int check_assertions(sepol_handle_t * handle,
-			    policydb_t * p, avrule_t * avrules);
+			    policydb_t * p, const avrule_t * avrules);
 
 extern int symtab_insert(policydb_t * x, uint32_t sym,
 			 hashtab_key_t key, hashtab_datum_t datum,
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 5e129883..71faa3b2 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -31,7 +31,7 @@
 struct avtab_match_args {
 	sepol_handle_t *handle;
 	policydb_t *p;
-	avrule_t *avrule;
+	const avrule_t *narule;
 	avtab_t *avtab;
 	unsigned long errors;
 };
@@ -74,7 +74,7 @@ static void report_failure(sepol_handle_t *handle, policydb_t *p, const avrule_t
 	free(permstr);
 }
 
-static int match_any_class_permissions(class_perm_node_t *cp, uint32_t class, uint32_t data)
+static int match_any_class_permissions(const class_perm_node_t *cp, uint32_t class, uint32_t data)
 {
 	for (; cp; cp = cp->next) {
 		if ((cp->tclass == class) && (cp->data & data))
@@ -84,7 +84,7 @@ static int match_any_class_permissions(class_perm_node_t *cp, uint32_t class, ui
 	return 0;
 }
 
-static int extended_permissions_and(uint32_t *perms1, uint32_t *perms2) {
+static int extended_permissions_and(const uint32_t *perms1, const uint32_t *perms2) {
 	size_t i;
 	for (i = 0; i < EXTENDED_PERMS_LEN; i++) {
 		if (perms1[i] & perms2[i])
@@ -94,7 +94,7 @@ static int extended_permissions_and(uint32_t *perms1, uint32_t *perms2) {
 	return 0;
 }
 
-static int check_extended_permissions(av_extended_perms_t *neverallow, avtab_extended_perms_t *allow)
+static int check_extended_permissions(const av_extended_perms_t *neverallow, const avtab_extended_perms_t *allow)
 {
 	int rc = 0;
 	if ((neverallow->specified == AVRULE_XPERMS_IOCTLFUNCTION)
@@ -121,8 +121,8 @@ static int check_extended_permissions(av_extended_perms_t *neverallow, avtab_ext
 
 /* Compute which allowed extended permissions violate the neverallow rule */
 static void extended_permissions_violated(avtab_extended_perms_t *result,
-					av_extended_perms_t *neverallow,
-					avtab_extended_perms_t *allow)
+					const av_extended_perms_t *neverallow,
+					const avtab_extended_perms_t *allow)
 {
 	size_t i;
 	if ((neverallow->specified == AVRULE_XPERMS_IOCTLFUNCTION)
@@ -160,14 +160,14 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 				policydb_t *p, const avrule_t *avrule,
 				unsigned int stype, unsigned int ttype,
 				const class_perm_node_t *curperm, uint32_t perms,
-				avtab_key_t *k, avtab_t *avtab)
+				const avtab_key_t *k, avtab_t *avtab)
 {
 	avtab_ptr_t node;
 	avtab_key_t tmp_key;
 	avtab_extended_perms_t *xperms;
 	avtab_extended_perms_t error;
-	ebitmap_t *sattr = &p->type_attr_map[stype];
-	ebitmap_t *tattr = &p->type_attr_map[ttype];
+	const ebitmap_t *sattr = &p->type_attr_map[stype];
+	const ebitmap_t *tattr = &p->type_attr_map[ttype];
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
 	int rc;
@@ -240,26 +240,26 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	sepol_handle_t *handle = a->handle;
 	policydb_t *p = a->p;
 	avtab_t *avtab = a->avtab;
-	avrule_t *avrule = a->avrule;
-	class_perm_node_t *cp;
+	const avrule_t *narule = a->narule;
+	const class_perm_node_t *cp;
 	uint32_t perms;
 	ebitmap_t src_matches, tgt_matches, self_matches;
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
-	const int is_avrule_self = (avrule->flags & RULE_SELF) != 0;
-	const int is_avrule_notself = (avrule->flags & RULE_NOTSELF) != 0;
+	const int is_narule_self = (narule->flags & RULE_SELF) != 0;
+	const int is_narule_notself = (narule->flags & RULE_NOTSELF) != 0;
 
 	if ((k->specified & AVTAB_ALLOWED) == 0)
 		return 0;
 
-	if (!match_any_class_permissions(avrule->perms, k->target_class, d->data))
+	if (!match_any_class_permissions(narule->perms, k->target_class, d->data))
 		return 0;
 
 	ebitmap_init(&src_matches);
 	ebitmap_init(&tgt_matches);
 	ebitmap_init(&self_matches);
 
-	rc = ebitmap_and(&src_matches, &avrule->stypes.types,
+	rc = ebitmap_and(&src_matches, &narule->stypes.types,
 			 &p->attr_type_map[k->source_type - 1]);
 	if (rc < 0)
 		goto oom;
@@ -267,22 +267,22 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	if (ebitmap_is_empty(&src_matches))
 		goto exit;
 
-	if (is_avrule_notself) {
-		if (ebitmap_is_empty(&avrule->ttypes.types)) {
+	if (is_narule_notself) {
+		if (ebitmap_is_empty(&narule->ttypes.types)) {
 			/* avrule tgt is of the form ~self */
 			rc = ebitmap_cpy(&tgt_matches, &p->attr_type_map[k->target_type -1]);
 		} else {
 			/* avrule tgt is of the form {ATTR -self} */
-			rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type - 1]);
+			rc = ebitmap_and(&tgt_matches, &narule->ttypes.types, &p->attr_type_map[k->target_type - 1]);
 		}
 		if (rc)
 			goto oom;
 	} else {
-		rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
+		rc = ebitmap_and(&tgt_matches, &narule->ttypes.types, &p->attr_type_map[k->target_type -1]);
 		if (rc < 0)
 			goto oom;
 
-		if (is_avrule_self) {
+		if (is_narule_self) {
 			rc = ebitmap_and(&self_matches, &src_matches, &p->attr_type_map[k->target_type - 1]);
 			if (rc < 0)
 				goto oom;
@@ -298,7 +298,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	if (ebitmap_is_empty(&tgt_matches))
 		goto exit;
 
-	for (cp = avrule->perms; cp; cp = cp->next) {
+	for (cp = narule->perms; cp; cp = cp->next) {
 
 		perms = cp->data & d->data;
 		if ((cp->tclass != k->target_class) || !perms) {
@@ -307,16 +307,16 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 
 		ebitmap_for_each_positive_bit(&src_matches, snode, i) {
 			ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
-				if (is_avrule_self && i != j)
+				if (is_narule_self && i != j)
 					continue;
-				if (is_avrule_notself && i == j)
+				if (is_narule_notself && i == j)
 					continue;
-				if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
-					a->errors += report_assertion_extended_permissions(handle,p, avrule,
+				if (narule->specified == AVRULE_XPERMS_NEVERALLOW) {
+					a->errors += report_assertion_extended_permissions(handle,p, narule,
 											i, j, cp, perms, k, avtab);
 				} else {
 					a->errors++;
-					report_failure(handle, p, avrule, i, j, cp, perms);
+					report_failure(handle, p, narule, i, j, cp, perms);
 				}
 			}
 		}
@@ -330,14 +330,14 @@ exit:
 	return rc;
 }
 
-static int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, avrule_t *avrule)
+static int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, const avrule_t *narule)
 {
 	int rc;
 	struct avtab_match_args args;
 
 	args.handle = handle;
 	args.p = p;
-	args.avrule = avrule;
+	args.narule = narule;
 	args.errors = 0;
 
 	args.avtab =  &p->te_avtab;
@@ -360,16 +360,16 @@ oom:
  * Look up the extended permissions in avtab and verify that neverallowed
  * permissions are not granted.
  */
-static int check_assertion_extended_permissions_avtab(avrule_t *avrule, avtab_t *avtab,
+static int check_assertion_extended_permissions_avtab(const avrule_t *narule, avtab_t *avtab,
 						unsigned int stype, unsigned int ttype,
-						avtab_key_t *k, policydb_t *p)
+						const avtab_key_t *k, policydb_t *p)
 {
 	avtab_ptr_t node;
 	avtab_key_t tmp_key;
-	avtab_extended_perms_t *xperms;
-	av_extended_perms_t *neverallow_xperms = avrule->xperms;
-	ebitmap_t *sattr = &p->type_attr_map[stype];
-	ebitmap_t *tattr = &p->type_attr_map[ttype];
+	const avtab_extended_perms_t *xperms;
+	const av_extended_perms_t *neverallow_xperms = narule->xperms;
+	const ebitmap_t *sattr = &p->type_attr_map[stype];
+	const ebitmap_t *tattr = &p->type_attr_map[ttype];
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
 	int rc = 1;
@@ -416,21 +416,21 @@ static int check_assertion_extended_permissions_avtab(avrule_t *avrule, avtab_t
  * 4. FAIL - The ioctl permission is granted AND the extended permission is
  *    granted
  */
-static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab,
-						avtab_key_t *k, policydb_t *p)
+static int check_assertion_extended_permissions(const avrule_t *narule, avtab_t *avtab,
+						const avtab_key_t *k, policydb_t *p)
 {
 	ebitmap_t src_matches, tgt_matches, self_matches;
 	unsigned int i, j;
 	ebitmap_node_t *snode, *tnode;
-	const int is_avrule_self = (avrule->flags & RULE_SELF) != 0;
-	const int is_avrule_notself = (avrule->flags & RULE_NOTSELF) != 0;
+	const int is_narule_self = (narule->flags & RULE_SELF) != 0;
+	const int is_narule_notself = (narule->flags & RULE_NOTSELF) != 0;
 	int rc;
 
 	ebitmap_init(&src_matches);
 	ebitmap_init(&tgt_matches);
 	ebitmap_init(&self_matches);
 
-	rc = ebitmap_and(&src_matches, &avrule->stypes.types,
+	rc = ebitmap_and(&src_matches, &narule->stypes.types,
 			 &p->attr_type_map[k->source_type - 1]);
 	if (rc < 0)
 		goto oom;
@@ -440,22 +440,22 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 		goto exit;
 	}
 
-	if (is_avrule_notself) {
-		if (ebitmap_is_empty(&avrule->ttypes.types)) {
+	if (is_narule_notself) {
+		if (ebitmap_is_empty(&narule->ttypes.types)) {
 			/* avrule tgt is of the form ~self */
 			rc = ebitmap_cpy(&tgt_matches, &p->attr_type_map[k->target_type -1]);
 		} else {
 			/* avrule tgt is of the form {ATTR -self} */
-			rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type - 1]);
+			rc = ebitmap_and(&tgt_matches, &narule->ttypes.types, &p->attr_type_map[k->target_type - 1]);
 		}
 		if (rc < 0)
 			goto oom;
 	} else {
-		rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
+		rc = ebitmap_and(&tgt_matches, &narule->ttypes.types, &p->attr_type_map[k->target_type -1]);
 		if (rc < 0)
 			goto oom;
 
-		if (is_avrule_self) {
+		if (is_narule_self) {
 			rc = ebitmap_and(&self_matches, &src_matches, &p->attr_type_map[k->target_type - 1]);
 			if (rc < 0)
 				goto oom;
@@ -475,11 +475,11 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 
 	ebitmap_for_each_positive_bit(&src_matches, snode, i) {
 		ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
-			if (is_avrule_self && i != j)
+			if (is_narule_self && i != j)
 				continue;
-			if (is_avrule_notself && i == j)
+			if (is_narule_notself && i == j)
 				continue;
-			if (check_assertion_extended_permissions_avtab(avrule, avtab, i, j, k, p)) {
+			if (check_assertion_extended_permissions_avtab(narule, avtab, i, j, k, p)) {
 				rc = 1;
 				goto exit;
 			}
@@ -496,7 +496,7 @@ exit:
 	return rc;
 }
 
-static int check_assertion_notself_match(avtab_key_t *k, avrule_t *avrule, policydb_t *p)
+static int check_assertion_notself_match(const avtab_key_t *k, const avrule_t *narule, policydb_t *p)
 {
 	ebitmap_t src_matches, tgt_matches;
 	unsigned int num_src_matches, num_tgt_matches;
@@ -505,16 +505,16 @@ static int check_assertion_notself_match(avtab_key_t *k, avrule_t *avrule, polic
 	ebitmap_init(&src_matches);
 	ebitmap_init(&tgt_matches);
 
-	rc = ebitmap_and(&src_matches, &avrule->stypes.types, &p->attr_type_map[k->source_type - 1]);
+	rc = ebitmap_and(&src_matches, &narule->stypes.types, &p->attr_type_map[k->source_type - 1]);
 	if (rc < 0)
 		goto oom;
 
-	if (ebitmap_is_empty(&avrule->ttypes.types)) {
+	if (ebitmap_is_empty(&narule->ttypes.types)) {
 		/* avrule tgt is of the form ~self */
 		rc = ebitmap_cpy(&tgt_matches, &p->attr_type_map[k->target_type - 1]);
 	} else {
 		/* avrule tgt is of the form {ATTR -self} */
-		rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type - 1]);
+		rc = ebitmap_and(&tgt_matches, &narule->ttypes.types, &p->attr_type_map[k->target_type - 1]);
 	}
 	if (rc < 0)
 		goto oom;
@@ -551,7 +551,7 @@ nomatch:
 	return rc;
 }
 
-static int check_assertion_self_match(avtab_key_t *k, avrule_t *avrule, policydb_t *p)
+static int check_assertion_self_match(const avtab_key_t *k, const avrule_t *narule, policydb_t *p)
 {
 	ebitmap_t src_matches;
 	int rc;
@@ -560,7 +560,7 @@ static int check_assertion_self_match(avtab_key_t *k, avrule_t *avrule, policydb
 	 * and the key's source.
 	 */
 
-	rc = ebitmap_and(&src_matches, &avrule->stypes.types, &p->attr_type_map[k->source_type - 1]);
+	rc = ebitmap_and(&src_matches, &narule->stypes.types, &p->attr_type_map[k->source_type - 1]);
 	if (rc < 0)
 		goto oom;
 
@@ -582,29 +582,29 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	int rc;
 	struct avtab_match_args *a = (struct avtab_match_args *)args;
 	policydb_t *p = a->p;
-	avrule_t *avrule = a->avrule;
+	const avrule_t *narule = a->narule;
 	avtab_t *avtab = a->avtab;
 
 	if ((k->specified & AVTAB_ALLOWED) == 0)
 		goto nomatch;
 
-	if (!match_any_class_permissions(avrule->perms, k->target_class, d->data))
+	if (!match_any_class_permissions(narule->perms, k->target_class, d->data))
 		goto nomatch;
 
-	if (!ebitmap_match_any(&avrule->stypes.types, &p->attr_type_map[k->source_type - 1]))
+	if (!ebitmap_match_any(&narule->stypes.types, &p->attr_type_map[k->source_type - 1]))
 		goto nomatch;
 
-	if (avrule->flags & RULE_NOTSELF) {
-		rc = check_assertion_notself_match(k, avrule, p);
+	if (narule->flags & RULE_NOTSELF) {
+		rc = check_assertion_notself_match(k, narule, p);
 		if (rc < 0)
 			goto oom;
 		if (rc == 0)
 			goto nomatch;
 	} else {
 		/* neverallow may have tgts even if it uses SELF */
-		if (!ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1])) {
-			if (avrule->flags == RULE_SELF) {
-				rc = check_assertion_self_match(k, avrule, p);
+		if (!ebitmap_match_any(&narule->ttypes.types, &p->attr_type_map[k->target_type -1])) {
+			if (narule->flags == RULE_SELF) {
+				rc = check_assertion_self_match(k, narule, p);
 				if (rc < 0)
 					goto oom;
 				if (rc == 0)
@@ -615,8 +615,8 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 		}
 	}
 
-	if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
-		rc = check_assertion_extended_permissions(avrule, avtab, k, p);
+	if (narule->specified == AVRULE_XPERMS_NEVERALLOW) {
+		rc = check_assertion_extended_permissions(narule, avtab, k, p);
 		if (rc < 0)
 			goto oom;
 		if (rc == 0)
@@ -631,16 +631,16 @@ oom:
 	return rc;
 }
 
-int check_assertion(policydb_t *p, avrule_t *avrule)
+int check_assertion(policydb_t *p, const avrule_t *narule)
 {
 	int rc;
-	struct avtab_match_args args;
-
-	args.handle = NULL;
-	args.p = p;
-	args.avrule = avrule;
-	args.errors = 0;
-	args.avtab = &p->te_avtab;
+	struct avtab_match_args args = {
+		.handle = NULL,
+		.p = p,
+		.narule = narule,
+		.errors = 0,
+		.avtab = &p->te_avtab,
+	};
 
 	rc = avtab_map(&p->te_avtab, check_assertion_avtab_match, &args);
 
@@ -653,20 +653,13 @@ int check_assertion(policydb_t *p, avrule_t *avrule)
 }
 
 int check_assertions(sepol_handle_t * handle, policydb_t * p,
-		     avrule_t * avrules)
+		     const avrule_t * narules)
 {
 	int rc;
-	avrule_t *a;
+	const avrule_t *a;
 	unsigned long errors = 0;
 
-	if (!avrules) {
-		/* Since assertions are stored in avrules, if it is NULL
-		   there won't be any to check. This also prevents an invalid
-		   free if the avtabs are never initialized */
-		return 0;
-	}
-
-	for (a = avrules; a != NULL; a = a->next) {
+	for (a = narules; a != NULL; a = a->next) {
 		if (!(a->specified & (AVRULE_NEVERALLOW | AVRULE_XPERMS_NEVERALLOW)))
 			continue;
 		rc = check_assertion(p, a);
-- 
2.45.2

