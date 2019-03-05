Return-Path: <SRS0=RVlB=RI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8B5C43381
	for <selinux@archiver.kernel.org>; Tue,  5 Mar 2019 16:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1186D2064A
	for <selinux@archiver.kernel.org>; Tue,  5 Mar 2019 16:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfCEQjW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:39:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfCEQjW (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 5 Mar 2019 11:39:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96ADEC04FFF9
        for <selinux@vger.kernel.org>; Tue,  5 Mar 2019 16:39:22 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-204.brq.redhat.com [10.40.204.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D15615D732;
        Tue,  5 Mar 2019 16:39:21 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 2/2] gui: Install .desktop files to /usr/share/applications by default
Date:   Tue,  5 Mar 2019 17:38:57 +0100
Message-Id: <20190305163856.395-2-plautrba@redhat.com>
In-Reply-To: <20190305163856.395-1-plautrba@redhat.com>
References: <pjdimx5l481.fsf@redhat.com>
 <20190305163856.395-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 05 Mar 2019 16:39:22 +0000 (UTC)
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
 gui/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gui/Makefile b/gui/Makefile
index b2375fbf..5e64c3a1 100644
--- a/gui/Makefile
+++ b/gui/Makefile
@@ -5,6 +5,7 @@ BINDIR ?= $(PREFIX)/bin
 SHAREDIR ?= $(PREFIX)/share/system-config-selinux
 DATADIR ?= $(PREFIX)/share
 MANDIR ?= $(PREFIX)/share/man
+DESKTOPDIR ?= $(PREFIX)/share/applications
 
 TARGETS= \
 booleansPage.py \
@@ -44,7 +45,7 @@ install: all
 	install -m 644 system-config-selinux.png $(DESTDIR)$(DATADIR)/pixmaps
 	install -m 644 system-config-selinux.png $(DESTDIR)$(DATADIR)/icons/hicolor/24x24/apps
 	install -m 644 system-config-selinux.png $(DESTDIR)$(DATADIR)/system-config-selinux
-	install -m 644 *.desktop $(DESTDIR)$(DATADIR)/system-config-selinux
+	install -m 644 *.desktop $(DESTDIR)$(DESKTOPDIR)
 	-mkdir -p $(DESTDIR)$(DATADIR)/pixmaps
 	install -m 644 sepolicy_256.png $(DESTDIR)$(DATADIR)/pixmaps/sepolicy.png
 	for i in 16 22 32 48 256; do \
-- 
2.20.1

