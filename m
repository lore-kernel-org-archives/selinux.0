Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B24C433EF
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 08:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C2C60EB4
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 08:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhI0IIX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Sep 2021 04:08:23 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:33394 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhI0IIW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Sep 2021 04:08:22 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 60BEF564AF7
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 10:06:43 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] GitHub Actions: do not use macOS latest runner for now
Date:   Mon, 27 Sep 2021 10:06:34 +0200
Message-Id: <20210927080634.4668-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Sep 27 10:06:43 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

GitHub is currently migrating its macos-latest runner to macOS 11:
https://github.com/actions/virtual-environments/issues/4060

Unfortunately, installing VirtualBox and Vagrant on this new version of
macOS is not easy, and the current macos-11 runner does not support
running virtual machines using Vagrant. This issue is being fixed on
https://github.com/actions/virtual-environments/pull/4010 .

Until this Pull Request is merged, use macos-10.15 runner instead of
macos-latest, to continue using Vagrant to run the SELinux testsuite in
a virtual machine.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---

For information, I tested this patch on
https://github.com/fishilico/selinux/actions/runs/1273275936

 .github/workflows/vm_testsuite.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
index af2fad1e73f5..601276ddcf50 100644
--- a/.github/workflows/vm_testsuite.yml
+++ b/.github/workflows/vm_testsuite.yml
@@ -6,7 +6,8 @@ jobs:
   vm_testsuite:
 
     # Use VirtualBox+vagrant on macOS, as described in https://github.com/actions/virtual-environments/issues/433
-    runs-on: macos-latest
+    # Use an old version of macOS until https://github.com/actions/virtual-environments/pull/4010 is merged.
+    runs-on: macos-10.15
 
     steps:
     - uses: actions/checkout@v2
-- 
2.32.0

