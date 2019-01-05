Return-Path: <SRS0=MvMz=PN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A46C43387
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 16:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB25620868
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 16:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfAEQAE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:00:04 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:39024 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfAEQAE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Jan 2019 11:00:04 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E984E5612A6
        for <selinux@vger.kernel.org>; Sat,  5 Jan 2019 16:59:59 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] scripts/run-flake8: run on Python scripts not ending with .py
Date:   Sat,  5 Jan 2019 16:59:53 +0100
Message-Id: <20190105155953.19583-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  5 17:00:01 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When running flake8 on a directory, it does not analyze files without an
extension, like semanage_migrate_store, mlscolor-test, etc. Use grep to
find files with a Python shebang and build a list which is then given to
flake8.

This commit is possible now that some clean-up patches have been
applied, such as commit 69c56bd2f6e9 ("python/chcat: improve the code
readability") and b7227aaec1da ("mcstrans: fix Python linter warnings on
test scripts") and 3cb974d2d2a7 ("semanage_migrate_store: fix many
Python linter warnings").

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 scripts/run-flake8 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/run-flake8 b/scripts/run-flake8
index 6ad029fa6852..24b1202fde99 100755
--- a/scripts/run-flake8
+++ b/scripts/run-flake8
@@ -4,6 +4,11 @@
 # Run on the base directory if no argument has been given
 if [ $# -eq 0 ] ; then
     cd "$(dirname -- "$0")/.." || exit $?
+
+    # Run on both files ending with .py and Python files without extension
+    # shellcheck disable=SC2046
+    set -- $( (find . -name '*.py' ; grep --exclude-dir=.git -l -e '^#!\s*/usr/bin/python' -e '^#!/usr/bin/env python' -r .) | sort -u )
+    echo "Analyzing $# Python scripts"
 fi
 
 # Assign each ignore warning on a line, in order to ease testing enabling the warning again
-- 
2.20.1

