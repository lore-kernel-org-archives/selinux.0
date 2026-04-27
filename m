Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531141C2F1
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319767; cv=none; b=o7uTC9Mzad++CQmYCZe0YOmBr4Ha2vqYBI4Eunr0P6VMF6Su/ik6OTS798bopXl4EgRX/m9pN3rss2HnDva020PQVh2TsxCv9GFVQxtCkCbv41sKDCEU9AplNj529RXTtPutZcrLQ8snwcE5Hv93IXoteU34kHo4Gu4Z2SFOezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319767; c=relaxed/simple;
	bh=ZZVzzOsC3d5KP6jLV4nXkcUQDSUwJgUyKdk5IIvldHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTgpnX6vLmKW8rFM2SQlzgbXQ2w12bUektmWgZFdp+/XueRl4ZKLqL33GPB7n5YTHUATyUGtkJZo9EkZGLc9fsr5w1/CxHuHdxm385LzIua8O2G6Yt9ELPL6sZjBFQ1sKuj+hWKRqovBF9Mj8CuwreAYcQ/8zPxBFZMXrBDWlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjWV/lQB; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjWV/lQB"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5062fc5d86aso86792761cf.1
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777319761; x=1777924561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mDeMGGOQOmeKT1xmcaYvXW0U/ikbUMWhdVCARGh0KA=;
        b=BjWV/lQBwV2jpM6hyWrf0xudJTIe6vkY4ygnlADv7sEYbYqPaTOON7+UWitkHXUdBt
         9WNKQVxDh1j9ymA+ypuirAIKXWqv/GZ6zeaog+XtfSnghI3PVJ6gWj8qUjE5BIGy/QYi
         qcwMgP4ir5XuP6R+f0b9A5UeeGm7BI3qUx/qNx/XVTiBjofNX3VpF+4kwJ0XTRSgPlx2
         yxnujKSJwN5n2PYpLp5yDn8THLMOd8oteoOf32JlcghCrbwXyhlxNY1Hy7dChqJaMGyb
         uSQZ2pMSLhCuuzjWTKwYHUelrgNC2zB76TXA6R0C4ESY/tCjunNEldz2SwdBqLzR0lXh
         fAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777319761; x=1777924561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5mDeMGGOQOmeKT1xmcaYvXW0U/ikbUMWhdVCARGh0KA=;
        b=fZ77OpY75HNQxZsC/EFPd4dCG1tqbv8Lhze2a8eUCDChh7AV57CP5G2GfQ8J7sZVAK
         JlfXPX2/pcULpFGhrHdo5Akmq7W92Wy976f9fRrWkEIDAGQrWCyT4YMNxFrx6p4xdqiH
         ihQi1XoYdKVwlk7QjdaN0N7e6EcVVnYysq9E8EYZ3ynXXt4wf3phcu3CwOlL6JhP3lPU
         Heh+D8If0yi4wZwNZ040fSSA9FYKIm8J6lsX/0kEHeTaHQgqu6pucNQGXxnA+oFE9NQ0
         Nnclo0enrZf/Iu4rJCtNfxcpNNvttyseiYnVJ14E0PUchhJ1OO9eJRGjmfmpxiApbV5G
         j+0Q==
X-Gm-Message-State: AOJu0Yze0AEn9t+n+jV5+l0tFKntAbmE1SOWr/DTJve3DRQLic4FAfWz
	wfJr1sd3yGSmE59KH8HIvxNUO3ocpA5veC4lLy+UWIfZB4hGXUMA2QhzfU8qgA==
