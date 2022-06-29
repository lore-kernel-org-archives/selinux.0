Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FBEC433EF
	for <selinux@archiver.kernel.org>; Wed, 29 Jun 2022 11:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiF2LFh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jun 2022 07:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiF2LFc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jun 2022 07:05:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DEE3D496
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 04:05:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eq6so21624431edb.6
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MV8GkonF0xIwSMIrHoupSMv8bmPO0FynoZgMZ00aKLA=;
        b=FtIhlEeDnIBzvQkuuu6xHznv2F0xMspti1Py3Kmj5iVe1YwWyhySCGKyELT2ABMie7
         pUN3PRfiKnFKaI7NOBIlRpl93msCon1jTQhURROWmP0vzsNHwqKSG45tjkwbXBaeksmK
         rFE5rQFrZZZNgkkVUddbC+VQasJWfL1VBPdlSCrlQOuYq99As0RljV/Ny86D8heiUqEq
         OmbA+ei/1IncIpESiBLgwBNcVkrJFE7vJZDWtTK2PdY5mgQ5WD4mdaYIyftHoVwQQ4UL
         y4Q+nxR9qJTeGYRXU/KuEg5JVf/oSwWDjlmbJNqPLzGxLKmtxONvODz0EbhK+dcvxf13
         ++jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MV8GkonF0xIwSMIrHoupSMv8bmPO0FynoZgMZ00aKLA=;
        b=Qa9WCP8EBR5ifYtzgFg4DSaT+Y8U78dPg+nkdsOoqU8OQCpCIrXfe976LLcYzyw0ct
         dj4/1To1tisiLgdIMmktdqNVuXu5kbQ060mdpOZ0kvhFa7WsbSPb6hLFvBsE8VkDfFdI
         zMjMqthUxpV4yioPkS3nj5e0YZf5IaE9BokyNx+OpU76Zq/UHgWltUwnJYX4DKPCVhA/
         TIuEXn8T79BvJaYtNYr9ZxZ5hmXHQN9h/eyLXlRCEdDmSZJ52Z7y0R31gkLiGHum+uts
         l2hb+LSKoHV1FFVm8zdja0NGkjYC8XyAgjQfvVEAkQ7vi5WQI2zLCZigIc8p6Ii/ghx5
         bnUg==
X-Gm-Message-State: AJIora+DS6GTyWx2wq1d+6xF7lv5STTRLrsSg4h8doAdoPmrkWhog1fl
        Ee3yyWiqfsJQ3RerVL1TqOgSfN5KvDUJeA==
X-Google-Smtp-Source: AGRyM1uFsfDCqfaPDO6YJqCs8515lauZT9pyDraqt8LZvOum0lOrstbrR55p39iSOEn4Dr+ra9Ceeg==
X-Received: by 2002:a05:6402:528f:b0:42a:c778:469e with SMTP id en15-20020a056402528f00b0042ac778469emr3408145edb.404.1656500729650;
        Wed, 29 Jun 2022 04:05:29 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-077-001-129-058.77.1.pool.telefonica.de. [77.1.129.58])
        by smtp.gmail.com with ESMTPSA id co6-20020a0564020c0600b0042dd022787esm11229868edb.6.2022.06.29.04.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 04:05:29 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsepol/utils: improve wording
Date:   Wed, 29 Jun 2022 13:05:12 +0200
Message-Id: <20220629110512.5067-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A request is denied with SEPOL_COMPUTEAV_RBAC if the source role is not
allowed to transition to the target role, granted via a

    allow source_role target_role;

statement.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/utils/sepol_check_access.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/utils/sepol_check_access.c b/libsepol/utils/sepol_check_access.c
index bd2ea896..5d2bf679 100644
--- a/libsepol/utils/sepol_check_access.c
+++ b/libsepol/utils/sepol_check_access.c
@@ -109,7 +109,7 @@ int main(int argc, char *argv[])
 	if (reason & SEPOL_COMPUTEAV_RBAC) {
 		if (i > 0)
 			printf(", ");
-		printf("transition-constraint");
+		printf("role-transition");
 		i++;
 	}
 	if (reason & SEPOL_COMPUTEAV_BOUNDS) {
-- 
2.36.1

