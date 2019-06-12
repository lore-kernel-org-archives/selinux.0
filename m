Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB8DC31E48
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8FA20684
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfFLIEm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:04:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfFLIEm (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Jun 2019 04:04:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 637DE23CD7F
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:41 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCAA0783AC
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:40 +0000 (UTC)
From:   Jan Zarsky <jzarsky@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 01/11] libsemanage: add helper functions to tests
Date:   Wed, 12 Jun 2019 10:03:54 +0200
Message-Id: <20190612080404.4529-2-jzarsky@redhat.com>
In-Reply-To: <20190612080404.4529-1-jzarsky@redhat.com>
References: <20190612080404.4529-1-jzarsky@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 12 Jun 2019 08:04:41 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

- Add functions for creating and destroying test semanage store.
- Add functions for writing SELinux policy to the test store.
- Add functions for creating semanage handle, connecting to the store and for
  beginning a transaction.
- Update Makefile to compile test policies from CIL source.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsemanage/tests/.gitignore            |   1 +
 libsemanage/tests/Makefile              |  11 +-
 libsemanage/tests/test_semanage_store.c |   2 +-
 libsemanage/tests/utilities.c           | 254 +++++++++++++++++++++++-
 libsemanage/tests/utilities.h           |  53 ++++-
 5 files changed, 311 insertions(+), 10 deletions(-)

diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
index f07111db..8a2a866a 100644
--- a/libsemanage/tests/.gitignore
+++ b/libsemanage/tests/.gitignore
@@ -1 +1,2 @@
 libsemanage-tests
+*.policy
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 324766a0..69f49a36 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -1,5 +1,6 @@
 # Add your test source files here:
 SOURCES = $(sort $(wildcard *.c))
+CILS = $(sort $(wildcard *.cil))
 
 ###########################################################################
 
@@ -8,15 +9,19 @@ CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../src -I../include
 override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
 
-OBJECTS = $(SOURCES:.c=.o) 
+OBJECTS = $(SOURCES:.c=.o)
+POLICIES = $(CILS:.cil=.policy)
 
-all: $(EXECUTABLE) 
+all: $(EXECUTABLE) $(POLICIES)
 
 $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
+%.policy: %.cil
+	../../secilc/secilc $*.cil -o $*.policy -f /dev/null
+
 clean distclean: 
-	rm -rf $(OBJECTS) $(EXECUTABLE)
+	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE)
 
 test: all 
 	./$(EXECUTABLE)
diff --git a/libsemanage/tests/test_semanage_store.c b/libsemanage/tests/test_semanage_store.c
index b324d502..92085361 100644
--- a/libsemanage/tests/test_semanage_store.c
+++ b/libsemanage/tests/test_semanage_store.c
@@ -43,7 +43,7 @@
 #include <unistd.h>
 #include <CUnit/Basic.h>
 
-semanage_handle_t *sh = NULL;
+extern semanage_handle_t *sh;
 const char *rootpath = "./test-policy";
 const char *polpath = "./test-policy/store/";
 const char *readlockpath = "./test-policy/store/semanage.read.LOCK";
diff --git a/libsemanage/tests/utilities.c b/libsemanage/tests/utilities.c
index 7cc726c6..18393215 100644
--- a/libsemanage/tests/utilities.c
+++ b/libsemanage/tests/utilities.c
@@ -1,6 +1,7 @@
 /* Authors: Christopher Ashworth <cashworth@tresys.com>
  *
  * Copyright (C) 2006 Tresys Technology, LLC
+ * Copyright (C) 2019 Red Hat, Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -17,16 +18,261 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-/*  The purpose of this file is to provide some functions commonly needed 
+/*  The purpose of this file is to provide some functions commonly needed
  *  by our unit tests.
  */
 
 #include "utilities.h"
 
+int test_store_enabled = 0;
+
+semanage_handle_t *sh = NULL;
+
 /* Silence any error output caused by our tests
- * by using this dummy function to catch messages. 
+ * by using this dummy function to catch messages.
  */
-void test_msg_handler(void *varg,
-		      semanage_handle_t * handle, const char *fmt, ...)
+void test_msg_handler(void *varg, semanage_handle_t *handle, const char *fmt,
+		      ...)
 {
 }
