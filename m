Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74A3D0D0
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931721; cv=none; b=tjUCLBn/K4EvdjFd27DJMLxGUVD8csgIUwJf8cfWiTRKdOcUiZzuGykXTzvgJy4ra3m3YVhqli+7nFGeISOA2K/mUq8M08ur/iBcCC7484xrcdOENrG3FOuyRYe7ou4VggGzcppaO3rARy21Z24ipPs9FAmtDCpA+5yQk2PWIzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931721; c=relaxed/simple;
	bh=xaMPf4yjfuPUTL2FKWuE34UzsBs5M40hZxCu2eAZmns=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5Cj5TCpI1D3+1utuHsBLgOUPDUbs3cXc+BAXZjXOwRU7ygxkNFk1S5ox3/YTMqnNwNnk63am5vpXBk7u4cvI45vEsKrVrndVproNh+rmIOXh0nyOFmZRsEB1UQS4kQR/yKbjxOxEolunFBfxeWzaxQ3AMFvPkYw9X6Op4OgR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZK/4LjSn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZK/4LjSn"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2cea0563cbso476181366b.3
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931718; x=1706536518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gtpdxkm0LQhEWxmv59dgMhIwdQkqX63ar6GQrbQC7Xk=;
        b=ZK/4LjSnBWzSwo3HRwnJgWkMfEczbrRO5LEUrpiTckC8KraZNX1rRlvKRyb9QPb/a5
         IHneK9q0n3PwwELEx8wQ22C2rf9oleimuweadBoaYtEWZiqj6mFGgIjGHUnWl/wExeOa
         YDfFu6K+k7DP7teS2FAlhN0rImZl09IQNkYrkLp6eDJv+jQoX4eM0uXoblQsvAIErxnW
         BK10y4J+y9CfV61ptGnQCg7WbRNov6pQDA/IZPO5I4tE+Bw0oRNNU1ISV6IPw+yNKYXO
         2ToKSmml4EqXkZd34WUnVWlWJRVwdJu4Jc1U0qy7KUB/pfYeKTsOaRNFt0fYkMqgufJv
         a45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931718; x=1706536518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gtpdxkm0LQhEWxmv59dgMhIwdQkqX63ar6GQrbQC7Xk=;
        b=sLSmfw4NP50kVvgqslUyqfhxW0e/zFfoxnt8fQjtR0RdJL4QFxUs73/1CFSo05SZ0a
         ajF7Df2aBlnkfCIBhMaS3FK0+9Mnx1gFhP8PC4MFqD96/JNLElz8nKnxLWpdzrHTDRvZ
         L24w8Njf9Ij+aPC12gMzrpgX9m3gES42ui59fe8nQrKwAbK9T+/kjuMjA5HbPdPzn2+A
         tu7jGadTXKbLwtnXFFGZVWu4LGy+QjLMb2wsVHNespe978chXhXyhn2+g5EiD2C1yyPz
         d2xIUAX7g71nljIXyfw4UiVsoxsP6PU5Tg05+/1jxAMXkYnGLGXAfItvtxn5RY0m6CUF
         IZzQ==
X-Gm-Message-State: AOJu0YzvoODMBTAtSghfTgSWsxdQAQO2oapHZsFZjp9XUrX0czShWvTu
	cIYStHNA1LZ9Ptf2XcA2EorWJaHb1gTFOSbbXqYK8WfG56HktFC65sB2PePV
X-Google-Smtp-Source: AGHT+IFBqZt+zMFzBUM1B/b5ADBTeq8wl7DHY76MNa+CcVOsHO9aXcw4/lLL85dxaBPti0XgxvS2cw==
X-Received: by 2002:a17:907:8743:b0:a28:fb5a:4d9c with SMTP id qo3-20020a170907874300b00a28fb5a4d9cmr2199608ejc.108.1705931718427;
        Mon, 22 Jan 2024 05:55:18 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:18 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 09/15] libsepol: use typedef
Date: Mon, 22 Jan 2024 14:55:01 +0100
Message-ID: <20240122135507.63506-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the only usage of the raw type struct level_datum to use the
typedef.  Simplifies refactorizations on the type.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/module_to_cil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ee22dbbd..417c5307 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2390,7 +2390,7 @@ static int boolean_to_cil(int indent, struct policydb *UNUSED(pdb), struct avrul
 
 static int sens_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct stack *UNUSED(decl_stack), char *key, void *datum, int scope)
 {
-	struct level_datum *level = datum;
+	level_datum_t *level = datum;
 
 	if (scope == SCOPE_DECL) {
 		if (!level->isalias) {
-- 
2.43.0

