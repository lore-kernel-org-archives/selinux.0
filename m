Return-Path: <SRS0=23Lp=ND=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4348C004D3
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 00:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2539205F4
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 00:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="IzKns45C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2539205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeJWJP7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:15:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41094 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeJWJP7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Oct 2018 05:15:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id u21-v6so38703598lja.8
        for <selinux@vger.kernel.org>; Mon, 22 Oct 2018 17:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9NN3fLcUlHVOjzUj6hDJ85TEsXQY8rTP555AlaSzOCU=;
        b=IzKns45Cg33sKrW+tkZ14wcvZitmdZT987Oe1txd4vPZLguYvdTdbzzuV7gO4J5CTl
         u7Ek8aE3lRsX2efu7zgQJRFWtGEmtfjmpgbbOd4D4aHA9LtkG9v230RqgOcSSxqCpn9o
         iqMkhQLfL/QHOkVY1Ch89jgOniGYX94pY0dfD4a30Nt7nYnFkNi3dqSPcktaE2hh7ntB
         b7B5yuiHVA3RcszEhfTMPZU8rdiPV0JfehJn4JK+eIs7iM97/FYPQ4/sxiR2rIy4kCNT
         oKH8pgdtL+2JRTFI06lIDNksRoXydNcnyZDqM7autX+qCGIAk3ThEuRl7ZiU1RMB/opu
         mVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9NN3fLcUlHVOjzUj6hDJ85TEsXQY8rTP555AlaSzOCU=;
        b=aDrzncLshleqREA22IXybhH2cW6ZBtqPoi5YAH7l3H9bFkTam8AkTS5bUVvA5nuMb1
         9jRvLJya7yUui7W4q6iY65rj0zXBVTigMYhZ2rhYXnuORIZhV4OJasIlvoYUjtXroZ3b
         oUhzeU8cEnmM7FrdWyRQyOiyyhCwvb8E1WcL9m8VOTm2mnp1DlHt/R9C/nxGgPHMm8IC
         bW1rbRa0xvKeD0b//ZPMwwtyy+mQJKrFOK/KP11Wh2VJXiqbRyR0O0r31qWfM3sQdJt5
         YfMe8GmvWJZeUX19q5AXTdI/TXS1OW24vqNuSHCFdNCNu6FD6WTYkEeI9wyGXGHsttXD
         5tVw==
X-Gm-Message-State: AGRZ1gI1tLWXpz5FUj6oFO6/kUKOF1fXefFB8WjgPujzkjffut4xMcUL
        JLo26R8Em2cd9YBmt/8gjRKcgWZPn/fmQ5MLjj1m
X-Google-Smtp-Source: ACcGV61i4DpQPdSkI+/OCrhgGAbBDLKD+B1TRsABb5fQ9jDuGQmIe1yrGoj4BRwonFkeHHVPqnPCpcgts7sShDkDtsA=
X-Received: by 2002:a2e:3810:: with SMTP id f16-v6mr10902275lja.77.1540256101579;
 Mon, 22 Oct 2018 17:55:01 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Oct 2018 20:54:50 -0400
Message-ID: <CAHC9VhRHCOZL5WTwiyPQxknO2SAHCeDLuSJmkKWmYLYb4WFXng@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Welcome back.

Three SELinux patches for v4.20, all fall under the bug-fix or
behave-better category, which is good.  All three have pretty good
descriptions too, which is even better.  Please merge this for v4.20.

Thanks,
-Paul

--
The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

 Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20181022

for you to fetch changes up to 4458bba09788e70e8fb39ad003f087cd9dfbd6ac:

 selinux: Add __GFP_NOWARN to allocation at str_read()
   (2018-09-13 15:36:25 -0400)

----------------------------------------------------------------
selinux/stable-4.20 PR 20181022

----------------------------------------------------------------
Jann Horn (1):
     selinux: refactor mls_context_to_sid() and make it stricter

Stephen Smalley (1):
     selinux: fix mounting of cgroup2 under older policies

Tetsuo Handa (1):
     selinux: Add __GFP_NOWARN to allocation at str_read()

security/selinux/hooks.c       |   5 ++
security/selinux/ss/mls.c      | 178 ++++++++++++++++++-----------------------
security/selinux/ss/mls.h      |   2 +-
security/selinux/ss/policydb.c |   2 +-
security/selinux/ss/services.c |  12 +--
5 files changed, 88 insertions(+), 111 deletions(-)

-- 
paul moore
www.paul-moore.com
