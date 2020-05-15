Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DCDC433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FBB206D4
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBjZyxX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgEOLiu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 07:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgEOLit (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 07:38:49 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B06C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 04:38:49 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so1857278ljj.11
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 04:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0GL2glJTpXTnrn+Aa4c7ZzjqEzN4Qga2qZZRZMxLew=;
        b=nBjZyxX9kLI5VHr0G8KvugNIc2RE6hl4sRAd1wojwaPkYbMQh0aMvHG3Ifz8hBN2Zq
         8YBK0PlpPkRtwoy8nL6mLFkKi/eKnqqqm3uSnmEX7SgEakpDIu3qQNBzEsmcrvrSnaCx
         IODWw6aDgYuBIAkO0lOM5jYkM7fvm4Gdr84akx3kud33v/hsHjjyyWuZjTuqEt4dl7vE
         qSXNZ9U6vUn5NQRbOGycx1pNulSMQPKgVkWSC96usaaKQS45SwyGCi+D5gEKj0dK1SDn
         Hsj6APBG/VFOrTM128DeSl6LVzbB8RkrhtQlEntLoJLqQE1ByMppipwpNo5fsHOP/uHp
         5nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0GL2glJTpXTnrn+Aa4c7ZzjqEzN4Qga2qZZRZMxLew=;
        b=K1ag97HyfQic0Uc1ZWYywuXbBut5z0V/M4RyZGI5I4bqyJWZbC7Z2QjskLDsYG5EEO
         syeThFwNfN98Fh+Y+l2OLlRVbBRIDHcQMXLwUKSiO5JTIhO9Xvy2QtAuLIf7P/VU+0st
         LlXDRzvQmMD5OHH2AKp12OdL9loIKBOwFDdYyJkb9I0rRKYaiWsC5Piiubh4GuxzgwYF
         ivbNQVTmeR41/boq7M+JOhhFn63cY+9dgU87XjF4htY+bEDSsZ9ghkkiJwY5OlQ7tC+j
         AU0KKVVv+1/PF9i9/1X3DfZtqeG8vlEb1ifIF+jKeRttYjuPokw5CfVFvxImQqvnB1iI
         J11g==
X-Gm-Message-State: AOAM533uEX6GDHau0qE1aFYEuW69w7aKVlWDHioR+7gM8fF3pls1mXAD
        45CMMLT/g/XU50u3TRG3oAq3QYVd
X-Google-Smtp-Source: ABdhPJwnUNbCZJVDD6eMGDnL/kLb9uIexmFRTdaU5DAYRZfn3Fmp4JBUJnJLd6FuPwLR3psfTB6pvA==
X-Received: by 2002:a2e:5753:: with SMTP id r19mr1927475ljd.195.1589542727242;
        Fri, 15 May 2020 04:38:47 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id s8sm1164111lfd.61.2020.05.15.04.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 04:38:46 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v2] secilc/docs: fix use of TMPDIR #240
Date:   Fri, 15 May 2020 14:38:42 +0300
Message-Id: <20200515113842.11316-1-toiwoton@gmail.com>
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

