Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25890C43334
	for <selinux@archiver.kernel.org>; Tue, 19 Jul 2022 15:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiGSPbF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiGSPbD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jul 2022 11:31:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4CD5885F
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x91so20137434ede.1
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpdIq7KJay1vnNNeqJAQUK4VClf+H7aQKoY5lfY+WZU=;
        b=oVMnEV6dxY5/pwQqUEdzbu9L8THe073HvDBoHIhawRVIyJNlL0WXe8IekiIfhcHfCb
         WocD0/NhyKHoKFFz/B/D4+dh+6wrx3zDmxWYT8cTRV5H4M3qxKj3vTB8JhhXQbyMq5yT
         RxMvNIo6YFWJkORk4En54nxmkbGoW3tHt6Hd3Uyy2pFBf1OiFy/39kEprMxJi2o4Ye1x
         niETAZgXO4e0DVEvDkmSs5ZUVKuhIFOrnfwo847K7T+Ct/+c/Wh70KMG1sq795s160lk
         khcaE9UZEsnpOXeaclRLYNNgifbYlRYgEceTalWdF8OTet8eGQUheEnZEksOUqB4d3Yp
         Oxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpdIq7KJay1vnNNeqJAQUK4VClf+H7aQKoY5lfY+WZU=;
        b=yaa3HKtZ0Weth80ZyT6zrFBZseSnYeKYA/GNYGtps/gkADHNjuF2NyratlqkMcVtQb
         GRtivg0iOJF88ARbPdvUonbMSVd8BnB8+WTYAb4FO+urPIO6CGARUZCglX9dTRF52Dw5
         e/IpTt/Y2TKx1ANVcm4+8+HK5TfgG4pIqxq2JtYU7nrua3Z83vEadbXZ14G5LtieM2b3
         tSAyaB7MiX+d/2px8nmXwoLEpopRECVpJo7KcXvm8Tw/t67MyedhFRNXfWpN5/vTdd2Q
         7r08w/QpwZPInM4+qIUfYvSuyXbrWXBeHHKaL3YnV83SukLI4j7kTEE+wHm6VPQvEZnz
         L68A==
X-Gm-Message-State: AJIora9Uk2x7NcSHbrtpgvnjCLqqmFkSa92N47BRbccFAC0kwK7BzCQT
        bOGWY+C8IJ2t7zJzO8qVQxYS2n4YU/SX/Q==
X-Google-Smtp-Source: AGRyM1vG2ZoenCEh5YxOmyzga93Td9ej7h1+xDV11HBanlogPLcmRXqFQasxrXgkVOLZBX+3rYzbUA==
X-Received: by 2002:a05:6402:3707:b0:437:61f9:57a9 with SMTP id ek7-20020a056402370700b0043761f957a9mr34495397edb.1.1658244658997;
        Tue, 19 Jul 2022 08:30:58 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-077-001-147-221.77.1.pool.telefonica.de. [77.1.147.221])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906311b00b0072b7b317aadsm6809621ejx.150.2022.07.19.08.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:30:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 1/7] libsepol/tests: add ebitmap tests
Date:   Tue, 19 Jul 2022 17:30:38 +0200
Message-Id: <20220719153045.70041-1-cgzones@googlemail.com>
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
v2:
  - add more tests for multi node ebitmaps and for bits set at node
    bounds
  - test ebitmap_for_each_bit()
