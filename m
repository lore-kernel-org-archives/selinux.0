Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CE0C433E9
	for <selinux@archiver.kernel.org>; Mon, 22 Feb 2021 01:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D228564E61
	for <selinux@archiver.kernel.org>; Mon, 22 Feb 2021 01:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhBVBVe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Feb 2021 20:21:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhBVBVc (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sun, 21 Feb 2021 20:21:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B988064EC3;
        Mon, 22 Feb 2021 01:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613956851;
        bh=Vjjw4B30+VR2Vn71KRTgcRzHUO//Pd0/WGOk/PsYb/8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KryiVcFPcuYzkd8X9k9WoVQ6T+2WHoxWBQtAJSs23sLn3nhCOUKfyShDIbqvRFjLA
         Va1hZwbPxmjqZ+tZrkigiA2zAvvbywgoCEQWIfGDKhQj0/kCPuONKXgnv4dWZbKa8A
         vl1hgYzaR4fJ69kFz8yw+KfHYR1OlyiXN+EizgUp/5vqxmYoky4734EtJEGgjGY8Im
         Vj59aqWvi+eqK4/DGquNVhQdosjw5dihsndmw1C2hnI+J6LqAezpyZewNg2Nb8fgIT
         9NuawydIEChFLNFad6BMfvYL0h4dzAJGFK65y23vYdqg2RnaU7gw4u6MtWFDUiM1D0
         +Imhik8o5F2QQ==
Subject: Re: [GIT PULL] SELinux patches for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRkn65jgVW5fTRWOrDe+dXQD-_-BTN+rZ8Kcq5qxFi45Q@mail.gmail.com>
References: <CAHC9VhRkn65jgVW5fTRWOrDe+dXQD-_-BTN+rZ8Kcq5qxFi45Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRkn65jgVW5fTRWOrDe+dXQD-_-BTN+rZ8Kcq5qxFi45Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20210215
X-PR-Tracked-Commit-Id: 365982aba1f264dba26f0908700d62bfa046918c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1fec2214bfbba5c759eb154b3744edb8c460384
Message-Id: <161395685171.836.3741388220994311369.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 01:20:51 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 16:57:38 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20210215

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1fec2214bfbba5c759eb154b3744edb8c460384

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
