Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010CDC07E95
	for <selinux@archiver.kernel.org>; Sat, 10 Jul 2021 12:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04C661351
	for <selinux@archiver.kernel.org>; Sat, 10 Jul 2021 12:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhGJMN4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 10 Jul 2021 08:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhGJMNz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 10 Jul 2021 08:13:55 -0400
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 10 Jul 2021 05:11:10 PDT
Received: from forward106p.mail.yandex.net (forward106p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE184C0613DD
        for <selinux@vger.kernel.org>; Sat, 10 Jul 2021 05:11:10 -0700 (PDT)
Received: from iva5-f90c153e7fcb.qloud-c.yandex.net (iva5-f90c153e7fcb.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7d80:0:640:f90c:153e])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 65DA21C8295C
        for <selinux@vger.kernel.org>; Sat, 10 Jul 2021 15:03:03 +0300 (MSK)
Received: from iva1-bc1861525829.qloud-c.yandex.net (iva1-bc1861525829.qloud-c.yandex.net [2a02:6b8:c0c:a0e:0:640:bc18:6152])
        by iva5-f90c153e7fcb.qloud-c.yandex.net (mxback/Yandex) with ESMTP id EiSsy0nQBA-33HaAt8m;
        Sat, 10 Jul 2021 15:03:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1625918583;
        bh=owilsSQoyQx0KSHSv2UihFEugVJkPu3ycUV4j0YOLIw=;
        h=Date:Subject:To:From:Message-Id;
        b=a4XKc2oA62zB0WUrjWvexK/74Lex9N2INmU2GzI2dXx/vZwsdW2rAWdT7BedTkQBY
         IAX7AlhFX1aKQPYLNKc/gle3CYwKG7YwXncfHiRaeQ7ddU4Om4Wn/EhcOF2Glb536l
         2bf4k14sBLIhNsJ7O3cPBLt9200J0FaTHLoJBI2E=
Authentication-Results: iva5-f90c153e7fcb.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Received: by iva1-bc1861525829.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id FGY8jxoL3C-32PSwuli;
        Sat, 10 Jul 2021 15:03:02 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Evgeny Vereshchagin <evvers@ya.ru>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] ci: turn on CIFuzz
Date:   Sat, 10 Jul 2021 12:03:01 +0000
Message-Id: <20210710120302.74862-1-evvers@ya.ru>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Now that almost all the bugs reported by OSS-Fuzz have been
fixed libsepol/cil should be stable enough to get CIFuzz working
more or less reliably. It should help to catch regressions/new bugs
faster.

https://google.github.io/oss-fuzz/getting-started/continuous-integration/

The patch was tested on GitHub in https://github.com/SELinuxProject/selinux/pull/285
The CIFuzz job can be found at https://github.com/SELinuxProject/selinux/actions/runs/1017865690

Signed-off-by: Evgeny Vereshchagin <evvers@ya.ru>
---
 .github/workflows/cifuzz.yml | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 .github/workflows/cifuzz.yml

diff --git a/.github/workflows/cifuzz.yml b/.github/workflows/cifuzz.yml
new file mode 100644
index 00000000..5c2233a2
--- /dev/null
+++ b/.github/workflows/cifuzz.yml
@@ -0,0 +1,39 @@
+---
+name: CIFuzz
+on:
+  push:
+    branches:
+      - master
+  pull_request:
+    branches:
+      - master
+jobs:
+  Fuzzing:
+    runs-on: ubuntu-latest
+    if: github.repository == 'SELinuxProject/selinux'
+    strategy:
+      fail-fast: false
+      matrix:
+        sanitizer: [address, undefined, memory]
+    steps:
+      - name: Build Fuzzers (${{ matrix.sanitizer }})
+        id: build
+        uses: google/oss-fuzz/infra/cifuzz/actions/build_fuzzers@master
+        with:
+          oss-fuzz-project-name: 'selinux'
+          dry-run: false
+          allowed-broken-targets-percentage: 0
+          sanitizer: ${{ matrix.sanitizer }}
+      - name: Run Fuzzers (${{ matrix.sanitizer }})
+        uses: google/oss-fuzz/infra/cifuzz/actions/run_fuzzers@master
+        with:
+          oss-fuzz-project-name: 'selinux'
+          fuzz-seconds: 180
+          dry-run: false
+          sanitizer: ${{ matrix.sanitizer }}
+      - name: Upload Crash
+        uses: actions/upload-artifact@v1
+        if: failure() && steps.build.outcome == 'success'
+        with:
+          name: ${{ matrix.sanitizer }}-artifacts
+          path: ./out/artifacts
-- 
2.31.1

