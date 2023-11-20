Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E39C5AD4C
	for <selinux@archiver.kernel.org>; Mon, 20 Nov 2023 16:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjKTQGE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Nov 2023 11:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjKTQGA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Nov 2023 11:06:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6552BF4
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 08:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700496355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=z8R5RUPNiaYQOwD0fz+h+99qfNvmwoDB5Tdy4ixrKeQ=;
        b=J5RM2811VuYYxtODbnm0lH46wwt1lyildjY/mjFmn3IRgLk6G1+2/vUvTdtohpQWwiatWh
        Iwa9sB+dGhenq2KacpVzog5smwi7zYuCzRc8TIMc43mFpozKf14IkIyTsUyNkGfzHEz6aI
        ZjH+1zB2Ixh6hoLQuruZ8A8BZiJVRfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-NRXfcJEcMGCoojGF_oEpEg-1; Mon, 20 Nov 2023 11:05:53 -0500
X-MC-Unique: NRXfcJEcMGCoojGF_oEpEg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8150B101A53B
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 16:05:53 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.45.226.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00DC5492BE0;
        Mon, 20 Nov 2023 16:05:52 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] sepolicy: port to dnf4 python API
Date:   Mon, 20 Nov 2023 17:05:48 +0100
Message-ID: <20231120160548.2341315-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

yum module is not available since RHEL 7.

Drop -systemd related code as it's obsoleted these days - only 2
packages ship their .service in -systemd subpackage

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/sepolicy/sepolicy/generate.py | 38 ++++++++++++----------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index b6df3e91160b..5aa71357f6a9 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -1262,13 +1262,20 @@ allow %s_t %s_t:%s_socket name_%s;
         return fcfile
 
     def __extract_rpms(self):
-        import yum
-        yb = yum.YumBase()
-        yb.setCacheDir()
+        import dnf
 
-        for pkg in yb.rpmdb.searchProvides(self.program):
+        base = dnf.Base()
+        base.read_all_repos()
+        base.fill_sack(load_system_repo=True)
+
+        query = base.sack.query()
+
+        pq = query.available()
+        pq = pq.filter(file=self.program)
+
+        for pkg in pq:
             self.rpms.append(pkg.name)
-            for fname in pkg.dirlist + pkg.filelist + pkg.ghostlist:
+            for fname in pkg.files:
                 for b in self.DEFAULT_DIRS:
                     if b == "/etc":
                         continue
@@ -1277,9 +1284,10 @@ allow %s_t %s_t:%s_socket name_%s;
                             self.add_file(fname)
                         else:
                             self.add_dir(fname)
-
-            for bpkg in yb.rpmdb.searchNames([pkg.base_package_name]):
-                for fname in bpkg.dirlist + bpkg.filelist + bpkg.ghostlist:
+            sq = query.available()
+            sq = sq.filter(provides=pkg.source_name)
+            for bpkg in sq:
+                for fname in bpkg.files:
                     for b in self.DEFAULT_DIRS:
                         if b == "/etc":
                             continue
@@ -1289,20 +1297,6 @@ allow %s_t %s_t:%s_socket name_%s;
                             else:
                                 self.add_dir(fname)
 
-        # some packages have own systemd subpackage
-        # tor-systemd for example
-        binary_name = self.program.split("/")[-1]
-        for bpkg in yb.rpmdb.searchNames(["%s-systemd" % binary_name]):
-            for fname in bpkg.filelist + bpkg.ghostlist + bpkg.dirlist:
-                for b in self.DEFAULT_DIRS:
-                    if b == "/etc":
-                        continue
-                    if fname.startswith(b):
-                        if os.path.isfile(fname):
-                            self.add_file(fname)
-                        else:
-                            self.add_dir(fname)
-
     def gen_writeable(self):
         try:
             self.__extract_rpms()
-- 
2.41.0

