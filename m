Return-Path: <SRS0=WnGO=YL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFB6CA9EA4
	for <selinux@archiver.kernel.org>; Fri, 18 Oct 2019 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6115222C3
	for <selinux@archiver.kernel.org>; Fri, 18 Oct 2019 09:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ca9sdGNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390499AbfJRJUN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:20:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59808 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409648AbfJRJUN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Oct 2019 05:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571390411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rEkagaXKoXhnnnheNdzt9zMOPRjlnVD/zrbZPYiIXzY=;
        b=Ca9sdGNrp3e0OSAuofhDnN2cEXY/v9CmSDD3XE/oZz2oyl1mePCqpgDQ0X5uM3z3eDgMhW
        wgQPILurKYUDf5IZFV4OXfZxL9XcIKkbj8pITKGb6hy9HxwBOY1PI9BVBHUxvgLhwYP7ma
        TwLBv3uNLTS1TFjwEeXpDleTjz11Zyg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-IeBu5Q5cOsyWb9NlrZqoVw-1; Fri, 18 Oct 2019 05:20:10 -0400
Received: by mail-wr1-f69.google.com with SMTP id t11so2303807wro.10
        for <selinux@vger.kernel.org>; Fri, 18 Oct 2019 02:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cEOYskm/itwHlkRsONS5/D5rKRb2CYlz+zwdyMLpUBw=;
        b=KDCA6i04Wg/sSKbnjWStUc/bC4nC+VfP/tDUsNzMj+HD29c7dwp0Vr80X/8bycyoYU
         Jk4JhCQiEfImDUkv8u2jJsPOETVgd3s9MHLEEqh4biEs3zVPKPPT1luQLeSU7LfjsdsW
         fgfhYSzVCU580iuPsgVdi43vSO+qtVxERQOyNju0GPo5utV9vswUokUbrny7MZXIri1o
         JCEQ8j7LfoDL2Q3L6ymPbOTql/guJTOmL8SSSzG1m8b3iAYuDhgGEKlKKNZae+e4Hw3k
         e7MUXkzyIsLVx5UCiuFqYiEbNzPzHXScR1PviaDNS/ufuR7qOvspWxztHnbbif1WWcHe
         5emA==
X-Gm-Message-State: APjAAAXJ0j8vGxViSGM+6iIy4/VWmp4K4CVazYhZOL869bZoFB2+BbvU
        kamTq7TodyDqkcrsl0QaXjA1L4mEfj5HOYR9qN0OtykVEVh2UaTYgvVCY1NxjI3jOXUMHMbAwTr
        bEmJSkT7ajewkWSkysQ==
X-Received: by 2002:a05:600c:224c:: with SMTP id a12mr5541316wmm.19.1571390408512;
        Fri, 18 Oct 2019 02:20:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwdOXFohtJI4snc31e85wA4zvKUFeUMmZOtVHd5cmHorqe//KG/TeyjbMA8n0x6SpjJzSbjfA==
X-Received: by 2002:a05:600c:224c:: with SMTP id a12mr5541287wmm.19.1571390408216;
        Fri, 18 Oct 2019 02:20:08 -0700 (PDT)
Received: from localhost.localdomain.com (adsl-dyn123.78-98-13.t-com.sk. [78.98.13.123])
        by smtp.gmail.com with ESMTPSA id f143sm9275826wme.40.2019.10.18.02.20.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:20:07 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2] sepolicy: generate man pages in parallel
Date:   Fri, 18 Oct 2019 11:20:05 +0200
Message-Id: <20191018092005.3198-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: IeBu5Q5cOsyWb9NlrZqoVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Generating man pages takes a lot of time. Do it in parallel to speed up
the process.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 python/sepolicy/sepolicy.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

Changes in v2:
- use multiprocessing.Pool, which reacts better to interruption

diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index 1934cd86..7b223065 100755
--- a/python/sepolicy/sepolicy.py
+++ b/python/sepolicy/sepolicy.py
@@ -25,6 +25,7 @@ import os
 import sys
 import selinux
 import sepolicy
+from multiprocessing import Pool
 from sepolicy import get_os_version, get_conditionals, get_conditionals_fo=
rmat_text
 import argparse
 PROGNAME =3D "policycoreutils"
@@ -326,8 +327,13 @@ def gen_gui_args(parser):
     gui.set_defaults(func=3Dgui_run)
=20
=20
+def manpage_work(domain, path, root, source_files, web):
+    from sepolicy.manpage import ManPage
+    m =3D ManPage(domain, path, root, source_files, web)
+    print(m.get_man_page_path())
+
 def manpage(args):
-    from sepolicy.manpage import ManPage, HTMLManPages, manpage_domains, m=
anpage_roles, gen_domains
+    from sepolicy.manpage import HTMLManPages, manpage_domains, manpage_ro=
les, gen_domains
=20
     path =3D args.path
     if not args.policy and args.root !=3D "/":
@@ -340,9 +346,11 @@ def manpage(args):
     else:
         test_domains =3D args.domain
=20
+    p =3D Pool()
     for domain in test_domains:
-        m =3D ManPage(domain, path, args.root, args.source_files, args.web=
)
-        print(m.get_man_page_path())
+        p.apply_async(manpage_work, [domain, path, args.root, args.source_=
files, args.web])
+    p.close()
+    p.join()
=20
     if args.web:
         HTMLManPages(manpage_roles, manpage_domains, path, args.os)
--=20
2.21.0

