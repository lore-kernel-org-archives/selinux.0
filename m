Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C793905F9
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390408; cv=none; b=CwuGe2l4UHvrk6K0R7FKDLezy4C9tqHouW4+1GsBtsyLLalUFpc5DF1HfJy5ffWPITloS6rmIazTIozGBe/jxjHjXf3TLOVviwjFHACK+6hCCB+ziwWt2I4IKK7QKwU1bWKM46bGUJm4f4Mq3p+JMJcucoVuG1FVvD59Fi9zxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390408; c=relaxed/simple;
	bh=dAqpaz6mceGG9DTR7268I2PAihFvxiJKerCTyLAxrD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oso9QeghPU4U0iW7dmTkBBscb9liC16iycKZQDQewjNhvhYs7kyg1GkCi18NEcfPljeOPnhNxmsnIRe4ypcVsWjt0p6xe6iGNe+KWZRm91kwdmuV/wcRzdxyORYLIsNvJTfmsu4Xk4EvdnhokU0+GtsiJWZgAJnX9HcF3FDAUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxTZI46e; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxTZI46e"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-911af978bf2so747757285a.1
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779390400; x=1779995200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocZK4ocEb42Qiibk50vZMgPeNOVaWBfHwl+xIWfuXDY=;
        b=rxTZI46eOJviyyE8qanJJih612vbm85081+eNtP8B0x97XtXorW8mHJRtZ40NdNjqE
         4qXXjzK5x3zVqg/jrLiMZQ9Qz7T89WKW8APUWgTr6o7B/4/cWOttrObcVPa63hCzXGpP
         e6I+c9zI4rqrfn20vqqXIN4tDB8CZr3MTt27B1cZWWkvtLqERY4FS1LBg3vHBnY+cN3E
         WrqxvdzlKpyBtrYSuniUBzgXHKFOczF/JF6abYYRm6L6NlIuWUZfvva5gShNZQBjlrNJ
         wn/mE3MD7FS6kvgXCJEiqgZynYjKWy2xJo9G13Rw7pXSP00hXxRiug8l3ohp27upr/Xi
         GybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779390400; x=1779995200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ocZK4ocEb42Qiibk50vZMgPeNOVaWBfHwl+xIWfuXDY=;
        b=c3gv8+f86NcG2Q6VGztTalwhsYzdTqCjndvBTuw8d+YYz9dwGAEpPMx2NE2OzzsbQ1
         OgBlczy3hlQJx3ug/k5YhBCs8YyTHuzdZlEhWLzECF1L1A6vRTL4HXJjAGgQW2M6VfpE
         hlzow50uimZ2QqzuIRXRWhyOiJDBkkrd+fzuD7nRUrrDKomW2lfqekj+b5sgFExrF8yg
         B/4QdCL+nNRea+Qrz9/3mtq9DglOy+7+1j6XvA0ZOMUHkhf58VAfzv/HELQhCkzK2Vd+
         6ouBoy4KoKQgKSP07gmpSZPsu56UHYmXuFdGB0bHgSjmi1RVEv+mJLgcYcU8hgTQf2WS
         hhfA==
X-Gm-Message-State: AOJu0YynfDZPsPqIBGtIi3Yt0W2gIBUFd0DkufoFSFRQBQfMjCn5scdw
	6FWX6o0xVUFfn9n5WqKI+xPWvoTpgKXTgKqqXgViGGMRFc0gfCzMVehR/sGtvQ==
X-Gm-Gg: Acq92OEJ9Gb3PiWCtD2FaVezLQYhTuH3dHG159lNWdMUEd3mBb+9P13aeHfCyWMm0cw
	zoWPPdr7Pw++DolHnTx7ZA+f2ZGn0QVeqmwH5S00g+w+L7WDwjpx9Pts2KCoQDFwsN3KvoCe09C
	XDVPiC7DlbDTfID6UNLLRZemiowvqUykQhoBMqt+7g2KBiQcLEYev44o5Zv88p+CM/uZk1+8tWA
	Kpq08msI7y+lTJzjqGpA0CQKtIXcZWmsjo6TpX+PnrIWcLTKDMH69UHOCOpkCjY5t7p1a3qFe+U
	CT5vPQYFajG2xX5O37LrGZlrQMFxMBZIJutoXMkpP9vRnR1TioJAtTAEQ2Nxibp9gXI4NJCOUoz
	dV84lVxcbLWrepRILSjCWvdByc9dAfj5YkFtw9HgN9rJaMeKOAEIX3pMslIboUsxHqfOD3KjYqt
	Od7kQS7gC9pBVvJ9X1jKz1isLrzJPOtkn2HmKdQ3ij03ozURIMPNJvmJHO
X-Received: by 2002:a05:620a:1982:b0:8c7:13b8:8b55 with SMTP id af79cd13be357-914b49a2000mr71948485a.46.1779390400393;
        Thu, 21 May 2026 12:06:40 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914abcc8884sm170674385a.45.2026.05.21.12.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 12:06:40 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3] libsepol: In module_to_cil correctly choose tunableif or booleanif
Date: Thu, 21 May 2026 15:06:26 -0400
Message-ID: <20260521190627.34885-2-jwcart2@gmail.com>
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

The flag COND_NODE_FLAGS_TUNABLE in struct cond_node is calculated
and used only during module expansion, so it should not be used
to determine if a conditional block is a tunableif or a booleanif
when converting a module to CIL.

Instead, set a flag when a tunable is found in a conditional
expression so the conditional block can be marked later as a
tunableif.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/module_to_cil.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 5f1e4dbf..f736288c 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1280,10 +1280,12 @@ exit:
 	return rc;
 }
 
-static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *cond_expr, uint32_t flags)
+static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *cond_expr)
 {
 	int rc = 0;
 	struct cond_expr *curr;
+	struct cond_bool_datum *dat1;
+	uint32_t is_tunable = 0;
 	struct stack *stack = NULL;
 	int len = 0;
 	int rlen;
@@ -1303,6 +1305,8 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 
 	for (curr = cond_expr; curr != NULL; curr = curr->next) {
 		if (curr->expr_type == COND_BOOL) {
+			dat1 = pdb->bool_val_to_struct[curr->boolean - 1];
+			is_tunable |= dat1->flags;
 			val1 = pdb->p_bool_val_to_name[curr->boolean - 1];
 			// length of boolean + 2 parens + null terminator
 			len = strlen(val1) + 2 + 1;
@@ -1388,7 +1392,7 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 		new_val = NULL;
 	}
 
-	if (flags & COND_NODE_FLAGS_TUNABLE) {
+	if (is_tunable) {
 		type = "tunableif";
 	} else {
 		type = "booleanif";
@@ -1429,7 +1433,7 @@ static int cond_list_to_cil(int indent, struct policydb *pdb, struct cond_node *
 		if (!cond->avtrue_list && !cond->avfalse_list)
 			continue;
 
-		rc = cond_expr_to_cil(indent, pdb, cond->expr, cond->flags);
+		rc = cond_expr_to_cil(indent, pdb, cond->expr);
 		if (rc != 0) {
 			goto exit;
 		}
-- 
2.54.0

