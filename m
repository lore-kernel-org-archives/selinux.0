Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E93630B3
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414411; cv=none; b=RgSYNuGIMVPOM3vYI5hgmUi3eBC+hmdYJBmeUEPPkkTzJ8nH0q0ymOXazKyAyxzSH49DQKfBOUzBja81d3RGGQVDMm8xmbwfO86UwO4VcCVdWH/iqiw3sICRXwegHJjpATR/59muNOiJ0y0/qP+JDI8SpbCI3MZOEijUy0ZgjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414411; c=relaxed/simple;
	bh=KtViav88PCC5W0j4+5C6uhggjkVI52vkw6v7MhThpSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kn8m0BxC3fgdr9w4nV2O27ftlmelpfp/l+0oaAMzc82zfsHsxttV/VKNw/7VVB7M2nhS36Y2s3rWxsk/fDWruBenbsd9G3dPK9J8usaEHAs9jQhrfTK03l+fzrDvLkO2DcrQ0QgHne8nlrOfWcWPkRDq0RFdEPPalKAVXQbuoLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj94ALV7; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj94ALV7"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9157d3f2098so92974185a.3
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780414409; x=1781019209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UD2VU6Qkchj+lh95HYyUl5zeYDPjx9xHz3lCGBGkJH4=;
        b=Kj94ALV7V/yCgrRUcV9qoQ4cA4SNeU5TWdzIfe1G6pxw2qhpFIZmLXVYXuMiPgWHb9
         RhHOCuuUtVwIXhcLB5H7ZL7X+xLgLslJm2OolxHeEnKikeFkOAWXnUXAD0KxE1HSjXGn
         tb2CEBdk75I0AjJfS62Gbu/mz5piztL5KmdShJ5JVE8qJfM5EpRZD8jPG1kQsNYzt6kT
         92F8UDtKhrWrHEYdtaWoKNJpFNpMuo2q4lNuumbmWc3bTKkIBi5hp+AWIdzPapYAzgFs
         wU84T6WCuojVd6DcRrYOMCQ+P29aKlGSa8cWVJaFL56LYF9Z+pR7E8j6/voWp8DxNYej
         JxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780414409; x=1781019209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UD2VU6Qkchj+lh95HYyUl5zeYDPjx9xHz3lCGBGkJH4=;
        b=X67f2mSju8Mf8rJikJFQym2E37RNE28neK7Z0RYtOJeqr28UtBKS2oDTbqvlF5Gc2N
         0K13EpKVxzxFO/3mhi5sh1dRZHxRABDA9R1YXoZvE7d+YiTtReCZPIFRuU6le8x6IXVk
         E/tj853CDIu/f30fIo0dzD2VoO8P9NJJPAJBdGvoJP1JGqgL7PnSc+Fbyi3ngMNLid1P
         BJ9Flx28SH5VTmT9mdhsESa2irFjcpWoSxwdcDIG62NEwA/oCd47XtbroJh8NKT78Dpm
         eViIIZLD/1n987e74HXpxU2yvvg1NvFDrFbSx+e3UL02xVH3mQdca9vY2k4kXOd1MdEV
         Rn6w==
X-Gm-Message-State: AOJu0YyYsMhPBFF96Av1HeTkDwI+QeECSKos0khGGVyBj1JJHMBG4BZq
	RdrHm/PUvg0OyzpGwnOfejWnF18RA0vDUltnJy5PTtnT+MaHu49OXOZS+Sw/TA==
X-Gm-Gg: Acq92OGOKmQYdJT8mH9zY4MZqkJWOBWIv2nzcjU/E4RSp9TfbLxuq3YCVoKTsc14PS8
	CpyAzEx1XX4e4Vyj7Gg8K13OMkDcDw5F5a6s5gQ0vrvvej7JGsjYmkD/A3IvEcvsS0zCl2nTH8L
	1NjIvJJCprLgfH44dH/ssPgNC24dgIJE3N58e6YqqDb4H2t1yNIj8j1cL2karnZZ7WultQkcj16
	b4ZSLcVyEHJrVQ3DFIgkjvsQkprrKDN0+XhdnuHFXFkjeU05ONw5fYr5I1MvKuQc6o5BRxu4mOF
	Zqq2M7w47us/DE+vE0+W5wDYYXTzDuGsOQfdknFI/ua8AS5/J7rodJ363lH+c300cDxXrGkG8Ec
	dAsjxycDWtNZUMiCSivfknx0ySGV9bBdxvYntiYw9MCVWYfWjNWR2z04sQ7ZlNV9YaGESvCZeTQ
	yqzn+JwPIyO4KsUAjS+DhmR/cJQaWLYSJozZpHPQvD9Z15BZDohSCnkwTJ
X-Received: by 2002:a05:620a:1a29:b0:915:76fe:9211 with SMTP id af79cd13be357-91576fe990bmr793801885a.54.1780414408120;
        Tue, 02 Jun 2026 08:33:28 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91586c6aabesm64888385a.40.2026.06.02.08.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:33:27 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com,
	stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3 v4] secilc: Add program that checks CIL neverallows against a binary policy
Date: Tue,  2 Jun 2026 11:33:09 -0400
Message-ID: <20260602153309.157348-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602153309.157348-1-jwcart2@gmail.com>
References: <20260602153309.157348-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the program secilcheck that takes a binary policy and one or
more CIL files and checks for violations in the binary policy using
the neverallow and neverallowx rules from the CIL policy.

ex/
secilcheck policy.bin neverallows.cil

The CIL neverallow and neverallowx rules must only use types, classes,
and permissions that are declared in the binary policy.

This is planned on being used in Android to validate policies from
partners against the standard AOSP assertions as part of the
Compatibility Test Suite.

Suggested-by: Thiébaud Weksteen <tweek@google.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Added more explanation to the commit msg
    Added the header unistd.h

 secilc/.gitignore       |   2 +
 secilc/Makefile         |  20 ++-
 secilc/secilcheck.8.xml |  81 +++++++++++
 secilc/secilcheck.c     | 302 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 403 insertions(+), 2 deletions(-)
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
index 00000000..279322a5
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
+      <refmiscinfo class="date">29 May 2026</refmiscinfo>
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
index 00000000..194f4943
--- /dev/null
+++ b/secilc/secilcheck.c
@@ -0,0 +1,302 @@
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
+#include <unistd.h>
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
2.54.0

