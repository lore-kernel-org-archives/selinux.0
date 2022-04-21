Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08251C433F5
	for <selinux@archiver.kernel.org>; Thu, 21 Apr 2022 08:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386569AbiDUIUS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Apr 2022 04:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386576AbiDUIUQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Apr 2022 04:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84DF938BC
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650529046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dGlJdQJ4QVr4j6xgKkEE1rpPhK9kWa1On/8jcFjS4k=;
        b=Q11uIF+Bt9/J0eK8kO9uD6PRKowNsWncgLauLjn3Iu3s7KO3z1Wy454+EJR566zDYGrlR4
        vSYQXwrmEoX4W1kt2SdO+jIHDt2xEbfFPBf2dl67uNxaEP7T3G1XLrd8LVxUN0qdYiPaWT
        1BbX7IKaS2XhDN2rfiMlCla0OgAupuw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-vPbe1dlgMdm155Y5nFKTFA-1; Thu, 21 Apr 2022 04:17:25 -0400
X-MC-Unique: vPbe1dlgMdm155Y5nFKTFA-1
Received: by mail-ed1-f72.google.com with SMTP id cb11-20020a0564020b6b00b0041d870f7b3aso2782120edb.11
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 01:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1dGlJdQJ4QVr4j6xgKkEE1rpPhK9kWa1On/8jcFjS4k=;
        b=q6g+Dr0my7OgsY+Ofy0MH9t7hXXaNHU4PLfzorpiqNaaXEi7P9ZTpEomiKJuwqbxid
         cDquqxi1OWqxj1pwYZa4WiovvQN94kLtH4DNmgVTalpIsilv++4nNSbsuYFT9G8Pb1SI
         9oc5a/nqwepTKylDdi8J6SW4sTuaTym2pqFf9Y0n53Sne32JM/gvHCZOudaHWTTnMHBV
         5ryQfuiSwmJt1Shw/d3N6dUlBM6HymOVM0IFXOjmdVtnpKovNl7bUVCGTs3tg8yurNJa
         MXKOUhUEC4uPIW0i50XYgkTuRo1SrTsj1ixieNZujXZUihtvqkaw2Nha/UvBKcZjJMzq
         GIrQ==
X-Gm-Message-State: AOAM5331VCwPl3pA8R5AenPIRfuULLQZpG3U8PZ5GoF+IOq0Vf/RiwEN
        SXtoYyTJlQG4Ugc3aIaa3PrSlAn/w3lt6nw3dvONK/TeLDw8a54Wx8bIX0yG8OrbURsRMvGkAcp
        NFmczX2Np2uheglSPIwS7FH8YZa7+quvF7mapRSe7ydEiZIgLfdPHIZfY6pGBj4Kb09op0w==
X-Received: by 2002:a17:907:7f94:b0:6da:64ec:fabc with SMTP id qk20-20020a1709077f9400b006da64ecfabcmr21985387ejc.717.1650529044089;
        Thu, 21 Apr 2022 01:17:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztxwA+5v2XFrZqGDwzPu4U/vuSnxkeIgj/A+T66XZbYv6zMeFNDxVjoWpBRRmumxukeTbVJQ==
X-Received: by 2002:a17:907:7f94:b0:6da:64ec:fabc with SMTP id qk20-20020a1709077f9400b006da64ecfabcmr21985373ejc.717.1650529043826;
        Thu, 21 Apr 2022 01:17:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id q17-20020a170906771100b006ef7d5b7a83sm5436830ejm.2.2022.04.21.01.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:17:23 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH testsuite 2/2] tests/ioctl: adjust size of variable passed to ioctl(2)
Date:   Thu, 21 Apr 2022 10:17:20 +0200
Message-Id: <20220421081720.744534-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421081720.744534-1-omosnace@redhat.com>
References: <20220421081720.744534-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

FIOQSIZE returns a result of type loff_t, which maps to long long int,
so make sure that the variable is large enough to not cause stack
corruption.

Fixes: b11701a55614 ("tests/ioctl: switch to FIOQSIZE")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/ioctl/test_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ioctl/test_ioctl.c b/tests/ioctl/test_ioctl.c
index 6fff2d0..9bf732d 100644
--- a/tests/ioctl/test_ioctl.c
+++ b/tests/ioctl/test_ioctl.c
@@ -18,7 +18,7 @@ int main(int argc, char **argv)
 
 	int fd;
 	int rc;
-	int val = 0;
+	long long int val = 0;
 
 	fd = open(argv[1], O_RDONLY, 0);
 
-- 
2.35.1

