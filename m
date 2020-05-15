Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C92C433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 10:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F395120709
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 10:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHOzsxLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgEOKvO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 06:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgEOKvO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 06:51:14 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86BFC061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 03:51:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so1745275ljd.3
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 03:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0GL2glJTpXTnrn+Aa4c7ZzjqEzN4Qga2qZZRZMxLew=;
        b=UHOzsxLGP3XSwchJisZk6r2dkhUyIzdsTWscxrzQdLApWu15DpmFCTiLPI5AXITlVm
         bk8JuYXZPssEoTwp/SNTdbfycmF7XDjyaElA0CvBqUJ0Ov7reA6OiJ8fTYxkA++Xl99l
         8m/QFT6H7DttmcnKk9Jst5p4DiAAPApTQdoug89aZH2HIIG5sXz4KJdhlx1mmctC01+1
         IQlCRuRI0WM4Zki1r/Rd6/jIsjwm5oQXDyZSr2ZylpiphCrYQfHIEyS4j3gCOqqDWo9E
         bzSdcWR2Osr2JjB/vyb7DD71W++AeS8ZC7xPWbgMIWzqmEWM/IKlNABpUydG2NKS8tgO
         Sa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0GL2glJTpXTnrn+Aa4c7ZzjqEzN4Qga2qZZRZMxLew=;
        b=AF+6D+JIXF7eqzUdfe2BsIUEmaLL6eQa8nCaFDNgiimJ4wsFWzGjm+QLoxS2Zc9IIx
         bcWh+ag4FqA5M2KvSGzr3K6B79T1o56zSuJRIkZDshfeC8ZJv1rw4GuoYM5SWF2NCw3v
         buzzgTqT3S6WOVvlvl4zE9FVf3nik5G0OehTIDMH6mwr+ktYyi+BY7mDk73HPEViaTA7
         KBYM6hSC1HiiH+TYMlUke/bPNMDTO064ug44LciwgP5vIqrVVLt7Pe5AlIio9laWrPL4
         knV32qNtfuybIntrc26Gz8ivi4nRAu0TNn0lpSnzi5JZDGfFdV7rcDkDbY2F5dZQucM3
         or4w==
X-Gm-Message-State: AOAM531nfcAj5J1dcTHMXyxTP85Tpdf9Z1hG7EZq4eIBMiO4YdkkMRe3
        ajBj89DnR0I30xOL046pDLXpOOUg
X-Google-Smtp-Source: ABdhPJwbR4iz+e0d9RKrW/NS64nZYL9YydxTNoux29Irb1x7sQFjHFSwzA/q0i8eZb3pac9DWtybkg==
X-Received: by 2002:a2e:8191:: with SMTP id e17mr1934114ljg.68.1589539871907;
        Fri, 15 May 2020 03:51:11 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id q27sm1088133lfn.58.2020.05.15.03.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:51:11 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] secilc/docs: fix use of TMPDIR #240
Date:   Fri, 15 May 2020 13:51:05 +0300
Message-Id: <20200515105105.10075-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Environment variable TMPDIR may be already set for the user building
and this could be equal to $XDG_RUNTIME_DIR or /tmp which are existing
directories. Then when running 'make clean', there are unintended side
effects:

rm -rf /run/user/1000
rm: cannot remove '/run/user/1000/dconf/user': Permission denied
rm: cannot remove '/run/user/1000/systemd': Permission denied
rm: cannot remove '/run/user/1000/gnupg': Permission denied
rm: cannot remove '/run/user/1000/dbus-1': Is a directory
rm: cannot remove '/run/user/1000/inaccessible': Permission denied
make[1]: *** [Makefile:68: clean] Error 1

Fix by using a different name.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 secilc/docs/Makefile | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
index 6b07ce7f..90214e0d 100644
--- a/secilc/docs/Makefile
+++ b/secilc/docs/Makefile
@@ -1,7 +1,7 @@
 CWD ?= $(shell pwd)
 HTMLDIR ?= $(CWD)/html
 PDFDIR ?= $(CWD)/pdf
-TMPDIR ?= $(CWD)/tmp
+TMP_DIR ?= $(CWD)/tmp
 TESTDIR ?= $(CWD)/../test
 
 # All the markdown files that make up the guide:
@@ -26,7 +26,7 @@ FILE_LIST ?= cil_introduction.md \
 	cil_infiniband_statements.md \
 	cil_xen_statements.md
 
-PANDOC_FILE_LIST = $(addprefix $(TMPDIR)/,$(FILE_LIST))
+PANDOC_FILE_LIST = $(addprefix $(TMP_DIR)/,$(FILE_LIST))
 
 PDF_OUT=CIL_Reference_Guide.pdf
 HTML_OUT=CIL_Reference_Guide.html
@@ -40,29 +40,29 @@ endif
 
 all: html pdf
 
-$(TMPDIR):
-	mkdir -p $(TMPDIR)
+$(TMP_DIR):
+	mkdir -p $(TMP_DIR)
 
-$(TMPDIR)/%.md: %.md | $(TMPDIR)
-	cp -f $< $(TMPDIR)/
+$(TMP_DIR)/%.md: %.md | $(TMP_DIR)
+	cp -f $< $(TMP_DIR)/
 	@# Substitute markdown links for conversion into PDF links
 	$(SED) -i -re 's:(\[`[^`]*`\])\([^#]*([^\)]):\1\(\2:g' $@
 
-$(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil
+$(TMP_DIR)/policy.cil: $(TESTDIR)/policy.cil
 	cp -f $< $@
 	@# add a title for the TOC to policy.cil. This is needed to play nicely with the PDF conversion.
 	$(SED) -i '1i Example Policy\n=========\n```' $@
 	echo '```' >> $@
 
-html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
+html: $(PANDOC_FILE_LIST) $(TMP_DIR)/policy.cil
 	mkdir -p $(HTMLDIR)
 	$(PANDOC) -t html $^ -o $(HTMLDIR)/$(HTML_OUT)
 
-pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
+pdf: $(PANDOC_FILE_LIST) $(TMP_DIR)/policy.cil
 	mkdir -p $(PDFDIR)
 	$(PANDOC) --standalone --toc $^ -o $(PDFDIR)/$(PDF_OUT)
 
 clean:
 	rm -rf $(HTMLDIR)
 	rm -rf $(PDFDIR)
-	rm -rf $(TMPDIR)
+	rm -rf $(TMP_DIR)
-- 
2.26.2

