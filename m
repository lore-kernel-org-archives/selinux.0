Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF338309DDB
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309766; cv=none; b=nN8uHhdI7o84D9UW8VhuegNFIOt07i8msRYzCnpqtov0NwtPK7TxQWKTQoLCTgUbapNjs49YCouNjl+elLYsc9YvyDLvbtffeq+jYGPJTEgmsAoa1catDlJvWu0OF+3Ip/lBbiQXX1wphl4yswgYg+fr6jREmw3XJzqhgZD1s1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309766; c=relaxed/simple;
	bh=nhZDk//JaQ9KCFCyXKSYjIUnka1PddFKE5uno2qV8Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Px5nZLeghvX2kpmY0z66Kce3ywka3ARY42FglS/5US/Cu3iMUF3GEK6n7v+4DUlYm7nxRA/dJEOtBi79bP0bBvuyDFJwxqNZy0HcYq2aH5lOoP7pzvNdJkxrO0QjjwN7DjvN9MCpm41cszHS/koSe32UJxyCf8JAJZLTKM3LVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us3MojEd; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us3MojEd"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c1372f84dso45603261cf.2
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784309759; x=1784914559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x7gjDoR3IrEHBROsQmG8DNciq7d/KYXAq5bY952331g=;
        b=Us3MojEduN6r6X3y+JEAcAMsP83+oHC6EERhHC/jNLgq44MSc/V7i2bvUYeC0GEZCV
         Z+TWmoh75erfcJ6jZmmOqWreV2ZulX1aKnlBz59yaLXf4WZAYAUORq0J4zqvYHBWCVn6
         +iEr03CyyR2CjfRjFEmqcXwPHWtpJHSJ0uR0BWG2Kqa504w6gnixNjHJQYWbVPWJI1bs
         y/1myimpTmATjlGwQ0/ZE6NDaf/lAEApAUV2gEN/GV9C5jMOS2FEmfNz0HcVnk8DOggA
         evD9PLAuQyzQZFT0eGTN2Cl5Q5hw9NKpXnqDj0Wx4KwfaiZRLYqNTumJkE+dCoztlXKZ
         vMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309759; x=1784914559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7gjDoR3IrEHBROsQmG8DNciq7d/KYXAq5bY952331g=;
        b=GI3pSVmVy/YyUPepA7BRewYQs9D2KqX9Q8wkpdh17EWv/clB0fIevtx5MwkqHhjf4L
         2VOgV76fgq9RYWhfaIPR8CBxR4DucKdtWAVNggKYBUQN1Hdn53GrDSfwyBGINk44ij5P
         PhMID0vCJe3Ka/+gCTg9/2DTUp4F0E/+ViBrdYpLl01nU0f/g8GdNE1cehXF3zrFFBl6
         hjNIB9YUaUoa3ziuKTscgG3B6yy3k6d0eHfMgmC5fRE91fRgbeKe34UzAkCVtk6RWuzr
         +f6pwt4N73Rc1ZnkeVTQLv8vg/BXjRD2Omv5Fca2POvTwqO9kdGdfOI4/7RxiYwYb93Y
         fOlA==
X-Gm-Message-State: AOJu0Ywda7ha4tXV3acrHBUEorFcWu20DlURdFF+47Cctf/Q2qGg//Ss
	DPNNDG0Vi5L0mY7C5xoQiy5E6UiF74trpb+C2t2BnrYvdhkHnYJse4DsZ6OTjw==
X-Gm-Gg: AfdE7ckMNyp0XkM9/C6XWhac7Ubt1P5phN3xMCsuu8YCY5mOwkSG4//X5aNGIKS2zSQ
	f0LtwdDI3ebWM1g8mikxRB/+1dwywQq2BgTnhC6eAAp55cNB71mUkCZoYghBn5/+6QBvG7itS0a
	3yvwU83hNuMia3GZo6qEqNWK7Ln2+15Pd1ksHsSMw6ZYuZuh6p4C5PYQxOVvinKSwXDRBBgv9cb
	DM/fw4omE+Fhmh5GNyoQ+eXXKtuQiPrqM+x5T3o77+8CessF2JjrsUtyBxNdogZO7azQ4G07Xva
	KaTZ++mkwZGAZn9HADptlM2QHmWvrSDgaXFRV/985Raj2dR140gzuDB3d2vwtdXxIeMM9j7ixRh
	h/3Znt/oCVhawm76f4NIngbtTf8QTkal8dz9/vl+e2JveBJFFXgSSKElmUcc3oIz0ZpJjuaxNUh
	XEue93b4pQHqZ+hHb3053PPecy
