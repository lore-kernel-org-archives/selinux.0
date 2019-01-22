Return-Path: <SRS0=5TXQ=P6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE92C282C3
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 11:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739BE20870
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 11:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfAVLuS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:50:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfAVLuS (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 22 Jan 2019 06:50:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03CC189ACC
        for <selinux@vger.kernel.org>; Tue, 22 Jan 2019 11:50:18 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 474CA6013C;
        Tue, 22 Jan 2019 11:50:17 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] restorecond: Install DBUS service file with 644 permissions
Date:   Tue, 22 Jan 2019 12:47:24 +0100
Message-Id: <20190122114724.1766-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 22 Jan 2019 11:50:18 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The original 600 permissions make the service file unreadable for dbus daemon.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1626462

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 restorecond/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/restorecond/Makefile b/restorecond/Makefile
index 8a0ada1f..6155ca4a 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -50,7 +50,7 @@ install: all
 	-mkdir -p $(DESTDIR)$(AUTOSTARTDIR)
 	install -m 644 restorecond.desktop $(DESTDIR)$(AUTOSTARTDIR)/restorecond.desktop
 	-mkdir -p $(DESTDIR)$(DBUSSERVICEDIR)
-	install -m 600 org.selinux.Restorecond.service  $(DESTDIR)$(DBUSSERVICEDIR)/org.selinux.Restorecond.service
+	install -m 644 org.selinux.Restorecond.service  $(DESTDIR)$(DBUSSERVICEDIR)/org.selinux.Restorecond.service
 	-mkdir -p $(DESTDIR)$(SYSTEMDDIR)/system
 	install -m 644 restorecond.service $(DESTDIR)$(SYSTEMDDIR)/system/
 relabel: install
-- 
2.20.1

