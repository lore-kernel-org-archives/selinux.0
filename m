Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FF3406261;
	Fri,  1 May 2026 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666992; cv=none; b=V4hGrNKTVkMRbk4e4KNpkOkpyR8XZOJsGhCDRBHwbDCT9FyNtkn5erPOSk/j9d7KfB5pyDYOg7k53vbH1//cO3TBaBCrpyHrYSY/WxduLtbSJ8LIrqd052av4mEgOLoNb2tOKLKanF+TwOR5WEsAhlFXbUQRm+5Z+bv+weYOC30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666992; c=relaxed/simple;
	bh=H5ZXGkQE9w1ugcbFey5A3JBuYwA+8PxHtYZNrY1Vu50=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dk+aMVUaBZmCc0Ad1mAspmyG+fGYssZhX/bFdYK1iRYUKFd9kfreMhaIDeyapebE6nytygqeUqjLGowpMDLwcyeZiiLxauBJ6quIrlYJWZCuWcTioxLwbN5m8AmFKj7aDXDsyOj26moshBiI1qgdVdDIfmYLVoXRTDXGp7BRro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXQziJKY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXQziJKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA46EC2BCB4;
	Fri,  1 May 2026 20:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777666991;
	bh=H5ZXGkQE9w1ugcbFey5A3JBuYwA+8PxHtYZNrY1Vu50=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JXQziJKYBrZJktdCOF+SojXsfSR3YxdwiSCdsaZKhCqbdfPKnn1B0MyUYU8IRNaHM
	 xheDHeXBFvLPQR6mxZ1KeJUIspvK8RvOCWljKysnWdCDHbKyOC2o+kb2bD7EdPlXH6
	 GsSRg611JHeyp05JY/ZjNgOCUqIs/PM+ajmbZX5tU1ZTAG3cLGpPItZqO3dXo3g2EG
	 zzaxRa8awsPKTw/ZbYoHO7ZIyQyTsEjRK4UB9kVQil6Rv40/w8wBUkq6LM6ftUrtwe
	 hyCl928tao2X+x6TuZmz8Fg5NlbTtmhwSHpZ9P7ERhMt4TyGM4mYUVqwr6hCeqSaiI
	 vGhnhuqKcjscQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE9C380CEEC;
	Fri,  1 May 2026 20:22:26 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20260501
From: pr-tracker-bot@kernel.org
In-Reply-To: <c40ca3bb83a27f66229acd4fe3888e78@paul-moore.com>
References: <c40ca3bb83a27f66229acd4fe3888e78@paul-moore.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <c40ca3bb83a27f66229acd4fe3888e78@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260501
X-PR-Tracked-Commit-Id: f92d542577db878acfd21cc18dab23d03023b217
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef5f46b630235b75beec43174348c3d01d6fc49a
Message-Id: <177766694489.3609975.8102470030070952141.pr-tracker-bot@kernel.org>
Date: Fri, 01 May 2026 20:22:24 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 01 May 2026 16:05:34 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260501

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef5f46b630235b75beec43174348c3d01d6fc49a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
