Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B24A49BD
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362126; cv=none; b=keY5XI4e/KDJz4b1K5/E1EpsFOuwN5TwV7HoC367MhJUOIk52WnVxTgBk/SEy2i+9lfptNcQfrQri4/9pEvlkPzBqRHKMfWFJ1nCpu9btco4jyHLrqUfPRGpNVq8Ww3Kz2tX/naAtSqONkPeF8HX0C8v7Zj6y/hSfYEfhHFZIEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362126; c=relaxed/simple;
	bh=Za3Pm1c9xvF9/g+4ZjqMiUwDNNG2c+WrxK33XeENKLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1skMIlgZaPxh1QYzF/+I/7jbYr3/ZIQOqnWfzBDpGOK0J53r3CwU3mk8TmDzSHExp/lYHPGBfm6MaAeMAUcqULf/PkdgtFxkR/DsHUfFkKwjOpdmdOZOV8DU+AdDa5inoIvdvGRQP6+zBL6vPQCRB6j5r2ToNBis2eIPc6mOXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2Cmf3Pe; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2Cmf3Pe"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92ed19f4d60so116815785a.0
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362123; x=1788966923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOBHURzAroS3rEr3maxAI2CZOiOoxkWCaR/nAi9sdAE=;
        b=U2Cmf3Pew5KFO8iLFL80AoviPeP9Q2+T9WN6TynbP/iZiNXGJRYG2Zj9y40J8KOcwN
         vrsTG5t1jX/pIB8LD1zT5J9pOlb+jyebGDQ+yagDk78x1hL7iyO652J5gwvD5Pw3H64y
         56p9Cu3Q4vPvp5pJCSl5Cdu7WW+/VpdMIAGEJf7g7z4IJcHUVJYzixs87DiX5dbnErit
         bBFi+YIXdI31tcBE+uADoAUsY0//i/+xO0ptdomZCrxsUe9skweTtqcpGVV1Sec/1NOP
         X+qNdhFqTIR4ouKWHwIm4SJBKoDbB1L+5gqfw4vhuoDdBiCj3mnLcP6KC+15yku/Kcxm
         1uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362123; x=1788966923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UOBHURzAroS3rEr3maxAI2CZOiOoxkWCaR/nAi9sdAE=;
        b=XKkcuQiXqa8QpDJLOEt9ElQaAFYvjXcIuLydLMbmjK4ZCsirU/fUmdi2dXbQPwUNX3
         easEurFnTTZbbk6Vw9X6wDOB5W9iendL4QwV2HwyZ+DXN9oWXq8J6xTkipkZcROklVYy
         418pA7Zg1UzLvN+MHuNZ43CkATBupquUheS4VYgDdHjhuFqyaHNOM/Zsp2QBsTH8tBQ9
         7Sa1/gOMULJ8bKN/Z3Y9qzSuIOETNOVyTwZ8uOUePfKk+Zrfl3RVVaG/J+ZjTDmC6x0a
         kVpO2Av8blOZ6QOwRTeZiMX68swDIK/fQ5FHlkuxg/KKwBbVSnEl2JpZUQn7zgMJ1yo0
         Y7AA==
X-Gm-Message-State: AFuF++lEk64lKrNiVp0Kg7EcQd0aVr7bCPJu1kfOoUL40mKgni2OGuam
	m048tekxa4k17/lqgXuTtMwo7BaL0/fJyquYm4ae+i/dO9JfcQAzz4AIF0C9kA==
X-Gm-Gg: AR+sD12+wzVcTlwIyL/O1FfJqUiBH7wP6cPIxldNQy5sH2EbKCyMnqMeiYbgxGyJ75s
	MXavO2guOyMebvzuZkPUoSF2PL/hkXSu8z7BcdWqFS18Y7l3OtyiDXHacbl+J4i6NeNXSKbAwVQ
	9O/lRdexjcLVUwp7stG5JZTTDeeB8kTB48Azb0FYMa6P/wAMjLJcLD+RTc6eZoyVe0elvc4KepC
	P4X85ZTFcpv4Q6GhEsGpWeJknnLLV2D9Xw00qAmAA0qJQhwmhxAagkV5sq0bz3NeQvo8YwDBlSG
	GjHucmgGmC2TQ/2j8O1EJzz6po1qfV/C9JwSJ2FITDqBfdJAevEBh/xxN1BqIi2VosHdIZXu9O2
	vl6LJkDkxjqLeflHu1D8NaTwkCvFBOafDwu/9jxEZx194RlBMcQE7g7gE+Aw8adyU8x6+b6FukB
	Hnzn0H3aXZOJ5DofwStaFgfxIS/OA1ADBO/O4rIg+Vm+N/i2FYhfM9bB6560+7OBfD1A0riTyBX
	TH3GGLS8OBTKLk/xyI5N+bWXbtyletX6dMTpDR2im79nSt71a0VB1gXOGJA/eM4hw==
X-Received: by 2002:a05:620a:470f:b0:92e:fed1:beba with SMTP id af79cd13be357-93965993c8dmr367600685a.3.1788362120741;
        Wed, 02 Sep 2026 08:15:20 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f17eefdsm229299885a.11.2026.09.02.08.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:15:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 5/9] libsemanage: create the writable store skeleton on first transaction
Date: Wed,  2 Sep 2026 11:14:02 -0400
Message-ID: <20260902151406.54168-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
References: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semodule calls semanage_set_create_store(1) so the writable store is
populated at connect time, but semanage does not, so a fresh system
with only a ro-store-root the first 'semanage <object> -a' fails at
the transaction-lock or the sandbox copy.

Any transaction needs the writable skeleton so create it at the top of
semanage_direct_begintrans() rather than depending on the caller.
semanage_create_store() is idempotent so semodule is unaffected.

After this the sandbox copies an empty active/ (just modules/) the
missing computed-file check in semanage_direct_commit() forces a full
rebuild, list_all()/get_cil_paths() draw the module set from the
read-only roots, and commit_sandbox() renames the freshly-created
active/ to previous/ before installing the new one.

Read-only callers that never begin a transaction still need the
read lock; that is handled separately.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index a930dac1..5646d451 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -405,6 +405,19 @@ static int semanage_direct_disconnect(semanage_handle_t *sh)
 
 static int semanage_direct_begintrans(semanage_handle_t *sh)
 {
+	/*
+	 * A caller that never calls semanage_set_create_store()
+	 * may be running against a fresh writable store that has
+	 * no active/ tree yet. Any transaction needs a writable
+	 * skeleton - <root>/<type>/, active/, active/modules/ and
+	 * the read lock - so create it here rather than failing at
+	 * the trans-lock open or the sandbox copy.
+	 * semanage_create_store() is idempotent.
+	 */
+	if (semanage_create_store(sh, 1) < 0) {
+		return -1;
+	}
+
 	if (semanage_get_trans_lock(sh) < 0) {
 		return -1;
 	}
-- 
2.55.0

