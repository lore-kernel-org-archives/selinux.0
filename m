Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC7376BEA
	for <selinux@vger.kernel.org>; Wed,  3 Dec 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779555; cv=none; b=SKmK1SHA5Mg2VvfJAYHnlMX2fZUsdwn1Bcy1k/+z8Vaeh4xR8G43sMvqC/oM8HakRcoGWmZnexRcv8KRi5SyIjmIt8bFpdQK3dlPE/68Mpeu0Z36/omSAzYJSZ5PlTxD8BGNg9yIfU+r1lY/pehGCL/sulqFBC1TUdQ80sxVBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779555; c=relaxed/simple;
	bh=lfgoLC8OCFWUCTwOdmZgk7/vfRTMwXZNdLqgAsYI1FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWmRadNWGxFvyafJZFRd0tHDaH+Dyr91zjy+6M2PAO6TnE891SfiFk555xtdCuziTFGg0NF4ZpmO4c8jtOQXtmQgQitedIPGMF907onM9XED/Wj+fmLtXJ5/YTF6ZZzQnYOt2jAkVf2dr8G4o85fw2qzMpacP8uGlefTFGKM21M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSFHQUNU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSFHQUNU"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2ea2b9631so644476785a.3
        for <selinux@vger.kernel.org>; Wed, 03 Dec 2025 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779552; x=1765384352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He8D/sVmP+FmPUg2OENU5aQI0DL/WudiU372xQUBgtY=;
        b=jSFHQUNUbzS0dlzj97DcLLX23mD9Q427ANCWKd+rKLmv8mVLrCI/hRXcyXUc5vTTto
         Y8UUYA1McU2fSfApTQHmVv3z79vXBDdhqdeGdOb5sOFs4oN05gicuHsaPOg+z0ZFQ2TS
         g3BNbu/LTFe/Pi2AtdPZFeE8Hlus82UjLuJ0w/jIPRvalSXUJqOrFVhx3ZUYqlss7/mK
         aw+ZSNK7kRRqvhSYCN7nhLckN/ct08BFq/mE9PdQmy9XZkjkWdROq+uJwSQmI0JlE+Ge
         LoXS8O+JKXqCnvU7SHE5bJhpQdAadMdV+8zO7AE7pmNijUGRZ069xT1EIZ70PIiyWQpy
         UNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779552; x=1765384352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=He8D/sVmP+FmPUg2OENU5aQI0DL/WudiU372xQUBgtY=;
        b=DPpMWrKlzlGCHL/5iKytN7OS35E5Z+22P1upSG7vG6aYz1zue4ZuhoJxt3tDQCjgJd
         zMxDTVdUfB5dDGQmxf1e9lvp1f/pNPtIkp/ETUYukEEAqhluSzEwS0ppyYaCe+BBTcQb
         GUIf0rnOeYLZkTbTVdnyHN/48KxvQBu8/8ZURNSTyttI9slrUk380P2oOC4ocHmkLJln
         kSsTCnGSyGYHbKuuRNQdAmv9n4euqab/xAPKzc7oYrflV729bbS6S70HDWjT7tzVYUWu
         1O30cHUH8yeKd0w+Fjgz6PZaxXasPfkSCdM07gNxVnIXBe+3cVC23lINcIH2pTbwvkEY
         iNag==
X-Gm-Message-State: AOJu0YwiOYLoAGy0fK8n/dUd0gR7cb3N2FJT0zaus8wwqqHwFHn9FCM5
	lkCFcDZkbebeYskEn6V17WrQ9NMhAuGmF7nVj3BaORpNPqvdEHslzDZfxeK4jw==
X-Gm-Gg: ASbGncuZSiASXz+KxaOanFdm/Vj5Hcpci0OcXJxGE3yJcTeQ9EJ2wpDIV/GTnecVl65
	3ATIR7lUY5yyIztICqWJQHQBV21eHhD8GBy5CvwFiUTa9MbyVHUY2sW+8uqPIAPzMH2yRyBq2bk
	zGYoAELdAp0U5vhIJSQDaDv4fh5t5aX+86XMZISulFfkn1TCyYsR+l2m/ORD0o/9JbKwmxXyvfn
	v9wJrRvJBkE2D/8FyagXbIYczTn+MyfZ0ox2152pfyKjwLx6iAs/9XNxVjeaUaRmSyo/gvUOPYX
	e7uF0FkNAdADWHZNHLQRJn2GYx3cC5sV8Xk55Soo/59s09qbTpUbAEIZeWfimWkTAlABGPP81Ev
	S+D958RAavISBUyiD+q8S3lcZnSWAFqiItB0vk2EjCssCRwjko4g5x418pKM4zKokw7trxpvLXf
	m6DOFh1CTr4lGl7Aq6bhSlHZ4lYkoN5g==
