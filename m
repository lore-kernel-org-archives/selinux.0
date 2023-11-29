Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8GHUKJY"
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE191F4
	for <selinux@vger.kernel.org>; Wed, 29 Nov 2023 09:42:52 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1fa21f561a1so2316703fac.3
        for <selinux@vger.kernel.org>; Wed, 29 Nov 2023 09:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701279772; x=1701884572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCWE+GHJ15s/XpYuCQYUzzT1ak0m4EvxUTeIj8QDVDY=;
        b=T8GHUKJYon4TSS05cFeMMsNokkpVQ99ABgX15Uo8TEXFkawkQskQUNQKOFaO55c5zo
         X/csMggKscN9jJzPFKQco20iMvqxgVmDe0HfcR6iqngq5ZPjqD7Nha3DDWOgPbwkohMe
         cPV8Soz4JutX7NhLocRubCdUygbA/2DyUh9wZ9LchX/WuGxYlO/Nt9fa17Opsxs7107S
         htIw2fUHk/OJqOD2MyTEjUJCEOY50uYvMEOpU5CuE0K5QHRnWgv5j56G1d9biVM9wmNz
         VAJj8WsFAfi6BTFmScdtV9v0GDxssBMIeyVLKNCsl0m+rhnRv3VcRNlod7MzJei40hIU
         IibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701279772; x=1701884572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCWE+GHJ15s/XpYuCQYUzzT1ak0m4EvxUTeIj8QDVDY=;
        b=d2rRhdoVtZnAGZdyb+Im4h+3BW13bIIq0mF4kG0EerTHmC0pofjp94PY1wEQCWfV+F
         xlbjCoa+LcWujGQ448+i5HKFtpxXfFL/Y9qQhIYCNqjy15BOS1/+LcA3iA2N8I5zp/ID
         x8lHKizzYWCzUhJnmFKyHf/Dx+RKNHh7OxQDoL4UHt7jiOMWcxGgl8PEtc2AbQmgFqqH
         dfTL9EuOzNc3LazaZiQT6Ukv0sYdqttGMatzTwcMhXRu2FCkSZmo8oSaS2GwJFzmBnTK
         LmRfG63DlnLgeR0TlyVXD32byAJSMPL50mTnsjD53QzHHgGjYN5zoDXudVymo1TFZOGt
         p8qA==
X-Gm-Message-State: AOJu0YzTTWsmiOOaSVMlhzll3OgeqPWLN3XKlmhfRJpaqNpYiYIiP4Fa
	499zUi3E2QbE/ILuDaYgzUcHZEQOBg4=
X-Google-Smtp-Source: AGHT+IFf0H+wRpf5ChR3x8dJiXUcEa3mKtxbpmiMbaT+QahK69UOElywLlPTeB3voHc+m2pqj91Mdw==
X-Received: by 2002:a05:6871:4185:b0:1fa:789a:d12c with SMTP id lc5-20020a056871418500b001fa789ad12cmr8698056oab.38.1701279771684;
        Wed, 29 Nov 2023 09:42:51 -0800 (PST)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id wa16-20020a05620a4d1000b0077891d2d12dsm5575135qkn.43.2023.11.29.09.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:42:51 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Clear AST node after destroying bad filecon rule
Date: Wed, 29 Nov 2023 12:42:46 -0500
Message-ID: <20231129174246.188157-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fb0a4ce1 (libsepol/cil: Allow paths in filecon rules to be
passed as arguments) changed when the new AST node data would be set
to point to the new filecon struct when creating a filecon rule.
This causes cil_destroy_filecon() to be called twice on the filecon
struct if there is an error when creating the filecon rule.

If there is an error when creating a filecon rule, call
cil_clear_node() after destroying the filecon struct.

Reported-by: oss-fuzz (issue 64385)
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index be260a31..56dac891 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4197,6 +4197,7 @@ int cil_gen_filecon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 exit:
 	cil_tree_log(parse_current, CIL_ERR, "Bad filecon declaration");
 	cil_destroy_filecon(filecon);
+	cil_clear_node(ast_node);
 	return rc;
 }
 
-- 
2.43.0

