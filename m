Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB19AC433DB
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 13:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5F5600CD
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 13:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhC3NRA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231794AbhC3NQw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 09:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617110212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zDn9ZFI/0BuCmvdKcn7cJI83LTvfK7KXgfeKU9KOzFs=;
        b=WszDWEB5t9EZQSydw9fIZ7Tf7S7LVev86oL8tr6reqmFLUEP0zsXKSgX9JDW17GLBw6FVY
        gneStLw+nb9Aj8sOkhXi6KoGlnjAd61iA5ATV623lDH8buWpm+sqs4ugtj2EcXfPx3MOwb
        BprF0gB5het8GBEJdUQUsWRx+Jydy90=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-U6ztTKYjNV267_hwEXHr0A-1; Tue, 30 Mar 2021 09:16:50 -0400
X-MC-Unique: U6ztTKYjNV267_hwEXHr0A-1
Received: by mail-ej1-f72.google.com with SMTP id v27so7134000ejq.0
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 06:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zDn9ZFI/0BuCmvdKcn7cJI83LTvfK7KXgfeKU9KOzFs=;
        b=mr0e6aWrKIOJYORQKo+5anBmaR45bk23PHJ/7KxwtIl0dL8/hedNwDB6sCIU4NQyll
         VFcMwMo4GQa9F5v2KqJ9Mpzr9sumt9hbW5jGMnlTdv5HLDeH3pE/7lV44+Bpv6OtbLZV
         XFlCQgjhiw8kvcNxoXraL3axQCq5zo1sRvXKxxYHSIDsCQkTeX1fmdzvFPElAlD7AyCR
         TLmQ/nvgieWqHfHSTxzCaBI8WOeTg2Ht1VAHN1pPj9iR0nPCqK2qwphvHF2ihscHQB8d
         U+Mu5HTmy9Ax5Mbaysjkc9Z0dR7qqdWPQmNxOAUur2pAZYLGxq4DJV9pm3+ZEnvjEdsa
         afjw==
X-Gm-Message-State: AOAM533lqQkuGUHZ+zOjYXSw8x3ceQf6ih/WoZ7flKGiGDRh9FSnPuXS
        rEn8vJ+kp5c1LshMDipwwry1e3t0u2h2/X8v0JWEzM0oIT9yt6K8B0lQmAFnzp9TlOCzwa0H3xT
        s+Fn/9GGYgyQM4/vTXZB38oJ1E1prxSHuKjrjJtkW0D1SdACieOrTF/EePgITHJE6XEKxGg==
X-Received: by 2002:a05:6402:17e9:: with SMTP id t9mr33565798edy.211.1617110208879;
        Tue, 30 Mar 2021 06:16:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWY1logX76bzv8TLaYrxbw/HrwmBpjahtwSxusFHhn1WiYG3YlKuPHe9dNNkyIYI/KdkYT2g==
X-Received: by 2002:a05:6402:17e9:: with SMTP id t9mr33565779edy.211.1617110208701;
        Tue, 30 Mar 2021 06:16:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id u16sm11178245edq.4.2021.03.30.06.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:16:48 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 0/3] selinux: fix changing booleans
Date:   Tue, 30 Mar 2021 15:16:43 +0200
Message-Id: <20210330131646.1401838-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series contains a patch that fixes broken conditional AV list
duplication introduced by c7c556f1e81b ("selinux: refactor changing
booleans") and a couple "and while I'm here..." cleanup patches on top.

Ondrej Mosnacek (3):
  selinux: fix cond_list corruption when changing booleans
  selinux: simplify duplicate_policydb_cond_list() by using kmemdup()
  selinux: constify some avtab function arguments

 security/selinux/ss/avtab.c       | 118 +++++++++++-------------------
 security/selinux/ss/avtab.h       |  18 +++--
 security/selinux/ss/conditional.c |  26 ++++---
 3 files changed, 65 insertions(+), 97 deletions(-)

-- 
2.30.2

