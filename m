Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16777C433EF
	for <selinux@archiver.kernel.org>; Sat, 13 Nov 2021 19:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0044561207
	for <selinux@archiver.kernel.org>; Sat, 13 Nov 2021 19:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhKMTS2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Nov 2021 14:18:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236083AbhKMTSU (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 13 Nov 2021 14:18:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BBD0661207;
        Sat, 13 Nov 2021 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636830927;
        bh=vGztLKDMmt5bakawHIdWP23Y5DPaFQ58oxzRnG8INTA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rxnWgAsna1C7EOrgHz6c/ydBKLpnaevY2rGgBQ/HcnBUMcrFMbUI3aoUWRKusxksI
         iX543UcWahTj/XviTnrL9AuFaarYcvMl3RwelwW4sDBuGMSt2RzH91hKAKs55yWbJL
         OzDuoqHW+L+et/Zrd2+AV1M9iEkZhzUsE5BpUOT2y3V4zdsF2X8MDJ3nP1mHtlq0Fx
         uBQRG1jlGt3ixDkNP/TEtXlyNGDXUrLr2w40yAsAxuHtjey9gS2iF/tERExNFVBDy6
         DZaBX+PLs+t5JaYuEIVICRDovpg8AvUH7v2uZmP8+okGVyAdWhFZtN6M/8XiDSJ4xd
         oqKTi/fEwr8VA==
Subject: Re: [GIT PULL] SELinux fix / revert for v5.16 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQVodwxiEheuUM=XgwdytuCE0boQ-h4xt=SqOTHv0PffA@mail.gmail.com>
References: <CAHC9VhQVodwxiEheuUM=XgwdytuCE0boQ-h4xt=SqOTHv0PffA@mail.gmail.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQVodwxiEheuUM=XgwdytuCE0boQ-h4xt=SqOTHv0PffA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20211112
X-PR-Tracked-Commit-Id: 32a370abf12f82c8383e430c21365f5355d8b288
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a90729278ae7b31084d2d436b0eee4d83b11506
Message-Id: <163683092771.10343.13397904709006773847.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Nov 2021 19:15:27 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Fri, 12 Nov 2021 18:19:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20211112

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a90729278ae7b31084d2d436b0eee4d83b11506

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
