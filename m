Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F252C352A3
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 16:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A7720870
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 16:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kwc6JoyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgBKQkA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:40:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23447 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728049AbgBKQkA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 11:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581439199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l+nlWvKhcwMTWcwHAgrIzktPikHSOQVVpSoFuszpHLk=;
        b=Kwc6JoyJGXayn/kK8YdZNinZUWUt+nT4P8Gndue01pWJHEFYnD61LyM1sqbTFzBh1jeBwm
        bMzfbsK+cvwwK0mf63uvys0F+VEUOuHquri2GvvVGlR23AKmuw2SasR9u68GIYioZWKQyI
        vvdmHBPH49MSWQTujWG9I9u3EQoyqqs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-T0vul5vWNo-qwOOm3PQWtw-1; Tue, 11 Feb 2020 11:39:57 -0500
X-MC-Unique: T0vul5vWNo-qwOOm3PQWtw-1
Received: by mail-wr1-f69.google.com with SMTP id n23so7180772wra.20
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 08:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+nlWvKhcwMTWcwHAgrIzktPikHSOQVVpSoFuszpHLk=;
        b=mIlhkIaY2X0pX3+t96UzUnbgx2/6dYHBw/t6sPEPkrVj48VNDy33eyvWURzKoG3bAb
         owcwhumSuOn/rCoo0S6W+oQMmEc9EQ5qKIW1YRoT91xJld80YxrRcSAPIkRgr4Gd/rAP
         ixV04Sk9xxw78RFNsJvtuYF6r6aa1+Wqm/fhbuZYPkBVM9kctuhYxQz61ZdE+TVpR0lt
         OqnZbvLyPPZD/0RU1j30t4Muc//FKNkLNkbCc1zePfJqtxA6Gky+8yWbnY9d9CDnAbIr
         B+qtvPepWNvIB8+AxSmc+SW2TsCnXHfvNzjfYd4K4kymsUGvbloRMWYe/2zcLxi9rrm7
         SsDg==
X-Gm-Message-State: APjAAAX3zBKQla5aHXfS90RFdUYqJXnG7M1fnNvfnygYL1jd1RD1pD1p
        SxErFN9P9vZvz4y77xpQ7Dqwa48jiCagyNliEByqA51OvcdROR3Y9cXo66CQu1f7oXKYp+bwA+/
        KiffV4YtgDL5sEEOW2Q==
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr9530027wrq.104.1581439196009;
        Tue, 11 Feb 2020 08:39:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqypuxq7K+/yUsPv29KWnVxrHgjRME6S9pn2aDdhv9KGOPR0CA4UTdVLA34cF45jZWRwXrNXew==
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr9530020wrq.104.1581439195784;
        Tue, 11 Feb 2020 08:39:55 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k10sm5831076wrd.68.2020.02.11.08.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 08:39:55 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 0/2] Optimize storage of filename transitions 
Date:   Tue, 11 Feb 2020 17:39:51 +0100
Message-Id: <20200211163953.12231-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series improves the computational and memory efficiency of filename
transition rules in SELinux. The first patch is only cosmetic, see the
second patch for more details about its effects.

Ondrej Mosnacek (2):
  selinux: factor out loop body from filename_trans_read()
  selinux: optimize storage of filename transitions

 security/selinux/ss/policydb.c | 227 +++++++++++++++++++--------------
 security/selinux/ss/policydb.h |   8 +-
 security/selinux/ss/services.c |  16 ++-
 3 files changed, 148 insertions(+), 103 deletions(-)

-- 
2.24.1

