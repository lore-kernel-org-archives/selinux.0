Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8E8EB64DD
	for <selinux@archiver.kernel.org>; Sat,  5 Aug 2023 09:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjHEJoo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Aug 2023 05:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHEJoo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Aug 2023 05:44:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B02310FC
        for <selinux@vger.kernel.org>; Sat,  5 Aug 2023 02:44:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c10ba30afso850611666b.1
        for <selinux@vger.kernel.org>; Sat, 05 Aug 2023 02:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691228681; x=1691833481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ET7aaTQaTGw00xOnk2tagygzcWrpoVLDL4AjPRyQs/A=;
        b=T91yKzijkgq+NKIvSkHhSjUBpmKJ1QISKoBzwmI5C0ANc6GLHPIetUIvO78OtX139/
         V3Mxabna+Ai4WbOhgh+JeAtteqx1paI4HbXtJo8fnrHLveZHrODgInDe6wmGmfSkbsvU
         2BHEurqZ2PtR886MAoqw3UZRORua0blOhJod+bxvhruanidC2voFuylAja9p73fIH6BG
         W2XQoUgYb6jFfDP/mxdiysiH74QOHJX2aYui0SM+BhNjxp1rsVjlo36kVQrew9S8S3xC
         XWmQnEi1+l9AkAKy30SqCNIhByV/4WaqnhdxY0tmyThQeXr9kxkLqedtczu4D6I6qjUT
         w3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691228681; x=1691833481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ET7aaTQaTGw00xOnk2tagygzcWrpoVLDL4AjPRyQs/A=;
        b=f6rZ9ynnmxX3GAJWpe6NN3Z803Ve4c0i8Qb/R+zET5L1+f9z8QK/JEKsfbbADHDKjQ
         AD6kmhjzJWNLzt7j5wWlQQG1rufkK4hCII1LA/qDpt4KmTRw15zysROMLncyGa/ziu3Y
         Scd41JkQobzHGZkJrsHIrysVY9eBiNuCHqkKPB8C1X+yYFI6wWjWMyg/hj89Lcnx04xI
         4tJ2TxryP8L2HzmLm+Sy8WagEfL1IzBy8t1Lt6/+l8RrqabfXVVrfOINNNUd1v22U/Vh
         sO2+djYNnuZAZnxnBLfkWHA3YHacR+mDlrRyIMeJbTxv08X4Vs91Rkqq6z1okLUnhb2t
         lV+A==
X-Gm-Message-State: AOJu0YxsWkg9D2lLFaKSOj8IYUEGwAkuXNEKsQai1Opi01tMDIvA75rE
        X7qiIz4VuGn0+HJk7+C3Bl0nkCBY+mbKmQ==
X-Google-Smtp-Source: AGHT+IF7CD5K68n+ClZt0z5gOm4nZGCr/6Hq5z/SwKKHa220HUn+xrHYNe7eIxdTqS16wWdb/DS9/g==
X-Received: by 2002:a17:907:6e8d:b0:994:fec:e1b7 with SMTP id sh13-20020a1709076e8d00b009940fece1b7mr2417868ejc.0.1691228681235;
        Sat, 05 Aug 2023 02:44:41 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-077-006-133-057.77.6.pool.telefonica.de. [77.6.133.57])
        by smtp.gmail.com with ESMTPSA id rl2-20020a170907216200b00992e51fecfbsm2491534ejb.64.2023.08.05.02.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 02:44:40 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsemanage/tests: use strict prototypes
Date:   Sat,  5 Aug 2023 11:44:18 +0200
Message-Id: <20230805094418.18828-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    utilities.c:39:22: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
    int create_test_store() {
                         ^
                          void
    utilities.c:171:23: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
    int destroy_test_store() {
                          ^
                           void

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/tests/utilities.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/tests/utilities.c b/libsemanage/tests/utilities.c
index 71d7af1e..806869e0 100644
--- a/libsemanage/tests/utilities.c
+++ b/libsemanage/tests/utilities.c
@@ -36,7 +36,7 @@ void test_msg_handler(void *varg, semanage_handle_t *handle, const char *fmt,
 {
 }
 
-int create_test_store() {
+int create_test_store(void) {
 	FILE *fptr;
 
 	if (mkdir("test-policy", 0700) < 0)
@@ -168,7 +168,7 @@ int write_test_policy_src(unsigned char *data, unsigned int data_len) {
 	return 0;
 }
 
-int destroy_test_store() {
+int destroy_test_store(void) {
 	FTS *ftsp = NULL;
 	FTSENT *curr = NULL;
 	int ret = 0;
-- 
2.40.1

