Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE50C43219
	for <selinux@archiver.kernel.org>; Tue, 15 Nov 2022 19:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiKOTrG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiKOTrC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Nov 2022 14:47:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2C711C15
        for <selinux@vger.kernel.org>; Tue, 15 Nov 2022 11:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668541560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/hhVm+1kQrr6wMDW9q/3qFYlNPpyRaBGpD06r8nbebA=;
        b=DoceKzdfQJkSdbb72tf9E5Ylvjo/Q3ux3E9CG6gi53v5hJ5yG54/IetQMQlR/bC2MBRkWN
        /NEHgbwE5qj1RcnPKS4MPy9Pn141B2uUV0fna5KNWZvCFyiaIk05N1CDRFsNVZUZQ9l68F
        QaP3LbT35SoQDGXAfB0EVughmdE3z9A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-q8FM_wW1NgWNxvPK71tfbg-1; Tue, 15 Nov 2022 14:45:58 -0500
X-MC-Unique: q8FM_wW1NgWNxvPK71tfbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 123DF185A78B
        for <selinux@vger.kernel.org>; Tue, 15 Nov 2022 19:45:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-195-4.brq.redhat.com [10.40.195.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62BAA112131E;
        Tue, 15 Nov 2022 19:45:57 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2 1/3] python/sepolicy: Fix sepolicy manpage -w ...
Date:   Tue, 15 Nov 2022 20:45:50 +0100
Message-Id: <20221115194552.338640-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Petr Lautrbach <lautrbach@redhat.com>

Commit 7494bb1298b3 ("sepolicy: generate man pages in parallel")
improved sepolicy performance but broke `sepolicy manpage -w ...` as it
didn't collect data about domains and roles from ManPage() and so
HTMLManPages() generated only empty page. This is fixed now, domains
and roles are being collected and used for HTML pages.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/sepolicy/sepolicy.py         | 13 +++++++++++--
 python/sepolicy/sepolicy/manpage.py | 12 +++++-------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index 733d40484709..2ca02ee9a0cf 100755
--- a/python/sepolicy/sepolicy.py
+++ b/python/sepolicy/sepolicy.py
@@ -332,9 +332,10 @@ def manpage_work(domain, path, root, source_files, web):
     from sepolicy.manpage import ManPage
     m = ManPage(domain, path, root, source_files, web)
     print(m.get_man_page_path())
+    return (m.manpage_domains, m.manpage_roles)
 
 def manpage(args):
-    from sepolicy.manpage import HTMLManPages, manpage_domains, manpage_roles, gen_domains
+    from sepolicy.manpage import HTMLManPages, gen_domains
 
     path = args.path
     if not args.policy and args.root != "/":
@@ -347,9 +348,17 @@ def manpage(args):
     else:
         test_domains = args.domain
 
+    manpage_domains = set()
+    manpage_roles = set()
     p = Pool()
+    async_results = []
     for domain in test_domains:
-        p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web])
+        async_results.append(p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web]))
+    results = map(lambda x: x.get(), async_results)
+    for result in results:
+        manpage_domains.update(set(result[0]))
+        manpage_roles.update(set(result[1]))
+
     p.close()
     p.join()
 
diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 3e61e333193f..de72cb6cda5f 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -21,7 +21,7 @@
 #                                        02111-1307  USA
 #
 #
-__all__ = ['ManPage', 'HTMLManPages', 'manpage_domains', 'manpage_roles', 'gen_domains']
+__all__ = ['ManPage', 'HTMLManPages', 'gen_domains']
 
 import string
 import selinux
@@ -147,10 +147,6 @@ def _gen_types():
 def prettyprint(f, trim):
     return " ".join(f[:-len(trim)].split("_"))
 
-# for HTML man pages
-manpage_domains = []
-manpage_roles = []
-
 fedora_releases = ["Fedora17", "Fedora18"]
 rhel_releases = ["RHEL6", "RHEL7"]
 
@@ -408,6 +404,8 @@ class ManPage:
     """
     modules_dict = None
     enabled_str = ["Disabled", "Enabled"]
+    manpage_domains = []
+    manpage_roles = []
 
     def __init__(self, domainname, path="/tmp", root="/", source_files=False, html=False):
         self.html = html
@@ -453,10 +451,10 @@ class ManPage:
         if self.domainname + "_r" in self.all_roles:
             self.__gen_user_man_page()
             if self.html:
-                manpage_roles.append(self.man_page_path)
+                self.manpage_roles.append(self.man_page_path)
         else:
             if self.html:
-                manpage_domains.append(self.man_page_path)
+                self.manpage_domains.append(self.man_page_path)
             self.__gen_man_page()
         self.fd.close()
 
-- 
2.38.1

