Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50BAC388F9
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 21:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805DE20679
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 21:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgKKV36 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:29:58 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:56683 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKV36 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Nov 2020 16:29:58 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 37C32564913
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 22:29:56 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libsepol: free memory when realloc() fails
Date:   Wed, 11 Nov 2020 22:29:44 +0100
Message-Id: <20201111212944.17659-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Nov 11 22:29:56 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In get_class_info(), if realloc(class_buf, new_class_buf_len) fails to
grow the memory, the function returns NULL without freeing class_buf.
This leads to a memory leak which is reported by clang's static
analyzer:
https://580-118970575-gh.circle-artifacts.com/0/output-scan-build/2020-11-11-194150-6152-1/report-42a899.html#EndPath

Fix the memory leak by calling free(class_buf).

While at it, use size_t insted of int to store the size of the buffer
which is growing.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/services.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index beb0711f6680..72b39657cd2e 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -312,17 +312,20 @@ static char *get_class_info(sepol_security_class_t tclass,
 	else
 		state_num = mls + 2;
 
-	int class_buf_len = 0;
-	int new_class_buf_len;
-	int len, buf_used;
+	size_t class_buf_len = 0;
+	size_t new_class_buf_len;
+	size_t buf_used;
+	int len;
 	char *class_buf = NULL, *p;
 	char *new_class_buf = NULL;
 
 	while (1) {
 		new_class_buf_len = class_buf_len + EXPR_BUF_SIZE;
 		new_class_buf = realloc(class_buf, new_class_buf_len);
-			if (!new_class_buf)
-				return NULL;
+		if (!new_class_buf) {
+			free(class_buf);
+			return NULL;
+		}
 		class_buf_len = new_class_buf_len;
 		class_buf = new_class_buf;
 		buf_used = 0;
@@ -330,7 +333,7 @@ static char *get_class_info(sepol_security_class_t tclass,
 
 		/* Add statement type */
 		len = snprintf(p, class_buf_len - buf_used, "%s", statements[state_num]);
-		if (len < 0 || len >= class_buf_len - buf_used)
+		if (len < 0 || (size_t)len >= class_buf_len - buf_used)
 			continue;
 
 		/* Add class entry */
@@ -338,7 +341,7 @@ static char *get_class_info(sepol_security_class_t tclass,
 		buf_used += len;
 		len = snprintf(p, class_buf_len - buf_used, "%s ",
 				policydb->p_class_val_to_name[tclass - 1]);
-		if (len < 0 || len >= class_buf_len - buf_used)
+		if (len < 0 || (size_t)len >= class_buf_len - buf_used)
 			continue;
 
 		/* Add permission entries (validatetrans does not have perms) */
@@ -351,7 +354,7 @@ static char *get_class_info(sepol_security_class_t tclass,
 		} else {
 			len = snprintf(p, class_buf_len - buf_used, "(");
 		}
-		if (len < 0 || len >= class_buf_len - buf_used)
+		if (len < 0 || (size_t)len >= class_buf_len - buf_used)
 			continue;
 		break;
 	}
-- 
2.29.2

