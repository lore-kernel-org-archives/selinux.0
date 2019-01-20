Return-Path: <SRS0=W3AJ=P4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA0BC26640
	for <selinux@archiver.kernel.org>; Sun, 20 Jan 2019 19:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC92520880
	for <selinux@archiver.kernel.org>; Sun, 20 Jan 2019 19:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfATTUA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 20 Jan 2019 14:20:00 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:57647 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfATTUA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 20 Jan 2019 14:20:00 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E03CB56120C
        for <selinux@vger.kernel.org>; Sun, 20 Jan 2019 20:19:57 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] Travis-CI: add Ruby 2.6 to the test matrix
Date:   Sun, 20 Jan 2019 20:19:32 +0100
Message-Id: <20190120191933.21343-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190120191933.21343-1-nicolas.iooss@m4x.org>
References: <20190120191933.21343-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jan 20 20:19:58 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index b8e97f83bbcd..19914f4c2823 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -11,19 +11,20 @@ compiler:
 env:
   matrix:
     # Test the last version of Python and Ruby together, with some linkers
-    - PYVER=python3.7 RUBYLIBVER=2.5.1
-    - PYVER=python3.7 RUBYLIBVER=2.5.1 TEST_FLAGS_OVERRIDE=1
-    - PYVER=python3.7 RUBYLIBVER=2.5.1 LINKER=gold
-    - PYVER=python3.7 RUBYLIBVER=2.5.1 LINKER=bfd
+    - PYVER=python3.7 RUBYLIBVER=2.6
+    - PYVER=python3.7 RUBYLIBVER=2.6 TEST_FLAGS_OVERRIDE=1
+    - PYVER=python3.7 RUBYLIBVER=2.6 LINKER=gold
+    - PYVER=python3.7 RUBYLIBVER=2.6 LINKER=bfd
 
     # Test several Python versions
-    - PYVER=python2.7 RUBYLIBVER=2.5.1
-    - PYVER=python3.5 RUBYLIBVER=2.5.1
-    - PYVER=python3.6 RUBYLIBVER=2.5.1
-    - PYVER=pypy2.7-6.0 RUBYLIBVER=2.5.1
-    - PYVER=pypy3.5-6.0 RUBYLIBVER=2.5.1
+    - PYVER=python2.7 RUBYLIBVER=2.6
+    - PYVER=python3.5 RUBYLIBVER=2.6
+    - PYVER=python3.6 RUBYLIBVER=2.6
+    - PYVER=pypy2.7-6.0 RUBYLIBVER=2.6
+    - PYVER=pypy3.5-6.0 RUBYLIBVER=2.6
 
-    # Test several Ruby versions
+    # Test several Ruby versions (http://rubies.travis-ci.org/)
+    - PYVER=python3.7 RUBYLIBVER=2.5.1
     - PYVER=python3.7 RUBYLIBVER=2.4
     - PYVER=python3.7 RUBYLIBVER=2.3
     - PYVER=python3.7 RUBYLIBVER=2.2
@@ -31,9 +32,9 @@ env:
 matrix:
   exclude:
     - compiler: clang
-      env: PYVER=python3.7 RUBYLIBVER=2.5.1 LINKER=gold
+      env: PYVER=python3.7 RUBYLIBVER=2.6 LINKER=gold
     - compiler: clang
-      env: PYVER=python3.7 RUBYLIBVER=2.5.1 LINKER=bfd
+      env: PYVER=python3.7 RUBYLIBVER=2.6 LINKER=bfd
 
 # Use Travis-CI Ubuntu 16.04 Xenial Xerus infrastructure, "full image" variant
 sudo: required
-- 
2.20.1

