Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9E4CCA47F
	for <selinux@archiver.kernel.org>; Tue, 12 Jul 2022 16:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiGLQJQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiGLQJJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jul 2022 12:09:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C83613DE9
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dn9so15149498ejc.7
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Th9symoIAedk8n4yZ9NYso7peFhQUZDzMX3JzdaOdRI=;
        b=B3xjxDDQTwmpV3BLQ/ADMMGPiqE7buqDD1gjEkLrAMMroPrCkglm2jq/SbVOA+Gt24
         lZFOwq2DRDc0QUhXWdHuJ+F4wz6SJJ4qnVOrm8fRsQjtBbul0j0BNWq0Hvu+VUh+vKDK
         Rf8ls+Vu15G3SRXihgwRLqPnJ0daWWWrVEY/tlAysiWziLxaL9BH688PkSQqcfSEh+iD
         8eOa2H/BTUTzq9gCKYBdr3T1U8V718Qiy1zIfnEojiHh8wbAF2W5tb8RWoBJJ49jvuxn
         BgUQbGxvPu9Ty3Yqiv8V6BJtyv8Lt9mqEdMjIPPMvBdc8kw+3EE9svOaO8uKwimJt7Xq
         LFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Th9symoIAedk8n4yZ9NYso7peFhQUZDzMX3JzdaOdRI=;
        b=3efR1/pFoid4RIljT3PF0OMnv90OJwLsrbfhR58EqqlYTqIqUmX88ZZBkUZGf3Xsot
         J7ML1qYXAecdfjfelnH1hnhDxwnOn4OdPC4yfFUUHT7BlgabS78EsVXxOA37RIwJZEis
         x6Ak5BfsP5Js77TmIFvr6xAFmhGEcMT7fiASWPiTqoqWOmgwB7mtuKmdzFt3wJnqZLZF
         4a7ianBwGm6VJl1M25HjYOLG4P75tpcekyl9RqcwyaZP9AOSDDpWUAG0+FrsvjF9050n
         huiQEn9gOn68b1Sv1S9woKJWCEXJdVpVnG2JhzYt05fk99zOIXYqcBp280WRDiLv8Ffz
         Arhw==
X-Gm-Message-State: AJIora9GbFyhEHt+c4MuzL9Cz7SQBU5RVMlxU9W9E6+D28WjOZGD+ofj
        Q+Bn1VAd534tpx6ntRfTZiKUR6iZyYuKCA==
X-Google-Smtp-Source: AGRyM1sRFItr5K97WutZ4+jC3B/HZWY5O673r84eJzLkSRDK2hVFV6aCcf+A5MhGwBjL07PkeH4iZw==
X-Received: by 2002:a17:907:2cca:b0:72b:4188:f95b with SMTP id hg10-20020a1709072cca00b0072b4188f95bmr16625717ejc.153.1657642144330;
        Tue, 12 Jul 2022 09:09:04 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-190-079.77.10.pool.telefonica.de. [77.10.190.79])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090653cd00b006fed85c1a8fsm3887127ejo.202.2022.07.12.09.09.03
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:09:03 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/7] libsepol/tests: add ebitmap tests
Date:   Tue, 12 Jul 2022 18:08:52 +0200
Message-Id: <20220712160858.22677-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Preparation for several ebitmap related optimizations.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/tests/libsepol-tests.c |   2 +
 libsepol/tests/test-ebitmap.c   | 711 ++++++++++++++++++++++++++++++++
 libsepol/tests/test-ebitmap.h   |  10 +
 3 files changed, 723 insertions(+)
 create mode 100644 libsepol/tests/test-ebitmap.c
 create mode 100644 libsepol/tests/test-ebitmap.h

diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index dc8fd5ce..5ae6bedc 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -19,6 +19,7 @@
  */
 
 #include "test-cond.h"
+#include "test-ebitmap.h"
 #include "test-linker.h"
 #include "test-expander.h"
 #include "test-deps.h"
@@ -64,6 +65,7 @@ static bool do_tests(int interactive, int verbose)
 	if (CUE_SUCCESS != CU_initialize_registry())
 		return CU_get_error();
 
+	DECLARE_SUITE(ebitmap);
 	DECLARE_SUITE(cond);
 	DECLARE_SUITE(linker);
 	DECLARE_SUITE(expander);
