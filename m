Return-Path: <SRS0=+qLe=O6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E3C43387
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E9F21906
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390464AbeLUUns (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:43:48 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:36008 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388627AbeLUUns (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Dec 2018 15:43:48 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C0E46561205
        for <selinux@vger.kernel.org>; Fri, 21 Dec 2018 21:43:45 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/4] python/sepolgen: close /etc/selinux/sepolgen.conf after parsing it
Date:   Fri, 21 Dec 2018 21:43:30 +0100
Message-Id: <20181221204333.27445-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Dec 21 21:43:46 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

sepolgen testsuite reports the following warning on a system with
/etc/selinux/sepolgen.conf:

    .../src/./sepolgen/defaults.py:35: ResourceWarning: unclosed file
    <_io.TextIOWrapper name='/etc/selinux/sepolgen.conf' mode='r'
    encoding='UTF-8'>

Fix this by properly closing the file in PathChooser.__init__().

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolgen/src/sepolgen/defaults.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/defaults.py b/python/sepolgen/src/sepolgen/defaults.py
index 199acfafe4cf..533a90412475 100644
--- a/python/sepolgen/src/sepolgen/defaults.py
+++ b/python/sepolgen/src/sepolgen/defaults.py
@@ -32,12 +32,13 @@ class PathChooser(object):
         self.config_pathname = pathname
         ignore = re.compile(r"^\s*(?:#.+)?$")
         consider = re.compile(r"^\s*(\w+)\s*=\s*(.+?)\s*$")
-        for lineno, line in enumerate(open(pathname)):
-            if ignore.match(line): continue
-            mo = consider.match(line)
-            if not mo:
-                raise ValueError("%s:%d: line is not in key = value format" % (pathname, lineno+1))
-            self.config[mo.group(1)] = mo.group(2)
+        with open(pathname, "r") as fd:
+            for lineno, line in enumerate(fd):
+                if ignore.match(line): continue
+                mo = consider.match(line)
+                if not mo:
+                    raise ValueError("%s:%d: line is not in key = value format" % (pathname, lineno+1))
+                self.config[mo.group(1)] = mo.group(2)
 
     # We're only exporting one useful function, so why not be a function
     def __call__(self, testfilename, pathset="SELINUX_DEVEL_PATH"):
-- 
2.19.1

