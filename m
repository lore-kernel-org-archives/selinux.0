Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF773C433EF
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 13:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiBVNu2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiBVNu2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 08:50:28 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABEC10BBCF
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:50:02 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qx21so43023072ejb.13
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cc/xqdU8Gx5CUJgr2s09qMSwxV6lW6cQISZQI6l6+g0=;
        b=m9l72qs7c0wGWkWSIcx6UoML7ef+NZC8mwGFIfVO+phHXHi/yTYoDUmyE/rtubwpjp
         tWE+ilw9J2co/efgKr6VgTctkG/DHLcGcukFyEP1SUE54bJj4iv9kWnzylJR1ubS7xwX
         pu3vLI5ySliOtu6gMOnP8XtEFeMGFFw8gEBjuAextdEirxlX/H9Vbu7JGUljUwfnz/CT
         w0i03DJ2kEZl3NzRfDuPB3EDnUvaol1erF3HPAIFyvhxaO5dNcakUqYbwGRs08N1PV89
         K9hufCm9Mf6aTXWetBmmsaLpoPw+WJtjmXofHhr4FovHUa3Hm0B1BFnjBYvnEXX+iLq5
         VhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cc/xqdU8Gx5CUJgr2s09qMSwxV6lW6cQISZQI6l6+g0=;
        b=UetyVjymE/ou1jk9xUGVTZxSTCx+LpGHRzJPCDmDitB0gC7AwUmegX6CsE8mNVUNJM
         1CZA1hh8e6g1dln4VRSPNi7WZ3758m+Lj+j6jTldyhZeJiV3t3TWeCWRUpSBIOqyhHaZ
         j1RAtENE63ILrKDjrEIwbXsQVY52LLVn1AAabi6M9W2yLbqarTxES+L5xbzflwIoq7OH
         u3/ewrJWUDGUHL7/VxHbOJA+QRDSPLI1Fz3QBO8QMPxfpY4z7gNd+Wt/NnFz8cfTs5mE
         rz9fvcsQXGJTlNKHHBx/2tKZku6uOiQ4p3yaGEF6D9ID7HCkHiIp7pjEgIoTRlqhpGy2
         t58Q==
X-Gm-Message-State: AOAM532gj4qY7zJihPGT2OCIxKiQz1cijMLARnIy9sz5eR3doNW2oo6i
        t2PgOiT9D8r9lEgRs5ZV3KT9BBfEGTE=
X-Google-Smtp-Source: ABdhPJzzwD6tU683nH3SIqh6Aei+IxDy71PbDCFISAiFxKK4JuKxVrwMQf3+nOdhZIREvhkRvuGjpg==
X-Received: by 2002:a17:906:5f96:b0:6bb:3024:9444 with SMTP id a22-20020a1709065f9600b006bb30249444mr20604360eju.298.1645537800951;
        Tue, 22 Feb 2022 05:50:00 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-065-014.77.3.pool.telefonica.de. [77.3.65.14])
        by smtp.gmail.com with ESMTPSA id fw30sm318268ejc.118.2022.02.22.05.49.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:50:00 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: NULL pointer offset fix
Date:   Tue, 22 Feb 2022 14:49:56 +0100
Message-Id: <20220222134956.30277-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On the first loop iteration the variables `r_buf` and `reason_buf_used`
are NULL respective 0.  Please UBSAN by not adding them but instead
directly assign NULL.

    services.c:800:16: runtime error: applying zero offset to null pointer
        #0 0x4d4fce in constraint_expr_eval_reason ./libsepol/src/services.c:800:16
        #1 0x4cf31a in sepol_validate_transition_reason_buffer ./libsepol/src/services.c:1079:8

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 7becfd1b..29723729 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -797,7 +797,7 @@ mls_ops:
 
 		for (x = 0; buffers[x] != NULL; x++) {
 			while (1) {
-				p = *r_buf + reason_buf_used;
+				p = *r_buf ? (*r_buf + reason_buf_used) : NULL;
 				len = snprintf(p, reason_buf_len - reason_buf_used,
 						"%s", buffers[x]);
 				if (len < 0 || len >= reason_buf_len - reason_buf_used) {
-- 
2.35.1

