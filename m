Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BDD170826;
	Wed, 22 Jan 2025 04:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737519311; cv=none; b=KlVyl7s7AKtb/+YKZMcOVJm0p9WMpa4NRKSVcK5iysUJykAIMV9WbktLAvHN5ujo86rjm8qetrXY57WFDwEkVa+w9g+oufnUDHyfM08q6d9jtbz5bnJj90SjchLmZnpdkOdiZbCnYSg+TgzoEVdM8yWDG6z/gA1RyyoPWUY55+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737519311; c=relaxed/simple;
	bh=xI+bHzRAzSixGhLZq8aNeeeH5/R/9suWwfYSg2KzB6o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WWjIQr2QBa5O7uQdVMlfv3gjiUY+L8tOwgwBeR077yn4wssqBJ6hKNXN53EBKPxZi2hxsBBNospsNyIfx0+tzbyn5tvV3H70jtp/nmRyc3RSkNtqz9E0TsmjGo4QepvP+TC/XBYxW4cyBb0RkVxkbpxEwN7+TTW/WIK+vIlS7e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0vCTd2L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0vCTd2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C1BC4CEE6;
	Wed, 22 Jan 2025 04:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737519310;
	bh=xI+bHzRAzSixGhLZq8aNeeeH5/R/9suWwfYSg2KzB6o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n0vCTd2Lz8g1+RcZTI9uBSuudABmeEapv39Igf1YhmCWPQ+V0JGg2Mrv4V4SMfyxU
	 U2w8IqH0Oa+Jhs0PK+FNGY7uRmLBm8WOJZP3wMRQRGRc+DoOmk/N2l5QO1S+IsF+fk
	 LNxwvYNH+7EZaay31PwN/gwIXh8RnCV0/ukgbU2zn5ITdyUq8858fSyAOMY7qDx3tk
	 ttBLQ3FCNneG5nFmNO/P9KDTB6MYuf8Sy2GUaXvmzQPhGZ4jqGrDvVf9dF6Mq5irQu
	 uUStFwbrxhqshPOIuEkMJn4dCSO6XuTrTnZD7W9HVMluf3hrP+hyxcrceY6UjCfRw2
	 bmvB76n0SXpxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B60380AA6B;
	Wed, 22 Jan 2025 04:15:36 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20250121
From: pr-tracker-bot@kernel.org
In-Reply-To: <d6c372031669fb475858e5f296fc8222@paul-moore.com>
References: <d6c372031669fb475858e5f296fc8222@paul-moore.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <d6c372031669fb475858e5f296fc8222@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250121
X-PR-Tracked-Commit-Id: 01c2253a0fbdccb58cd79d4ff9ab39964bfb4474
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 690ffcd817eaad3bd25a24dd8d63d9d97adf5cfe
Message-Id: <173751933492.229101.8477369296633301197.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 04:15:34 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 18:40:24 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/690ffcd817eaad3bd25a24dd8d63d9d97adf5cfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
