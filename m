Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21985C433EF
	for <selinux@archiver.kernel.org>; Thu, 16 Jun 2022 22:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379250AbiFPW5O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379248AbiFPW5M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jun 2022 18:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06806212F;
        Thu, 16 Jun 2022 15:57:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CE6F60F73;
        Thu, 16 Jun 2022 22:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4AC2C34114;
        Thu, 16 Jun 2022 22:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655420230;
        bh=zznE9cygfawFKzOkGsp6z3Fu47wZj6MgkBmsFByFzmw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FVTyeuiQzn3V09bbv6wCSuwKmkC9M5KbQlVW0AjVPW5nyA0IfvttriuKd7y9qGaUy
         GElzfaC1SZkTeGe2rTiqEhcOwbcsKAsWlMPT3EgqBHKr1Pl5YepYT0jFOBpKn3eptt
         iIszudU4VGkykwgoTTHw1XGCozaXpr6BfpFHnN4AlgNM/15618Ytl1mfagFD378vo0
         ukko0HIk4PzEisfaVe+D8bdsgFG9EAIflOoAO8iNH/nu4xx25w3P0x3flQ5w46RsWf
         NB7j9aGlhmUN5sMADNyjtdEYPZlG+fgc12tJmMxWODoXr7vWi9xwkGBSD7WbIlN+mo
         2ZTISfJyaMlzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D15A1FD99FB;
        Thu, 16 Jun 2022 22:57:10 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux fixes for v5.19 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQa-L-_F4UdMekqvyF714xhEerVQzc9rPvuwTQJtmMd8A@mail.gmail.com>
References: <CAHC9VhQa-L-_F4UdMekqvyF714xhEerVQzc9rPvuwTQJtmMd8A@mail.gmail.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQa-L-_F4UdMekqvyF714xhEerVQzc9rPvuwTQJtmMd8A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git selinux-pr-20220616
X-PR-Tracked-Commit-Id: cad140d00899e7a9cb6fe93b282051df589e671c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6decbf75c93e654ce6cb0e93a02ca6575dce9922
Message-Id: <165542023085.4629.13548382440245751190.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jun 2022 22:57:10 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Thu, 16 Jun 2022 17:44:35 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git selinux-pr-20220616

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6decbf75c93e654ce6cb0e93a02ca6575dce9922

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
