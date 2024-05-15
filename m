Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84683800;
	Wed, 15 May 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790907; cv=none; b=iG6g/ueFfvMLgkBn/epT3yDoNBI3tS6vg3hv9vStAa2CZy67kXGCqlqw2zieyj/YwD7A897TgHClYslvsR16NB+LHpvRoEY9+owdX/HLNr1Zb3y8y311b9G3ZuVzzhlkNnb4EkIuGOfOyxEdEj8WtOomdRLA4Fnw7haMWi8KsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790907; c=relaxed/simple;
	bh=PoivPBOAhAAaQPcPeSYxBCrpVaH2Dxvmlh72fQacjy0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oKNrOi+8LtlIdMl3wUVBzxlzqvqfG6YZfbIc1+caRU4bDE3idR3fKfWRn2SWYKHtOvf7pzln75CCFB7PK77xPEFrDTrVJtQoS+Ld7hlQ1ss6hBzUMzcsMFhUJIapBftpVtbTaMczdvUxqzzoIAsVDRPHoc1Zu5X9v0gwO1KbZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+BO7M0Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+BO7M0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 631FAC116B1;
	Wed, 15 May 2024 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715790907;
	bh=PoivPBOAhAAaQPcPeSYxBCrpVaH2Dxvmlh72fQacjy0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i+BO7M0Yi5kg6PyKIPG48oywJoh9XI7SE/K7f5EfIF8Zf0Xt7AAemOsznXTrcYHnr
	 PWNBGZvlFwc/JgK5YfOOHD1dwHDP1ikgdpWHEWODRBsiE6f+EQ9jK3nyVB3Zma8sOf
	 qPpmHVjB8lrgg11JC9i6POEg+dBQLQRyX7PvX3LwwnJWKQTbulg2Tgczng8cUZXy0U
	 RsqZNiHziIt6TKCgfc6k67tkulpsFJazY0tFRuiy1YhIEAP5fDGErSyHOjnCLdKqd7
	 aipouS95e+9nPCVCNMk00qLotMkasjAQGZvdZXICmOvPmSPC1LOO6fg3C20IE31kh3
	 HUppaVHHyXKcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 594FEC433A2;
	Wed, 15 May 2024 16:35:07 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20240513
From: pr-tracker-bot@kernel.org
In-Reply-To: <32b581d2da1208a912f4ad200b08bdf1@paul-moore.com>
References: <32b581d2da1208a912f4ad200b08bdf1@paul-moore.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <32b581d2da1208a912f4ad200b08bdf1@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240513
X-PR-Tracked-Commit-Id: 581646c3fb98494009671f6d347ea125bc0e663a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccae19c6239ae810242d2edc03b02bdcc12fc5ab
Message-Id: <171579090735.28973.14194535403813876767.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 16:35:07 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 17:23:02 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240513

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccae19c6239ae810242d2edc03b02bdcc12fc5ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
