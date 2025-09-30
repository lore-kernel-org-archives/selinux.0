Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3D1E0DFE;
	Tue, 30 Sep 2025 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253752; cv=none; b=fT7L6ArC6M2FvfNTTKD0tGMnceLt21GqsnOwGyshjnyWcB2tPyGIhm7pH/ykGAwKizfFPXMoi8osoLez8gAyq7BbmrOP5jzEnWupVuSUjY1MQRxcfrO117ILeyr6HZzfCx+Ca/RIx38x0HmNDX87E+s8wIeexjnpLciraocnNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253752; c=relaxed/simple;
	bh=OEHuYq21cl8oWHp0Jg5wo7XPtdxQLFLN7jxxL1kFOJw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aYEjlyVdU/DNdRZVhJktCZNX0GD+MK//XVMD0JZ9XjVbs9qXnFTeckEe165kQCTmpMHN3SaVRA53VTd+x1U1uNr38nzIVyonYdQmFrHztAHDV2rjBdaSnsL0rYmhKwKoHh2JFwrMTiAD3YONjhdmtL8QnUBz1X7gw04/lxNplZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh/2YaiB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh/2YaiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C95C4CEF0;
	Tue, 30 Sep 2025 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759253751;
	bh=OEHuYq21cl8oWHp0Jg5wo7XPtdxQLFLN7jxxL1kFOJw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hh/2YaiBoqXv0MlnQUsbXa2MrlzmOGx9fDcVgDVQA4YTmcZZg4CqOzGi/6NTvvprG
	 P/GJSl4TK48sSSL0bRltN5v/IsjcDKuj/GTwZJiSnUpWbZaD2YjqQx3XKxbr50SFCE
	 kfu2wZTIKXI6mqBLFhFQSJYA/wghg+cP6tsfpuEEajbo0WlU4GAQkwbQiNJXMf1Iem
	 zJ7LcMWmskvDc5nzGxB4VcMyarqIWjqSuX5KyQaPbcutUTJOYdnqd5YstBWOAi8lhn
	 dVGaiQbFCCUcgWlsxrjk0xdf5UY4HeOXpCBquemeKDi0NWQSFTi7YFNRIAaCBirdNy
	 Q4MSpYRRVxSCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3412339D0C1A;
	Tue, 30 Sep 2025 17:35:46 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20250926
From: pr-tracker-bot@kernel.org
In-Reply-To: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com>
References: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250926
X-PR-Tracked-Commit-Id: 68e1e908cb7682db9fb7f79907f9352435a81c0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57bc683896c55ff348e1a592175e76f9478035d6
Message-Id: <175925374486.2087146.16146771245932650399.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 17:35:44 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 23:07:34 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250926

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57bc683896c55ff348e1a592175e76f9478035d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
