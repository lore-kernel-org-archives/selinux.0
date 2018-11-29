Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A5EC64EB4
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 23:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7780120673
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 23:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7780120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeK3KRM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:17:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbeK3KRL (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 30 Nov 2018 05:17:11 -0500
Subject: Re: [GIT PULL] SELinux fixes for v4.20 (#2)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C282146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTvN5iQkqDXsKuqwr73_eHwi6-0khVRb-pWQa439rN+3g@mail.gmail.com>
References: <CAHC9VhTvN5iQkqDXsKuqwr73_eHwi6-0khVRb-pWQa439rN+3g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTvN5iQkqDXsKuqwr73_eHwi6-0khVRb-pWQa439rN+3g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20181129
X-PR-Tracked-Commit-Id: 598e1a42e9626213565d3b22ea948ce78556512a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f92a2ebb3d5588720a33d4f22d55b4ba24f94da6
Message-Id: <20181129231002.19778.95214.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 29 Nov 2018 23:10:02 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Thu, 29 Nov 2018 11:48:40 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20181129

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f92a2ebb3d5588720a33d4f22d55b4ba24f94da6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
