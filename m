Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A7449EA4
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917765; cv=none; b=R6Wn88G1XlrVkGxnSoormh6QFrHwGSmGC3HbPNr/RmA0WJiuqU6rnEZoP9Mx1noKatAVMBlV0gXIU/KDjPNRjgz577i0r2iZVxoTbQ1wm+0VqIhrUwiSEQrCxf3CMHbFAe24s5zPHz276HBtF2nM6o6Gbox2OqnxnijEUp5/HxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917765; c=relaxed/simple;
	bh=Efc7JY9liE9mlc0GdslqtH2sBtoeEKbVKgLEn43jOYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMe4nf55u6qStuPuRQ2e2wKZsBWY8ZtiLE6cSuIPDfCzc6iZc+VEYhAqFCd5Gt4Kdv6uhmksCEkKJNGhSJ6jiyto3VNPNfNN+FyXaKa7b227UavRxyxVpexYFhZOept6FcUwMCuaCzKyxUKRyUt9H0BMbg0X/EI9mzVETXM/PgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3Llk1uE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Llk1uE"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e512a9a6bso53028185a.2
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784917761; x=1785522561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HrIPYdINtrBLcR5oxdoqPnNwrpO9F6HT+ulbp0r1NpU=;
        b=J3Llk1uEwyPS75V5Vk3MSQU4mdD4l5SVD9YcdqiouoJBCBooU6ug/5oTmw32wN2mcw
         kscwa7JAFE+b1c9s9xpvbLgANm6IqNVGHE7TNcdVPKSpXutTW8oPFA4J9D0N7aF312G/
         XMxYlJ661gl606aHTqPNETfbNMb9rflnX0ROFiah+jFGWxsvLpDGXFYoRpr+foTK5UMF
         pjeOROYFDhZtGLc7nEBWZ8PcFlmMrGnWmnyUkKeycPzWLOCjvBmUEhst580PquHFSW4w
         WEc4oYv5k+j66nPd4hE2z/YwOFpCeJsoP7n0NsGmrArZI5g4bwmmxbTZ8A44Yjm+GWvj
         /EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784917761; x=1785522561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HrIPYdINtrBLcR5oxdoqPnNwrpO9F6HT+ulbp0r1NpU=;
        b=JJm3NzW/VlYRBzb+5Mt2/yyQs2nXjsDGmJXLZXnAbqDvCurrkUSD6fQQMxvj/7KZeO
         aO0hSll217arLjC3X1/JiWrvwZ2MMjIB72lQ0bY+1V+I5wT5y9DpMcHjHjbBYtHsMWOJ
         C+NOD/W+OO9GXQdJGpAecrxmVoY4D75iSjVPGkgM3eBTOxNw8MBXVTW6CX0fG8Je3Geu
         nUoEdnG3n/nWLYPwZMBm0KQp/j8pLjv5IjrIYHXMULtTp9KRfuubg88gWNeG24g/Oxzd
         TaPbe50q550cLKJIYmOmGFTTtg811zbb+X98XdLaqVV8RuMDKkK6ZNd2H62hW+S83aec
         fGxA==
X-Gm-Message-State: AOJu0Yxw2iSeV1wCGQb90dUUSi83FJYlTbrqWGviyn4UhxajIxPb2+BH
	CzSVHvynBXxMoAm5PVBkrTtUkTgw9pABCXlbMcoGnWlCF2Ea7NW0CO5qcpbkaA==
X-Gm-Gg: AR+sD10mVRazaa93l6y+eXg41N2Wwn6cwSThfELeLeUpVK310M7tgxy01m6TicjtDzl
	ICiO4dfGdAg9k8aIILdYWFokS7TMD8pWhj5rujGKv/SvdFAaDU07fEjkJGURsrvzqTopDgbuaR+
	26BIqoIY29ocYavYag2CCeZfI+2NqPNx+oV9/ccUWcc5gfruAgMfK3w3UPcDQJpXtksnQPsTmfP
	Tw06ei4ouR23s2ReZL0bsKVgBPP2Q5Q85IBpz9aKqme3E4QRoeg/Pu/Le0u4z9mXdmEsXhXws5K
	wC23RDTIBckznIo9hcB8Xk8clHKiTn4nyxBFDp8fGQH+Q9DrPIjVEmnGqMqrNG3ZCUB4R6i+5Fz
	00m0b0MJv4d6KR7rAF7sQyeGwN/6BYQ3gm8Fn8t+hEK7tsQlZF1+JMzCThNjLhgfm/ZlDmk2Nwe
	g7S4/jakKaEQyogHSxl0d6ygO4frsk90C9ofg=