diff --git a/libsepol/tests/test-ebitmap.c b/libsepol/tests/test-ebitmap.c
new file mode 100644
index 00000000..a21f18c0
--- /dev/null
+++ b/libsepol/tests/test-ebitmap.c
@@ -0,0 +1,711 @@
+#include "test-ebitmap.h"
+
+#include <stdlib.h>
+#include <time.h>
+
+#include <sepol/debug.h>
+#include <sepol/policydb/ebitmap.h>
+
+#define RANDOM_ROUNDS 10
+
+
+static int ebitmap_init_random(ebitmap_t *e, unsigned int length, int set_chance)
+{
+	unsigned int i;
+	int rc;
+
+	if (set_chance <= 0 || set_chance > 100)
+		return -EINVAL;
+
+	ebitmap_init(e);
+
+	for (i = 0; i < length; i++) {
+		if ((random() % 100) < set_chance) {
+			rc = ebitmap_set_bit(e, i, 1);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
+static void test_ebitmap_init_destroy(void)
+{
+	ebitmap_t e;
+
+	ebitmap_init(&e);
+	ebitmap_init(&e);
+	ebitmap_init(&e);
+
+	CU_ASSERT(ebitmap_is_empty(&e));
+	CU_ASSERT_PTR_NULL(ebitmap_startnode(&e));
+
+	ebitmap_destroy(&e);
+	ebitmap_destroy(&e);
+	ebitmap_destroy(&e);
+
+	CU_ASSERT(ebitmap_is_empty(&e));
+	CU_ASSERT_PTR_NULL(ebitmap_startnode(&e));
+}
+
+static void test_ebitmap_cmp(void)
+{
+	ebitmap_t e1, e2;
+
+	ebitmap_init(&e1);
+	ebitmap_init(&e2);
+
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
+
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 10, 1), 0);
+
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	ebitmap_destroy(&e2);
+	ebitmap_destroy(&e1);
+}
+
+static void test_ebitmap_set_and_get(void)
+{
+	ebitmap_t e;
+
+	ebitmap_init(&e);
+
+	CU_ASSERT(ebitmap_is_empty(&e));
+	CU_ASSERT_TRUE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 0);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 0);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, UINT32_MAX, 1), -EINVAL);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 10, 0), 0);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 10, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 1);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 10);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 1);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 100, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 2);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 100);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 100), 1);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 50, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 3);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 100);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 50), 1);
+
+	{
+		ebitmap_node_t *n;
+		unsigned int bit;
+
+		ebitmap_for_each_positive_bit(&e, n, bit) {
+			CU_ASSERT(bit == 10 || bit == 50 || bit == 100);
+		}
+	}
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 100, 0), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 2);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 50);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 100), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 10, 0), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 1);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 50);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 50, 0), 0);
+	CU_ASSERT_TRUE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 0);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 0);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 50), 0);
+
+	ebitmap_destroy(&e);
+}
+
+static void test_ebitmap_or(void)
+{
+	ebitmap_t e1, e2, e3, e4;
+
+	ebitmap_init(&e1);
+	ebitmap_init(&e2);
+	ebitmap_init(&e3);
+	ebitmap_init(&e4);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 430, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_or(&dst, &e1, &e1), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e1));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_or(&dst, &e2, &e2), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e2));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_or(&dst, &e1, &e2), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e3));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_or(&dst, &e3, &e3), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e3));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_or(&dst, &e3, &e4), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e3));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_or(&dst, &e4, &e4), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+		ebitmap_destroy(&dst);
+	}
+
+	ebitmap_destroy(&e4);
+	ebitmap_destroy(&e3);
+	ebitmap_destroy(&e2);
+	ebitmap_destroy(&e1);
+}
+
+static void test_ebitmap_and(void)
+{
+	ebitmap_t e1, e2, e12, e3, e4;
+
+	ebitmap_init(&e1);
+	ebitmap_init(&e2);
+	ebitmap_init(&e12);
+	ebitmap_init(&e3);
+	ebitmap_init(&e4);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 430, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 101, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e1), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e1));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_and(&dst, &e2, &e2), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e2));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e2), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e12));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_and(&dst, &e3, &e3), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e3));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e3), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e1));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_and(&dst, &e2, &e3), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e2));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_and(&dst, &e4, &e4), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_and(&dst, &e3, &e4), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+		ebitmap_destroy(&dst);
+	}
+
+	ebitmap_destroy(&e4);
+	ebitmap_destroy(&e3);
+	ebitmap_destroy(&e12);
+	ebitmap_destroy(&e2);
+	ebitmap_destroy(&e1);
+}
+
+static void test_ebitmap_xor(void)
+{
+	ebitmap_t e1, e2, e3, e4;
+
+	ebitmap_init(&e1);
+	ebitmap_init(&e2);
+	ebitmap_init(&e3);
+	ebitmap_init(&e4);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 5, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 3, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 6, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 9, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 3, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 5, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 6, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 9, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
+
+	{
+		ebitmap_t dst1, dst2;
+
+		CU_ASSERT_EQUAL(ebitmap_xor(&dst1, &e1, &e1), 0);
+		CU_ASSERT(ebitmap_cmp(&dst1, &e4));
+		CU_ASSERT_EQUAL(ebitmap_xor(&dst2, &dst1, &e1), 0);
+		CU_ASSERT(ebitmap_cmp(&dst2, &e1));
+
+		ebitmap_destroy(&dst2);
+		ebitmap_destroy(&dst1);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e2, &e2), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e3, &e3), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e4, &e4), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e1, &e2), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e3));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e2, &e4), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e2));
+
+		ebitmap_destroy(&dst);
+	}
+
+	ebitmap_destroy(&e4);
+	ebitmap_destroy(&e3);
+	ebitmap_destroy(&e2);
+	ebitmap_destroy(&e1);
+}
+
+static void test_ebitmap_not(void)
+{
+	ebitmap_t e1, e2, e3, e4;
+
+	ebitmap_init(&e1);
+	ebitmap_init(&e2);
+	ebitmap_init(&e3);
+	ebitmap_init(&e4);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 0, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 5, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 2, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 3, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 4, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 6, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 7, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 8, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 9, 1), 0);
+
+	{
+		ebitmap_t dst1, dst2;
+
+		CU_ASSERT_EQUAL(ebitmap_not(&dst1, &e3, 10), 0);
+		CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst1), 9);
+		CU_ASSERT_EQUAL(ebitmap_cardinality(&dst1), 10);
+
+		CU_ASSERT_EQUAL(ebitmap_not(&dst2, &dst1, 10), 0);
+		CU_ASSERT(ebitmap_cmp(&dst2, &e3));
+
+		ebitmap_destroy(&dst2);
+		ebitmap_destroy(&dst1);
+	}
+
+	{
+		ebitmap_t dst1, dst2;
+
+		CU_ASSERT_EQUAL(ebitmap_not(&dst1, &e1, 11), 0);
+		CU_ASSERT(ebitmap_cmp(&dst1, &e2));
+		CU_ASSERT_EQUAL(ebitmap_not(&dst2, &dst1, 11), 0);
+		CU_ASSERT(ebitmap_cmp(&dst2, &e1));
+
+		ebitmap_destroy(&dst2);
+		ebitmap_destroy(&dst1);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_not(&dst, &e1, 8), 0);
+		CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst), 7);
+		CU_ASSERT_EQUAL(ebitmap_cardinality(&dst), 5);
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_not(&dst, &e1, 12), 0);
+		CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst), 11);
+		CU_ASSERT_EQUAL(ebitmap_cardinality(&dst), 8);
+
+		ebitmap_destroy(&dst);
+	}
+
+	ebitmap_destroy(&e3);
+	ebitmap_destroy(&e2);
+	ebitmap_destroy(&e1);
+}
+
+static void test_ebitmap_andnot(void)
+{
+	ebitmap_t e1, e2, e12, e3, e4;
+
+	ebitmap_init(&e1);
+	ebitmap_init(&e2);
+	ebitmap_init(&e12);
+	ebitmap_init(&e3);
+	ebitmap_init(&e4);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 430, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 10, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 100, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 430, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 1013, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e1, 1024), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e2, &e2, 1024), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e2, 1024), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e12));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e3, &e3, 1024), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e3, 1024), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e2, &e12, 1024), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e2));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e4, &e4, 1024), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+		ebitmap_destroy(&dst);
+	}
+
+	{
+		ebitmap_t dst;
+
+		CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e3, &e4, 1024), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e3));
+
+		ebitmap_destroy(&dst);
+	}
+
+	ebitmap_destroy(&e4);
+	ebitmap_destroy(&e3);
+	ebitmap_destroy(&e12);
+	ebitmap_destroy(&e2);
+	ebitmap_destroy(&e1);
+}
+
+static void test_ebitmap__random_impl(unsigned int length, int set_chance)
+{
+	ebitmap_t e1, e2, dst_cpy, dst_or, dst_and, dst_xor1, dst_xor2, dst_not1, dst_not2, dst_andnot;
+	unsigned int i;
+
+	CU_ASSERT_EQUAL(ebitmap_init_random(&e1, length, set_chance), 0);
+	CU_ASSERT_EQUAL(ebitmap_init_random(&e2, length, set_chance), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_cpy(&dst_cpy, &e1), 0);
+	CU_ASSERT(ebitmap_cmp(&dst_cpy, &e1));
+
+	CU_ASSERT_EQUAL(ebitmap_or(&dst_or, &e1, &e2), 0);
+	for (i = 0; i < length; i++)
+		CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_or, i), ebitmap_get_bit(&e1, i) | ebitmap_get_bit(&e2, i));
+
+	CU_ASSERT_EQUAL(ebitmap_and(&dst_and, &e1, &e2), 0);
+	for (i = 0; i < length; i++)
+		CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_and, i), ebitmap_get_bit(&e1, i) & ebitmap_get_bit(&e2, i));
+
+	CU_ASSERT_EQUAL(ebitmap_xor(&dst_xor1, &e1, &e2), 0);
+	for (i = 0; i < length; i++)
+		CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_xor1, i), ebitmap_get_bit(&e1, i) ^ ebitmap_get_bit(&e2, i));
+	CU_ASSERT_EQUAL(ebitmap_xor(&dst_xor2, &dst_xor1, &e2), 0);
+	CU_ASSERT(ebitmap_cmp(&dst_xor2, &e1));
+
+	CU_ASSERT_EQUAL(ebitmap_not(&dst_not1, &e1, length), 0);
+	for (i = 0; i < length; i++)
+		CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_not1, i), !ebitmap_get_bit(&e1, i));
+	CU_ASSERT_EQUAL(ebitmap_not(&dst_not2, &dst_not1, length), 0);
+	CU_ASSERT(ebitmap_cmp(&dst_not2, &e1));
+
+	CU_ASSERT_EQUAL(ebitmap_andnot(&dst_andnot, &e1, &e2, length), 0);
+	for (i = 0; i < length; i++)
+		CU_ASSERT_EQUAL(ebitmap_get_bit(&dst_andnot, i), ebitmap_get_bit(&e1, i) & !ebitmap_get_bit(&e2, i));
+
+	ebitmap_destroy(&dst_andnot);
+	ebitmap_destroy(&dst_not2);
+	ebitmap_destroy(&dst_not1);
+	ebitmap_destroy(&dst_xor2);
+	ebitmap_destroy(&dst_xor1);
+	ebitmap_destroy(&dst_and);
+	ebitmap_destroy(&dst_or);
+	ebitmap_destroy(&dst_cpy);
+	ebitmap_destroy(&e2);
+	ebitmap_destroy(&e1);
+}
+
+static void test_ebitmap__random(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < RANDOM_ROUNDS; i++)
+		test_ebitmap__random_impl(5, 10);
+
+	for (i = 0; i < RANDOM_ROUNDS; i++)
+		test_ebitmap__random_impl(5, 90);
+
+	for (i = 0; i < RANDOM_ROUNDS; i++)
+		test_ebitmap__random_impl(1024, 50);
+
+	for (i = 0; i < RANDOM_ROUNDS; i++)
+		test_ebitmap__random_impl(8000, 5);
+
+	for (i = 0; i < RANDOM_ROUNDS; i++)
+		test_ebitmap__random_impl(8000, 95);
+}
+
+/*
+ * External hooks
+ */
+
+int ebitmap_test_init(void)
+{
+	srandom(time(NULL));
+
+	/* silence ebitmap_set_bit() failure message */
+	sepol_debug(0);
+
+	return 0;
+}
+
+int ebitmap_test_cleanup(void)
+{
+	return 0;
+}
+
+#define ADD_TEST(name) \
+	do { \
+		if (NULL == CU_add_test(suite, #name, test_##name)) { \
+			return CU_get_error(); \
+		} \
+	} while (0)
+
+int ebitmap_add_tests(CU_pSuite suite)
+{
+	ADD_TEST(ebitmap_init_destroy);
+	ADD_TEST(ebitmap_cmp);
+	ADD_TEST(ebitmap_set_and_get);
+	ADD_TEST(ebitmap_or);
+	ADD_TEST(ebitmap_and);
+	ADD_TEST(ebitmap_xor);
+	ADD_TEST(ebitmap_not);
+	ADD_TEST(ebitmap_andnot);
+	ADD_TEST(ebitmap__random);
+	return 0;
+}
diff --git a/libsepol/tests/test-ebitmap.h b/libsepol/tests/test-ebitmap.h
new file mode 100644
index 00000000..952a0421
--- /dev/null
+++ b/libsepol/tests/test-ebitmap.h
@@ -0,0 +1,10 @@
+#ifndef TEST_EBITMAP_H__
+#define TEST_EBITMAP_H__
+
+#include <CUnit/Basic.h>
+
+int ebitmap_test_init(void);
+int ebitmap_test_cleanup(void);
+int ebitmap_add_tests(CU_pSuite suite);
+
+#endif  /* TEST_EBITMAP_H__ */
-- 
2.36.1

