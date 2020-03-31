Return-Path: <SRS0=ncaB=5Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216D0C2D0EE
	for <selinux@archiver.kernel.org>; Tue, 31 Mar 2020 22:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54132080C
	for <selinux@archiver.kernel.org>; Tue, 31 Mar 2020 22:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585692920;
	bh=ne016EYcgo1BXB4ktHvGk1kdHTYidGrFCVPBwbZwbUc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qC6exfv4Z/OBz4mnlgrZeMl3+tJm1n1BRqANSIsvTWjfNRbAbrsbdIdT8Dokrt/ff
	 L+hn9hKTmmdqpQQ/VmWZa3QYXPZgjoLGdI5K6Te1KzIZHl0Z0Ef4RprIg5lQxRsoBJ
	 FRC9tjLiJ0gxEUzwMX9CfoYtU0PnBHNMMLt2+21A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgCaWPQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgCaWPO (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 31 Mar 2020 18:15:14 -0400
Subject: Re: [GIT PULL] SELinux patches for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585692913;
        bh=ne016EYcgo1BXB4ktHvGk1kdHTYidGrFCVPBwbZwbUc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hssACP7P+gxAmwonGyrElO683ewcOAIawNRPc9mdqmkyOlfmSLmna73k8sjvp3GSa
         k4JQfTbP1n3zZwOKsuVtmU3FkaBY2S5gfqA78IU2Gb4S3/dQzQIhGpx6dnI7l9RpXq
         vNVmvANnOiZqB4XZQvAHDLHRSjt1cXeTOu4gtZvs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQoqpqiFncTP1w0+--hGTwcm57LXgrXVsGnNqcRSof1WA@mail.gmail.com>
References: <CAHC9VhQoqpqiFncTP1w0+--hGTwcm57LXgrXVsGnNqcRSof1WA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQoqpqiFncTP1w0+--hGTwcm57LXgrXVsGnNqcRSof1WA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20200330
X-PR-Tracked-Commit-Id: c753924b628551564b6eea3c9896e4a95aa25ed9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3aa112d57b704441143d84b0475fb633a750035
Message-Id: <158569291347.4579.3524814433990268929.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 22:15:13 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 20:38:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20200330

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3aa112d57b704441143d84b0475fb633a750035

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
