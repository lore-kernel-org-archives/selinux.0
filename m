Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02363C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D689D20786
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbiUHZiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHYPU5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:20:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22426 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgHYPUx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 11:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598368851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PRLiRxkWVw8uTvuarrIDiLBzVWFZWORQt/5QoxhrJxA=;
        b=fbiUHZiFdNxw4KTmOopsc2tFKa/dKO8d/3rCTwFPES61eXmmPJwCKlrDXPuuxjC0u4AHEZ
        396pZxPZB5nwfjprGhOWBp3qPeNj5ZN/wUyOJMcI9RbC3gnFjr1R173HxVnT++6jcuWZ/b
        Kin5NrMuPdnJc1Sny1ZXS8hEIKBdor0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-s27P0sdZMc2cWGmQWDYGdw-1; Tue, 25 Aug 2020 11:20:49 -0400
X-MC-Unique: s27P0sdZMc2cWGmQWDYGdw-1
Received: by mail-wm1-f72.google.com with SMTP id x81so862360wmg.8
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 08:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRLiRxkWVw8uTvuarrIDiLBzVWFZWORQt/5QoxhrJxA=;
        b=VL1Rgh7EZSgUPN25lheBIMusF9jdQAgsL2rXhXVwQfUfpvU4vZWSPq3OBNcCucqIir
         ApxgQs6ImOiGYMsYXt4kZ5luQCTVs7RBufu5Rm+0iO5p+EejJHZ15WyHZC+sO0nBVjO1
         8SdtY5nQpz0DK9WQIz43xwnxWTwBuRgdSp2tmF1PqNkDzO1TGwiS5vhhlpMq3kFiOXcN
         ahmdP/KJjal4+orJr8ERXZja+qM99+R96y32VynyqkL4hKRViiUYaKnHSVVvDnlucpzG
         0OjNl2W9nYJZF5Hd1FS39ikYoGa6hQNqAKaHL2RyuIpRCpVB7Ddxl+ReO/tB9awEQMaE
         SRYA==
X-Gm-Message-State: AOAM533gCfsRAEb3gfUsvhPoXYJfBPZ/+bnUypySwI+pMy8RzA9q/H2E
        VAuXIphaaYwxDK2kdT5LF7GTOPgPTfyUs5s+HlxIhLF1YTQgq9HLwpzN4GgIa368CuDuBRtV+K7
        WoDCy/wki0nBk7YEtKA==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr2470273wmj.41.1598368848239;
        Tue, 25 Aug 2020 08:20:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6u1BK1xJdgzgmskFYwZx+KYbOhF8q7VKxPrVClSKeJ0A3wK1x3Uij62v5xqRYBXItNyeDiA==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr2470255wmj.41.1598368847976;
        Tue, 25 Aug 2020 08:20:47 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id t4sm28372514wre.30.2020.08.25.08.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:20:47 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [RFC PATCH 0/3] selinux: RCU conversion follow-ups
Date:   Tue, 25 Aug 2020 17:20:42 +0200
Message-Id: <20200825152045.1719298-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series contains some follow-up patches for the policy rwlock to RCU
conversion that has been merged recently. The first two are quite
straightforward, but I marked this series as RFC mainly because of the
last patch, which may need some more careful review/testing.

Note that the last patch also opens up the possiblity to implement
security_read_policy_kernel() from the IMA measurement patch [1] in a
simple way without race conditions.

I only did quick basic testing of these patches, so there may be some
bugs. I hope to do more thorough testing tomorrow. I'd just like to give
people chance to give some early feedback, especially on the last patch.

[1] https://lore.kernel.org/selinux/CAHC9VhQP7_rV+Oi6weLjVhrx2d8iu9UJ8zeE=ZcqnBMqngrJ4Q@mail.gmail.com/T/#mcb727e45670c8ee1f2da2ea0927e97f25e2395ad

Ondrej Mosnacek (3):
  selinux: simplify away security_policydb_len()
  selinux: remove the 'initialized' flag from selinux_state
  selinux: track policy lifetime with refcount

 security/selinux/include/security.h |  11 +-
 security/selinux/selinuxfs.c        |  12 +-
 security/selinux/ss/services.c      | 327 +++++++++++++---------------
 security/selinux/ss/services.h      |   6 +
 4 files changed, 165 insertions(+), 191 deletions(-)

-- 
2.26.2

