Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F129B22F
	for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776193898; cv=none; b=ko6EdxZcNdBy50QhfSE3DXtiifYMTcDzxEQPN1HzI/E7lLaRWy2oCzkAYHP3rHwxI5zeoG1e3q4pd93JWvXeIzd8UtNsv8tsaUoh+hfs2v93MyvsU5w0f+PlDnkbYNhoTaX25O/foQqLWTtWwaL7BvK1Rk2gK1tr/cerSOUlXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776193898; c=relaxed/simple;
	bh=MYwtp4LZkcoyR4mS8NtHcWKkUwIGtH7rQRnd5LntcNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4wRLUPkFDt5hnaWhmi6PuQ/gemifZGwGdZk11A4pJV4VoOFw/Q25vLhAhLQKTUz/8goTcRIHSm2ipTTaSqhwSPg+4hfTVbcty6WNQ4RAyJ+wk+VbYYqUDOZrrAgrW7HzaS1IkIsmsXGR53aimdZ5SdZ8bpB3S4vJiIaZ4T6hNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPHAkuIp; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPHAkuIp"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cfd44fa075so670293685a.0
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776193896; x=1776798696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSie6lW8XVeKeIqsHo/RAp5lFLOCNJWgu6Y4fS3+ToI=;
        b=GPHAkuIp3CH5SQbJYBWbJacSRxwUvKD8EqWX68ss41HQY4YhfOZp3NZgEw7SIWM+Oa
         d2+PkhLAOTpsYhaVHarsbxdIAnIGbHZdGq6UiZ6PhLdxaYyEHSxxJaihFOW/GppEmw2h
         Nz2FlqAJctb3xXnqdrfAum1FrgXB+UP1xR5m516ycI4fA9pzk7RjdaqHiex6slHzgdXy
         HRA0alcSqJIbxNiA+CQG70PbaaWeONnVJ43wjO7aPaQDuRrcNy8cdSgRPip1SgwFJ9ND
         LSaaX9OzqZSvdg4q6yMWopGeJ8aHQHa2tALqgJ/H3CZyqUCbwepPyGvajODjoxZ5R1FQ
         DuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776193896; x=1776798696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TSie6lW8XVeKeIqsHo/RAp5lFLOCNJWgu6Y4fS3+ToI=;
        b=aEqaYNnTyzEQxdYJ9isFxa+Sk2mmeNchLxNXoCsftG8VQ32ydLy+D3Z2QF+zTN6Jww
         oFW6TfQjKiTH9ZYly+s2zPU+7pTpX5WSHqcbSiDs76Ga5YC8rznq19TV45qtisfitjQ1
         O9a/1eeU9Ir5kV29WWtvHZHPFVDpGKWmhzrCOdOIdY0Whm9F1lJZdg6eOXpaBvy/ab13
         4nuCckqN8TEE8uWhch45Ljo3sdtSglZtbac7D10xm2MIcNIotDRuCB28R7nPTNbPRDxX
         5SU/iWFSzfDaRtY41XTW0EQSvPSV/sgmCS0fPGR+2WwKA0exbXNkY1Nhs6sNsBCbyqNL
         /D1w==
X-Gm-Message-State: AOJu0YygTX1K4PVYdYMHlE3cxoOncAqILU59lWIcmOVMo9C6yGCC8Vt0
	I2XAd8CPGzDlR2xdbiaPSoR6dQWYgdTea453WHNwOtkp6lIkXWz8U1ZbELLZjA==
