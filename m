Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14091C6AB
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646393; cv=none; b=Kjd2AqwM6/n6YAj4YxGVFcPgU7OjEMF6qRnqCe8/qrHBURIqPK+QZlOOkWSSa1uRwogs9EH/VKL/tZXMLAyWXOBy1RfI0N9SMcm+YDCP5uwix8M019up0DLGpQZNHf8X3qwykEnp9QNoHIah7o5RP8bR08cjmwPfNlf657EuAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646393; c=relaxed/simple;
	bh=cn4Uyvk024NxtibRVr4efWyEBEkB87HX0nGADdUIA7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntvccQs9oHsVaIxMHsNz5oR+rJ1IfmkzwF2Gm+pAzo7eIdJZvToBRgNDpUUSd+uDZxkN375PvlMlc3Jf9a5DEIBIPPCkShTAxlcmp8gZYXZ7M5eokPQQgyDQHUGtrRMihwFQun5H9EmQx8F2PXnqgnh0No5STqrMnB65zahpHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FFUdgJtS; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FFUdgJtS"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-787ac650561so12669785a.3
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646390; x=1709251190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YVKT6CKRc8KsJbHsMGUUZvIeZDdms8RgL4xO8gKMf8=;
        b=FFUdgJtSbxbGcU4hlpZo27xeJYBRur2SNNieF5Bstw5EWek7uN8TMCRiY/eh/gQYhl
         sM7soyraOYyjUsoZ40ElRdch5GP0TS+SgLCSO2w5ClrG8C71kTCK2KLoqy7KVrFLz/8d
         0qoasPZ6t+2WxZC8sEk9v+VRFIUwi7B5TyIUjsrw7qubYKgoBvZA9LPUzi2yqMTtfMah
         wRUze0pc9kUOemdjQAM9Ja3z1BmX+1y8LkwqBUyxL03mel4/QOtzDtdYvX19lCvnHdf1
         eMjVXyIehHX8vVdqBriL5ln6dg0RUggmz+L9or1VLoMtX01SuVRjb6j35RZIr/QzluPq
         3JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646390; x=1709251190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YVKT6CKRc8KsJbHsMGUUZvIeZDdms8RgL4xO8gKMf8=;
        b=ORLav+nu030Fiuk88XY374+cpUsdB2/VgisTpGMwGH8LlswJdp6WM6uREjehDATveG
         G6psSrY6Z58j7QTRKiGGvKL84xR+O0suLUtSmxHGLXY+7nrywxS13kgS+6LI/zU+rPIx
         /sAfAgltDI4QBupFFE0DSAfJKlxqYIMtJj3ZtmZX0PyQcnUKYVJflQLQQFkQ5ooe8sR1
         Zmu8yu35ht++Eofs3YqgWeT5jccEjj9QoUFvnTtocXJes7FIyjvH71EvUvu9k9Vg+G2m
         ApTmB9zI3KALqA+VQu3PoJXk9J4PfX8LZeYyuELBKu6k62KgbMwF+cVOyQOuR/HPZ+zP
         XiiA==
X-Gm-Message-State: AOJu0YzukzG0QdVkLX8YTjkfM+5wOA7cmM2HsQsB4ou+PPu/ACenkTR8
	74muLrYBJO9vaOoiyMPIvK0p/TTMNOsbqy3eJySibaBwrtCYTEShui5E4RxS2P/xA34jO3ce5sk
	=
X-Google-Smtp-Source: AGHT+IFK2BTDXrPduR555qz0Fl7SEa8NrnKKLEun9whw2jVz5DS92oH7DAW+mI6X6bMMCi6p5zt47g==
X-Received: by 2002:a05:620a:1714:b0:787:1849:53b1 with SMTP id az20-20020a05620a171400b00787184953b1mr679247qkb.22.1708646390276;
        Thu, 22 Feb 2024 15:59:50 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id c20-20020a05620a135400b007877f9d9e11sm2564966qkl.119.2024.02.22.15.59.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:49 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 18/21] selinux: fix style issues in security/selinux/ss/sidtab.h
