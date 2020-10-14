Return-Path: <SRS0=aJPZ=DV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE5FC433E7
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 07:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE63D20878
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 07:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnkiIwVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgJNHh3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Oct 2020 03:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbgJNHh2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Oct 2020 03:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602661047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jUBKznBz+w04lTV+Iiqq2Ep5QBc6DxTgUt2VWxuuVC4=;
        b=AnkiIwVyEWqgUPTHHLHvc5kiXXMchexNvVRZFeyamtH5YYOShqxLet3O5o+wVjfxcyVyYz
        /ATHTBiF/sbphIbQHjj5eNiF1UDiHvStJEaYWS4FobEEK+Ys7kFJ7ad4urgvLakVk6quSi
        zZK/iDr6x+E2rVs1136HYfObInSS+bg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-w67VTWoJML2YpEf4NHLtIA-1; Wed, 14 Oct 2020 03:37:25 -0400
X-MC-Unique: w67VTWoJML2YpEf4NHLtIA-1
Received: by mail-wr1-f72.google.com with SMTP id k14so923102wrd.6
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2020 00:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUBKznBz+w04lTV+Iiqq2Ep5QBc6DxTgUt2VWxuuVC4=;
        b=nnPIHA+nsTgPKe+qUcoIGKQRUwtvd+0uoz85WyC2Z2TFzgm5md9FMzepz+AFTVNcEM
         qR/ro47zGJeyXwDfkMu/3H35B7Nr9nT2an7lzg2QtlqLk6hNJcsCecfh2yh627pTgDLi
         2mQ37SjslmCdzazXAZf88WuFh1uIxPePQbu4rdOX/iag43Nr3F0KbnIDRBArlmOtbwDq
         gHKPCQ5Y2Bq1otx6e8jqrLLFrUkjEMutId8NhRxGcA0sjLvVjz7wb8FnfrTm4mzFMKeM
         ps7kwKPJat4fGO1ro8vwtqZYjGPNltgoyiUIFy0lIOd4I2mPELonocWPpULvfW4nSFsN
         k4ZQ==
X-Gm-Message-State: AOAM53164MKbq10azcWixwejU/UExTse/CkHRhk2nWcZpHyBdatMkWLA
        FVyMtJlzTIgzXvoajO8EQ8awKHalozxack/j/LcdY3VIq3yENugXIYb2o2L6fxJJcx3JO/Rnb5L
        xebF2qPhIB+a5mJvfEw==
X-Received: by 2002:adf:e350:: with SMTP id n16mr3871263wrj.415.1602661044213;
        Wed, 14 Oct 2020 00:37:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC+Llvwl4TmlIewbsp/rO5TkgOTWp8V6aIs4Sp6m2CxypqZAr4VvhLDrUHnplEywsL94zdHQ==
X-Received: by 2002:adf:e350:: with SMTP id n16mr3871248wrj.415.1602661044037;
        Wed, 14 Oct 2020 00:37:24 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id h1sm3406997wrx.33.2020.10.14.00.37.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 00:37:23 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 0/1] 
Date:   Wed, 14 Oct 2020 09:37:20 +0200
Message-Id: <20201014073721.392783-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

 tests/keys/keyctl.c          |  8 ++++----
 tests/keys/keyring_service.c |  8 ++++----
 tests/keys/keys_common.h     | 28 +++++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 11 deletions(-)

-- 
2.26.2

