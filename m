Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C3C43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 10:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA50218AE
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 10:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfCUKNu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:13:50 -0400
Received: from ithil.bigon.be ([163.172.57.153]:43284 "EHLO ithil.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbfCUKNu (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Mar 2019 06:13:50 -0400
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Mar 2019 06:13:49 EDT
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id CAF0D1FC7C
        for <selinux@vger.kernel.org>; Thu, 21 Mar 2019 11:04:41 +0100 (CET)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id OA-Ox-obyHjo for <selinux@vger.kernel.org>;
        Thu, 21 Mar 2019 11:04:41 +0100 (CET)
Received: from edoras.bigon.be (mail2.vdab.be [193.53.238.200])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA
        for <selinux@vger.kernel.org>; Thu, 21 Mar 2019 11:04:41 +0100 (CET)
Received: from bigon (uid 1000)
        (envelope-from bigon@bigon.be)
        id 6308f
        by edoras.bigon.be (DragonFly Mail Agent v0.11);
        Thu, 21 Mar 2019 11:04:39 +0100
From:   Laurent Bigonville <bigon@debian.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] restorecond: Do not link against libpcre
Date:   Thu, 21 Mar 2019 11:04:39 +0100
Message-Id: <20190321100439.7130-1-bigon@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Laurent Bigonville <bigon@bigon.be>

For some reasons, restorecond was explicitly linking against libpcre but
the code is not using any of its symbols

Closes: https://github.com/SELinuxProject/selinux/issues/137

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 restorecond/Makefile | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/restorecond/Makefile b/restorecond/Makefile
index b81f8c82..12452cd2 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -19,17 +19,7 @@ DBUSLIB = $(shell $(PKG_CONFIG) --libs dbus-glib-1)
 CFLAGS ?= -g -Werror -Wall -W
 override CFLAGS += $(DBUSFLAGS)
 
-USE_PCRE2 ?= n
-ifeq ($(USE_PCRE2),y)
-	PCRE_CFLAGS := -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 $(shell $(PKG_CONFIG) --cflags libpcre2-8)
-	PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre2-8)
-else
-	PCRE_CFLAGS := $(shell $(PKG_CONFIG) --cflags libpcre)
-	PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre)
-endif
-export PCRE_CFLAGS PCRE_LDLIBS
-
-override LDLIBS += -lselinux $(PCRE_LDLIBS) $(DBUSLIB)
+override LDLIBS += -lselinux $(DBUSLIB)
 
 all: restorecond
 
-- 
2.20.1

