Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAMJIcuk008417
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 14:18:38 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2 v2] secilc: Add secil2conf which creates a policy.conf
 from CIL policy
Date: Tue, 22 Nov 2016 14:18:16 -0500
Message-Id: <1479842296-21906-3-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1479842296-21906-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1479842296-21906-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The program secil2conf uses the libsepol function
cil_write_policy_conf() to create a policy.conf file from CIL policy.

By default a file called "policy.conf" will be created, but the "-o"
option can be used to write to a different file. The "-M" option can
be used to override the mls statement in CIL. The "-P" option will
cause tunables to be treated as booleans.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 secilc/.gitignore       |   2 +
 secilc/Makefile         |  32 ++++++--
 secilc/secil2conf.8.xml |  82 +++++++++++++++++++++
 secilc/secil2conf.c     | 192 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 300 insertions(+), 8 deletions(-)
 create mode 100644 secilc/secil2conf.8.xml
 create mode 100644 secilc/secil2conf.c

diff --git a/secilc/.gitignore b/secilc/.gitignore
index f659d80..2d3ff40 100644
--- a/secilc/.gitignore
+++ b/secilc/.gitignore
@@ -1,5 +1,7 @@
 secilc
 secilc.8
+secil2conf
+secil2conf.8
 policy.*
 file_contexts
 docs/html
diff --git a/secilc/Makefile b/secilc/Makefile
index 40254ce..e714a84 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -5,19 +5,24 @@ LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 
 LDLIBS = -lsepol -L$(LIBDIR)
+
 SECILC = secilc
 SECILC_SRCS := secilc.c
 SECILC_OBJS := $(patsubst %.c,%.o,$(SECILC_SRCS))
 
-# The secilc man page:
-MANPAGE = secilc.8
+SECIL2CONF = secil2conf
+SECIL2CONF_SRCS := secil2conf.c
+SECIL2CONF_OBJS := $(patsubst %.c,%.o,$(SECIL2CONF_SRCS))
+
+SECILC_MANPAGE = secilc.8
+SECIL2CONF_MANPAGE = secil2conf.8
 XMLTO = xmlto
 
 CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused
 
 override CFLAGS += -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 
-all: $(SECILC) man
+all: $(SECILC) $(SECIL2CONF) man
 
 $(SECILC): $(SECILC_OBJS)
 	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)
@@ -25,16 +30,24 @@ $(SECILC): $(SECILC_OBJS)
 test: $(SECILC)
 	./$(SECILC) test/policy.cil
 
-man: $(MANPAGE)
+$(SECIL2CONF): $(SECIL2CONF_OBJS)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)
+
+man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE)
+
+$(SECILC_MANPAGE): $(SECILC_MANPAGE).xml
+	$(XMLTO) man $(SECILC_MANPAGE).xml
 
-$(MANPAGE): $(MANPAGE).xml
-	$(XMLTO) man $(MANPAGE).xml
+$(SECIL2CONF_MANPAGE): $(SECIL2CONF_MANPAGE).xml
+	$(XMLTO) man $(SECIL2CONF_MANPAGE).xml
 
 install: all man
 	-mkdir -p $(BINDIR)
 	-mkdir -p $(MANDIR)/man8
 	install -m 755 $(SECILC) $(BINDIR)
-	install -m 644 $(MANPAGE) $(MANDIR)/man8
+	install -m 755 $(SECIL2CONF) $(BINDIR)
+	install -m 644 $(SECILC_MANPAGE) $(MANDIR)/man8
+	install -m 644 $(SECIL2CONF_MANPAGE) $(MANDIR)/man8
 
 doc:
 	$(MAKE) -C docs
@@ -42,9 +55,12 @@ doc:
 clean:
 	rm -f $(SECILC)
 	rm -f $(SECILC_OBJS)
+	rm -f $(SECIL2CONF)
+	rm -f $(SECIL2CONF_OBJS)
 	rm -f policy.*
 	rm -f file_contexts
-	rm -f $(MANPAGE)
+	rm -f $(SECILC_MANPAGE)
+	rm -f $(SECIL2CONF_MANPAGE)
 
 relabel:
 
