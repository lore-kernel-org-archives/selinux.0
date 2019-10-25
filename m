Return-Path: <SRS0=OQXi=YS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92723CA9EA0
	for <selinux@archiver.kernel.org>; Fri, 25 Oct 2019 13:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7255421872
	for <selinux@archiver.kernel.org>; Fri, 25 Oct 2019 13:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504844AbfJYNmE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:42:04 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:58899 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfJYNly (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Oct 2019 09:41:54 -0400
Received: from localhost (static-css-ccs-204145.business.bouyguestelecom.com [176.157.204.145])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9B3FC24000C;
        Fri, 25 Oct 2019 13:41:51 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     selinux@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH libselinux] libselinux/src/Makefile: don't pass bogus -I and -L to python setup.py build_ext
Date:   Fri, 25 Oct 2019 15:41:49 +0200
Message-Id: <20191025134149.12518-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Using $(DESTDIR) during the build does not follow the normal/standard
semantic of DESTDIR: it is normally only needed during the
installation. Therefore, a lot of build systems/environments don't
pass any DESTDIR at build time, which causes setup.py to be called
with -I /usr/include -L /usr/lib, which breaks cross-compilation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 2b1696a0..3b8bad81 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -130,7 +130,7 @@ SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
 all: $(LIBA) $(LIBSO) $(LIBPC)
 
 pywrap: all selinuxswig_python_exception.i
-	CFLAGS="$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext -I $(DESTDIR)$(INCLUDEDIR) -L $(DESTDIR)$(LIBDIR)
+	CFLAGS="$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
 
 rubywrap: all $(SWIGRUBYSO)
 
-- 
2.21.0

