Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D736134AC
	for <selinux@vger.kernel.org>; Sat,  8 Jun 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867310; cv=none; b=qBKJlQfNCex+YaBL5iLeBbX9ae0xxsVttm11eSVVBXmwrdiRZmpJ9Nn9LEh7zRplPkUJx2nIxkUCuXIrJAWTWv2L7pNaKCySxtpfRdRv9cskKQ+8ZtNt7A4/17qFRy9MgdEkXRTJQhF1OAdcavpELPKVS8bh7/tL3MGC/lBFcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867310; c=relaxed/simple;
	bh=tjEhWkNG+fhkzYSFEX86MWxP5lgar0USYmBYQPvxR+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V8FQO5A+N5t/te7U+bnR7apERvlzlqCowGdPFs4CkVZjQJHdbiQi9mZOABUymFI2CxvTughQoUAvyDCrpgH46vWvpmbHh+9k5/+LOf4omj4qehikJqPBqDIv9OKs329YdpnQnIwqq/bgVLhGpRAZdvrj1Pc62dL/kqZP+O1m2l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=D+NiwjB/; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="D+NiwjB/"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1717867306;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pPM1nSCsZ7RCT4H7ex8RC5zWKEtEXmxBurv3IZ82uog=;
	b=D+NiwjB/vUVMbrkqtH+OP8pFqXKpK6fdGNHsGwm5i13HRf809vjASMsaCgZctgkqOBLDqF
	CRhjONA0fUXd+b8DAUbTHwOl7fQ2wf2016nEfMd1xB9mFGcN0qbuQFWOXfG697Ot0kCAKi
	kEZoiBjK+1ECGJlK6/8MkP8Qj5kvTqJRUCMqlgOmY0PK5w4I+Opl664henNSAg43yZGwds
	NaQTHUp1GnEBYMv2miM7NdUFFDmFDma+It3r39MJxNWIU6KesumQ2gENpIFJjv4wTkw1L3
	MW/b8A5R9ZegN8/DtDmgpcGpawXdOQEBUztMTd3V+UaUfahuuuA+ExQ40KvOpA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] libsepol: move unchanged data out of loop
Date: Sat,  8 Jun 2024 19:21:41 +0200
Message-ID: <20240608172142.138894-1-cgoettsche@seltendoof.de>
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

Perform the lookup whether the class is in the current scope once, and
not for every permission.
This also ensures the class is checked to be in the current scope if
there are no permissions attached.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/link.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index b8272308..a6f2a251 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1925,7 +1925,7 @@ static int find_perm(hashtab_key_t key, hashtab_datum_t datum, void *varg)
  * Note that if a declaration had no requirement at all (e.g., an ELSE
  * block) this returns 1. */
 static int is_decl_requires_met(link_state_t * state,
-				avrule_decl_t * decl,
+				const avrule_decl_t * decl,
 				struct missing_requirement *req)
 {
 	/* (This algorithm is very unoptimized.  It performs many
@@ -1933,9 +1933,9 @@ static int is_decl_requires_met(link_state_t * state,
 	 * which symbols have been verified, so that they do not need
 	 * to be re-checked.) */
 	unsigned int i, j;
-	ebitmap_t *bitmap;
-	char *id, *perm_id;
-	policydb_t *pol = state->base;
+	const ebitmap_t *bitmap;
+	const char *id, *perm_id;
+	const policydb_t *pol = state->base;
 	ebitmap_node_t *node;
 
 	/* check that all symbols have been satisfied */
@@ -1961,27 +1961,25 @@ static int is_decl_requires_met(link_state_t * state,
 	}
 	/* check that all classes and permissions have been satisfied */
 	for (i = 0; i < decl->required.class_perms_len; i++) {
+		const class_datum_t *cladatum = pol->class_val_to_struct[i];
+		const scope_datum_t *scope;
+
+		bitmap = &decl->required.class_perms_map[i];
+		id = pol->p_class_val_to_name[i];
+
+
+		scope = hashtab_search(state->base->p_classes_scope.table, id);
+		if (scope == NULL) {
+			ERR(state->handle,
+				"Could not find scope information for class %s",
+				id);
+			return -1;
+		}
 
-		bitmap = decl->required.class_perms_map + i;
 		ebitmap_for_each_positive_bit(bitmap, node, j) {
 			struct find_perm_arg fparg;
-			class_datum_t *cladatum;
 			uint32_t perm_value = j + 1;
 			int rc;
-			scope_datum_t *scope;
-
-			id = pol->p_class_val_to_name[i];
-			cladatum = pol->class_val_to_struct[i];
-
-			scope =
-			    hashtab_search(state->base->p_classes_scope.table,
-					   id);
-			if (scope == NULL) {
-				ERR(state->handle,
-				    "Could not find scope information for class %s",
-				    id);
-				return -1;
-			}
 
 			fparg.valuep = perm_value;
 			fparg.key = NULL;
-- 
2.45.1

