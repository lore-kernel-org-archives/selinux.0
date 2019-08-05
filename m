Return-Path: <SRS0=PMFh=WB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4CBC0650F
	for <selinux@archiver.kernel.org>; Mon,  5 Aug 2019 21:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257A120B1F
	for <selinux@archiver.kernel.org>; Mon,  5 Aug 2019 21:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfHEVNJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:13:09 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:53203 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbfHEVNJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Aug 2019 17:13:09 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 161925606B4
        for <selinux@vger.kernel.org>; Mon,  5 Aug 2019 23:13:07 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libselinux: ensure that digest_len is not zero
Date:   Mon,  5 Aug 2019 23:13:02 +0200
Message-Id: <20190805211302.28465-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Aug  5 23:13:07 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In add_xattr_entry(), if selabel_get_digests_all_partial_matches()
returns with digest_len = 0, the code gets executed as:

    sha1_buf = malloc(digest_len * 2 + 1);  /* Allocate 1 byte */

    /* ... */

    for (i = 0; i < digest_len; i++)  /* Do not do anything */
        sprintf((&sha1_buf[i * 2]), "%02x", xattr_digest[i]);

    /* ... */

    new_entry->digest = strdup(sha1_buf);  /* use of uninitiliazed content */

This is reported by some static code analyzers, even though in practise
digest_len should never be zero, and the call to sprintf() ensures that
the content of sha1_buf is initialized and terminated by '\0'.

Make sure to never call strdup() on an uninitialized string by verifying
that digest_len != 0.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/selinux_restorecon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 1be453f3b494..028d8924235f 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -309,7 +309,7 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 						&calculated_digest,
 						&xattr_digest, &digest_len);
 
-	if (!xattr_digest) {
+	if (!xattr_digest || !digest_len) {
 		free(calculated_digest);
 		return 1;
 	}
-- 
2.22.0

