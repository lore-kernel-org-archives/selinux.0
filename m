Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C579EC433FE
	for <selinux@archiver.kernel.org>; Tue,  4 Oct 2022 01:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJDBDq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Oct 2022 21:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJDBDp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Oct 2022 21:03:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AEF39BA1;
        Mon,  3 Oct 2022 18:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B958D61237;
        Tue,  4 Oct 2022 01:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26186C433D6;
        Tue,  4 Oct 2022 01:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664845423;
        bh=ih1Ua6plqATyfmALYk/lBmAsXu3cjXf7P5URbdDs4o4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cmYcUPDHY8jZRQ3s8gmnRG9AddxEdLpDc4aNjdsei7OSaNIhDFzWhVXxUSG1kdjm1
         I6Ah79UlCLBo5Mm5s+90oXJgLTpBIBuzl4S0UIamjWRvKk328RWav9g3imvUC5Qh6f
         HtYOXMP2QFlWCYDzkNafuqPfaDSskZBbaF+MIBeIwVlDvq4bMq2ycNpHppAAF4mekq
         WkkocMctpD3FcIuYSyxaSg5R5eO+7mtCh3zdOHAxXMmrlsevH09BTYIBA4pa0WFfq/
         TgirqiLlzn7UVcEAPkzcQTlqBtN8K6CQYH2uVbBRc/rRzP7zxxslcIpVKsySIrI74r
         4BKF7wLkG96gA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D267E49FA3;
        Tue,  4 Oct 2022 01:03:43 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQF6oLGHN=fHSN568iM-mP7yDpMWH=OKwSRADu4Rb5-Dw@mail.gmail.com>
References: <CAHC9VhQF6oLGHN=fHSN568iM-mP7yDpMWH=OKwSRADu4Rb5-Dw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQF6oLGHN=fHSN568iM-mP7yDpMWH=OKwSRADu4Rb5-Dw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20221003
X-PR-Tracked-Commit-Id: 2fe2fb4ce60be9005d7bfdd5665be03b8efb5b13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e816da29bc0cf0504afddd314a2d71b694b5d7af
Message-Id: <166484542304.7481.17443359591527469807.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 01:03:43 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Mon, 3 Oct 2022 16:44:56 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20221003

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e816da29bc0cf0504afddd314a2d71b694b5d7af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
