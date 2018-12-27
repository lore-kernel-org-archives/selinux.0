Return-Path: <SRS0=gO7z=PE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E9C43387
	for <selinux@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3A121907
	for <selinux@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545948336;
	bh=25Dl5lwpAEPCjzWY63MPCXCu4zEt3Vjgb5PIgSvTFdw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LZBpW20IBICZ881y/2r4yCsi+doYIzHETqwnCDD3CkFJnVQadkV5m+SIEAzRvezp/
	 uXjAnFMXMZnckyrhOx+Lguf402z8njxE0PZF5VrwgMZuzPBWjHxfI707CfA5TXTRDY
	 EYk10H4q1eyAM9RxtAh0Ojr7rZJqIQdjA7B3uSMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbeL0WFf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:05:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731530AbeL0WFF (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 27 Dec 2018 17:05:05 -0500
Subject: Re: [GIT PULL] SELinux patches v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545948304;
        bh=25Dl5lwpAEPCjzWY63MPCXCu4zEt3Vjgb5PIgSvTFdw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aIt9vBVGAbRxzB/8KaWhfTQXZ6UHONLlbBWD6WsBMxhclGiOPp5IMtNCv+bwBOw7n
         qJ7/gQZZ/uQGxu/o3AF5cG666qqlb3M4prfcrWcsnSbQ22/GejNrbNOxCQSQS8skuF
         M8ZHYiZRJkZN7qrQNvsvTn7qL+fUklPT9eMOS/QA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSzkyh3Nj+25YX1y_gs9-Y+TEedo7hi-Qk7hd+qMERvyQ@mail.gmail.com>
References: <CAHC9VhSzkyh3Nj+25YX1y_gs9-Y+TEedo7hi-Qk7hd+qMERvyQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSzkyh3Nj+25YX1y_gs9-Y+TEedo7hi-Qk7hd+qMERvyQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20181224
X-PR-Tracked-Commit-Id: ee1a84fdfeedfd7362e9a8a8f15fedc3482ade2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb2a624d5fe8b9206d14bff52da7a368a3a8374c
Message-Id: <20181227220504.24636.89315.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 22:05:04 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 12:02:25 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20181224

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb2a624d5fe8b9206d14bff52da7a368a3a8374c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
