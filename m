Return-Path: <SRS0=Plie=RK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077F5C43381
	for <selinux@archiver.kernel.org>; Thu,  7 Mar 2019 20:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6E620851
	for <selinux@archiver.kernel.org>; Thu,  7 Mar 2019 20:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551992118;
	bh=5r639Man69NVlhCkmwwdQa5NuM9IotL1m9vSHKNcnz0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ye85ryykyxXeef7NPZmrGiyHNEt67TE/By2URMqhyK/hCE+jZbY6WMusBKQ9qUrXV
	 MbGtxP/nUkAm3TeaKaano84s15qqX/RVZqq8r/wPLWYHxrIZGAXoZN3sDqMxfQb1wi
	 zNNR3M35LOEU49bkt7u493vlsgDl6V3IhxIJrgLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfCGUzR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:55:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfCGUzQ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 7 Mar 2019 15:55:16 -0500
Subject: Re: [GIT PULL] SELinux patches for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551992115;
        bh=5r639Man69NVlhCkmwwdQa5NuM9IotL1m9vSHKNcnz0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sBqnA4vH2ZZOhMlDbRg5eQYiZ1s4JaFBZjtSbt9d75DnPJ0vT0k88nQiRTwtV2Lv2
         ZVuiQ/Wc7OqQQF98ZZRtl0qXVHY9JURPJgT92LEDhLifLi6wsm0wX0jFXnnTEibKfE
         UyE+PEakLl1WvOFdGGcYpKUENOc5kxJiApXTjuN0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRbDONFkYe5J2KtFSRdKcz5Z3vdJFuiZCi_EQiJHFaNtA@mail.gmail.com>
References: <CAHC9VhRbDONFkYe5J2KtFSRdKcz5Z3vdJFuiZCi_EQiJHFaNtA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRbDONFkYe5J2KtFSRdKcz5Z3vdJFuiZCi_EQiJHFaNtA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190305
X-PR-Tracked-Commit-Id: 45189a1998e00f6375ebd49d1e18161acddd73de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ac96c30ccfa802501dd2f4941e4508ea54b0b8a
Message-Id: <155199211579.24626.7678959468205082133.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 20:55:15 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 17:17:30 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190305

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ac96c30ccfa802501dd2f4941e4508ea54b0b8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