X-Gm-Gg: AeBDieuutSFSXl1HZzYdWwD8wLi7vaE/9p4rRwI3kSNzRaoPqwqYCJfH3kyLgb2LPU6
	DW7eVadjOOcePZRIjKGX5MD5Jh1RyMTLF9g4AaKJe8QAxA2oa1hB7ujpZo+f0x32V0R1Wz3FF1P
	CNyFbvgpoNEUr/tNHezHVJDWVGFo6gNR4zfLzo5ZPLlIIV/1Khhg/LNFMRFjkOrVW7MKWcb94T/
	Tyjwgw5JAJYNnr+tJ7mhCdMaanJ5lI/zvKnzOt5PmoC6pvOboiL8RlZJhQbQHZDm8d2OxjultVd
	PfKU92uGu/zG7UbcVoVoacuIU88VUjuRv198oRtjGMnuGGU7m7nnppNqJeRL8+37xi7o71vkApx
	dAhK8TxM5hy2j5+1qnxx2LITwuA0NxmbD3zcRQ3qCIWNpvmor8HPfK5eY7PPATbO4dRIyDntLkO
	mZBJwH46fOKgZ9Q+Qvp//KpSDbSxGOw9Sj3FIqsjQq5NhAN4VKC1jrY+cw
X-Received: by 2002:a05:622a:345:b0:50f:b6ef:e10b with SMTP id d75a77b69052e-5100c8efe00mr11597731cf.27.1777319760585;
        Mon, 27 Apr 2026 12:56:00 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5100db1ffd1sm1047601cf.14.2026.04.27.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 12:56:00 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com,
	James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 3/3] secilc: Add program that checks CIL neverallow rules against a binary policy
Date: Mon, 27 Apr 2026 15:55:46 -0400
Message-ID: <20260427195546.91395-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427195546.91395-1-jwcart2@gmail.com>
References: <20260427195546.91395-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the program secilcheck that takes a binary policy and one or
more CIL files and checks the binary policy against the neverallow
rules in the CIL policy.

ex/
secilcheck policy.bin neverallows.cil

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/.gitignore       |   2 +
 secilc/Makefile         |  20 ++-
 secilc/secilcheck.8.xml |  81 +++++++++++
 secilc/secilcheck.c     | 301 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 402 insertions(+), 2 deletions(-)
 create mode 100644 secilc/secilcheck.8.xml
 create mode 100644 secilc/secilcheck.c

diff --git a/secilc/.gitignore b/secilc/.gitignore
index d2a3daf1..9a5f45e0 100644
--- a/secilc/.gitignore
+++ b/secilc/.gitignore
@@ -4,6 +4,8 @@ secil2conf
 secil2conf.8
 secil2tree
 secil2tree.8
+secilcheck
+secilcheck.8
 policy.*
 file_contexts
 docs/html
diff --git a/secilc/Makefile b/secilc/Makefile
index ef7bc8cd..ebcc9d7c 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -14,9 +14,14 @@ SECIL2TREE = secil2tree
 SECIL2TREE_SRCS := secil2tree.c
 SECIL2TREE_OBJS := $(patsubst %.c,%.o,$(SECIL2TREE_SRCS))
 
+SECILCHECK = secilcheck
+SECILCHECK_SRCS := secilcheck.c
+SECILCHECK_OBJS := $(patsubst %.c,%.o,$(SECILCHECK_SRCS))
+
 SECILC_MANPAGE = secilc.8
 SECIL2CONF_MANPAGE = secil2conf.8
 SECIL2TREE_MANPAGE = secil2tree.8
+SECILCHECK_MANPAGE = secilcheck.8
 XMLTO = xmlto
 DIFF = diff
 
@@ -28,7 +33,7 @@ CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -Wcast-align
 override CFLAGS += -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 override LDLIBS += -lsepol
 
-all: $(SECILC) $(SECIL2CONF) $(SECIL2TREE) man
+all: $(SECILC) $(SECIL2CONF) $(SECIL2TREE) $(SECILCHECK) man
 
 $(SECILC): $(SECILC_OBJS)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
@@ -45,7 +50,10 @@ $(SECIL2CONF): $(SECIL2CONF_OBJS)
 $(SECIL2TREE): $(SECIL2TREE_OBJS)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
-man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE) $(SECIL2TREE_MANPAGE)
+$(SECILCHECK): $(SECILCHECK_OBJS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
+
+man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE) $(SECIL2TREE_MANPAGE) $(SECILCHECK_MANPAGE)
 
 $(SECILC_MANPAGE): $(SECILC_MANPAGE).xml
 	$(XMLTO) man $(SECILC_MANPAGE).xml
