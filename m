Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F826C31E48
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0A020684
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436784AbfFLIEt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:04:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436780AbfFLIEt (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Jun 2019 04:04:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA2ED821EF
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:49 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FFA078386
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:49 +0000 (UTC)
From:   Jan Zarsky <jzarsky@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 11/11] libsemanage: test semanage_msg_default_handler
Date:   Wed, 12 Jun 2019 10:04:04 +0200
Message-Id: <20190612080404.4529-12-jzarsky@redhat.com>
In-Reply-To: <20190612080404.4529-1-jzarsky@redhat.com>
References: <20190612080404.4529-1-jzarsky@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 12 Jun 2019 08:04:49 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add test for semanage_msg_default_handler.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsemanage/tests/test_other.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/libsemanage/tests/test_other.c b/libsemanage/tests/test_other.c
index 437064d2..c4ee0ed8 100644
--- a/libsemanage/tests/test_other.c
+++ b/libsemanage/tests/test_other.c
@@ -24,6 +24,9 @@
 /* context_record.h */
 void test_semanage_context(void);
 
+/* debug.h */
+void test_debug(void);
+
 extern semanage_handle_t *sh;
 
 int other_test_init(void)
@@ -39,6 +42,7 @@ int other_test_cleanup(void)
 int other_add_tests(CU_pSuite suite)
 {
 	CU_add_test(suite, "semanage_context", test_semanage_context);
+	CU_add_test(suite, "debug", test_debug);
 
 	return 0;
 }
@@ -95,3 +99,22 @@ void test_semanage_context(void)
 	semanage_context_free(con_clone);
 	cleanup_handle(SH_CONNECT);
 }
+
+/* Function semanage_msg_default_handler */
+void test_debug(void)
+{
+	semanage_module_info_t *modinfo = NULL;
+
+	/* setup */
+	sh = semanage_handle_create();
+	CU_ASSERT_PTR_NOT_NULL(sh);
+	CU_ASSERT(semanage_connect(sh) >= 0);
+	CU_ASSERT(semanage_module_info_create(sh, &modinfo) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_module_info_set_priority(sh, modinfo, -42) < 0);
+
+	/* cleanup */
+	CU_ASSERT(semanage_disconnect(sh) >= 0);
+	semanage_handle_destroy(sh);
+}
-- 
2.20.1

