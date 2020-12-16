Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5047C4361B
	for <selinux@archiver.kernel.org>; Wed, 16 Dec 2020 19:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF04230FF
	for <selinux@archiver.kernel.org>; Wed, 16 Dec 2020 19:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgLPTpf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Dec 2020 14:45:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgLPTpf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 16 Dec 2020 14:45:35 -0500
Subject: Re: [GIT PULL] SELinux patches for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608147894;
        bh=DWOiwWwHK7MnQTcZrSH1hG8BZx5h0YlfC6uySaXZq84=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AEuMzeECwANmMeUfOOuPC1okXipPnfcbbGhhT4KWjsd9dYhGfUEBMuouo41mF0dWI
         ahAgoRcmec/W8PFBZe2AcC+PGtjt7IQKbCiV4KT7ZFTp4jK/qjRPfsKfmiApN/oWGO
         rh4AMXHATsi5wC0iidT2Ad1FzADH2+0ZRr6BBCmAYhdBrAuoXM24+lyEu3qnxCLNAH
         7O8FFrBPDaAB+piKKxxPepyyXk5NV5eYX4Z5s7giSNJpsGWwidGOQWCjuUf8MhOODT
         OOjPxIVF6MPUW2C7R2aLeg2SSufIPFdyObE+/5VFlSuSfhlPEWHMA7djW+CUg60P0p
         7Mn6NII1TdUxA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhT85MwDwrB_pAvU+g12SnGZ1g9Tvqr4nJqBpZfEw1GAdg@mail.gmail.com>
References: <CAHC9VhT85MwDwrB_pAvU+g12SnGZ1g9Tvqr4nJqBpZfEw1GAdg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhT85MwDwrB_pAvU+g12SnGZ1g9Tvqr4nJqBpZfEw1GAdg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20201214
X-PR-Tracked-Commit-Id: 3df98d79215ace13d1e91ddfc5a67a0f5acbd83f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca5b877b6ccc7b989614f3f541e9a1fe2ff7f75a
Message-Id: <160814789456.14944.2617759795851844649.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 19:44:54 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 21:18:20 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20201214

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca5b877b6ccc7b989614f3f541e9a1fe2ff7f75a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
