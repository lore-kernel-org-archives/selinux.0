Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C58FC433F5
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 22:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiDDWxr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 18:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbiDDWx0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 18:53:26 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAED38B5
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 15:10:46 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a11so8958327qtb.12
        for <selinux@vger.kernel.org>; Mon, 04 Apr 2022 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sAe5qmOLbdvaBQAkd8izjvnOPdGsnYQUy6JjvjqmACw=;
        b=uCyc8UqEwHli1nuJJEfnILt8SL9nq+cnQuLi16y3MdQKcoAbUH1ZIdjoSMHoPUWhle
         SuIlN2AkuZEZ4e9T2vLH6b0u9eiw1VAXyxqKMMRj/eX5gYulKMGXzX3aX61oUyytNiLk
         Zk7ZEdLA8GjN++2yuvZc0DjXFL5YnMRjpb4deEKiegS8oZoyKaFFprr0lG1T3IBQg3z2
         Q/zriC+0X6IdeWMm7wUoCM9a5EofjAfJ4rizsBHSZi5RBsjEAoXRm+yWi3YJKNQ+muW/
         IGvWjcm9FcUYTb2s439t8myOros8r6qs6x0TL8FfGR3X6uq/I5tAIP2WXK5JfCdVmMGP
         Ey3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=sAe5qmOLbdvaBQAkd8izjvnOPdGsnYQUy6JjvjqmACw=;
        b=JEl1UcV2ruOLXMGBDuAziUub45qo392JlXvbDpsj9tUGzUtG2snSZxqc1htwqKJsov
         gZuZIod5Grmj0qr+VKeFZscYckiq4By4x86rgXgTTwBA7I1cA87qroLbZk98h6xSUV5U
         OvwhjQO+vkd3ue9/uFqiPwnOH3/4x21gq29Jqw/dlMRTdULb44TNyOPBmRTpNCVPpwGG
         tbKBln6xIG5FMHlR9zrJ+TbgDaT1vlp8x+f48e3yAin52Gs/aLl9t4u4xt4SQxIk5ByB
         U4LN7gd9tZLHoIbob3KbKeHCzpcSaJyuJWSFGMYYxlx2A3VD1j8o3a02xaIRALbkS5R2
         J0FA==
X-Gm-Message-State: AOAM530tNp25OQGsTNP79b8XFkyLB+PpMqUTm5C06bYB7eCusHDoZG34
        44X32Pu19wgwYZcuecL3jMG/CF1nn1mg
X-Google-Smtp-Source: ABdhPJwT/XJKx+Jm25p2r9e+O8z9npsLkNOeYKlHcLb4r3jx85DQ/KUkStNoD30kd5Uhj69Z6X574Q==
X-Received: by 2002:ac8:45d2:0:b0:2e2:70b:f887 with SMTP id e18-20020ac845d2000000b002e2070bf887mr484898qto.272.1649110244982;
        Mon, 04 Apr 2022 15:10:44 -0700 (PDT)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a0e8400b0067b1bcd081csm6886218qkm.66.2022.04.04.15.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 15:10:44 -0700 (PDT)
Subject: [PATCH] github: add some basic GH Actions to build the notebook
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 04 Apr 2022 18:10:43 -0400
Message-ID: <164911024356.258070.13216631741313822218.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch adds GH Actions to built the HTML, PDF, and EPUB variants
of The SELinux Notebook when the GH repo is updated or a pull request
is submitted.  This should make it much easier for people to validate
their changes as well as providing fully rendered copies for each
revision moving forward.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 .github/actions/setup/action.yml |   16 ++++++++++++++++
 .github/workflows/epub.yml       |   26 ++++++++++++++++++++++++++
 .github/workflows/html.yml       |   26 ++++++++++++++++++++++++++
 .github/workflows/pdf.yml        |   26 ++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)
 create mode 100644 .github/actions/setup/action.yml
 create mode 100644 .github/workflows/epub.yml
 create mode 100644 .github/workflows/html.yml
 create mode 100644 .github/workflows/pdf.yml

