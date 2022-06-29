Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF49C43334
	for <selinux@archiver.kernel.org>; Wed, 29 Jun 2022 07:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiF2Hcc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2Hcc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jun 2022 03:32:32 -0400
X-Greylist: delayed 333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 00:32:29 PDT
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBBA33EBA
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 00:32:29 -0700 (PDT)
Received: from localhost.localdomain (41.169.89.92.rev.sfr.net [92.89.169.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A0A025647FD
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 09:21:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m4x.org; s=svoboda;
        t=1656487264; bh=wSZSM2YWcp1vxcT25zpHfRVpdKj5n3RAodFSe/TX7BI=;
        h=From:To:Subject:Date:Message-Id;
        b=H07iOl6h+0lNhy29OIBV0QP/Dd2oHmWviSDwIJN5j8dRb1Qia0vzlEyufoDSvy4oA
         1fHIZODiIQpPJTDK6F92XKKAflvnRJMRGDVLYJyfunczKiIP8grUMkpX/0JdRo6Hnx
         //R3BkgcIj0ujQaU3k0XHm9VAf7S6M5sonsbwWGU=
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 1/1] libsepol: initialize s in constraint_expr_eval_reason
Date:   Wed, 29 Jun 2022 09:20:55 +0200
Message-Id: <20220629072055.2653695-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jun 29 09:21:04 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

clang's static analyzer reports that s[0] can be uninitialized when used
in:

    sprintf(tmp_buf, "%s %s\n",
                    xcontext ? "Validatetrans" : "Constraint",
                    s[0] ? "GRANTED" : "DENIED");

Silence this false-positive issue by making s always initialized.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index d7510e9dae51..db769cdcfaf9 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -394,7 +394,7 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
 	role_datum_t *r1, *r2;
 	mls_level_t *l1, *l2;
 	constraint_expr_t *e;
-	int s[CEXPR_MAXDEPTH];
+	int s[CEXPR_MAXDEPTH] = {};
 	int sp = -1;
 	char tmp_buf[128];
 
-- 
2.36.1

