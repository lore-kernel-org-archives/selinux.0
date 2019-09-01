Return-Path: <SRS0=nwEP=W4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URI_HEX,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7596FC3A5A4
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F142190F
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfIASG5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Sep 2019 14:06:57 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:59543 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfIASG5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Sep 2019 14:06:57 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7900C564880
        for <selinux@vger.kernel.org>; Sun,  1 Sep 2019 20:06:55 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 6/9] libsepol/cil: do not dereference perm_value_to_cil when it has not been allocated
Date:   Sun,  1 Sep 2019 20:06:33 +0200
Message-Id: <20190901180636.31586-7-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190901180636.31586-1-nicolas.iooss@m4x.org>
References: <20190901180636.31586-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Sep  1 20:06:55 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When one of the first allocations of cil_binary_create_allocated_pdb()
fails, the exit label dereferences the items of array perm_value_to_cil
even though it could be still NULL.

This issue has been found using clang's static analyzer:
https://327-118970575-gh.circle-artifacts.com/0/output-scan-build/2019-08-05-203459-6149-1/report-febf85.html#EndPath

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_binary.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 77ffc36f20ff..c882d5b74226 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -5043,11 +5043,13 @@ exit:
 	hashtab_destroy(avrulex_ioctl_table);
 	free(type_value_to_cil);
 	free(class_value_to_cil);
-	/* Range is because libsepol values start at 1. */
-	for (i=1; i < db->num_classes+1; i++) {
-		free(perm_value_to_cil[i]);
+	if (perm_value_to_cil != NULL) {
+		/* Range is because libsepol values start at 1. */
+		for (i=1; i < db->num_classes+1; i++) {
+			free(perm_value_to_cil[i]);
+		}
+		free(perm_value_to_cil);
 	}
-	free(perm_value_to_cil);
 	cil_list_destroy(&neverallows, CIL_FALSE);
 
 	return rc;
-- 
2.22.0