@@ -56,15 +64,20 @@ $(SECIL2CONF_MANPAGE): $(SECIL2CONF_MANPAGE).xml
 $(SECIL2TREE_MANPAGE): $(SECIL2TREE_MANPAGE).xml
 	$(XMLTO) man $(SECIL2TREE_MANPAGE).xml
 
+$(SECILCHECK_MANPAGE): $(SECILCHECK_MANPAGE).xml
+	$(XMLTO) man $(SECILCHECK_MANPAGE).xml
+
 install: all man
 	-mkdir -p $(DESTDIR)$(BINDIR)
 	-mkdir -p $(DESTDIR)$(MANDIR)/man8
 	install -m 755 $(SECILC) $(DESTDIR)$(BINDIR)
 	install -m 755 $(SECIL2CONF) $(DESTDIR)$(BINDIR)
 	install -m 755 $(SECIL2TREE) $(DESTDIR)$(BINDIR)
+	install -m 755 $(SECILCHECK) $(DESTDIR)$(BINDIR)
 	install -m 644 $(SECILC_MANPAGE) $(DESTDIR)$(MANDIR)/man8
 	install -m 644 $(SECIL2CONF_MANPAGE) $(DESTDIR)$(MANDIR)/man8
 	install -m 644 $(SECIL2TREE_MANPAGE) $(DESTDIR)$(MANDIR)/man8
+	install -m 644 $(SECILCHECK_MANPAGE) $(DESTDIR)$(MANDIR)/man8
 
 doc:
 	$(MAKE) -C docs
@@ -76,11 +89,14 @@ clean:
 	rm -f $(SECIL2CONF_OBJS)
 	rm -f $(SECIL2TREE)
 	rm -f $(SECIL2TREE_OBJS)
+	rm -f $(SECILCHECK)
+	rm -f $(SECILCHECK_OBJS)
 	rm -f policy.*
 	rm -f file_contexts
 	rm -f $(SECILC_MANPAGE)
 	rm -f $(SECIL2CONF_MANPAGE)
 	rm -f $(SECIL2TREE_MANPAGE)
+	rm -f $(SECILCHECK_MANPAGE)
 	rm -f opt-actual.cil
 	rm -f opt-actual.bin
 	$(MAKE) -C docs clean
