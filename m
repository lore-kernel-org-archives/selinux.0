Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3C2C433B4
	for <selinux@archiver.kernel.org>; Sat,  1 May 2021 10:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B47CB613E7
	for <selinux@archiver.kernel.org>; Sat,  1 May 2021 10:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhEAKpO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 May 2021 06:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231252AbhEAKpN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 May 2021 06:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619865864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Vxh0gAdGqHlyRM06hoxyaqbX+y8jhsm78TzVgGOg1g=;
        b=OVOh1IlfLapkw8ez1Avhu8AocflOSI7YijJXUvobCU6bu2igc0YkiYJroTN4leklosume/
        tDaMZmV2ADeM4YWOHpKI4k2MyZnWIZq4G4MMSl4L7e9VBmfA8Qd4RJ+cMihwNiCH0hrkh2
        /JaNhpkEsGjBX4kvY9wzR4ycLDspgbw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-q6p9Vc6mO1qRfgLOc6kUxA-1; Sat, 01 May 2021 06:44:22 -0400
X-MC-Unique: q6p9Vc6mO1qRfgLOc6kUxA-1
Received: by mail-wr1-f69.google.com with SMTP id h60-20020adf90420000b029010418c4cd0cso493027wrh.12
        for <selinux@vger.kernel.org>; Sat, 01 May 2021 03:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Vxh0gAdGqHlyRM06hoxyaqbX+y8jhsm78TzVgGOg1g=;
        b=agj79LVsfJdsuUwwP5Pr096q1awftUBvvJOTQsMvD/6cWMw43CV94PK5iOQ+Icybf0
         jLS1Nw6zCiBHEmqEIAx+UTirDEBdcSrB+cRAcdAK8uK+3Na7juO1LAK+pyz4vsvbpor5
         yg9E4qCgSA/N/Se/d9tulPyeTSyGzrxCcvH0lKr0yR5e7JTjoo6LPLyAcR4PC407601c
         SVbdrK8/UvKvJKZsjhtk3XVwO4DqbFuNdE98QOmw55qC/JrS2iz5Fij8wR4DA1EpPaqr
         kkvu8wRAri58wlIULn7pi+EYxfrwJ5VF7FKsi1mXMKo+K91+Gx9leL0sXhYhDShwa0Xl
         5/5w==
X-Gm-Message-State: AOAM532D8YZuiC+Z0Z+KGso0dDaijRvpmSlzyXhEJymE+bY8y/SseG5f
        tIou4i0xYvk13MyrE+6y7mwKJALXkuDtzfJRZ1HmbZSaGaxUyZiEESlHJe9G8UUnbat2th7bn/F
        Kyi2E+2rGOEpairzySB7OCsBRQdhqZ9lqvXE0s3KOFulzUanlf/S5N2YUYyB8MC1D1W4R0Q==
X-Received: by 2002:a05:600c:3388:: with SMTP id o8mr1408894wmp.101.1619865860722;
        Sat, 01 May 2021 03:44:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdt6pA5eDBQoc/gy7+kVQVLx0OTCpIyCaOE515KH5wN957CRQQU62aNC5pVycgZ6EtbQ1r0A==
X-Received: by 2002:a05:600c:3388:: with SMTP id o8mr1408880wmp.101.1619865860495;
        Sat, 01 May 2021 03:44:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id m15sm5153031wrx.32.2021.05.01.03.44.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 03:44:20 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] ci: test also on F34 images
Date:   Sat,  1 May 2021 12:44:19 +0200
Message-Id: <20210501104419.20220-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the CI configuration to test also on an F34 image in addition to
F33 and also test kernel-secnext on F34 instead of F33.

We could of course test just on F34, but having an older release in the
test matrix should help ensure that the testsuite will still work on
older kernel/userspace versions as well, so I'd rather keep both.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .github/workflows/checks.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
index 59f1a47..d0e276e 100644
--- a/.github/workflows/checks.yml
+++ b/.github/workflows/checks.yml
@@ -15,7 +15,8 @@ jobs:
       matrix:
         env:
           - { version: 33, secnext: 0 }
-          - { version: 33, secnext: 1 }
+          - { version: 34, secnext: 0 }
+          - { version: 34, secnext: 1 }
     env:
       FEDORA_VERSION: ${{ matrix.env.version }}
       KERNEL_SECNEXT: ${{ matrix.env.secnext }}
-- 
2.30.2

