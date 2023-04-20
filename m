Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D94C77B73
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjDTPgL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjDTPgI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:36:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AA01988
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:36:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5069097bac7so1086098a12.0
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682004965; x=1684596965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ja/YyX4eH/J/H69z/28GvNm5nE7Ma9kH8qL3caDpr/0=;
        b=nuIGnDbROKRxh3Yp8qccevZ0U/8ojoS/ovu5wklD0BaxioBbogu+lqk2kcAas4z6UY
         HT7wmw/YcFLRVXcWSLRXo+4uKPK8Dt5wD8i61uzJ9/FftSGCZ0UJ73MDgEFqIGaCOZwe
         AT7bA2480/jtT9FkvVUBzj7merQAEyzG7oXcnETxSwjYvjOSqC7MmXmJytLM1Tg5eNy0
         vwxB7l8e2s+mLQGAd6YpaOHQmMGebQhPPYf9U+kVup0/rLHnkWMZUbMEFUrrh2lu3zZR
         m5XrreJIxR38z3g5+qkQ0OKelrhE8WlsoD+wh2lArZVh9dbkY2RG4dFI95vP1mL9BZfX
         3etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004965; x=1684596965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ja/YyX4eH/J/H69z/28GvNm5nE7Ma9kH8qL3caDpr/0=;
        b=T7UBTrxQHFx+yxDSgJQd5kHJ2fpNkJol+JAbvPHieJja0QFDya9Id5FuJqKRmblinb
         SPVaZ/GQLnm+VI8WX0RJtDahZ4Y34Am4Os8zNOXshxEcUgkEYNslqB/vlu8CYbM6td9z
         LWxbHgi9vIKlngO9a4c+7t92JQ/jpw3H5DwFOg6bRGK3xnu8anCFM1IM4RY8O25K3Z8p
         BaGkhpeQJuc+d3ICilvI8OU+Syy+ytx0+DRo5N9lcWn4N3t39IUSCq9+ehegYAJkOtoU
         ygK90sFScboQf+5JdWnRbh7wekECfuRdIcSwOXh5j3KVGoe1qt14UlNbRXwDWXDKLUVB
         awjA==
X-Gm-Message-State: AAQBX9eUdqYaVwCtsOXAAMvfGlZ2+Xgn/20E6+L9bPtqR2ggAOtex0LK
        Kx04hRkaZpqPPhm2Dey0BlEXqkQAYjM=
X-Google-Smtp-Source: AKy350ZHd5O4VODJ2HtfjdtiFvUYwOILVXbkisyAhGR3Mv4RGR602WnqRK2el9zO55ag47Fz6bn+gg==
X-Received: by 2002:a05:6402:6c7:b0:506:83fc:2dab with SMTP id n7-20020a05640206c700b0050683fc2dabmr2787692edy.22.1682004965490;
        Thu, 20 Apr 2023 08:36:05 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id r22-20020aa7cb96000000b0050696c2d2f6sm853013edt.88.2023.04.20.08.36.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:36:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 6/6] libsemanage/tests: rename bool identifiers
Date:   Thu, 20 Apr 2023 17:35:56 +0200
Message-Id: <20230420153556.32115-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420153556.32115-1-cgzones@googlemail.com>
References: <20230420153556.32115-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid using the identifier `bool` to improve support with future C
standards.  C23 is about to make `bool` a predefined macro (see N2654).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/tests/libsemanage-tests.c | 2 +-
 libsemanage/tests/test_bool.c         | 6 +++---
 libsemanage/tests/test_bool.h         | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/libsemanage/tests/libsemanage-tests.c b/libsemanage/tests/libsemanage-tests.c
index ee176703..1d41a03b 100644
--- a/libsemanage/tests/libsemanage-tests.c
+++ b/libsemanage/tests/libsemanage-tests.c
@@ -73,7 +73,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(semanage_store);
 	DECLARE_SUITE(semanage_utilities);
 	DECLARE_SUITE(handle);
-	DECLARE_SUITE(bool);
+	DECLARE_SUITE(boolean);
 	DECLARE_SUITE(fcontext);
 	DECLARE_SUITE(iface);
 	DECLARE_SUITE(ibendport);
diff --git a/libsemanage/tests/test_bool.c b/libsemanage/tests/test_bool.c
index 672544bb..9356a1ae 100644
--- a/libsemanage/tests/test_bool.c
+++ b/libsemanage/tests/test_bool.c
@@ -57,7 +57,7 @@ static void test_bool_list_local(void);
 
 extern semanage_handle_t *sh;
 
-int bool_test_init(void)
+int boolean_test_init(void)
 {
 	if (create_test_store() < 0) {
 		fprintf(stderr, "Could not create test store\n");
@@ -72,7 +72,7 @@ int bool_test_init(void)
 	return 0;
 }
 
-int bool_test_cleanup(void)
+int boolean_test_cleanup(void)
 {
 	if (destroy_test_store() < 0) {
 		fprintf(stderr, "Could not destroy test store\n");
@@ -82,7 +82,7 @@ int bool_test_cleanup(void)
 	return 0;
 }
 
-int bool_add_tests(CU_pSuite suite)
+int boolean_add_tests(CU_pSuite suite)
 {
 	CU_add_test(suite, "bool_key_create", test_bool_key_create);
 	CU_add_test(suite, "bool_key_extract", test_bool_key_extract);
diff --git a/libsemanage/tests/test_bool.h b/libsemanage/tests/test_bool.h
index b5b5a603..985c1f06 100644
--- a/libsemanage/tests/test_bool.h
+++ b/libsemanage/tests/test_bool.h
@@ -24,8 +24,8 @@
 #include <CUnit/Basic.h>
 #include "semanage/semanage.h"
 
-int bool_test_init(void);
-int bool_test_cleanup(void);
-int bool_add_tests(CU_pSuite suite);
+int boolean_test_init(void);
+int boolean_test_cleanup(void);
+int boolean_add_tests(CU_pSuite suite);
 
 #endif
-- 
2.40.0

