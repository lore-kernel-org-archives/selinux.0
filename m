Return-Path: <SRS0=Gc5K=6Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9CFC54E4B
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 11:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4AC20736
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 11:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnFMD4YP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgEKLXU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 May 2020 07:23:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48704 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728531AbgEKLXU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 May 2020 07:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589196199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LzL/3q02rl3llN1Sxw4wl++fx8r0VTmaj95ohnnF8J0=;
        b=MnFMD4YPT3SqfAtVQkL7Fxvz92mTEE3sXFtJy430SjzF8cdtrQgm+sTy/pWneCyz19Yj2Z
        tdiJCih1cedCVhG09V3eGuJ7JkzMBIxkpkwSC1mi/uFR7TEC4FJTnL2ZAQlUiZ1uLZa269
        ECFWbHUgFQmiVnnA89CjWeo5eooBbAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-I0mH_qZLPFGLPd17Bw5Zpg-1; Mon, 11 May 2020 07:23:15 -0400
X-MC-Unique: I0mH_qZLPFGLPd17Bw5Zpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50C53835B40
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 11:23:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 819A49CB9;
        Mon, 11 May 2020 11:23:13 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] semanage/test-semanage.py: Return non-zero value when some of unittest tests fail
Date:   Mon, 11 May 2020 13:23:08 +0200
Message-Id: <20200511112308.23523-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Previously python/semanage/test-semanage.py returned 0 even when there was a
fail in some test and `make test` didn't indicate any problem.

Fixes:
    $ make test
    ...
    Ran 10 tests in 110.854s
    FAILED (failures=4)
    $ echo $?
    0

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/test-semanage.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/python/semanage/test-semanage.py b/python/semanage/test-semanage.py
index c8f6ec231fc2..d99e3fdaa211 100644
--- a/python/semanage/test-semanage.py
+++ b/python/semanage/test-semanage.py
@@ -233,7 +233,7 @@ def semanage_custom_suite(test_list):
 
 
 def semanage_run_test(suite):
-    unittest.TextTestRunner(verbosity=2).run(suite)
+    return unittest.TextTestRunner(verbosity=2).run(suite).wasSuccessful()
 
 
 class CheckTest(argparse.Action):
@@ -255,9 +255,9 @@ def semanage_args(args):
         for i in semanage_test_list:
             print(i)
     if args.all:
-        semanage_run_test(semanage_suite())
+        return semanage_run_test(semanage_suite())
     if args.test:
-        semanage_run_test(semanage_custom_suite(args.test))
+        return semanage_run_test(semanage_custom_suite(args.test))
 
 
 def gen_semanage_test_args(parser):
@@ -281,8 +281,10 @@ if __name__ == "__main__":
         gen_semanage_test_args(parser)
         try:
             args = parser.parse_args()
-            args.func(args)
-            sys.exit(0)
+            if args.func(args):
+                sys.exit(0)
+            else:
+                sys.exit(1)
         except ValueError as e:
             sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
             sys.exit(1)
-- 
2.26.2

