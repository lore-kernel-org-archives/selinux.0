Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35BDC433EF
	for <selinux@archiver.kernel.org>; Fri, 24 Dec 2021 15:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353041AbhLXPHs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Dec 2021 10:07:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352999AbhLXPHr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Dec 2021 10:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640358466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BF/YCJv1AAKRhV+98m4TlzO0qSIWH7hI7+kRVcFAOVU=;
        b=d72A0052yFK4Ma49RuQ53Roi0BUqAVmlmIantFAvT3ZiAbozO1XHE9dC4SCRKWkSf+rQ8C
        XJ+uA2kK6mA6qt//CL6mX5oTaDWSmbVCIVNqx7fuh4eWVh9tv8GD4mNf6xTwi3keCDHc/a
        JjGi7TtRG3HJjvJe+WyYH4WFCPZ2WZQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-V0Ib1EP6NqqC2movXuOXeg-1; Fri, 24 Dec 2021 10:07:45 -0500
X-MC-Unique: V0Ib1EP6NqqC2movXuOXeg-1
Received: by mail-qv1-f70.google.com with SMTP id i3-20020ad45c63000000b0041143710adbso6805342qvh.18
        for <selinux@vger.kernel.org>; Fri, 24 Dec 2021 07:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BF/YCJv1AAKRhV+98m4TlzO0qSIWH7hI7+kRVcFAOVU=;
        b=yUhoRo2gIoOBNGdYThAG+nFM/SvIOgCvW6lm/EzD2loaBkIHSW4CARLLUq48Br4Iv6
         z839d3s93g33FoInTMlBUs42vzSbeFGt5xpNnTV4LQwr0C8e/gDaW6hmbZPoDb9hNQ98
         Tz0WN22wDLWGIWwam+TCWQ8Smx7t7KlbrPpHnWnE6+Z8zYQzMQLEaMYQZbYQcgsPiBnE
         VfFvgdWVmMYaiBwAvRitFpkOxPV8Aq51e9juKWHi97yldEMw48E/87jArP2NajceC6uf
         +jYjaw2ebaPiuDf/v56zLtQk+/QFObub8FJWlva067mB/bJd/GGQE9YdLsWlvnS5WL+y
         qPLQ==
X-Gm-Message-State: AOAM530Naw+n4GmIKYVt12tMul+C6tyzMI7av37zU+D4rANl4ANGOGYE
        iMl7qJzGe0yGs3bwVfk1MQUYTIN49DbCn2Vq5Ocpe0F7mbfh1WSIm4bLRQGtRDezg3SgjAHdKoK
        euG4c2XxEYsaWb2VeBA==
X-Received: by 2002:a05:620a:809:: with SMTP id s9mr4863328qks.156.1640358464963;
        Fri, 24 Dec 2021 07:07:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1pKHrG4CVFHlqnEQE1caIilyx7SPxj7M2T/jSxcp1oBjfTGs3uB+F1wC/sUIYc89L4aGXzg==
X-Received: by 2002:a05:620a:809:: with SMTP id s9mr4863309qks.156.1640358464728;
        Fri, 24 Dec 2021 07:07:44 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id bl8sm7314148qkb.38.2021.12.24.07.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 07:07:44 -0800 (PST)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] selinux: initialize proto variable in selinux_ip_postroute_compat()
Date:   Fri, 24 Dec 2021 07:07:39 -0800
Message-Id: <20211224150739.3278019-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this warning

hooks.c:5765:6: warning: 4th function call argument is an uninitialized value
        if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

selinux_parse_skb() can return ok without setting proto.  The later call
to selinux_xfrm_postroute_last() does an early check of proto and can
return ok is the garbage proto value matches.  So initialize proto.

Fixes: eef9b41622f2 ("selinux: cleanup selinux_xfrm_sock_rcv_skb() and selinux_xfrm_postroute_last()")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e2a6d0f5c47af..fd7a0e9e26647 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5742,7 +5742,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	struct sk_security_struct *sksec;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
-	u8 proto;
+	u8 proto = 0;
 
 	sk = skb_to_full_sk(skb);
 	if (sk == NULL)
-- 
2.26.3

