Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB2C4BA04
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 22:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8789720732
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 22:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgBYWsy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:48:54 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:32892 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgBYWsy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 17:48:54 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E37FE561296
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 23:48:50 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libsepol: make ebitmap_cardinality() of linear complexity
Date:   Tue, 25 Feb 2020 23:48:41 +0100
Message-Id: <20200225224841.2693481-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb 25 23:48:51 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As ebitmap_get_bit() complexity is linear in the size of the bitmap, the
complexity of ebitmap_cardinality() is quadratic. This can be optimized
by browsing the nodes of the bitmap directly in ebitmap_cardinality().

While at it, use built-in function __builtin_popcountll() to count the
ones in the 64-bit value n->map for each bitmap node. This seems better
suited than "count++". This seems to work on gcc and clang on x86,
x86_64, ARM and ARM64 but if it causes compatibility issues with some
compilers or architectures (or with older versions of gcc or clang),
the use of __builtin_popcountll() can be replaced by a C implementation
of a popcount algorithm.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/ebitmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index d23444ce5064..a5108b7184c5 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -128,14 +128,15 @@ int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, unsigned int ma
 
 unsigned int ebitmap_cardinality(ebitmap_t *e1)
 {
-	unsigned int i, count = 0;
+	unsigned int count = 0;
+	ebitmap_node_t *n;
 
 	if (e1->cardinality || e1->highbit == 0)
 		return e1->cardinality;
 
-	for (i=ebitmap_startbit(e1); i < ebitmap_length(e1); i++)
-		if (ebitmap_get_bit(e1, i))
-			count++;
+	for (n = e1->node; n; n = n->next) {
+		count += __builtin_popcountll(n->map);
+	}
 	e1->cardinality = count;
 	return count;
 }
-- 
2.25.0

