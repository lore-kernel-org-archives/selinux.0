Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6BDC43334
	for <selinux@archiver.kernel.org>; Fri, 10 Jun 2022 15:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbiFJPGe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jun 2022 11:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiFJPGc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jun 2022 11:06:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E06223BD7
        for <selinux@vger.kernel.org>; Fri, 10 Jun 2022 08:06:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z7so35659073edm.13
        for <selinux@vger.kernel.org>; Fri, 10 Jun 2022 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IswP33oDLgRHcyfg9LVWX2XNcNqlY2uaS/6KbLvlzBQ=;
        b=fuogGdrFMCt1hPiA1sWBYGRX7KP/ztP4CGRHWBjULlb0xl9GkutrhzD/BYoffB0b8Y
         WmfwqnFFCJSPTGK0qs5KPmTdkiATfwvMS3HsmmKuY8tpHyeDUb4dwsfA50JZwaMrrzTk
         A3D9QAwmzLfhuT5soPf79dOG9fmMFNpcYQnuwc/S+uB2cMjlxgbSvfzhLm8M+x70oJNO
         BiO+/zklleqQWytkLjkUqoRQoKIt6HqG8hMJv7XI+i1dJmrglrbakfH7WZDqvix7rBiB
         opjtg3xIVOu6xwKDsJGt5HCjIhDK8MJdT+C+e54hZNOoFO45QLVctQDol97ZjNDz3gOm
         Mzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IswP33oDLgRHcyfg9LVWX2XNcNqlY2uaS/6KbLvlzBQ=;
        b=BcTF4EgqISghLmi2Iq6Pb/uDqw38z/Mttmk7GxMNfTTEZ2QklXsGuVCNlzQfuaR4GF
         jsbEKZ1C1gHXkhrNxxoSoDVygNo/8a2UXlg/lpvCszVDbMnZIdduF6ATRH0QLnBkt7+6
         bG6rQRFy06Dn0vXuZBKDWVDI9zrzhULQ8LQ5/mFlA+Y9aN5A0LXqHMx/+lmwrCWwTwU4
         PnxKTGDPcdEQcPTfCa6dLaN8vZhRhQfcNlxkW/b1SD1XeNb5T2TZ/x1tqh3dOMevCKV3
         Ida0NRWyF/zdWax6BAnMurPA0sPhlabh+T2H3JXLh1q1DJemTkgdn0RI1QGlr7V/xKmb
         tAOg==
X-Gm-Message-State: AOAM530O21H7NOFq997B10htUTxVvfUIOpIg+T7U7ubZjDmQR/OfiFzU
        RfCbw10ci9eUFCBJQkC84JXdV+7qWI4=
X-Google-Smtp-Source: ABdhPJxBBzzXQfq2wOLqqbGlYCNLhFKjSLef9BRO7tAcNn/9QxD8FfUwlnDlm96ce7oTTA7wylTiOQ==
X-Received: by 2002:a05:6402:5211:b0:42e:2e1c:5bce with SMTP id s17-20020a056402521100b0042e2e1c5bcemr44701780edd.198.1654873590316;
        Fri, 10 Jun 2022 08:06:30 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-083-029.95.116.pool.telefonica.de. [95.116.83.29])
        by smtp.gmail.com with ESMTPSA id lk24-20020a170906cb1800b006fa84a0af2asm12529724ejb.16.2022.06.10.08.06.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 08:06:29 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: avoid potential NULL dereference on optional parameter
Date:   Fri, 10 Jun 2022 17:06:23 +0200
Message-Id: <20220610150623.21082-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The parameter `reason` of `context_struct_compute_av()` is optional and
can be passed in as NULL, like from `type_attribute_bounds_av()`.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/services.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index d7510e9d..24412d83 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -894,7 +894,8 @@ static void type_attribute_bounds_av(context_struct_t *scontext,
 	/* mask violated permissions */
 	avd->allowed &= ~masked;
 
-	*reason |= SEPOL_COMPUTEAV_BOUNDS;
+	if (reason)
+		*reason |= SEPOL_COMPUTEAV_BOUNDS;
 }
 
 /*
-- 
2.36.1

