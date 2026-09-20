Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB793C945A;
	Sun, 20 Sep 2026 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789917095; cv=none; b=uT+GekY6I/IrK2p5dXm6X0GkpTmwUJexL3pdCD8Zp1DqxprIhi6bQUr49plZrPGgV19Cpbrj8YXES4PygIrXQ6tW9QjjuQd0ZGpr9h6HJO+pXSBpR7C5Dj1PchEQLzpDmlazHCfStpD3hPGh+aygfLN6IrWripv9TwQz3jRsNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789917095; c=relaxed/simple;
	bh=MiRiiiuKlVBfksk/ATg9vMcSfxwKBTaBo2kS9ncMMN8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nOoedJSo6ViGo5vB2lxfxsDSUVx2JaqNCUiPJBkAgGO/PoksmZ8lfmWJopLhdAnBMjyrFLflmIEeRtYFVJegGNGx05ifOzGcZvG3XW1xNjSk9iYFjYWfHUwU3Pi4sXVrY9DkskVlttiuEpr+UAUUUMNNLweL4CkTvEnM51YsGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmqxsqIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmqxsqIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350A61F000FF;
	Sun, 20 Sep 2026 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789917094;
	bh=QEh0nhYMmxkE9ek+/pIDbN91AHlnOTMvHwVpVQ+8254=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=YmqxsqIJFXHyqfwp0VN02SjKHrvUym7gwPTDnQAI5aWYyf2dVGitEnMOw3ByVIyv0
	 H2x4KQ6NANWyYSdF1/agPFbHNutiWHT/LL2SPGlCIdHrLDdvhX6E4DaT5fxEwAFy6q
	 rUZ4SpivaG2u/cJtMDoVEhn2HgMP/IBVkdr35595l1e9gCz0SY9GU8eCLuNdmhAiat
	 6PLVV4bZRbEYs5LVeJsUTjTe0FjQbi6GTrjyDt3GdoRhphzSklZUMu8U15RIrhBmFU
	 SPuBoXgGQ/UvIdAQQVIITVuuoo+Nf8Ulp8DMmFYlbgt7Iv2qX//VGnEhOC2d4pRU8y
	 Hy/xKoSYkfFAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C8239253CF;
	Sun, 20 Sep 2026 15:10:27 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20260919
From: pr-tracker-bot@kernel.org
In-Reply-To: <932d0e418d78fa40b5d18951a34876ac@paul-moore.com>
References: <932d0e418d78fa40b5d18951a34876ac@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <932d0e418d78fa40b5d18951a34876ac@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260919
X-PR-Tracked-Commit-Id: 78fc54b934bfb2c18aad8154c7302067146946f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a910e594aae615fcc8e0f840549659e13641529
Message-Id: <178991702624.1703482.5167888360822492920.pr-tracker-bot@kernel.org>
Date: Sun, 20 Sep 2026 15:10:26 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 19 Sep 2026 22:07:14 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260919

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a910e594aae615fcc8e0f840549659e13641529

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
