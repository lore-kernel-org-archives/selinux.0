Return-Path: <SRS0=RVlB=RI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCEAC43381
	for <selinux@archiver.kernel.org>; Tue,  5 Mar 2019 16:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BBD2064A
	for <selinux@archiver.kernel.org>; Tue,  5 Mar 2019 16:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfCEQjB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:39:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCEQjB (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 5 Mar 2019 11:39:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C74A308125E
        for <selinux@vger.kernel.org>; Tue,  5 Mar 2019 16:39:01 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-204.brq.redhat.com [10.40.204.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 694905D783;
        Tue,  5 Mar 2019 16:39:00 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 1/2] gui: Install polgengui.py to /usr/bin/selinux-polgengui
Date:   Tue,  5 Mar 2019 17:38:55 +0100
Message-Id: <20190305163856.395-1-plautrba@redhat.com>
In-Reply-To: <pjdimx5l481.fsf@redhat.com>
References: <pjdimx5l481.fsf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 05 Mar 2019 16:39:01 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

polgengui.py is a standalone gui tool which should be in /usr/bin with other
tools.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 gui/Makefile       | 2 +-
 gui/modulesPage.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gui/Makefile b/gui/Makefile
index c2f982de..b2375fbf 100644
--- a/gui/Makefile
+++ b/gui/Makefile
@@ -31,7 +31,7 @@ install: all
 	-mkdir -p $(DESTDIR)$(DATADIR)/polkit-1/actions/
 	install -m 755 system-config-selinux.py $(DESTDIR)$(SHAREDIR)
 	install -m 755 system-config-selinux $(DESTDIR)$(BINDIR)
-	install -m 755 polgengui.py $(DESTDIR)$(SHAREDIR)
+	install -m 755 polgengui.py $(DESTDIR)$(BINDIR)/selinux-polgengui
 	install -m 644 $(TARGETS) $(DESTDIR)$(SHAREDIR)
 	install -m 644 system-config-selinux.8 $(DESTDIR)$(MANDIR)/man8
 	install -m 644 selinux-polgengui.8 $(DESTDIR)$(MANDIR)/man8
diff --git a/gui/modulesPage.py b/gui/modulesPage.py
index 34c5d9e3..cb856b2d 100644
--- a/gui/modulesPage.py
+++ b/gui/modulesPage.py
@@ -118,7 +118,7 @@ class modulesPage(semanagePage):
 
     def new_module(self, args):
         try:
-            Popen(["/usr/share/system-config-selinux/polgengui.py"])
+            Popen(["selinux-polgengui"])
         except ValueError as e:
             self.error(e.args[0])
 
-- 
2.20.1

