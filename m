Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BD7C433B4
	for <selinux@archiver.kernel.org>; Tue, 27 Apr 2021 20:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF30E613ED
	for <selinux@archiver.kernel.org>; Tue, 27 Apr 2021 20:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhD0UPs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Apr 2021 16:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbhD0UPr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Apr 2021 16:15:47 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECF4C061574
        for <selinux@vger.kernel.org>; Tue, 27 Apr 2021 13:15:03 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id b14so4111582qvf.9
        for <selinux@vger.kernel.org>; Tue, 27 Apr 2021 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=x5tiNNYa8DgqYjf8WsS6xQbPIr4loBU5caU/wtED5mA=;
        b=XNo8DTsJ9BgZDoIosadZN3AKugS0WNFbfMHZayI0YSHD/XiAG4RdYeyuCG16Zn9J8t
         P6PeHeRx2nRDtVkRcoIklFnEv7aOxsF2WVH7+3JM2fDsoA+iNDmdSS0e2W6T71mknBQq
         9hTB9BLRQxfUkokbAn8DE7naILTHnwPRlhyCoyFAfhkquK4JQeHPrUV7vNBXSmuk8T5w
         ycEb0qPQPZ8/9SAhIGgIoKtbX8pMvqtx/W3W77aMN4l3D/gt6A5C3Q6trQrkCGRdTwOg
         RGR5aNwr0rPVqW3C6e/Cl5ZzDY0VMVWvGKWKfYmXAQQSnbe45+p7kG5EDokvcN/GRWTi
         AeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=x5tiNNYa8DgqYjf8WsS6xQbPIr4loBU5caU/wtED5mA=;
        b=OPi+xkEDDfkNImr/fMzN1O9K8Ka3FJfoPfkAdqHURXDBwsEz2aEWW/ChBiRGFFUG+k
         Ilw5Q6VOscfs5DdTcy29YN/538g+lettYqSOuNb455wkWNFaV/KXYFAG2Y0DIvQC9Gwz
         CIlHcdzy26n+0j8IOb/hCXT2/dN4CLCeIQYzHabikP/7ECNCgRJQ3YW2Y0ffmORCiZxH
         Q/o9M+13puAJEU2BLFGi5z7RthRf18KlpfgXyWAcUXprvSk0L+4WjU4I75Q3JguuKvxZ
         vPiAndsvYZA3XXDfFgvNSdc9ORHpGH14zfTCLv4jxnXIlWmwttasffAWWYMqcYEsT946
         ZXbQ==
X-Gm-Message-State: AOAM533k9yQA1pDVhT1v5h1Lpyz3rkYK3ZxDFCTHzbcOHxyL8e2AN4oq
        Kjqdz6a69h+//7lahrjKbx7xChR++8yh
X-Google-Smtp-Source: ABdhPJwCaPmp4k32YnTl8stTLlYL7PIC37+U9lf6Q7ZO7AUnirr+JgsfBMcGsyp8oFT+XflkXf7ivQ==
X-Received: by 2002:a0c:f1cc:: with SMTP id u12mr25764285qvl.20.1619554501437;
        Tue, 27 Apr 2021 13:15:01 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id x204sm3529842qkb.97.2021.04.27.13.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 13:15:01 -0700 (PDT)
Subject: [PATCH 2] testsuite: fix cap_userns for kernels >= v5.12
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Tue, 27 Apr 2021 16:15:00 -0400
Message-ID: <161955450031.8261.16400002795828868356.stgit@olly>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Starting with Linux v5.12 CAP_SETFCAP is required to map UID 0/root.
This is due to kernel commit db2e718a4798 ("capabilities: require
CAP_SETFCAP to map uid 0").  In order to resolve this in the test
suite allow the cap_userns test domains to exercise the setfcap
capability.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 policy/test_cap_userns.te |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
index ab74325..9683870 100644
--- a/policy/test_cap_userns.te
+++ b/policy/test_cap_userns.te
@@ -12,6 +12,9 @@ unconfined_runs_test(test_cap_userns_t)
 typeattribute test_cap_userns_t testdomain;
 typeattribute test_cap_userns_t capusernsdomain;
 
+# linux >= v5.12 needs setfcap to map UID 0
+allow capusernsdomain self:capability setfcap;
+
 # This domain is allowed sys_admin on non-init userns for mount.
 allow test_cap_userns_t self:cap_userns sys_admin;
 

