Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E513B2B1;
	Tue, 16 Jul 2024 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167162; cv=none; b=PWDjE8F1fNCm8zVwwLF3WofURWBYiDe7gxsRuTb+HgqSnlAT27DqxiF7Zy5CZMSH6OiYlfJAI4rAfxx4aWfFgO7R/g5vFGZl+MLsRWVkx5PljHH1SMG/HQKBqfiKuFAcsCAIFLRXrlOFWhECDWm5VANqc3IrcbUVemmwxN9shmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167162; c=relaxed/simple;
	bh=RLNvHZ7ijUj6F87ttAG5Whxhqk0lI4BCCRd7ZAv11nE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q+swYUW96Ii3418tO8KBmNt34ulMqoYs17PedPY/qQIuhAFzkWjtC0ShhRqUN1/L7BvkxIibQImWvKG42khtv8weUjS8mptV98/0hfLoC+4UOGbSsr54ywU3RHFc6BlVT+MV7yEbQP9iTzNIHEqigfcLYuCPKPdn85N2GTKCRI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6O87lMo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6O87lMo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B08B2C116B1;
	Tue, 16 Jul 2024 21:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721167161;
	bh=RLNvHZ7ijUj6F87ttAG5Whxhqk0lI4BCCRd7ZAv11nE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I6O87lMouMBamWUHt1gPAMAqXY6/vo0nSP/7rGNlZea7Dp3x87MW0JBdtH3c9AUi9
	 eQ+uwddo2h9BusMs3UBs0QwBP2zl4UxYpqoAv1N2fyIQkC2gbJuUoT2xRYm40Ip9tf
	 urZyeiQK7UQaCfR+sUVIrJ7h7Bkc8rDv193ExwV1Lpzto6AFtJUYVlJmljVnoNChBG
	 Wg0nBJbPvBIXdXciyNojU+OsAR0YNkE4KZuB7GSNjmVpiVBYsaTNv7lLMDpMaOIZRq
	 zDpJuqP83DLSlF7xr+eDASjSsPxIRap2M01ZWNgSt03qjImFfp5EilS6ndQYO2tp/X
	 W4peAHSU2Kddg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A469BC43445;
	Tue, 16 Jul 2024 21:59:21 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20240715
From: pr-tracker-bot@kernel.org
In-Reply-To: <4b4df5f5e3d91b9342b56ae69b3fd2be@paul-moore.com>
References: <4b4df5f5e3d91b9342b56ae69b3fd2be@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <4b4df5f5e3d91b9342b56ae69b3fd2be@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240715
X-PR-Tracked-Commit-Id: e123134b39dc40af94e8aec49227ae55b5e087a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dad8d1a383a8a2123be2a067098fa25afa2ddad7
Message-Id: <172116716166.1258.7360995268999604207.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 21:59:21 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 15:17:33 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240715

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dad8d1a383a8a2123be2a067098fa25afa2ddad7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
