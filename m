Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF55C43460
	for <selinux@archiver.kernel.org>; Thu, 15 Apr 2021 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3D461131
	for <selinux@archiver.kernel.org>; Thu, 15 Apr 2021 20:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhDOUeU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbhDOUeO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Apr 2021 16:34:14 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4220C061756
        for <selinux@vger.kernel.org>; Thu, 15 Apr 2021 13:33:50 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 18so9798943qkl.3
        for <selinux@vger.kernel.org>; Thu, 15 Apr 2021 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KWc1nakIMtMydMKxm0K7+kiRrBDVkmC54QCzaoL5bEI=;
        b=OWrDbNohb4D7NuKrLMvIBHReI1WC2bqRMMHEdMBhDuLg56WFYhQ/JUB2750HiCYqDw
         l4/F532VX9VHQJX5t2Nhar+5iKCV52WRJpl3LQM3CNo8fYC3z1AB+PIUbzq3dvGYtfQB
         NzJI+fPMsoCb0gaejLl9Dc9n1OGDhHejtqX3NtGiOyVF7QOA2uDl0Eb0Lqcps2dfRoJj
         KnrW9K92F4VGkNSsY8jCRf/AL8wtCLCinzn0+rRSc4kFwNk+h0TjFNU8HN8B6fothuYC
         KU2J6jM+RPt6zjVjVVPfjQIs1dLhU7eYBlFqoUmAeJlKTTQJS/Q4pwvuXElvelfHq/li
         3DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWc1nakIMtMydMKxm0K7+kiRrBDVkmC54QCzaoL5bEI=;
        b=MoZeQsuRp0CFh6PVGvNLia6dASo2lLcRjcHgXcxIbr3mGe/9WwVTrLGdfsXj4AtDjc
         njSGqkbY5wcKXb8lFVrV2wlaTRKF0CTDhz8GYP+QcLXXtCSHIa9H3bdumKAN7Xn8agYF
         A/93r/+qFDXWIe1yIXb2b3evLhzrM66bQTbWpeyWDjeaiWPQh9EGcQ3nzlvUHxPYY5sf
         OsY/RaOiJeYB1SpMrfdy6iehTE1/xKGY39PiXY6UbaG2H7yk4ksA+kcy/yx6g7yu8jWq
         R/culef8G4OeuCYYiY9CFIELdr+HjHPDDz+7vSHMrQNulFGWKLA9CBtWDRp6+aXlt6OL
         LRkg==
X-Gm-Message-State: AOAM532dyq4Y8ixMJ4Ws4Yf/z/7PsTSV5IkyPMbOS6EOnU9QapyOad0X
        +zSF0KgTBTFgpBMIilGEpcdBCEgG3tSUlA==
X-Google-Smtp-Source: ABdhPJw571l24sYEkqOycQYBkQuZni22VMSODZFPFG1saI9m272GAdW7Zn0DCWMifYeFoc6bRnlvPA==
X-Received: by 2002:a37:6287:: with SMTP id w129mr5405684qkb.159.1618518829618;
        Thu, 15 Apr 2021 13:33:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id c27sm2763469qko.71.2021.04.15.13.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:33:49 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3] secilc: Create the new program called secil2tree to write out CIL AST
Date:   Thu, 15 Apr 2021 16:33:32 -0400
Message-Id: <20210415203332.191302-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210415203332.191302-1-jwcart2@gmail.com>
References: <20210415203332.191302-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

secil2tree is the SELinux CIL AST writer. It calls the cil functions
cil_write_parse_ast(), cil_write_build_ast(), or cil_write_resolve_ast()
to write out the parse tree, the CIL AST after the build phase, or the
CIL AST after the resolve phase.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/.gitignore       |   2 +
 secilc/Makefile         |  20 +++-
 secilc/secil2tree.8.xml |  81 ++++++++++++++++
 secilc/secil2tree.c     | 206 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 307 insertions(+), 2 deletions(-)
 create mode 100644 secilc/secil2tree.8.xml
 create mode 100644 secilc/secil2tree.c

diff --git a/secilc/.gitignore b/secilc/.gitignore
index 164523b0..d2a3daf1 100644
--- a/secilc/.gitignore
+++ b/secilc/.gitignore
@@ -2,6 +2,8 @@ secilc
 secilc.8
 secil2conf
 secil2conf.8
+secil2tree
+secil2tree.8
 policy.*
 file_contexts
 docs/html
