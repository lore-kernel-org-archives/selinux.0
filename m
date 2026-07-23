Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B424908AB
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834302; cv=none; b=k+kAp2XwsJg/UShPr1VLKAf5xDw/fKZto8XrmOdsmusyga/jBlsiWmoBvXWXBC7WIbW78HLKulvY4LvvM9ccFTyt+D6wsE4YSAOUQTxBNzPSpKZABqqUBZB4JopOGhS81Qh9NKBBJWo0x1/VGsqfUBYABkxtb4Ots2R+fUDxJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834302; c=relaxed/simple;
	bh=svbxfI6vvEumisLeuMCJrIKQvxGLNxZ9Z7FIog4RYpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uxr73NlLtRkAqm7YSlGyyUsT8mghJ5f29ulo0THoKELzgdEeld7oZtr1cpYgapHghiKxcGeVNGSPFPVo9FDg8ev/XC9uOE2dz89wGraozXDdrytXvURYIRKSxnfo55jYISPu0IOp5mRAIjTFeks7B0OP9bEBKZvXde89diWsAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYHwF2by; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYHwF2by"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92ea24a2dbfso97580585a.0
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 12:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784834300; x=1785439100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcvXkwTjKav3IdrM5jGfGlNr8r14yLwxdc1cV4/w9eE=;
        b=pYHwF2bykKsMRY8zSpbhf/FtQs81rUQrgQ4lPiSoGFJq8u1KSJx7TQ+QYJVEkOvQo8
         RVoFJi4Rp0KaNz/GRivWYHNbP/sXPBl0cZK1Gz/zvUADEWyR8IWKjpoHhquRIfxAjlPy
         9YqXYOD4PUdMXdBhiSnbrtuV8YSPdcqIfmrYwyaXXekh03Cd3EmqqZl2RmlHstnzazuL
         2aH0CC3aC+ek2CW2ffRmaCqC5G26R+WXhyT9KeHR86YtegULFpuZIu2WjH/Eyf//HwCF
         vaT1FTdvDMy9YosOduRkl/Nc29OPTM3qPpbbkOxhu5wCeI589pwcVK/eEMRMwA36amET
         8dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784834300; x=1785439100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BcvXkwTjKav3IdrM5jGfGlNr8r14yLwxdc1cV4/w9eE=;
        b=RmCHPVFiZ/muJtSqf1GPIbn5j8VIenXi4LMmEtKXYRKHMKASVSb/0Mla8EEc2Nl31S
         VdOa3aT8AGL1/mDVLJciNWcFlRrSeJyXTqpb8b0gL5R86BOxApbaV6HC3JaIu0LkKOZS
         FlOs3dzJ/y6w4zmCK0QOR7TOOjD082Rif4qmNCF8oBRB+puHdjL3AB8KM4mobAJrXuk2
         UhfkPXPkxWJKk4mXH1sDIbblbZEo3yX0Hqr2noQkWk92ERQa1Zg79tHXKdSIwHyQzdhy
         /PBA5l6flhpXpVygtvm5HlIO/kPyQR2dxBS9A4L9WgxEMGKf2cenqPX2qiJYZL80kwCx
         14ew==
X-Gm-Message-State: AOJu0YwNAPB7JGq2EwgBMQiTpCFA1AqH5JVn4uS22A55XuZ01nAqzd+3
	fY856a66UpvZ5hQ2enOVj93Fz/B82y2E7vQzPVcF0HYa9hzxcxX6CGWmAHt6ZA==
