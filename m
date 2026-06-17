Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E9227B94;
	Wed, 17 Jun 2026 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697531; cv=none; b=VvKvmglGcP6lrlZIbtvREUHPWc1YQAq6XnbXhVzPa/fz/iub6lfee0wJ0nK2jApejcCRmjYEIRGN8dc/wd7wqOnMpyC/gJyPGME8eVNzleiqjyYnX/E9h0J5m2srxZQbe3rfycbyIhzvVK37r/R/x/2hx0s1Hv0JL8aEvH6LZ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697531; c=relaxed/simple;
	bh=vM3sWwYYY1ja4bE0h1VWGMbTI/jaFpIk2pvKTX+yE+8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OyEJoE5L4TKbNrDSC33saizMqZo0vWoFB5s9RAoZBBqLseHqzzGHRt4sSI1V79GJ4BrzT0PIB3PxYLm00c/NRvTa05GR1rMW2m43+83bZcynHJ1MB+OoW8hQeotQYEl92cYK3K6+SrjdJ/y3cPXYXn5fVdnKLRclNw8Ae278tc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf42Nc5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf42Nc5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F323B1F000E9;
	Wed, 17 Jun 2026 11:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781697530;
	bh=OXwGcsF8OFpTZAYH6b2kikMtGAQJmRjOCtLNDqI5MXc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Xf42Nc5RuXdIwfe37aW32H7qu4aP9bdmUoJyjlnd4Z+15mYb2VCr+Y9o3GfE6Q/YT
	 Sxb1VHZvJwMzzQwIv1oIi3miq4IhgM+Ti15eSurVg4rwn5kki4Qrbkvi702Ad1FL+N
	 kTq9BD86BM62rdiyOUTYMCjzbVDNg6hU+eR87X693Ij6VxTlbfy7OE+oWOxYl7PeZY
	 pF4qeJOrYMhRr6G4ZlRuaMLTMEmoYxi2cnSzD3E6Zde4jka0rMrLctx8SkwvBnsOTA
	 iT259hpxAwAJE6J4KH+OKRpQN5mTyXTep/nc4uIBwJq7kif6q1zQJGpkWv2g3SSC53
	 7MzEqp/X8Fpbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A583930E10;
	Wed, 17 Jun 2026 11:58:45 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20260615
From: pr-tracker-bot@kernel.org
In-Reply-To: <577e6fb29cf0b9c335748aa5fa026275@paul-moore.com>
References: <577e6fb29cf0b9c335748aa5fa026275@paul-moore.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <577e6fb29cf0b9c335748aa5fa026275@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260615
X-PR-Tracked-Commit-Id: 033182baeab63ce96a6eb8aef1a6cd444fcf9519
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 231e9d447ea97033ae8b8dff7b910e6269d7c5af
Message-Id: <178169752385.1583338.15218541619257971998.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 11:58:43 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 22:55:42 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260615

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/231e9d447ea97033ae8b8dff7b910e6269d7c5af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
