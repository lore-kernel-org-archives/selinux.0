Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA08CC4332F
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A348D60EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhJKQ2Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhJKQ2Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A4DC061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id p13so70634391edw.0
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IgE5SYce2CwKG9puNgGnknytYYE1jm0LddDlDYEBKPw=;
        b=dCwqjlI7HC+RMqSQEY1kqAznPW2WCE7cBFVz8/Vap28x/oXQi6BdXX061HfBwRaSFu
         hmR7We8PctSHlX308fmIV7JTuuoezvE9zyfNPDV0baKZm80roNicpHVw04qqq1bNV2GD
         uYY1aYkCHVAP/LQ/jfjt0VthSUFooBZ/G2ZjxNR1P9+yvl1sAHRmfVUUgkDitSy8mDga
         EIUTz6G6UtzjOJMnQnWvYRdC3DXx2AwbqvW1pWq++JINT4m0gwN274qpnBQz4O5ndZ+e
         HTwPIUhs+mTlHKYb9QxMbXH8hq0uQQ2exQ2jUGgkhww5GJA7TsN4DEE6ND+QyTFXwmkz
         Qa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IgE5SYce2CwKG9puNgGnknytYYE1jm0LddDlDYEBKPw=;
        b=p/cVhARlNlt1E3EIRace++60drzNRHT5hUBSf8xjCoj34Iv7iWTWi4jI9h+BeXwf2z
         uIfWZgHwo5AQS1x8aCyeZVClceqcIHppVb6zYOJDVLUs7oylf6UlokJxmfYf5C9UdZLg
         ygbOzA8yeH/1idsZ44/9xy/VHfB7G4mDNOyOCISIp3KPjTwqFFWzl1GI/cl08T44jGF8
         3Kn2iq2yRuzwPANydtxm991XfQDCFTJao2DPzjugkiag0LZJwugW5SuCVMPkwPJkJYFj
         cASQQ4Oj9KiOtWCs3J5nqdydzOHaeKMsVSswlIMrIHdyKHLF5GtUnf5+Rz5GektxHHcP
         hp9Q==
X-Gm-Message-State: AOAM532wOFSq4bv63YZpV2FgcHt2Tg/IAvot/iTShXXImv6R58eo7cMN
        v8SaAQZnU4rhvgA60M+uUlbl10jEejA=
X-Google-Smtp-Source: ABdhPJyek6mCx6rPnszyoiWG6aKniXVrrHGC+GvQtU/X80in06NiFOYQ+7+AkU/aq4FDHiWsv07zbg==
X-Received: by 2002:a05:6402:1296:: with SMTP id w22mr20252044edv.390.1633969582788;
        Mon, 11 Oct 2021 09:26:22 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:22 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 03/35] libsepol/fuzz: silence secilc-fuzzer
Date:   Mon, 11 Oct 2021 18:25:01 +0200
Message-Id: <20211011162533.53404-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not output CIL log messages while fuzzing, since their amount are
huge, e.g. for neverallow or typebounds violations.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/fuzz/secilc-fuzzer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/fuzz/secilc-fuzzer.c b/libsepol/fuzz/secilc-fuzzer.c
index 255b3241..9a1a16de 100644
--- a/libsepol/fuzz/secilc-fuzzer.c
+++ b/libsepol/fuzz/secilc-fuzzer.c
@@ -8,6 +8,10 @@
 #include <sepol/cil/cil.h>
 #include <sepol/policydb.h>
 
+static void log_handler(__attribute__((unused)) int lvl, __attribute__((unused)) const char *msg) {
+	/* be quiet */
+}
+
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
 	enum cil_log_level log_level = CIL_ERR;
 	struct sepol_policy_file *pf = NULL;
@@ -24,6 +28,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
 	sepol_policydb_t *pdb = NULL;
 
 	cil_set_log_level(log_level);
+	cil_set_log_handler(log_handler);
 
 	cil_db_init(&db);
 	cil_set_disable_dontaudit(db, disable_dontaudit);
-- 
2.33.0