diff --git a/secilc/Makefile b/secilc/Makefile
index d4a1c35a..94be0481 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -10,8 +10,13 @@ SECIL2CONF = secil2conf
 SECIL2CONF_SRCS := secil2conf.c
 SECIL2CONF_OBJS := $(patsubst %.c,%.o,$(SECIL2CONF_SRCS))
 
+SECIL2TREE = secil2tree
+SECIL2TREE_SRCS := secil2tree.c
+SECIL2TREE_OBJS := $(patsubst %.c,%.o,$(SECIL2TREE_SRCS))
+
 SECILC_MANPAGE = secilc.8
 SECIL2CONF_MANPAGE = secil2conf.8
+SECIL2TREE_MANPAGE = secil2tree.8
 XMLTO = xmlto
 DIFF = diff
 
@@ -23,7 +28,7 @@ CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -Wcast-align
 override CFLAGS += -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 override LDLIBS += -lsepol
 
-all: $(SECILC) $(SECIL2CONF) man
+all: $(SECILC) $(SECIL2CONF) $(SECIL2TREE) man
 
 $(SECILC): $(SECILC_OBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
@@ -37,7 +42,10 @@ test: $(SECILC)
 $(SECIL2CONF): $(SECIL2CONF_OBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
-man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE)
+$(SECIL2TREE): $(SECIL2TREE_OBJS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
+
+man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE) $(SECIL2TREE_MANPAGE)
 
 $(SECILC_MANPAGE): $(SECILC_MANPAGE).xml
 	$(XMLTO) man $(SECILC_MANPAGE).xml
@@ -45,13 +53,18 @@ $(SECILC_MANPAGE): $(SECILC_MANPAGE).xml
 $(SECIL2CONF_MANPAGE): $(SECIL2CONF_MANPAGE).xml
 	$(XMLTO) man $(SECIL2CONF_MANPAGE).xml
 
+$(SECIL2TREE_MANPAGE): $(SECIL2TREE_MANPAGE).xml
+	$(XMLTO) man $(SECIL2TREE_MANPAGE).xml
+
 install: all man
 	-mkdir -p $(DESTDIR)$(BINDIR)
 	-mkdir -p $(DESTDIR)$(MANDIR)/man8
 	install -m 755 $(SECILC) $(DESTDIR)$(BINDIR)
 	install -m 755 $(SECIL2CONF) $(DESTDIR)$(BINDIR)
+	install -m 755 $(SECIL2TREE) $(DESTDIR)$(BINDIR)
 	install -m 644 $(SECILC_MANPAGE) $(DESTDIR)$(MANDIR)/man8
 	install -m 644 $(SECIL2CONF_MANPAGE) $(DESTDIR)$(MANDIR)/man8
+	install -m 644 $(SECIL2TREE_MANPAGE) $(DESTDIR)$(MANDIR)/man8
 
 doc:
 	$(MAKE) -C docs
@@ -61,10 +74,13 @@ clean:
 	rm -f $(SECILC_OBJS)
 	rm -f $(SECIL2CONF)
 	rm -f $(SECIL2CONF_OBJS)
+	rm -f $(SECIL2TREE)
+	rm -f $(SECIL2TREE_OBJS)
 	rm -f policy.*
 	rm -f file_contexts
 	rm -f $(SECILC_MANPAGE)
 	rm -f $(SECIL2CONF_MANPAGE)
+	rm -f $(SECIL2TREE_MANPAGE)
 	rm -f opt-actual.cil
 	rm -f opt-actual.bin
 	$(MAKE) -C docs clean
diff --git a/secilc/secil2tree.8.xml b/secilc/secil2tree.8.xml
new file mode 100644
index 00000000..9b513eaf
--- /dev/null
+++ b/secilc/secil2tree.8.xml
@@ -0,0 +1,81 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML//EN"
+               "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd">
+
+<refentry>
+   <refentryinfo>
+      <author>
+         <firstname>James</firstname><surname>Carter</surname><contrib></contrib>
+      </author>
+   </refentryinfo>
+
+   <refmeta>
+      <refentrytitle>SECIL2TREE</refentrytitle>
+      <manvolnum>8</manvolnum>
+      <refmiscinfo class="date">05 April 2021</refmiscinfo>
+      <refmiscinfo class="source">secil2tree</refmiscinfo>
+      <refmiscinfo class="manual">SELinux CIL AST Writer</refmiscinfo>
+   </refmeta>
+   <refnamediv id="name">
+      <refname>secil2tree</refname>
+      <refpurpose>invoke the SELinux Common Intermediate Language (CIL) AST Writer </refpurpose>
+   </refnamediv>
+
+   <refsynopsisdiv id="synopsis">
+      <cmdsynopsis>
+        <command>secil2tree</command>
+          <arg choice="opt" rep="repeat"><replaceable>OPTION</replaceable></arg>
+          <arg choice="plain"><replaceable>file</replaceable></arg>
+      </cmdsynopsis>
+   </refsynopsisdiv>
+
+   <refsect1 id="description"><title>DESCRIPTION</title>
+      <para><emphasis role="italic">secil2tree</emphasis> invokes the CIL AST Writer with the specified <emphasis role="italic">argument</emphasis>s.</para>
+   </refsect1>
+
+   <refsect1 id="options"><title>OPTIONS</title>
+      <variablelist>
+         <varlistentry>
+            <term><option>-o, --output=&lt;file></option></term>
+            <listitem><para>Write AST to <emphasis role="italic">file</emphasis> (default: stdout)</para></listitem>
+         </varlistentry>
+
+         <varlistentry>
+            <term><option>-P, --preserve-tunables</option></term>
+            <listitem><para>Treat tunables as booleans.</para></listitem>
+         </varlistentry>
+
+         <varlistentry>
+            <term><option>-A, --ast-phase &lt;phase></option></term>
+            <listitem><para>Write AST of phase <emphasis role="italic">phase</emphasis>. Must be <emphasis role="bold">parse</emphasis>, <emphasis role="bold">build</emphasis>, or <emphasis role="bold">resolve</emphasis>. (default: <emphasis role="bold">resolve</emphasis>)</para></listitem>
+         </varlistentry>
+
+         <varlistentry>
+            <term><option>-v, --verbose</option></term>
+            <listitem><para>Increment verbosity level.</para></listitem>
+         </varlistentry>
+
+         <varlistentry>
+            <term><option>-h, --help</option></term>
+            <listitem><para>Display usage information.</para></listitem>
+         </varlistentry>
+      </variablelist>
+   </refsect1>
+
+   <refsect1 id="see_also"><title>SEE ALSO</title>
+      <para>
+      <simplelist type="inline">
+         <member><citerefentry>
+            <refentrytitle>secilc</refentrytitle>
+            <manvolnum>8</manvolnum>
+         </citerefentry></member>
+         <member><citerefentry>
+            <refentrytitle>secil2conf</refentrytitle>
+            <manvolnum>8</manvolnum>
+         </citerefentry></member>
+      </simplelist>
+      </para>
+      <para>HTML documentation describing the CIL language statements is available starting with <emphasis role="italic">docs/html/index.html</emphasis>.</para>
+      <para>PDF documentation describing the CIL language statements is available at: <emphasis role="italic">docs/pdf/CIL_Reference_Guide.pdf</emphasis>.</para>
+   </refsect1>
+</refentry>
diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
new file mode 100644
index 00000000..1f55d08a
--- /dev/null
+++ b/secilc/secil2tree.c
@@ -0,0 +1,206 @@
+/*
+ * Copyright 2011 Tresys Technology, LLC. All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ *    1. Redistributions of source code must retain the above copyright notice,
+ *       this list of conditions and the following disclaimer.
+ *
+ *    2. Redistributions in binary form must reproduce the above copyright notice,
+ *       this list of conditions and the following disclaimer in the documentation
+ *       and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS'' AND ANY EXPRESS
+ * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
+ * EVENT SHALL TRESYS TECHNOLOGY, LLC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * The views and conclusions contained in the software and documentation are those
+ * of the authors and should not be interpreted as representing official policies,
+ * either expressed or implied, of Tresys Technology, LLC.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <getopt.h>
+#include <sys/stat.h>
+
+#ifdef ANDROID
+#include <cil/cil.h>
+#else
+#include <sepol/cil/cil.h>
+#endif
+#include <sepol/policydb.h>
+
+enum write_ast_phase {
+	WRITE_AST_PHASE_PARSE = 0,
+	WRITE_AST_PHASE_BUILD,
+	WRITE_AST_PHASE_RESOLVE,
+};
+
+static __attribute__((__noreturn__)) void usage(const char *prog)
+{
+	printf("Usage: %s [OPTION]... FILE...\n", prog);
+	printf("\n");
+	printf("Options:\n");
+	printf("  -o, --output=<file>      write AST to <file>. (default: stdout)\n");
+	printf("  -P, --preserve-tunables  treat tunables as booleans\n");
+	printf("  -A, --ast-phase <phase>  write AST of phase <phase>. Phase must be parse, \n");
+	printf("                           build, or resolve. (default: resolve)\n");
+	printf("  -v, --verbose            increment verbosity level\n");
+	printf("  -h, --help               display usage information\n");
+	exit(1);
+}
+
+int main(int argc, char *argv[])
+{
+	int rc = SEPOL_ERR;
+	FILE *file = NULL;
+	char *buffer = NULL;
+	struct stat filedata;
+	uint32_t file_size;
+	char *output = NULL;
+	struct cil_db *db = NULL;
+	int preserve_tunables = 0;
+	enum write_ast_phase write_ast = WRITE_AST_PHASE_RESOLVE;
+	int opt_char;
+	int opt_index = 0;
+	enum cil_log_level log_level = CIL_ERR;
+	static struct option long_opts[] = {
+		{"help", no_argument, 0, 'h'},
+		{"verbose", no_argument, 0, 'v'},
+		{"preserve-tunables", no_argument, 0, 'P'},
+		{"output", required_argument, 0, 'o'},
+		{"ast-phase", required_argument, 0, 'A'},
+		{0, 0, 0, 0}
+	};
+	int i;
+
+	while (1) {
+		opt_char = getopt_long(argc, argv, "o:hvPA:", long_opts, &opt_index);
+		if (opt_char == -1) {
+			break;
+		}
+		switch (opt_char) {
+			case 'v':
+				log_level++;
+				break;
+			case 'P':
+				preserve_tunables = 1;
+				break;
+			case 'o':
+				output = strdup(optarg);
+				break;
+			case 'A':
+				if (!strcasecmp(optarg, "parse")) {
+					write_ast = WRITE_AST_PHASE_PARSE;
+				} else if (!strcasecmp(optarg, "build")) {
+					write_ast = WRITE_AST_PHASE_BUILD;
+				} else if (!strcasecmp(optarg, "resolve")) {
+					write_ast = WRITE_AST_PHASE_RESOLVE;
+				} else {
+					fprintf(stderr, "Invalid AST phase: %s\n", optarg);
+					usage(argv[0]);
+				}
+				break;
+			case 'h':
+				usage(argv[0]);
+			case '?':
+				break;
+			default:
+				fprintf(stderr, "Unsupported option: %s\n", optarg);
+				usage(argv[0]);
+		}
+	}
+
+	if (optind >= argc) {
+		fprintf(stderr, "No cil files specified\n");
+		usage(argv[0]);
+	}
+
+	cil_set_log_level(log_level);
+
+	cil_db_init(&db);
+	cil_set_preserve_tunables(db, preserve_tunables);
+	cil_set_attrs_expand_generated(db, 0);
+	cil_set_attrs_expand_size(db, 0);
+
+	for (i = optind; i < argc; i++) {
+		file = fopen(argv[i], "r");
+		if (!file) {
+			fprintf(stderr, "Could not open file: %s\n", argv[i]);
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+		rc = stat(argv[i], &filedata);
+		if (rc == -1) {
+			fprintf(stderr, "Could not stat file: %s\n", argv[i]);
+			goto exit;
+		}
+		file_size = filedata.st_size;
+
+		buffer = malloc(file_size);
+		rc = fread(buffer, file_size, 1, file);
+		if (rc != 1) {
+			fprintf(stderr, "Failure reading file: %s\n", argv[i]);
+			goto exit;
+		}
+		fclose(file);
+		file = NULL;
+
+		rc = cil_add_file(db, argv[i], buffer, file_size);
+		if (rc != SEPOL_OK) {
+			fprintf(stderr, "Failure adding %s\n", argv[i]);
+			goto exit;
+		}
+
+		free(buffer);
+		buffer = NULL;
+	}
+
+	if (output == NULL) {
+		file = stdout;
+	} else {
+		file = fopen(output, "w");
+		if (file == NULL) {
+			fprintf(stderr, "Failure opening file %s for writing\n", output);
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+	}
+
+	switch (write_ast) {
+	case WRITE_AST_PHASE_PARSE:
+		rc = cil_write_parse_ast(file, db);
+		break;
+	case WRITE_AST_PHASE_BUILD:
+		rc = cil_write_build_ast(file, db);
+		break;
+	case WRITE_AST_PHASE_RESOLVE:
+		rc = cil_write_resolve_ast(file, db);
+		break;
+	}
+
+	if (rc != SEPOL_OK) {
+		fprintf(stderr, "Failed to write AST\n");
+		goto exit;
+	}
+
+exit:
+	if (file != NULL && file != stdin) {
+		fclose(file);
+	}
+	free(buffer);
+	free(output);
+	cil_db_destroy(&db);
+	return rc;
+}
-- 
2.26.3

