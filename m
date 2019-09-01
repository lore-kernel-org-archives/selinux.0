Return-Path: <SRS0=nwEP=W4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276B8C3A5A7
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0797222CF7
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfIASG4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Sep 2019 14:06:56 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47685 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbfIASG4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Sep 2019 14:06:56 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5A3E6564880
        for <selinux@vger.kernel.org>; Sun,  1 Sep 2019 20:06:54 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/9] libsepol: do not dereference scope if it can be NULL
Date:   Sun,  1 Sep 2019 20:06:31 +0200
Message-Id: <20190901180636.31586-5-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190901180636.31586-1-nicolas.iooss@m4x.org>
References: <20190901180636.31586-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Sep  1 20:06:54 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Doing this looks wrong:

    len = scope->decl_ids_len;
    if (scope == NULL) {
        /* ... */

Move the dereferencing of scope after the NULL check.

This issue has been found using Infer static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/avrule_block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
index 5a873af4a864..a9832d0d118f 100644
--- a/libsepol/src/avrule_block.c
+++ b/libsepol/src/avrule_block.c
@@ -157,7 +157,7 @@ int is_id_enabled(char *id, policydb_t * p, int symbol_table)
 	scope_datum_t *scope =
 	    (scope_datum_t *) hashtab_search(p->scope[symbol_table].table, id);
 	avrule_decl_t *decl;
-	uint32_t len = scope->decl_ids_len;
+	uint32_t len;
 
 	if (scope == NULL) {
 		return 0;
@@ -166,6 +166,7 @@ int is_id_enabled(char *id, policydb_t * p, int symbol_table)
 		return 0;
 	}
 
+	len = scope->decl_ids_len;
 	if (len < 1) {
 		return 0;
 	}
-- 
2.22.0

