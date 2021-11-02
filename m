Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CF2C4332F
	for <selinux@archiver.kernel.org>; Tue,  2 Nov 2021 04:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2D6608FB
	for <selinux@archiver.kernel.org>; Tue,  2 Nov 2021 04:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhKBEXg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Nov 2021 00:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhKBEXf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 2 Nov 2021 00:23:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 80649608FB;
        Tue,  2 Nov 2021 04:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635826861;
        bh=ToVWfb1y0VeLVRe8N2KmE9z7N8TxPHho9AP6Npnmfkw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X9AOA1z7zO1N8E5gwMfDFpDb2Cw3ykCPSxNgtysdKlieTNwWaekyvYwOjrv8N9fO/
         nKpdODqesnYooZeLy2JK26x/18QevzibDGJUIAaBzgFjbToYkrCHGuvxQxzpZk8AbY
         Ptu0U7E5MgHWEmQ9c5zB8DMfjBZ+tXM2Zm2T95wJiVFljfFEGrqfo2+N8d0tG1RD7J
         q0FdJH/gcny7CcItKEdKFZHVBzRP4i3K8e78xE99CvGhUJoKe3QcqCxIJtocpX49sw
         PpL5fgn+3Wn70EJALcdGcGWSDVXJd1BKwnM9H7xXjcjx6lR47+hDkF++CPuEOSx2hR
         CcsqpI1ddTDXA==
Subject: Re: [GIT PULL] SELinux patches for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
References: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20211101
X-PR-Tracked-Commit-Id: 15bf32398ad488c0df1cbaf16431422c87e4feea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdab10bf3285ee354e8f50254aa799631b7a95e0
Message-Id: <163582686139.28234.18129070672818879641.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 04:21:01 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 19:59:02 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20211101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdab10bf3285ee354e8f50254aa799631b7a95e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
