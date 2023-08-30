Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878EAC83F01
	for <selinux@archiver.kernel.org>; Wed, 30 Aug 2023 18:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbjH3SrI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343695AbjH3Qeb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Aug 2023 12:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DEB19A;
        Wed, 30 Aug 2023 09:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BBB06228C;
        Wed, 30 Aug 2023 16:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B41A8C433C7;
        Wed, 30 Aug 2023 16:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693413267;
        bh=0UufymtUlKtRynNknBSV6gC10JNMuuGyc7Lk144Q3sE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l65272u1/n1eTc3jyhPC+mijokIM2iNod7XUL9filllAE/6qf/amOwQ4jaBCjbLwA
         eQdhhLvBA9opJ30MehEHKIERI1MGxK7+hPFE1REdqu5jvnxQPKw7ZZdtUy8gWFj0eR
         SVSK09ArUICwgJ9m25Du9RHO/q6LcKhqANDkti3nK1H7FY50WPOX+/TQPq4LosKkmG
         iCIofySyd4GEJ2cF1GqZ3VFEhaGq4O8QBsk1HbSubx4P2J/dIBXrEHWBij/HvwnNY2
         91ip2+pa/IiRLy9PWWQyILqw5R0LVm2znft6lWte9sMkeVPdo2LGt3nIFOC0pfq3Rq
         OcLGM9BZgklHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3548C64457;
        Wed, 30 Aug 2023 16:34:27 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSnxiL9wsc6FGDme+yDFfTGC0nMKTGObC_WJ3+TZqdR5Q@mail.gmail.com>
References: <CAHC9VhSnxiL9wsc6FGDme+yDFfTGC0nMKTGObC_WJ3+TZqdR5Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSnxiL9wsc6FGDme+yDFfTGC0nMKTGObC_WJ3+TZqdR5Q@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20230829
X-PR-Tracked-Commit-Id: 1df83cbf23a27174aee6ea5e52462f03f7e48a10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dbae189873066e817fe94b4e4ac7c8c42b51d77
Message-Id: <169341326766.28213.5078416612857618994.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 16:34:27 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 19:06:06 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20230829

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dbae189873066e817fe94b4e4ac7c8c42b51d77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
