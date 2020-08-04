Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ACAC433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 21:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A85322CB1
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 21:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596577225;
	bh=LGM8VL8I37A2Tt5HGk6cHGMdfAs9oQQmcuhSNVg+lD4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uzUHnjoCOL2sNqHZkUxZjK2DpVnfcQthHhfQlZ5oNQdIvjiN4Wx0zlqY0Sh6S+tf/
	 9DVupDLV3H5/0XgY659G62rme+BbxVqHAMCEZuH7mFuCH5AQK52lWOVTktHTDJXPTP
	 Vz7cCxWD92Y6zwnaHALxY/ndg6uGYS1QzT+jsRPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgHDVkR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbgHDVkN (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 4 Aug 2020 17:40:13 -0400
Subject: Re: [GIT PULL] SELinux patches for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596577212;
        bh=LGM8VL8I37A2Tt5HGk6cHGMdfAs9oQQmcuhSNVg+lD4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Iv5gcQ/XuHG5yU135Z3eQpv6HSYZMHaNnUU7sKKLMi2b27GgUdb68KPGJs4rqsRZX
         74Xq5UhZHtjxuPRe1NWvHOV+mlU3Hpe7DSFri4YQk1PHwFiXe99NSpMVWCGAWMhs/V
         m91g3GoorwrthpgfepEgJxZrP3dFGuLCAQdmtlWo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTy5xcOqx2SRjsyC-H-xvj3vvbHDt7O-S7TLYhXjANZGw@mail.gmail.com>
References: <CAHC9VhTy5xcOqx2SRjsyC-H-xvj3vvbHDt7O-S7TLYhXjANZGw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTy5xcOqx2SRjsyC-H-xvj3vvbHDt7O-S7TLYhXjANZGw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20200803
X-PR-Tracked-Commit-Id: 54b27f9287a7b3dfc85549f01fc9d292c92c68b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49e917deeb81e263bcdb4b20e61ca18111995ffe
Message-Id: <159657721266.17686.17285046647020246350.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 21:40:12 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 19:16:10 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20200803

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49e917deeb81e263bcdb4b20e61ca18111995ffe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
