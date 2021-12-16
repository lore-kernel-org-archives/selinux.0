Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A40C433F5
	for <selinux@archiver.kernel.org>; Thu, 16 Dec 2021 17:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhLPRdU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Dec 2021 12:33:20 -0500
Received: from mailomta9-re.btinternet.com ([213.120.69.102]:58345 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230217AbhLPRdU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Dec 2021 12:33:20 -0500
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20211216173318.MXXF24326.re-prd-fep-046.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 16 Dec 2021 17:33:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1639675998; 
        bh=6nOz1yWSZaPMQ0W+yUqutxm6X0HEC1YmpFBx6CNW2Xw=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=lFHItlLTX2KgoIm+upVDwN99AQz4Kpgn5HVF4FShsAO77PpyP/ENqxx7c4fN2XOS6F72Kp6wMVYaFYw0vfEuSfZr1PtQIexqeJWxf2aLc5esjqjmA+nZJRQzPi97IuKxhe0FPWm4FNayfoy0jVgELAdbx/XUqvD3kxP5QkWQ8+MsITGzV+oLaDGK59TNDwwQnOk//1zUdJ8NCJ4NLlAVLGpz50qb8ol9UmFLNmIcnrSAd12zZyHyOduuS+sVGY4KFqTUgMlIQoRVDrE4ldVgM54STRtXwyBOHTmej3whHA1N8UvrZ8+sTQu57jjPJvm5NA/ZY0lALx2D0tIHxmdGSw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A8CC30D7C7212
X-Originating-IP: [217.43.180.152]
X-OWM-Source-IP: 217.43.180.152 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepgfevvdeivdekueffleeivdfhgedtteefheehffekheekfefggeeftddtieethfeunecuffhomhgrihhnpehuphgurghtvgdqmhhimhgvqdgurghtrggsrghsvgdrlhhotggrlhdpghhithhhuhgsrdgtohhmpdhgnhhurdhorhhgpdguvghvihgrnhhtrghrthdrtghomhdptghonhhtrhhisghuthhinhhgrdhmugenucfkphepvddujedrgeefrddukedtrdduhedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedvudejrdegfedrudektddrudehvddpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohep
        shgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (217.43.180.152) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A8CC30D7C7212; Thu, 16 Dec 2021 17:33:18 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-notebook: Add epub build
Date:   Thu, 16 Dec 2021 17:33:06 +0000
Message-Id: <20211216173306.36377-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Build an epub document. If Calibre is installed also build a version
suitable for a Kindle (azw3 format).

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 .gitignore          |  1 +
 BUILD.md            | 26 ++++++++++++++++-----
 CONTRIBUTING.md     | 13 ++++++-----
 Makefile            | 55 +++++++++++++++++++++++++++++++++++++++------
 README.md           |  8 ++++---
 src/cover.md        | 16 +++++++++++++
 src/cover_epub.md   |  2 ++
 src/metadata.yaml   | 14 ++++++++++++
 src/styles_epub.css | 52 ++++++++++++++++++++++++++++++++++++++++++
 src/styles_html.css |  8 +++++++
 src/styles_pdf.css  |  8 +++++++
 src/title.md        | 16 -------------
 12 files changed, 183 insertions(+), 36 deletions(-)
 create mode 100644 src/cover.md
 create mode 100644 src/cover_epub.md
 create mode 100644 src/styles_epub.css

diff --git a/.gitignore b/.gitignore
index 979135f..3554095 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
 .tmp/
 html/
 pdf/
+epub/
diff --git a/BUILD.md b/BUILD.md
index 34045cf..a72dc38 100644
--- a/BUILD.md
+++ b/BUILD.md
@@ -29,21 +29,37 @@ Extract from the README:
 > 
 >     % update-mime-database ~/.local/share/mime
 
-# Build HTML or PDF Versions
+# Build HTML, PDF or EPUB Versions
 
-The SELinux Notebook can be rendered in both HTML and PDF using the included
+The SELinux Notebook can be rendered in HTML, PDF and EPUB using the included
 Makefile.  In order to build these versions of the notebook, "pandoc" and
 "weasyprint" must be installed on your system; consult your distribution
 documentation for information on installing these packages.
 
+The EPUB build will also produce a Kindle "azw3" formatted version if "calibre"
+is installed on your system (specifically the "ebook-convert" command).
+
 Once the required packages are installed can generate the PDF notebook with the
 following command:
 
 	% make pdf
 
-... and the following will generate the HTML notebook:
+... the following will generate the HTML notebook:
 
 	% make html
 
-The PDF and HTML notebooks will be generated in newly created "pdf" and "html"
-directories.
+... and the following will generate the EPUB notebook:
+
+	% make epub
+
+The PDF, HTML and EPUB notebooks will be generated in newly created "pdf",
+"html" and "epub" directories.
+
+**Notes:**
+
+- The Notebook examples are not embedded into any of the document formats,
+  however they will have links to them via their build directory.
+- When viewing the Notebook EPUB version, eBook readers do vary on rendering
+  tables, displaying images and resolving links to the examples. For Linux,
+  Foliate was found to be the most consistent, and can be found at:
+  <https://github.com/johnfactotum/foliate>
diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 43f1934..c39f7a8 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -10,11 +10,14 @@ project.
 
 ## Make Sure Your Changes Render Correctly
 
-The SELinux Notebook can be viewed in three different formats: Markdown, HTML,
-and PDF.  Your changes need to render correctly in all three formats.  The
-HTML and PDF formatted notebooks can be created using the included Makefile
-and Markdown can be viewed directly via the GitHub source browser or any
-number of Markdown viewers.
+The SELinux Notebook can be viewed in four different formats: Markdown, HTML,
+PDF and EPUB.  Your changes need to render correctly in all four formats.
+The HTML, PDF and EPUB formatted notebooks can be created using the included
+Makefile and Markdown can be viewed directly via the GitHub source browser
+or any number of Markdown viewers.
+
+Note that the EPUB build will optionally produce a version suitable for
+viewing on a Kindle that supports the "azw3" file format.
 
 ## Explain Your Work
 
diff --git a/Makefile b/Makefile
index f41bb16..5655e7a 100644
--- a/Makefile
+++ b/Makefile
@@ -2,20 +2,27 @@
 # The SELinux Notebook
 #
 
+SED = sed
+PANDOC = pandoc
+# Find if Calibre ebook-convert command is installed, if so produce a
+# Kindle version in azw3 format
+EBOOK_CONVERT = $(shell whereis -b ebook-convert | cut -f 2 -d :)
 CWD ?= $(shell pwd)
 SCRIPTS = $(CWD)/scripts
 SRCDIR = $(CWD)/src
 HTMLDIR ?= $(CWD)/html
 PDFDIR ?= $(CWD)/pdf
+EPUBDIR ?= $(CWD)/epub
 IMAGES = $(SRCDIR)/images
 EXAMPLES = $(SRCDIR)/notebook-examples
+EXAMPLES_EPUB = $(shell echo $(EXAMPLES) | $(SED) 's;/;\\/;g')
 METADATA = $(SRCDIR)/metadata.yaml
 
 HTML_OUT = SELinux_Notebook.html
 PDF_OUT = SELinux_Notebook.pdf
+EPUB_OUT = SELinux_Notebook.epub
+AZW3_OUT = SELinux_Notebook.azw3
 
-SED = sed
-PANDOC = pandoc
 PANDOC_OPTS  = --from markdown+pipe_tables
 PANDOC_OPTS += -V mainfont='DejaVu Serif' -V monofont='DejaVu Sans Mono'
 
@@ -27,8 +34,8 @@ help:
 	@echo "targets:"
 	@grep "^#@ " Makefile | cut -c4-
 
-#@   all             build both the PDF and HTML versions
-all: html pdf
+#@   all             build the PDF, HTML and EPUB versions
+all: html pdf epub
 
 #@   navlinks        update the navigation links in the markdown sources
 .PHONY: navlinks
@@ -46,11 +53,13 @@ navlinks:
 		echo "" >> $$i; \
 	done
 
-#@   pdf             build both the PDF version
+#@   pdf             build PDF version
 .PHONY: pdf
 pdf: $(DEP_FILE_LIST) $(METADATA)
 	mkdir -p $(PDFDIR)
 	cat $(METADATA) > $(PDFDIR)/.full_document.md
+	cat $(SRCDIR)/cover.md | $(SCRIPTS)/macros_section.sh \
+		>> $(PDFDIR)/.full_document.md
 	for i in $(DEP_FILE_LIST); do \
 		cat $$i | $(SCRIPTS)/macros_section.sh \
 			>> $(PDFDIR)/.full_document.md; \
@@ -70,11 +79,13 @@ pdf: $(DEP_FILE_LIST) $(METADATA)
 		--css=$(SRCDIR)/styles_pdf.css --self-contained \
 		$(PDFDIR)/.full_document.md -o $(PDFDIR)/$(PDF_OUT))
 
