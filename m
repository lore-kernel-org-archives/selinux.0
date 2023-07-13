Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319CAC001B0
	for <selinux@archiver.kernel.org>; Thu, 13 Jul 2023 18:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjGMSI2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jul 2023 14:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGMSI2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jul 2023 14:08:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8631BFB
        for <selinux@vger.kernel.org>; Thu, 13 Jul 2023 11:08:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992dcae74e0so139852766b.3
        for <selinux@vger.kernel.org>; Thu, 13 Jul 2023 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689271706; x=1691863706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eeiHfqlDKwy7H9huqV10Cm7uj2ULWJI1opG70fx1IkY=;
        b=dh7MUCUwVXYJxJf0n2ahPf82nMhi/WbqsEaQIszwV3E8tjvXPCid7ui3hM3xTIobb4
         SwC1vs7o34JMfIm5iz+sqI4BBUIEMZZY0tjLQZb5CpdyJONyRZ9Qa5T8TOFiL1OYsZma
         TuSybsowqR2l1iQgBvBow49QsUMNDS5agHBvzoujcIBgi7t03VLoezQIaRWDqx7JrkvY
         lT1LocAnohfUK2hFH+bJIAwUWVxB0oRsH2Wpj9u9WdMt2Qw2HdlDxCO21LTv7ub7s+Wt
         47Po0r/oNL+BYTU0BJO69pPHFWKA34EMmtBU5zU/ZE0RDh6J21/xOgedfTjuEQyOagtz
         HHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271706; x=1691863706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeiHfqlDKwy7H9huqV10Cm7uj2ULWJI1opG70fx1IkY=;
        b=OT2wDz0I9jUDzN83QEFpZ9IzWKdRyK2HKMDioYXj/gy757xO6k2rI2a8qHL57s/UHQ
         GDzwbOSF/obJf+dm69Bt/fyUcZeg8CmrY3qfnQJGe13b9PJ1uJD2lw7kLkP3jGqQQtoG
         1XrhB+WGPyS0anUDJykzatGOP37msosZOXx4EoDPX0FukNrEhiy71UF5slFDSJFK4mG+
         rUTtg1IqHUnCUtYBCr2Lw/G398l10sMyuBeot/5+Ns2lIDYmv88U7+whvpP8xFYfxXer
         F32Gh2LU5VslrhltM10dlYefwMCaroYGehRTbz1ZnsUMFxgxXznNgP6SHl0ezRTIZwbb
         Llfg==
X-Gm-Message-State: ABy/qLa+v8XcaIGKm5H7xnwBUJdGIBvQfwGGYJ+Vba0ewHIrM/zxCUnn
        MV37rmyqOLTEutC3zzpWY+1ASC0/NuDTLzZL
X-Google-Smtp-Source: APBJJlEtTSNO3qf7NZUTk8zQ6GpKIMODaOe8m6C2jhIgW4mpyj4HElyvFhZIPzi3knn2Fqo4vmO/GA==
X-Received: by 2002:a17:907:75d7:b0:982:a454:6d20 with SMTP id jl23-20020a17090775d700b00982a4546d20mr1843976ejc.54.1689271705660;
        Thu, 13 Jul 2023 11:08:25 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-010-190-210.77.10.pool.telefonica.de. [77.10.190.210])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906940b00b00992d70f8078sm4270014ejx.106.2023.07.13.11.08.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:08:25 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/5] libsepol: free memory on str_read() failures
Date:   Thu, 13 Jul 2023 20:08:12 +0200
Message-Id: <20230713180816.101924-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If str_read() fails to read the next entry it has already allocated
memory for it.
Free the passed pointer also in the error case.

Reported-by: oss-fuzz (issue 60567)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/avtab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 99fdaa87..5c76fe12 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -857,7 +857,7 @@ static int filename_trans_read_one(avtab_t *a, void *fp)
 	len = le32_to_cpu(*buf);
 	rc = str_read(&name, fp, len);
 	if (rc < 0)
-		return SEPOL_ERR;
+		goto err;
 
 	/* read stype, ttype, tclass and otype */
 	rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
@@ -898,7 +898,7 @@ static int filename_trans_comp_read_one(avtab_t *a, void *fp)
 	len = le32_to_cpu(*buf);
 	rc = str_read(&name, fp, len);
 	if (rc < 0)
-		return SEPOL_ERR;
+		goto err;
 
 	/* read ttype, tclass, ndatum */
 	rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
-- 
2.40.1

