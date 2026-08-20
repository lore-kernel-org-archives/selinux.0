Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC22AE68;
	Thu, 20 Aug 2026 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787187367; cv=none; b=eYxVkly+SplhEKGyTOZdLMFkkl2UnHQCnQx0ehMHakhQ3vVvcB510SNJqvj3x+rTq5UYeOZhnWhe2+PlayEn7x9H2bMskSP0X/3jWCFjLLxe4tjNbm7h8oGlW6O3O1EgMrfaFT0/6Z1UVSKrP3fVlLAAihNdg9HrIyWbV2gWd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787187367; c=relaxed/simple;
	bh=yuSPxd6qOy4F8M6Jn062/ua5IonESTjLdaLzOX5uQGw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MRc/yJFt4oO8R8YjEALuNOF4L5KEde/aGMg+G899bXgFipTUbr7JVdJFIS7NAeywNw6WnzQ0QzyUUaD8cJhbvm65D5qidJcTOWpNdKRgj+eX4yuf//slLHkqhKgiPu9F1ijKXSAzjwfOgTKVfJ2gOzKavGAMukTwBcnTCN9RsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+pgX4H0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+pgX4H0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7291F000E9;
	Thu, 20 Aug 2026 00:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787187365;
	bh=KjxfHZDa4i/PSlQlrfIvtxFtwQMBFtStxPcupny38Q8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Q+pgX4H0mAhu0PcYGwecQnWMwMrSOUAWcx/AdXtiOCfVbc1H1FQwYOshzn6eTVRwl
	 aoDg9GdU+hNroVRSAs7yrTEJ9mLmhQTIJYXVw7fdAJom11alY1CoijR8V78FrlsFDd
	 0MS6D3gngjM1Py3pCrPFr6uFbbACFrasSZPVVf1FM/zcR/0Piw3u48MXHBWUTv/qt5
	 nYVyGw9Ml6/IUH3lQ/0QSyrUOW7XHN6AD5bsiV8KzOvNeS6TcW7T4NLghoI6fWNJT6
	 qTHP/WGLu2PdO8h+3ICx0xcyhLsQ8i1ivdkC13o4beAQk0YWsE2Z2n/yr6P875nF1O
	 UxuMDAC79A/JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B7F3811A50;
	Thu, 20 Aug 2026 00:55:17 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20260814
From: pr-tracker-bot@kernel.org
In-Reply-To: <e3c1c27333646164f71bce44e20cfc49@paul-moore.com>
References: <e3c1c27333646164f71bce44e20cfc49@paul-moore.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <e3c1c27333646164f71bce44e20cfc49@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260814
X-PR-Tracked-Commit-Id: fd6e2388a3ea55e58cbbbef840c1d8aa2067dbb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4253eb09d25bcfe44f6987b6f67c09f09d80a966
Message-Id: <178718731650.3758847.16368313288243147652.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 00:55:16 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 19:16:34 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260814

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4253eb09d25bcfe44f6987b6f67c09f09d80a966

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