-#@   html            build both the HTML version
+#@   html            build HTML version
 .PHONY: html
 html: $(DEP_FILE_LIST) $(METADATA)
 	mkdir -p $(HTMLDIR)
 	cat $(METADATA) > $(HTMLDIR)/.full_document.md
+	cat $(SRCDIR)/cover.md | $(SCRIPTS)/macros_section.sh \
+		>> $(HTMLDIR)/.full_document.md
 	for i in $(DEP_FILE_LIST); do \
 		cat $$i | $(SCRIPTS)/macros_section.sh \
 			>> $(HTMLDIR)/.full_document.md; \
@@ -92,7 +103,37 @@ html: $(DEP_FILE_LIST) $(METADATA)
 		--css=$(SRCDIR)/styles_html.css --self-contained \
 		$(HTMLDIR)/.full_document.md -o $(HTMLDIR)/$(HTML_OUT))
 
+#@   epub             build EPUB version
+.PHONY: epub
+epub: $(DEP_FILE_LIST) $(METADATA)
+	mkdir -p $(EPUBDIR)
+	cat $(METADATA) > $(EPUBDIR)/.full_document.md
+	cat $(SRCDIR)/cover_epub.md | $(SCRIPTS)/macros_section.sh \
+		>> $(EPUBDIR)/.full_document.md
+	for i in $(DEP_FILE_LIST); do \
+		cat $$i | $(SCRIPTS)/macros_section.sh \
+			>> $(EPUBDIR)/.full_document.md; \
+		echo '<!-- %PAGEBREAK% -->' \
+			>> $(EPUBDIR)/.full_document.md; \
+	done
+	$(SCRIPTS)/macros_doc.sh $(EPUBDIR)/.full_document.md
+	$(SED) -i 's/](.*\.md#/](#/' $(EPUBDIR)/.full_document.md
+	# remove the section file name from all HTML links
+	$(SED) -i 's/href=.*\.md#/href="#/' $(EPUBDIR)/.full_document.md
+	# fixup path for examples, otherwise defaults to file:///EPUB/text
+	$(SED) -i 's/](.\/notebook-examples/](file:\/\/$(EXAMPLES_EPUB)/g' \
+		$(EPUBDIR)/.full_document.md
+	[ -e $(EPUBDIR)/images ] || ln -s $(IMAGES) $(EPUBDIR)
+	[ -e $(EPUBDIR)/notebook-examples ] || ln -s $(EXAMPLES) $(EPUBDIR)
+	(cd $(EPUBDIR); $(PANDOC) $(PANDOC_OPTS) \
+		--epub-cover-image=$(SRCDIR)/images/selinux-penguin.png \
+		--css=$(SRCDIR)/styles_epub.css --self-contained \
+		$(EPUBDIR)/.full_document.md -o $(EPUBDIR)/$(EPUB_OUT))
+	# Convert to Kindle format if Calibre ebook-convert is installed
+	[ -b $(EBOOK_CONVERT) ] || $(EBOOK_CONVERT) $(EPUBDIR)/$(EPUB_OUT) \
+		$(EPUBDIR)/$(AZW3_OUT)
+
 #@   clean           clean any build artifacts
 .PHONY: clean
 clean:
