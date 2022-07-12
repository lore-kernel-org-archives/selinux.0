Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD49C43334
	for <selinux@archiver.kernel.org>; Tue, 12 Jul 2022 16:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiGLQJP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiGLQJI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jul 2022 12:09:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E0C2316C
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eq6so10734096edb.6
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0W9B5X+a7rqKPu7imnEnZRKOX7qiw8f6dz5BGNPo/5Q=;
        b=GZRL0In2IGOzRPKdY3TYo6wy7l/971tqvk/G8mICVvdVkiPISFaHvj+adhlc88Kkfw
         /PW1OzBuiVBBYT0Ntj+PMiBmGGNnsK3dpbe3/hVsIJPzmu/+MYEeURqUTseWsGVVfe/8
         z6qdAjh+UKQRj2wI1ym3mG5xtgryLf8ZPOVdBMPM7O2xA9it6/2JbnKJ76FuFvkQUp1V
         ZF8o73mx+c16KEQdmHhYI5dVyj/k8vKFEnBoYov/L5FCti/Si8ehUr8aNNHsU+jp76Ou
         67hzwdjOU+eftMl6OS+1qE0jSOscy593CIgvRIhjvLf9eDdW9YwuJW+vy5sk1q0+/O/n
         hOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0W9B5X+a7rqKPu7imnEnZRKOX7qiw8f6dz5BGNPo/5Q=;
        b=NMgTgiRsbxXC49YHqsAGiujDlzCwF2y0He06wm7O0TyhFB7/q3XqxNIpDCeFLQhXMw
         clWc8sxV/Ww18I1c4ack0hSz4pAEhQQkb8UYRX/Qfbg7s1bCLZzH/lrcrHcWVz+Exh0s
         1TrShaLODMLSZAy92LldoOgDOsYP5Pfu1F3giGZKOkH22v8JXmCzw+Xza6VODaos5Mwh
         L+JZRfwf351Ygw9rtGxg9P2PB3DFScq+Vl1SuO4Cnce9N2TvmE7Fu7y3nkwPndMx5I/g
         BZ97spokZqjrkpC/AaTuPqCOv5VJ1H8pjZWAE4pM8XYd8Zlrg86m98eRUwMxVwZ77RGq
         ev4w==
X-Gm-Message-State: AJIora+4l32StlWPptuAJNi8zr5gRM269nDzBprhvq2xMnsQYBTT3NAy
        DsyoAcXoCa4R6Qzu9p/+UiJLwkpMouwgnw==
X-Google-Smtp-Source: AGRyM1u1tUxZOcwZnkpPU78HlpapJOms+L/itxKFYtSk5LPVY+ExbSfiGMoVL9ZrZdcbN/KBIGHl6A==
X-Received: by 2002:a05:6402:5412:b0:435:5997:ccb5 with SMTP id ev18-20020a056402541200b004355997ccb5mr32041473edb.167.1657642144964;
        Tue, 12 Jul 2022 09:09:04 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-190-079.77.10.pool.telefonica.de. [77.10.190.79])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090653cd00b006fed85c1a8fsm3887127ejo.202.2022.07.12.09.09.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:09:04 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/7] libsepol: add ebitmap_init_range
Date:   Tue, 12 Jul 2022 18:08:53 +0200
Message-Id: <20220712160858.22677-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712160858.22677-1-cgzones@googlemail.com>
References: <20220712160858.22677-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add an initializer for ebitmaps that sets all bits in a given range to
save node traversals for each bit to set, compared to calling
ebitmap_init() followed by iterating ebitmap_set_bit().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/ebitmap.h |  1 +
 libsepol/src/ebitmap.c                    | 49 +++++++++++++++++++++++
 libsepol/tests/test-ebitmap.c             | 32 +++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 81d0c7a6..85b7ccfb 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -94,6 +94,7 @@ extern int ebitmap_contains(const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_match_any(const ebitmap_t *e1, const ebitmap_t *e2);
 extern int ebitmap_get_bit(const ebitmap_t * e, unsigned int bit);
 extern int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value);
+extern int ebitmap_init_range(ebitmap_t * e, unsigned int minbit, unsigned int maxbit);
 extern unsigned int ebitmap_highest_set_bit(const ebitmap_t * e);
 extern void ebitmap_destroy(ebitmap_t * e);
 extern int ebitmap_read(ebitmap_t * e, void *fp);
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index bd98c0f8..fb20e994 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -349,6 +349,55 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
 	return 0;
 }
 
