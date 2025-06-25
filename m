Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83E91C69D;
	Wed, 25 Jun 2025 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750812969; cv=none; b=L4J4bGsc2ZOwHvx0z15INRYSlW1XlcK52l56YjfUr2Aaq086iDuexHVG6swovFM7Cd4wMQW1LtQy9aEWwCI9iWdQVzIYwY0V5mv7qRJA1Il58LDiHbaN6Rm8Se/PgaSoNVVTt1dgybTS2MyafLeF+eEJROVwyq1lYOW2QG6jk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750812969; c=relaxed/simple;
	bh=IH2bGWZA5bhBYPjvdzUaJzZFzJ1VmY7yf8SFcjwQhsk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WYRuLQUPVeXAmjP4v7bF0V1S5ilZgZfYWPfZ7DHNT7qVnqAIkQzBJ/XJUPyefFwbdG3KX2aXo4M68WBA2isyGfncmaaErw0gDEReNGoiN1JM3wsrmMN58u8ei1022Z/0NPLV1kW1Ikwia/SSJAsyFEM4GAATy1dwZDIOpEmpZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir4KBpvA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir4KBpvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47172C4CEE3;
	Wed, 25 Jun 2025 00:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750812969;
	bh=IH2bGWZA5bhBYPjvdzUaJzZFzJ1VmY7yf8SFcjwQhsk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ir4KBpvAgC5atDjh40sjGtgFT8QaY4e4ZecSOp99l0m9kYptgrlnabB55RYps1MYi
	 li6Kk31MBSf3jB9SQqPfTojDOg256Kv0m+qSHhIQAmSe5uK+yaurJQd8uwh9xGKIF1
	 rqbPsDluqc1597i5b0kCTCvvQcbg3aMTG8Jkf5yUO5T/OxtfsemoL5pnneVzG7sSQT
	 Q7NLH78lA2Duq99iK0f0E36jDTG8Di5hFcYztk2kT/o2929uNV6lrW5PeFkwN+3DsT
	 dWMaL4u/mD93rRIATPk1bNO7geqjaUJixkLT1L7x5CFVYx8QiaUXljKKsz6OIUWJ8R
	 OJqUMBUsz3SsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3415C39FEB73;
	Wed, 25 Jun 2025 00:56:37 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20250624
From: pr-tracker-bot@kernel.org
In-Reply-To: <190ee36309adb0efa27e3b39a1a93de3@paul-moore.com>
References: <190ee36309adb0efa27e3b39a1a93de3@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <190ee36309adb0efa27e3b39a1a93de3@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250624
X-PR-Tracked-Commit-Id: fde46f60f6c5138ee422087addbc5bf5b4968bf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7595b66ae9de667bf35a8c99e8f1bfc4792e207e
Message-Id: <175081299575.4088186.8297113350911328984.pr-tracker-bot@kernel.org>
Date: Wed, 25 Jun 2025 00:56:35 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 24 Jun 2025 20:10:50 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250624

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7595b66ae9de667bf35a8c99e8f1bfc4792e207e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
