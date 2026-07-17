Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757237DE91;
	Fri, 17 Jul 2026 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784319465; cv=none; b=GuCNoRCIYp1hYB36115bQT0e5WLKUKYpphh3oZtifCsUM7jUM2dDI9BwdNhdIef/vPkZgBcEgk9W0roBfL0Qhuh3dH0haNmYbCFGUjJPLvytuZyVtofBs1ZCk/IWKS6uB27ceBOnAt85qAVZS3uX9OXstFLJ/vYXY5XmyZLtj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784319465; c=relaxed/simple;
	bh=wfKPe13mOKmlHFy4bOSv1MuQuvi81PWINUIl2Hpj+Nw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BNQJyYTEAviXRVbCFiXlJx6nYlqAzh+JznXid0uOHi2O2Dt4jQoeP/GBvCDkVzrJwyxq3s+X5BmT/prQ+dkVaCNGnm8LZFgLBY8srCbIgY7gRPfdwwYM1WKsY8SoPO5zdcTlUQdHyKbEjbscvo7WRsR5QNW3OAEEAYajYJwCa1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEAyFJMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEAyFJMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14671F000E9;
	Fri, 17 Jul 2026 20:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784319463;
	bh=aWPJSvQQ4Eljr8B5pvz5XOo/eexEvCwKsiJC6BgarMw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=NEAyFJMYsOfuPX3u5dpcM0P6TqBC3Gq9m/RggSW9U8osNcw7RI8utn1q4I4o7aazO
	 Xq5U4CY/V4dEB5BL5Y35oQz2k4EQv+QGweS5k2efSSN1HX9wtT8jTJJCll/7uhfMHT
	 rpIvLgIxGzZgmxKu7ayI8OnqNzViU7DXGtRFqN6PUPjF754EBuXFZA18g1mDcO7Pl4
	 /tNma48SKqtu6bHfvdn7ajYHx1r/XRXxiGauDxCY99HFREBXKW9aNpadT4XKhRQlq1
	 q04O2KWBQDAPMNlyWULgwoLAhR3Qb3o1lmAOuT2SB9EDifv7l7qkDr5nMJv3ZeLcoG
	 A3AIk97gfOjsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56944380CFED;
	Fri, 17 Jul 2026 20:17:17 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20260717
From: pr-tracker-bot@kernel.org
In-Reply-To: <fa44478822ef189fb7a5ce16135dadd8@paul-moore.com>
References: <fa44478822ef189fb7a5ce16135dadd8@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <fa44478822ef189fb7a5ce16135dadd8@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260717
X-PR-Tracked-Commit-Id: 9fe595fad54d4ac6a402edb3f60bec859d52cea6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fc574321e59a2484063b2e75016772815038608
Message-Id: <178431943596.1854741.6098507108282276518.pr-tracker-bot@kernel.org>
Date: Fri, 17 Jul 2026 20:17:15 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Jul 2026 13:03:30 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260717

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fc574321e59a2484063b2e75016772815038608

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