X-Gm-Gg: AeBDiev1y3dUP0WdVdePVTgRcqcZMZ0sAhlLwQScGxQqToa8dm+lBO7WyDzFQwjpMSa
	a5+Wq8l7edqeqFMLv2hnT7ZYYiK/jujBYbV3s6ApUwOL+jFX5PWKloJoLTIa6v+QH8LOq9b1x1t
	9Z3KRFlUsL5D4mwTP1csxQngcPxnoNFjU7knUq0SLDLTFiOAD7+Z+Rkbr3h2UMTtkdnBcqCaoUZ
	aZRigAiK6FMT8X8zT+pQiZrx4K6wDELuRJiEHw1ddG4+u0vA6N7PYJyd1QJGeu7EqI7sQ2NxOnT
	irQHiO1y0cAJ3eV1kV49BCuL8WOcPW0JgskOIT+HmLpi4HXl3TudkrRqGAWOQs+64wMR+UhlUeE
	Sg1JGbppN2rvdFEvNkXvHgV36EYu4qOEBNJvcLyHOV33tWffzXm/VN+eyWbwkx7L4SWSGDPdB8F
	kGVfu24GSJYcN/SUPp7yv0WvqgKuDccumX0mPEijwVUWFeDA==
X-Received: by 2002:a05:620a:400c:b0:8cd:81cc:5567 with SMTP id af79cd13be357-8ddcecbd10amr2590907685a.32.1776193896158;
        Tue, 14 Apr 2026 12:11:36 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb8d6e13fsm1210787685a.23.2026.04.14.12.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:11:35 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3] libsepol: When resolving names check if a block is abstract
Date: Tue, 14 Apr 2026 15:11:19 -0400
Message-ID: <20260414191120.29067-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414191120.29067-1-jwcart2@gmail.com>
References: <20260414191120.29067-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing in an abstract block in CIL is instantiated until the block
is inherited. No declartion, macro, or optional block within an
abstract block should ever be referred to from outside of the block.

Check for abstract blocks when resolving names and return an error
if one is found.

This patch is based on a report from the security firm Trail of Bits.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index bcac4026..b0965f1d 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -4355,7 +4355,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, en
 		node = ast_node;
 		if (*name == '.') {
 			/* Leading '.' */
-			symtab = &((struct cil_root *)db->ast->root->data)->symtab[CIL_SYM_BLOCKS];
+			symtab = ((struct cil_root *)db->ast->root->data)->symtab;
 		} else {
 			rc = __cil_resolve_name_helper(db, node->parent, current, CIL_SYM_BLOCKS, datum);
 			if (rc != SEPOL_OK) {
@@ -4366,14 +4366,20 @@ int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, en
 		}
 		/* Keep looking up blocks by name until only last part of name remains */
 		while (next != NULL) {
-			rc = cil_symtab_get_datum(symtab, current, datum);
+			rc = cil_symtab_get_datum(&(symtab[CIL_SYM_BLOCKS]), current, datum);
 			if (rc != SEPOL_OK) {
 				free(name_dup);
 				goto exit;
 			}
 			node = NODE(*datum);
 			if (node->flavor == CIL_BLOCK) {
-				symtab = &((struct cil_block*)node->data)->symtab[CIL_SYM_BLOCKS];
+				if (((struct cil_block *)node->data)->is_abstract) {
+					cil_log(CIL_WARN, "Found %s which is an abstract block and invalid for name resolution\n", current);
+					free(name_dup);
+					rc = SEPOL_ERR;
+					goto exit;
+				}
+				symtab = ((struct cil_block*)node->data)->symtab;
 			} else {
 				if (ast_node->flavor != CIL_IN) {
 					cil_log(CIL_WARN, "Can only use %s name for name resolution in \"in\" blocks\n", cil_node_to_string(node));
@@ -4383,7 +4389,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, en
 				}
 				if (node->flavor == CIL_MACRO) {
 					struct cil_macro *macro = node->data;
-					symtab = &macro->symtab[sym_index];
+					symtab = macro->symtab;
 				}
 			}
 			current = next;
@@ -4401,6 +4407,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, en
 
 exit:
 	if (rc != SEPOL_OK) {
+		cil_tree_log(ast_node, CIL_ERR, "Failed to resolve %s", name);
 		*datum = NULL;
 	}
 
-- 
2.53.0

