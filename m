Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185B0C433FE
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 18:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbhKWSgr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbhKWSgr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 13:36:47 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3E7C061574
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 10:33:38 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g14so96120203edb.8
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 10:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2osoShOeQBLQQZdZwmrK9Cw5dJ/2Kxmg+usnZQB+tLQ=;
        b=fuZ4meSJ7FbWHSdoF2H4I1wSFIkhWXvcwwl7izAFGzAvWKuJEfPmzsAROonxumMcJA
         NdSgZdHG6v2JZSB8OQhiUfglhCSUPhXh6H4pIRq+Y6Re88721M7zVFmPRuXLuNz2CBDu
         UgtV7cv7QkV0GQGPxPKyM/nDVAReSnN6/owzcOLQrIvVNLUx7dkcyClUkqEidbw03b8r
         loM6eyuftCsCBsLviZOqwmaEMf8AIR+GtudgXIswm9xMzdMKYozC9bpgUwlX5lWARJTC
         yTqLjtvQjBmoF73s3YSu+q8dq8NnRzhYWkToqhk94JQ86ptzzmvihncCdTYD7tBSDtVm
         OGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2osoShOeQBLQQZdZwmrK9Cw5dJ/2Kxmg+usnZQB+tLQ=;
        b=t6AzMehID01BulOP5PDABOMqEHa3j3tTfWCnr3YL6myvCXFnsPa98aLAw8duLlx5Gd
         YFCdRQxIzSgjZb0jkNt/Xz8Y93mQ9GLJSejMwaRxUdZw21teI+OKn642cuY000mYBnhO
         Ac9wI2G/yKY+JbZ4BVDYoXnA/34Y62Ji2rikam4uMjSpTHoofwGwEqpeuCqX1GcA/SwU
         Q8Esl47nxnXgQ7S1Mu81oZdbryCcpm3RaSMzQT7WUxExozFnXaIsrxiv9CajhHkZg0gI
         B3o5HahORU99SO2Nby4qZ1S8N48AKyn9b11EDy5XYrV0au4+yqDxr8AxECRWBYjFY/9v
         3LrA==
X-Gm-Message-State: AOAM530arTS6Nt1tt8wP21Jh6cuYtH6iyZLKkRMWkwalcK84zMSetPCX
        UVjvHP4MN3vaOGbBteEI3eemp1mEStk=
X-Google-Smtp-Source: ABdhPJxXotU0+gQiRX4Mvzm71OnpcMm4/OopMoeh7b9Dia6qiqFq3MjqZlzr0BvUzy5R5mCth0/Hzw==
X-Received: by 2002:a05:6402:10cd:: with SMTP id p13mr12371164edu.111.1637692416911;
        Tue, 23 Nov 2021 10:33:36 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-112-244-006.95.112.pool.telefonica.de. [95.112.244.6])
        by smtp.gmail.com with ESMTPSA id k16sm6159714edq.77.2021.11.23.10.33.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 10:33:36 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] Replace PCRE with PCRE2 build dependencies
Date:   Tue, 23 Nov 2021 19:32:49 +0100
Message-Id: <20211123183249.6133-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123183249.6133-1-cgzones@googlemail.com>
References: <20211123183249.6133-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Now that libselinux defaults to PCRE2 and mcstrans has been ported,
update all documentation and scripts.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .circleci/config.yml             | 2 +-
 .github/workflows/run_tests.yml  | 2 +-
 CONTRIBUTING.md                  | 2 +-
 README.md                        | 4 ++--
 scripts/ci/fedora-test-runner.sh | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/.circleci/config.yml b/.circleci/config.yml
index 5d3177da..af20484b 100644
--- a/.circleci/config.yml
+++ b/.circleci/config.yml
@@ -13,7 +13,7 @@ jobs:
 
     # Install dependencies
     - run: sudo apt-get update -qq
-    - run: sudo apt-get install -qq bison clang clang-tools flex gawk gettext libaudit-dev libcap-dev libcap-ng-dev libcunit1-dev libdbus-glib-1-dev libpcre3-dev python3-dev python-dev ruby-dev swig xmlto
+    - run: sudo apt-get install -qq bison clang clang-tools flex gawk gettext libaudit-dev libcap-dev libcap-ng-dev libcunit1-dev libdbus-glib-1-dev libpcre2-dev python3-dev python-dev ruby-dev swig xmlto
 
     - run:
         name: Setup environment variables
diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index ef4be8af..01fbbbe5 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -57,7 +57,7 @@ jobs:
             libcap-ng-dev \
             libcunit1-dev \
             libdbus-glib-1-dev \
-            libpcre3-dev \
+            libpcre2-dev \
             python3-dev \
             python-dev \
             ruby-dev \
diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index a3517cb8..7c548e58 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -26,7 +26,7 @@ using a custom policy please include it as well.
 There are a number of dependencies required to build the userspace
 tools/libraries. On a Fedora system you can install them with yum:
 
-    # yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python-devel setools-devel swig ustr-devel
+    # yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre2-devel python-devel setools-devel swig ustr-devel
 
 The tools and libraries can be built and installed under a private directory from the top level with make, e.g.
 
diff --git a/README.md b/README.md
index e1c2fe64..74b0a0c3 100644
--- a/README.md
+++ b/README.md
@@ -51,7 +51,7 @@ dnf install \
     libcap-devel \
     libcap-ng-devel \
     pam-devel \
-    pcre-devel \
+    pcre2-devel \
     xmlto
 
 # For Python and Ruby bindings
@@ -78,7 +78,7 @@ apt-get install --no-install-recommends --no-install-suggests \
     libcap-ng-dev \
     libcunit1-dev \
     libglib2.0-dev \
-    libpcre3-dev \
+    libpcre2-dev \
     pkgconf \
     python3 \
     python3-distutils \
diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
index f817499b..3ce2c3a6 100755
--- a/scripts/ci/fedora-test-runner.sh
+++ b/scripts/ci/fedora-test-runner.sh
@@ -36,7 +36,7 @@ dnf install -y \
     libcap-devel \
     libcap-ng-devel \
     pam-devel \
-    pcre-devel \
+    pcre2-devel \
     xmlto \
     python3-devel \
     ruby-devel \
-- 
2.34.0

