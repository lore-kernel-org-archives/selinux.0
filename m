Return-Path: <SRS0=LIAv=RQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F2C4360F
	for <selinux@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DA2213A2
	for <selinux@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552502438;
	bh=MXCAuBQfGO22+XxbWVr1BkEytccTypBZMz5f21liqnQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bW43AWjzVD4xS/Mv7JpBRYJEllmc3liBId+SkmJO3/+sIRoZI3ZwVbzJE9gXC6KPL
	 Y8Fq8Yh9IU1XaPOze8RARaBbdjgF6ookX2WwVXEIgAKNMUzQBMiXXQ4hMVlxCJ/FPB
	 rLBa98TlHMpQ3KGEDvTnmP1xLtIWjSggt1Zpx6Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCMSkc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfCMSkQ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 13 Mar 2019 14:40:16 -0400
Subject: Re: [GIT PULL] SELinux fixes for v5.1 (#1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552502416;
        bh=MXCAuBQfGO22+XxbWVr1BkEytccTypBZMz5f21liqnQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l7n1/aaNcrJoX1LM+VcWaM4Mrrx4YdNTeB7EqS1i8eUpqnLDAxYD1AuQWkgmEIgAN
         ELczKneqtkgr/aOXVisNNcU2la7H6t0d+vgioUVOsB6JZ4UTC7wVbhSSoGvRGAAACG
         vavQHCQGNMXuneM3L6P/wEP9eUwslYYdBarbh/z8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTNWou2axPZ5SeCD0pML_r6=r1Wok1U=ggONUR14O+mQw@mail.gmail.com>
References: <CAHC9VhTNWou2axPZ5SeCD0pML_r6=r1Wok1U=ggONUR14O+mQw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTNWou2axPZ5SeCD0pML_r6=r1Wok1U=ggONUR14O+mQw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190312
X-PR-Tracked-Commit-Id: 3815a245b50124f0865415dcb606a034e97494d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa3d493f7a573b4e4e2538486e912093a0161c1b
Message-Id: <155250241595.10454.14356742047919525165.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Mar 2019 18:40:15 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Tue, 12 Mar 2019 19:12:50 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190312

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa3d493f7a573b4e4e2538486e912093a0161c1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
