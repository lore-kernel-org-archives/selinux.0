Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF0413BAF8
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646395; cv=none; b=VAES+7SyUFtLxmjWa+AGWeXUCQwaNtXeJLN0nZZ9JXN1iJ5+TQrKIrcc84i3s8I4oIgDIfJiaG9cTGngW+x3fwhohPkvmmMm1x0661ZEIR4er/6UvEbRfXOaK3xtERS41Xc67mzJn/bScVqj2IM/9JLcLOTAouGSp22ZFC1cWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646395; c=relaxed/simple;
	bh=sItb/ePRu45VJMGJcNCchsgSQkrwNAcUqNWJZaT9f9w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=staxu3DDHxaCiFdaPOduxsqYdwArgm2CJ0irLIZrauprVxQVY4p/0FEuOTpZXkoiUK1Xk7NvSC0KllGXsnrbKq7iFA7p3XnjxrxtnzL8jm9cyyRd/nlHG3sEBhxKVClrSLyIwUNDDfxxA+nkV7kU9KQVnH5/UDHSLH6YIKnnyZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SW6nNLGR; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SW6nNLGR"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68fcb96fbc9so2014716d6.2
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646392; x=1709251192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDT4N0sZ6Pfgwi8jZAiZ8Ln93adVZzC/jA4W4IZORlo=;
        b=SW6nNLGRra+5nfCBIm9EajvCg8D28H22CPzhaIGVw3+J6qz3Ax3yggVgI0fub8q9wh
         iNJLXq5E8xcPW8E8IsDFoyTxidTvXtCi8phoyKA5+tKlq0r+lEQ6SmUwdoNvKRhlPOsZ
         NsslJKn5IJ3NwaBuqdz75wktPmobsSbYbWXpgI26foSzsv+mMwZjEX5OS3kkYexWOxxY
         i44r85UGzuc7F57MGPxw4Ndkou+l0Q0kaG7REswYkG/SIMPHgJo3Hgc9J05hZPmXq4HB
         aaf+q7IgvS+V8cr6btObiJgvCfRzkiQSAfwBfWDhnprOlDWvC5u1W3PdnL3zM+8IJDEa
         m7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646392; x=1709251192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDT4N0sZ6Pfgwi8jZAiZ8Ln93adVZzC/jA4W4IZORlo=;
        b=nmWup2oZ85qk8i0ftLYzvQm4H3wOEjoCSeV8qIsjLMcU7OV5zk1sKbSz8Oga7ZR4WP
         C56FdWiS08tgyKUx/BYrffinUEpfyOfUl7UdRz4An17NGVd8EyCu7uGlJTEQkKdT4VAE
         qHTEQv0K38QxERTvRDAkH1KGVntGGOevkPsHUmDiW5N53+QDYMs0x5/jusVJYXWXr9Yi
         P87/TspbgICUhDb3FwkXe5W5rx9M0O8b0+5AGtFP89PtWjGOjq6y9uMEvGfvI1gedTi7
         vgPXxVfztKn+rskukC3l+tH7ZC/kpH4h/p9b4qFVnam0A37FEgbHgRtgjSmn7nCueKVX
         8z9A==
X-Gm-Message-State: AOJu0Yzq4FFv/76yP0YfWqfoFa1U/NVYQOymZ/DknliL6hvU3iGliMAs
	khDxzhIrNV+zPDkMIhbKTGgMPRiTo5M/TkA3nyxRsKu8SQeXa+syClifEjqMqh9CNrQqYnzrEBU
	=
X-Google-Smtp-Source: AGHT+IFggUeauGLz8sFZ4HcTQLz3T0nbgf9WrEAEA6zmQWZB7+d57QPXdU5JrrM0qEKuB502Ca50lA==
X-Received: by 2002:a05:6214:5005:b0:68f:6f85:b1d5 with SMTP id jo5-20020a056214500500b0068f6f85b1d5mr942900qvb.9.1708646392084;
        Thu, 22 Feb 2024 15:59:52 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ma7-20020a0562145b0700b0068f73372424sm5197887qvb.90.2024.02.22.15.59.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:51 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 20/21] selinux: fix style issues in security/selinux/ss/symtab.h
Date: Thu, 22 Feb 2024 18:52:38 -0500
Message-ID: <20240222235708.386652-43-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=paul@paul-moore.com; h=from:subject; bh=sItb/ePRu45VJMGJcNCchsgSQkrwNAcUqNWJZaT9f9w=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19/QEPjNBn1WeGliPgYDrrrzXecIxxYx4Zjlg f/xrt7JieqJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdff0AAKCRDqIPLalzeJ cwvlD/0dhoPIdzI5os57Sh3VlkGQMkrwQDFhOawbihFAuhezapBL7NUNrfr1pVDQ4PCksRPvwLY 8D9y13LILmou2WdHINpJsiFaqV7xlvep8nIWH/xDFMx19mpN9kh+vi7M3TQUecjI3oBVYJKK0Kn gOWRo6STXEoMGV7HkYuBCpjYP9KbpJA1CahiFDC9fVEzIh+zWGFOkH7a9fXgwLLrHe+M6GVxN/e DBf0S/f/2bLJu98IoABtjJ85YKf0hY16Ic43MFxhrrT/kxM3HfHWP+oNrUrY2/bemlCpIEGJ4Ni s2+PuXOwy+Yhc0N4Eb/USUZJ0k0zQ2dxfUxsXpDD7PB/2cxW/X4N/iYNR7LyqHpDtCz6cLWgRrl MAtZKHoH9oR8/yt+vd/6vSyLiF9INWlM1RkM8sHjWcKU/APx1c7RROqfCl2fUBDX9kuOiav4JXS NB9xaKOAz1h9eLclwDWR+LlfLXFUtL+ti6OPJoLe6bMxLpWC4NA6gow3/HeDzE9+GrpC8fX7rAM uErT1XO0/DGXleVUywv35Frx9a3DgLbWQy6haog/3X832sTLodEjh8TFG6Hj/JTy+jII4Rql6BM Y/jcGiZEtf3pka/4ynlJLsa9hOkYNfOGY2MtXwdkOMPU0llx4GvQVn2hmeQTWuaglBEJLJlEA4B 25ml2eHdu0HhY+Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/symtab.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/symtab.h b/security/selinux/ss/symtab.h
index 0a3b5de79a0f..8e667cdbf38f 100644
--- a/security/selinux/ss/symtab.h
+++ b/security/selinux/ss/symtab.h
@@ -7,14 +7,15 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 #ifndef _SS_SYMTAB_H_
 #define _SS_SYMTAB_H_
 
 #include "hashtab.h"
 
 struct symtab {
-	struct hashtab table;	/* hash table (keyed on a string) */
-	u32 nprim;		/* number of primary names in table */
+	struct hashtab table; /* hash table (keyed on a string) */
+	u32 nprim; /* number of primary names in table */
 };
 
 int symtab_init(struct symtab *s, u32 size);
@@ -22,6 +23,4 @@ int symtab_init(struct symtab *s, u32 size);
 int symtab_insert(struct symtab *s, char *name, void *datum);
 void *symtab_search(struct symtab *s, const char *name);
 
-#endif	/* _SS_SYMTAB_H_ */
-
-
+#endif /* _SS_SYMTAB_H_ */
-- 
2.43.2

