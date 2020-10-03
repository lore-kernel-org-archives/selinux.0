Return-Path: <SRS0=OlHu=DK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250D1C4727D
	for <selinux@archiver.kernel.org>; Sat,  3 Oct 2020 19:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAA1206DD
	for <selinux@archiver.kernel.org>; Sat,  3 Oct 2020 19:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgJCTkH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Oct 2020 15:40:07 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:46320 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgJCTkH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Oct 2020 15:40:07 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id AD5B55600AD
        for <selinux@vger.kernel.org>; Sat,  3 Oct 2020 21:40:05 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libsepol: silence potential NULL pointer dereference warning
Date:   Sat,  3 Oct 2020 21:39:57 +0200
Message-Id: <20201003193957.1876526-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201003193957.1876526-1-nicolas.iooss@m4x.org>
References: <20201003193957.1876526-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Oct  3 21:40:05 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When find_avtab_node() is called with key->specified & AVTAB_XPERMS and
xperms=NULL, xperms is being dereferenced. This is detected as a
"NULL pointer dereference issue" by static analyzers.

Even though it does not make much sense to call find_avtab_node() in a
way which triggers the NULL pointer dereference issue, static analyzers
have a hard time with calls such as:

    node = find_avtab_node(handle, avtab, &avkey, cond, NULL);

... where xperms=NULL.

So, make the function report an error instead of crashing.

Here is an example of report from clang's static analyzer:
https://558-118970575-gh.circle-artifacts.com/0/output-scan-build/2020-10-02-065849-6375-1/report-d86a57.html#EndPath

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/expand.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 19e48c507236..eac7e4507d02 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1570,17 +1570,22 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 
 	/* AVTAB_XPERMS entries are not necessarily unique */
 	if (key->specified & AVTAB_XPERMS) {
-		node = avtab_search_node(avtab, key);
-		while (node) {
-			if ((node->datum.xperms->specified == xperms->specified) &&
-				(node->datum.xperms->driver == xperms->driver)) {
-				match = 1;
-				break;
+		if (xperms == NULL) {
+			ERR(handle, "searching xperms NULL");
+			node = NULL;
+		} else {
+			node = avtab_search_node(avtab, key);
+			while (node) {
+				if ((node->datum.xperms->specified == xperms->specified) &&
+					(node->datum.xperms->driver == xperms->driver)) {
+					match = 1;
+					break;
+				}
+				node = avtab_search_node_next(node, key->specified);
 			}
-			node = avtab_search_node_next(node, key->specified);
+			if (!match)
+				node = NULL;
 		}
-		if (!match)
-			node = NULL;
 	} else {
 		node = avtab_search_node(avtab, key);
 	}
-- 
2.28.0

