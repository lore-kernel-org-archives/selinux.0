Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F54028C8
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390412; cv=none; b=sMqRXGnlHhCrO0YsYmVMvlYAFloWJ0p8TzAmxVPzO2mXTczLbvQZdSBhRJkyQS/o2n3N8K58xf6tjAVVq5f6XjkIFVtbOaQ+Lb+9Bo4SCSmp/7l0Gl4Bllx0EqlUFde3ElLm8SYJy+wzAswAEsKxbI6Yw/XjOf1PP9VEFx3UarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390412; c=relaxed/simple;
	bh=TdBSHhnuNDjAy5vNWyFWXzJ+PWERvtIt7zadQekZs3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSkdCxSHXO3AOdC2fGge0RFemexcFzz1QONEh0/1+WdSq4K4axO46kAPmSPagmOjQSsp1cX9nAyoJ0TllMAeJ1FfFkeAdyo1QyNiUH4AZ1CK67Pho0gzZmWbh0v8sI+Zp842N23jGST6YMWfM0umOw7WCbzYlh1Odlju5a8Wwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3Ms3GXn; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3Ms3GXn"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9144163319fso607601685a.2
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779390402; x=1779995202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OMZiZh/rRkh0JY8OD2zYQkR84EZz5bPRoaBWhA/I8U=;
        b=A3Ms3GXnaUB+BYguscIP/EuUot5XLmEqXPyxseS5nFbP58BpszXPdGdTTQ2DoBGdnS
         6/WNjJwkKHau+8DR4PmRINeGpgftRka81WnylrFs9fOpyxM7X03PNKDhjvRiKpFpDPeQ
         AL6k50rZZ8D+To/t8GUAqmVi3++YvHFJGFvMqMjpgCdqSPgwyqlQ9ldIz9tcYpOiY8Xe
         g60Kd+GABseexR0cf0r9rmqHhqEyGnm78bkYqoQEbqEOsZlc2VYMzvanZYhq8LJbNyRl
         jIASyeZ/wpB0+M7nbKV5ZW+vHFmw5aTRZrxvCUiuL/Tvde0vRm6NOWioVeOwO0j67DWH
         hmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779390402; x=1779995202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+OMZiZh/rRkh0JY8OD2zYQkR84EZz5bPRoaBWhA/I8U=;
        b=gxMlDP0HrXaiBNoPC7CJVLjWdpddO5RQHxtjp2PSzQwYavxOdlhujqss4i6GoC0fMe
         cqcgyjv//IlsnSiriHnWN/TSy0sP2FE5DB7eU9ZJKiVptVLrmloOuWWscsRNHV6si5j2
         AMK5lfm7KdvgZeq+V87/PeF3kX7HA2sxCn2zccTaZw7fzonDs5bMn9Cgbdg6dSMIAigS
         QtkGI6xIabs70u4pw+dCkt5v4u01juV+uG4pAjMnrKbiUAw34LijQrtN2AqfSnpOLCsJ
         BXWobYkxdMJhtLc+Zs1+b+tDLljfgzCz3gSP/stQM/Qw7Znaki7qZMamtZO+NKnJdJOZ
         KP5w==
X-Gm-Message-State: AOJu0YyE9X4kQxgEgrZKV6Hak7KFtx37Nhqsqa7QbGR17X/eOyVOXQuU
	ORsaVLm4Hp+sK2CQJ5YwBeCd1vz9dNtEE6eC5sT3VEwOrwMpmFuiIlD6JPMP4g==
