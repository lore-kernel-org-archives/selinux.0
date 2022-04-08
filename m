Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4FAC43219
	for <selinux@archiver.kernel.org>; Fri,  8 Apr 2022 13:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiDHNOP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbiDHNNs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Apr 2022 09:13:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554A324A
        for <selinux@vger.kernel.org>; Fri,  8 Apr 2022 06:11:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bq8so17218936ejb.10
        for <selinux@vger.kernel.org>; Fri, 08 Apr 2022 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TKxq3hfRQRES7WZbXprId1u9wweLW/peSZkSvH29jPY=;
        b=fIwmjcv9oMei6HXfpE0Ym4PJTngKMoFJ/tIUL4KotVKcxYqJg7PqCXRBjOuJsmdUhE
         QEJqRA63Xr+73kRWDp/FKr2JNjuv3JT8jI1qtxC0dxseN7PwOxKHltLsh9Lqr+GoyGCN
         cJRTWbu9ZzZqFZF+3rX4S65DUio6l+ATEqkvWyt1ei0DTMD03xQ3/w+Wb7gDAcdROs4S
         TFMU0urq/CzhC5lu5fwnpdLx3PVPeTqK0opaqAukWTasxcg1XRJxrhj9zaYuxSQpUQYr
         GkRkzp7EOK6Xscm3ry+J2zD4YzhMcTZnOH8FX8GupF5+6pu9G5rWbMdxg5J+hxiv+qjT
         jJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKxq3hfRQRES7WZbXprId1u9wweLW/peSZkSvH29jPY=;
        b=g9qpH1kYugR9HBRTT4vOAK6aRX7hwmC1TYMx199ZN/+oOwEqYH6U4PHp+VkgPc6+RA
         +ozQB7JJMrSJE3f2yDJcn3rJjRpyLNjsTCp8dTPj+bynPLpPlZy7Q4PqmFljGVMvIMQJ
         turxMK8hjw9i+hCe2pdEalqnEAbWe+BnNO23CTvo0rYGgYP1XF0Yif3fBGxvQN+tHn/+
         B4Qyf8jsZSWK2fHAGRQMoZzDCnmcrteNOBjEx/Ih1Pxq4HIz0I/mjF+DRgrFzd86tHvR
         Nd3tUSBXMoyZB6ZhxWlQc/PEEonZJz9CB7gWzM8upK7xLYpNfWanVWpTvBuQoc0sHTQW
         fQrw==
X-Gm-Message-State: AOAM533WQsh/zNIwLdqRp3W6QGAF6ZnNATDsknUq7Nz8+T9BhxOkuxwZ
        qnnouRuQonh6job66xTRS8jIYTUt+x0=
X-Google-Smtp-Source: ABdhPJxIC0Kcafj/2ajM2Pb7hidUaAIf7elqQfTAepc+9k0r1dJgW0KIANvQHGvg2rO3j2L+JsyKcw==
X-Received: by 2002:a17:907:1b06:b0:6e7:f58a:9b91 with SMTP id mp6-20020a1709071b0600b006e7f58a9b91mr18877547ejc.291.1649423458829;
        Fri, 08 Apr 2022 06:10:58 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-032-209.77.3.pool.telefonica.de. [77.3.32.209])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906111a00b006e778bd4fc8sm6398601eja.38.2022.04.08.06.10.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 06:10:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/5] libsepol: check correct pointer for oom
Date:   Fri,  8 Apr 2022 15:10:51 +0200
Message-Id: <20220408131054.7957-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408131054.7957-1-cgzones@googlemail.com>
References: <20220408131054.7957-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check the actual pointer which memory was assigned to, not its parent
array pointer.

    services.c:810:14: warning: Assigned value is garbage or undefined [core.uninitialized.Assign]
                                            **r_buf = **new_buf;
                                                    ^ ~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 29723729..b8fb2704 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -803,7 +803,7 @@ mls_ops:
 				if (len < 0 || len >= reason_buf_len - reason_buf_used) {
 					new_buf_len = reason_buf_len + REASON_BUF_SIZE;
 					*new_buf = realloc(*r_buf, new_buf_len);
-					if (!new_buf) {
+					if (!*new_buf) {
 						ERR(NULL, "failed to realloc reason buffer");
 						goto out1;
 					}
-- 
2.35.1

