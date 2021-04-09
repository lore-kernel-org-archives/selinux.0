Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE831C43462
	for <selinux@archiver.kernel.org>; Fri,  9 Apr 2021 19:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA87160234
	for <selinux@archiver.kernel.org>; Fri,  9 Apr 2021 19:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhDIT7p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Apr 2021 15:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234006AbhDIT7o (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 9 Apr 2021 15:59:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AAC0E610F9;
        Fri,  9 Apr 2021 19:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617998370;
        bh=gfXKKduWvd16y/NVGts30IJAqi1mgL3khm3hFyE8yfY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PLGUuLtjTFd/4Ra6ycb3oimTH+KRQF344E2XkeSUoqNGfaK5UazbBYzqjKxcvLZHO
         CxchqZdly07tEd/5VD3diFKXZzL8CL7YJTn/rw+kxNtXkH5GdgKHIWKK5fl7IFReYa
         bm4euSf+sVErEvv5lhM3gFj7nuwiUQnpYS4CPiUIeLw14DTqysPlqJaGMDsvFoAvRw
         7gBvKU48WkgsC+bwCuLDwQdbICqZ2p1H082nsp1gB3Er56f2tMqP6g27S0P418FI/a
         1gjwJFTu+cue73sh9rWpvbUQY9ETVMXYrsQPnOmzXnl3DB5Zl9fpMDvv4fCy+UGuj/
         OAS7mNyeWEp+Q==
Subject: Re: [GIT PULL] SELinux fixes for v5.12 (#2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhS20dq3FNQjpYX+BkHw=PSc-CrzUaZj_Cg9RBcZ3Ck9xg@mail.gmail.com>
References: <CAHC9VhS20dq3FNQjpYX+BkHw=PSc-CrzUaZj_Cg9RBcZ3Ck9xg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhS20dq3FNQjpYX+BkHw=PSc-CrzUaZj_Cg9RBcZ3Ck9xg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20210409
X-PR-Tracked-Commit-Id: 9ad6e9cb39c66366bf7b9aece114aca277981a1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60144b23c94216b4aca6fba90dca9349183f39e1
Message-Id: <161799837067.7895.9178581619464856698.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Apr 2021 19:59:30 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Fri, 9 Apr 2021 13:44:38 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20210409

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60144b23c94216b4aca6fba90dca9349183f39e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
