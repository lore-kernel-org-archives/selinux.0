Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F95C433E1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 11:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3600E2078D
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 11:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0dk19VV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHXLah (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:30:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726624AbgHXLab (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 07:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598268621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t2UWkIRF6+ESzs9Scc+cGtU/5IIfRfGhetSPQR8rkh4=;
        b=X0dk19VVvqPKJ8fdd2RgPvWZD8cfYy1lwkzk26HASmrxK2i1HV1FOsH1Cmn/AePpTIlWno
        TM+qiVJjoKgeUDg59jt/MmKPAQTP2AMfHf4RI1ugGbET75CrNsxRoA9pGUeModfC0fK3YO
        bHvhpgDo23kkvMGkheuMrinSlMEtTgQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-_Fky0HUtNY6YlSPVG1MouA-1; Mon, 24 Aug 2020 07:30:19 -0400
X-MC-Unique: _Fky0HUtNY6YlSPVG1MouA-1
Received: by mail-wr1-f70.google.com with SMTP id b18so3862380wrn.6
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 04:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t2UWkIRF6+ESzs9Scc+cGtU/5IIfRfGhetSPQR8rkh4=;
        b=m5U5DBEvBSimruoRCtq12ILHTMKMj98icrmuBNO+4h1Dp5rdIqtsjuKdM2Xc46BoEx
         KXjtsBAWD7XAMzxjq1OSn4X4NfjrvrBYjIkRuOhm7PyrlrvQSNBVCdrHAX0f3yUFCQ50
         LYodBq7NVQ5N/ddc7ORNihSfDHdq3erGWnZ81lWfNhwowmY91u2968L18paTXQlrpAkj
         AeteOH8CQCrcCSDShFwx83damUXyni9d/kIRKUNWo1opyYeDmvmSVD93xsa8hRjuHGnq
         KWJy1Ezbg6kNNAM0m4BBaphy+rdMa/wTq+D9FTE6X56e+h6BUg5WgKX4GBDUzAtwTV1s
         xB6g==
X-Gm-Message-State: AOAM532XTVmKOvifKqkxo579WHrdDIGCh/eneIfMnGQPsun4DuOD70zw
        ApA50FpXuziv+KrCF0r8vMfk47z7DbGzOA+FsuJzgcF2+myCWoh2HsCFPmGDLqzcOCoIXpu0KUo
        pYtj2R96QCsp8PKFByQ==
X-Received: by 2002:a05:600c:28c1:: with SMTP id h1mr5425471wmd.174.1598268618045;
        Mon, 24 Aug 2020 04:30:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyateQFfFfVN7aWJxKgyM4J1vJ3pTeP7iEf8ZEAt7owRZkRS9PzMOfoq0RUs4n6KjH8mKjQ9Q==
X-Received: by 2002:a05:600c:28c1:: with SMTP id h1mr5425454wmd.174.1598268617785;
        Mon, 24 Aug 2020 04:30:17 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id l1sm25092434wrb.12.2020.08.24.04.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 04:30:17 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 0/2] Fix race conditions when reading out policy data
Date:   Mon, 24 Aug 2020 13:30:13 +0200
Message-Id: <20200824113015.1375857-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

v2:
- avoid calling vmalloc_user() under read lock
- add one more patch that fixes another related race condition

v1: https://lore.kernel.org/selinux/CAFqZXNvdtpxveqesYMz3ZxoWGd_vi5euqy6c9gzhmdkKgbU-Fg@mail.gmail.com/T/

Ondrej Mosnacek (2):
  selinux: fix a race condition in security_read_policy()
  selinux: fix a race condition in sel_open_policy()

 security/selinux/include/security.h |  1 -
 security/selinux/selinuxfs.c        | 12 ++++++------
 security/selinux/ss/services.c      | 28 ++++++++++++----------------
 3 files changed, 18 insertions(+), 23 deletions(-)

-- 
2.26.2

