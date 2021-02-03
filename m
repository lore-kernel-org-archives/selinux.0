Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52874C433DB
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0786664F77
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhBCI7k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 03:59:40 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:58943 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhBCI7k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 03:59:40 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3B2DD5648FF
        for <selinux@vger.kernel.org>; Wed,  3 Feb 2021 09:58:58 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] libsepol: uniformize prototypes of sepol_mls_contains and sepol_mls_check
Date:   Wed,  3 Feb 2021 09:58:45 +0100
Message-Id: <20210203085846.6680-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210203085846.6680-1-nicolas.iooss@m4x.org>
References: <20210203085846.6680-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Feb  3 09:58:58 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In libsepol/src/mls.c, functions sepol_mls_contains and sepol_mls_check
used "sepol_policydb_t * policydb" even though
libsepol/include/sepol/context.h used "const sepol_policydb_t *
policydb".

Add const qualifiers in mls.c in order to match the header file. Detect
such mismatching error at compile time by including the header file in
mls.c.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/mls.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
index 1ee90cf8dee1..366a1114ce96 100644
--- a/libsepol/src/mls.c
+++ b/libsepol/src/mls.c
@@ -27,6 +27,7 @@
  * Implementation of the multi-level security (MLS) policy.
  */
 
+#include <sepol/context.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/context.h>
@@ -664,7 +665,7 @@ int mls_compute_sid(policydb_t * policydb,
 }
 
 int sepol_mls_contains(sepol_handle_t * handle,
-		       sepol_policydb_t * policydb,
+		       const sepol_policydb_t * policydb,
 		       const char *mls1, const char *mls2, int *response)
 {
 
@@ -703,7 +704,7 @@ int sepol_mls_contains(sepol_handle_t * handle,
 }
 
 int sepol_mls_check(sepol_handle_t * handle,
-		    sepol_policydb_t * policydb, const char *mls)
+		    const sepol_policydb_t * policydb, const char *mls)
 {
 
 	int ret;
-- 
2.30.0

