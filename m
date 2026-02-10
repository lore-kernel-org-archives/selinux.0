Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B1926C3AE;
	Tue, 10 Feb 2026 00:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684615; cv=none; b=XMK5mmF+QkesVAqyWMjFmXV/+gOJfax0LP3fD4m78M2osOR0WPmE9nFrYvGHmbywylZXpk1d/OmjJR+bhPI96wqwizjiHu7viK+SIDK+8XAjEbPI3Llr2LHdLhK/c677KLEYVMy361dzExOQomDY5WjZY6WY6XxAgk2Q/sT93qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684615; c=relaxed/simple;
	bh=9Eh+a6d35MP5Wq805wcryucwLLDyJpIhFEjQO5H/5TA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KZSw0LUKlFcXa0HNF/DKzBWMqEnJa2cxyRGxDp7Q4wmSVj7r32JLveM7wiQs6bq+FGcbLeYIiZG2edyNdZI3pP45eS8EWJlICERIF3HvKH6CcSw0Z43UzWk6hfve/AFE0MyVN7BikrMhdYEExY5BIzLXN61a9t897RFf2cKNBBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb+D4EnM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb+D4EnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3E8C19425;
	Tue, 10 Feb 2026 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684615;
	bh=9Eh+a6d35MP5Wq805wcryucwLLDyJpIhFEjQO5H/5TA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Pb+D4EnMThIFEPQZiUFqQJJRij2rzHjqfX+0SEZM0zzFMReuN8/ZMHxcEFnMCVcvj
	 3aVYzt4qJW9rfpwff2E0j60+KvRRYX1tQz2Ta9KP+GBSTE6KvEbHgJ2hlwpLU/JqfS
	 sKf0HePbSa9mjZXoc+EHwm8r7FhnspUWJDLl5sEiuNYVghqie0SlmYfJKKDNzHwOXP
	 L/sqqZahVrxxw8o28x6CgRJDfh6RCv7i98n9J04S/WSS3bRIuxUotmHD+077lleFIj
	 X99GNcU08j85tHPkLVXmwBDkHJLCYnbFCNPm09TlfOgQXuyNNRfbUqOqE1Bjoci2t+
	 L6fm0HQAujkAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 22D2C380AA4A;
	Tue, 10 Feb 2026 00:50:12 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20260203
From: pr-tracker-bot@kernel.org
In-Reply-To: <74f395ba13926ab0391bd8714abc6036@paul-moore.com>
References: <74f395ba13926ab0391bd8714abc6036@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <74f395ba13926ab0391bd8714abc6036@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260203
X-PR-Tracked-Commit-Id: ea64aa57d596c4cbe518ffd043c52ef64089708d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6252e917b9006dfa2f3d884fe0dbaf3e676c4108
Message-Id: <177068461100.3270491.3095071738038495587.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:11 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 03 Feb 2026 23:10:38 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260203

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6252e917b9006dfa2f3d884fe0dbaf3e676c4108

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
