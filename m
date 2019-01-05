Return-Path: <SRS0=MvMz=PN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CF6C43387
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 19:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E45F222FE
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 19:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfAETiN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:38:13 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:44822 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfAETiM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Jan 2019 14:38:12 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id CE21C5647FA
        for <selinux@vger.kernel.org>; Sat,  5 Jan 2019 20:38:10 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/5] python/audit2allow: use local sepolgen-ifgen-attr-helper for tests
Date:   Sat,  5 Jan 2019 20:37:57 +0100
Message-Id: <20190105193759.3333-4-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105193759.3333-1-nicolas.iooss@m4x.org>
References: <20190105193759.3333-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  5 20:38:11 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Introduce option --attr-helper to sepolgen-ifgen to make it possible to
override /usr/bin/sepolgen-ifgen-attr-helper and use it in the testuite
in order to test the helper which has been compiled from the project
instead of the one installed on the system.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/audit2allow/sepolgen-ifgen      | 8 +++++---
 python/audit2allow/test_audit2allow.py | 5 ++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/python/audit2allow/sepolgen-ifgen b/python/audit2allow/sepolgen-ifgen
index e3f67d430647..c482f227193f 100644
--- a/python/audit2allow/sepolgen-ifgen
+++ b/python/audit2allow/sepolgen-ifgen
@@ -56,6 +56,8 @@ def parse_options():
                       help="print debuging output")
     parser.add_option("-d", "--debug", action="store_true", default=False,
                       help="extra debugging output")
+    parser.add_option("--attr-helper", default=ATTR_HELPER,
+                      help="path to sepolgen-ifgen-attr-helper")
     parser.add_option("--no_attrs", action="store_true", default=False,
                       help="do not retrieve attribute access from kernel policy")
     options, args = parser.parse_args()
@@ -77,7 +79,7 @@ def get_policy():
     return None
 
 
-def get_attrs(policy_path):
+def get_attrs(policy_path, attr_helper):
     try:
         if not policy_path:
             policy_path = get_policy()
@@ -93,7 +95,7 @@ def get_attrs(policy_path):
         return None
 
     fd = open("/dev/null", "w")
-    ret = subprocess.Popen([ATTR_HELPER, policy_path, outfile.name], stdout=fd).wait()
+    ret = subprocess.Popen([attr_helper, policy_path, outfile.name], stdout=fd).wait()
     fd.close()
     if ret != 0:
         sys.stderr.write("could not run attribute helper\n")
@@ -127,7 +129,7 @@ def main():
     # Get the attibutes from the binary
     attrs = None
     if not options.no_attrs:
-        attrs = get_attrs(options.policy_path)
+        attrs = get_attrs(options.policy_path, options.attr_helper)
         if attrs is None:
             return 1
 
diff --git a/python/audit2allow/test_audit2allow.py b/python/audit2allow/test_audit2allow.py
index 0320c6dd5c1b..87e5504ada47 100644
--- a/python/audit2allow/test_audit2allow.py
+++ b/python/audit2allow/test_audit2allow.py
@@ -28,7 +28,10 @@ class Audit2allowTests(unittest.TestCase):
         "Verify sepolgen-ifgen works"
         temp_directory = mkdtemp(suffix='audit2allow_test')
         output_file = os.path.join(temp_directory, 'interface_info')
-        p = Popen([sys.executable, './sepolgen-ifgen', '-p', 'test_dummy_policy', '-o', output_file], stdout=PIPE)
+        p = Popen([
+            sys.executable, './sepolgen-ifgen', '-p', 'test_dummy_policy', '-o', output_file,
+            '--attr-helper', './sepolgen-ifgen-attr-helper'
+            ], stdout=PIPE)
         out, err = p.communicate()
         if err:
             print(out, err)
-- 
2.20.1