X-Gm-Gg: AR+sD11vOM1EnfotSEUBIBTOAqW3FoqLabe+/aueWXqOi6OXoUs+CPW9dQt0iF3lpUQ
	XQcpasE1jc1RAWrx4/y4lzJwhClimywhucoLsjcKYqZnetzzNIncupcf8gC9X2vnuTWsBgc2F+y
	zXPwiU8iprhIEwgLdqBL8B+/P0tLjtaLzGoMxL53uZFcFVxFiR4BP5PJ+bHglhFXPGbXBgw3tEf
	ovmQI2gAFzxnWyjGkqjtx3/KhOlwPHglW9cxpC9iuMwdp/UD4kTFucb1yrne406nI5RbCR6ie59
	+mccLgN32veOd/Dpdb7QxmMmYz/G6UxvrDPqOJE4gcqZM1czUQu1x5UVsJMFufW2mZ58X215ht8
	l4016rjkUnvDgOoNgkWhteB6JqJSoHILjo0JPM2wn9AbyAbFOcy8Njq9gYPPJa9ySpg26oAFQUc
	qz3wqviVds1NYKBeIOwzOty5xj9JVLarfun6k=
X-Received: by 2002:a05:620a:4486:b0:92e:fe10:3339 with SMTP id af79cd13be357-93103ad652emr472766685a.47.1784834300018;
        Thu, 23 Jul 2026 12:18:20 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a7f937sm480017285a.40.2026.07.23.12.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:18:19 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2 v2] libsepol: Validate scope index class_perm_map array
Date: Thu, 23 Jul 2026 15:18:05 -0400
Message-ID: <20260723191805.28568-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723191805.28568-1-jwcart2@gmail.com>
References: <20260723191805.28568-1-jwcart2@gmail.com>
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

An optional block has a required scope. For a required scope validate
that the array is long enough to contain all of the classes that
are in scope for the block and that for each class in the array
either the permission ebitmap is empty (the class is not required
in the block) or contains at least one valid permission. [Older
compilers could set all the bits if "*" was used.]

For declared scopes, verify that the length of the class permissions
ebitmap array is 0 and the array itself is NULL.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Move assignment of class and map to after the validate_value() check
    to make sanitizers happy.

 libsepol/src/policydb_validate.c | 45 +++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 166e20a5..2d7c3e71 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1690,10 +1690,9 @@ bad:
 
 static int validate_scope_index(sepol_handle_t *handle,
 				const scope_index_t *scope_index,
-				validate_t flavors[])
+				const policydb_t *p, validate_t flavors[],
+				bool required)
 {
-	uint32_t i;
-
 	if (!ebitmap_is_empty(&scope_index->scope[SYM_COMMONS]))
 		goto bad;
 	if (validate_ebitmap(&scope_index->p_classes_scope,
@@ -1712,9 +1711,37 @@ static int validate_scope_index(sepol_handle_t *handle,
 	if (validate_ebitmap(&scope_index->p_cat_scope, &flavors[SYM_CATS]))
 		goto bad;
 
-	for (i = 0; i < scope_index->class_perms_len; i++)
-		if (validate_value(i + 1, &flavors[SYM_CLASSES]))
+	if (required) {
+		uint32_t i;
+		if (ebitmap_highest_set_bit(&scope_index->p_classes_scope) >=
+		    scope_index->class_perms_len)
+			goto bad;
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
+		if (scope_index->class_perms_len != 0)
+			goto bad;
+		if (scope_index->class_perms_map != NULL)
 			goto bad;
+	}
 
 	return 0;
 
@@ -1786,11 +1813,11 @@ static int validate_avrule_blocks(sepol_handle_t *handle,
 			if (validate_range_trans_rules(
 				    handle, decl->range_tr_rules, flavors))
 				goto bad;
-			if (validate_scope_index(handle, &decl->required,
-						 flavors))
+			if (validate_scope_index(handle, &decl->required, p,
+						 flavors, true))
 				goto bad;
-			if (validate_scope_index(handle, &decl->declared,
-						 flavors))
+			if (validate_scope_index(handle, &decl->declared, p,
+						 flavors, false))
 				goto bad;
 			if (validate_filename_trans_rules(
 				    handle, decl->filename_trans_rules, p,
-- 
2.55.0