diff --git a/.github/actions/setup/action.yml b/.github/actions/setup/action.yml
new file mode 100644
index 0000000..da37cf6
--- /dev/null
+++ b/.github/actions/setup/action.yml
@@ -0,0 +1,16 @@
+#
+# Github Action to setup The SELinux Notebook build
+#
+# Copyright (c) 2022 Microsoft Corporation <paulmoore@microsoft.com>
+# Author: Paul Moore <paul@paul-moore.com>
+#
+
+name: Setup the build for The SELinux Notebook
+description: "Install dependencies for The SELinux Notebook build"
+runs:
+  using: "composite"
+  steps:
+  - run: sudo apt-get update
+    shell: bash
+  - run: sudo apt-get install -y build-essential weasyprint pandoc calibre
+    shell: bash
diff --git a/.github/workflows/epub.yml b/.github/workflows/epub.yml
new file mode 100644
index 0000000..456f71d
--- /dev/null
+++ b/.github/workflows/epub.yml
@@ -0,0 +1,26 @@
+#
+# Github Action to build The SELinux Notebook
+#
+# Copyright (c) 2022 Microsoft Corporation <paulmoore@microsoft.com>
+# Author: Paul Moore <paul@paul-moore.com>
+#
+
+name: EPUB build
+on: ["push", "pull_request"]
+
+jobs:
+  epub:
+    runs-on: ubuntu-20.04
+
+    steps:
+    - name: Checkout from GitHub
+      uses: actions/checkout@v2
+    - name: Setup the build directory
+      uses: ./.github/actions/setup
+    - name: Run the build
+      run: make epub
+    - name: Archive the rendering
+      uses: actions/upload-artifact@v3
+      with:
+        name: EPUB rendering
+        path: ./epub/SELinux_Notebook.azw3
diff --git a/.github/workflows/html.yml b/.github/workflows/html.yml
new file mode 100644
index 0000000..eeb9164
--- /dev/null
+++ b/.github/workflows/html.yml
@@ -0,0 +1,26 @@
+#
+# Github Action to build The SELinux Notebook
+#
+# Copyright (c) 2022 Microsoft Corporation <paulmoore@microsoft.com>
+# Author: Paul Moore <paul@paul-moore.com>
+#
+
+name: HTML build
+on: ["push", "pull_request"]
+
+jobs:
+  html:
+    runs-on: ubuntu-20.04
+
+    steps:
+    - name: Checkout from GitHub
+      uses: actions/checkout@v2
+    - name: Setup the build directory
+      uses: ./.github/actions/setup
+    - name: Run the build
+      run: make html
+    - name: Archive the rendering
+      uses: actions/upload-artifact@v3
+      with:
+        name: HTML rendering
+        path: ./html/SELinux_Notebook.html
diff --git a/.github/workflows/pdf.yml b/.github/workflows/pdf.yml
new file mode 100644
index 0000000..93ea28c
--- /dev/null
+++ b/.github/workflows/pdf.yml
@@ -0,0 +1,26 @@
+#
+# Github Action to build The SELinux Notebook
+#
+# Copyright (c) 2022 Microsoft Corporation <paulmoore@microsoft.com>
+# Author: Paul Moore <paul@paul-moore.com>
+#
+
+name: PDF build
+on: ["push", "pull_request"]
+
+jobs:
+  pdf:
+    runs-on: ubuntu-20.04
+
+    steps:
+    - name: Checkout from GitHub
+      uses: actions/checkout@v2
+    - name: Setup the build directory
+      uses: ./.github/actions/setup
+    - name: Run the build
+      run: make pdf
+    - name: Archive the rendering
+      uses: actions/upload-artifact@v3
+      with:
+        name: PDF rendering
+        path: ./pdf/SELinux_Notebook.pdf

