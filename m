Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EC3C11F69
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976E761C44
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhGFR5Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhGFR5Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09241C061574
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h2so29212239edt.3
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oav1PeRGPMZWIm7UG7Np40qqDwAtjIlXIG+x9/XHnYo=;
        b=JXZcUQi6qz9Y9IR+CLJ2fprBQaZjo0FQvhrsAOHEztk26HCd2dQOs07oyHtiobi5GF
         vZ/3jNRiEGlUf1nK44il+1HtyhPTVOa5X0IH6lajE0rI6pArXsmw+nXJrGcpoGfKy78i
         vVKQjzo2hCQHlvZrNig8/EW/KerLDjveHTcIZeDctHLvnxeCzRtC10V69xHP4n11KeJ0
         2BDbqtX5Ku4BGHq7jgYrntt32APgEwiumM+WaTJr2/wzbvkjSaMg51WcgJ2nVkUjrnhm
         3nHCkzIiolvGAJ3X/vfgwLjbmb9IMiPESb8EHQstpZIqmVNQbg9FN2KjwDP1Tcs3gnK0
         Weyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oav1PeRGPMZWIm7UG7Np40qqDwAtjIlXIG+x9/XHnYo=;
        b=ock2PVUQkmd1ShSfajGDf5iAptqMZvSfvzm5AFXpuaEJO7gBC9brpmcYjqbcnENE7U
         UySfyXnoUBarIw9jvA5Fyogu41Z3foPRE4+MmySJ71cYevIdHxSxWveaBgMv+cXc9SP1
         oPkRzwusVp/Ri1nIi0KDfZoEwpcntxC2StFb/T82tivWoeyCpQR02xpcoVMeuEjKaI9f
         rmTby7aihJ/R4CdfktEIzolIkJ5HV7kQJNiigJH5mEgzdEXgO359yUW0MBlZPvH86wbj
         kwUzpUrf39GEk8XDeJ/6GNEWhw0i91BE6SDPhQpVLXZQdJLIrZHIqQvRiZSEzlnIArDV
         PrKw==
X-Gm-Message-State: AOAM530wofP3ELlZKkzlU4FUPhz+LvIanCDm4tjn3KYbvpCqQf1HXKGa
        XGdiqFUvwV6HBjnmzqlXISaTDWIism8=
X-Google-Smtp-Source: ABdhPJxYzW2t6UwQSXzm7StmkuerthmRFCrntGej6rOj/ZUAyNTY6Nkno2sHVV5vLDmIClHW3i+YRA==
X-Received: by 2002:aa7:cb03:: with SMTP id s3mr24833467edt.189.1625594083633;
        Tue, 06 Jul 2021 10:54:43 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 07/13] checkpolicy: remove dead assignments
Date:   Tue,  6 Jul 2021 19:54:27 +0200
Message-Id: <20210706175433.29270-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706175433.29270-1-cgzones@googlemail.com>
References: <20210706175433.29270-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The variable `cladatum` is otherwise always assigned before used, so
these two assignments without a follow up usages are not needed.

Found by clang-analyzer.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkpolicy.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 9627275f..c88ca542 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -1176,8 +1176,6 @@ int main(int argc, char **argv)
 					printf("\nNo such class.\n");
 					break;
 				}
-				cladatum =
-				    policydb.class_val_to_struct[tclass - 1];
 			} else {
 				ans[strlen(ans) - 1] = 0;
 				cladatum =
@@ -1229,8 +1227,6 @@ int main(int argc, char **argv)
 					printf("\nNo such class.\n");
 					break;
 				}
-				cladatum =
-				    policydb.class_val_to_struct[tclass - 1];
 			} else {
 				ans[strlen(ans) - 1] = 0;
 				cladatum =
-- 
2.32.0

