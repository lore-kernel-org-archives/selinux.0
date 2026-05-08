Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711529405;
	Fri,  8 May 2026 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778200257; cv=none; b=pVJlJ6rGobs/yKF7/1IPbXVXPa4Smj3bPBdauUYGmoVW3Vp3irvPImUWBSU4DBrULJIcc3Ep7Vjm0vO3Kne+bD/dol/hN+akqPhZAA39j8FlMAcOB+iYZSn5IMRYFhD/C+7SLqq1J89LHRv4FfDBFM02bBshDUAvFkBafrvBmAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778200257; c=relaxed/simple;
	bh=ycgCeKC2kYFvVKkFjei3IWZmujyB7Wr+LHu5OyXLMD8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GDR3iod+E59I3Ni5p2KwGM0M8D+dityapBJssj+36o/Ndh7+SxVa2u+7QP1byVejtdXEHdflRDhpsjMkXH7F8mZ+V0jOuA1Avc2MrEOtP2TbZs0j3p8mij5uZWht3de32FreSRvjQ4GnzL62gOG5g+5pjyeOyKkvFs9bypOwlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEafQ89p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEafQ89p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B53C2BCB2;
	Fri,  8 May 2026 00:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778200256;
	bh=ycgCeKC2kYFvVKkFjei3IWZmujyB7Wr+LHu5OyXLMD8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iEafQ89pFSMky3FmhXARa9B4pJjqmABLfRAjR5c9m14cRaS6qBgyjMPYlmqb479kj
	 Je+NeYVRMJC4AB4xlC+BJg7CNszDeo7zspMh5vz3uIVEg0n3FXJiTZellB78GjxbUg
	 kV5KGxtdqNRj6dZT29KkCHnA1Tqnujrr1vll/6kQJz+237cU9px8njL2BXG31qQVRS
	 d10/V6Dc7AzrAzEeD/AEk/NbWmJi1KxB3FkKxkZmli2vLZOBTc+Px8LmldMvPiftFZ
	 oH1TaMy8uj0fkF1E+nEZ9dQ7ZbyfyCzIFAFmit8T+tQZDiHN0ffiewNlP3HCfHKVLX
	 EpeVFybGv3f7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0563810901;
	Fri,  8 May 2026 00:30:06 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20260507
From: pr-tracker-bot@kernel.org
In-Reply-To: <71f5ecc18e71e40093ddaf1b0dd1df2b@paul-moore.com>
References: <71f5ecc18e71e40093ddaf1b0dd1df2b@paul-moore.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <71f5ecc18e71e40093ddaf1b0dd1df2b@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260507
X-PR-Tracked-Commit-Id: 868f31e4061eca8c3cd607d79d954d5e54f204aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 917719c412c48687d4a176965d1fa35320ec457c
Message-Id: <177820020522.25177.17681064170087475927.pr-tracker-bot@kernel.org>
Date: Fri, 08 May 2026 00:30:05 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 07 May 2026 18:16:57 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260507

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/917719c412c48687d4a176965d1fa35320ec457c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
