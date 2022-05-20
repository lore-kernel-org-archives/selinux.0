Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB9BC433F5
	for <selinux@archiver.kernel.org>; Fri, 20 May 2022 13:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345583AbiETNI5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 May 2022 09:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349694AbiETNIz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 May 2022 09:08:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B682B1632AB
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:08:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f21so1870632ejh.11
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q0EUWFdytUcHJEHqsWdttuqMXD+RgVp3fYdL2P+BxU4=;
        b=JTD2JFz+C4s+MZ6eo0jnSxxx5F0arp7ZfYXaNe3ivpED1aVJu+CzzhR5bkn4PYn4+B
         iIvGQtHtavzy57vPb3+rQVR5u8oxfma2GKAsB7x+8oD25JKjdI2RDV2gB1BwfhaRNcqB
         I8nn0Qbte4nRAoEo+0FmDPOAn3n2k3+OxsTdVFKoMD5Ym3gte0ElWrI775HGmaQJjuMY
         1Tgy3YfZcdZa79hLo+/D82dkinuM5U0+HLK1tClq3qi0tWJAB51wIpvb0ZYsNG4uNkKa
         Af23y/I+JSj9UcfGZIyBcCMRh7clpN7OvCaK1lhkTsLSDW6WGIZi8s7Bvhig/fO1ESUu
         O3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0EUWFdytUcHJEHqsWdttuqMXD+RgVp3fYdL2P+BxU4=;
        b=dE4RJLbQA+hPhqiAOlNGh3IPnNd6gqrp8Co/wMaQ3OYFkLn2XxFezq1r0r71HHyjRj
         OEyXAdR5h5uQr7ZNqGiCju9NE28vk16ZVGn9hJ/8sLHf5KMNZDoU1j86aDp7pyMFQs9j
         tmPHWqUAYGk3eyuUPr+WLAuoTf6J45TD08XBSBVn3wVyFM4FvqFSQgriEmIw2SzkAqhp
         tW1hsHOwhJJooTY0xTMQe+WkX2wmwaULuxDNg/s0jNgbrrKerRQcVt14Wjx5Ntl5WRE4
         ZcjDOmsYWM2Ne96fG6PdyJeRvAlZfALpzdrUfROrl+RrQWLrALhZat+hYBATThdSsvKW
         BiiQ==
X-Gm-Message-State: AOAM530zi3Q9qSYWLgIfwHaIpm6J7W7cdVkL67wG9FhmX+YI/iJK/m2j
        wS/cJ0ptfN5bCtIJ/fIQW+IG6CnMA30=
X-Google-Smtp-Source: ABdhPJz5K0h16dIKZv0qdrzkrIR6YxPthBq9BOv9lyU7+yllIui0ay2zBeVKaNtiIizexut6IsP3jA==
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id nb10-20020a1709071c8a00b006e92a0dd7b7mr8516007ejc.572.1653052133231;
        Fri, 20 May 2022 06:08:53 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-251-125.77.8.pool.telefonica.de. [77.8.251.125])
        by smtp.gmail.com with ESMTPSA id hs33-20020a1709073ea100b006feb71acbb3sm160154ejc.105.2022.05.20.06.08.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 06:08:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/4] libselinux: enclose macro definition in parenthesis
Date:   Fri, 20 May 2022 15:08:45 +0200
Message-Id: <20220520130847.10958-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520130847.10958-1-cgzones@googlemail.com>
References: <20220520130847.10958-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid potential precedence issues.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/avc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 9b23357a..4bbd2382 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -24,7 +24,7 @@ struct security_id {
 };
 typedef struct security_id *security_id_t;
 
-#define SECSID_WILD (security_id_t)NULL	/* unspecified SID */
+#define SECSID_WILD ((security_id_t)NULL)	/* unspecified SID */
 
 /**
  * avc_sid_to_context - get copy of context corresponding to SID.
-- 
2.36.1

