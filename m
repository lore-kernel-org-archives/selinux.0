Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351C2C433EF
	for <selinux@archiver.kernel.org>; Tue, 10 May 2022 18:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiEJSYo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 May 2022 14:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242059AbiEJSYn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 May 2022 14:24:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25FA33E18
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 11:20:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g6so34632297ejw.1
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kVvpLcS3d99OpL262ctdqKvbJMGHTK6PLVCH1M59eI0=;
        b=XTyx49ErI6Wy6sQ3osgDZhAvSR/4+TNnMETZF+knENMROvHksIpinBfv+arOB9OiPt
         lhELRWYsuN7wgcE6aRDuJiqYczTLLwN1ATOOd3T7WHDSMYxBjS8AnBnVpJkqNwshRZpq
         iR4aDKnBgvpxRTTXJj9zeobWuxEJxi9MH8PFZhbmpnyPJ0oXPBFpA32kpIDVZ3pXw3cT
         TtIsj0ZGMhOlV6OaM3bK8plncJ53UMDVi9O36FUpX+2vyr2+FsHdtPvzaXEWyqXOibt+
         IlYn5t+5EDLtlBeu6mgx9dJ8CSNvMnThSh5GBL96caDfF1kFUXlRvRDOr/29f9Fnln47
         wUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVvpLcS3d99OpL262ctdqKvbJMGHTK6PLVCH1M59eI0=;
        b=j58cYB76vZ1ybdC3ryYkING3J/L0te1eWKuzmb7GFi/QlQTTqf7GSyVWMPTZ21qWRk
         FR4WQMFSlXmZHWJTK0X/qOgGDRMXF2iXjO3mrJuixDrkyATSQuJBThm4cBIlINExnl2k
         R9HGrY1YYtz5zXqXruaOSOqOE050tNiikLz1DAWLYlEY3qknnoVlIKVOICJ6FuP0DdIA
         QpLDZFjXZvZrEN9uP/Ldefy5UhUyBsEWiaO9tYwQVB4XXftT1D00LMcDKe25QOLB2PD1
         CW8alBdohScR/UNBrCqQ2oHyGMNxwCAjNX8qpWHW1sy41kAxmfFYk8l7mpZZDrqL/LYP
         QsfA==
X-Gm-Message-State: AOAM531Bx1vHegeej0SyWGbKxQWrdf+8KSU8HOEQSPfYu/k9JILJ1Z4X
        dAv9zy0caWhoCDFz1RkADoloj++qUNo=
X-Google-Smtp-Source: ABdhPJxbEjNmwqC4pTrXNZyFYyVGbfzDK4GMeEeSdXJv2Zg3nClFwZ0IsYBbE1DczZ2kQdO/ppS4AQ==
X-Received: by 2002:a17:907:94cf:b0:6f5:942:5db7 with SMTP id dn15-20020a17090794cf00b006f509425db7mr21391991ejc.625.1652206844272;
        Tue, 10 May 2022 11:20:44 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-078-050-241-079.78.50.pool.telefonica.de. [78.50.241.79])
        by smtp.gmail.com with ESMTPSA id p3-20020a056402154300b0042877d166fdsm5339947edx.38.2022.05.10.11.20.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:20:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 2/4] libselinux: add header guard for internal header
Date:   Tue, 10 May 2022 20:20:37 +0200
Message-Id: <20220510182039.28771-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510182039.28771-1-cgzones@googlemail.com>
References: <20220510182039.28771-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 297dcf26..9f4c9073 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -1,3 +1,6 @@
+#ifndef SELINUX_INTERNAL_H_
+#define SELINUX_INTERNAL_H_
+
 #include <selinux/selinux.h>
 #include <pthread.h>
 
@@ -90,3 +93,5 @@ extern int selinux_page_size ;
 #define SELINUXCONFIG SELINUXDIR "config"
 
 extern int has_selinux_config ;
+
+#endif /* SELINUX_INTERNAL_H_ */
-- 
2.36.1

