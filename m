Return-Path: <SRS0=0eMI=VM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9140C76195
	for <selinux@archiver.kernel.org>; Mon, 15 Jul 2019 14:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929A0206B8
	for <selinux@archiver.kernel.org>; Mon, 15 Jul 2019 14:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bigon.be header.i=@bigon.be header.b="UNamyArA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403938AbfGOOyI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:54:08 -0400
Received: from ithil.bigon.be ([163.172.57.153]:37766 "EHLO ithil.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392257AbfGOOyI (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 15 Jul 2019 10:54:08 -0400
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id 4B5D51FED2
        for <selinux@vger.kernel.org>; Mon, 15 Jul 2019 16:45:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigon.be; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=key2; t=
        1563201904; x=1565016305; bh=H8IX/WYTBKONYXNdPiADyQrZDwm5JC8MszW
        21VA2XrI=; b=UNamyArAm6QBtA3WGJnzzTQg1md2QJik/zaH73/zUw6UeglKCnn
        KT8XLujGGGAGGF2fXvnYsv3+bAvyOg4DGrAAnWg6y+uHSbWthUgI5aCLAo+SxpFM
        KL8hybCfqBcGNftMw3dFsPgCOOL9L+Cuqlbk08JDaH4dOX4Fyno82L/0=
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id OrnkPCeQnXAA for <selinux@vger.kernel.org>;
        Mon, 15 Jul 2019 16:45:04 +0200 (CEST)
Received: from edoras.bigon.be (mail2.vdab.be [193.53.238.200])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA
        for <selinux@vger.kernel.org>; Mon, 15 Jul 2019 16:45:04 +0200 (CEST)
Received: from bigon (uid 1000)
        (envelope-from bigon@bigon.be)
        id 640db
        by edoras.bigon.be (DragonFly Mail Agent v0.11);
        Mon, 15 Jul 2019 16:45:02 +0200
From:   Laurent Bigonville <bigon@debian.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] mcstrans: Move setrans.conf manpage to section 5
Date:   Mon, 15 Jul 2019 16:45:01 +0200
Message-Id: <20190715144502.30547-2-bigon@debian.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715144502.30547-1-bigon@debian.org>
References: <20190715144502.30547-1-bigon@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Laurent Bigonville <bigon@bigon.be>

Move setrans.conf manpage to section 5 as it describes the documentation
for "File formats and conventions"

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 mcstrans/man/Makefile                                    | 9 +++++++++
 .../man/{man8/setrans.conf.8 => man5/setrans.conf.5}     | 2 +-
 .../man/ru/{man8/setrans.conf.8 => man5/setrans.conf.5}  | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)
 rename mcstrans/man/{man8/setrans.conf.8 => man5/setrans.conf.5} (98%)
 rename mcstrans/man/ru/{man8/setrans.conf.8 => man5/setrans.conf.5} (98%)

diff --git a/mcstrans/man/Makefile b/mcstrans/man/Makefile
index 0f8d34fd..71713818 100644
--- a/mcstrans/man/Makefile
+++ b/mcstrans/man/Makefile
@@ -2,15 +2,23 @@
 LINGUAS ?= ru
 PREFIX ?= /usr
 MANDIR ?=  $(PREFIX)/share/man
+MAN5SUBDIR ?= man5
+MAN5DIR ?= $(MANDIR)/$(MAN5SUBDIR)
 MAN8SUBDIR ?= man8
 MAN8DIR ?= $(MANDIR)/$(MAN8SUBDIR)
 
 all:
 
 install: all
+	mkdir -p $(DESTDIR)$(MAN5DIR)
 	mkdir -p $(DESTDIR)$(MAN8DIR)
+	install -m 644 man5/*.5 $(DESTDIR)$(MAN5DIR)
 	install -m 644 man8/*.8 $(DESTDIR)$(MAN8DIR)
 	for lang in $(LINGUAS) ; do \
+		if [ -e $${lang}/man5 ] ; then \
+			mkdir -p $(DESTDIR)$(MANDIR)/$${lang}/$(MAN5SUBDIR) ; \
+			install -m 644 $${lang}/man5/*.5 $(DESTDIR)$(MANDIR)/$${lang}/$(MAN5SUBDIR) ; \
+		fi ; \
 		if [ -e $${lang}/man8 ] ; then \
 			mkdir -p $(DESTDIR)$(MANDIR)/$${lang}/$(MAN8SUBDIR) ; \
 			install -m 644 $${lang}/man8/*.8 $(DESTDIR)$(MANDIR)/$${lang}/$(MAN8SUBDIR) ; \
@@ -19,4 +27,5 @@ install: all
 
 clean:
 	-rm -f *~ \#*
+	-rm -f man5/*~ man5/\#*
 	-rm -f man8/*~ man8/\#*
diff --git a/mcstrans/man/man8/setrans.conf.8 b/mcstrans/man/man5/setrans.conf.5
similarity index 98%
rename from mcstrans/man/man8/setrans.conf.8
rename to mcstrans/man/man5/setrans.conf.5
index b7609921..4949a502 100644
--- a/mcstrans/man/man8/setrans.conf.8
+++ b/mcstrans/man/man5/setrans.conf.5
@@ -1,4 +1,4 @@
-.TH "setrans.conf" "8" "13 July 2010" "txtoth@gmail.com" "setrans.conf documentation"
+.TH "setrans.conf" "5" "13 July 2010" "txtoth@gmail.com" "setrans.conf documentation"
 .SH "NAME"
 setrans.conf \- translation configuration file for MCS/MLS SELinux systems
 
diff --git a/mcstrans/man/ru/man8/setrans.conf.8 b/mcstrans/man/ru/man5/setrans.conf.5
similarity index 98%
rename from mcstrans/man/ru/man8/setrans.conf.8
rename to mcstrans/man/ru/man5/setrans.conf.5
index 9141defe..724b206b 100644
--- a/mcstrans/man/ru/man8/setrans.conf.8
+++ b/mcstrans/man/ru/man5/setrans.conf.5
@@ -1,4 +1,4 @@
-.TH "setrans.conf" "8" "13 июля 2010" "txtoth@gmail.com" "Документация по setrans.conf"
+.TH "setrans.conf" "5" "13 июля 2010" "txtoth@gmail.com" "Документация по setrans.conf"
 .SH "ИМЯ"
 setrans.conf \- файл конфигурации преобразования для систем MCS/MLS SELinux
 
-- 
2.22.0

