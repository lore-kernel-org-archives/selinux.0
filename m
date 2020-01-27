Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A75C32771
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 23:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173F32173E
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 23:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580169323;
	bh=/RHbzCKM561zYe8Wjo0KSVUZ77qX9Vyf1BOcLlnjz/Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Fj+A/88OJJQw6vXmIXkSn3mazvhdXWJBRKB6HM9UNZ6o0mALkINvv+TYR6gxhKHre
	 VWoMF0zAfQz0/wH0HtMDq++UaHjXMBKNp6jbqmsXUQPXcsv6Ek5L6966JnZxkAI5eu
	 aEj+aYhs+tKYlIjomB3TjBv0Oo4NOgWCk9V3uevA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgA0XzJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgA0XzF (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 27 Jan 2020 18:55:05 -0500
Subject: Re: [GIT PULL] SELinux patches for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580169305;
        bh=/RHbzCKM561zYe8Wjo0KSVUZ77qX9Vyf1BOcLlnjz/Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QBSWodMLhwQyJ6CUCjO0ksG0WuSjc1emxTEFfmkt2BILXwhNXOO7qxJOe3ZZ78zhi
         tFDYdf5MOeVLAJObvZQjkMN6v86xyJcHh1XBY7BwMId80gl0GgjnerMndGLWMiTcXL
         fJjAP1XUrk+M98FqR7XuXAoMnHXcf1QdNbqucBMg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhR_5564up7u1V-PRXOz_RRfTLj16m508qgNvdWC8gcRTA@mail.gmail.com>
References: <CAHC9VhR_5564up7u1V-PRXOz_RRfTLj16m508qgNvdWC8gcRTA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhR_5564up7u1V-PRXOz_RRfTLj16m508qgNvdWC8gcRTA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20200127
X-PR-Tracked-Commit-Id: 98aa00345de54b8340dc2ddcd87f446d33387b5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1dba2473114588be3df916bf629a61bdcc83737
Message-Id: <158016930519.17044.11033207196664253320.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 23:55:05 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 17:26:18 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20200127

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1dba2473114588be3df916bf629a61bdcc83737

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
