Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3781CC11F75
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 08:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F92460FF3
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 08:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351528AbhGLIz0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 04:55:26 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:49627 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356416AbhGLIrk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 04:47:40 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5D6C45606AD
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 10:44:50 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: do not allow \0 in quoted strings
Date:   Mon, 12 Jul 2021 10:44:28 +0200
Message-Id: <20210712084428.73440-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Jul 12 10:44:50 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Using the '\0' character in strings in a CIL policy is not expected to
happen, and makes the flex tokenizer very slow. For example when
generating a file with:

    python -c 'print("\"" + "\0"*100000 + "\"")' > policy.cil

secilc fails after 26 seconds, on my desktop computer. Increasing the
numbers of \0 makes this time increase significantly. But replacing \0
with another character makes secilc fail in only few milliseconds.

Fix this "possible denial of service" issue by forbidding \0 in strings
in CIL policies.

Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=36016

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_lexer.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_lexer.l b/libsepol/cil/src/cil_lexer.l
index e28c33ecb9f1..8bf2b6e7765a 100644
--- a/libsepol/cil/src/cil_lexer.l
+++ b/libsepol/cil/src/cil_lexer.l
@@ -49,7 +49,7 @@ spec_char	[\[\]\.\@\=\/\*\-\_\$\%\+\-\!\|\&\^\:\~\`\#\{\}\'\<\>\?\,]
 symbol		({digit}|{alpha}|{spec_char})+
 white		[ \t]
 newline		[\n\r]
-qstring		\"[^"\n]*\"
+qstring		\"[^"\n\0]*\"
 hll_lm          ^;;\*
 comment		;
 
-- 
2.32.0

