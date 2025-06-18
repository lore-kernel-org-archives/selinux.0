Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C13085A2;
	Wed, 18 Jun 2025 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270061; cv=none; b=nBOtBpcLLt0M4GO7wrfNafqeMPd+IY0IFjArPq4uernzKA4bB4vdCYzTn05rSFA7kS/XD6XloDqWIfh9CZfbVd2jiV1IPr12SDFllGpfSUEAkbWCinm7h9rsZsxKzwFgU9FvccGmjWp+qH5UCY+QymAf0Lzy/h0pUfVQ7/8L9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270061; c=relaxed/simple;
	bh=4q4qpoJwHTapwByRbld5mh0ke/Y4FP53Oj70AUCa5bE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y5mtO8NUbQX1MlDxtihxbcmzY1sH4TdLzERsEouwIYNE6RVkvlGJpdebsYwND++LvwdW1OtU6sueMaB2HapMWYCvlcNHGrQFHUu/MVljMgi8SX8gOYf5MCExxv5NCutbffI3JyUN0CQGOW5Dn//Fg6OZomnzzcBOOQACa7OFbfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxYqy/vi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxYqy/vi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6651C4CEE7;
	Wed, 18 Jun 2025 18:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750270060;
	bh=4q4qpoJwHTapwByRbld5mh0ke/Y4FP53Oj70AUCa5bE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jxYqy/viZfy3xwvGXU4ldDaa4IBExQ0CiGle7DTeOPf7gOk/nMY+T2QYGC7pNR2jg
	 L89hD+6Yw2oyySwv4/J/DmuVfj3BeGxhk4N1cbIwOxolsI/ov8phlcZt3G1h6fnCXE
	 aLpeE7mubarw+tgwQhvNt3KyBqAmzdbopVRFdU0fUYeleIs6Ccnf37ZmCi1e3Nn2sy
	 YDuHzLk5tXx2Rei39stVHEFAAuo2hGZKv2wQUFuVBD/YQpnfFfKIlWCvpmAV/iPgEU
	 +P8TZ40nEMiUS5DN2D/CNcmcKeHtogwa+tDMXArDWlIVwwkqr8Sf6c5IMVETsTYp5E
	 t2dh0X9wNKB7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D803806649;
	Wed, 18 Jun 2025 18:08:10 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20250618
From: pr-tracker-bot@kernel.org
In-Reply-To: <5894f2f11a7a4741ba0279c703160e82@paul-moore.com>
References: <5894f2f11a7a4741ba0279c703160e82@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <5894f2f11a7a4741ba0279c703160e82@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250618
X-PR-Tracked-Commit-Id: 86c8db86af43f52f682e53a0f2f0828683be1e52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5adb635077d1b4bd65b183022775a59a378a9c00
Message-Id: <175027008888.206233.13361756418006863178.pr-tracker-bot@kernel.org>
Date: Wed, 18 Jun 2025 18:08:08 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Jun 2025 12:34:38 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250618

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5adb635077d1b4bd65b183022775a59a378a9c00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
