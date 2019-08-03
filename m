Return-Path: <SRS0=E+gd=V7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598C6C433FF
	for <selinux@archiver.kernel.org>; Sat,  3 Aug 2019 17:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECEC2087C
	for <selinux@archiver.kernel.org>; Sat,  3 Aug 2019 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564854320;
	bh=lPh4AIBXrY77KC2xroeNW0G/7AjLMBhuNi3a1wBKcg0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FahbKjd3QTo82eqhWwuhbslvIUE7CCaHWovfOZNcYNusCE3wmhZWZo1alSRTpY/4g
	 2FIRpnCxiqdBTX1PVuct2H8U9JVA42lYq25DCpO6WAgtAT6P4spxhAWXjKgKWaUqYw
	 MBkCONp9t6mplHrfesuuWupEd0KbqzkL/gKC+h5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfHCRpL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Aug 2019 13:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbfHCRpK (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 3 Aug 2019 13:45:10 -0400
Subject: Re: [GIT PULL] SELinux fixes for v5.3 (#2)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564854310;
        bh=lPh4AIBXrY77KC2xroeNW0G/7AjLMBhuNi3a1wBKcg0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=w8M3KpXafujE4xPfZf0Yowa3+sEEbtxWCBxv012YWrzR0vW7Z7YbeiGsx1uJvZC/J
         qV5pNOdp8bLPoitRl4bI8VhUx4iGBed80LZd5lIaCtzgrPl+yrflxNXw/GLwY5FjiG
         amCskA4iZCpYV5cjVn4d8cJRgxAH1+EqMeoMa6xM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQ6X==anxZ435QAdbjiWtGiVA3LQbBbp0vhbzOhW6NvCQ@mail.gmail.com>
References: <CAHC9VhQ6X==anxZ435QAdbjiWtGiVA3LQbBbp0vhbzOhW6NvCQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQ6X==anxZ435QAdbjiWtGiVA3LQbBbp0vhbzOhW6NvCQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190801
X-PR-Tracked-Commit-Id: 45385237f65aeee73641f1ef737d7273905a233f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f1a6ef1df6f952fc9f22f34d51a6c3d3c4fbe23
Message-Id: <156485431005.24028.10256625498472409394.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Aug 2019 17:45:10 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Thu, 1 Aug 2019 19:01:52 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190801

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f1a6ef1df6f952fc9f22f34d51a6c3d3c4fbe23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
