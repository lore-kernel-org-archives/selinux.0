Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51A639150F;
	Mon, 13 Apr 2026 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120509; cv=none; b=VNZh0oTZunLuogOdF9MpgwYnFB0Q7ji379EKM3BBdN5pJ//Xm+/9NlEY9rtEPmgKDlqVDAfpei/W/9M0kTjc7/rmuYwmhY0R/+93hBfL/z86gAyT+YCbQ5i8V6vj8UFMaSLPljoNXjtt49C3BeGkXyln3vlqxHbpZhcvoM2Wi2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120509; c=relaxed/simple;
	bh=xzgNtg+csaFUUgIUfQ0P1+eEWx95nfPTsRWxISJhEH8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RflsiINjFDl7k2Bk8NekRfBAlBn3TqdO0FbWjajwD39k+78J5coCGps1xPfAlnl4lpx3CX9nJXphfZ3XwAdlK41qQ5/iZbp/HhBPxac0IHU6KSGjA0f2SQySSyd7dDzfu56yvWRyzZUbQbuwEjI51lG0CyNAi4KA5gSqWX4LW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITJD4w+/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITJD4w+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8B7C2BCAF;
	Mon, 13 Apr 2026 22:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120509;
	bh=xzgNtg+csaFUUgIUfQ0P1+eEWx95nfPTsRWxISJhEH8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ITJD4w+/5tiC6r7WVd76Olli0tp0ZtVDChrR92DAJs5Bl80RTM+oHMSZhz/rdoMGV
	 9nlvmHTtCWcgC1b+aw53ePH1DCdo60v2+5KgpVfxkCrvbtC+qwfok28Ts5iouXl0g7
	 uiA671tA8kh/QPkby+5dx4qxSBzCw++B01s5/DFTvE31Gknkpo3e95SsMTtsF0bqPQ
	 nEko27f36AWWP7e3TuEQHDPKikMMozAK/zSSGnHXGmG5XBHyKgCZ/vtCX0tgXWt03d
	 IYDjya9qmIAAbi0x+2C2d/1MLghmz3X8RU61JWwJc45e7asfq6df168xrudT9WDP8c
	 YPmoWRkp9G4Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 03C1C3809A0B;
	Mon, 13 Apr 2026 22:48:02 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20260410
From: pr-tracker-bot@kernel.org
In-Reply-To: <60af9bced9ea23be5deffcb469805ff5@paul-moore.com>
References: <60af9bced9ea23be5deffcb469805ff5@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <60af9bced9ea23be5deffcb469805ff5@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260410
X-PR-Tracked-Commit-Id: 8dc51459ef702bcc0ef5fb26bb4d362b38aa56c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b206a6fb9a105be198cf2dc435ffa4ad7c75ddc2
Message-Id: <177612048093.584243.7448313467874973509.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 22:48:00 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 19:26:11 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260410

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b206a6fb9a105be198cf2dc435ffa4ad7c75ddc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
