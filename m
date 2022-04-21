Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C32C4332F
	for <selinux@archiver.kernel.org>; Thu, 21 Apr 2022 08:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243019AbiDUIUR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Apr 2022 04:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386569AbiDUIUP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Apr 2022 04:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAAE33889
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 01:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650529044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P4kJavn5PBrmWzsESk4ISOm+fTVxQqvuKJcfv7gCmHs=;
        b=AwYxuU8gLwCwip3WMwDBzcUyjSEDG3TwAJL7DVvVK0L0XCTVLMtZpBUrVpngblMSHZYqUy
        1WvPqF2ba3EOKCsAEMsa/ecQ3CEYM8asi7apvxnDMzTuNnkAI3AOM2Jiqf8Zon4l2jrdnV
        CVXlv9dBbKmUb/Raz4gckFt9gjTokb0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-wwtlGMuGMRm6OzZYPA1GWg-1; Thu, 21 Apr 2022 04:17:23 -0400
X-MC-Unique: wwtlGMuGMRm6OzZYPA1GWg-1
Received: by mail-ed1-f72.google.com with SMTP id cy25-20020a0564021c9900b0041d84fd5d8fso2787142edb.4
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 01:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4kJavn5PBrmWzsESk4ISOm+fTVxQqvuKJcfv7gCmHs=;
        b=vj5MIH4I3lUFcLuKYFrz7j413FxMVxeEK3L+/FAIGxqPTyT1h8neszc5tanYfqmNqz
         R7UVCfH1IV78uKWvZpzl+djATYlLLkcQ589KkMxisNc8V78BKUANpr2DJQcPTgVp+qcK
         gnqzTjq5UMcRiJwjwrVkj+mp50Apua3vQHKAqKb7EJCpYDZCGEPEbFGoWfBtmwAZMKcp
         gKT4+SQKOKulKr+uTnJ1zJExdlpa7NMKzXEcrOrWFPlg20ZjESDQjzqSwNpCqTEPd3L3
         pXlwJg/zCuV4KatL+giSF9Eb2OBoSDr9/KYijaaJO1P97Y1FLgDGBw27ADuxGXZFDHI7
         y90A==
X-Gm-Message-State: AOAM530ApKTWKlrpHkbF5VTdqyo6t6BW8kw4+zQixajks3mGImxjhKDC
        u4TtsANeaN/vUA3nqp9VDnsNysB7BK+j4cKrF762vXUlDri+4NgDKsqS21KmIbI6y1NVx/5YQ2s
        FrFhpMrLdO4yKOSXQ8+ze9Sez6JR/T+x5mVzhEL/03J0r1rM4x14SBI8HqM96U0sWlt+jKQ==
X-Received: by 2002:a17:907:7f0a:b0:6ef:cc08:bd73 with SMTP id qf10-20020a1709077f0a00b006efcc08bd73mr13407985ejc.210.1650529042090;
        Thu, 21 Apr 2022 01:17:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxCKvFQFcZI3TOeV4/JveqOG5EYCwSTsN12VN2mTdbgLIwcX4IWDg84i9sclnpivZO0vht2g==
X-Received: by 2002:a17:907:7f0a:b0:6ef:cc08:bd73 with SMTP id qf10-20020a1709077f0a00b006efcc08bd73mr13407965ejc.210.1650529041767;
        Thu, 21 Apr 2022 01:17:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id q17-20020a170906771100b006ef7d5b7a83sm5436830ejm.2.2022.04.21.01.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:17:21 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH testsuite 0/2] FIOQSIZE followup fixes
Date:   Thu, 21 Apr 2022 10:17:18 +0200
Message-Id: <20220421081720.744534-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Two small fixes for the recently merged switch to FIOQSIZE. One was
found when the testsuite was run on ppc64le and s390x arches, the other
one when looking at the code.

Ondrej Mosnacek (2):
  policy/test_ioctl_xperms.te: add ioctl numbers for other arches
  tests/ioctl: adjust size of variable passed to ioctl(2)

 policy/test_ioctl_xperms.te | 3 ++-
 tests/ioctl/test_ioctl.c    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.35.1