+
+int create_test_store() {
+	FILE *fptr;
+
+	if (mkdir("test-policy", 0700) < 0)
+		return -1;
+
+	if (mkdir("test-policy/store", 0700) < 0)
+		return -1;
+
+	if (mkdir("test-policy/store/active", 0700) < 0)
+		return -1;
+
+	if (mkdir("test-policy/store/active/modules", 0700) < 0)
+		return -1;
+
+	if (mkdir("test-policy/etc", 0700) < 0)
+		return -1;
+
+	if (mkdir("test-policy/etc/selinux", 0700) < 0)
+		return -1;
+
+	fptr = fopen("test-policy/etc/selinux/semanage.conf", "w+");
+
+	if (!fptr)
+		return -1;
+
+	fclose(fptr);
+
+	enable_test_store();
+	return 0;
+}
+
+void disable_test_store(void) {
+	test_store_enabled = 0;
+}
+
+void enable_test_store(void) {
+	test_store_enabled = 1;
+}
+
+int write_test_policy(char *data, size_t data_len) {
+	FILE *fptr = fopen("test-policy/store/active/policy.kern", "wb+");
+
+	if (!fptr) {
+		perror("fopen");
+		return -1;
+	}
+
+	if (fwrite(data, data_len, 1, fptr) != 1) {
+		perror("fwrite");
+		fclose(fptr);
+		return -1;
+	}
+
+	fclose(fptr);
+
+	return 0;
+}
+
+int write_test_policy_from_file(const char *filename) {
+	char *buf = NULL;
+	size_t len = 0;
+	FILE *fptr = fopen(filename, "rb");
+
+	if (!fptr) {
+		perror("fopen");
+		return -1;
+	}
+
+	fseek(fptr, 0, SEEK_END);
+	len = ftell(fptr);
+	fseek(fptr, 0, SEEK_SET);
+
+	buf = (char *) malloc(len);
+
+	if (!buf) {
+		perror("malloc");
+		fclose(fptr);
+		return -1;
+	}
+
+	fread(buf, len, 1, fptr);
+	fclose(fptr);
+
+	return write_test_policy(buf, len);
+}
+
+int write_test_policy_src(unsigned char *data, unsigned int data_len) {
+	if (mkdir("test-policy/store/active/modules/100", 0700) < 0)
+		return -1;
+
+	if (mkdir("test-policy/store/active/modules/100/base", 0700) < 0)
+		return -1;
+
+	FILE *fptr = fopen("test-policy/store/active/modules/100/base/cil",
+			   "w+");
+
+	if (!fptr) {
+		perror("fopen");
+		return -1;
+	}
+
+	if (fwrite(data, data_len, 1, fptr) != 1) {
+		perror("fwrite");
+		fclose(fptr);
+		return -1;
+	}
+
+	fclose(fptr);
+
+	fptr = fopen("test-policy/store/active/modules/100/base/lang_ext",
+		     "w+");
+
+	if (!fptr) {
+		perror("fopen");
+		return -1;
+	}
+
+	if (fwrite("cil", sizeof("cil"), 1, fptr) != 1) {
+		perror("fwrite");
+		fclose(fptr);
+		return -1;
+	}
+
+	fclose(fptr);
+
+	return 0;
+}
+
+int destroy_test_store() {
+	FTS *ftsp = NULL;
+	FTSENT *curr = NULL;
+	int ret = 0;
+
+	disable_test_store();
+
+	char *files[] = { (char *) "test-policy", NULL };
+
+	ftsp = fts_open(files, FTS_NOCHDIR | FTS_PHYSICAL | FTS_XDEV, NULL);
+
+	if (!ftsp)
+		return -1;
+
+	while ((curr = fts_read(ftsp)))
+		switch (curr->fts_info) {
+		case FTS_DP:
+		case FTS_F:
+		case FTS_SL:
+		case FTS_SLNONE:
+		case FTS_DEFAULT:
+			if (remove(curr->fts_accpath) < 0)
+				ret = -1;
+		default:
+			break;
+		}
+
+	fts_close(ftsp);
+
+	return ret;
+}
+
+void helper_handle_create(void) {
+	if (test_store_enabled)
+		semanage_set_root("test-policy");
+
+	sh = semanage_handle_create();
+	CU_ASSERT_PTR_NOT_NULL(sh);
+
+	semanage_msg_set_callback(sh, test_msg_handler, NULL);
+
+	if (test_store_enabled) {
+		semanage_set_create_store(sh, 1);
+		semanage_set_reload(sh, 0);
+		semanage_set_store_root(sh, "");
+		semanage_select_store(sh, (char *) "store",
+				      SEMANAGE_CON_DIRECT);
+	}
+}
+
+void helper_handle_destroy(void) {
+	semanage_handle_destroy(sh);
+}
+
+void helper_connect(void) {
+	CU_ASSERT(semanage_connect(sh) >= 0);
+}
+
+void helper_disconnect(void) {
+	CU_ASSERT(semanage_disconnect(sh) >= 0);
+}
+
+void helper_begin_transaction(void) {
+	CU_ASSERT(semanage_begin_transaction(sh) >= 0);
+}
+
+void helper_commit(void) {
+	CU_ASSERT(semanage_commit(sh) >= 0);
+}
+
+void setup_handle(level_t level) {
+	if (level >= SH_NULL)
+		sh = NULL;
+
+	if (level >= SH_HANDLE)
+		helper_handle_create();
+
+	if (level >= SH_CONNECT)
+		helper_connect();
+
+	if (level >= SH_TRANS)
+		helper_begin_transaction();
+}
+
+void cleanup_handle(level_t level) {
+	if (level >= SH_TRANS)
+		helper_commit();
+
+	if (level >= SH_CONNECT)
+		helper_disconnect();
+
+	if (level >= SH_HANDLE)
+		helper_handle_destroy();
+
+	if (level >= SH_NULL)
+		sh = NULL;
+}
+
+void setup_handle_invalid_store(level_t level) {
+	CU_ASSERT(level >= SH_HANDLE);
+
+	helper_handle_create();
+
+	semanage_select_store(sh, (char *) "", SEMANAGE_CON_INVALID);
+
+	if (level >= SH_CONNECT)
+		helper_connect();
+
+	if (level >= SH_TRANS)
+		helper_begin_transaction();
+}
diff --git a/libsemanage/tests/utilities.h b/libsemanage/tests/utilities.h
index 781867d1..c9d54d1e 100644
--- a/libsemanage/tests/utilities.h
+++ b/libsemanage/tests/utilities.h
@@ -1,6 +1,7 @@
 /* Authors: Christopher Ashworth <cashworth@tresys.com>
  *
  * Copyright (C) 2006 Tresys Technology, LLC
+ * Copyright (C) 2019 Red Hat, Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -17,7 +18,55 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include "handle.h"
+#ifndef __UTILITIES_H__
+#define __UTILITIES_H__
 
-void test_msg_handler(void *varg, semanage_handle_t * handle, const char *fmt,
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <fts.h>
+#include <assert.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <CUnit/Basic.h>
+
+#include "semanage/semanage.h"
+
+#define CU_ASSERT_CONTEXT_EQUAL(CON1,CON2) \
+	do { \
+		char *__str; \
+		char *__str2; \
+		CU_ASSERT(semanage_context_to_string(sh, CON1, &__str) >= 0); \
+		CU_ASSERT(semanage_context_to_string(sh, CON2, &__str2) >= 0); \
+		CU_ASSERT_STRING_EQUAL(__str, __str2); \
+	} while (0)
+
+#define I_NULL  -1
+#define I_FIRST  0
+#define I_SECOND 1
+#define I_THIRD  2
+
+typedef enum { SH_NULL, SH_HANDLE, SH_CONNECT, SH_TRANS } level_t;
+
+void test_msg_handler(void *varg, semanage_handle_t *handle, const char *fmt,
 		      ...);
+
+void setup_handle(level_t level);
+void cleanup_handle(level_t level);
+void setup_handle_invalid_store(level_t level);
+
+void helper_handle_create(void);
+void helper_handle_destroy(void);
+void helper_connect(void);
+void helper_disconnect(void);
+void helper_begin_transaction(void);
+void helper_commit(void);
+
+int create_test_store(void);
+int write_test_policy_from_file(const char *filename);
+int write_test_policy_src(unsigned char *data, unsigned int data_len);
+int destroy_test_store(void);
+void enable_test_store(void);
+void disable_test_store(void);
+
+#endif
-- 
2.20.1

