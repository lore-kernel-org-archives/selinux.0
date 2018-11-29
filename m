Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0FBC43441
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84982081C
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84982081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeK3ACA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:02:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50329 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeK3ACA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 19:02:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id 125so2169484wmh.0
        for <selinux@vger.kernel.org>; Thu, 29 Nov 2018 04:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vufpO84kPDVI5zKru0pPXxCGlhYIFEA2TXK+mclMnLY=;
        b=L4GOLC/Pyl4dm987IxL3jzO5+mlkRr57kCHgDLq57shiDlx/yrO3R9bVzYJx3yqBCq
         UOYQe7aA8y8cCe3LLtyVHuhV7dwJLm/ZopzQ1U48LZkut+7Os6b7OK+uswftyqWOa72j
         48y6SwXOEoaYKHSXZCNLUp8xqxAEbIjaZpSlFxlq654jAyw+jcqsYcIThBDAVJHwBLUy
         H2ZeWu59dMnn6EfP3L3luIbV+ZnD4uKMuDsh0zbZab1Pjdj+fxqt2DHN7U3fbsQx7X9h
         uXf+0+3J8rP0mLGq/RoGHHQcZQOsAFU+78jSWFQZudR4/5zwyYzunhiJuaRArbknNPGb
         oLbw==
X-Gm-Message-State: AA+aEWaheeXFPMldTjY7ju12Wu044Wl99oXfT7rU5FRvn8Ur5XonJjOh
        k4cOEULlR+7QzIt7RXG62QnopfpZJIw=
X-Google-Smtp-Source: AFSGD/XOtsQHTu86fJUI8pwy3vG2vQuG79PeBfmTy41JVEKRR31KyqLR9DEhtOZb0ADJIuaMQP9zdA==
X-Received: by 2002:a1c:8cd0:: with SMTP id o199mr1567590wmd.56.1543496201957;
        Thu, 29 Nov 2018 04:56:41 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 125sm2344952wml.35.2018.11.29.04.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 04:56:41 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH v3 0/9] Fix ENOMEM errors during policy reload
Date:   Thu, 29 Nov 2018 13:53:53 +0100
Message-Id: <20181129125402.5900-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Previous versions of this patchset:
https://lore.kernel.org/selinux/20181127103605.32765-1-omosnace@redhat.com/T/
https://lore.kernel.org/selinux/20181113135255.26045-1-omosnace@redhat.com/T/

The patches that have "[squash]" in the subject are posted separately for ease
of review but will be folded into the previous patch in the final posting.
Likewise, patches with "[fixup]" at the beginning odf the subject are logically
separarted fixes/tweaks for the last non-fixup commit preceding them.

Changes in v3:
(new changes are only in the "[fixup]" patches)
- fixed handling of SECSID_NULL (it is now remapped to unlabeled as before)
    * verified using selinux-testsuite
- cosmetic tweak: add sidtab_lookup_initial() helper to make
  sidtab_search_core() a bit more readable
- fixed converting of unmapped contexts
    * verified using the reproducer from Stephen Smalley
- cosmetic tweak: drop the 'out' goto label in convert_context()
- fixed SIDTAB_LEAF_ENTRIES to use SIDTAB_NODE_ALLOC_SIZE instead of using
  PAGE_SIZE directly

Changes in v2:
- dropped the first patch since it is already merged in -next
- fixed initial SID table to not reserve an entry for SECSID_NULL
- added back an equivalent of the reverse lookup cache
- fixed checkpatch.pl errors and some warnings

Testing:
An x86_64 Fedora 29 kernel with this patchset applied passes selinux-testsuite
and the reproducer from GH issue #38 [1]. I also made sure that the two bugs
discovered in previous version are now fixed.

[1] https://github.com/SELinuxProject/selinux-kernel/issues/38

Ondrej Mosnacek (9):
  selinux: use separate table for initial SID lookup
  [squash] do not store entry for SECSID_NULL
  [fixup] fix handling of SECSID_NULL
  [fixup] cosmetic tweak for sidtab_search_core()
  selinux: overhaul sidtab to fix bug and improve performance
  [fixup] fix handling of invalid context in convert_context
  [fixup] remove the now unneeded 'out' label
  [fixup] fix SIDTAB_LEAF_ENTRIES to use the correct size macro
  [squash] add back reverse lookup cache to sidtab

 security/selinux/ss/mls.c      |  23 +-
 security/selinux/ss/mls.h      |   3 +-
 security/selinux/ss/policydb.c |  10 +-
 security/selinux/ss/services.c | 200 +++++------
 security/selinux/ss/services.h |   2 +-
 security/selinux/ss/sidtab.c   | 616 +++++++++++++++++++++------------
 security/selinux/ss/sidtab.h   |  95 +++--
 7 files changed, 574 insertions(+), 375 deletions(-)

-- 
2.19.2

