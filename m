Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C62C43219
	for <selinux@archiver.kernel.org>; Mon, 14 Nov 2022 20:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiKNULI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiKNUKy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Nov 2022 15:10:54 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197FB1B1EA
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 12:10:53 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n20so10479199ejh.0
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 12:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=McTStY4ftkbj5eldoW2InOIwOrA58RR2T/ju5cLV/Yo=;
        b=RkbL+BVIpNeOm5ewOvR6U0HZ8J/KJJFrp5mkgEluPh0LgjoTv/uFv3lQQw2tyU4jpK
         ojO8gzn2TQntS1lN6P2o5Bo5bCfY1kb7H59dK/OBKqul5O6+shd1Eirdmt7Mg9jNtU/V
         w/dvS1H3m/aRSqGEgJqU1APwyEHqtqCdKDKLGvbt4QwvLlark8Muyyha1TAESSP0EuRM
         ihSzW/s5n0o/c3nyFmjQyTkR8BPY53bmf3yrBcRQzBt6LdNpa/ztb1iRC1FZAY8ajV+p
         4+pqOJmlyLekiEfWCyaQoUXGYOuUymw7Kqt3v30pPODftPlDRFfyNIYG7PEnyzJQqC2A
         ggCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McTStY4ftkbj5eldoW2InOIwOrA58RR2T/ju5cLV/Yo=;
        b=y5HX7e9RRYdqS6jmhTxgfuUS66aOsNdVDNZsEY5Tp8eaqZwR6iUeBjoDbeyLmiDwRD
         BL27RqCI3DeMdTHLBr3FLdlCpgbMhiqPPnbgg2XbJ2C5SRVGYq5+XLteX5dlBGpZPrG7
         UIvbUrgfVKVFLX1krOGdOa6A9KzXxKuC+AouiIxOVlWsSYFLk7n6JlYkyfBxZ8P40Z1z
         jbiJpqMukHns2rFj7EI77aghbvxwwuh2A9gQhyz06Kgy23JzZGhnsIE+t13WZ8IFktYm
         MFsmNB7m/+oS6hx2iuV7Kvni4EALne8M5ITPOyZAGuZS2Mhw1lN6IJvNDAkJWH+4UQ2O
         Dsgw==
X-Gm-Message-State: ANoB5pmb1blFvfTsejcQjgewtj+ft640BwPZcBiU4La5LnjwlZzNo3+W
        xcGPQ31shaFeMXuBypQhS/xPz87b2uI=
X-Google-Smtp-Source: AA0mqf5VbV3i2FumGVR9WJ7RFINvXP1ycdpF3kflOOlfMfuKWJN/P8Frws4EncbRQXMP+TIxW6PL5A==
X-Received: by 2002:a17:906:d8d:b0:7af:883:ec72 with SMTP id m13-20020a1709060d8d00b007af0883ec72mr3272646eji.727.1668456651574;
        Mon, 14 Nov 2022 12:10:51 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-090-138.77.3.pool.telefonica.de. [77.3.90.138])
        by smtp.gmail.com with ESMTPSA id cb13-20020a170906a44d00b007abafe43c3bsm4558377ejb.86.2022.11.14.12.10.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:10:51 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 6/6] libsemanage/tests: rename bool identifiers
Date:   Mon, 14 Nov 2022 21:10:42 +0100
Message-Id: <20221114201042.17773-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114201042.17773-1-cgzones@googlemail.com>
References: <20221114201042.17773-1-cgzones@googlemail.com>
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
2.38.1