X-Received: by 2002:ac8:574f:0:b0:51c:805:1be3 with SMTP id d75a77b69052e-5213b149535mr33235071cf.31.1784309758930;
        Fri, 17 Jul 2026 10:35:58 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-521502b92acsm18198041cf.30.2026.07.17.10.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:35:58 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Prevent OOB access of array when copying scope information
Date: Fri, 17 Jul 2026 13:35:44 -0400
Message-ID: <20260717173544.15801-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function copy_scope_index() in link.c copies information about
what declarations are in scope for the current block. This is tracked
in the "scope" field of the scope_index struct in an array of ebitmaps.
A second field called "class_perms_map" is used to track which
permissions are in scope for each class. The "class_perms_len" field is
the length of the permissions array. As the function is copying scoping
information from the module to the base policy, the index values are
translated as well. When the information for classes is translated and
copied the largest new index value for a class is determined. This value
is used to allocate the class_perms_map array. For each source class in
that array, the bits in the source ebitmap are translated and set in the
destination bitmap.

A maliciously crafted policy could set permissions in the module's
class_perms_map for a class that is not in scope. If that class has
a new index that is greater than the largest index of a valid class,
then there will be an OOB write when copying the class_perms_map.

When copying the class_perms_map, check that the index is not going to
result in an OOB write when converting. In addition, if there were no
classes, then just set class_perms_map to NULL and return. Also, don't
bother trying to copy permissions if the ebitmap is empty. Finally,
just use array notation when copying the scope and class_perms_map
data since they are both arrays of ebitmaps.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/link.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 70742fc8..868e0a7a 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1652,8 +1652,9 @@ static int copy_scope_index(scope_index_t *src, scope_index_t *dest,
 	ebitmap_node_t *node;
 	/* copy the scoping information for this avrule decl block */
 	for (i = 0; i < SYM_NUM; i++) {
-		ebitmap_t *srcmap = src->scope + i;
-		ebitmap_t *destmap = dest->scope + i;
+		ebitmap_t *srcmap = &src->scope[i];
+		ebitmap_t *destmap = &dest->scope[i];
+
 		if (copy_callback_f[i] == NULL) {
 			continue;
 		}
@@ -1672,18 +1673,28 @@ static int copy_scope_index(scope_index_t *src, scope_index_t *dest,
 		}
 	}
 
+	dest->class_perms_len = largest_mapped_class_value;
+	if (largest_mapped_class_value == 0) {
+		dest->class_perms_map = NULL;
+		return 0;
+	}
+
 	/* next copy the enabled permissions data  */
 	if ((dest->class_perms_map = calloc(largest_mapped_class_value,
 					    sizeof(*dest->class_perms_map))) ==
 	    NULL) {
 		goto cleanup;
 	}
-	dest->class_perms_len = largest_mapped_class_value;
-	for (i = 0; i < src->class_perms_len; i++) {
-		const ebitmap_t *srcmap = src->class_perms_map + i;
-		ebitmap_t *destmap =
-			dest->class_perms_map + module->map[SYM_CLASSES][i] - 1;
 
+	for (i = 0; i < src->class_perms_len; i++) {
+		const ebitmap_t *srcmap = &src->class_perms_map[i];
+		ebitmap_t *destmap;
+		if (ebitmap_is_empty(srcmap))
+			continue;
+		j = module->map[SYM_CLASSES][i] - 1;
+		if (j >= largest_mapped_class_value)
+			goto cleanup;
+		destmap = &dest->class_perms_map[j];
 		if (ebitmap_convert(srcmap, destmap, module->perm_map[i]))
 			goto cleanup;
 	}
@@ -1691,7 +1702,7 @@ static int copy_scope_index(scope_index_t *src, scope_index_t *dest,
 	return 0;
 
 cleanup:
-	ERR(state->handle, "Out of memory!");
+	ERR(state->handle, "Error copying scope index");
 	return -1;
 }
 
-- 
2.55.0

