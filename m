Return-Path: <SRS0=MvMz=PN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2D3C43387
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 15:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18722085A
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 15:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAEPqY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Jan 2019 10:46:24 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:50650 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAEPqY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Jan 2019 10:46:24 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id DFC16561202
        for <selinux@vger.kernel.org>; Sat,  5 Jan 2019 16:46:21 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] python/sepolgen: close /etc/selinux/sepolgen.conf after parsing it
Date:   Sat,  5 Jan 2019 16:45:51 +0100
Message-Id: <20190105154551.18768-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105154551.18768-1-nicolas.iooss@m4x.org>
References: <20190105154551.18768-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  5 16:46:22 2019 +0100 (CET))
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
2.20.1

