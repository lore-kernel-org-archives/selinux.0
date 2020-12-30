Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ACBC433E0
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC43B21D94
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 10:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgL3KIm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Dec 2020 05:08:42 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:41254 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgL3KIk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Dec 2020 05:08:40 -0500
Received: from localhost.localdomain (174.17.206.77.rev.sfr.net [77.206.17.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9D99C565ABF
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 11:07:57 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/6] libsepol/cil: constify some strings
Date:   Wed, 30 Dec 2020 11:07:43 +0100
Message-Id: <20201230100746.2549568-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Dec 30 11:07:57 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Function cil_add_file() copies its input into a newly-allocated buffer,
and does not modify "name". State these properties in the types of
parameters by adding "const" qualifiers.

This enables using LibFuzzer directly on cil_add_file(), without a
warning about discarding "const" qualifier:

    fuzz-secilc.c: In function ‘LLVMFuzzerTestOneInput’:
    fuzz-secilc.c:57:31: warning: passing argument 3 of ‘cil_add_file’
    discards ‘const’ qualifier from pointer target type
    [-Wdiscarded-qualifiers]
       57 |  if (cil_add_file(db, "fuzz", data, size) != SEPOL_OK)
          |                               ^~~~
    In file included from fuzz-secilc.c:26:
    /usr/include/sepol/cil/cil.h:45:57: note: expected ‘char *’ but
    argument is of type ‘const uint8_t *’ {aka ‘const unsigned char *’}
       45 | extern int cil_add_file(cil_db_t *db, char *name, char *data, size_t size);
          |                                                   ~~~~~~^~~~

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/include/cil/cil.h | 4 ++--
 libsepol/cil/src/cil.c         | 2 +-
 libsepol/cil/src/cil_log.c     | 6 +++---
 libsepol/cil/src/cil_parser.c  | 2 +-
 libsepol/cil/src/cil_parser.h  | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
index f8cfc3be5015..e6f4503eb33a 100644
--- a/libsepol/cil/include/cil/cil.h
+++ b/libsepol/cil/include/cil/cil.h
@@ -42,7 +42,7 @@ typedef struct cil_db cil_db_t;
 extern void cil_db_init(cil_db_t **db);
 extern void cil_db_destroy(cil_db_t **db);
 
-extern int cil_add_file(cil_db_t *db, char *name, char *data, size_t size);
+extern int cil_add_file(cil_db_t *db, const char *name, const char *data, size_t size);
 
 extern int cil_compile(cil_db_t *db);
 extern int cil_build_policydb(cil_db_t *db, sepol_policydb_t **sepol_db);
@@ -67,7 +67,7 @@ enum cil_log_level {
 	CIL_INFO
 };
 extern void cil_set_log_level(enum cil_log_level lvl);
-extern void cil_set_log_handler(void (*handler)(int lvl, char *msg));
+extern void cil_set_log_handler(void (*handler)(int lvl, const char *msg));
 
 #ifdef __GNUC__
 __attribute__ ((format(printf, 2, 3)))
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index bb7f06d5c4b3..99c8e288912c 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -500,7 +500,7 @@ void cil_root_destroy(struct cil_root *root)
 	free(root);
 }
 
-int cil_add_file(cil_db_t *db, char *name, char *data, size_t size)
+int cil_add_file(cil_db_t *db, const char *name, const char *data, size_t size)
 {
 	char *buffer = NULL;
 	int rc;
diff --git a/libsepol/cil/src/cil_log.c b/libsepol/cil/src/cil_log.c
index b222b155120a..a8e4d2e94a78 100644
--- a/libsepol/cil/src/cil_log.c
+++ b/libsepol/cil/src/cil_log.c
@@ -37,14 +37,14 @@
 
 static enum cil_log_level cil_log_level = CIL_ERR;
 
-void cil_default_log_handler(__attribute__((unused)) int lvl, char *msg)
+void cil_default_log_handler(__attribute__((unused)) int lvl, const char *msg)
 {
 	fprintf(stderr, "%s", msg);
 }
 
-void (*cil_log_handler)(int lvl, char *msg) = &cil_default_log_handler;
+void (*cil_log_handler)(int lvl, const char *msg) = &cil_default_log_handler;
 
-void cil_set_log_handler(void (*handler)(int lvl, char *msg))
+void cil_set_log_handler(void (*handler)(int lvl, const char *msg))
 {
 	cil_log_handler = handler;
 }
diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index a8af1dce2c4b..b62043b95806 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -196,7 +196,7 @@ static void add_cil_path(struct cil_tree_node **current, char *path)
 	insert_node(node, *current);
 }
 
-int cil_parser(char *_path, char *buffer, uint32_t size, struct cil_tree **parse_tree)
+int cil_parser(const char *_path, char *buffer, uint32_t size, struct cil_tree **parse_tree)
 {
 
 	int paren_count = 0;
diff --git a/libsepol/cil/src/cil_parser.h b/libsepol/cil/src/cil_parser.h
index 02ecb784e95c..1cec63944fdf 100644
--- a/libsepol/cil/src/cil_parser.h
+++ b/libsepol/cil/src/cil_parser.h
@@ -32,6 +32,6 @@
 
 #include "cil_tree.h"
 
-int cil_parser(char *path, char *buffer, uint32_t size, struct cil_tree **parse_tree);
+int cil_parser(const char *path, char *buffer, uint32_t size, struct cil_tree **parse_tree);
 
 #endif /* CIL_PARSER_H_ */
-- 
2.29.2

