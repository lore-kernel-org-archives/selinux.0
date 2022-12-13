Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F05BC4332F
	for <selinux@archiver.kernel.org>; Tue, 13 Dec 2022 03:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiLMDGG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Dec 2022 22:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiLMDFz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Dec 2022 22:05:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9781DDF3
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 19:05:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id l10so579815plb.8
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 19:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+11UAkspQI3Jl+0ZwasHXEveHAO0fduT9eEWrtO/NFw=;
        b=vAmV6Ve9T1g68nyf2BTmmpfK3ZAGVjLDM0mB03JCVfPJ+0zm5oDlT2x1lMWBmWvEun
         JWccJWMmHWfCBtbI4jaNV6v5hZDiD/Nru7tBCwZYniVVgfjvbfIgqz6NiaXNRUWCEscJ
         tIoB+qjES458S02apGDAi4zOFeC+lmlicxeU/8GekT6FthKNDxvGD7yxGvrd0xRrkMbA
         iMUjUYosY6NT0XivSapHmBKx8zDGq7a8gw5Q2MlX7LBEiHObn7KM6aa1Tw7/pMUqKnl2
         6zr+2AN4bupICc0bCNyd0yqN6ynMNsz2QNxvoA3K/Cs5Sya66ZPRtBP6GvBNXmoWUbfs
         6+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+11UAkspQI3Jl+0ZwasHXEveHAO0fduT9eEWrtO/NFw=;
        b=H7Vcj2WdE7zPaz72PlGgV53QT6gY5rzFlBdKUHtcfY2Y7rBs7PmjFGDKeu3T/y3lB3
         4C0A1eiRgC6vTlcZyQQvFc7eg6LHdukFfIg+jNm1gfMw+VfVhsch8g9fX5eXC4s4YQCV
         D2KYPj+pbmS3TpZsbcVRcZBIrZlifoGj/OSbBlL9D4JHwjQf5pZQ0XbiYPBZSxwlhSCF
         Xnlujdvps94odXi78pgiF/Ufp+hc4b+VVk1W1rvBIxlggiDCmErE4WCqZSB/0cLaZpvT
         iYD6ZAxFDdPhU7kRbQ7dkoWcv+FO6I21BfNl+cCPi4FX8M0Fnjw7Pv3PA2rhGgvmahNd
         gdTQ==
X-Gm-Message-State: ANoB5pl9Rjag+aFflF4CUM9IhWyubaLInn3vZYqeXSM4ePhNdkxgeGhr
        JcOwc0bBaojW+iYQpegn5Vr6l3atEfeCWmN4Kpmz
X-Google-Smtp-Source: AA0mqf4dO55J3qEuFKf35PPU8uD2z8ih9tAlQEyhv0JLUdm0PiTX77Y0W9NqQv+W5PCq12uE/0W2kosgxqOLYeCqGaU=
X-Received: by 2002:a17:90a:fa8c:b0:221:5597:5de7 with SMTP id
 cu12-20020a17090afa8c00b0022155975de7mr136592pjb.147.1670900743486; Mon, 12
 Dec 2022 19:05:43 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Dec 2022 22:05:32 -0500
Message-ID: <CAHC9VhSmJHDRroUJifUuDNF+KvVPVtW17CuMzb_RrUKBBkTabA@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Two SELinux patches for Linux v6.2: one increases the sleep time on
deprecated functionality, and one removes the indirect calls in the
sidtab context conversion code.  Unfortunately, this pull request does
conflict with fixes that were merged during the v6.1-rcX cycle so you
will either need to do some manual fixup or you can pull the tag below
which has the necessary fixes and has been sanity tested today.  If
you're looking for something different to handle this merge, let me
know.

* tags/selinux-pr-20221212.merge

-Paul

--
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

 Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20221212

for you to fetch changes up to 048be156491ff1aeb0fe5ff0862644d38cd39015:

 selinux: remove the sidtab context conversion indirect calls
   (2022-11-09 11:00:49 -0500)

----------------------------------------------------------------
selinux/stable-6.2 PR 20221212

----------------------------------------------------------------
Paul Moore (2):
     selinux: increase the deprecation sleep for checkreqprot and runtime
              disable
     selinux: remove the sidtab context conversion indirect calls

security/selinux/selinuxfs.c   |  4 ++--
security/selinux/ss/services.c | 51 ++++++++++++++----------------------
security/selinux/ss/services.h | 14 +++++++++---
security/selinux/ss/sidtab.c   | 21 +++++++++--------
security/selinux/ss/sidtab.h   |  3 +--
5 files changed, 47 insertions(+), 46 deletions(-)

-- 
paul-moore.com
