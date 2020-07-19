Return-Path: <SRS0=eLZI=A6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489E0C433DF
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 10:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1299C2064B
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 10:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrnX9ATB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgGSKfP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Jul 2020 06:35:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38333 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgGSKfO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Jul 2020 06:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595154912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l8ntinp8I1Tac5+hZh9vl4hp30l7BUxYuiM2LRlQXfM=;
        b=SrnX9ATB3ExxCWWur46GQNwWirZQ+4/PS6gmq4hTSKeiO3o6hHSiLr0Hgh4nLset5boJUf
        ITyXEuSJE/aaEiBKZQzTTQXYPkPYqiBsRRW02PnGOOB5VnQBN94MkqTBQCEVSKdkOdzAvT
        XP4HL9YDAg6+qkPgg7cs6q5bZ1etCqs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-oyOIA3rFNgCV29EK7bkcVA-1; Sun, 19 Jul 2020 06:35:10 -0400
X-MC-Unique: oyOIA3rFNgCV29EK7bkcVA-1
Received: by mail-wm1-f72.google.com with SMTP id e15so12931960wme.8
        for <selinux@vger.kernel.org>; Sun, 19 Jul 2020 03:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l8ntinp8I1Tac5+hZh9vl4hp30l7BUxYuiM2LRlQXfM=;
        b=O5xmguyCYn4sog62JCgL1Bb1PEYM8N1ynO8VzR33iECRHJh/966aksdAFSSQRkQd5D
         luD71/ClSc8Q8j5lbGVIVkCL9UjBKGRh1KEeYPgqSaCzc4TbjjuTVKLtzHUciXKPMsXX
         kNh/n2FFedb0Jq16PJ23t52SnZZ0BfFmAEdHWhB9qrrN1uD8wtrhjWFfgBOdmTCIPPgP
         KkJJkgFxYi22eXHwEwUSNRyq3LjV9nabVx1AjjX7STxt0rI9RgMmWkxjciDmxXQ+zGVH
         M3uPM77gYgf5h9ckt6GT7JNVza4vsMENGWxbjSksWg1e/LXzHPVmwWwsgdOepJ5CXwwJ
         dkQg==
X-Gm-Message-State: AOAM531lcHuslJ7/ba6jE1vV5+40PiFvk4bEFc/Q8GgSUTu8uy6UJdZx
        K9Wr355xINjTPPQVcN8Oeqj+uHuD5I/5bupFrYuX1d1AvOy9GY0q4nmGU8jY6cTPAgCeZXhj5Id
        z9vmrzZfZKYJ5h+Rj4w==
X-Received: by 2002:a5d:6a07:: with SMTP id m7mr18135297wru.324.1595154909511;
        Sun, 19 Jul 2020 03:35:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6RqGFXIfiasX7IQjOYNtZI8LjGmFLV+sxQeI7WXUOcwbAfmt/ScBt6CGecuquphY4bC7SWQ==
X-Received: by 2002:a5d:6a07:: with SMTP id m7mr18135281wru.324.1595154909230;
        Sun, 19 Jul 2020 03:35:09 -0700 (PDT)
Received: from omos.redhat.com (adsl-dyn227.91-127-10.t-com.sk. [91.127.10.227])
        by smtp.gmail.com with ESMTPSA id n16sm28468498wra.19.2020.07.19.03.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 03:35:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v5 0/2] userspace: Implement new format of filename trans rules
Date:   Sun, 19 Jul 2020 12:35:04 +0200
Message-Id: <20200719103506.865962-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These patches are the userspace side of the following kernel commits:
c3a276111ea2 ("selinux: optimize storage of filename transitions") [1]
430059024389 ("selinux: implement new format of filename transitions") [2].

The first patch changes libsepol's internal representation of filename
transition rules in a way similar to the kernel commit.

The second patch then builds upon that and implements reading and
writing of the new binary policy format that uses this representation
also in the data layout.

See individual patches for more details.

NOTE: This series unfortunately breaks the build of setools. Moreover,
when an existing build of setools dynamically links against the new
libsepol, it segfaults. Sadly, there doesn't seem to be a nice way of
handling this, since setools relies on non-public libsepol policydb
API/ABI. I have prepared a preliminary patch to adapt setools to these
changes - I'll open a WIP pull request for it soon...

See also this discussion about the setools impact:
https://lore.kernel.org/selinux/daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov/

Changes in v5:
 - fix comment in filename_trans_read() to not change when being moved
 - fix filename_trans_check_datum()
   - destroy temporary ebitmaps at return
   - actually iterate through datums

Changes in v4:
 - rebased on top of latest master branch

Changes in v3:
 - fixed the change in dispol.c to match the rest of the code
 - renamed the helper functions to use the "_compat" suffix rather than
   "_old" and "_new"

Changes in v2:
 - fixed counting rules when reading the new policy format

[1] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4300590243895ac39e8c97a2f5acd004dad8a42f

Ondrej Mosnacek (2):
  libsepol,checkpolicy: optimize storage of filename transitions
  libsepol: implement POLICYDB_VERSION_COMP_FTRANS

 checkpolicy/policy_define.c                |  52 ++--
 checkpolicy/test/dispol.c                  |  20 +-
 libsepol/cil/src/cil_binary.c              |  29 +-
 libsepol/include/sepol/policydb/policydb.h |  18 +-
 libsepol/src/expand.c                      |  60 +---
 libsepol/src/kernel_to_cil.c               |  24 +-
 libsepol/src/kernel_to_conf.c              |  24 +-
 libsepol/src/policydb.c                    | 306 +++++++++++++++++----
 libsepol/src/write.c                       | 101 +++++--
 9 files changed, 435 insertions(+), 199 deletions(-)

-- 
2.26.2