diff --git a/secilc/secilcheck.8.xml b/secilc/secilcheck.8.xml
new file mode 100644
index 00000000..004e6ccd
--- /dev/null
+++ b/secilc/secilcheck.8.xml
@@ -0,0 +1,81 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
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
+      <refentrytitle>SECILCHECK</refentrytitle>
+      <manvolnum>8</manvolnum>
+      <refmiscinfo class="date">27 April 2026</refmiscinfo>
+      <refmiscinfo class="source">secilcheck</refmiscinfo>
+      <refmiscinfo class="manual">Check binary policy file against CIL neverallow files</refmiscinfo>
+   </refmeta>
+   <refnamediv id="name">
+      <refname>secilcheck</refname>
+      <refpurpose>invoke the CIL neverallow checker</refpurpose>
+   </refnamediv>
+
+   <refsynopsisdiv id="synopsis">
+      <cmdsynopsis>
+        <command>secilcheck</command>
+          <arg choice="opt" rep="repeat"><replaceable>OPTION</replaceable></arg>
+          <arg choice="plain"><replaceable>binary</replaceable></arg>
+          <arg choice="plain" rep="repeat"><replaceable>file</replaceable></arg>
+      </cmdsynopsis>
+   </refsynopsisdiv>
+
+   <refsect1 id="description"><title>DESCRIPTION</title>
+      <para><emphasis role="italic">secilcheck</emphasis> invokes the CIL neverallow checker with specified <emphasis role="italic">argument</emphasis>s.</para>
+   </refsect1>
+
+   <refsect1 id="options"><title>OPTIONS</title>
+      <variablelist>
+         <varlistentry>
+            <term><option>-Q, --qualified-names</option></term>
+            <listitem><para>Allow names containing dots (qualified names). Blocks, blockinherits, blockabstracts, and in-statements will not be allowed.</para></listitem>
+         </varlistentry>
+
+         <varlistentry>
+            <term><option>-m, --multiple-decls</option></term>
+            <listitem><para>Allow some statements to be re-declared.</para></listitem>
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
+            <refentrytitle>secil2tree</refentrytitle>
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
diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
new file mode 100644
index 00000000..874f6544
--- /dev/null
+++ b/secilc/secilcheck.c
@@ -0,0 +1,301 @@
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
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+#ifdef ANDROID
+#include <cil/cil.h>
+#else
+#include <sepol/cil/cil.h>
+#endif
+#include <sepol/policydb.h>
+#include <sepol/kernel_to_cil.h>
+
+static int get_binary_policy_db(const char *filename, sepol_policydb_t *pdb)
+{
+	int fd;
+	struct stat sb;
+	void *map = NULL;
+	sepol_policy_file_t *pf = NULL;
+	int rc = SEPOL_ERR;
+
+	/* Read binary policy */
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Could not open file: %s\n", filename);
+		goto exit;
+	}
+	if (fstat(fd, &sb) < 0) {
+		fprintf(stderr, "Could not stat file: %s\n", filename);
+		goto exit;
+	}
+	map = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED) {
+		fprintf(stderr, "Could not map file: %s\n", filename);
+		goto exit;
+	}
+
+	if (sepol_policy_file_create(&pf) < 0) {
+		fprintf(stderr, "Out of memory");
+		goto exit;
+	}
+	sepol_policy_file_set_mem(pf, map, sb.st_size);
+
+	if (sepol_policydb_read(pdb, pf) < 0) {
+		fprintf(stderr,"Error reading binary policy: %s\n", filename);
+		sepol_policydb_free(pdb);
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
+	rc = SEPOL_OK;
+
+exit:
+	if (fd >= 0)
+		close(fd);
+	if (map)
+		munmap(map, sb.st_size);
+	sepol_policy_file_free(pf);
+	return rc;
+}
+
+static int add_decls_to_cil(const char *filename, sepol_policydb_t *pdb, struct cil_db *db)
+{
+	FILE *cfp = NULL;
+	char *cptr = NULL;
+	size_t csize;
+	int rc = SEPOL_ERR;
+
+	cfp = open_memstream(&cptr, &csize);
+	if (!cfp) {
+		fprintf(stderr, "Failed to open dynamic memory buffer stream\n");
+		goto exit;
+	}
+
+	if (sepol_kernel_policydb_decls_to_cil(cfp, &pdb->p) < 0) {
+		fprintf(stderr, "Failed to convert binary policy to CIL\n");
+		goto exit;
+	}
+
+	if (fflush(cfp) < 0) {
+		fprintf(stderr, "Failed to flush CIL memory buffer stream\n");
+		goto exit;
+	}
+
+	/* Add to CIL db */
+	if (cil_add_file(db, filename, cptr, csize) < 0) {
+		fprintf(stderr, "Failed to add binary policy file: %s\n", filename);
+		goto exit;
+	}
+	
+	rc = 0;
+
+exit:
+	if (cfp)
+		fclose(cfp);
+	if (cptr)
+		free(cptr);
+	return rc;
+}
+
+static int add_cil_file(const char *filename, struct cil_db *cdb)
+{
+	FILE *file;
+	struct stat filedata;
+	char *buffer = NULL;
+	size_t file_size;
+	int rc = -1;
+
+	file = fopen(filename, "r");
+	if (!file) {
+		fprintf(stderr, "Could not open file: %s\n", filename);
+		goto exit;
+	}
+	if (stat(filename, &filedata) < 0) {
+		fprintf(stderr, "Could not stat file: %s\n", filename);
+		goto exit;
+	}
+	file_size = filedata.st_size;
+
+	if (!file_size) {
+		fclose(file);
+		rc = 0;
+		goto exit;
+	}
+
+	buffer = malloc(file_size);
+	if (!buffer) {
+		fprintf(stderr, "Out of memory\n");
+		goto exit;
+	}
+
+	if (fread(buffer, file_size, 1, file) != 1) {
+		fprintf(stderr, "Failure reading file: %s\n", filename);
+		goto exit;
+	}
+
+	if (cil_add_file(cdb, filename, buffer, file_size) < 0) {
+		fprintf(stderr, "Failure adding %s\n", filename);
+		goto exit;
+	}
+
+	rc = 0;
+
+exit:
+	if (file)
+		fclose(file);
+	if (buffer)
+		free(buffer);
+	return rc;
+}
+
+static __attribute__((__noreturn__)) void usage(const char *prog)
+{
+	printf("Usage: %s [OPTION]... BIN_POLICY CIL_NEVERALLOW_FILE1...\n", prog);
+	printf("\n");
+	printf("Options:\n");
+	printf("  -Q, --qualified-names          Allow names containing dots (qualified names).\n");
+	printf("                                 Blocks, blockinherits, blockabstracts, and\n");
+	printf("                                 in-statements will not be allowed.\n");
+	printf("  -m, --multiple-decls           allow some statements to be re-declared\n");
+	printf("  -v, --verbose                  increment verbosity level\n");
+	printf("  -h, --help                     display usage information\n");
+	exit(1);
+}
+
+int main(int argc, char *argv[])
+{
+	int rc = SEPOL_ERR;
+	sepol_policydb_t *pdb = NULL;
+	int violation = 0;
+	struct cil_db *db = NULL;
+	int multiple_decls = 0;
+	int qualified_names = 0;
+	int opt_char;
+	int opt_index = 0;
+	enum cil_log_level log_level = CIL_ERR;
+	static struct option long_opts[] = {
+		{"help", no_argument, 0, 'h'},
+		{"verbose", no_argument, 0, 'v'},
+		{"multiple-decls", no_argument, 0, 'm'},
+		{"qualified-names", no_argument, 0, 'Q'},
+		{0, 0, 0, 0}
+	};
+
+	while (1) {
+		opt_char = getopt_long(argc, argv, "hvQm", long_opts, &opt_index);
+		if (opt_char == -1) {
+			break;
+		}
+		switch (opt_char) {
+			case 'v':
+				log_level++;
+				break;
+			case 'm':
+				multiple_decls = 1;
+				break;
+			case 'Q':
+				qualified_names = 1;
+				break;
+			case 'h':
+				usage(argv[0]);
+			case '?':
+				break;
+			default:
+					fprintf(stderr, "Unsupported option: %s\n", optarg);
+				usage(argv[0]);
+		}
+	}
+
+	if (argc < optind + 2) {
+		fprintf(stderr, "Not enough files specified\n");
+		usage(argv[0]);
+	}
+
+	cil_set_log_level(log_level);
+
+	cil_db_init(&db);
+	cil_set_multiple_decls(db, multiple_decls);
+	cil_set_qualified_names(db, qualified_names);
+
+	if (sepol_policydb_create(&pdb) < 0) {
+		fprintf(stderr, "Out of memory\n");
+		goto exit;
+	}
+	if (get_binary_policy_db(argv[optind], pdb) < 0) {
+		fprintf(stderr, "Failed to get binary policy db\n");
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+	if (add_decls_to_cil(argv[optind], pdb, db) < 0) {
+		fprintf(stderr, "Failed to convert decls to CIL\n");
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+	optind++;
+
+	do {
+		if (add_cil_file(argv[optind], db) < 0) {
+			fprintf(stderr, "Failed to add cil file to CIL files\n");
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+		optind++;
+	} while (optind < argc);
+
+	rc = cil_compile(db);
+	if (rc != SEPOL_OK) {
+		fprintf(stderr, "Failed to compile cildb: %d\n", rc);
+		goto exit;
+	}
+
+	rc = cil_check_neverallows_against_pdb(db, &pdb->p, &violation);
+	if (rc != SEPOL_OK) {
+		fprintf(stderr, "Failed to complete neverallow checking\n");
+		goto exit;
+	}
+	if (violation == 1) {
+		fprintf(stderr, "There was a neverallow violation\n");
+		rc = SEPOL_ERR;
+	}
+
+	rc = SEPOL_OK;
+
+exit:
+	cil_db_destroy(&db);
+	sepol_policydb_free(pdb);
+	return rc;
+}
-- 
2.53.0

