Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C118C2C9;
	Tue, 19 Nov 2024 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983044; cv=none; b=jtKnnwOnDwVhcNddjQlJUPI0EfGPGt/eQ06/UZyMSYm1AoW1QNiLYa5z6hyAkPT/SQ5RaWsWZLs6MhbHaZn83CsGV1sqt8GIMBx7PcHPKYsxz7QIZFVZiui+pph/MHoPre9A3bezrsYLc2+xZTBXvBAJecA0Dt+h9TyX6lmo1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983044; c=relaxed/simple;
	bh=Mov/PpYLqGT4ikeK9WxEeNiYlsOIGXc3TuNHO8SQAug=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FyaXTiuOa74LsFqRHId3Al409k0NuzaVOf1DagV6V5sN7pwjoLKk0BZzPAoDH7kx07jKhouyGVyOrclqnJK9/K8o7ZHciOU0Nw9qE93wST3uz9nywb7tPu5aXKmD9ua/N0sTcVOf7S35gdqRPqEGFM4JUNZNi0xs0MtNuqjJIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY6xVKwk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY6xVKwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8048FC4CECC;
	Tue, 19 Nov 2024 02:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731983044;
	bh=Mov/PpYLqGT4ikeK9WxEeNiYlsOIGXc3TuNHO8SQAug=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UY6xVKwkhTjLGb+7ST2ZFAovwrenN6Hs9BzA59t2QsQicpgs+B832ZfEdbv7xzj8f
	 zh6LWAOKc6rBtKdrN/tfiAZSB5XSmqiVtPqRMredTzdQOWClkf+S3vroUeetHQn238
	 VJGnae016rcrwBnpcM6BnvevxiO/Paif01Vk4QR9gyzIZcZtcsRRMpfDDsVAU2H8tP
	 WCMkYAmjKwQTqvzLExoqVD7gOjuQUGCFncz4CA6ZyipZhAuiQvxY9KSI/I42NDAalV
	 DLBCWVcNclKiZFS1fltLEzrMCFQKR05/1nchvdy5PUIWQdqgHqlgCvWq+tVAYq20VX
	 hRIBd6hbN8v6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 25A563809A80;
	Tue, 19 Nov 2024 02:24:17 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20241112
From: pr-tracker-bot@kernel.org
In-Reply-To: <accfdfaee6d92e9049ecc0f8b7e16889@paul-moore.com>
References: <accfdfaee6d92e9049ecc0f8b7e16889@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <accfdfaee6d92e9049ecc0f8b7e16889@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20241112
X-PR-Tracked-Commit-Id: d7b6918e22c74f2b354d8dc0ef31ab17ae334b93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ffc7dbce2d54d2ac1fac9f79a94cb84b0cba1f5
Message-Id: <173198305565.73657.1075813358913245919.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 02:24:15 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Nov 2024 18:02:10 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20241112

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ffc7dbce2d54d2ac1fac9f79a94cb84b0cba1f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
