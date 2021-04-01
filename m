Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F6CC433B4
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 18:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529B861001
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 18:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhDASDj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237141AbhDAR7h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Apr 2021 13:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ktS87jJw/08j20VhO7XCpSRx0/B7KGmgEACWGMbsYe0=;
        b=K3CjOdES2AyxKZR7nBdwCizVZQr8qp2rUe9vNZeKb7QQSkKXVO6fMKrypEa36G9UGJk0Qp
        b7A789+m1PbHJONmLR6g6A8knG+pk8HmnamU7qcvsYOuk2/A0haLhcCZJM15Za2OwMpnBL
        XTtl0QVyOa//cFWrb2gYjum6M589xOk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-GbXUuF3lNYWmsahCoaIuQw-1; Thu, 01 Apr 2021 11:59:17 -0400
X-MC-Unique: GbXUuF3lNYWmsahCoaIuQw-1
Received: by mail-ej1-f71.google.com with SMTP id mj6so2417005ejb.11
        for <selinux@vger.kernel.org>; Thu, 01 Apr 2021 08:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ktS87jJw/08j20VhO7XCpSRx0/B7KGmgEACWGMbsYe0=;
        b=GX2xASDBT1qN5MH7ZCTqzi/d4A9G5eq+J2ZZbLTMfK8mIjfD+WpW1lGOVc3CIHRQPA
         VdpSAmzqFlg8MrvfAon/ARmNGq0nYYgwfYIgWCaUocVox/ewKA0MZqx+YAZMB4HJYGIE
         mYfbgfkoNHMfNA3bmFnVR1YPecDngAyHNZcTHop1muuGgvuzRdncGasnzLZzoQDwhF4Q
         fhveSbKNEmft3Aw/L2iLREQKUzBs3HjXERTIe9yDIt+qj/Gt+mvxUoDRcynfp2sBqj1f
         gclTkYDyH0E2252bdcTBcWAyBAdIsl9evA39zjH87BID2AHnxG85VZ+2eBVXjLw+yOgG
         YNyQ==
X-Gm-Message-State: AOAM532UOpBi3iWdv2bXDxycsHNRnECfE4BDLLCCn1buPyCbXpPjq6g/
        tLwzMhEOQDucwmStiMgwoT1yes0YEpstz4FNlbPTYSjEoFdVtia/2zIO7Dxmc6P9T/kWDIzlcCd
        UKg3ejjibo57Lq+nxrKLwHFA5+QNVhCUZg4UhPMhkVoyxrdTdVJJEJUg6GjGeHxsYZ/x+Hg==
X-Received: by 2002:a17:906:1a16:: with SMTP id i22mr9939957ejf.522.1617292755762;
        Thu, 01 Apr 2021 08:59:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3leMnDpHexp5bDnN1+poyT/rHNN/Wvtl9/ILLDnViHZtqUkyv5W1eMD/JS0gIcPNgc3k1QA==
X-Received: by 2002:a17:906:1a16:: with SMTP id i22mr9939943ejf.522.1617292755575;
        Thu, 01 Apr 2021 08:59:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id x4sm3537000edd.58.2021.04.01.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:59:15 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 0/2] selinux: fix changing booleans
Date:   Thu,  1 Apr 2021 17:59:11 +0200
Message-Id: <20210401155913.1693097-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series contains a patch that fixes broken conditional AV list
duplication introduced by c7c556f1e81b ("selinux: refactor changing
booleans") and a couple "and while I'm here..." cleanup patches on top.

v2:
- drop the follow-up cleanup patches from this series
- add a patch fixing the current handling of nrules/nslots being zero
- fix this handling also in the original v1 patch
- simplify the loop that computes nslots

Ondrej Mosnacek (2):
  selinux: make nslot handling in avtab more robust
  selinux: fix cond_list corruption when changing booleans

 security/selinux/ss/avtab.c       | 101 ++++++++++--------------------
 security/selinux/ss/avtab.h       |   2 +-
 security/selinux/ss/conditional.c |  12 ++--
 3 files changed, 40 insertions(+), 75 deletions(-)

-- 
2.30.2

