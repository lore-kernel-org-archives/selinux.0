Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FCAC433DF
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 01:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51985206E9
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 01:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591146610;
	bh=jWVJCRzIi5rxx76ZMWxJsqDwcIYmelZ8tRzaS/f4wOM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PYDXxrefVOlQL+qeIJhQKp4gBLyZ2Zz8Ja+l48Nd38uUNDHeOnvZKBA1f3/cHSlCP
	 np8qcTHJU4kcwULQjiVaFk2F+PwjeV/EUkRGQJOr/htna0XsgBIDcoxfkSKA/ZqTQ1
	 8OigzozytJ5Hd1/tXJllKnXcDGzpTEkL3g0Kp1Jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgFCBKH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFCBKH (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 2 Jun 2020 21:10:07 -0400
Subject: Re: [GIT PULL] SELinux patches for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591146606;
        bh=jWVJCRzIi5rxx76ZMWxJsqDwcIYmelZ8tRzaS/f4wOM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SJKamLceubdGhXYjGf4/5ZdW03IM3xeV7DbdhwYopRJRScKCxXns7VKTBnyRc+v93
         SMIHddqeVI6BDD3mItMZzENUjB4CS7fNyweXZZnXinrt7GSfm5tfPH4x6OSXJIE0Lm
         QjDxWZe6Wh6RGmotfU7BpnI2V3lCzCQVIzzhMXcg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20200601
X-PR-Tracked-Commit-Id: fe5a90b8c14914397a3bb0c214d142103c1ba3bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f41030a20b38552a2da3b3f6bc9e7a78637d6c23
Message-Id: <159114660678.11472.15482345694870905600.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 01:10:06 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 21:06:48 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20200601

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f41030a20b38552a2da3b3f6bc9e7a78637d6c23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
