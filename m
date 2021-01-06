Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30753C433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE5E2311A
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbhAFN2A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:28:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbhAFN17 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 08:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609939593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hCiAK3Ufb3KVgmzbhsuoS1dNrxcSXsXep9MxlkjWe14=;
        b=XPKH40B8OV4Eo0TUOHVohHZPSLugCEfDYWPshsV2chV+KzgPMwaEzUox89gfalouTxZcMT
        83YyPwCsQcyGq+x4aVugkJCKxkS1qo8soPYrX9iUqt126reXekmjBC+/TQsefrqUSYoyf4
        PsL9PRRHhW1fI8EuXpiIa4of0JZkuUQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-bvXtkilUN5K4Emmt2rVAgA-1; Wed, 06 Jan 2021 08:26:31 -0500
X-MC-Unique: bvXtkilUN5K4Emmt2rVAgA-1
Received: by mail-ej1-f71.google.com with SMTP id dv25so1283690ejb.15
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 05:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hCiAK3Ufb3KVgmzbhsuoS1dNrxcSXsXep9MxlkjWe14=;
        b=tqDaTbDLaFMcBvjptYwUYzejOXmdCQBZjH6yRN29ImTbe6LCrxSvmULgLy71+sT4MU
         w7pPSbPJVgQfbFdP6tQ+QAuOyt0JNeR+QyQCG90VygrBbcfessyByjQzDlS01joBkcO7
         PdowDrf3AXqUc37uI9bjng6M+4xc/rIvypNSS5WbvyXSrvDSQwXtS6EjkSuUHlo33Mnt
         SIvWA1ipR3UDVxPKqmqmqeycr5o+TUC3MaYw4DjVIR165l/SoE+D9abKxWwWS9nCZ5oq
         Suk5ZGxHJgdPHO9OEuOCxvBKDVCgIOS5tE7n04OYeWQ5pf7w2FyjV700DCIjb5R97G5w
         G1Hg==
X-Gm-Message-State: AOAM532HgL6HA3N1kqf1aRjrhs/FE7r98ap/3kE7Qu5dHXTm7x4Tmo4y
        gEq9Y5lJPCIi7s8UJr6hxwJO6eDxA9Cem5xH4zetMttNTNq6YkqTbFnebk0DMpQ+BK0grWFFW7Z
        srKq8jAxzUOmCqeoecY8FilhUdnGrBeL980oadlGCyGHeQ76wo9lz5oa1DA6kltlk3yL4hg==
X-Received: by 2002:a05:6402:ca2:: with SMTP id cn2mr3961039edb.137.1609939590379;
        Wed, 06 Jan 2021 05:26:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfnXVZVfUEsnjkq22EATDnmevLfCQWs/gLT984NHopzli2B7UWSauNq7OZGrMSPuOBCVKwew==
X-Received: by 2002:a05:6402:ca2:: with SMTP id cn2mr3961018edb.137.1609939590075;
        Wed, 06 Jan 2021 05:26:30 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id bm12sm1225893ejb.117.2021.01.06.05.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:26:29 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 0/5] Clean up SELinux global variables
Date:   Wed,  6 Jan 2021 14:26:17 +0100
Message-Id: <20210106132622.1122033-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Minor cleanups related to SELinux global variables, plus one fix for a
potential TCP SYN flood performance regression on SMP systems.

Ondrej Mosnacek (5):
  selinux: remove unused global variables
  selinux: drop the unnecessary aurule_callback variable
  selinux: make selinuxfs_mount static
  selinux: mark some global variables __ro_after_init
  selinux: mark selinux_xfrm_refcount as __read_mostly

 security/selinux/avc.c              | 10 +++++-----
 security/selinux/ibpkey.c           |  1 -
 security/selinux/include/security.h |  1 -
 security/selinux/netif.c            |  1 -
 security/selinux/netlink.c          |  2 +-
 security/selinux/netnode.c          |  1 -
 security/selinux/netport.c          |  1 -
 security/selinux/selinuxfs.c        |  4 ++--
 security/selinux/ss/avtab.c         |  4 ++--
 security/selinux/ss/ebitmap.c       |  2 +-
 security/selinux/ss/hashtab.c       |  2 +-
 security/selinux/ss/services.c      | 10 +++-------
 security/selinux/xfrm.c             |  2 +-
 13 files changed, 16 insertions(+), 25 deletions(-)

-- 
2.29.2

