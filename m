Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705FBC001DB
	for <selinux@archiver.kernel.org>; Wed, 28 Jun 2023 01:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjF1BBZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Jun 2023 21:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjF1BBW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Jun 2023 21:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B5D296D;
        Tue, 27 Jun 2023 18:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBC7A61244;
        Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B887C433C8;
        Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687914080;
        bh=vbcUCSLeYDz5ymA5Wr7I6xs6/fKMMskt1UXc55IPG00=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yi8ERP/96UlYB1lg9QSxpqT8GVPOvHND46iH1lrUqwF3sEXqHKI2+Gyy3LtrkwoR/
         0/9m1Qr8WsyKswjTDqLkpMEPKyro8ytn319bXMNv/xYHFHPMTp4rr3Jeb9v0iTyuzq
         3ffVqzTh9XmAd2NEVinvTyePd0x9XFO6/clxlEym+88hpkc3lnJ6YuFubl1kXHVciT
         4B4cqngMkomcpYGda9UJeVTavEAx/ksSGHHztfw9e7Q3gBe6EpUKaurd27KITS85g/
         A87NY/XpZSXHYd1QrYBgw3pE3miuI5sQh1He0bLeyT3nqveKiO5diXaiNycM4eRNV0
         OLmKYRHIyyRXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38827E53800;
        Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTC6s-_Q+5+evrgHHdE=wHLP0VXACzfsWSTLQ1ipyFRaw@mail.gmail.com>
References: <CAHC9VhTC6s-_Q+5+evrgHHdE=wHLP0VXACzfsWSTLQ1ipyFRaw@mail.gmail.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTC6s-_Q+5+evrgHHdE=wHLP0VXACzfsWSTLQ1ipyFRaw@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20230626
X-PR-Tracked-Commit-Id: 447a5688005e5b789633bd080016517a08f9fd8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 729b39ec1bdb7e1ca594e14069d05f682d9ab868
Message-Id: <168791408022.14121.11101174619013240499.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 01:01:20 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 17:28:15 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20230626

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/729b39ec1bdb7e1ca594e14069d05f682d9ab868

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
