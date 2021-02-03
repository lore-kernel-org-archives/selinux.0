Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5ECC433E9
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317EF64E49
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhBCI7n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 03:59:43 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:57622 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhBCI7l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 03:59:41 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 22F425648FF
        for <selinux@vger.kernel.org>; Wed,  3 Feb 2021 09:58:59 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] libsepol: include header files in source files when matching declarations
Date:   Wed,  3 Feb 2021 09:58:46 +0100
Message-Id: <20210203085846.6680-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210203085846.6680-1-nicolas.iooss@m4x.org>
References: <20210203085846.6680-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Feb  3 09:58:59 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It is good practise in C to include the header file that specifies the
prototype of functions which are defined in the source file. Otherwise,
the function prototypes which be different, which could cause unexpected
issues.

Add the include directives to do this.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_find.c      | 1 +
 libsepol/cil/src/cil_fqn.c       | 1 +
 libsepol/cil/src/cil_mem.c       | 1 +
 libsepol/cil/src/cil_parser.c    | 1 +
 libsepol/cil/src/cil_policy.c    | 1 +
 libsepol/cil/src/cil_reset_ast.c | 1 +
 libsepol/src/kernel_to_cil.c     | 1 +
 libsepol/src/kernel_to_conf.c    | 1 +
 libsepol/src/services.c          | 1 +
 9 files changed, 9 insertions(+)

diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
index 638b675db826..3898725f18d5 100644
--- a/libsepol/cil/src/cil_find.c
+++ b/libsepol/cil/src/cil_find.c
@@ -30,6 +30,7 @@
 #include <sepol/policydb/ebitmap.h>
 
 #include "cil_internal.h"
+#include "cil_find.h"
 #include "cil_flavor.h"
 #include "cil_list.h"
 #include "cil_log.h"
diff --git a/libsepol/cil/src/cil_fqn.c b/libsepol/cil/src/cil_fqn.c
index 2e76f8737754..097222a83da9 100644
--- a/libsepol/cil/src/cil_fqn.c
+++ b/libsepol/cil/src/cil_fqn.c
@@ -31,6 +31,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include "cil_fqn.h"
 #include "cil_internal.h"
 #include "cil_log.h"
 #include "cil_strpool.h"
diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
index f73021b58d50..8e4a1d246f2c 100644
--- a/libsepol/cil/src/cil_mem.c
+++ b/libsepol/cil/src/cil_mem.c
@@ -33,6 +33,7 @@
 #include <string.h>
 
 #include "cil_log.h"
+#include "cil_mem.h"
 
 void *cil_malloc(size_t size)
 {
diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index b62043b95806..0038eed6dd1b 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -38,6 +38,7 @@
 #include "cil_mem.h"
 #include "cil_tree.h"
 #include "cil_lexer.h"
+#include "cil_parser.h"
 #include "cil_strpool.h"
 #include "cil_stack.h"
 
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 06d7d74e54c3..74edb34575ea 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -41,6 +41,7 @@
 #include "cil_flavor.h"
 #include "cil_find.h"
 #include "cil_mem.h"
+#include "cil_policy.h"
 #include "cil_tree.h"
 #include "cil_list.h"
 #include "cil_symtab.h"
diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 52e5f64011d2..3da1b9a64167 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -2,6 +2,7 @@
 #include "cil_internal.h"
 #include "cil_log.h"
 #include "cil_list.h"
+#include "cil_reset_ast.h"
 #include "cil_symtab.h"
 
 static inline void cil_reset_classperms_list(struct cil_list *cp_list);
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index c247b32f9e75..a146ac514018 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -16,6 +16,7 @@
 #define IPPROTO_SCTP 132
 #endif
 
+#include <sepol/kernel_to_cil.h>
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/hashtab.h>
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 62bf706c1aa0..a22f196df9e9 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -15,6 +15,7 @@
 #define IPPROTO_SCTP 132
 #endif
 
+#include <sepol/kernel_to_conf.h>
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/hashtab.h>
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 72b39657cd2e..6596431c38e2 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -59,6 +59,7 @@
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/util.h>
+#include <sepol/sepol.h>
 
 #include "debug.h"
 #include "private.h"
-- 
2.30.0