-	rm -rf $(HTMLDIR) $(PDFDIR)
+	rm -rf $(HTMLDIR) $(PDFDIR) $(EPUBDIR)
diff --git a/README.md b/README.md
index 8042f41..876ae83 100644
--- a/README.md
+++ b/README.md
@@ -69,7 +69,9 @@ See: **<http://www.gnu.org/licenses/fdl-1.3.html>**
 
 Logo designed by [*Máirín Duffy*](http://pookstar.deviantart.com/)
 
-## Building HTML/PDF Versions
+## Building HTML/PDF/EPUB Versions
 
-The [**BUILD.md**](BUILD.md) file has more information on building HTML and PDF
-versions of the notebook as well as alternate ways to view the source markdown.
+The [**BUILD.md**](BUILD.md) file has more information on building HTML, PDF
+and EPUB versions of the notebook as well as alternate ways to view the
+source markdown. Note that the EPUB build will optionally produce a version
+suitable for viewing on a Kindle that supports the "azw3" file format.
diff --git a/src/cover.md b/src/cover.md
new file mode 100644
index 0000000..2bd1f79
--- /dev/null
+++ b/src/cover.md
@@ -0,0 +1,16 @@
+<!-- %STYLESTART%(text-align:center;) -->
+
+<!-- %STYLESTART%(font-size:400%) -->
+# The SELinux Notebook
+<!-- %STYLEEND% -->
+
+<!-- %STYLESTART%(display:block;margin-left:auto;margin-right:auto;padding:2em) -->
+![](./images/selinux-penguin.png)
+<!-- %STYLEEND% -->
+
+**<!-- %DATE% -->**
+<!-- %GITHEAD% -->
+
+<!-- %STYLEEND% -->
+
+<!-- %PAGEBREAK% -->
diff --git a/src/cover_epub.md b/src/cover_epub.md
new file mode 100644
index 0000000..3f90deb
--- /dev/null
+++ b/src/cover_epub.md
@@ -0,0 +1,2 @@
+**<!-- %DATE% -->**
+<!-- %GITHEAD% -->
diff --git a/src/metadata.yaml b/src/metadata.yaml
index 5097763..89bb523 100644
--- a/src/metadata.yaml
+++ b/src/metadata.yaml
@@ -1,3 +1,17 @@
 ---
 title: The SELinux Notebook
+author: Originally created by Richard Haines
+subject: Security-Enhanced Linux (SELinux)
+description: |
+	Gives a description of SELinux and its major components to provide
+	Mandatory Access Control services for GNU / Linux. Hopefully it will
+	show how the SELinux components link together and how SELinux-aware
+	applications / object manager have been implemented.
+contributor: |
+	Anyone may contribute to this book, see
+	<https://github.com/SELinuxProject/selinux-notebook/blob/main/CONTRIBUTING.md>
+rights: |
+	Permission is granted to copy, distribute and/or modify this document
+	under the terms of the GNU Free Documentation License, Version 1.3 or
+	any later version published by the Free Software Foundation.
 ---
diff --git a/src/styles_epub.css b/src/styles_epub.css
new file mode 100644
index 0000000..3942ab3
--- /dev/null
+++ b/src/styles_epub.css
@@ -0,0 +1,52 @@
+
+.title {
+	/* pandoc generates the h1 title with the "title" class */
+	display: none;
+}
+
+.author {
+	display: none;
+}
+
+.rights {
+	display: none;
+}
+
+html {
+	font-size: 100%;
+}
+
+a {
+	color: blue;
+}
+
+table {
+	/* limit to 95% page width */
+	min-width: 50%;
+	max-width: 95%;
+	/* combine table borders when they are adjacent */
+	border-collapse: collapse;
+}
+table th {
+	padding: 0.5em;
+	border: 1px solid black;
+	background-color: #d3d3d3;
+}
+table tr, td {
+	padding: 0.5em;
+	border: 1px solid black;
+}
+
+img {
+	/* center and limit to 95% page width */
+	display: block;
+	margin-left: auto;
+	margin-right: auto;
+	max-width: 95%;
+}
+
+pre {
+	width: 95%;
+	padding: 1em;
+	background-color: #f5f5f5;
+}
diff --git a/src/styles_html.css b/src/styles_html.css
index fef851e..0f28003 100644
--- a/src/styles_html.css
+++ b/src/styles_html.css
@@ -4,6 +4,14 @@
 	display: none;
 }
 
