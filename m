Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87EE1547EE;
	Sat, 22 Nov 2025 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763836221; cv=none; b=Vap5gscLL82wvfcOpfrI6nLXD43iR7gQRJaCrXZAsBZcgSIShPlmtWbxhgCsFwfoZv9nN4S3V9IRQBr7HEZTl/8E6PANXN/cLLNFH8kKYGWHPRJCrq6tamI1g3JvSeTukPP/3IQuEUR+ItVpZFGxJg+K4GVsWW0XPQgayjjZOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763836221; c=relaxed/simple;
	bh=1hdCHSazDewOv/RP8IxFsdGeAxrIGJnFblV1I9pFH0E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hYxwzI88YthQzN4L80MHvAZY2iKot1Hx1dkS6+igehrO2ajm19lDBRRQjDw+TwcnP/PaUHOCzNCZ5U7vvEka+caQOns8NM/vaj+tHzvAhGU5dNnOmaPp61gXzhBkB0S240qoQQ+Y0iVsLOa/WE0C4o8iqneY3FUb5l6oiL1yacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7UtwIHZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7UtwIHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1FBC4CEF5;
	Sat, 22 Nov 2025 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763836220;
	bh=1hdCHSazDewOv/RP8IxFsdGeAxrIGJnFblV1I9pFH0E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e7UtwIHZLBFNa3JoRyiDCFGl6eHmHwJt6YseIk40GNRhdvkHy++nzXQHHxK7mxaZ8
	 W/ipEZrTNkFuzorJ4HHQ7v+/8FKCpmHKgLJa26y53/Q/FGVzlbgk7dvEdvV6bTFfZa
	 tl1Ydk1A4dCW2Xsp54i4Edh8tSzIn7beERhV/yAjjGaEmrEfz1MRsX1fFIgMGhDEjL
	 +0J8E8D1Asbla9Z0Knvj3uJAKxpM1eA71GS7XVmhsgSvfBqauqIXal49Xp5NGWc39w
	 KTYX/8cHD60Vhlnk3iYICGkNQEsJlGA+4pPt/7WQB3TmJftivJsDKoV9vV8eu90A1z
	 akNkDhvVHlrAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF63A82577;
	Sat, 22 Nov 2025 18:29:45 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20251121
From: pr-tracker-bot@kernel.org
In-Reply-To: <e6a2c26951147ce12c57ff1fd53651c0@paul-moore.com>
References: <e6a2c26951147ce12c57ff1fd53651c0@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <e6a2c26951147ce12c57ff1fd53651c0@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20251121
X-PR-Tracked-Commit-Id: 3ded250b97c3ae94a642bc2e710a95700e72dfb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5703357ede59ce8b0af11e02c374a3db73c55ee8
Message-Id: <176383618428.2850055.6766000151131474766.pr-tracker-bot@kernel.org>
Date: Sat, 22 Nov 2025 18:29:44 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Nov 2025 15:57:27 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20251121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5703357ede59ce8b0af11e02c374a3db73c55ee8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
