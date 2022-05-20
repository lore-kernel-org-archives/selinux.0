Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB88C433F5
	for <selinux@archiver.kernel.org>; Fri, 20 May 2022 13:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349552AbiETNAM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 May 2022 09:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349664AbiETNAL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 May 2022 09:00:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9020116ABC3
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:00:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c10so10741737edr.2
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPG+tzooQRmAqZc/WGMN9KebMeoMYYAO9CvqsBYs/hs=;
        b=BB7DYRCb0QVzHPaRcS7OPf0yUKOEzrFgWI4iC5dwjj+fBipGiuLCatbi7fLU5N5XJx
         zeA3A+FNGM0rFNIW0+rOLS4A/7IVsb5vZdLyDJyu4Ne5cNrLQNiA5flmDE9TyKH6qx7M
         k7qh1tqZYA1/tEpsOwkKrJxXFw95tbxvrCePQwPlPgU3+j3qq4kC3eTEBl79B+AH4Grj
         HL6cQnsYdbVyvLEJkfzfm9oPvyrcq1VBl31WxKNPEW2Gab9iAnNonZDUWtCiYp2gGMiy
         yf4TTVnUYmLWKizK0E+z6vx4M2+TyjqNIPFA42+uZmfOo8SGF2XOP6qJAnxApE8IX1CI
         lAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPG+tzooQRmAqZc/WGMN9KebMeoMYYAO9CvqsBYs/hs=;
        b=uLVCExhwmExHsKrnqRddHtcPP7oML15NTN+c+mbEpQuQ0R8kdCD7IRut/vSoXu549H
         YnQ6lUu6hcb7BgOEKGrfeWrVC89QLmM1w/sRbdcpkAWAKN5B4J2bYtYi5Vla4HAOJ2rx
         FMqcDMRJi/ZEg9SgWRJn5nX8yg4YQHbL1/e/Qeb9TT3JXWz9UfyYvGjCaz+QMLFo6+79
         Bv4wTqjT8Nl+DpCZm1vi2aRZaYojsCM4l4d0+Zv19RBzX9/RyfJej5sZav29frtu949E
         zNpHRjMtgaF1Nnex7u5kg6vp485S+YEqMUD3LZgyVSMtGSJCEZKAT0p26dKvF0ooHQ+a
         IUxg==
X-Gm-Message-State: AOAM531pHxrRie+ygo+D45o2MCM6mlxsb0FoP0BJT2U0TtIZIT+J6d2U
        eZtjlhuC4GF3pnoNBi/91OhfwjATswI=
X-Google-Smtp-Source: ABdhPJwgPMzElR/cvoK2ZHhj/A9ZUaKy8RcsktmYPN7WiMSkmi1tAjxdorRp52CzuOpQdf6YkleBIw==
X-Received: by 2002:a50:ec95:0:b0:42a:d359:a139 with SMTP id e21-20020a50ec95000000b0042ad359a139mr10845876edr.15.1653051608062;
        Fri, 20 May 2022 06:00:08 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-251-125.77.8.pool.telefonica.de. [77.8.251.125])
        by smtp.gmail.com with ESMTPSA id hy14-20020a1709068a6e00b006f3ef214e76sm3114060ejc.220.2022.05.20.06.00.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 06:00:07 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] Makefile: always include and link with DESTDIR
Date:   Fri, 20 May 2022 15:00:04 +0200
Message-Id: <20220520130004.9096-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The top level Makefile adds, if the environment variable DESTDIR is
defined, the according include and link directory to CFLAGS and LDFLAGS
to build all userspace tools against dependencies from this repository
and not the system.
If CFLAGS or LDFLAGS are specified by the user, e.g.

    DESTDIR=~/destdir CFLAGS=-Dfoo LDFLAGS=-Lbar make install

use the override directive to force adding DESTDIR paths to the user
specified CFLAGS or LDFLAGS.

Note that

    DESTDIR=~/destdir make CFLAGS=-Dfoo LDFLAGS=-Lbar install

does not work, since in sub-directories the internal make options take
precedence over the overridden environment variables in the top
Makefile.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 2ffba8e9..e05e924b 100644
--- a/Makefile
+++ b/Makefile
@@ -29,8 +29,8 @@ ifneq ($(DESTDIR),)
 	LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 	LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
-	CFLAGS += -I$(DESTDIR)$(PREFIX)/include
-	LDFLAGS += -L$(DESTDIR)$(PREFIX)/lib -L$(LIBDIR)
+	override CFLAGS += -I$(DESTDIR)$(PREFIX)/include
+	override LDFLAGS += -L$(DESTDIR)$(PREFIX)/lib -L$(LIBDIR)
 	export CFLAGS
 	export LDFLAGS
 	export LIBSEPOLA
-- 
2.36.1

