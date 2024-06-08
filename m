Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC0134B1
	for <selinux@vger.kernel.org>; Sat,  8 Jun 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867310; cv=none; b=VTlyHDHsQHoCpGJXV9sJ6mlYZaHtwUMbexpUYdw1Tz9cSnUeq5lpcCIHKXCCKHmqTPdweVztpjFk6gNA1dqwtUIjiaaSSvW8W729UooqUSxgvvUd2YBokZVFbVFXSm09zDyjcChSPtacP0+UFPhLuCKQr/su0SgSXcE7FclQYEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867310; c=relaxed/simple;
	bh=JKMtwY4NVya2ufeH26+t3bTMJEMmtYRcmEvfc0ZhivA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXfpntl9igHlDNGHO7NYo4qXmKqr+R2CbuDJGYDwiokmnPak+H3+D8pECS+t6ZjSjrEn0BjDmY4qX+4xiTO5aAZBK3ZNOrcsZLtVLjF7NzThaDz086VvHbQQ81tMAJvYB2Imo07mnEvF3puIDPPwXPgaiMlDxveLhHqMvC02faM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ZGPvbOd3; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ZGPvbOd3"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1717867306;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wg5WIczUZnoXmBEzGYkQbz7XRgWsYtpyjZ1CtL/ViZw=;
	b=ZGPvbOd3OujiYZxm4lpemzNGFGMp18opY6zWFzsWaOh+TGhWlLWoEobk0h/C2N1EkbTajZ
	NrTUHHgIpVmjeyCHpgk84aWceuh8BYvzzUXY7qdyyYe3KVJ8FEq2Mbau36ZrjkYBXUkANO
	/FNaSVgxRT8vaCqpCQH7V0kdPZfNkRl5jlicvux2BzLKSAxhJANsu7fUkhOJTcUlDvzchX
	m4/fFfY2xGVa2guyb1zg7FNn6H6OSzmyTmGCyp+5tij5i0mzoob6XC7c5pLC8jvx9wkamF
	GmbL/h1iNwDQKA14fVtPl/J+g9PVs/IKEqiJjFiNjtfCp206BTPUmJUnsM1NZw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] libsepol: rework permission enabled check
Date: Sat,  8 Jun 2024 19:21:42 +0200
Message-ID: <20240608172142.138894-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240608172142.138894-1-cgoettsche@seltendoof.de>
References: <20240608172142.138894-1-cgoettsche@seltendoof.de>
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

Check the class is defined once, and not for every permission via
is_perm_enabled(). Also pass the class datum to avoid an unnecessary
name lookup.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .../include/sepol/policydb/avrule_block.h     |  4 +--
 libsepol/src/avrule_block.c                   | 27 +++++++------------
 libsepol/src/link.c                           |  6 ++++-
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/libsepol/include/sepol/policydb/avrule_block.h b/libsepol/include/sepol/policydb/avrule_block.h
index 27047d43..18a1dc78 100644
--- a/libsepol/include/sepol/policydb/avrule_block.h
+++ b/libsepol/include/sepol/policydb/avrule_block.h
@@ -35,8 +35,8 @@ extern avrule_decl_t *get_avrule_decl(policydb_t * p, uint32_t decl_id);
 extern cond_list_t *get_decl_cond_list(policydb_t * p,
 				       avrule_decl_t * decl,
 				       cond_list_t * cond);
-extern int is_id_enabled(char *id, policydb_t * p, int symbol_table);
-extern int is_perm_enabled(char *class_id, char *perm_id, policydb_t * p);
+extern int is_id_enabled(const char *id, const policydb_t * p, int symbol_table);
+extern int is_perm_existent(const class_datum_t *cladatum, const char *perm_id);
 
 #ifdef __cplusplus
 }
diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
index dcfce8b8..547021e9 100644
--- a/libsepol/src/avrule_block.c
+++ b/libsepol/src/avrule_block.c
@@ -152,11 +152,11 @@ cond_list_t *get_decl_cond_list(policydb_t * p, avrule_decl_t * decl,
  * marked as SCOPE_DECL, and any of its declaring block has been enabled,
  * then return 1.  Otherwise return 0. Can only be called after the 
  * decl_val_to_struct index has been created */
-int is_id_enabled(char *id, policydb_t * p, int symbol_table)
+int is_id_enabled(const char *id, const policydb_t * p, int symbol_table)
 {
-	scope_datum_t *scope =
+	const scope_datum_t *scope =
 	    (scope_datum_t *) hashtab_search(p->scope[symbol_table].table, id);
-	avrule_decl_t *decl;
+	const avrule_decl_t *decl;
 	uint32_t len;
 
 	if (scope == NULL) {
@@ -189,21 +189,14 @@ int is_id_enabled(char *id, policydb_t * p, int symbol_table)
 	return 0;
 }
 
-/* Check if a particular permission is present within the given class,
- * and that the class is enabled.  Returns 1 if both conditions are
- * true, 0 if neither could be found or if the class id disabled. */
-int is_perm_enabled(char *class_id, char *perm_id, policydb_t * p)
+/* Check if a particular permission is present within the given class.
+ * Whether the class is enabled is NOT checked.
+ * Returns 1 if both conditions are true,
+ * 0 if neither could be found or if the class id disabled. */
+int is_perm_existent(const class_datum_t *cladatum, const char *perm_id)
 {
-	class_datum_t *cladatum;
-	perm_datum_t *perm;
-	if (!is_id_enabled(class_id, p, SYM_CLASSES)) {
-		return 0;
-	}
-	cladatum =
-	    (class_datum_t *) hashtab_search(p->p_classes.table, class_id);
-	if (cladatum == NULL) {
-		return 0;
-	}
+	const perm_datum_t *perm;
+
 	perm = hashtab_search(cladatum->permissions.table, perm_id);
 	if (perm == NULL && cladatum->comdatum != 0) {
 		/* permission was not in this class.  before giving
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index a6f2a251..9281a986 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1968,6 +1968,10 @@ static int is_decl_requires_met(link_state_t * state,
 		id = pol->p_class_val_to_name[i];
 
 
+		if (!is_id_enabled(id, state->base, SYM_CLASSES)) {
+			return 0;
+		}
+
 		scope = hashtab_search(state->base->p_classes_scope.table, id);
 		if (scope == NULL) {
 			ERR(state->handle,
@@ -1994,7 +1998,7 @@ static int is_decl_requires_met(link_state_t * state,
 			perm_id = fparg.key;
 
 			assert(perm_id != NULL);
-			if (!is_perm_enabled(id, perm_id, state->base)) {
+			if (!is_perm_existent(cladatum, perm_id)) {
 				if (req != NULL) {
 					req->symbol_type = SYM_CLASSES;
 					req->symbol_value = i + 1;
-- 
2.45.1

