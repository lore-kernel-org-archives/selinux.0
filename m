Return-Path: <SRS0=8S61=Y2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D2BCA9ED0
	for <selinux@archiver.kernel.org>; Sat,  2 Nov 2019 17:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0CE217D9
	for <selinux@archiver.kernel.org>; Sat,  2 Nov 2019 17:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfKBR2n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Nov 2019 13:28:43 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:41434 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfKBR2m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 2 Nov 2019 13:28:42 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C77CF5648A9
        for <selinux@vger.kernel.org>; Sat,  2 Nov 2019 18:28:40 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/4] python: compile Python bytecode when installing Python files
Date:   Sat,  2 Nov 2019 18:28:11 +0100
Message-Id: <20191102172812.22492-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191102172812.22492-1-nicolas.iooss@m4x.org>
References: <20191102172812.22492-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Nov  2 18:28:41 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a cache directory such as
/usr/lib/python3.7/site-packages/sepolgen/__pycache__/ in order to
prevent it from being dynamically created when sepolgen module is
imported.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/semanage/Makefile              | 1 +
 python/sepolgen/src/sepolgen/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index 024e9640fed0..c6a16918360d 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -28,6 +28,7 @@ install: all
 	done
 	test -d $(DESTDIR)/$(PACKAGEDIR) || install -m 755 -d $(DESTDIR)/$(PACKAGEDIR)
 	install -m 644 seobject.py $(DESTDIR)/$(PACKAGEDIR)
+	$(PYTHON) -m compileall $(DESTDIR)/$(PACKAGEDIR)/seobject.py
 	-mkdir -p $(DESTDIR)$(BASHCOMPLETIONDIR)
 	install -m 644 $(BASHCOMPLETIONS) $(DESTDIR)$(BASHCOMPLETIONDIR)/semanage
 
diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
index cac8def7204e..95a9d41571e7 100644
--- a/python/sepolgen/src/sepolgen/Makefile
+++ b/python/sepolgen/src/sepolgen/Makefile
@@ -8,6 +8,7 @@ all:
 install: all
 	-mkdir -p $(DESTDIR)$(PACKAGEDIR)
 	install -m 644 *.py $(DESTDIR)$(PACKAGEDIR)
+	$(PYTHON) -m compileall $(DESTDIR)$(PACKAGEDIR)
 
 clean:
 	rm -f parser.out parsetab.py
-- 
2.23.0