+int ebitmap_init_range(ebitmap_t * e, unsigned int minbit, unsigned int maxbit)
+{
+	ebitmap_node_t *new, *prev = NULL;
+	uint32_t minstartbit = minbit & ~(MAPSIZE - 1);
+	uint32_t maxstartbit = maxbit & ~(MAPSIZE - 1);
+	uint32_t minhighbit = minstartbit + MAPSIZE;
+	uint32_t maxhighbit = maxstartbit + MAPSIZE;
+	uint32_t startbit;
+	MAPTYPE mask;
+
+	ebitmap_init(e);
+
+	if (minbit > maxbit)
+		return -EINVAL;
+
+	if (minhighbit == 0 || maxhighbit == 0)
+		return -EOVERFLOW;
+
+	for (startbit = minstartbit; startbit <= maxstartbit; startbit += MAPSIZE) {
+		new = malloc(sizeof(ebitmap_node_t));
+		if (!new)
+			return -ENOMEM;
+
+		new->next = NULL;
+		new->startbit = startbit;
+
+		if (startbit != minstartbit && startbit != maxstartbit)
+			new->map = ~((MAPTYPE)0);
+		else if (startbit != maxstartbit)
+			new->map = ~((MAPTYPE)0) << (minbit - startbit);
+		else if (startbit != minstartbit)
+			new->map = ~((MAPTYPE)0) >> (MAPSIZE - (maxbit - startbit + 1));
+		else {
+			mask = ~((MAPTYPE)0) >> (MAPSIZE - (maxbit - minbit + 1));
+			new->map = (mask << (minbit - startbit));
+		}
+
+		if (prev)
+			prev->next = new;
+		else
+			e->node = new;
+		prev = new;
+	}
+
+	e->highbit = maxhighbit;
+
+	return 0;
+}
+
 unsigned int ebitmap_highest_set_bit(const ebitmap_t * e)
 {
 	const ebitmap_node_t *n;
diff --git a/libsepol/tests/test-ebitmap.c b/libsepol/tests/test-ebitmap.c
index a21f18c0..1a49aa5f 100644
--- a/libsepol/tests/test-ebitmap.c
+++ b/libsepol/tests/test-ebitmap.c
@@ -135,6 +135,37 @@ static void test_ebitmap_set_and_get(void)
 	ebitmap_destroy(&e);
 }
 
+static void test_ebitmap_init_range(void)
+{
+	ebitmap_t e1, e2, e3, e4, e5, e6;
+
+	CU_ASSERT_EQUAL(ebitmap_init_range(&e1, 0, 0), 0);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e1), 0);
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e1), 1);
+
+	CU_ASSERT_EQUAL(ebitmap_init_range(&e2, 0, 5), 0);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e2), 5);
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e2), 6);
+
+	CU_ASSERT_EQUAL(ebitmap_init_range(&e3, 20, 100), 0);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e3), 100);
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e3), 81);
+
+	CU_ASSERT_EQUAL(ebitmap_init_range(&e4, 100, 400), 0);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e4), 400);
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e4), 301);
+
+	CU_ASSERT_EQUAL(ebitmap_init_range(&e5, 10, 5), -EINVAL);
+	CU_ASSERT_EQUAL(ebitmap_init_range(&e6, 0, UINT32_MAX), -EOVERFLOW);
+
+	ebitmap_destroy(&e6);
+	ebitmap_destroy(&e5);
+	ebitmap_destroy(&e4);
+	ebitmap_destroy(&e3);
+	ebitmap_destroy(&e2);
+	ebitmap_destroy(&e1);
+}
+
 static void test_ebitmap_or(void)
 {
 	ebitmap_t e1, e2, e3, e4;
@@ -701,6 +732,7 @@ int ebitmap_add_tests(CU_pSuite suite)
 	ADD_TEST(ebitmap_init_destroy);
 	ADD_TEST(ebitmap_cmp);
 	ADD_TEST(ebitmap_set_and_get);
+	ADD_TEST(ebitmap_init_range);
 	ADD_TEST(ebitmap_or);
 	ADD_TEST(ebitmap_and);
 	ADD_TEST(ebitmap_xor);
-- 
2.36.1

