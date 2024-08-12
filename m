Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAEB187348
	for <selinux@vger.kernel.org>; Mon, 12 Aug 2024 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481803; cv=none; b=f6ktpiOLt9kANfzh61HsZyndRzey1wVp55LXnytfyvpK0IBnaSF7rzEwWlBbXNB+yPVlGFY1DEDHwQkoRBqG4S139qLkuMWse0XwJMngy3+Ww13ysO6Ubq4mXxglbiIl/j05sARwBtZnd07WSH2ODdLT4K9r9J+P0Ye67Q54DOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481803; c=relaxed/simple;
	bh=p+tJD6kYdI4lbsncHczJtfmGEKHrHEWIFY0RMLfCXyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZbA41cIwrTsnvVFdC9UZq1nIn1o2Cm3JG9dy3gg2poouuq1cazHqezN5UEfBQg1t6jlgG2yI5yiYG1Mg5JwYszl15q89zmBLZQFIeSUWKJIft/UIP5pkdGCDQ+SE3I54alO6ZxLf57/owLj0kqCQzZO0zfcymgN7Q7ZOeBKRJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K16QAN2x; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K16QAN2x"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db19caec60so3145154b6e.1
        for <selinux@vger.kernel.org>; Mon, 12 Aug 2024 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723481800; x=1724086600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7yJNlGVhHF46k/ih9WdMYGAeqCmb3O+6S/ssB9VMlWA=;
        b=K16QAN2xQtyY9zkXRFxCJP1e7JYaCjtE5KLyFtJQnWrTRz7IpF7qhTqz9MDU95XJuj
         iCERifK6oUCTWQnrQUn+TsCfazhh/wUHex1TrJcrNoW4IzKOeDzmTUTAg8/M9RqnA4QO
         MafSLrMFJttCRS2YHKCBxBJiEt2IzniEDBOLNrvsef3mwLlEL+LwEzjLCny+ShfVvCNw
         qmcgl+vMXQUoJEzQsXWvq4f5a+EeAcSUmpu+HqjoeEsxhTo8dhHqrzGw5iFER8ELiWMc
         rCHFEPC0fhjwynEOL9mDV9pk/9eA2mFVaX4nY+XQebbEzNRTaM5fjpLOQjWvAWrFwyBd
         m+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481800; x=1724086600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yJNlGVhHF46k/ih9WdMYGAeqCmb3O+6S/ssB9VMlWA=;
        b=GvmUNGsfvwoJAIHlCNBuvqeG8atJPpL6RTbW3ecI6Fp/kJ+UDuURaGpMOeJLmcj3NX
         sm5lFY6w911MK0D2wOQyTCZdJ1OrcfmeaVOZyiEyuQV6rLY6G7DDXM+q6qgaRRhnxHbE
         P16+/nENeO44ej9uPSywuPkP+RDvI1V0B/FWrv7xaDok2KJp2mWHjdHiUAhLHgHWxkwH
         ZaWu+bg5B22tPEBna3lUpFNTMoZA3qFPJMC/63ylsrMMjNOLKafzMCzC3ZLGpvmyFIN9
         fQdSm7G5zwJSytBNwQQaHQcc5iuMoLvbsLgllBvGVIgCXVTw4n0tvvBL6meFctK5V0g1
         ceMg==
X-Gm-Message-State: AOJu0Yyc1vZd6+OoHCQQPjCaT9XMNGScw4emH3/SQTYSLeL0sMjSDKzJ
	Q++WOrcrpOEWwQxepDoOC71xZ2by/2u9E8b+0BFiVTeXu7lu8TkMgbs38A==
X-Google-Smtp-Source: AGHT+IHG7d2m/H1NyReUwP2EieZ5UQaEd5f8rmIB1KgK3xPl4erqlnWaPOUL9dkyjfOe3OlVDPGb6w==
X-Received: by 2002:a05:6808:16a6:b0:3d9:38e2:5392 with SMTP id 5614622812f47-3dd1eecf805mr987352b6e.36.1723481800239;
        Mon, 12 Aug 2024 09:56:40 -0700 (PDT)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c2918d0sm24691861cf.82.2024.08.12.09.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:56:39 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: dominick.grift@defensec.nl,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Allow dotted names in aliasactual rules
Date: Mon, 12 Aug 2024 12:56:33 -0400
Message-ID: <20240812165633.49121-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function cil_gen_alias() is used to declare type, sensitivity,
and category aliases and the function cil_gen_aliasactual() is used
to assign an alias to the actual declared name.

Commit e55621c03 ("libsepol/cil: Add notself and other support to CIL")
added "notself" and "other" as reserved words. Previously, a check
was made in cil_gen_aliasactual() to ensure that the "self" reserved
word was not used. With the notself patch this function was upgraded
to call cil_verify_name() to verify that the other reserved words
were not used as well. This change prevents the use of dotted names
to refer to alias or actual names that are declared in blocks.

The check for a reserved word being used is not needed because that
check will be done for both the alias and the actual name when they
are declared.

Remove the call to cil_verify_name() and allow dotted names in
aliasactual rules.

Reported-by: Dominick Grift <dominick.grift@defensec.nl>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 56dac891..6884f12c 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -3174,16 +3174,6 @@ int cil_gen_aliasactual(struct cil_db *db, struct cil_tree_node *parse_current,
 		goto exit;
 	}
 
-	rc = cil_verify_name(db, parse_current->next->data, flavor);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
-	rc = cil_verify_name(db, parse_current->next->next->data, flavor);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
 	cil_aliasactual_init(&aliasactual);
 
 	aliasactual->alias_str = parse_current->next->data;
-- 
2.46.0

