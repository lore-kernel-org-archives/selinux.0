Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28845C433DB
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 16:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D402E22C9D
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 16:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbhAEQB5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:01:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbhAEQB4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Jan 2021 11:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609862430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w6jE4UUJBjyJ60aw3QE12PMwNPh9iX2AVphGgNAwpTU=;
        b=PpkdTpGGZKiEjyLRxb9jy+dGSntjhaM7w4DyLDS9RvlXmXWYL/VWQTKIxWW60GN3ivOclj
        yeo/HmF94x5z3E0ciUM5+H33HPwyhSGYkySKOEYV7uGMKYaM1PjPOCUeeHmxzi7kvWHJgE
        3hXErhNJ7981+ZjDzKOGIrz3cHc6nlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-MOePE6uQPQ-W5-bV1HvZng-1; Tue, 05 Jan 2021 11:00:28 -0500
X-MC-Unique: MOePE6uQPQ-W5-bV1HvZng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B481C7408
        for <selinux@vger.kernel.org>; Tue,  5 Jan 2021 16:00:27 +0000 (UTC)
Received: from thinkpad-work.redhat.com (unknown [10.40.192.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B1BC71C91
        for <selinux@vger.kernel.org>; Tue,  5 Jan 2021 16:00:26 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/semanage: empty stdout before exiting on BrokenPipeError
Date:   Tue,  5 Jan 2021 17:00:21 +0100
Message-Id: <20210105160021.160108-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Empty stdout buffer before exiting when BrokenPipeError is
encountered. Otherwise python will flush the bufer during exit, which
may trigger the exception again.
https://docs.python.org/3/library/signal.html#note-on-sigpipe

Fixes:
   #semanage fcontext -l | egrep -q -e '^/home'
   BrokenPipeError: [Errno 32] Broken pipe
   Exception ignored in: <_io.TextIOWrapper name='<stdout>' mode='w' encoding='UTF-8'>
   BrokenPipeError: [Errno 32] Broken pipe

Note that the error above only appears occasionally (usually only the
first line is printed).

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/semanage | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index b2fabea6..ce15983b 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -27,6 +27,7 @@ import traceback
 import argparse
 import seobject
 import sys
+import os
 PROGNAME = "policycoreutils"
 try:
     import gettext
@@ -945,6 +946,13 @@ def do_parser():
         args = commandParser.parse_args(make_args(sys.argv))
         args.func(args)
         sys.exit(0)
+    except BrokenPipeError as e:
+        sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
+        # Python flushes standard streams on exit; redirect remaining output
+        # to devnull to avoid another BrokenPipeError at shutdown
+        devnull = os.open(os.devnull, os.O_WRONLY)
+        os.dup2(devnull, sys.stdout.fileno())
+        sys.exit(1)
     except IOError as e:
         sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
         sys.exit(1)
-- 
2.29.2