X-Gm-Gg: Acq92OEerDqH/bDR+VWjmQrNaGdgTgFWVP9FNRUKwwbxbAWjhDhluXYvZyfRB+/1ano
	bkAjZBO2x+Z4fZQp/TDSsy7j6IILshNcA86h52yk/HrgrFeD3V6JbY9I0Hv8+4U2T3ASzo2gEah
	t7Uw1zYU8PFWFu/OeXTl9g/fVKydXbkdVUZe6wpnKhjG5FlPUMiDbGUlhduQhxsWuMMnqMdoOZh
	AK9lfvSkhv478HlyxN3h2kPkfklVCzXe7xr4bNSDoSlPKAJe4G+ASGkdNXIkscBAhFiQOlYZMWV
	QdCEzNUl/d9zvNJ+efzaenxFbmwc2q7mKz1nk36pWQxL6aRwCdYwmcgqOEt+xOSaLef9NXc/2xb
	p41pXDc8NhkYtPIVBLcwF1Ds5QdxXMwdVaoIkAkPIXRnYwnE1QEIzvhuf/V40kCq9hYdOp19QVj
	02Vy+p/6Pw/+bwT3cy6xq6mVMHqu1hxUFjKznp8gnl21MfBxa31nOclVqy
X-Received: by 2002:a05:620a:4686:b0:912:1206:ddc2 with SMTP id af79cd13be357-914b46ca07fmr78875985a.5.1779390402081;
        Thu, 21 May 2026 12:06:42 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914abcc8884sm170674385a.45.2026.05.21.12.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 12:06:41 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3] libsepol: In module_to_cil use constrain and validatetrans where possible
Date: Thu, 21 May 2026 15:06:27 -0400
Message-ID: <20260521190627.34885-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521190627.34885-1-jwcart2@gmail.com>
References: <20260521190627.34885-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When converting a module to CIL for an MLS policy module_to_cil was
always using mlsconstrain and mlsvalidatetrans.

Instead only use mlsconstrain and mlsvalidatetrans when the constraint
expression contains l1, l2, h1, or h2.

This follows the example of kernel_to_cil.

It also avoids an error that would occur if a user is referred to
in a constrain that then becomes an mlsconstrain. "u1 == user_u" is
allowed for a constrain, but the error "unknown user user_u" will
occur for an mlsconstrain.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/module_to_cil.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index f736288c..79d34576 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1742,7 +1742,7 @@ exit:
 }
 
 
-static int constraint_expr_to_string(struct policydb *pdb, struct constraint_expr *exprs, char **expr_string)
+static int constraint_expr_to_string(struct policydb *pdb, struct constraint_expr *exprs, char **expr_string, int *use_mls)
 {
 	int rc = -1;
 	struct constraint_expr *expr;
@@ -1762,6 +1762,8 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 	unsigned int num_names = 0;
 	struct type_set *ts;
 
+	*use_mls = 0;
+
 	rc = stack_init(&stack);
 	if (rc != 0) {
 		goto exit;
@@ -1803,6 +1805,10 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 				goto exit;
 			}
 
+			if (expr->attr >= CEXPR_L1L2) {
+				*use_mls = 1;
+			}
+
 			if (expr->expr_type == CEXPR_ATTR) {
 				// length of values/attrs + 2 separating spaces + 2 parens + null terminator
 				len = strlen(op) + strlen(attr1) + strlen(attr2) + 2 + 2 + 1;
@@ -1979,18 +1985,26 @@ static int constraints_to_cil(int indent, struct policydb *pdb, char *classkey,
 	int rc = -1;
 	struct constraint_node *node;
 	char *expr = NULL;
-	const char *mls;
+	int use_mls;
+	const char *mls = "";
 	char *perms;
 
-	mls = pdb->mls ? "mls" : "";
-
 	for (node = constraints; node != NULL; node = node->next) {
 
-		rc = constraint_expr_to_string(pdb, node->expr, &expr);
+		rc = constraint_expr_to_string(pdb, node->expr, &expr, &use_mls);
 		if (rc != 0) {
 			goto exit;
 		}
 
+		if (use_mls) {
+			if (!pdb->mls) {
+				ERR(NULL, "MLS constraint expression in non-mls policy");
+				rc = -1;
+				goto exit;
+			}
+			mls = "mls";
+		}
+
 		if (is_constraint) {
 			perms = sepol_av_to_string(pdb, class->s.value, node->permissions);
 			if (perms == NULL) {
-- 
2.54.0

