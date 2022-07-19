Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A565C43334
	for <selinux@archiver.kernel.org>; Tue, 19 Jul 2022 15:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiGSPbI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiGSPbH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jul 2022 11:31:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B345885F
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id z23so27876894eju.8
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTvYFVbriaW0Niv5/huzg4LHWamuGhBYbTQRk7sWhSM=;
        b=g6lwDuCdD4Uiae7hxBdhAyrH3J7ZTqoiNKKSVs7qIqE9UPViWYJ+7GWhrLUv7L2Yi4
         tUsxvlhafc64D4OmmDIArS1QR22OpekDBfYbPLpugObbq1cbFrOFpYFiTT69+nz+1cdz
         4CM6guDop8Q/iyGWAyZlD2OpqWX+EFaB/G/D3rptHdPdc29j77KjsOV2BvwuSnrTBGmU
         ijSb87u4xKggNUpWpw+8F1anwb1ndV1nb3bMbp4jr7kCOfryjpNfjE+Jx9C6CayyjGhn
         xjwkeCE0A7OVy+hwGG3ssYCEvoy04gdV252JbUsMMgBPHJ+gq1ne2GuE0Zfpl8IOfK35
         tAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTvYFVbriaW0Niv5/huzg4LHWamuGhBYbTQRk7sWhSM=;
        b=FtjvGCvyr43C4Q6bheL2aACnxIjuwEXbxwgabzsQQUH+8ccmzKxKNeyWRcf0gp49U4
         1rnH6rBOQDdTF1+waKL6owkeUy06pgMxElsM1HaXANnOPnimIgBal+gTng5Yl/OoBck3
         K0/5w2p5V1Ovk2Bqqtle2/h9NDvnVTQa01cSL8VO74Q4aMqhCjKzwSw0WNmqr+nmR7Ac
         zu+MO0rxKtfHSduinG6nTQbjmLDXG3ky9YIgpi1LlF1JnUWrfK4KTmhdq9amllA+L+fx
         Gthn43ftiKlkubjMvqJQf8sbgWTMOIlXCMeYCXIhs4HDf427UweH55ZRgJIKfftQv+A3
         IB8A==
X-Gm-Message-State: AJIora903oCSulcvn1ZD5Lh967UBiGlI/sQV0w0BxOwmh+Hl9N5dzePG
        1iGwSXO8Teg0Ki4t+xlkfEXKINIz5Jst7w==
X-Google-Smtp-Source: AGRyM1vsRHJZCC442wTcuV+2vhB1WnQFsbteBee0M6A5vioeJ9u/QiZq1DPspEGCNn2qh9h0QnGy4A==
X-Received: by 2002:a17:907:2bc6:b0:72e:ceea:862b with SMTP id gv6-20020a1709072bc600b0072eceea862bmr28618919ejc.134.1658244663262;
        Tue, 19 Jul 2022 08:31:03 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-077-001-147-221.77.1.pool.telefonica.de. [77.1.147.221])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906311b00b0072b7b317aadsm6809621ejx.150.2022.07.19.08.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:31:02 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 2/7] libsepol: add ebitmap_init_range
Date:   Tue, 19 Jul 2022 17:30:39 +0200
Message-Id: <20220719153045.70041-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220719153045.70041-1-cgzones@googlemail.com>
References: <20220719153045.70041-1-cgzones@googlemail.com>
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
v2:
  use braces for all if-else branches when used for at least one of them
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
index bd98c0f8..0f9afd62 100644
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
+		if (startbit != minstartbit && startbit != maxstartbit) {
+			new->map = ~((MAPTYPE)0);
+		} else if (startbit != maxstartbit) {
+			new->map = ~((MAPTYPE)0) << (minbit - startbit);
+		} else if (startbit != minstartbit) {
+			new->map = ~((MAPTYPE)0) >> (MAPSIZE - (maxbit - startbit + 1));
+		} else {
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
index fad5bd75..8774555e 100644
--- a/libsepol/tests/test-ebitmap.c
+++ b/libsepol/tests/test-ebitmap.c
@@ -253,6 +253,37 @@ static void test_ebitmap_set_and_get(void)
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
@@ -1038,6 +1069,7 @@ int ebitmap_add_tests(CU_pSuite suite)
 	ADD_TEST(ebitmap_init_destroy);
 	ADD_TEST(ebitmap_cmp);
 	ADD_TEST(ebitmap_set_and_get);
+	ADD_TEST(ebitmap_init_range);
 	ADD_TEST(ebitmap_or);
 	ADD_TEST(ebitmap_and);
 	ADD_TEST(ebitmap_xor);
-- 
2.36.1

