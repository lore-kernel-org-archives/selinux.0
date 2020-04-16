Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CEBC2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD06E221EB
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587059729;
	bh=p7COsR3/YEVYo3WksfwDu7k9RVu980i5r+jUbutGp10=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EB0jXVRPrcAN9lHXjgtlKrgiSOonggdteutAdTzcACoik1VImB9Q5m3QK5yFBpoDs
	 3h+tIafkQUt+BFbfMitdRQ6T9fpp+88JdXVfezwqBFu8r6uug9zAQOyesof5adX1LO
	 xaAHkDcNlu4Ai7qpToiUZ7Nh+tjnnebmMtg4GH5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbgDPRzY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731913AbgDPRzX (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 16 Apr 2020 13:55:23 -0400
Subject: Re: [GIT PULL] SELinux fixes for v5.7 (#1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587059723;
        bh=p7COsR3/YEVYo3WksfwDu7k9RVu980i5r+jUbutGp10=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gvPCsN12d88EIWYC/heWBqSeZyFB7ZGUoC7IrQfFB5U6vObRY80/EzgHI4jiVSNUk
         7TU2TpPHyM+zBypSSCYpzCfCJNwK1akJJtFQr8Uq1L8osqn/WEzEXS+MZeB+L/uXjV
         grLSasg7mbHxioE3fBEkx8N/12+PJdnK/vRHEE+8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRNYDwZttwD0Pc3JctBg7puvc+UsuZG082CdPVrarQoDg@mail.gmail.com>
References: <CAHC9VhRNYDwZttwD0Pc3JctBg7puvc+UsuZG082CdPVrarQoDg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRNYDwZttwD0Pc3JctBg7puvc+UsuZG082CdPVrarQoDg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20200416
X-PR-Tracked-Commit-Id: af15f14c8cfcee515f4e9078889045ad63efefe3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9786cab674574239b04df638f825ee0e7d76a48c
Message-Id: <158705972330.30027.7167816407601724293.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Apr 2020 17:55:23 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Thu, 16 Apr 2020 13:43:55 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20200416

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9786cab674574239b04df638f825ee0e7d76a48c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
