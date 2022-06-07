Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D8C43334
	for <selinux@archiver.kernel.org>; Tue,  7 Jun 2022 17:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344630AbiFGRQ6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345485AbiFGRQ5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 13:16:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD1B104CA3
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 10:16:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z7so23849113edm.13
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KZpERE6OrTcWK2YjPMSHBBfIqlFAoYtGznUmWlx5Jkc=;
        b=dmg3tHfXpRO49osOCNwaAokVzUWa91L8Um8u8n7JTy6PQRwtXnV/50Zb8z8UvzSINU
         YH0i+Scmy7iWLsJsIOwnNLz3m6+VQVGGaLLYyZFo4O9/x8Rbaav2jgfYc0OfjAwVHblW
         KMvIZbF34oNSJ8jXHx2SlUqRX7/1JE65sWqDf8xkmA8aCeEyUFcGdf3FWDCXgeH1e33M
         50oxPyY4W3oQG2y0zoRz9ii9t9ug5Pi+peoHiq3DQGZfH101aH52ywor1V1IMFdOQ9Pu
         kgdHLjr3ScUgJlzO0PLrk+qldZCGqjpAZt6eVLJuImbL/vEqt0UXBUC9PZFEukpFusDW
         xgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZpERE6OrTcWK2YjPMSHBBfIqlFAoYtGznUmWlx5Jkc=;
        b=NKRtBxLRJLdcaVyFtC9OA1vpYoL1QNSX+k5awU/sLF9VQuFF6i3JE6/sR3o1zVZ+JQ
         /08/hZy91WbmXgzXPjdrhdegdKn8ffCygUu89rKlA3hYho8/aPd5WWqHT5YPKoLlgeZU
         p3dcLCPN8Jjuzarvv2RCTd5l9ODoCOdZNMGyIHkqW97xhk8GsqBbU5Rs/seSiN8/aMHG
         63Hu4oOWZ791puXKoWNRxPtDGM78w0SS0py8pf8sFTZUXfnOEXuBygFl0f3w30vol2bJ
         7MDDh2eFLvoXYgLWlp3RAV9KrNL/NXsdyu9KLO0UFZJYM4q3LWVFg8kuvNV1BWloiSxg
         AX4Q==
X-Gm-Message-State: AOAM530evtKfisejohYjWhem3pbDxL6IaXH9+PcP2NAsV70fHg9/KCbn
        1fvHXc6JjafHForTFhB5Uq4oar5F0sQ=
X-Google-Smtp-Source: ABdhPJz6jABQxkDUtlgfARNPcGapsKx8JJhyfLmAK60c3I7/StL2X+H85CVJF/SHabok1Jti6nOXvg==
X-Received: by 2002:a05:6402:1c91:b0:42d:c9b6:506b with SMTP id cy17-20020a0564021c9100b0042dc9b6506bmr34190153edb.166.1654622214356;
        Tue, 07 Jun 2022 10:16:54 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-054-039.77.8.pool.telefonica.de. [77.8.54.39])
        by smtp.gmail.com with ESMTPSA id lo27-20020a170906fa1b00b006fe9209a9edsm7780380ejb.128.2022.06.07.10.16.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:16:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 3/4] libselinux: name parameters in context.h
Date:   Tue,  7 Jun 2022 19:16:47 +0200
Message-Id: <20220607171647.42625-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520130847.10958-3-cgzones@googlemail.com>
References: <20220520130847.10958-3-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - Rebase on top of dd98fa32 ("libselinux: declare return value of
    context_str(3) const")
---
 libselinux/include/selinux/context.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/libselinux/include/selinux/context.h b/libselinux/include/selinux/context.h
index 82f4e690..59d9bb69 100644
--- a/libselinux/include/selinux/context.h
+++ b/libselinux/include/selinux/context.h
@@ -17,7 +17,7 @@ extern "C" {
 
 /* Return a new context initialized to a context string */
 
-	extern context_t context_new(const char *);
+	extern context_t context_new(const char *str);
 
 /* 
  * Return a pointer to the string value of the context_t
@@ -25,24 +25,24 @@ extern "C" {
  * for the same context_t*
  */
 
-	extern const char *context_str(context_t);
+	extern const char *context_str(context_t con);
 
 /* Free the storage used by a context */
-	extern void context_free(context_t);
+	extern void context_free(context_t con);
 
 /* Get a pointer to the string value of a context component */
 
-	extern const char *context_type_get(context_t);
-	extern const char *context_range_get(context_t);
-	extern const char *context_role_get(context_t);
-	extern const char *context_user_get(context_t);
+	extern const char *context_type_get(context_t con);
+	extern const char *context_range_get(context_t con);
+	extern const char *context_role_get(context_t con);
+	extern const char *context_user_get(context_t con);
 
 /* Set a context component.  Returns nonzero if unsuccessful */
 
-	extern int context_type_set(context_t, const char *);
-	extern int context_range_set(context_t, const char *);
-	extern int context_role_set(context_t, const char *);
-	extern int context_user_set(context_t, const char *);
+	extern int context_type_set(context_t con, const char *type);
+	extern int context_range_set(context_t con, const char *range);
+	extern int context_role_set(context_t con, const char *role);
+	extern int context_user_set(context_t con, const char *user);
 
 #ifdef __cplusplus
 }
-- 
2.36.1

