Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1545C433B4
	for <selinux@archiver.kernel.org>; Fri,  9 Apr 2021 17:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB646115C
	for <selinux@archiver.kernel.org>; Fri,  9 Apr 2021 17:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhDIRpF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Apr 2021 13:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhDIRpD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Apr 2021 13:45:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED41C061761
        for <selinux@vger.kernel.org>; Fri,  9 Apr 2021 10:44:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h10so7471931edt.13
        for <selinux@vger.kernel.org>; Fri, 09 Apr 2021 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nSjCyqrsCYIpjIq/WPQfh7f6ppE3qyWXTgcaAHBDVZg=;
        b=M67BIZxSEjlJYNXW+eYXjjHCFHMsLzlnur4qfOKyVoYViCymy5iyguGUOgW0ofYGUz
         1syAlaZIMoPTBeQNvtQTBCv9kQL1GoeshqJreljATES3rFADT5/4Ir/jgyJu8c9Jd2Qn
         taWv0sH3mtSirfyXSQPpT3nhNSsHJpPgjLbimB+7n5E0IAj4xJXhNmrWTCD0LcP3jIeX
         uF1PWlZdtsYpvxW5cv7QDbEN8SDksByWD3T2zjXXgWNOdtWwQyh98O1pHHS59Qp7ZlHp
         4B8s57yeiXvcjmwQX85ASm0czIwVa1J51BMjfWHH4/tffHwxwUYQJyJa09+6sZBSzdFA
         bFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nSjCyqrsCYIpjIq/WPQfh7f6ppE3qyWXTgcaAHBDVZg=;
        b=QwMibvx/La/DTQVUAle4dVT9TvtqI2AlvZgpiukkuZW0FA/QfypuIpmTeatPhcCzlH
         EUvL+eBMZ0naWtMHhmpPGR/YU56eAD1DAW+mBYRj0pWmK0YGEqskU80CIH50O1gTykC5
         p/d8nPcveeJ45Mj4O3ZqLDiuegtiO8dlG1KIJHWheT5qZOQUhd7fNEUu+drNUDtBNxQl
         zV2l/BtomhN1IhdDVC9tOL5m7VJgPlZWBcC/Aeru0B+RI6Q2yEcUh43759bzTzNA0YwM
         hnapxaFVjeZJaKTkwHPUOHz1ATU22qO2HGDbu5eJp/yEGo25/UvVuyZVrZDKMStaVMkC
         WSUQ==
X-Gm-Message-State: AOAM5314bCIEDBseOuk86kfNqj3nzu9OWRXAasR5HnEPX/dBMdEFjBI/
        3tpQc5ZwweGiODN6ldELJej+SNKUbNQab8DoL4+p
X-Google-Smtp-Source: ABdhPJx90ZIIuFo2jn8xwq3lr2Xj/Vsuta9Az/QMVDn78N2gX3QFhsmKupUsjNpnaLqtCeEsRuNGFiJCt3olsd1KEvo=
X-Received: by 2002:a05:6402:3c7:: with SMTP id t7mr18723463edw.196.1617990288812;
 Fri, 09 Apr 2021 10:44:48 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Apr 2021 13:44:38 -0400
Message-ID: <CAHC9VhS20dq3FNQjpYX+BkHw=PSc-CrzUaZj_Cg9RBcZ3Ck9xg@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.12 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

I realize we are getting late in the v5.12-rcX release cycle, but we
have three SELinux patches which I believe should be merged before the
proper v5.12 release.  The patches fix known problems relating to
(re)loading SELinux policy or changing the policy booleans, and pass
our test suite without problem.  As of a few minutes ago, the tag
below also merged cleanly into your tree.

Please pull for the next v5.12-rcX release, thanks.
-Paul

--
The following changes since commit ee5de60a08b7d8d255722662da461ea159c15538:

 selinuxfs: unify policy load error reporting (2021-03-18 23:26:59 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20210409

for you to fetch changes up to 9ad6e9cb39c66366bf7b9aece114aca277981a1f:

 selinux: fix race between old and new sidtab (2021-04-07 20:42:56 -0400)

----------------------------------------------------------------
selinux/stable-5.12 PR 20210409

----------------------------------------------------------------
Ondrej Mosnacek (3):
     selinux: make nslot handling in avtab more robust
     selinux: fix cond_list corruption when changing booleans
     selinux: fix race between old and new sidtab

security/selinux/ss/avtab.c       | 101 ++++++++----------------
security/selinux/ss/avtab.h       |   2 +-
security/selinux/ss/conditional.c |  12 +--
security/selinux/ss/services.c    | 157 +++++++++++++++++++++++++++-------
security/selinux/ss/sidtab.c      |  21 +++++
security/selinux/ss/sidtab.h      |   4 +
6 files changed, 185 insertions(+), 112 deletions(-)

-- 
paul moore
www.paul-moore.com
