Return-Path: <SRS0=eoah=N2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4656FC43441
	for <selinux@archiver.kernel.org>; Thu, 15 Nov 2018 17:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E79F21582
	for <selinux@archiver.kernel.org>; Thu, 15 Nov 2018 17:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E79F21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbeKPDir (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbeKPDiq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 15 Nov 2018 22:38:46 -0500
Subject: Re: [GIT PULL] SELinux fixes for v4.20 (#1)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD87223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRWJ2s+z3TYazcgb6e2mkYuvD4Hy5W-N8i4Qo9Rn_8SeA@mail.gmail.com>
References: <CAHC9VhRWJ2s+z3TYazcgb6e2mkYuvD4Hy5W-N8i4Qo9Rn_8SeA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRWJ2s+z3TYazcgb6e2mkYuvD4Hy5W-N8i4Qo9Rn_8SeA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20181115
X-PR-Tracked-Commit-Id: 877181a8d9dc663f7a73f77f50af714d7888ec3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da5322e65940e4e8426613a8ff3d99a08b350a52
Message-Id: <20181115173002.30611.37125.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 15 Nov 2018 17:30:02 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Thu, 15 Nov 2018 08:02:47 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20181115

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da5322e65940e4e8426613a8ff3d99a08b350a52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
