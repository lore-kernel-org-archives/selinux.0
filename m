Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1219C433E6
	for <selinux@archiver.kernel.org>; Mon,  8 Mar 2021 20:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B74765272
	for <selinux@archiver.kernel.org>; Mon,  8 Mar 2021 20:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCHUtw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCHUtf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Mar 2021 15:49:35 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297EDC06174A
        for <selinux@vger.kernel.org>; Mon,  8 Mar 2021 12:49:35 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 130so10783378qkh.11
        for <selinux@vger.kernel.org>; Mon, 08 Mar 2021 12:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNbo3sq9lCOwtIJd4dY04nOd5zgyTnixwgT7LCwIQ34=;
        b=LWawPEM858CaHPALqCfHh/PNlFO0pSbeiVXhQngQUeuK8R9W3yn27hNeuBUrJnyzB3
         oWC+9cb5R/Vbmv03NMs/OwcMcqvKeRz1fm++Z7YMH43iCRRP1lHDhzbQS5hdNXnZ4zXz
         075B3Njd/GUBupELIMyIIikn9X5Aab9EVN65NtVA0lzo8vSNWSmYttyPWwnWJZx1kMxa
         ycC41hEPd1xfTyzHNoaRkkwwGO6WAI7SaigruSiAqC31mSohSrhM50ZHaxMRUc5P7nZ2
         X3rVHoxsd3DqNPLGN8DAA8wkBTUaROhr5ozx1JO2nPKdR95fPi4QBuCiEJphWQZlyfQE
         A0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNbo3sq9lCOwtIJd4dY04nOd5zgyTnixwgT7LCwIQ34=;
        b=Ex9W9HbaDiiug4UwmecQXgQmEKq93P9UtRVauO7jzwgqtcobR/CBQfX24CMVRpRKIs
         o/JXmJv+e2lU0Tlw74OZfinoagDfRkEw8uTFxpVKLcoBIzGjqgMrII5EgXtnGhsqySqI
         WKjc85hROdJoC1kXyhs09smDLuciwH1LVxMcYvrsN5HSFmxJ9gF54y9y4V7mEPrqUSKp
         Ym1VItAPoZaeERFq+8nquqLu3nAOhYYJ7Y96F4ICEXNJFXG2RyOhhMgJ1ttB+Y0mFM3b
         vMMi7MwKMgT/OuP5ZLRrcPdfhLCp9E9COJt6ecSoaahbmlwxWiYPsfymdGhQG0bvv3FH
         v20w==
X-Gm-Message-State: AOAM531/Xjr+rl6mk64YKiUbh8bT643lO6HllqgktpxgNQg44BuMFZju
        kjRQm9BRAkF6V2gv1BjixQiDCiPDujs=
X-Google-Smtp-Source: ABdhPJxw+tmb/CHPynFR56tiyo80tiCvm13qlne36CjVStO1ORwv9Lm1cHfam1ShiGp5k9vr+C7eTQ==
X-Received: by 2002:ae9:e015:: with SMTP id m21mr3457093qkk.420.1615236574293;
        Mon, 08 Mar 2021 12:49:34 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id i8sm4408453qtj.16.2021.03.08.12.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:49:33 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/checkpolicy: Set user roles using role value instead of dominance
Date:   Mon,  8 Mar 2021 15:49:23 -0500
Message-Id: <20210308204923.71940-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Roles in an optional block have two datums, one in the global block
and one in the avrule_decl where it is declared. The datum in the
global block does not have its dominace set. This is a problem because
the function set_user_role() sets the user's roles based on the global
datum's dominance ebitmap. If a user is declared with an associated role
that was declared in an optional block, then it will not have any roles
set for it because the dominance ebitmap is empty.

Example/
  # handle_unknown deny
  class CLASS1
  sid kernel
  class CLASS1 { PERM1 }
  type TYPE1;
  allow TYPE1 self:CLASS1 PERM1;
  role ROLE1;
  role ROLE1 types { TYPE1 };
  optional {
    require {
      class CLASS1 { PERM1 };
    }
    role ROLE1A;
    user USER1A roles ROLE1A;
  }
  user USER1 roles ROLE1;
  sid kernel USER1:ROLE1:TYPE1

In this example, USER1A would not have ROLE1A associated with it.

Instead of using dominance, which has been deprecated anyway, just
set the bit corresponding to the role's value in the user's roles
ebitmap in set_user_role().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/policy_define.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index c9286f77..6c035716 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4088,8 +4088,6 @@ cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void *arg2)
 static int set_user_roles(role_set_t * set, char *id)
 {
 	role_datum_t *r;
-	unsigned int i;
-	ebitmap_node_t *node;
 
 	if (strcmp(id, "*") == 0) {
 		free(id);
@@ -4115,12 +4113,9 @@ static int set_user_roles(role_set_t * set, char *id)
 		return -1;
 	}
 
-	/* set the role and every role it dominates */
-	ebitmap_for_each_positive_bit(&r->dominates, node, i) {
-		if (ebitmap_set_bit(&set->roles, i, TRUE))
-			goto oom;
-	}
 	free(id);
+	if (ebitmap_set_bit(&set->roles, r->s.value-1, TRUE))
+		goto oom;
 	return 0;
       oom:
 	yyerror("out of memory");
-- 
2.26.2

