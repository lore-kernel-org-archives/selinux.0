Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FEBC433EF
	for <selinux@archiver.kernel.org>; Fri, 10 Dec 2021 11:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbhLJLrb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Dec 2021 06:47:31 -0500
Received: from mailomta26-re.btinternet.com ([213.120.69.119]:33466 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240744AbhLJLra (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Dec 2021 06:47:30 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20211210114354.KBLG24326.re-prd-fep-046.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Fri, 10 Dec 2021 11:43:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1639136634; 
        bh=UBTAVqWtgVhxKtVVyZg0DKzx16fLVN67bgj+xfwcGQg=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=X3zGyR0GbbKm3LCuuw86d6VVsjhL77hlZoNNOG/3rXs1fzkAio0f9KuvAtSoGAzBhHrBeHl4PKte649PuNjwp0EKc6UWN+tFMlDtg+XRlfDx6FJy7wOcfG4h+jijS1KE5pkrKjhdO2iWmgZaVzYryBZfCXBRS7E7fC9bB8tcMVoZ3RCicluKD5AHw4Kg8vTTcquYS2DeEy2IWnSBeXQI+iuWTzdieZLDJO2njnyD50hak9UFM3oVnclI8ejeT1LacnNTXV9k5kWdAeLaF1U/CIqa1Zzuw8SaHfwohra8pFDweW5JCEwis5iVVNWmmPVxgTPdQ/qkiEAs5JZKjBNuog==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613A901C0CC4A2C9
X-Originating-IP: [81.141.144.155]
X-OWM-Source-IP: 81.141.144.155 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrkedvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeduffefveduffeuhfekgfeuleffgfelheelieffgeegvedvgfeuveevveeigeetveenucffohhmrghinhepuhhpuggrthgvqdhmihhmvgdquggrthgrsggrshgvrdhlohgtrghlpdhgnhhurdhorhhgpdguvghvihgrnhhtrghrthdrtghomhenucfkphepkedurddugedurddugeegrdduheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudeguddrudeggedrudehhedpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.141.144.155) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A901C0CC4A2C9; Fri, 10 Dec 2021 11:43:54 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 4/4] selinux-notebook: Add epub build
Date:   Fri, 10 Dec 2021 11:43:40 +0000
Message-Id: <20211210114340.13977-5-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211210114340.13977-1-richard_c_haines@btinternet.com>
References: <20211210114340.13977-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Build an epub document.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 BUILD.md            | 17 +++++++++++-----
 CONTRIBUTING.md     | 10 +++++-----
 Makefile            | 48 ++++++++++++++++++++++++++++++++++++++-------
 README.md           |  9 +++++----
 src/cover.md        | 16 +++++++++++++++
 src/cover_epub.md   |  2 ++
 src/styles_epub.css | 44 +++++++++++++++++++++++++++++++++++++++++
 src/title.md        | 16 ---------------
 8 files changed, 125 insertions(+), 37 deletions(-)
 create mode 100644 src/cover.md
 create mode 100644 src/cover_epub.md
 create mode 100644 src/styles_epub.css

diff --git a/BUILD.md b/BUILD.md
index 34045cf..6ca9077 100644
--- a/BUILD.md
+++ b/BUILD.md
@@ -29,9 +29,9 @@ Extract from the README:
 > 
 >     % update-mime-database ~/.local/share/mime
 
-# Build HTML or PDF Versions
+# Build HTML, PDF or EPUB Versions
 
-The SELinux Notebook can be rendered in both HTML and PDF using the included
+The SELinux Notebook can be rendered in HTML, PDF and EPUB using the included
 Makefile.  In order to build these versions of the notebook, "pandoc" and
 "weasyprint" must be installed on your system; consult your distribution
 documentation for information on installing these packages.
@@ -41,9 +41,16 @@ following command:
 
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
+The Notebook examples are not embedded into any of the document formats,
+however they will have links to them via their build directory.
diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 43f1934..db137b0 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -10,11 +10,11 @@ project.
 
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
 
 ## Explain Your Work
 
diff --git a/Makefile b/Makefile
index f41bb16..1903982 100644
--- a/Makefile
+++ b/Makefile
@@ -2,20 +2,23 @@
 # The SELinux Notebook
 #
 
+SED = sed
+PANDOC = pandoc
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
 
-SED = sed
-PANDOC = pandoc
 PANDOC_OPTS  = --from markdown+pipe_tables
 PANDOC_OPTS += -V mainfont='DejaVu Serif' -V monofont='DejaVu Sans Mono'
 
@@ -27,8 +30,8 @@ help:
 	@echo "targets:"
 	@grep "^#@ " Makefile | cut -c4-
 
-#@   all             build both the PDF and HTML versions
-all: html pdf
+#@   all             build the PDF, HTML and EPUB versions
+all: html pdf epub
 
 #@   navlinks        update the navigation links in the markdown sources
 .PHONY: navlinks
@@ -46,11 +49,13 @@ navlinks:
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
@@ -70,11 +75,13 @@ pdf: $(DEP_FILE_LIST) $(METADATA)
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
@@ -92,7 +99,34 @@ html: $(DEP_FILE_LIST) $(METADATA)
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
+		--epub-cover-image=$(SRCDIR)/images/selinux-penguin_400.png \
+		--css=$(SRCDIR)/styles_epub.css --self-contained \
+		$(EPUBDIR)/.full_document.md -o $(EPUBDIR)/$(EPUB_OUT))
+
 #@   clean           clean any build artifacts
 .PHONY: clean
 clean:
-	rm -rf $(HTMLDIR) $(PDFDIR)
+	rm -rf $(HTMLDIR) $(PDFDIR) $(EPUBDIR)
diff --git a/README.md b/README.md
index 9558101..f2e1c94 100644
--- a/README.md
+++ b/README.md
@@ -1,6 +1,6 @@
 # The SELinux Notebook
 
-![](./src/images/selinux-penguin.svg)
+![](./src/images/selinux-penguin_400.png)
 
 ## Introduction
 
@@ -69,7 +69,8 @@ See: **<http://www.gnu.org/licenses/fdl-1.3.html>**
 
 Logo designed by [*Máirín Duffy*](http://pookstar.deviantart.com/)
 
-## Building HTML/PDF Versions
+## Building HTML/PDF/EPUB Versions
 
-The [**BUILD.md**](BUILD.md) file has more information on building HTML and PDF
-versions of the notebook as well as alternate ways to view the source markdown.
+The [**BUILD.md**](BUILD.md) file has more information on building HTML, PDF
+and EPUB versions of the notebook as well as alternate ways to view the
+source markdown.
diff --git a/src/cover.md b/src/cover.md
new file mode 100644
index 0000000..d3be82c
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
+![](./images/selinux-penguin_400.png)
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
diff --git a/src/styles_epub.css b/src/styles_epub.css
new file mode 100644
index 0000000..a1bb26f
--- /dev/null
+++ b/src/styles_epub.css
@@ -0,0 +1,44 @@
+
+.title {
+	/* pandoc generates the h1 title with the "title" class */
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
diff --git a/src/title.md b/src/title.md
index 03c5795..7f21617 100644
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
-![](./images/selinux-penguin.svg)
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

