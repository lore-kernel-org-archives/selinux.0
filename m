Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B880EC43217
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhLQST2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhLQST2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:28 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D751AC061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:27 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id l25so2981877qkl.5
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPkVQCcebJo7Yq9WhSxtz3V4v3wlvtz3YCm1gFtNgv4=;
        b=PRUoqmKQMviSSmLAJX6blUR4Bz5gnd1/S3+FIudpcaug2BpQzJ6n0reGrdZZ/dSYBn
         HBILX/h9RmFOkMy88FryOZP1Ar8JEIx9DIMRjI8WYDn01DKGz6/je5+OQb88Otl7XOzn
         Pow0CP2fqSviFSNQwuXWb/H5GW5wGzZv1UoSkle81ec2WHdczzXij29Jv5BfEzgmfs6s
         vPHj4wrxHqT5W7Wp/c2F2TU8vd1sEEUgyqMwuGXFk/M4+RLuwkHkXJyOglpoysLaQ5tQ
         CIf06Ru5xwYraaAns76BifFZZj6g7t/Mq7z2pXvwuviiufqLEynYAihHnNnyzOoqZxFU
         oITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPkVQCcebJo7Yq9WhSxtz3V4v3wlvtz3YCm1gFtNgv4=;
        b=o5o1kpUGTw4sVt//i76SzIvt2FQxyUU4eaGd+pFGPLXSXk2vzpAfI1Lj3nxOELJK79
         jNKvGCDFHyaVinpiZOpSXAn9YeNA97HSP0x8HHrUZGcXxuz/YVrj3PdWF/AhFQAKJTde
         STwPQ/VI8oVdJ8ldXyjtoMDEeowZoINtxQPBJmkMoDTxQiGF5kcyoPfRrgNsCR7etuqF
         0jodTij1FLCBOcqjOTLSanGKGofYOT6xDdhhmHVTqQWViV6o0Z6L4mgAAMjWpBijtubW
         pg3zb5kIEtbSDm6smt7Vh08RhakXyh4yQGW7bGs0l6vu0beicaD9C9NyHNCPHVa30QmT
         f7Yw==
X-Gm-Message-State: AOAM5300yHxNxVxVcEMUtyB3IEvpscJhDouglyN8qO1IaO/7u+urq+0Z
        x9ef4DmDc1MJQ/hu3KVOw/RWBCUrZhQ=
X-Google-Smtp-Source: ABdhPJxeGXnNvLzGapOc2b9X/g6kMl+gkt3tbtY7kW3kPsu260sd5/JWVQLUnDbFc7iQivEHpy4RpA==
X-Received: by 2002:a05:620a:d87:: with SMTP id q7mr2587200qkl.377.1639765166937;
        Fri, 17 Dec 2021 10:19:26 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:26 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 04/16] libsepol: Check for error from check_assertion_extended_permissions()
Date:   Fri, 17 Dec 2021 13:19:01 -0500
Message-Id: <20211217181913.336360-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Return an error if check_assertion_extended_permissions() returns
an error instead of treating it as an assertion violation.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 832d3749..a2cbb74d 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -481,6 +481,8 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 
 	if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
 		rc = check_assertion_extended_permissions(avrule, avtab, k, p);
+		if (rc < 0)
+			goto oom;
 		if (rc == 0)
 			goto nomatch;
 	}
-- 
2.31.1

