Return-Path: <SRS0=gfEM=YH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C537FC4CECE
	for <selinux@archiver.kernel.org>; Mon, 14 Oct 2019 08:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E562054F
	for <selinux@archiver.kernel.org>; Mon, 14 Oct 2019 08:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7QIOuu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfJNIG5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:06:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36654 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725934AbfJNIG5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Oct 2019 04:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571040416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tmiFdkZ9lJtSvRVSby+4gbn8htChwN1YPSW0hA5BNLk=;
        b=M7QIOuu7xh7M+lS+oyVBe//MppsOCbVZGV8AAmN//TfKAHjZbbiAJhB87RQEArEYqlJO8+
        w6v49KNO0vvLtnOiSw6X4X0d56L0SUgEUgidQf1cVd00mAAlg6l58uFEtT+metTTKPf1I6
        2wWER0MN535WLQOXsN1T3zVY3PSTY68=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-LHYe_mauPeiqDmCD4qeYGw-1; Mon, 14 Oct 2019 04:06:52 -0400
Received: by mail-wr1-f70.google.com with SMTP id w2so8194504wrn.4
        for <selinux@vger.kernel.org>; Mon, 14 Oct 2019 01:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=weoPf8V32eoQfWf0fi8raIVupdNas4XZvwJjZ3KvUHA=;
        b=KhFu1BePXzdlIdgI35D8/p5xjwRyESL6J8OeQ/7nY28/FiaN8hXtHFsvFxCqknS0nO
         PZJpV6BB/yIMuzWomlkXaSKWWYn13g/Vh7LC+EzyGl1wkIwnPbDETnd+sOWe4SxqbGru
         WDd0yBsyc4B3tPqd+MdkgSEXdxSiAvfELzspGWF4jm6jJMIumFNI7F77DzvGwGbYunlc
         DtESEz/fKjfR3D+VdXAn6EE+xCuwCvjGrwqSI/GNldEg1wtte543k3v4lChuQ7YrTjrs
         wWSSVl/QzqXdp8Xi1c/7zUdLR0HpsJUoOachpVpSmCcb6usa6vWtRN6FoMElabRay89S
         DsGw==
X-Gm-Message-State: APjAAAUukNIhzZOKI+0pKE/5CMayk7U9R/KMTeBDq0OoPyp4v9qCtjoy
        F5VzYWLAbFRFlsYPK7KzBbN5zwD4fcn9C3BuvwnwineyrMo5rajV1J8jH/jREIudVJ511TTtuPP
        7Z0kqnFoae08dsViNtg==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr13694080wmc.104.1571040410824;
        Mon, 14 Oct 2019 01:06:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx9gWTHQTj0pLlvzeH/OI98fOPbcYYDiaan4FaN+t95SrKF2tjvBLDfcxHAK2RSoLxcbQujnw==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr13694062wmc.104.1571040410593;
        Mon, 14 Oct 2019 01:06:50 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t203sm20351114wmf.42.2019.10.14.01.06.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 01:06:49 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] sepolicy: generate man pages in parallel
Date:   Mon, 14 Oct 2019 10:06:47 +0200
Message-Id: <20191014080647.19602-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: LHYe_mauPeiqDmCD4qeYGw-1
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
 python/sepolicy/sepolicy.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index 1934cd86..02094013 100755
--- a/python/sepolicy/sepolicy.py
+++ b/python/sepolicy/sepolicy.py
@@ -25,6 +25,7 @@ import os
 import sys
 import selinux
 import sepolicy
+from concurrent.futures import ProcessPoolExecutor
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
@@ -340,9 +346,9 @@ def manpage(args):
     else:
         test_domains =3D args.domain
=20
-    for domain in test_domains:
-        m =3D ManPage(domain, path, args.root, args.source_files, args.web=
)
-        print(m.get_man_page_path())
+    with ProcessPoolExecutor() as e:
+        for domain in test_domains:
+            e.submit(manpage_work, domain, path, args.root, args.source_fi=
les, args.web)
=20
     if args.web:
         HTMLManPages(manpage_roles, manpage_domains, path, args.os)
--=20
2.21.0

