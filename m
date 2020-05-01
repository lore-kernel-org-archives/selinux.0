Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A837C4724C
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 09:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6C72076D
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 09:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgEAJ3o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 05:29:44 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:34561 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgEAJ3n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 05:29:43 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8EB0A5649DF
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 11:29:41 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] scripts/env_use_destdir: propagate PREFIX, LIBDIR, BINDIR, etc.
Date:   Fri,  1 May 2020 11:29:29 +0200
Message-Id: <20200501092929.1162708-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501092929.1162708-1-nicolas.iooss@m4x.org>
References: <20200501092929.1162708-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri May  1 11:29:42 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On systems using non-default `PREFIX`, `LIBDIR`, `SHLIBDIR`, `BINDIR`
or `SBINDIR`, running
`DESTDIR=/path/to/destdir ./scripts/env_use_destdir make test`
does not perform the intended behavior, because the testing programs and
libraries are installed into locations that are not added to
`LD_LIBRARY_PATH` nor `PATH`.

More precisely, with `LIBDIR=/usr/lib64 SHLIBDIR=/lib64`, `env_use_destdir`
does not work. Fix this by adding the installation directories relative
to `DESTDIR` in `LD_LIBRARY_PATH` and `PATH`.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 scripts/env_use_destdir | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/env_use_destdir b/scripts/env_use_destdir
index 491da58f9207..8274013e9cf0 100755
--- a/scripts/env_use_destdir
+++ b/scripts/env_use_destdir
@@ -22,7 +22,26 @@ if [ -z "${DESTDIR:-}" ] ; then
 fi
 
 export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
+if [ -n "${PREFIX:-}" ] ; then
+    LD_LIBRARY_PATH="$DESTDIR$PREFIX/lib:$LD_LIBRARY_PATH"
+fi
+if [ -n "${LIBDIR:-}" ] ; then
+    LD_LIBRARY_PATH="$DESTDIR$LIBDIR:$LD_LIBRARY_PATH"
+fi
+if [ -n "${SHLIBDIR:-}" ] ; then
+    LD_LIBRARY_PATH="$DESTDIR$SHLIBDIR:$LD_LIBRARY_PATH"
+fi
+
 export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH"
+if [ -n "${PREFIX:-}" ] ; then
+    PATH="$DESTDIR$PREFIX/sbin:$DESTDIR$PREFIX/bin:$LD_LIBRARY_PATH"
+fi
+if [ -n "${BINDIR:-}" ] ; then
+    PATH="$DESTDIR$BINDIR:$PATH"
+fi
+if [ -n "${SBINDIR:-}" ] ; then
+    PATH="$DESTDIR$SBINDIR:$PATH"
+fi
 
 NEW_PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(plat_specific=1, prefix='/usr'))"):$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
 if [ -n "${PYTHONPATH:-}" ] ; then
-- 
2.26.2

