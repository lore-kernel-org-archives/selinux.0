Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F8BC433F5
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 22:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbhKWWIW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 17:08:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239302AbhKWWIV (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 23 Nov 2021 17:08:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9DBB060F58;
        Tue, 23 Nov 2021 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637705112;
        bh=GwXgOOttEXMS2pMYRYGXIBgUvE+lETc/IRhLYRc0JnU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oRUE1HdEgdB1Bm4bHTAoinlgcDj0tJCwmT2/2bqfXtaiyNdrAWX1lNvHDyZ+JfpeA
         9sE6lNL3I36Wn9GMEdyYj8ZDm4xF2rMm9IU+RWxUAXF9znWboRX/+jzh5QoXyJu1+C
         Wexl51M0Gok+4k5XH3bK8VrO0FVlGw+Ecj5uI4e/GgrQtDxb8LaTO3rq6JSKoebW1W
         hUlTSd/1ylj3D1ekOHAnvZbXKvChLe0M1n/SdDdb6a/lWzM3DLf9QQMZcjdbECjo65
         9/Uj4b/bqBS5yHCTK+aqFxETJCBVa/Y9iyG+RaFEB5U2pG0GsMd2VhIw/7NeODYpGj
         5xm1Nb9eUfeFQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8BD67609D9;
        Tue, 23 Nov 2021 22:05:12 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux fixes for v5.16 (#2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhS2Hqg2rvS=Fbkpj++HEs5Cxf=4Xcmd7kdgvOykY1Os+A@mail.gmail.com>
References: <CAHC9VhS2Hqg2rvS=Fbkpj++HEs5Cxf=4Xcmd7kdgvOykY1Os+A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhS2Hqg2rvS=Fbkpj++HEs5Cxf=4Xcmd7kdgvOykY1Os+A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20211123
X-PR-Tracked-Commit-Id: dc27f3c5d10c58069672215787a96b4fae01818b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d9f4cf36721aba199975a9be7863a3ff5cd4b59
Message-Id: <163770511251.14610.5458733436145329838.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Nov 2021 22:05:12 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Tue, 23 Nov 2021 16:52:30 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20211123

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d9f4cf36721aba199975a9be7863a3ff5cd4b59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