Date: Thu, 22 Feb 2024 18:52:36 -0500
Message-ID: <20240222235708.386652-41-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4160; i=paul@paul-moore.com; h=from:subject; bh=cn4Uyvk024NxtibRVr4efWyEBEkB87HX0nGADdUIA7M=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19/DHMsBZ2CIKXcHip9sbmIocM7YbfEvAbqev sxdMQxLW2+JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffwwAKCRDqIPLalzeJ c2esD/9qFIXv+y2lLRlPdYxuSV+4ukeKgvgrvxZYJzeaSeUdz1Duw+mV6qAnBjZFfz+lvlGcuBH DoO3pojHSqa5wbNLgYcN4uzkM9kTavNTCMk+/HRJ9lQzn8pAOnPfD86eXko/NWrfF2ucdeVoCXf +cJgnhhDGRXER+io2x/h1mrhW/yFGqia958OexNkzV55WMXoW+pddvvCOF3pGSoBM2aMo8K2Q90 ZPYsMdRRBp+sxMzt3u2qjUOD7hUKWRkiiEzf2gcBNb2/nACASu4zqNd0VbmplHtpQUh9AB3xq0N Ws9sddY5v1z1W+hhD+UJP5MmZt21useeccCqpRk/mAHhh9koF2mhQJ2bohFMqwJIo6bnR5CJNHY EB7CJ773rWIGuQztluhQoB02oAGWYhuXvuPmiQCy2o06E5ds6B4E/dhnmpKPaHxXFxvXoS53UYU esojxaAhfPexFQH8SPtlYkREa0AwcEYityFacmQ0dnaBtW5e0fv0hIQcPWB7m2JeIBUqzQhZWmV b19BwoRSZ0q8ZFKcCbypazQP1KMvrC/lg4+JyIzozDpQm2jSovE0UQuFyXvDYqCSeMtB2PiYOYa ag8OeQLbl0M9hMzOAzEmDAJTEbjfryJylATIwCdeiiB9HZ7O0ymaraL0u9gb5cif5b36CxGByww /vOq/zJgI+v8qEQ==
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
 security/selinux/ss/sidtab.h | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 22258201cd14..832c85c70d83 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -8,6 +8,7 @@
  *
  * Copyright (C) 2018 Red Hat, Inc.
  */
+
 #ifndef _SS_SIDTAB_H_
 #define _SS_SIDTAB_H_
 
@@ -29,25 +30,26 @@ struct sidtab_entry {
 
 union sidtab_entry_inner {
 	struct sidtab_node_inner *ptr_inner;
-	struct sidtab_node_leaf  *ptr_leaf;
+	struct sidtab_node_leaf *ptr_leaf;
 };
 
 /* align node size to page boundary */
 #define SIDTAB_NODE_ALLOC_SHIFT PAGE_SHIFT
-#define SIDTAB_NODE_ALLOC_SIZE  PAGE_SIZE
+#define SIDTAB_NODE_ALLOC_SIZE	PAGE_SIZE
 
-#define size_to_shift(size) ((size) == 1 ? 1 : (const_ilog2((size) - 1) + 1))
+#define size_to_shift(size) ((size) == 1 ? 1 : (const_ilog2((size)-1) + 1))
 
-#define SIDTAB_INNER_SHIFT \
-	(SIDTAB_NODE_ALLOC_SHIFT - size_to_shift(sizeof(union sidtab_entry_inner)))
+#define SIDTAB_INNER_SHIFT         \
+	(SIDTAB_NODE_ALLOC_SHIFT - \
+	 size_to_shift(sizeof(union sidtab_entry_inner)))
 #define SIDTAB_INNER_ENTRIES ((size_t)1 << SIDTAB_INNER_SHIFT)
 #define SIDTAB_LEAF_ENTRIES \
 	(SIDTAB_NODE_ALLOC_SIZE / sizeof(struct sidtab_entry))
 
 #define SIDTAB_MAX_BITS 32
-#define SIDTAB_MAX U32_MAX
+#define SIDTAB_MAX	U32_MAX
 /* ensure enough tree levels for SIDTAB_MAX entries */
-#define SIDTAB_MAX_LEVEL \
+#define SIDTAB_MAX_LEVEL                                                   \
 	DIV_ROUND_UP(SIDTAB_MAX_BITS - size_to_shift(SIDTAB_LEAF_ENTRIES), \
 		     SIDTAB_INNER_SHIFT)
 
@@ -69,7 +71,7 @@ struct sidtab_convert_params {
 	struct sidtab *target;
 };
 
-#define SIDTAB_HASH_BITS CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS
+#define SIDTAB_HASH_BITS    CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS
 #define SIDTAB_HASH_BUCKETS (1 << SIDTAB_HASH_BITS)
 
 struct sidtab {
@@ -125,8 +127,10 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params);
 
 void sidtab_cancel_convert(struct sidtab *s);
 
-void sidtab_freeze_begin(struct sidtab *s, unsigned long *flags) __acquires(&s->lock);
-void sidtab_freeze_end(struct sidtab *s, unsigned long *flags) __releases(&s->lock);
+void sidtab_freeze_begin(struct sidtab *s, unsigned long *flags)
+	__acquires(&s->lock);
+void sidtab_freeze_end(struct sidtab *s, unsigned long *flags)
+	__releases(&s->lock);
 
 int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid);
 
@@ -137,8 +141,8 @@ int sidtab_hash_stats(struct sidtab *sidtab, char *page);
 #if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
 void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
 			const char *str, u32 str_len);
-int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry,
-		       char **out, u32 *out_len);
+int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry, char **out,
+		       u32 *out_len);
 #else
 static inline void sidtab_sid2str_put(struct sidtab *s,
 				      struct sidtab_entry *entry,
@@ -146,13 +150,11 @@ static inline void sidtab_sid2str_put(struct sidtab *s,
 {
 }
 static inline int sidtab_sid2str_get(struct sidtab *s,
-				     struct sidtab_entry *entry,
-				     char **out, u32 *out_len)
+				     struct sidtab_entry *entry, char **out,
+				     u32 *out_len)
 {
 	return -ENOENT;
 }
 #endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
 
-#endif	/* _SS_SIDTAB_H_ */
-
-
+#endif /* _SS_SIDTAB_H_ */
-- 
2.43.2

