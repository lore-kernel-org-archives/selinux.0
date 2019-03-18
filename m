Return-Path: <SRS0=cHrg=RV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758C2C43381
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 13:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3D72085A
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 13:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCRNjh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:39:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfCRNjh (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 18 Mar 2019 09:39:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AFA0C01DE1B
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2019 13:39:37 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-181.brq.redhat.com [10.40.204.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEE681001E6A;
        Mon, 18 Mar 2019 13:39:36 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2] gui: Install .desktop files to /usr/share/applications by default
Date:   Mon, 18 Mar 2019 14:39:25 +0100
Message-Id: <20190318133925.3387-1-plautrba@redhat.com>
In-Reply-To: <CAJfZ7==GdCtQGKNw_+Uvrhbx0=dqYfwKYMj0o-fLhUOWD+n--w@mail.gmail.com>
References: <CAJfZ7==GdCtQGKNw_+Uvrhbx0=dqYfwKYMj0o-fLhUOWD+n--w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 18 Mar 2019 13:39:37 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

/usr/share/applications is a standard directory for .desktop files.
Installation path can be changed using DESKTOPDIR variable in installation
phase, e.g.

make DESKTOPDIR=/usr/local/share/applications install

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 gui/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gui/Makefile b/gui/Makefile
index b2375fbf..ca965c94 100644
--- a/gui/Makefile
+++ b/gui/Makefile
@@ -5,6 +5,7 @@ BINDIR ?= $(PREFIX)/bin
 SHAREDIR ?= $(PREFIX)/share/system-config-selinux
 DATADIR ?= $(PREFIX)/share
 MANDIR ?= $(PREFIX)/share/man
+DESKTOPDIR ?= $(PREFIX)/share/applications
 
 TARGETS= \
 booleansPage.py \
@@ -29,6 +30,7 @@ install: all
 	-mkdir -p $(DESTDIR)$(DATADIR)/pixmaps
 	-mkdir -p $(DESTDIR)$(DATADIR)/icons/hicolor/24x24/apps
 	-mkdir -p $(DESTDIR)$(DATADIR)/polkit-1/actions/
+	-mkdir -p $(DESTDIR)$(DESKTOPDIR)
 	install -m 755 system-config-selinux.py $(DESTDIR)$(SHAREDIR)
 	install -m 755 system-config-selinux $(DESTDIR)$(BINDIR)
 	install -m 755 polgengui.py $(DESTDIR)$(BINDIR)/selinux-polgengui
@@ -44,7 +46,7 @@ install: all
 	install -m 644 system-config-selinux.png $(DESTDIR)$(DATADIR)/pixmaps
 	install -m 644 system-config-selinux.png $(DESTDIR)$(DATADIR)/icons/hicolor/24x24/apps
 	install -m 644 system-config-selinux.png $(DESTDIR)$(DATADIR)/system-config-selinux
-	install -m 644 *.desktop $(DESTDIR)$(DATADIR)/system-config-selinux
+	install -m 644 *.desktop $(DESTDIR)$(DESKTOPDIR)
 	-mkdir -p $(DESTDIR)$(DATADIR)/pixmaps
 	install -m 644 sepolicy_256.png $(DESTDIR)$(DATADIR)/pixmaps/sepolicy.png
 	for i in 16 22 32 48 256; do \
-- 
2.21.0

