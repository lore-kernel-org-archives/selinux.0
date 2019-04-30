Return-Path: <SRS0=/07/=TA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ADAC43219
	for <selinux@archiver.kernel.org>; Tue, 30 Apr 2019 18:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C3021734
	for <selinux@archiver.kernel.org>; Tue, 30 Apr 2019 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556648704;
	bh=lH6236Wdd2e1xct8m9E1lVmpcCCpId/hAfshAXY5srE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yJYICv/VKLahSSfrzt3ZsH17HPx9AFnY2m5l1k6hJR8/vu9y9WFf3ZO1jSZknSgf4
	 k8IJkIdIMUJRz6979levyvfAjUjp6r+vaLHFI3NevMjv5WRXcQePTfxaSRlAVEUpwN
	 KfB77/Xsf+n+xb2lPUXcgJ06BairI5LZNksfaJM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfD3SZE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfD3SZE (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 30 Apr 2019 14:25:04 -0400
Subject: Re: [GIT PULL] SELinux fixes for v5.1 (#3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556648703;
        bh=lH6236Wdd2e1xct8m9E1lVmpcCCpId/hAfshAXY5srE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2ChchlfVxElYvAyi4CHpXDHp83y+g9Dqo/R9JhaKY1nUZEw/T59NtH+OXHce5+R81
         G4lTIwxRSy6qMWGwC2fumbqt/7CavoTu8+o+NYpZ/zcyZlP1i+C7J1iUC5y86fl+ym
         ywk631HhYicttyS328caszXhtFVMW08Qh05fUKwg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQ6QF7LvuFjr2YdYNX-3pW80nm+VJh4jK080JsKOzOVsA@mail.gmail.com>
References: <CAHC9VhQ6QF7LvuFjr2YdYNX-3pW80nm+VJh4jK080JsKOzOVsA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQ6QF7LvuFjr2YdYNX-3pW80nm+VJh4jK080JsKOzOVsA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190429
X-PR-Tracked-Commit-Id: dfbd199a7cfe3e3cd8531e1353cdbd7175bfbc5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fea27bc7ff43a8beb6bebe6d4fe9eb889e185d4a
Message-Id: <155664870354.13312.10312761470463339803.pr-tracker-bot@kernel.org>
Date:   Tue, 30 Apr 2019 18:25:03 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Mon, 29 Apr 2019 18:55:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190429

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fea27bc7ff43a8beb6bebe6d4fe9eb889e185d4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
