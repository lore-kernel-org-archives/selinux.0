Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B06C4332F
	for <selinux@archiver.kernel.org>; Fri, 18 Nov 2022 12:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbiKRMy2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiKRMy1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Nov 2022 07:54:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C162AF9
        for <selinux@vger.kernel.org>; Fri, 18 Nov 2022 04:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668776005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eQp3raKZtxp1YusGOZv3gpep9FLCkOa03W8+QK0BcCs=;
        b=F8dkmvgreknHescA/6bMbf3zH7Yu3F2Sl5RwK6fwpgF+uREYy6ICLXiXcgCxCI/jS5VNAS
        1zCsVpToVzLU9NF+H2nSS++qgmAdLzXyRIYYs4E/I4k6YZdClwABBiVRUGTj6foJcs6A5z
        NOkXpdFgxyfyKK6FwCxsHmncYyVRoGc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-81CJT8QpPgKl4l5CWlZdNw-1; Fri, 18 Nov 2022 07:53:24 -0500
X-MC-Unique: 81CJT8QpPgKl4l5CWlZdNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B530F3850E86
        for <selinux@vger.kernel.org>; Fri, 18 Nov 2022 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-194-48.brq.redhat.com [10.40.194.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2076140C6EC3;
        Fri, 18 Nov 2022 12:53:22 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v3 1/3] python/sepolicy: Fix sepolicy manpage -w ...
Date:   Fri, 18 Nov 2022 13:51:52 +0100
Message-Id: <20221118125153.453700-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 7494bb1298b3 ("sepolicy: generate man pages in parallel")
improved sepolicy performance but broke `sepolicy manpage -w ...` as it
didn't collect data about domains and roles from ManPage() and so
HTMLManPages() generated only empty page. This is fixed now, domains
and roles are being collected and used for HTML pages.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---

- v3: improved the result loop, based on Ondrej Mosnacek <omosnace@redhat.com>'s suggestion


 python/sepolicy/sepolicy.py         | 13 +++++++++++--
 python/sepolicy/sepolicy/manpage.py | 12 +++++-------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index 733d40484709..82ff6af2bc2d 100755
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
+    for result in async_results:
+        domains, roles = result.get()
+        manpage_domains.update(domains)
+        manpage_roles.update(roles)
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

