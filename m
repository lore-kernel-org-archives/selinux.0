Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DAAC63797
	for <selinux@archiver.kernel.org>; Sun, 15 Jan 2023 23:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjAOXed (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 15 Jan 2023 18:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjAOXec (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 15 Jan 2023 18:34:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E5E83F6
        for <selinux@vger.kernel.org>; Sun, 15 Jan 2023 15:34:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso29487608pjf.1
        for <selinux@vger.kernel.org>; Sun, 15 Jan 2023 15:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDCOm2pxvY2EfttGk+prcJ4jP9ydy+6LjuCgK458U6Y=;
        b=PPjw0wbMZw9oLkcTd+xtjIQCLFFaztR55igF5k4i2X1/Ft6bho4O4n71yR5DkvcgXN
         1L7PcboRX9ydEDT+DEzd409kUMqlt7L652DX69g6XzWPAhN3FY0geGLcj4ThgMW89j2a
         u3hIgcZ4FB6KcHh064eL30smEFP2zdSbL3hftsSJKsk9jFgYDQrdVELPBzyuugGhl3ay
         7r7tCU5QglAZNCDtmJLo4c1jZT2p/7NqpW32VRaF/VsJUhhCOEkRhO27gTlpnHop5I+x
         0S8NaVxJ+JF//HT99ZdFwgxTDyhd/AEA0VWcs608Xgep2h6Orf3hjcTGO7m+awLu13Jl
         E9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDCOm2pxvY2EfttGk+prcJ4jP9ydy+6LjuCgK458U6Y=;
        b=hn1WIr2L9YNS8cxWyaWpdXNh8DfbF2NXKTuN5WBcqXmkHw3UuCXLfZn39yA4/PmdO6
         CQ1fob5VhUIChDbh8ZNf6WPe3XMwU0PQlH9nC2oqmMSdFY0KWII0qQmuMaj2V9mDlQin
         A8Qpz8mgtV1DJ9DnIT1wGpnDmaGurVyJKnfSxF4JwzMEtE7rY8AGS3p1otg62qQEDjFC
         +7pZxj7qaWv17wviyFks8kmHJiWqdqkNroAjFsEKkiZLdNFrz6GzRSAOfmYlspnnFCfR
         y7Zb0pJ6Jyfabq/VESOw2vUTSrJBL9vXJGA1/vVrq5A7rprc4/hxZ8+OMBkZpXJr9Kx9
         Aayg==
X-Gm-Message-State: AFqh2kpYvpdcIyplquSbd2e8AdeDXlHDrx9RoqYPBPSuixunTPUSU02c
        C0w0aImhv5gTH/00r8YpFysArf3TZuP/fu1SBZg=
X-Google-Smtp-Source: AMrXdXsj7KifV6tjRTVLQLYceYvnIQ8x3Y4ieg3fe46PeQzCGmJPHsSCUS2RCISAFgJzNOizXXNzQA==
X-Received: by 2002:a17:902:e54b:b0:194:6679:87fa with SMTP id n11-20020a170902e54b00b00194667987famr17902308plf.32.1673825669845;
        Sun, 15 Jan 2023 15:34:29 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id b7-20020a63eb47000000b00460ea630c1bsm14687400pgk.46.2023.01.15.15.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 15:34:29 -0800 (PST)
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Cc:     Jason Zaman <jason@perfinion.com>
Subject: [PATCH] ci: bump to python 3.11 in GitHub Actions
Date:   Sun, 15 Jan 2023 15:34:26 -0800
Message-Id: <20230115233426.41204-1-jason@perfinion.com>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

- Also drop py3.5, py3.6 since they are no longer supported in the
  github 22.04 runners

Signed-off-by: Jason Zaman <jason@perfinion.com>
---

CI passed here: https://github.com/perfinion/selinux/actions/runs/3925727573


 .github/workflows/run_tests.yml | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index db0e1af5..198ba7b6 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -10,31 +10,30 @@ jobs:
       matrix:
         compiler: [gcc, clang]
         python-ruby-version:
-          - {python: '3.10', ruby: '3.1'}
-          - {python: '3.10', ruby: '3.1', other: test-flags-override}
-          - {python: '3.10', ruby: '3.1', other: test-debug}
-          - {python: '3.10', ruby: '3.1', other: linker-bfd}
-          - {python: '3.10', ruby: '3.1', other: linker-gold}
+          - {python: '3.11', ruby: '3.1'}
+          - {python: '3.11', ruby: '3.1', other: 'test-flags-override'}
+          - {python: '3.11', ruby: '3.1', other: 'test-debug'}
+          - {python: '3.11', ruby: '3.1', other: 'linker-bfd'}
+          - {python: '3.11', ruby: '3.1', other: 'linker-gold'}
           # Test several Python versions with the latest Ruby version
+          - {python: '3.10', ruby: '3.1'}
           - {python: '3.9', ruby: '3.1'}
           - {python: '3.8', ruby: '3.1'}
           - {python: '3.7', ruby: '3.1'}
-          - {python: '3.6', ruby: '3.1'}
-          - {python: '3.5', ruby: '3.1'}
           - {python: 'pypy3.7', ruby: '3.1'}
           # Test several Ruby versions with the latest Python version
-          - {python: '3.10', ruby: '3.0'}
-          - {python: '3.10', ruby: '2.7'}
-          - {python: '3.10', ruby: '2.6'}
-          - {python: '3.10', ruby: '2.5'}
+          - {python: '3.11', ruby: '3.0'}
+          - {python: '3.11', ruby: '2.7'}
+          - {python: '3.11', ruby: '2.6'}
+          - {python: '3.11', ruby: '2.5'}
         exclude:
           - compiler: clang
-            python-ruby-version: {python: '3.10', ruby: '3.1', other: linker-bfd}
+            python-ruby-version: {python: '3.11', ruby: '3.1', other: 'linker-bfd'}
           - compiler: clang
-            python-ruby-version: {python: '3.10', ruby: '3.1', other: linker-gold}
+            python-ruby-version: {python: '3.11', ruby: '3.1', other: 'linker-gold'}
         include:
           - compiler: gcc
-            python-ruby-version: {python: '3.10', ruby: '3.1', other: sanitizers}
+            python-ruby-version: {python: '3.11', ruby: '3.1', other: 'sanitizers'}
 
     steps:
     - uses: actions/checkout@v3
-- 
2.38.2

