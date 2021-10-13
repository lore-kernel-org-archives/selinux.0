Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BF8C433F5
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 12:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF7E61056
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 12:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhJMM4M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhJMM4L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 08:56:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAF2C061570
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 05:54:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a25so9793167edx.8
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cdOuvMHNLtr1P/81u7ICoXwqWm5Od7tUKK0KdGpXC0Y=;
        b=bjAEIcePAQKEd+kvAXPxTVIgGLSBTXiY2DY8tGAR6ZL+yQVaTYNzy2iudQjGRVWeR6
         GK7N1xlxyRUlXnQWiRcGkhc7i6ytjmCAawU4FFPWvh06aH/ztlgcmsbhCwInN73PjMGT
         V15v7tMjeTQIzNotYQva9ibDnadjS56D+Nqdnxwqc1cnBsYuxDtRTwklbaf5w8xURwJP
         F06Rcb1LiqM/G89G8k6WYAWysuNS10XGFA3AHq/0erdj/cqbomkTspYGMlMT2OkOlX40
         qpBlTJ/asyYajLuZmMBBR9jqpLg+lOWSmO/TXv9aekdHmgJR24lZbyMMVBgAxMvlzOhe
         WDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdOuvMHNLtr1P/81u7ICoXwqWm5Od7tUKK0KdGpXC0Y=;
        b=ZhzIKDI4FAfVXok9eaevZ9ySgrsDqbonSuZvIQut8EMUkZxsnRnGO5uxjUOuLVRZod
         vTSR2L95YFSPSucXS60ndtBVEeDugzmbXDzE0Yj4h9KdstwjwzB3CWEmU/ddaKRk5NgU
         llmHI830OV+BMFstyGgjV0XcNY49O8804uUq4//d7PcXy3MfW+L63KOt2YMEGsHmd6KB
         5gXg8xepFkp0UaYXCCxUJFSscjK47sQGODj+TLPTyZM5d6Bv6QJWiphbKpZbDrL2yBCW
         krWpsq2xHDjRx+NQ6yduLzVwuhYDXsVzq2flyksu57dgTTGG0z3ALcSwHnrGEZTXNkZ5
         Moxg==
X-Gm-Message-State: AOAM530LAjoM3NWhURIA0VE8Sc4FyV+VfhQ9UAUPmCS49eNLbIBu2UjV
        WZKE/ysYdc9/BA7HqNUChZ6CAeFpBNg=
X-Google-Smtp-Source: ABdhPJwzpJb3tFV2LeFatyG/RMExGTdQnGMUBL3QnVu/m2g1C5vC18ngspnFoZ0ihJnBKcBIbQmVWQ==
X-Received: by 2002:a17:906:3784:: with SMTP id n4mr17746216ejc.129.1634129645894;
        Wed, 13 Oct 2021 05:54:05 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-105-029.77.3.pool.telefonica.de. [77.3.105.29])
        by smtp.gmail.com with ESMTPSA id u16sm6745880ejy.14.2021.10.13.05.54.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:54:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] libsemanage: do not sort empty records
Date:   Wed, 13 Oct 2021 14:53:57 +0200
Message-Id: <20211013125358.15534-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013125358.15534-1-cgzones@googlemail.com>
References: <20211013125358.15534-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not sort empty records to avoid calling qsort(3) with a NULL pointer.
qsort(3) might be annotated with the function attribute nonnull and
UBSan then complains:

    database_join.c:80:2: runtime error: null pointer passed as argument 1, which is declared to never be null

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/database_join.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/database_join.c b/libsemanage/src/database_join.c
index b9b35a61..b0e66e53 100644
--- a/libsemanage/src/database_join.c
+++ b/libsemanage/src/database_join.c
@@ -77,10 +77,12 @@ static int dbase_join_cache(semanage_handle_t * handle, dbase_join_t * dbase)
 		goto err;
 
 	/* Sort for quicker merge later */
-	qsort(records1, rcount1, sizeof(record1_t *),
-	      (int (*)(const void *, const void *))rtable1->compare2_qsort);
-	qsort(records2, rcount2, sizeof(record2_t *),
-	      (int (*)(const void *, const void *))rtable2->compare2_qsort);
+	if (rcount1 > 0)
+		qsort(records1, rcount1, sizeof(record1_t *),
+		      (int (*)(const void *, const void *))rtable1->compare2_qsort);
+	if (rcount2 > 0)
+		qsort(records2, rcount2, sizeof(record2_t *),
+		      (int (*)(const void *, const void *))rtable2->compare2_qsort);
 
 	/* Now merge into this dbase */
 	while (i < rcount1 || j < rcount2) {
-- 
2.33.0

