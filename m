Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB800C61D97
	for <selinux@archiver.kernel.org>; Wed, 22 Nov 2023 11:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbjKVLbB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Nov 2023 06:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343646AbjKVLbA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Nov 2023 06:31:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9C5D8
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 03:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700652655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOCauNU+RS19oLNf6dJ8h9GtjmWQ4qBtFs8GG731cAw=;
        b=EcebyQBOHY82O6FMirnSELn5CY8LpDUfYnAZfEQVDu3nWiWaY9alrOLVKVpAdgSGGDDSSh
        0R8TfJK9llgVpXPe2iNVVvuFcMTA7Q721yjRrZ7rciFIj/A1+gAL6iK3cRzONaLv/UuPk9
        Akeei5huxtqVSbttaSYstCTbSNJx6wc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-DgHQAGJgMBq4ifoZCJ8ncQ-1; Wed,
 22 Nov 2023 06:30:52 -0500
X-MC-Unique: DgHQAGJgMBq4ifoZCJ8ncQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA2C63806624
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 11:30:50 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.45.226.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AF77C1596F;
        Wed, 22 Nov 2023 11:30:50 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2] sepolicy: port to dnf4 python API
Date:   Wed, 22 Nov 2023 12:29:43 +0100
Message-ID: <20231122112942.2832586-2-lautrbach@redhat.com>
In-Reply-To: <CAFqZXNt1vLh5YEM98UKqOQSxNP0=b7kBVA14921qk8n=J9HtYg@mail.gmail.com>
References: <CAFqZXNt1vLh5YEM98UKqOQSxNP0=b7kBVA14921qk8n=J9HtYg@mail.gmail.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

yum module is not available since RHEL 7.

Drop -systemd related code as it's obsoleted these days - only 2
packages ship their .service in -systemd subpackage

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---

v2: use with dnf.Base() as base:  suggested by Ondrej Mosnacek <omosnace@redhat.com>

 python/sepolicy/sepolicy/generate.py | 56 +++++++++++++---------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index b6df3e91160b..adf65f27a822 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -1262,24 +1262,20 @@ allow %s_t %s_t:%s_socket name_%s;
         return fcfile
 
     def __extract_rpms(self):
-        import yum
-        yb = yum.YumBase()
-        yb.setCacheDir()
-
-        for pkg in yb.rpmdb.searchProvides(self.program):
-            self.rpms.append(pkg.name)
-            for fname in pkg.dirlist + pkg.filelist + pkg.ghostlist:
-                for b in self.DEFAULT_DIRS:
-                    if b == "/etc":
-                        continue
-                    if fname.startswith(b):
-                        if os.path.isfile(fname):
-                            self.add_file(fname)
-                        else:
-                            self.add_dir(fname)
+        import dnf
+
+        with dnf.Base() as base:
+            base.read_all_repos()
+            base.fill_sack(load_system_repo=True)
+
+            query = base.sack.query()
 
-            for bpkg in yb.rpmdb.searchNames([pkg.base_package_name]):
-                for fname in bpkg.dirlist + bpkg.filelist + bpkg.ghostlist:
+            pq = query.available()
+            pq = pq.filter(file=self.program)
+
+            for pkg in pq:
+                self.rpms.append(pkg.name)
+                for fname in pkg.files:
                     for b in self.DEFAULT_DIRS:
                         if b == "/etc":
                             continue
@@ -1288,20 +1284,18 @@ allow %s_t %s_t:%s_socket name_%s;
                                 self.add_file(fname)
                             else:
                                 self.add_dir(fname)
-
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
+                sq = query.available()
+                sq = sq.filter(provides=pkg.source_name)
+                for bpkg in sq:
+                    for fname in bpkg.files:
+                        for b in self.DEFAULT_DIRS:
+                            if b == "/etc":
+                                continue
+                            if fname.startswith(b):
+                                if os.path.isfile(fname):
+                                    self.add_file(fname)
+                                else:
+                                    self.add_dir(fname)
 
     def gen_writeable(self):
         try:
-- 
2.41.0

