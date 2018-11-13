Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98407C43441
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 13:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A691206BA
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 13:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A691206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbeKMXvY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:51:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37440 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732959AbeKMXvY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Nov 2018 18:51:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id o15-v6so13388636wrv.4
        for <selinux@vger.kernel.org>; Tue, 13 Nov 2018 05:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qzTKoVTQzijKM3v9xW80COz5P41lxlSZ+u1CMt/SSFg=;
        b=rY6OKseKBSgnBh+Au6B2UTegKaAZ0BO2cqLgBq4ynByO9SJdL8i3CCF32UTfdKNuSp
         ymA7gzVPxcLPleMpTgvoaTf0ZaQee4IO7Sm7bD1tKJ6B683U5VSLfpT/LleBH2kpvhDl
         T6iELeJPgmp8toM+F1RFVzgVwoRi6KLNiclPG105q2aUezWgYttEUKmdn5X/dT93Y7ge
         68WXnwhIyZAIh0jQu/8QJUk+dzqeTWcuRgjGUGdiWUzApUtBi6dYWXBJkRLGucl5+WkO
         eHeMOqzakueotb7yc06gx9vG5pNid6/EtqtljsIx1/n/NE5J5Ht1dvBouVI74h5T9o96
         A6gA==
X-Gm-Message-State: AGRZ1gKGYIksuhEto098Z5oTJ2Q+HBxHXlNL8DWR1kAbjwp40vSZLv3M
        4S89trFrIIKLsM7oeMjYgOMn82MaS6Y=
X-Google-Smtp-Source: AJdET5crUHXdgBop31SDUxHRTWyY+BZBzlW5XoD1HhbUjRQmOEkeXWU0Lt/DncZTVIbVpnoJep+nkA==
X-Received: by 2002:a5d:5544:: with SMTP id g4-v6mr5066220wrw.222.1542117188129;
        Tue, 13 Nov 2018 05:53:08 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t187-v6sm10342609wmt.45.2018.11.13.05.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 05:53:07 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH 0/3] Fix ENOMEM errors during policy reload
Date:   Tue, 13 Nov 2018 14:52:52 +0100
Message-Id: <20181113135255.26045-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset is an alternative, hopefully better (but also more risky),
solution of the ENOMEM problem ([1]) that I first tried to solve in [2].

In this version I encapsulate the initial SID table within sidtab and
also switch back from converting the sidtab in-place to converting into
a new sidtab and then just switching the pointer (keeping the code ready
for switching to RCU locks).

The change is split into three patches for easier review. Some changes
done in the first two patches are effectively undone by the last patch,
so it might actually make more sense to send the final version as one
squashed patch (please let me know which is better for you).

The first patch moves the sidtab conversion logic into sidtab.c. This
allows hiding sidtab_insert() from sidtab.h in the second patch, where
it becomes an internal function.

The second patch separates the handling of initial SIDs into a separate
lookup table inside sidtab. After this change, the main table always
contains N entries with keys from 0 to (N-1). This property is then
leveraged in the last patch.

Finally, the third patch rewrites the main sidtab to a more efficient
implementation that also gracefully handles context conversions during
policy reloads, which no longer produces the ENOMEM errors.

After applying this patchset, the time it takes to insert new sidtab
entries is drastically reduced. I measured the time to populate the
table with N new entries by repeatedly writing to
/sys/fs/selinux/context. A graph of the results is available at [3].

The SID -> context lookups are now also faster. With the old
implementation, these are O(N) once N goes above 128. The new
implementation can handle them theoretically in O(log N), but in
practice the slope is almost flat, so they are practically
almost constant-time.

Review and feedback welcome.

[1] https://github.com/SELinuxProject/selinux-kernel/issues/38
[2] https://lore.kernel.org/selinux/20181031122718.18735-1-omosnace@redhat.com/
[3] https://docs.google.com/spreadsheets/d/e/2PACX-1vRUArNJR6kckm2SEs4dRZlijNVdCTmsNuWRGe7X3fC01YkBHpxXHnmcssxEiMF3Z7ivtXN2L5MC0ry-/pubhtml

Ondrej Mosnacek (3):
  selinux: refactor sidtab conversion
  selinux: use separate table for initial SID lookup
  selinux: overhaul sidtab to fix bug and improve performance

 security/selinux/ss/mls.c      |  23 +-
 security/selinux/ss/mls.h      |   3 +-
 security/selinux/ss/policydb.c |  10 +-
 security/selinux/ss/services.c | 188 +++++------
 security/selinux/ss/services.h |   2 +-
 security/selinux/ss/sidtab.c   | 550 ++++++++++++++++++++-------------
 security/selinux/ss/sidtab.h   |  90 ++++--
 7 files changed, 498 insertions(+), 368 deletions(-)

-- 
2.17.2