X-Received: by 2002:a05:620a:1a14:b0:915:a427:f2a3 with SMTP id af79cd13be357-9310384e3e2mr914972085a.6.1784917761193;
        Fri, 24 Jul 2026 11:29:21 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e871e226sm3765026d6.47.2026.07.24.11.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 11:29:20 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol: Validate scope index class_perm_map array
Date: Fri, 24 Jul 2026 14:29:08 -0400
Message-ID: <20260724182908.97023-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724182908.97023-1-jwcart2@gmail.com>
References: <20260724182908.97023-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In addtion to the array of ebitmaps that shows which declarations
are in scope for a given block, the scope index also contains an
array of ebitmaps, class_perms_map, that shows which permissions
are in scope for each class and it contains the length of that
array.

If the class_perms_map is NULL, then verify that class_perms_len
is 0. If the class_perms_map is not NULL, then verify that the
class_perms_len is not 0 and that the array is long enough to
contain all of the classes that are in scope for the block and
that for each class in the array either the permission ebitmap
is empty or it contains at least one valid permission. [Older
compilers could set all the bits if "*" was used.]

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v3: - Stop differentiating between required and declared blocks and
      instead differentiate between NULL and non-NULL class_perms_map
    - Remove the added bool argument "required"

 libsepol/src/policydb_validate.c | 45 +++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 1d8e0870..fc66a4c7 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1713,10 +1713,8 @@ bad:
 
 static int validate_scope_index(sepol_handle_t *handle,
 				const scope_index_t *scope_index,
-				validate_t flavors[])
+				const policydb_t *p, validate_t flavors[])
 {
-	uint32_t i;
-
 	if (!ebitmap_is_empty(&scope_index->scope[SYM_COMMONS]))
 		goto bad;
 	if (validate_ebitmap(&scope_index->p_classes_scope,
@@ -1735,9 +1733,42 @@ static int validate_scope_index(sepol_handle_t *handle,
 	if (validate_ebitmap(&scope_index->p_cat_scope, &flavors[SYM_CATS]))
 		goto bad;
 
-	for (i = 0; i < scope_index->class_perms_len; i++)
-		if (validate_value(i + 1, &flavors[SYM_CLASSES]))
+	if (scope_index->class_perms_map != NULL) {
+		uint32_t i;
+		if (scope_index->class_perms_len == 0)
+			goto bad;
+		if (ebitmap_highest_set_bit(&scope_index->p_classes_scope) >=
+		    scope_index->class_perms_len)
 			goto bad;
+		for (i = 0; i < scope_index->class_perms_len; i++) {
+			const ebitmap_t *map;
+			class_datum_t *class;
+			ebitmap_node_t *node;
+			unsigned int bit = 0;
+			if (validate_value(i + 1, &flavors[SYM_CLASSES]))
+				goto bad;
+			map = &scope_index->class_perms_map[i];
+			class = p->class_val_to_struct[i];
+			/* Either there are no perms */
+			if (ebitmap_is_empty(map))
+				continue;
+			/* Or at least one valid perm */
+			ebitmap_for_each_positive_bit(map, node, bit) {
+				if (bit < class->permissions.nprim)
+					break;
+			}
+			if (bit >= class->permissions.nprim)
+				goto bad;
+		}
+	} else {
+		/* This is the normal branch for declared blocks.
+		 * Base module required blocks should never be in this branch.
+		 * Module required blocks can be if neither its nor the module's
+		 * require block has a class in it.
+		 */
+		if (scope_index->class_perms_len != 0)
+			goto bad;
+	}
 
 	return 0;
 
@@ -1811,10 +1842,10 @@ static int validate_avrule_blocks(sepol_handle_t *handle,
 			if (validate_range_trans_rules(
 				    handle, decl->range_tr_rules, flavors))
 				goto bad;
-			if (validate_scope_index(handle, &decl->required,
+			if (validate_scope_index(handle, &decl->required, p,
 						 flavors))
 				goto bad;
-			if (validate_scope_index(handle, &decl->declared,
+			if (validate_scope_index(handle, &decl->declared, p,
 						 flavors))
 				goto bad;
 			if (validate_filename_trans_rules(
-- 
2.55.0

