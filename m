Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w21B06ej010395
 for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2018 06:00:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3968C4084FEF
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 11:00:07 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D274110AF9F5
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 11:00:06 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu,  1 Mar 2018 11:59:43 +0100
Message-Id: <20180301105945.15587-2-vmojzis@redhat.com>
In-Reply-To: <20180301105945.15587-1-vmojzis@redhat.com>
References: <aaa79052-e646-716d-676f-d06554953b3f@tycho.nsa.gov>
 <20180301105945.15587-1-vmojzis@redhat.com>
Subject: [PATCH 1/3] secilc: Fix documentation build for OS X systems
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Yuli Khodorkovskiy <ykhodo@gmail.com>

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