diff --git a/secilc/secil2conf.8.xml b/secilc/secil2conf.8.xml
new file mode 100644
index 0000000..59d87a5
--- /dev/null
+++ b/secilc/secil2conf.8.xml
@@ -0,0 +1,82 @@
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
+      <refentrytitle>SECIL2CONF</refentrytitle>
+      <manvolnum>8</manvolnum>
+      <refmiscinfo class="date">21 November 2016</refmiscinfo>
+      <refmiscinfo class="source">secil2conf</refmiscinfo>
+      <refmiscinfo class="manual">SELinux CIL to policy.conf Converter</refmiscinfo>
+   </refmeta>
+   <refnamediv id="name">
+      <refname>secil2conf</refname>
+      <refpurpose>invoke the SELinux Common Intermediate Language (CIL) to policy.conf converter</refpurpose>
+   </refnamediv>
+
+   <refsynopsisdiv id="synopsis">
+      <cmdsynopsis>
+        <command>secil2conf</command>
+          <arg choice="opt" rep="repeat"><replaceable>OPTION</replaceable></arg>
+          <arg choice="plain"><replaceable>file</replaceable></arg>
+      </cmdsynopsis>
+   </refsynopsisdiv>
+
+   <refsect1 id="description"><title>DESCRIPTION</title>
+      <para><emphasis role="italic">secil2conf</emphasis> invokes the CIL to policy.conf converter with the specified <emphasis role="italic">argument</emphasis>s.</para>
+   </refsect1>
+
+   <refsect1 id="options"><title>OPTIONS</title>
+      <variablelist>
+         <varlistentry>
+            <term><option>-o, --output=&lt;file></option></term>
+            <listitem><para>Write policy.conf to <emphasis role="italic">file</emphasis> (default: policy.conf)</para></listitem>
+         </varlistentry>
+
+         <varlistentry>
+            <term><option>-M, --mls true|false</option></term>
+            <listitem><para>Build an mls policy.conf. Must be <emphasis role="bold">true</emphasis> or <emphasis role="bold">false</emphasis>. This will override the <emphasis role="bold">(mls <emphasis role="italic">boolean</emphasis></emphasis><emphasis role="bold">)</emphasis> statement if present in the policy.</para></listitem>
+         </varlistentry>
+
+         <varlistentry>
+            <term><option>-P, --preserve-tunables</option></term>
+            <listitem><para>Treat tunables as booleans.</para></listitem>
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
+            <refentrytitle>sestatus</refentrytitle>
+            <manvolnum>8</manvolnum>
+         </citerefentry></member>
+      </simplelist>
+      </para>
+      <para>HTML documentation describing the CIL language statements is available starting with <emphasis role="italic">docs/html/index.html</emphasis>.</para>
+      <para>PDF documentation describing the CIL language statements is available at: <emphasis role="italic">docs/pdf/CIL_Reference_Guide.pdf</emphasis>.</para>
+      <para>There is a CIL Design Wiki at: <ulink url="http://github.com/SELinuxProject/cil/wiki"></ulink> that describes the goals and features of the CIL language.</para>
+   </refsect1>
+</refentry>
diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
new file mode 100644
index 0000000..ff564f0
--- /dev/null
+++ b/secilc/secil2conf.c
@@ -0,0 +1,192 @@
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
+void usage(char *prog)
+{
+	printf("Usage: %s [OPTION]... FILE...\n", prog);
+	printf("\n");
+	printf("Options:\n");
+	printf("  -o, --output=<file>            write policy.conf to <file>\n");
+	printf("                                 (default: policy.conf)\n");
+	printf("  -M, --mls true|false           write an mls policy. Must be true or false.\n");
+	printf("                                 This will override the (mls boolean) statement\n");
+	printf("                                 if present in the policy\n");
+	printf("  -P, --preserve-tunables        treat tunables as booleans\n");
+	printf("  -v, --verbose                  increment verbosity level\n");
+	printf("  -h, --help                     display usage information\n");
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
+	int mls = -1;
+	int preserve_tunables = 0;
+	int opt_char;
+	int opt_index = 0;
+	enum cil_log_level log_level = CIL_ERR;
+	static struct option long_opts[] = {
+		{"help", no_argument, 0, 'h'},
+		{"verbose", no_argument, 0, 'v'},
+		{"mls", required_argument, 0, 'M'},
+		{"preserve-tunables", no_argument, 0, 'P'},
+		{"output", required_argument, 0, 'o'},
+		{0, 0, 0, 0}
+	};
+	int i;
+
+	while (1) {
+		opt_char = getopt_long(argc, argv, "o:hvM:P", long_opts, &opt_index);
+		if (opt_char == -1) {
+			break;
+		}
+		switch (opt_char) {
+			case 'v':
+				log_level++;
+				break;
+			case 'M':
+				if (!strcasecmp(optarg, "true") || !strcasecmp(optarg, "1")) {
+					mls = 1;
+				} else if (!strcasecmp(optarg, "false") || !strcasecmp(optarg, "0")) {
+					mls = 0;
+				} else {
+					usage(argv[0]);
+				}
+				break;
+			case 'P':
+				preserve_tunables = 1;
+				break;
+			case 'o':
+				output = strdup(optarg);
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
+	if (optind >= argc) {
+		fprintf(stderr, "No cil files specified\n");
+		usage(argv[0]);
+	}
+
+	cil_set_log_level(log_level);
+
+	cil_db_init(&db);
+	cil_set_preserve_tunables(db, preserve_tunables);
+	cil_set_mls(db, mls);
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
+	rc = cil_compile(db);
+	if (rc != SEPOL_OK) {
+		fprintf(stderr, "Failed to compile cildb: %d\n", rc);
+		goto exit;
+	}
+
+	if (output == NULL) {
+		file = fopen("policy.conf", "w");
+	} else {
+		file = fopen(output, "w");
+	}
+	if (file == NULL) {
+		fprintf(stderr, "Failure opening policy.conf file for writing\n");
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
+	cil_write_policy_conf(file, db);
+
+	fclose(file);
+	file = NULL;
+	rc = SEPOL_OK;
+
+exit:
+	if (file != NULL) {
+		fclose(file);
+	}
+	free(buffer);
+	free(output);
+	cil_db_destroy(&db);
+	return rc;
+}
-- 
2.7.4
