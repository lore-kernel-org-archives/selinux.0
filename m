Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1O4vlen017913
 for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2018 23:57:47 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC03.oob.disa.mil (Postfix) with SMTP id 3zpG6x31TjzJnY6
 for <selinux@tycho.nsa.gov>; Sat, 24 Feb 2018 04:57:45 +0000 (UTC)
Received: from UPDC3CPA10_EEMSG_MP26.eemsg.mil (unknown [192.168.18.21])
 by UPDCF3IC03.oob.disa.mil (Postfix) with ESMTP id 3zpG6x1WzdzJnXt
 for <selinux@tycho.nsa.gov>; Sat, 24 Feb 2018 04:57:45 +0000 (UTC)
Received: by mail-qk0-f193.google.com with SMTP id l206so13347625qke.1
 for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2018 20:57:44 -0800 (PST)
Received: from localhost.localdomain (c-76-100-110-125.hsd1.md.comcast.net.
 [76.100.110.125])
 by smtp.gmail.com with ESMTPSA id x28sm2957160qtx.20.2018.02.23.20.57.42
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 23 Feb 2018 20:57:42 -0800 (PST)
From: Yuli Khodorkovskiy <ykhodo@gmail.com>
To: selinux@tycho.nsa.gov
Date: Sat, 24 Feb 2018 04:57:33 +0000
Message-Id: <20180224045733.12509-1-ykhodo@gmail.com>
Subject: [PATCH] secilc: Fix documentation build for OS X systems
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since Darwin systems do not have GNU sed installed, the Darwin sed is
missing the "regexp-extended" flag needed to modify the secilc markdown
files before processing with pandoc.

A quick fix for Mac users is to `brew install gnu-sed` and to use gsed.

Signed-off-by: Yuli Khodorkovskiy <ykhodo@gmail.com>
---
 secilc/docs/Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
index c0fa6b7f..6b07ce7f 100644
--- a/secilc/docs/Makefile
+++ b/secilc/docs/Makefile
@@ -31,6 +31,12 @@ PANDOC_FILE_LIST = $(addprefix $(TMPDIR)/,$(FILE_LIST))
 PDF_OUT=CIL_Reference_Guide.pdf
 HTML_OUT=CIL_Reference_Guide.html
 PANDOC = pandoc
+SED ?= sed
+
+OS := $(shell uname)
+ifeq ($(OS), Darwin)
+	SED := gsed
+endif
 
 all: html pdf
 
@@ -40,12 +46,12 @@ $(TMPDIR):
 $(TMPDIR)/%.md: %.md | $(TMPDIR)
 	cp -f $< $(TMPDIR)/
 	@# Substitute markdown links for conversion into PDF links
-	sed -i -re 's:(\[`[^`]*`\])\([^#]*([^\)]):\1\(\2:g' $@
+	$(SED) -i -re 's:(\[`[^`]*`\])\([^#]*([^\)]):\1\(\2:g' $@
 
 $(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil
 	cp -f $< $@
 	@# add a title for the TOC to policy.cil. This is needed to play nicely with the PDF conversion.
-	sed -i '1i Example Policy\n=========\n```' $@
+	$(SED) -i '1i Example Policy\n=========\n```' $@
 	echo '```' >> $@
 
 html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
-- 
2.14.3
