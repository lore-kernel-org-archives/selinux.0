Return-Path: <SRS0=Kbw6=XM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26150C4CECD
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 19:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C929420665
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 19:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cs2Ud6vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfIQTiS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:38:18 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:45301 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfIQTiS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Sep 2019 15:38:18 -0400
Received: by mail-lf1-f44.google.com with SMTP id r134so3776658lff.12
        for <selinux@vger.kernel.org>; Tue, 17 Sep 2019 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DPMCqyPE0QzC55vTbDjf3OpUmm9PZ45gf2c/NXtRms4=;
        b=cs2Ud6vhFRVLTHwS+TJWy/K0npQyVF7UGgwFXhyL38hI/XrrcUkCxchVudDRV+Y87Q
         SwtTBuQ56G1UsSCImNsJOZoEs+B6xqduRc2ulEFSQtg8gsFXEeGNpLX7iYfpiIYh4ps+
         wf3bOWH9ypIoXMcpUL9q/5JjQtIv3c5bJwBTTwff9Bnq5bsjgC0KptAs/J4DgPb785Jt
         hucVAkYaQq/z4g+HeY7tUFV6kbJ5eMApqA3AVMa8QJIJKfQtsT7Cc3k2SU0F1C0H6kG2
         p8prEPIpWW3q9H9ubTS0EVOCB6jEXBiu6siA3frXYxv01bu/4aZjEuFM/pC1W6ebt7da
         X2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DPMCqyPE0QzC55vTbDjf3OpUmm9PZ45gf2c/NXtRms4=;
        b=CQWcsYQM1tnod0tFhTonIraeekysqgd0J3NvZZVCMaiwAgi2RZRGQY5aZYNdL0FGct
         iiubd4Rj0sgfToANT5geOFBf9kQ6t7P3mD6eJSfs8ApDLKCWw5mB86k/RRO3vKTWp5DM
         1F1e3TDTCElB7uhFXL1amJ1wDqNNddxBtyB1fT4jVjVssjeCSdu3lMniljFjaFqLf0Wh
         A1Mq19SwDiY0EZmxmc3L7eqlRafx8qxW/QcxKLQGihTneqDKU1WKciyugU3Nn7b4barh
         eKDqA+2vnD/+GwvvzdzXh7YvjTebIAstJcxMZRP5FwYwxmzAKng+f8Zcm43PM5ePVLyD
         lagw==
X-Gm-Message-State: APjAAAUaFNgLz4mX6jzX9LN76jZDKFAxXC4ZLlu3tqRd0HM/ONcb/qXU
        NlwSmnjVMqcDIxjnaYbTKJ2ZCo1QEXuV8IzAYrhKLEJVGVL1
X-Google-Smtp-Source: APXvYqxDlAIJZz7PnVeZd8+3jQfl+vZQNh7Br/xAk4fcswBcE4hm4+BMHvXr9jeBipijFUcWCYKs3rAS2d82E6s93K8=
X-Received: by 2002:a19:6517:: with SMTP id z23mr2690779lfb.31.1568749096080;
 Tue, 17 Sep 2019 12:38:16 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 Sep 2019 15:38:05 -0400
Message-ID: <CAHC9VhT1n=zwWJRSqF+OLzQq2r_8Bf0TjO-1QEe3yfLHAnomfA@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Eight SELinux patches for v5.4, the highlights are listed below and
all pass the selinux-testsuite, please merge for v5.4.

- Add LSM hooks, and SELinux access control hooks, for dnotify,
fanotify, and inotify watches.  This has been discussed with both the
LSM and fs/notify folks and everybody is good with these new hooks.

- The LSM stacking changes missed a few calls to current_security() in
the SELinux code; we fix those and remove current_security() for good.

- Improve our network object labeling cache so that we always return
the object's label, even when under memory pressure.  Previously we
would return an error if we couldn't allocate a new cache entry, now
we always return the label even if we can't create a new cache entry
for it.

- Convert the sidtab atomic_t counter to a normal u32 with
READ/WRITE_ONCE() and memory barrier protection.

- A few patches to policydb.c to clean things up (remove forward
declarations, long lines, bad variable names, etc.).

Thanks,
-Paul

--
The following changes since commit 45385237f65aeee73641f1ef737d7273905a233f:

 selinux: fix memory leak in policydb_init() (2019-07-31 16:51:23 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190917

for you to fetch changes up to 15322a0d90b6fd62ae8f22e5b87f735c3fdfeff7:

 lsm: remove current_security() (2019-09-04 18:53:39 -0400)

----------------------------------------------------------------
selinux/stable-5.4 PR 20190917

----------------------------------------------------------------
Aaron Goidel (1):
     fanotify, inotify, dnotify, security: add security hook for fs
       notifications

Ondrej Mosnacek (3):
     selinux: policydb - fix some checkpatch.pl warnings
     selinux: policydb - rename type_val_to_struct_array
     selinux: avoid atomic_t usage in sidtab

Paul Moore (3):
     selinux: shuffle around policydb.c to get rid of forward declarations
     selinux: always return a secid from the network caches if we find one
     lsm: remove current_security()

Stephen Smalley (1):
     selinux: fix residual uses of current_security() for the SELinux blob

fs/notify/dnotify/dnotify.c         |  15 +-
fs/notify/fanotify/fanotify_user.c  |  19 +-
fs/notify/inotify/inotify_user.c    |  14 +-
include/linux/cred.h                |   1 -
include/linux/lsm_hooks.h           |   9 +-
include/linux/security.h            |  10 +-
security/security.c                 |   6 +
security/selinux/hooks.c            |  49 ++++-
security/selinux/include/classmap.h |   5 +-
security/selinux/include/objsec.h   |  20 +-
security/selinux/netif.c            |  31 ++-
security/selinux/netnode.c          |  30 ++-
security/selinux/netport.c          |  24 +--
security/selinux/ss/policydb.c      | 402 +++++++++++++++---------------
security/selinux/ss/policydb.h      |   2 +-
security/selinux/ss/services.c      |   6 +-
security/selinux/ss/sidtab.c        |  48 ++---
security/selinux/ss/sidtab.h        |  19 +-
18 files changed, 403 insertions(+), 307 deletions(-)

-- 
paul moore
www.paul-moore.com
