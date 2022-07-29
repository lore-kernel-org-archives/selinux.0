Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD67BC19F29
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiG2MCm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiG2MCl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7B24863DF
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCNTP7AQDJgrxxpzoEvSEzOecZLF3Xzn6XGCSPV0z88=;
        b=DRFDLDSW+fZaqIFhe9gHE9n18CyHBHj6cfGYDaLrdHL/HdKPFnmt6+3HaMdMU9bvOCDybi
        Ly3OZnQzG9KcydKkVWOgn95raXkxGsSmUoEXQPbvxARofss5LBZJ1SsqSM22vmHPv8qFlq
        tzwTP01HIPgERCS75z/bW9AUQNxnwhI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-o5sRbsKYNf-n_4nbbZ40zw-1; Fri, 29 Jul 2022 08:02:37 -0400
X-MC-Unique: o5sRbsKYNf-n_4nbbZ40zw-1
Received: by mail-wm1-f71.google.com with SMTP id v18-20020a05600c215200b003a2fea66b7cso791639wml.4
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=pCNTP7AQDJgrxxpzoEvSEzOecZLF3Xzn6XGCSPV0z88=;
        b=mm8fPbJKYBc1KGWyNaWOFT89D1CpQJGDn98yOtwphH9Ioip0bo0+qJA0ZobtMT8s5E
         NroXC0PkJIYd+6V1q4XgS37EC3X7EA+CXJ1yYAq3tLB7uFx+CLOXUvKIQHnEJGM33zZM
         k+xlmrBEfSGKzZsCwQEyamPtKZi/EU/FGFgyGEYTN1tMJPijNFvXPIB9iHwcYpKxAc7B
         7nNP6dFlg3HvNg0+YnX6Q6uLkxpvv2B+QdoLuxlaZaOJQq688uYetlwt7iccsWoMHsEE
         SpEYI9v20JrqBYpi/Iqva6KRzOgQVACmlJdX563r6MuKRFeacwikAdfm+EU11groE9ri
         soQA==
X-Gm-Message-State: ACgBeo2js+BCOTxQIkNZW3USvu7HvKN8H08mY4ZNcEfmKKhdxdWSmFE5
        0gDyT736aWpi+oOmkU3MD9Cqi/BKD/OGA7MH6TZSdZlLeQ61u4VpsJDoxUJt72HLydcn+UdG05v
        MgAtpjS44hxhRSOgUS4Sp2skRK0+Gs+8spxlLCoANNYTVO/L7XVfHz8z+cx77D1pmegdIfw==
X-Received: by 2002:a05:6000:a1a:b0:21f:10a3:924 with SMTP id co26-20020a0560000a1a00b0021f10a30924mr1792758wrb.650.1659096156222;
        Fri, 29 Jul 2022 05:02:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Tspv6TpEqYMPuTYr4a5BmVoB/6+g3kX5Jse04mMpGYPr8p7QIPmYya14kZs6fRp0sZ0DVXg==
X-Received: by 2002:a05:6000:a1a:b0:21f:10a3:924 with SMTP id co26-20020a0560000a1a00b0021f10a30924mr1792737wrb.650.1659096155922;
        Fri, 29 Jul 2022 05:02:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:34 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 02/24] test_global.te: remove unused role require
Date:   Fri, 29 Jul 2022 14:02:07 +0200
Message-Id: <20220729120229.207584-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The staff_r role is not used and can be dropped.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_global.te | 1 -
 1 file changed, 1 deletion(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index d19b4be..dae20d6 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -9,7 +9,6 @@ policy_module(test_policy,1.0.0)
 attribute testdomain;
 
 gen_require(`
-	role staff_r;
 	role system_r;
 	role sysadm_r;
 ')
-- 
2.37.1

