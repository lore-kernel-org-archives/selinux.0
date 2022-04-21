Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB17C433F5
	for <selinux@archiver.kernel.org>; Thu, 21 Apr 2022 08:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386580AbiDUIUQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Apr 2022 04:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386572AbiDUIUP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Apr 2022 04:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAE4338AB
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650529046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUqXuwUmJG9eEUCFhmtupp5nlyr3BlHfhZR9FLsCUQo=;
        b=TXX9zHzBNuIRHaOkqdggssw+VKpzh9nS0WjYmJwpuZn/M2vrXyOtt+4frLuU+k4it+6vvE
        IOKw74VabO12/tnNe5wDXiDt1kjwhf+QI9w90yQTmqmYDy1+EnVY6+zTXMfQcwLujQ1L6U
        oy/HyiOsAT/MWHN9YzqG/IB3nJSYJdY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-HYvAVbizNk2J5Fe1fMMo1A-1; Thu, 21 Apr 2022 04:17:24 -0400
X-MC-Unique: HYvAVbizNk2J5Fe1fMMo1A-1
Received: by mail-ej1-f70.google.com with SMTP id i14-20020a17090639ce00b006dabe6a112fso2093791eje.13
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 01:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUqXuwUmJG9eEUCFhmtupp5nlyr3BlHfhZR9FLsCUQo=;
        b=TP6+JNXcgdOJOwWYN7G7LA1mr/2G11WNUQspt0PLvBqDccEPWFIVMW8yfSb73GSrpM
         uZ7o6PhjfYpk8y2M0IifSpb2O0qgbRpjnAZ1M9sQasq64pbN/BlKq1BhxyPg5b+eCSw1
         3978WYVNSamJikY6pE/8duCZBTgmrpsOSlCM9nvgUs+8foCrA9NtLwl1VadeBP6APC4w
         KzUmE7D56hYnh/oGQlPbp95vlLCYqj+mF5tq8JF644LUjO1Gso3twEPBV9aOH/vumR0Y
         nwM0lMutavNQOTmWhzbmz4NLEnBzWScXt5U0LKYRG7HoIfG3lRg7fBwV/QI+MbmA1xde
         ccfw==
X-Gm-Message-State: AOAM5312dghW1TyJDPJlVtxb0iA0QfngRFi4Bf+misEr4z79luZV9YUw
        qOHGCkPQxb/Fc8oUDHt12Ini9j0FMQWTAdnJksVHI1B1BRRwfYOsHskMdxMdeQKu/G+rmjj2uuX
        7WwJGQzf7BwNGTgHFd7N2Za5yBEHvwTPPkdAexhhGdAwddsVcFoEJfU8Jc0wKGy+5Q4uAXA==
X-Received: by 2002:a17:907:7f02:b0:6ef:cc09:3d68 with SMTP id qf2-20020a1709077f0200b006efcc093d68mr14636717ejc.616.1650529043297;
        Thu, 21 Apr 2022 01:17:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvX3hESxwX3kQlkoMH0NRXalNfrLzX1uDeWwAPTMlCWF7NCwaiMBXsRWcUdwCpDGmLIm0MVg==
X-Received: by 2002:a17:907:7f02:b0:6ef:cc09:3d68 with SMTP id qf2-20020a1709077f0200b006efcc093d68mr14636707ejc.616.1650529043055;
        Thu, 21 Apr 2022 01:17:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id q17-20020a170906771100b006ef7d5b7a83sm5436830ejm.2.2022.04.21.01.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:17:22 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH testsuite 1/2] policy/test_ioctl_xperms.te: add ioctl numbers for other arches
Date:   Thu, 21 Apr 2022 10:17:19 +0200
Message-Id: <20220421081720.744534-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421081720.744534-1-omosnace@redhat.com>
References: <20220421081720.744534-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The FIOQSIZE ioctl numbers differ across arches. Add missing numbers to
cover all arches currently supported by the Linux kernel.

Fixes: b11701a55614 ("tests/ioctl: switch to FIOQSIZE")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_ioctl_xperms.te | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/policy/test_ioctl_xperms.te b/policy/test_ioctl_xperms.te
index 5f570c3..1071bb9 100644
--- a/policy/test_ioctl_xperms.te
+++ b/policy/test_ioctl_xperms.te
@@ -1,4 +1,5 @@
-define(`FIOQSIZE', `{ 0x00005460 }')
+# include FIOQSIZE ioctl numbers through all arches
+define(`FIOQSIZE', `{ 0x545E 0x5460 0x667f 0x6680 }')
 
 # Domain for process that is allowed the required ioctl xperms.
 type test_ioctl_xperm_t;
-- 
2.35.1

