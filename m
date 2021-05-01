Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D1FC433ED
	for <selinux@archiver.kernel.org>; Sat,  1 May 2021 10:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED8CC613E1
	for <selinux@archiver.kernel.org>; Sat,  1 May 2021 10:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhEAKkb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 May 2021 06:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231252AbhEAKkb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 May 2021 06:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619865581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MYwX+w+minzT9s1SlKaza2KlbaOTPXKZJIIXQe6vGuI=;
        b=Ayr0t4VOW1gktOTac4RysdXPHzZrExoVYi+GiwZVnnJOOB0TEkalTfmUl5FYj7y2IUlAts
        L8dcjNikydjw28bfPNEqbZb7WS1q+Cd3FRgBWbfFpJg/0ODTvOysNm8i1CrhDGlb+zOzdU
        jcxfT3jGy/jNnAq/PXokqGaYX5l9Uck=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-uhSVaNfYMs6TWazOs0Rz4g-1; Sat, 01 May 2021 06:39:40 -0400
X-MC-Unique: uhSVaNfYMs6TWazOs0Rz4g-1
Received: by mail-wr1-f70.google.com with SMTP id 89-20020adf83e20000b029010c35eb9917so516367wre.1
        for <selinux@vger.kernel.org>; Sat, 01 May 2021 03:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYwX+w+minzT9s1SlKaza2KlbaOTPXKZJIIXQe6vGuI=;
        b=nyiPmU8nuL61HnLFlaLo7ZDlR2fzv4VeprJGGYGnzlvuGdxp/xAcRV1+P9KgpbZ2zX
         pyM2B9KxRoLkB3ifFJcPPJ2yYZNS6SFyGDU59jtn1ZNBuewxLgjOPNx7AEWDEGlAdZkl
         vJK8Ldp+1A83hvpJJmtCS+C18GmOkxrA5XFxhRduNxs6hn1DvlHRNg8oNiQZfdjhki6Y
         rmRRKEI35WMrcRYbt9oNY59L+uRilTrMPKJAVnI564mIamfslRnoW7VT5wrONLdLHtBD
         1xOWQtX/+uWxLOtyM15Kd1xCTYH8JwclaS+aUOF8WtPITbLMHZyn4AuSNSQfwG87oF1j
         g56w==
X-Gm-Message-State: AOAM530fc20XhNgyCaWDvWp/oLCMbrKYG4LLsBq42kSyFii9+1c4mRi/
        XFyinqKjJFEbOHpK3pMx4VihIo9Z8sFkfV6sPMy/nfqvNm77/L8cbBRaWl32jiROgIroK21bMFv
        zOu+si/kxm5gXJJYPhrP9JMI+tJb1AAico2FpnlLxxAV+rHwXbTHPSG6Upcd1tnLdeoeZdQ==
X-Received: by 2002:a1c:7f58:: with SMTP id a85mr21792496wmd.149.1619865578540;
        Sat, 01 May 2021 03:39:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBVetPungj2P0KycDTXaFY15OSOWKdZB1fTj0jqYkdD+Pp7WmLk700JF/KNVIh+OGOxczl2g==
X-Received: by 2002:a1c:7f58:: with SMTP id a85mr21792480wmd.149.1619865578251;
        Sat, 01 May 2021 03:39:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id l21sm17377282wme.10.2021.05.01.03.39.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 03:39:37 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/lockdown: use /sys/kernel/debug/fault_around_bytes for integrity test
Date:   Sat,  1 May 2021 12:39:36 +0200
Message-Id: <20210501103936.19527-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

/sys/kernel/debug/sched_features has been moved/removed in kernel 5.13,
so use /sys/kernel/debug/fault_around_bytes instead, which will
hopefully be more stable.

Fixes: de8246f5c853 ("lockdown: use debugfs/tracefs to test lockdown permissions")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/lockdown/test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/lockdown/test b/tests/lockdown/test
index 6694a4c..a86c988 100755
--- a/tests/lockdown/test
+++ b/tests/lockdown/test
@@ -3,7 +3,7 @@
 use Test;
 BEGIN { plan tests => 8 }
 
-$integrity_cmd       = "head -c 1 /sys/kernel/debug/sched_features";
+$integrity_cmd       = "head -c 1 /sys/kernel/debug/fault_around_bytes";
 $confidentiality_cmd = "head -c 1 /sys/kernel/debug/tracing/tracing_on";
 
 # everything is allowed
-- 
2.30.2

