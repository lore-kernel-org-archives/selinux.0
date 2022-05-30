Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D96C433EF
	for <selinux@archiver.kernel.org>; Mon, 30 May 2022 12:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiE3MUj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 May 2022 08:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiE3MUj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 May 2022 08:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C84A6CF6F
        for <selinux@vger.kernel.org>; Mon, 30 May 2022 05:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653913237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XxhAPuj8a9B6AJHwMTiQ8h//Us3/GYAKRQLGbjEepho=;
        b=azidp7HkObMkxXJrrXy1i1ay0EEk7DyRi6rwRQuE2VNxqpGjtLj1cKQNXbfFV4d1Nn9bGL
        qYtgVf+wR1/JRECwxP7TVaSD2hiB8at6KKZ3RVcCXXx9sM5HKHFecGoRxc8dgpaLBqkuSr
        lnNTi8vr8VcbiNW0W3ApzoWreoEgkdk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-dyhQfix_MgW2KabIp7nIQw-1; Mon, 30 May 2022 08:20:36 -0400
X-MC-Unique: dyhQfix_MgW2KabIp7nIQw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BE9E185A794
        for <selinux@vger.kernel.org>; Mon, 30 May 2022 12:20:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E525492C3B
        for <selinux@vger.kernel.org>; Mon, 30 May 2022 12:20:35 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python: Split "semanage import" into two transactions
Date:   Mon, 30 May 2022 14:20:21 +0200
Message-Id: <20220530122021.3952270-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

First transaction applies all deletion operations, so that there are no
collisions when applying the rest of the changes.

Fixes:
  # semanage port -a -t http_cache_port_t -r s0 -p tcp 3024
  # semanage export | semanage import
  ValueError: Port tcp/3024 already defined

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/semanage | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 8f4e44a7..1d828128 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -852,10 +852,29 @@ def handleImport(args):
     trans = seobject.semanageRecords(args)
     trans.start()
 
+    deleteCommands = []
+    commands = []
+    # separate commands for deletion from the rest so they can be
+    # applied in a separate transaction
     for l in sys.stdin.readlines():
         if len(l.strip()) == 0:
             continue
+        if "-d" in l or "-D" in l:
+            deleteCommands.append(l)
+        else:
+            commands.append(l)
+
+    if deleteCommands:
+        importHelper(deleteCommands)
+        trans.finish()
+        trans.start()
+
+    importHelper(commands)
+    trans.finish()
 
+
+def importHelper(commands):
+    for l in commands:
         try:
             commandParser = createCommandParser()
             args = commandParser.parse_args(mkargv(l))
@@ -869,8 +888,6 @@ def handleImport(args):
         except KeyboardInterrupt:
             sys.exit(0)
 
-    trans.finish()
-
 
 def setupImportParser(subparsers):
     importParser = subparsers.add_parser('import', help=_('Import local customizations'))
-- 
2.35.1

