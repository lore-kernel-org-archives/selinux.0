Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514461BDC3;
	Wed, 18 Dec 2024 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560410; cv=none; b=nslz9l+SKrLyOODpS7r/p824mHmbn9s9YtyIJ/P1WNA3gQ4D1U535DmWz0rBJUjSjIPKqEe9hQMd/5wlyFBIplSgo+a5yOEi/p1sGJfihS7TOuv8sOVAByLZ4hNiKvZQpTY313fCBUNxEonRQMLxq/+OIeLvYER/0taKrgNsbQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560410; c=relaxed/simple;
	bh=UyAHwHeahHkvyLwlC2lkCs/TCeTKQbP5V1BXg8dwK6E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ospc1a0iUgJsYyYTHUa/0OYz6P/jsQ1LvU3ASFG7qTgeOZGyK+2Q5r9m9GhqesGU3ELlCSwgV3OeS9HX64hB8OshBtAmJDoopSTc0bIeIvuFpPd5+9PTV1j5UWnHfTG9fiSLyyHDd2/DvFYIj8IyLNiesCFTjXmm7h+m8tJgIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLanwcj5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLanwcj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B6BC4CECD;
	Wed, 18 Dec 2024 22:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734560409;
	bh=UyAHwHeahHkvyLwlC2lkCs/TCeTKQbP5V1BXg8dwK6E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fLanwcj5x7wu6tBoIX2eAQ9l+i+p4CjhCW1L1sXgt2cpXxalhb5dyCpZOOjpdDGiZ
	 C0kPUalaIl+UaY0JCK/vkZMdQo6EX1n9awKqXpUTi0QC7MFRbXrzibE+07ZJ5UAK02
	 a9uSGmN3h/ERmgCKkoaXsaz181XE9hLe5uLUA8r/mIU5Onr0V/EOveMsnu7qwfGFVt
	 b4D99b/HtaOHdqAHkpolnMMHM5gBSEITtMH4sNDFphnIi939ZdjBAJVoDX3LLSMm6e
	 gSG0JOuH9ieVoVwyFT58C/HYoLYlv9b7BC/7Bz8oaaiwbCmKalgZt0n4X2KThHwgc5
	 8FZuZ7JXtBzoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711833805DB1;
	Wed, 18 Dec 2024 22:20:28 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20241217
From: pr-tracker-bot@kernel.org
In-Reply-To: <ac07005d555b51b0ae021bc2b0222f39@paul-moore.com>
References: <ac07005d555b51b0ae021bc2b0222f39@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ac07005d555b51b0ae021bc2b0222f39@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20241217
X-PR-Tracked-Commit-Id: 900f83cf376bdaf798b6f5dcb2eae0c822e908b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 397d1d88af2670db9c73d2806ae270b147e6f949
Message-Id: <173456042692.1744913.13253811254137640842.pr-tracker-bot@kernel.org>
Date: Wed, 18 Dec 2024 22:20:26 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Dec 2024 23:52:02 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20241217

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/397d1d88af2670db9c73d2806ae270b147e6f949

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
