Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564125;
	b=diCOkuYB9JTpfRtBm0jysFPklnTUTT44DadQlwZiUimVAAhtn5Yse3o4mtT960CdsIrF
	 crUW/SBArCxnzpQjdXtmfbM1y5zHiSIU6sbgjy2GfmiravXmrUnt+TE6lTF5UdNZ3Ze5t
	 iIzy3ZJJ0gV6NZsj6ySDI8TVmy0Gm5TIL6cAXI+ybAQMvMbgmQsCKnwm13VO5ZHVC32f1
	 izAKFaJWhIOFYwSPsIHkNf6bc0w1/g9Fp4esnxUF0QN1DSTNX0QxIBNQ40MwA8lD3VGZI
	 J6oyolV/tr6QyLxJYSMmVA+LoxfqXyn8zqqewlbHDGEMzu/T/RI2bU6P8up9ZM3tvLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564125;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=/Z1rydeOMWEIkF48pT5N1tfwDZ6mRJN9nE4//O9FEdg=;
	b=abFpQE1oSg1oMVJDk/zxWlxdpSkCLsVJox+fHiZ0blAvGkSF/Ff2GOm+o1bpG2aVao+B
	 4AnDYXvSjrayTkqCdwuXK4yCV+LZQ+Pn1rMsmiT1wLJWN/Miwp3kyQBPRh6siq+Ov3u6i
	 eT8+xpSj7aO5hTaavARPtbwGJILJ2H0z4wRn0bx3Fx5jQ6odkEo+YRbA9L4QW6EdM4WQ6
	 V2rL5+iV9FAB/lCcql7UWDt0uVNWu6FhvUPP02N4brzcaI0eTOqGZQwMJOR00+nUXQ5T5
	 ZNwVuizcwut3W8jXV6iLv8iU5CxissLqYIUUgCS+iL12sMosLTBs8x5/Dei56a44zSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZvBpTzC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A014606A325;
	Wed, 21 Oct 2026 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZvBpTzC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B871F000CB;
	Wed, 21 Oct 2026 06:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792564125;
	bh=/Z1rydeOMWEIkF48pT5N1tfwDZ6mRJN9nE4//O9FEdg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=FZvBpTzClk5RnunFzByZY97t8GWAKktOS6iLG9UN4QL7mRb2a9ls3p9A5xoiVh/BF
	 qZIVcpicEueogfhvnR51g5N356aYGwQiUoPctiCq+9uXM8lJ5yy6zSYSkhjIa9nDZ+
	 QgKliDANgSzBWv+QcKtCs25NZndWIZ9ot8JLtZG0YGkQZ/PATGs9K4IRYmMFn3ZrcZ
	 XGL8h832BuhilnpAJoZUHO3CCNgXT9X6TXoAj5fX/ogwR0rvGX7ljnXp6yiu53IHdW
	 Go5TPQV7HAto8b2U+PRBdmpxt9CJanJcQ20XyNXRRgvnlLEI/XCQAKUsbDMHXS6Vt0
	 7YDPy0kGPGtXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4DA3809A24;
	Wed, 21 Oct 2026 06:28:45 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20261015
From: pr-tracker-bot@kernel.org
In-Reply-To: <e30c2a29706391f16d9ac9446907193c@paul-moore.com>
References: <e30c2a29706391f16d9ac9446907193c@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <e30c2a29706391f16d9ac9446907193c@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20261015
X-PR-Tracked-Commit-Id: b73b967b0fc44707f39faa4f298f1f9d9b7bfac5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 331eadd85f14bac85663c14c99228f6dedf64d87
Message-Id: <179256412366.425997.9084383338217041751.pr-tracker-bot@kernel.org>
Date: Wed, 21 Oct 2026 06:28:43 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 16 Oct 2026 23:00:05 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20261015

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/331eadd85f14bac85663c14c99228f6dedf64d87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
