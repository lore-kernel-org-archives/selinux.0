Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96FFC433B4
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 17:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 772B561164
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 17:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbhDURPd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242973AbhDURPb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Apr 2021 13:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619025298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Ds+L1bCP6+6WbzB+/50dXw+9s8exJ7s0FvADavIhEQ=;
        b=NQQU92PIgrh3iDkjXdCSdKwSSD6tLZdQ/JYphwolvKLp3QCOVfYBtzJ8dgEXj1POA4HylJ
        8Sd9xZd9ytZfqKP9MEeKbRnwQ9rDmJ3QFPUbU5VtqOFutJP2bDaLueAl8v85yXoPOLDGs0
        5LHnrcV2pHE4CzV0v5cZXfZA9mCK3rI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-iYVenShQNaqU4QVtw6jnRg-1; Wed, 21 Apr 2021 13:14:51 -0400
X-MC-Unique: iYVenShQNaqU4QVtw6jnRg-1
Received: by mail-ej1-f71.google.com with SMTP id bx15-20020a170906a1cfb029037415131f28so6192976ejb.18
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 10:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Ds+L1bCP6+6WbzB+/50dXw+9s8exJ7s0FvADavIhEQ=;
        b=asMofwfqhqecROoShpQ4yOhwhNufSY0Y1mXMA84uMC8osvpuRG5Pptn5oPOyWZzxJ1
         enSVVTwMs0kJsBMpv1PMk3HjtHF6yUg1kviY4isGruxibIpQW2iZab4QRkfsL0EYfc62
         7T7YRurCbQFszEXme+idda79vE71QEiX3cCw2TmmZQqCYlXTeY0iNJDWgyKcpweIHRar
         l3sz2nCaJxunNwZ1ngghg8diV00XtqMwUL5GlKylwLKClP/j1cnOd6GdlsfUqItYC5OV
         7tALFULiUuXLcuM3Z/2+aby7s8Pft1O15PEbHF626GgjNZYlbV4t9L5xKN9kJiIG3H2L
         njwA==
X-Gm-Message-State: AOAM532xuur1ab3mR6Agk1nyVH9lsD2KX7dU+z44z0nXUlcIhK3U/q8h
        HOLaSaOgD7FRbI9aI/JIQXz94GlltA6liq69zQJMvtDQ0ezjZ/uy4lanq0Xw6k9HtQfqLdRC5lB
        URGyHvRTGta5KfPpRZsgYUIcYy3r//zeRs7VetO9rg1DTv+HEWlkBN3Ue4aeRP6EypC9uag==
X-Received: by 2002:a05:6402:290:: with SMTP id l16mr29082613edv.337.1619025289600;
        Wed, 21 Apr 2021 10:14:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmoKETRUuKqjG2OlKoFygbPK3HDWwNtdSKU+JS0tzwEYE4lpqCN0fHqQM+w+zccUEMLCoX8w==
X-Received: by 2002:a05:6402:290:: with SMTP id l16mr29082582edv.337.1619025289299;
        Wed, 21 Apr 2021 10:14:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id i1sm22905edt.33.2021.04.21.10.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:14:48 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lokesh Gidra <lokeshgidra@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 0/2] selinux,anon_inodes: Use a separate SELinux class for each type of anon inode
Date:   Wed, 21 Apr 2021 19:14:44 +0200
Message-Id: <20210421171446.785507-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series aims to correct a design flaw in the original anon_inode
SELinux support that would make it hard to write policies for anonymous
inodes once more types of them are supported (currently only userfaultfd
inodes are). A more detailed rationale is provided in the second patch.

The first patch extends the anon_inode_getfd_secure() function to accept
an additional numeric identifier that represents the type of the
anonymous inode being created, which is passed to the LSMs via
security_inode_init_security_anon().

The second patch then introduces a new SELinux policy capability that
allow policies to opt-in to have a separate class used for each type of
anon inode. That means that the "old way" will still 

I wish I had realized the practical consequences earlier, while the
patches were still under review, but it only started to sink in after
the authors themselves later raised the issue in an off-list
conversation. Even then, I still hoped it wouldn't be that bad, but the
more I thought about how to apply this in an actual policy, the more I
realized how much pain it would be to work with the current design, so
I decided to propose these changes.

I hope this will be an acceptable solution.

A selinux-testsuite patch that adapts the userfaultfd test to work also
with the new policy capability enabled will follow.

Ondrej Mosnacek (2):
  LSM,anon_inodes: explicitly distinguish anon inode types
  selinux: add capability to map anon inode types to separate classes

 fs/anon_inodes.c                           | 42 +++++++++++++---------
 fs/userfaultfd.c                           |  6 ++--
 include/linux/anon_inodes.h                |  4 ++-
 include/linux/lsm_hook_defs.h              |  3 +-
 include/linux/security.h                   | 19 ++++++++++
 security/security.c                        |  3 +-
 security/selinux/hooks.c                   | 28 ++++++++++++++-
 security/selinux/include/classmap.h        |  2 ++
 security/selinux/include/policycap.h       |  1 +
 security/selinux/include/policycap_names.h |  3 +-
 security/selinux/include/security.h        |  7 ++++
 11 files changed, 95 insertions(+), 23 deletions(-)

-- 
2.30.2