+.author {
+	display: none;
+}
+
+.rights {
+	display: none;
+}
+
 html {
 	/* 1em is specified as 16pt, 75% should be 12pt */
 	font-size: 100%;
diff --git a/src/styles_pdf.css b/src/styles_pdf.css
index f0bba23..12ed81c 100644
--- a/src/styles_pdf.css
+++ b/src/styles_pdf.css
@@ -48,6 +48,14 @@
 	display: none;
 }
 
+.author {
+	display: none;
+}
+
+.rights {
+	display: none;
+}
+
 html {
 	/* 1em is specified as 16pt, 75% should be 12pt */
 	font-size: 75%;
diff --git a/src/title.md b/src/title.md
index 1112175..7f21617 100644
--- a/src/title.md
+++ b/src/title.md
@@ -1,19 +1,3 @@
-<!-- %STYLESTART%(text-align:center;) -->
-
-<!-- %STYLESTART%(font-size:400%) -->
-# The SELinux Notebook
-<!-- %STYLEEND% -->
-
-<!-- %STYLESTART%(display:block;margin-left:auto;margin-right:auto;padding:2em) -->
-![](./images/selinux-penguin.png)
-<!-- %STYLEEND% -->
-
-**<!-- %DATE% -->**
-<!-- %GITHEAD% -->
-
-<!-- %STYLEEND% -->
-
-<!-- %PAGEBREAK% -->
 
 ## Copyright Information
 
-- 
2.33.1

