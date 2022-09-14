Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0846C6FA82
	for <selinux@archiver.kernel.org>; Wed, 14 Sep 2022 22:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiINWDz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Sep 2022 18:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiINWDx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Sep 2022 18:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1BA61139
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 15:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663193030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QrDAJb42L0yTHnxYSDiRpEwjx1nNLlxa13N2/OnQ3wg=;
        b=BImHpuLLMJX2pcf6WIMyDa0Nzd5eVv/Vw/H+VWJkP7oXCeoj+QllgOnCW4oG1seKZ+BpbU
        iSsWVvRep6qXvxKzsTeEQSZ8uRH2NW0Ect2clhj9Vi+3KcA/D6U9SlAtayOPUKF5yuFZh5
        tqi/sI/hGiYRBO+dJdauSOyTDBQWwPw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-LeRPDvbzPr6mj92V0vlTAg-1; Wed, 14 Sep 2022 18:03:48 -0400
X-MC-Unique: LeRPDvbzPr6mj92V0vlTAg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E1B0294EDEF
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 22:03:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD18747505E
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 22:03:47 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python: Hide error message when modifying non-local fcontext
Date:   Thu, 15 Sep 2022 00:03:37 +0200
Message-Id: <20220914220337.165813-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes:
  # semanage fcontext -f f -m -t passwd_file_t /etc/security/opasswd
  libsemanage.dbase_llist_query: could not query record value (No such file or directory).

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 0782c082..2d52f53c 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -177,6 +177,22 @@ except (OSError, ImportError):
             for l in self.log_list:
                 syslog.syslog(syslog.LOG_INFO, message + l)
 
+# Define a context manager to suppress stderr.
+class suppress_stderr(object):
+    def __init__(self):
+        # Open a /dev/null file to be used as stderr
+        self.null =  os.open(os.devnull,os.O_RDWR)
+        self.save_fd = os.dup(2)
+
+    def __enter__(self):
+        # Set stderr to the null file
+        os.dup2(self.null,2)
+
+    def __exit__(self, *_):
+        # Restore stderr
+        os.dup2(self.save_fd,2)
+        os.close(self.null)
+
 
 class nulllogger:
 
@@ -2510,7 +2526,8 @@ class fcontextRecords(semanageRecords):
                 raise ValueError(_("File context for %s is not defined") % target)
 
         try:
-            (rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
+            with suppress_stderr():
+                (rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
         except OSError:
             try:
                 (rc, fcontext) = semanage_fcontext_query(self.sh, k)
-- 
2.35.3

