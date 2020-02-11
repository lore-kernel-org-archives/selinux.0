Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E93C352A4
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 01:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D60820708
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581383435;
	bh=W9nWEA3G1TduFuZXl5PQOqHztuRKoP2nmeJ7R0lnxS0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KBm1WPvVABTux5KuuUTDmeB168LZGiH4Rlyl4eQVTScVQBiGSdg8RS9799fk+zkY7
	 rMl++/aXSWOIBbedltwHA7a493cvFOAiawW5n07RAGaUaoBGn/gNOuRWneNs3s9PSS
	 eka6KZ+r9kHt2kgkhkADsyoi+ZLPVh79a8VUvn0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBKBKY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 20:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbgBKBKY (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 10 Feb 2020 20:10:24 -0500
Subject: Re: [GIT PULL] SELinux fixes for v5.6 (#1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581383423;
        bh=W9nWEA3G1TduFuZXl5PQOqHztuRKoP2nmeJ7R0lnxS0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZIhCVS64e46yKoy7pgb3ojf812fkBubQkgYABlY1D25GuXLNpHhcZfHAT4XowMiYZ
         SO3IZPLefwU2N06t+eCuOqG/tXXBVZc1blFd+jEeZXpsr/yY5UUGaK314/rJdOabHo
         YN5mARu9+LwcD59t1yFy3sXMDZxBpHVkHZ/sIzWU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRegJC9MP2pAGV_htOVNiBYSzxJ3xBFk7trwRpLniBY+w@mail.gmail.com>
References: <CAHC9VhRegJC9MP2pAGV_htOVNiBYSzxJ3xBFk7trwRpLniBY+w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRegJC9MP2pAGV_htOVNiBYSzxJ3xBFk7trwRpLniBY+w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20200210
X-PR-Tracked-Commit-Id: 39a706fbcf2694bfb651bed9041d44c3f4fa8078
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5650acb5f33d8c7c26941136b2d3c46b8a243ea
Message-Id: <158138342360.12297.13560207964939239421.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Feb 2020 01:10:23 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Mon, 10 Feb 2020 16:27:42 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20200210

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5650acb5f33d8c7c26941136b2d3c46b8a243ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
