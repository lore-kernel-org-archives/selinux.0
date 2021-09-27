Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCF6C433F5
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 08:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B006D6108E
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 08:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhI0Ivj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Sep 2021 04:51:39 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:60682 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhI0Ivj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Sep 2021 04:51:39 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 4B59A5647DF
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 10:50:00 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] README: update continuous integration badges
Date:   Mon, 27 Sep 2021 10:49:44 +0200
Message-Id: <20210927084944.7197-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Sep 27 10:50:00 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The CI now uses GitHub Actions to run tests and the SELinux testsuite in
a virtual machine. Replace the Travis CI badge with the ones for these
workflows.

Fixes: https://github.com/SELinuxProject/selinux/issues/299
Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 README.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index d1338e8765d1..e1c2fe641fc9 100644
--- a/README.md
+++ b/README.md
@@ -2,7 +2,8 @@ SELinux Userspace
 =================
 
 ![SELinux logo](https://github.com/SELinuxProject.png)
-[![Build Status](https://travis-ci.org/SELinuxProject/selinux.svg?branch=master)](https://travis-ci.org/SELinuxProject/selinux)
+[![Run Tests](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml)
+[![Run SELinux testsuite in a virtual machine](https://github.com/SELinuxProject/selinux/actions/workflows/vm_testsuite.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/vm_testsuite.yml)
 [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
 [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
 
-- 
2.32.0

