Return-Path: <SRS0=t6JQ=VY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD54C7618F
	for <selinux@archiver.kernel.org>; Sat, 27 Jul 2019 03:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B92A2077C
	for <selinux@archiver.kernel.org>; Sat, 27 Jul 2019 03:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564196718;
	bh=YFdrtcuW1PWn7HvNfLmcygXS2Ie/ZiauyA8DZLGoD84=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KyJr5XRwrIvsXKlzzVEpaqDZgurAadv9rlLdFpGQLvTjpBS1Y4Emr/fNciqcmTkBG
	 XDO8CQB/193zLcEYMyTsfFsMyCfUPcuplW4EQGuR1ypWAnvX7goPLNhxw7rrIWovqJ
	 lVy6BFdcJtAA+Tm1jAhKfVpdpn9mw6u9E0e97ux8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfG0DFR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 23:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfG0DFR (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 26 Jul 2019 23:05:17 -0400
Subject: Re: [GIT PULL] SELinux fixes for v5.3 (#1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564196716;
        bh=YFdrtcuW1PWn7HvNfLmcygXS2Ie/ZiauyA8DZLGoD84=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ocirH6gToG23yoB6Nv0/zVyj3NFESbyNIiXqRQU5Z6M5tWWeJ9mINZ747KskQGOCv
         CCsbYIuZTT0A89MfP54zTVhUkZbPAbRRF3jWLdrzAXSZUpNIK9Y+c+s6AYl0tpW0QY
         cOMIm3Csf0MsZRnBjyOHSBX9I8eHw4/wdOHl+8dg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQJ8oDqX09AdrvLJAgweaBcxETCw547CSiRyApRguXznQ@mail.gmail.com>
References: <CAHC9VhQJ8oDqX09AdrvLJAgweaBcxETCw547CSiRyApRguXznQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQJ8oDqX09AdrvLJAgweaBcxETCw547CSiRyApRguXznQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190726
X-PR-Tracked-Commit-Id: acbc372e6109c803cbee4733769d02008381740f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40233e7c447367ffc615b524187970732848d5e3
Message-Id: <156419671673.31249.15396757883686279137.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jul 2019 03:05:16 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 18:13:53 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190726

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40233e7c447367ffc615b524187970732848d5e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