---
 libsepol/tests/libsepol-tests.c |    2 +
 libsepol/tests/test-ebitmap.c   | 1048 +++++++++++++++++++++++++++++++
 libsepol/tests/test-ebitmap.h   |   10 +
 3 files changed, 1060 insertions(+)
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
index 00000000..fad5bd75
--- /dev/null
+++ b/libsepol/tests/test-ebitmap.c
@@ -0,0 +1,1048 @@
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
+	/* verify idempotence */
+	ebitmap_init(&e);
+	ebitmap_init(&e);
+	ebitmap_init(&e);
+
+	CU_ASSERT(ebitmap_is_empty(&e));
+	CU_ASSERT_PTR_NULL(ebitmap_startnode(&e));
+
+	/* verify idempotence */
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
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 10, 1), 0);
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 63, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 63, 1), 0);
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 64, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 64, 1), 0);
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1022, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1022, 1), 0);
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1023, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1023, 1), 0);
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1024, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1024, 1), 0);
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1025, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1025, 1), 0);
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 255, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 255, 1), 0);
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 256, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 256, 1), 0);
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 639, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 639, 1), 0);
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 640, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 640, 1), 0);
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 900, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 900, 1), 0);
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
+
+	ebitmap_destroy(&e2);
+
+	CU_ASSERT_FALSE(ebitmap_cmp(&e1, &e2));
+
+	ebitmap_destroy(&e1);
+
+	CU_ASSERT(ebitmap_cmp(&e1, &e2));
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
+	CU_ASSERT(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 0);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 0);
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
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1023, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 4);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1023), 1);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1024, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 5);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1024);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1024), 1);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1050, 1), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 6);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1050);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1050), 1);
+
+	{
+		ebitmap_node_t *n;
+		unsigned int bit, count;
+
+		/* iterate all allocated bits */
+		count = 0;
+		ebitmap_for_each_bit(&e, n, bit) {
+			CU_ASSERT(                bit <   64  ||
+			          (64   <= bit && bit <  128) ||
+			          (960  <= bit && bit < 1024) ||
+			          (1024 <= bit && bit < 1088));
+			count++;
+		}
+		CU_ASSERT_EQUAL(count, 4 * 64);
+
+		count = 0;
+		ebitmap_for_each_positive_bit(&e, n, bit) {
+			CU_ASSERT(bit == 10 ||
+			          bit == 50 ||
+			          bit == 100 ||
+			          bit == 1023 ||
+			          bit == 1024 ||
+			          bit == 1050);
+			CU_ASSERT_EQUAL(ebitmap_get_bit(&e, bit), 1);
+			count++;
+		}
+		CU_ASSERT_EQUAL(count, 6);
+	}
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1024, 0), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 5);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1050);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1024), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1050, 0), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 4);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1050), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 100, 0), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 3);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 100), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 10, 0), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 2);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 10), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 50, 0), 0);
+	CU_ASSERT_FALSE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 1);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 1023);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 50), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e, 1023, 0), 0);
+	CU_ASSERT_TRUE(ebitmap_is_empty(&e));
+	CU_ASSERT_EQUAL(ebitmap_cardinality(&e), 0);
+	CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&e), 0);
+	CU_ASSERT_EQUAL(ebitmap_get_bit(&e, 1023), 0);
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
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 318, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 319, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 383, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 384, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 449, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 430, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
+
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 318, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 319, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 383, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 384, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
+	CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 449, 1), 0);
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
+	{
+		ebitmap_t e1, e2, e12, e3, e4;
+
+		ebitmap_init(&e1);
+		ebitmap_init(&e2);
+		ebitmap_init(&e12);
+		ebitmap_init(&e3);
+		ebitmap_init(&e4);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 318, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 319, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 383, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 384, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 449, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 319, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 101, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 319, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 318, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 319, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 383, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 384, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 449, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e1), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e1));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_and(&dst, &e2, &e2), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e2));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e2), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e12));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_and(&dst, &e3, &e3), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e3));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_and(&dst, &e1, &e3), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e1));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_and(&dst, &e2, &e3), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e2));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_and(&dst, &e4, &e4), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_and(&dst, &e3, &e4), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+			ebitmap_destroy(&dst);
+		}
+
+		ebitmap_destroy(&e4);
+		ebitmap_destroy(&e3);
+		ebitmap_destroy(&e12);
+		ebitmap_destroy(&e2);
+		ebitmap_destroy(&e1);
+	}
+
+	{
+		ebitmap_t e5;
+		ebitmap_t e6;
+		ebitmap_t e56;
+		ebitmap_t dst;
+
+		ebitmap_init(&e5);
+		ebitmap_init(&e6);
+		ebitmap_init(&e56);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 63, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 191, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 192, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 318, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 319, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 64, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 192, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 319, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 320, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 192, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 319, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_and(&dst, &e5, &e6), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e56));
+
+		ebitmap_destroy(&dst);
+		ebitmap_destroy(&e56);
+		ebitmap_destroy(&e6);
+		ebitmap_destroy(&e5);
+	}
+}
+
+static void test_ebitmap_xor(void)
+{
+	{
+		ebitmap_t e1, e2, e3, e4;
+
+		ebitmap_init(&e1);
+		ebitmap_init(&e2);
+		ebitmap_init(&e3);
+		ebitmap_init(&e4);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 5, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 1, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 3, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 6, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 9, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 3, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 5, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 6, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 9, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
+
+		{
+			ebitmap_t dst1, dst2;
+
+			CU_ASSERT_EQUAL(ebitmap_xor(&dst1, &e1, &e1), 0);
+			CU_ASSERT(ebitmap_cmp(&dst1, &e4));
+			CU_ASSERT_EQUAL(ebitmap_xor(&dst2, &dst1, &e1), 0);
+			CU_ASSERT(ebitmap_cmp(&dst2, &e1));
+
+			ebitmap_destroy(&dst2);
+			ebitmap_destroy(&dst1);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e2, &e2), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e3, &e3), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e4, &e4), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e1, &e2), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e3));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e2, &e4), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e2));
+
+			ebitmap_destroy(&dst);
+		}
+
+		ebitmap_destroy(&e4);
+		ebitmap_destroy(&e3);
+		ebitmap_destroy(&e2);
+		ebitmap_destroy(&e1);
+	}
+
+	{
+		ebitmap_t e5;
+		ebitmap_t e6;
+		ebitmap_t e56;
+		ebitmap_t dst;
+
+		ebitmap_init(&e5);
+		ebitmap_init(&e6);
+		ebitmap_init(&e56);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 63, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 191, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 192, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 318, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 319, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 64, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 192, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 319, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 320, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 63, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 64, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 191, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 318, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 320, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_xor(&dst, &e5, &e6), 0);
+		CU_ASSERT(ebitmap_cmp(&dst, &e56));
+
+		ebitmap_destroy(&dst);
+		ebitmap_destroy(&e56);
+		ebitmap_destroy(&e6);
+		ebitmap_destroy(&e5);
+	}
+}
+
+static void test_ebitmap_not(void)
+{
+	{
+		ebitmap_t e1, e2, e3, e4;
+
+		ebitmap_init(&e1);
+		ebitmap_init(&e2);
+		ebitmap_init(&e3);
+		ebitmap_init(&e4);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 0, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 5, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 2, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 3, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 4, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 6, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 7, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 8, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 9, 1), 0);
+
+		{
+			ebitmap_t dst1, dst2;
+
+			CU_ASSERT_EQUAL(ebitmap_not(&dst1, &e3, 10), 0);
+			CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst1), 9);
+			CU_ASSERT_EQUAL(ebitmap_cardinality(&dst1), 10);
+
+			CU_ASSERT_EQUAL(ebitmap_not(&dst2, &dst1, 10), 0);
+			CU_ASSERT(ebitmap_cmp(&dst2, &e3));
+
+			ebitmap_destroy(&dst2);
+			ebitmap_destroy(&dst1);
+		}
+
+		{
+			ebitmap_t dst1, dst2;
+
+			CU_ASSERT_EQUAL(ebitmap_not(&dst1, &e1, 11), 0);
+			CU_ASSERT(ebitmap_cmp(&dst1, &e2));
+			CU_ASSERT_EQUAL(ebitmap_not(&dst2, &dst1, 11), 0);
+			CU_ASSERT(ebitmap_cmp(&dst2, &e1));
+
+			ebitmap_destroy(&dst2);
+			ebitmap_destroy(&dst1);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_not(&dst, &e1, 8), 0);
+			CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst), 7);
+			CU_ASSERT_EQUAL(ebitmap_cardinality(&dst), 5);
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_not(&dst, &e1, 12), 0);
+			CU_ASSERT_EQUAL(ebitmap_highest_set_bit(&dst), 11);
+			CU_ASSERT_EQUAL(ebitmap_cardinality(&dst), 8);
+
+			ebitmap_destroy(&dst);
+		}
+
+		ebitmap_destroy(&e3);
+		ebitmap_destroy(&e2);
+		ebitmap_destroy(&e1);
+	}
+
+	{
+		ebitmap_t e5;
+		ebitmap_t e5not;
+		ebitmap_node_t *n;
+		unsigned int bit;
+
+		ebitmap_init(&e5);
+		ebitmap_init(&e5not);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 63, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 191, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 192, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 318, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 319, 1), 0);
+
+		for (bit = 0; bit < 317; bit++)
+			CU_ASSERT_EQUAL(ebitmap_set_bit(&e5not, bit, 1), 0);
+		ebitmap_for_each_positive_bit(&e5, n, bit)
+			CU_ASSERT_EQUAL(ebitmap_set_bit(&e5not, bit, 0), 0);
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_not(&dst, &e5, 317), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e5not));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_not(&dst, &e5, 318), 0);
+			CU_ASSERT_FALSE(ebitmap_cmp(&dst, &e5not));
+
+			CU_ASSERT_EQUAL(ebitmap_set_bit(&e5not, 317, 1), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e5not));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_not(&dst, &e5, 319), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e5not));
+
+			ebitmap_destroy(&dst);
+		}
+
+		ebitmap_destroy(&e5not);
+		ebitmap_destroy(&e5);
+	}
+}
+
+static void test_ebitmap_andnot(void)
+{
+	{
+		ebitmap_t e1, e2, e12, e3, e4;
+
+		ebitmap_init(&e1);
+		ebitmap_init(&e2);
+		ebitmap_init(&e12);
+		ebitmap_init(&e3);
+		ebitmap_init(&e4);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 10, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 100, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 101, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 430, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e1, 1013, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 11, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 101, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e2, 665, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 10, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 100, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 430, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e12, 1013, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 10, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 11, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 100, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 101, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 430, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 665, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e3, 1013, 1), 0);
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e1, 1024), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e2, &e2, 1024), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e2, 1024), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e12));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e3, &e3, 1024), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e1, &e3, 1024), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e2, &e12, 1024), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e2));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e4, &e4, 1024), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e4));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e3, &e4, 1024), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e3));
+
+			ebitmap_destroy(&dst);
+		}
+
+		ebitmap_destroy(&e4);
+		ebitmap_destroy(&e3);
+		ebitmap_destroy(&e12);
+		ebitmap_destroy(&e2);
+		ebitmap_destroy(&e1);
+	}
+
+	{
+		ebitmap_t e5;
+		ebitmap_t e6;
+		ebitmap_t e56;
+
+		ebitmap_init(&e5);
+		ebitmap_init(&e6);
+		ebitmap_init(&e56);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 63, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 191, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 192, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 318, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e5, 319, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 64, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 192, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 319, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e6, 320, 1), 0);
+
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 63, 1), 0);
+		CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 191, 1), 0);
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e5, &e6, 317), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e56));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e5, &e6, 318), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e56));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e5, &e6, 319), 0);
+			CU_ASSERT_FALSE(ebitmap_cmp(&dst, &e56));
+
+			CU_ASSERT_EQUAL(ebitmap_set_bit(&e56, 318, 1), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e56));
+
+			ebitmap_destroy(&dst);
+		}
+
+		{
+			ebitmap_t dst;
+
+			CU_ASSERT_EQUAL(ebitmap_andnot(&dst, &e5, &e6, 320), 0);
+			CU_ASSERT(ebitmap_cmp(&dst, &e56));
+
+			ebitmap_destroy(&dst);
+		}
+
+		ebitmap_destroy(&e56);
+		ebitmap_destroy(&e6);
+		ebitmap_destroy(&e5);
+	}
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

