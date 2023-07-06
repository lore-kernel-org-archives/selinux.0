Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F221EB64DC
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 16:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjGFQV3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 12:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFQV2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 12:21:28 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9594ADC
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 09:21:27 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so13605761fa.3
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688660486; x=1691252486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=44KMtgp7wWS/Ou9XeIt9PCnrW3cgusmK2zkiCeDwgqg=;
        b=DLSFYh+5wJz8qqTTweDmBUEjuStTWQeQiB3xOZanVjvka045RYUqnuJPHgVf6l1Qr0
         P3yBYCjS/Ki8J5N9JnDf5B/X9aQUDO+rBUL/KX8kW/HI4StDRSnqblwjGNB4QBvjDOlf
         /k0A9ILqSIIj7zFUKFtN1YEVkQWqXQdj8SHzImlXCyBhQ+uArTK34qwFAz/y2iF+hSXV
         BehtbVlcs8Z8YYdcBq3l2FPK6np0L7n6f3+9rMSr38svNHsm0/THjq7Vv0qv/UMDY9d8
         I4QqB0alEL0DqCUL8OvtiAlaUOyEouetbpS4nQqq6k90QwTOw4WK5Cc2Nr8pk7OmITTm
         IMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688660486; x=1691252486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44KMtgp7wWS/Ou9XeIt9PCnrW3cgusmK2zkiCeDwgqg=;
        b=dFLUkJVnU8dMerYjBXbmVtJfk7oOH6tgwVzQKOUVampsK17ihmdzNzjJ+3qx+lBEdO
         RRf4E2+BO10rIq3Dwd83sMF0ke5UQtYgGo20mvdKaZzdKj9GHAUXrzy3/aw38CkLRQ5z
         AhbfF08gWTJZX60YNNljCgBiofS9KebhjLed9S9J/zB+VXzLAXda4w2CrlAW9lIGp0FA
         h6c+Ho/OCIvQ9G2xOODUOp46QooLvlxKxiP2DZWD2CnaJ8Uc6Gicv3i8hnWWTq8Mi+TG
         dpyD0CoMv445BL8RmQU2hnD0NfyAKwRT/gc70PRU2Xl3MVqaWW+BCVIBJiBCcKLZijb1
         J9Bw==
X-Gm-Message-State: ABy/qLbD8pg1qzbSzEuQ4FvyZ9Rn1+SIIlJQJugZhue5kGV0+Esd+GT0
        jAueZDSVhV4Ar3sDPLi7BipuEBaiJzl81PgO
X-Google-Smtp-Source: APBJJlE+TPngVGM763zl2RPHQa/7FLvyMyhihAKkI+VGXsi0Upmbq7g+sPLyMihkSrpbGXSMLSqlSQ==
X-Received: by 2002:a2e:9844:0:b0:2b6:de6d:9e22 with SMTP id e4-20020a2e9844000000b002b6de6d9e22mr1522900ljj.40.1688660485600;
        Thu, 06 Jul 2023 09:21:25 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id a17-20020a1709062b1100b00992ea405a79sm998036ejg.166.2023.07.06.09.21.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:21:25 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] checkpolicy: free role identifier in define_role_dom()
Date:   Thu,  6 Jul 2023 18:21:20 +0200
Message-Id: <20230706162120.25610-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Free the role identifier in case the role has been already defined
beforehand, since in that case the identifier is not stored via
declare_symbol().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Triggered by the checkpolicy round-trip patch in the GitHub CI.
---
 checkpolicy/policy_define.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index cef8f3c4..e10c92ff 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3045,7 +3045,11 @@ role_datum_t *define_role_dom(role_datum_t * r)
 			yyerror("Out of memory!");
 			goto cleanup;
 		}
+	} else {
+		free(role_id);
+		role_id = NULL;
 	}
+
 	if (r) {
 		ebitmap_t types;
 		ebitmap_init(&types);
-- 
2.40.1

