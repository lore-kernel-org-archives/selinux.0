Return-Path: <SRS0=riLa=NQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3413AC0044C
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 20:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CCD20827
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 20:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CCD20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeKFGTP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:19:15 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:42460 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeKFGTP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Nov 2018 01:19:15 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 18CCA56125C
        for <selinux@vger.kernel.org>; Mon,  5 Nov 2018 21:57:41 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libselinux: selinux_restorecon: fix printf format string specifier for uint64_t
Date:   Mon,  5 Nov 2018 21:57:10 +0100
Message-Id: <20181105205710.15548-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Nov  5 21:57:41 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

fc_count is defined as uint64_t, which needs to be printed with PRIu64
(it is "llu" on x86 and "lu" on x86-64). Otherwise, building with
'CC="gcc -m32"' fails with:

    selinux_restorecon.c: In function ‘restorecon_sb’:
    selinux_restorecon.c:633:26: error: format ‘%lu’ expects argument of
    type ‘long unsigned int’, but argument 3 has type ‘uint64_t’ {aka
    ‘long long unsigned int’} [-Werror=format=]
         fprintf(stdout, "\r%luk", fc_count / STAR_COUNT);
                            ~~^
                            %llu

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/selinux_restorecon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 41f2225081e0..3df2d382d50b 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <fts.h>
+#include <inttypes.h>
 #include <limits.h>
 #include <stdint.h>
 #include <sys/types.h>
@@ -630,7 +631,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 					     fc_count / efile_count) : 100;
 				fprintf(stdout, "\r%-.1f%%", (double)pc);
 			} else {
-				fprintf(stdout, "\r%luk", fc_count / STAR_COUNT);
+				fprintf(stdout, "\r%" PRIu64 "k", fc_count / STAR_COUNT);
 			}
 			fflush(stdout);
 		}
-- 
2.19.1

