Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182EAC43217
	for <selinux@archiver.kernel.org>; Tue,  3 May 2022 15:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiECPjT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 May 2022 11:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbiECPjA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 May 2022 11:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 944BA286EF
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651592125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o0txM+GFG4iMUQB+eA6hS3snjLHf3Yl4GBkx7ebo+4k=;
        b=Cxi2vuRPYjRSVL5FS6xZcpi2XAjnjNqHISBQY6fdLK2O3qPOErYQEyKwQFOw/ru5xzq6A8
        pQtoV5KOPWqQmk6xwwGUPUGqwCsgNEjlzCkuqbGD7PRiLNiwWyxZjbEVQG0KWElZ58rq7K
        apD55RcqPcVQucHJKo/szSuXYcMt8iE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-wAfD7DMuPcCFmJo7hvTL2A-1; Tue, 03 May 2022 11:35:13 -0400
X-MC-Unique: wAfD7DMuPcCFmJo7hvTL2A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2953E29ABA2B
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 11:43:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC159401E0B
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 11:43:04 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] gui: Make sure sepolicy calls are translated properly
Date:   Tue,  3 May 2022 13:42:44 +0200
Message-Id: <20220503114244.39441-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The policy is generated using sepolicy.generate, but since its
translations are in a different translation domain (selinux-python as
opposed to selinux-gui), the confirmation dialog is not translated.

- Add selinux-python as a fallback translation domain
- Set the whole "generate()" confirmation as translatable
- Drop "codeset" parameter since it is deprecated

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 gui/polgengui.py                     | 7 +++++--
 python/sepolicy/sepolicy/generate.py | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/gui/polgengui.py b/gui/polgengui.py
index 01f541ba..dcd5df47 100644
--- a/gui/polgengui.py
+++ b/gui/polgengui.py
@@ -69,10 +69,13 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    t.install()
+    t.add_fallback(gettext.translation("selinux-python",
+                    localedir="/usr/share/locale",
+                    **kwargs))
 except:
     try:
         import builtins
diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index 43180ca6..42d52109 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -1372,7 +1372,7 @@ Warning %s does not exist
         fd.close()
 
     def generate(self, out_dir=os.getcwd()):
-        out = "Created the following files:\n"
+        out = _("Created the following files:\n")
         out += "%s # %s\n" % (self.write_te(out_dir), _("Type Enforcement file"))
         out += "%s # %s\n" % (self.write_if(out_dir), _("Interface file"))
         out += "%s # %s\n" % (self.write_fc(out_dir), _("File Contexts file"))
-- 
2.35.1

