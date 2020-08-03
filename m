Return-Path: <SRS0=5Yje=BN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159F3C433DF
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 15:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE3C20825
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 15:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShuFO0z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgHCPOf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCPOf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 11:14:35 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E704C06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 08:14:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so20814550pls.4
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y9E7Q+5hEiDCcwHm8jAEGUJw3qsMXHmd9kIT7B0NL1s=;
        b=ShuFO0z8dDlnJ6vRWgwN69Wwz/4zifQyQIHNg3fS8EE4mFfr8jccIWNDWIGDH1P9NG
         7Kt/be8+4a/Olgg7xGUgWlfKn0C8kjZY5ZobbImLF28eXxXKMBLqdbtdU74ktZX/+E7Y
         Q+aJFxBzRbvW9uDN3BcBLOPYhMsDvd+26MB8SRtghcvMxflpX/XCoAEQE8OOUTLCnsxj
         eYTQcZ87iyn0kn2DchlZrWc2n+4GbiSRTMla/cvIMaw7A2EFr53UEFPSpI1b0Zf+tuCi
         fNdp4WinzGB3M+krf5gOg8CAlkUMK9RFhDT65GKwFu1L4k8/NE9Sfwu2dygDlfSFa/Mz
         ncvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y9E7Q+5hEiDCcwHm8jAEGUJw3qsMXHmd9kIT7B0NL1s=;
        b=E5KYSw/BOU7100qhGmt5fmk3OtAncIAvZQQ4ppoYIGj82GYDwWBsbeW8KYL4W1WzLd
         NkRyzfmUWlGKqwR8F+mkg+Q0z/XzgMWwQbNTPA/TnXKGvAUdU86A6dyCICJG50POXoPf
         /7Y1TePCa0LR6qRIExG0D0TfEv7KYHmb/MV829HywPuVaQKrDVPwoNNO0Npn/GD7vkwv
         oNVReT5QtaUo+3fRnqBZaH64lSQPyc0f0qIC4I+RYiC7bqlIn5WNkh2OBH1z8aLooqtW
         WYQ/0yc8Dz/KAa24mDtrMuU1XVmVx30Fdf0OL4oYXQUbKkKx7XZmkz12lQrkCfW+AAc/
         soVw==
X-Gm-Message-State: AOAM5307twcu4DiCIwFbYGKpKhCvcQ0XGt5HYjY5mki5z8CWH/mt6TTC
        v3KqznlQe5zyHpPiDRj1FsEwaiFzZP0=
X-Google-Smtp-Source: ABdhPJyW6MNTSh2NFdoXn/9KiTYuddUm/C6/bo3FQ9xZ++XDVbfCIrLs8WrwjZg8KDoAA1ohJa5ZKg==
X-Received: by 2002:a17:902:bd48:: with SMTP id b8mr15474412plx.121.1596467674468;
        Mon, 03 Aug 2020 08:14:34 -0700 (PDT)
Received: from wcrobert-MOBL1.netgear.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id i12sm3642579pgj.23.2020.08.03.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 08:14:33 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     omosnace@redhat.com
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        william.c.roberts@intel.com
Subject: [PATCH v2] scripts/ci: license as MIT
Date:   Mon,  3 Aug 2020 10:14:28 -0500
Message-Id: <20200803151428.15166-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFqZXNvh9q4qTSN-Fj108JrO8DAfMiDkOzTDHs6n3Pxg+DOtXg@mail.gmail.com>
References: <CAFqZXNvh9q4qTSN-Fj108JrO8DAfMiDkOzTDHs6n3Pxg+DOtXg@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

License the ci scripts with a permissive, OSI approved license, such as
MIT.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 v1: Apache 2.0
 v2: MIT
 
 scripts/ci/LICENSE               | 7 +++++++
 scripts/ci/fedora-test-runner.sh | 2 +-
 scripts/ci/travis-kvm-setup.sh   | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)
 create mode 100644 scripts/ci/LICENSE

diff --git a/scripts/ci/LICENSE b/scripts/ci/LICENSE
new file mode 100644
index 000000000000..6cd7b7924ef9
--- /dev/null
+++ b/scripts/ci/LICENSE
@@ -0,0 +1,7 @@
+Copyright <YEAR> <COPYRIGHT HOLDER>
+
+Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
index 569723387f6b..0aaba87c421b 100755
--- a/scripts/ci/fedora-test-runner.sh
+++ b/scripts/ci/fedora-test-runner.sh
@@ -1,5 +1,5 @@
 #!/usr/bin/env bash
-
+# SPDX-License-Identifier: MIT
 set -ev
 
 #
diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
index 8d4cfb79f7d7..2b5734178096 100755
--- a/scripts/ci/travis-kvm-setup.sh
+++ b/scripts/ci/travis-kvm-setup.sh
@@ -1,5 +1,5 @@
 #!/usr/bin/env bash
-
+# SPDX-License-Identifier: MIT
 set -ev
 
 TEST_RUNNER="scripts/ci/fedora-test-runner.sh"
-- 
2.17.1

