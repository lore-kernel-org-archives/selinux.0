Return-Path: <SRS0=8S61=Y2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576BDCA9EC7
	for <selinux@archiver.kernel.org>; Sat,  2 Nov 2019 17:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28865217D9
	for <selinux@archiver.kernel.org>; Sat,  2 Nov 2019 17:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfKBR2j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Nov 2019 13:28:39 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:35601 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfKBR2j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 2 Nov 2019 13:28:39 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 536F15648A9
        for <selinux@vger.kernel.org>; Sat,  2 Nov 2019 18:28:37 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/4] libselinux: compile Python bytecode when installing Python files
Date:   Sat,  2 Nov 2019 18:28:09 +0100
Message-Id: <20191102172812.22492-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Nov  2 18:28:37 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When selinux module is imported from a Python script, the content of
__init__.py is compiled into bytecode and the result is saved into a
file if it is allowed. For example, when root runs with Python 3.7 a
script that uses "import selinux" on a system where SELinux is in
permissive mode, this file may be created:

    /usr/lib/python3.7/site-packages/selinux/__pycache__/__init__.cpython-37.pyc

Prevent this file from being dynamically created by creating it when
libselinux is installed, using "python -m compileall".

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 3b8bad810de0..349f957355c1 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -176,6 +176,7 @@ install-pywrap: pywrap
 	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
 	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
+	$(PYTHON) -m compileall $(DESTDIR)$(PYTHONLIBDIR)/selinux
 
 install-rubywrap: rubywrap
 	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYINSTALL) 
-- 
2.23.0