X-Google-Smtp-Source: AGHT+IE9rIX9wP/exhm5rhmOR7iSms1jeLmQftkg0zHf2jyuB09GXHvB9DNNfe6xh7DW6k3JjBaFug==
X-Received: by 2002:a05:620a:c55:b0:8a4:b9eb:e62a with SMTP id af79cd13be357-8b5e47d0422mr358739685a.23.1764779552375;
        Wed, 03 Dec 2025 08:32:32 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1cad4esm1333399485a.45.2025.12.03.08.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:32:31 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/6] libsepol: Fix processing of levels for user rule in an optional block
Date: Wed,  3 Dec 2025 11:32:16 -0500
Message-ID: <20251203163218.54939-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251203163218.54939-1-jwcart2@gmail.com>
References: <20251203163218.54939-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When converting a module to CIL, MLS user statements in an optional
block are not handled correctly. The string names of the sensitivities
for the user's default level and range are not looked up correctly.
There is special code to look up the name of a sensitivity directly
from the sensitivity's id instead of with the usual -1 offset.

Instead, lookup the sensitivities for a MLS user statement in an
optional block with thei usual -1 offset.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/module_to_cil.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 1c4e80d1..41c2b051 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -516,11 +516,11 @@ static int is_id_in_scope(struct policydb *pdb, struct stack *decl_stack, char *
 	return is_id_in_scope_with_start(pdb, decl_stack, start, symbol_type, type);
 }
 
-static int semantic_level_to_cil(struct policydb *pdb, int sens_offset, struct mls_semantic_level *level)
+static int semantic_level_to_cil(struct policydb *pdb, struct mls_semantic_level *level)
 {
 	struct mls_semantic_cat *cat;
 
-	cil_printf("(%s ", pdb->p_sens_val_to_name[level->sens - sens_offset]);
+	cil_printf("(%s ", pdb->p_sens_val_to_name[level->sens - 1]);
 
 	if (level->cat != NULL) {
 		cil_printf("(");
@@ -1586,14 +1586,14 @@ static int range_trans_to_cil(int indent, struct policydb *pdb, struct range_tra
 
 					cil_printf("(");
 
-					rc = semantic_level_to_cil(pdb, 1, &rule->trange.level[0]);
+					rc = semantic_level_to_cil(pdb, &rule->trange.level[0]);
 					if (rc != 0) {
 						goto exit;
 					}
 
 					cil_printf(" ");
 
-					rc = semantic_level_to_cil(pdb, 1, &rule->trange.level[1]);
+					rc = semantic_level_to_cil(pdb, &rule->trange.level[1]);
 					if (rc != 0) {
 						goto exit;
 					}
@@ -2320,7 +2320,7 @@ exit:
 	return rc;
 }
 
-static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *block, struct stack *UNUSED(decl_stack), char *key, void *datum,  int scope)
+static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct stack *UNUSED(decl_stack), char *key, void *datum,  int scope)
 {
 	struct user_datum *user = datum;
 	struct ebitmap roles = user->roles.roles;
@@ -2328,7 +2328,6 @@ static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *bl
 	struct mls_semantic_range range = user->range;
 	struct ebitmap_node *node;
 	uint32_t i;
-	int sens_offset = 1;
 
 	if (scope == SCOPE_DECL) {
 		cil_println(indent, "(user %s)", key);
@@ -2341,16 +2340,10 @@ static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *bl
 		cil_println(indent, "(userrole %s %s)", key, pdb->p_role_val_to_name[i]);
 	}
 
-	if (block->flags & AVRULE_OPTIONAL) {
-		// sensitivities in user statements in optionals do not have the
-		// standard -1 offset
-		sens_offset = 0;
-	}
-
 	cil_indent(indent);
 	cil_printf("(userlevel %s ", key);
 	if (pdb->mls) {
-		semantic_level_to_cil(pdb, sens_offset, &level);
+		semantic_level_to_cil(pdb, &level);
 	} else {
 		cil_printf(DEFAULT_LEVEL);
 	}
@@ -2359,9 +2352,9 @@ static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *bl
 	cil_indent(indent);
 	cil_printf("(userrange %s (", key);
 	if (pdb->mls) {
-		semantic_level_to_cil(pdb, sens_offset, &range.level[0]);
+		semantic_level_to_cil(pdb, &range.level[0]);
 		cil_printf(" ");
-		semantic_level_to_cil(pdb, sens_offset, &range.level[1]);
+		semantic_level_to_cil(pdb, &range.level[1]);
 	} else {
 		cil_printf(DEFAULT_LEVEL " " DEFAULT_LEVEL);
 	}
-- 
2.50.0

