Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92732BE7DC
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742368; cv=none; b=lC6XJuDrKN49ekD+zWgV8Iiyeu8MZFcRQNT91kPoT2+x8MJp2VyntjVnNB1SikXaZtq1yw3R5HFMWwA/j3O2wnBHypKhfYu0t7WjoBl3yO1lL7ZxF5ABuQmPM5n4W7MeF8o6zg2K5gP6VmmEco24fF5vZ3S6wQDLGK+N24bSqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742368; c=relaxed/simple;
	bh=7MFZWkYSh3YwnwKEsowhIrW2oqDi9bx9XbPiFVBYrZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgiYcKV8Lt8MsTuK0BdjTefsnK5vaMdP8+COSsoCVWX2KZS718HVnSxQQBMH2hGuDOPfLc3UWS6jd0cy8paHcL6oMrZTGXCmjMwDxGJcmlFc2OKIie2WZ2DKwD/W7VqgOyMZCD+gAaqBSM8QJcGbH779oFTFJcTfEHcWzchom9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXNlhfie; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXNlhfie"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c15bf5000so87264961cf.3
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784742363; x=1785347163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Yfvtaebso/UmcgzrhN8/S8KMFxfsowXFE/ApYqnYEw=;
        b=FXNlhfieqYs86txeqJkfMBuj5Z/+bYBrY2nrj2NIVkS/YhBZWzyubyEV+1ETInJeA6
         +DqEIjyu3twsXpeKHd2sNPQlFczVd3EiAlZ1R2a3fI4Ly70Vb49cpmezjOZjysxY9085
         nBDGddhuWmEs2k0YDv0Cd5NqfxNs8cBONJoAXFYLFrMzKe4/XGI+QItJ09vnfWZuQLce
         4YVE8GktRP1YuQM1N5ag1w/4XRwwvEcAirR1U+LTYlQwjBE7ScNkGBpaDfse4C/NxixU
         Wf1KbqrtGCMq9fKStOrqflTo0yu+mA7M2AWqOWMHb9wr7teNMYhnNDHOvHIouyl1NHVH
         +SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784742363; x=1785347163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Yfvtaebso/UmcgzrhN8/S8KMFxfsowXFE/ApYqnYEw=;
        b=qsjDJygyHvLPphnbKy/qb93NDjHOhb3mbfjGssDPABjdjEV7c3SSLwy4aSL01F4W9i
         mwvA0zrrfATRAh1CME4HjcXAJ7Qk1otvEY30PNy7EDE7pgovP/5d0PtpCHhiMK4xwz6O
         RUAViE3Cr8IJHWvxJPb+ZA+mrt/AGZ5fb9eAAZKYrZYk4YVJiuHiYKUNQcHOkVXf8vRq
         RU3J+uf9VCzUl6a3IlKK2zZB68TcWffRFxeGwRW0JMWJKT63DGfq4GQxNBR/ZcORN2Rq
         Vt90F1Im/1i012VpUynFn5Mctfa4eUL6XDxZGBnB3GwDqGsddXb24uw0XZmXhj6rS4N/
         Bmyg==
X-Gm-Message-State: AOJu0YyVrHd3Z5YujoklbPyxZqSN18Bfv7R06Cw5Lg7Wj3auW3Op7nMB
	eD2VlfIOyTreCqSNczEQHgiPB17riqCOAJj98YptHTs8TkGYudjLpqj5J1rgeg==
X-Gm-Gg: AR+sD132J2uxsfGeQ3AH31u8cS8m7qmKRF/V4Ll5dumN0VN94nwnj40HaJQFbskizm8
	lKMhQ6SHc08uDwJNpth5LNHlNMNFXmQQBtbmLp+IwnyL044c6eN8Tp7qXZMmQEnWJNj8Zw9OlO3
	eIjCSmBUUer33KwcJKqKUWNyPt2GYKjG1H4bWlltxPtyRwU09llSt4xXXidmZDqD2I4GmXKAGLn
	fMb+n5pm2imacMODpBFJ2J0LAeoneqSIG5sruRyTt1j+kaeEQnbIZmwLck5nkEvjw1FPh6YuD+g
	0GHIYNIoESyPICy6iMmqvfzD44kYrdbjO6oAWveqdzDqHq9XmSGBj0hjZP1MYZWU0MtvIpPkqUr
	kQj2kmViDVXFws4OylZX0iCrUhlw6JCeE40gr8i+7FqYAzO5ZJgR6G/L0TuUvHJvSjReV+O9crv
	Z0cqbE0LJQQGoHdowQthwQWkCA
X-Received: by 2002:ac8:5916:0:b0:51c:8432:1753 with SMTP id d75a77b69052e-5213c201a65mr242349251cf.30.1784742363121;
        Wed, 22 Jul 2026 10:46:03 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa0b7a0sm25587116d6.36.2026.07.22.10.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:46:02 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol: Validate scope index class_perm_map array
Date: Wed, 22 Jul 2026 13:45:51 -0400
Message-ID: <20260722174551.100020-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722174551.100020-1-jwcart2@gmail.com>
References: <20260722174551.100020-1-jwcart2@gmail.com>
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
 libsepol/src/policydb_validate.c | 43 +++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 166e20a5..1cf3868c 100644
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
@@ -1712,9 +1711,35 @@ static int validate_scope_index(sepol_handle_t *handle,
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
+			const ebitmap_t *map = &scope_index->class_perms_map[i];
+			class_datum_t *class = p->class_val_to_struct[i];
+			ebitmap_node_t *node;
+			unsigned int bit = 0;
+			if (validate_value(i + 1, &flavors[SYM_CLASSES]))
+				goto bad;
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
 
@@ -1786,11 +1811,11 @@ static int validate_avrule_blocks(sepol_handle_t *handle,
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

