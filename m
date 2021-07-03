Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA66C07E97
	for <selinux@archiver.kernel.org>; Sat,  3 Jul 2021 14:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D265261490
	for <selinux@archiver.kernel.org>; Sat,  3 Jul 2021 14:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhGCOe1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Jul 2021 10:34:27 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:54816 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhGCOeW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Jul 2021 10:34:22 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8C8CB564DD4
        for <selinux@vger.kernel.org>; Sat,  3 Jul 2021 16:31:47 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/6] checkpolicy: silence -Wextra-semi-stmt warning
Date:   Sat,  3 Jul 2021 16:31:20 +0200
Message-Id: <20210703143122.1441578-4-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210703143122.1441578-1-nicolas.iooss@m4x.org>
References: <20210703143122.1441578-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jul  3 16:31:47 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Ubuntu 20.04, when building with clang -Werror -Wextra-semi-stmt
(which is not the default build configuration), the compiler reports:

      checkpolicy.c:740:33: error: empty expression statement has no
      effect; remove unnecessary ';' to silence this warning
      [-Werror,-Wextra-semi-stmt]
                      FGETS(ans, sizeof(ans), stdin);
                                                    ^

Introduce "do { } while (0)" blocks to silence such warnings.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/checkpolicy.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index acf1eac41559..8af31db5c6b7 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -119,11 +119,14 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 }
 
 #define FGETS(out, size, in) \
-if (fgets(out,size,in)==NULL) {	\
-		fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,\
-				strerror(errno)); \
-			exit(1);\
-}
+do { \
+	if (fgets(out,size,in)==NULL) {	\
+		fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__, \
+			strerror(errno)); \
+		exit(1);\
+	} \
+} while (0)
+
 static int print_sid(sepol_security_id_t sid,
 		     context_struct_t * context
 		     __attribute__ ((unused)), void *data
-- 
2.32.0

