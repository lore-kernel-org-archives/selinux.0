Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB4DC433FE
	for <selinux@archiver.kernel.org>; Wed, 19 Jan 2022 16:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344646AbiASQfd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jan 2022 11:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356158AbiASQfb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jan 2022 11:35:31 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA0DC06161C
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 08:35:31 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a8so3724216qvx.2
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xe9/8YvdpDyZtxye7TxK8fXCzaEzg9CokVs3WKVeLPI=;
        b=aKZAt6HCc4qBJJ83eCaOpwC3nNnKM+qUMTrzBTQOxg6j+54Rtd3paUyeoNLXDTK1n5
         hIbK7JPgw88IrOExKmJEfyonFb6h8LY0+xE9He3Wj/cr9Y1YVa9FXnNkqVnxO4JVAgEy
         bhbVskVX4AN2c+ZAKNBuioUpqrV+JdTTWHafnsEQxHD7QsNVGWqK3AowHbOwhKGbJbfB
         sTgoW7x4SBfaVb8/re9+FwVXj2SSViHITSkhSzH++ZT1ghCBmNPgcdxnLAOeTuWqn6MB
         75YRAGt2YaHsZQEvEy31SPLUzMRob1qnRJLi/JtwzpKCpjynyQfLdGDrsrGTSi9WzU98
         Qu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xe9/8YvdpDyZtxye7TxK8fXCzaEzg9CokVs3WKVeLPI=;
        b=gEjV1KnO7w2EcRB1euNbUIVTFKFYUNtFCB6/mBF/G+a0haQFAu04UGiBAFk28Afo6n
         DXqew/A73OKPviJ2F8j33CSIfQfAwOoxXQWW+BISG00X2nPUy9Q9C4ENCpcTSEpGMI01
         MeINgJmxWKWlhizXXTqwlZuLtiq1AsJWLrcCSHbDf6JSWhSqIL2U7mHOgwnKci78YoPB
         PNxCIs3ko6gObFWEg7QYLqLqQciWjr3ToLYK/B9cu3lKrY+hdbSnm0S6/iIvqUrLPM+8
         0YynY2ZLrIpPkIPzYA+MTeVYGzS39Cmn/P4rB1cA4HwK/Gu8oNUt52gmngzE/R1IDwqa
         YX3A==
X-Gm-Message-State: AOAM533uR/YzpWCLc4meK3E4xG3bHGrYi+UTJBx10M+DYpx8As3tXjrI
        T3KtPsY2GrLVeNGwWvi3aSq3QWrp1Js=
X-Google-Smtp-Source: ABdhPJyZvDrFP8rUazB3JwLACyb0kUF2SXoBD/UyK2x8z4+OxpbnK0UrqP+IJUVoyEDybDQ/QSh3Vg==
X-Received: by 2002:a05:6214:5001:: with SMTP id jo1mr27749773qvb.21.1642610130251;
        Wed, 19 Jan 2022 08:35:30 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id b200sm127231qkc.50.2022.01.19.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:35:29 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     j2468h@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/4 v2] libsepol/cil: Add cil_get_log_level() function
Date:   Wed, 19 Jan 2022 11:35:15 -0500
Message-Id: <20220119163518.93780-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220119163518.93780-1-jwcart2@gmail.com>
References: <20220119163518.93780-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the function cil_get_log_level() that returns the current log
level for CIL.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_log.c | 5 +++++
 libsepol/cil/src/cil_log.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/libsepol/cil/src/cil_log.c b/libsepol/cil/src/cil_log.c
index a8e4d2e9..a296929b 100644
--- a/libsepol/cil/src/cil_log.c
+++ b/libsepol/cil/src/cil_log.c
@@ -70,3 +70,8 @@ void cil_set_log_level(enum cil_log_level lvl)
 {
 	cil_log_level = lvl;
 }
+
+enum cil_log_level cil_get_log_level(void)
+{
+	return cil_log_level;
+}
diff --git a/libsepol/cil/src/cil_log.h b/libsepol/cil/src/cil_log.h
index 541569be..442781fb 100644
--- a/libsepol/cil/src/cil_log.h
+++ b/libsepol/cil/src/cil_log.h
@@ -38,4 +38,6 @@
 __attribute__ ((format(printf, 2, 0))) void cil_vlog(enum cil_log_level lvl, const char *msg, va_list args);
 __attribute__ ((format(printf, 2, 3))) void cil_log(enum cil_log_level lvl, const char *msg, ...);
 
+enum cil_log_level cil_get_log_level(void);
+
 #endif // CIL_LOG_H_
-- 
2.31.1

