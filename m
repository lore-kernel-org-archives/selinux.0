Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA328C848;
	Wed, 28 May 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446844; cv=none; b=mGtO86nCbFpZLZa3S4BlxVqFsQF6OasilAhWyb+P0DYUAhVdZM6Foj3Ix/dresn8+JB63WU4o3tZZ/mvfp7TxtH3VXXEBYLWqkVo44zN4BiIvtbrAChNzucd5RyOm78egmDk8g8nsFs4y6mzOpP2hbPHsG6tbd5quOJptUh6j90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446844; c=relaxed/simple;
	bh=xjbGGtsovR47x5VeJpAiXdFmv9RG3ZrB72S+d5ljXTo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l7zlqsjiNm60NF5sQ4IYFmqGf0ygU2C/36DmYfo/D3/4ZDaKgC7CvL+7flO7tvLyWFGB10U3Vc0niOj9zHzgykTU/b88AKEVyqn/a5d1M8Sh1s5gBiNmVQZolGIpPz6w+Q4IKONgZ0kqXNCHoc5yROPKV55d1LWQ8Nx1UUZJZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uabs9i8P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uabs9i8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B47C4CEF0;
	Wed, 28 May 2025 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748446844;
	bh=xjbGGtsovR47x5VeJpAiXdFmv9RG3ZrB72S+d5ljXTo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uabs9i8PmvuySKKHY8qP01nt19X6aTJgoILLaKtYzOfIXThOYoB7PyFrWgh4+2VkX
	 aYV7E9J5H80QjBXqOtE7tZQUFBSa/EaeY6UOvQqpX5ayYC+F4SnI9r2/ekZKuacJLG
	 uyQbDyzQO07Nok88cM5su5wHT/5x84FKDxgI0K1uOGsRr7wxDWYz6JzI/GDAEZvWE8
	 QczaHc79ZEqQaQ1tNTYo/oXpNP4BlADaEBi6H/cucZQc9oNVWhGTC4bX94vljXj8Fk
	 AmSV1xQJupZU0Kb41Augt0wdjp2sdnxf7tlocZLHNyUb7qE6yn3FwcKY30+MwvCArk
	 T8UHWfwRpDB3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB93822D1A;
	Wed, 28 May 2025 15:41:19 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20250527
From: pr-tracker-bot@kernel.org
In-Reply-To: <c19db64a8086ec30050d9f5012204a6b@paul-moore.com>
References: <c19db64a8086ec30050d9f5012204a6b@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <c19db64a8086ec30050d9f5012204a6b@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250527
X-PR-Tracked-Commit-Id: 05f1a939225ec895a97a6b2f1cf64e329b6474f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5628b81bd19fa52d6a35e49336c58d7188eaf1b
Message-Id: <174844687809.2439471.16122471024617642094.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 15:41:18 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 18:57:40 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250527

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5628b81bd19fa52d6a35e49336c58d7188eaf1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
