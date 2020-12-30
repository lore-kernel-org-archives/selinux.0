Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BF7C433DB
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 20:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C2B2222A
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 20:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL3UJZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Dec 2020 15:09:25 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:40931 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3UJZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Dec 2020 15:09:25 -0500
Received: from localhost.localdomain (174.17.206.77.rev.sfr.net [77.206.17.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2A31C565A0A
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 21:08:43 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] GitHub Actions: run SELinux testsuite in Fedora virtual machine
Date:   Wed, 30 Dec 2020 21:08:21 +0100
Message-Id: <20201230200821.3454892-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Dec 30 21:08:43 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the Vagrant configuration in scripts/ci in a workflow for GitHub
Actions.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
Example of run: https://github.com/fishilico/selinux/runs/1627586446

 .github/workflows/vm_testsuite.yml | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 .github/workflows/vm_testsuite.yml

diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
new file mode 100644
index 000000000000..af2fad1e73f5
--- /dev/null
+++ b/.github/workflows/vm_testsuite.yml
@@ -0,0 +1,22 @@
+name: Run SELinux testsuite in a virtual machine
+
+on: [push, pull_request]
+
+jobs:
+  vm_testsuite:
+
+    # Use VirtualBox+vagrant on macOS, as described in https://github.com/actions/virtual-environments/issues/433
+    runs-on: macos-latest
+
+    steps:
+    - uses: actions/checkout@v2
+
+    - name: Create Vagrant VM
+      run: |
+        cd scripts/ci
+        vagrant up
+
+    - name: Run SELinux testsuite in the VM
+      run: |
+        cd scripts/ci
+        vagrant ssh -- ./run-selinux-test.sh
-- 
2.29.2

