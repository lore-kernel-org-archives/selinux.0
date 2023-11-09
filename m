Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E23EC4332F
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 15:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjKIPWD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 10:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjKIPWA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 10:22:00 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D513358E
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 07:21:57 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso1542981a12.1
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 07:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699543316; x=1700148116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LE3PxJ6FhvhQS5MLWz6c0pjUTYPjtQZB1qoMC1rHFBw=;
        b=JAx32GfVjSOSpS8OgcQzqHgtXsO5JJXt5xUwh/V1rnCg2qljtr0Q0gC+a8qRuzd/tN
         mbkZFXgu7BSx8U781BeaZ2XsCRsBeF27URG2NDh+QljWpPP8E44U5DQ2wSHAfqcK71jQ
         ISjcL+gnYWN8waQLHJKaSOsIIj3v2L6+qCSShyHrsP7xlrN3KHlBFlMjfSiqEBu78W1C
         XMfgTIEtvYHeaq9EbmhB9oErt/3pk3Wb0/LUeUo4jEA1UPn+c17D6D39t4ju/b4dDLjY
         H1mI2GZdCM86WOKPWrO81SPL9wTolkMzQb8hu/xeIC9wEnxwyH1Z/8OsEu1J3+p6QX0F
         DrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543316; x=1700148116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LE3PxJ6FhvhQS5MLWz6c0pjUTYPjtQZB1qoMC1rHFBw=;
        b=TmC4Kkb6LaNHvJtGyVRnBXSW7V7lZGjCtFtCMuy/VzDYCEcRgxLpdAXMW2Y3Ew/z9l
         l4y/oTjmDFVlH6t7eUN7mlNK8yB2HOD1gmnkqfhJP8OXRCN0NVzxQkfPYuO3EsGjg3ip
         aZTSUi0QrNQKRUDveg1TRtfxCqIBN803tJDd/zPU31vD/9vR3uOsoqOPCbBM+CQ39z8Q
         HSEdW5GJmcus74aqxR7ZC7LYslsY1p35h8eRO7NqMaSwCE5aa/eJH2iaT2rZpelYwCBV
         3tCWw3bevKfejzu6esFKHrLp0rDGKcPASdJ0ilGR2OFrORQP2houPPThTLqWUqDhAaRR
         ad1g==
X-Gm-Message-State: AOJu0Yygp3aliTbu8D6WTxnP6Z6BL9rEchnZ3j5KzeE2pLA3exVcuIGw
        q0S5dyQHnODGhs7G7mIpOyx9aWboNxM=
X-Google-Smtp-Source: AGHT+IGW71YDrZADJbajVdE++7Oj+rXtqCK4E32SN8UMP96kDqtTEyhBgFH1Xq+Q9/qb4hA/KdyEAA==
X-Received: by 2002:a50:cdc3:0:b0:53f:8ef:1b22 with SMTP id h3-20020a50cdc3000000b0053f08ef1b22mr4666214edj.2.1699543315906;
        Thu, 09 Nov 2023 07:21:55 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id bo18-20020a0564020b3200b0053df23511b0sm8068848edb.29.2023.11.09.07.21.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:21:55 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] github: bump action dependencies
Date:   Thu,  9 Nov 2023 16:21:50 +0100
Message-ID: <20231109152150.691053-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .github/workflows/cifuzz.yml       | 2 +-
 .github/workflows/run_tests.yml    | 2 +-
 .github/workflows/vm_testsuite.yml | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/cifuzz.yml b/.github/workflows/cifuzz.yml
index 92523db4..c4e592c5 100644
--- a/.github/workflows/cifuzz.yml
+++ b/.github/workflows/cifuzz.yml
@@ -33,7 +33,7 @@ jobs:
           report-unreproducible-crashes: true
           sanitizer: ${{ matrix.sanitizer }}
       - name: Upload Crash
-        uses: actions/upload-artifact@v1
+        uses: actions/upload-artifact@v3
         if: failure() && steps.build.outcome == 'success'
         with:
           name: ${{ matrix.sanitizer }}-artifacts
diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index 198ba7b6..3bd859a3 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -36,7 +36,7 @@ jobs:
             python-ruby-version: {python: '3.11', ruby: '3.1', other: 'sanitizers'}
 
     steps:
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v4
 
     - name: Set up Python ${{ matrix.python-ruby-version.python }}
       uses: actions/setup-python@v4
diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
index 92155da2..b96d58a5 100644
--- a/.github/workflows/vm_testsuite.yml
+++ b/.github/workflows/vm_testsuite.yml
@@ -9,7 +9,7 @@ jobs:
     runs-on: macos-12
 
     steps:
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v4
 
     - name: Create Vagrant VM
       run: |
-- 
2.42.0

