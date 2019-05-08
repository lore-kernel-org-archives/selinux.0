Return-Path: <SRS0=Lq8N=TI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6594C004C9
	for <selinux@archiver.kernel.org>; Wed,  8 May 2019 02:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989C0214AF
	for <selinux@archiver.kernel.org>; Wed,  8 May 2019 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557283213;
	bh=u2GBr45b52Owzs2YuLYw9iZjMpSuRVKRcqQ735BO2/w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LZJcofkJEdt0evf4N+W9nmrph6OoH0JXbTusvQLK+ovrkxccQksdC3UKuJOcCCw67
	 Bmxl4gSib/C7LORvNsS5cx6wRLt/HFR4B8PSGOPiq1A8ECVJWG1oaNwybATdrau0TS
	 YoOGRRvYKhxMP9v2E4neIFd+UTHM1MlujcRt9gSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfEHCkN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 May 2019 22:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfEHCkM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 7 May 2019 22:40:12 -0400
Subject: Re: [GIT PULL] SELinux patches for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557283212;
        bh=u2GBr45b52Owzs2YuLYw9iZjMpSuRVKRcqQ735BO2/w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xAPew/dfvA6gSL/Z1gXsrqKtPFFw7dlVLzVKnuvOAmIbaQxcMn4fS26WWQnrytY95
         /Hqn42rGB/cioBS/Xn/k5ASsDe3vSE4DWZb0P/ahZTRNMdhI8RIw1625bx3Pv9V3Rx
         3wBlhgQ23jTWrL3OVw44fkpsMJ4jU0VYxCFeFefU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSkOmRGvOje3HycoauPL+ZW9g9zZ3dqiPDmQTPUPnhCPg@mail.gmail.com>
References: <CAHC9VhSkOmRGvOje3HycoauPL+ZW9g9zZ3dqiPDmQTPUPnhCPg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSkOmRGvOje3HycoauPL+ZW9g9zZ3dqiPDmQTPUPnhCPg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190507
X-PR-Tracked-Commit-Id: 35a196bef449b5824033865b963ed9a43fb8c730
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f72dae20891d7bcc43e9263ab206960b6ae5209f
Message-Id: <155728321226.19924.13180646017168860982.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 02:40:12 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 13:23:03 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190507

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f72dae20891d7bcc43e9263ab206960b6ae5209f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
