Return-Path: <SRS0=3sNC=VZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URI_HEX,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9D1C433FF
	for <selinux@archiver.kernel.org>; Sun, 28 Jul 2019 18:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484F920644
	for <selinux@archiver.kernel.org>; Sun, 28 Jul 2019 18:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfG1SiW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Jul 2019 14:38:22 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:58954 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfG1SiW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Jul 2019 14:38:22 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 08104564707
        for <selinux@vger.kernel.org>; Sun, 28 Jul 2019 20:38:19 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libsepol: initialize a local variable once
Date:   Sun, 28 Jul 2019 20:37:49 +0200
Message-Id: <20190728183749.30044-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jul 28 20:38:20 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Function optimize_cond_av_list() initializes its local variable pcov_cur
twice. Remove the first initialization.

This issue has been found using clang's static analyzer:
https://282-118970575-gh.circle-artifacts.com/0/output-scan-build/2019-06-24-210510-6101-1/report-c64da3.html#EndPath

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 3780b68b24fe..10399a43e1cf 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -247,7 +247,7 @@ static void optimize_cond_av_list(cond_av_list_t **cond, cond_av_list_t **del,
 {
 	cond_av_list_t **listp = cond;
 	cond_av_list_t *pcov = NULL;
-	cond_av_list_t **pcov_cur = &pcov;
+	cond_av_list_t **pcov_cur;
 
 	/*
 	 * Separate out all "potentially covering" rules (src or tgt is an attr)
-- 
2.22.0

