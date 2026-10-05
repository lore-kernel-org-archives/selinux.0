Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4784AD4CE;
	Mon,  5 Oct 2026 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211307; cv=none; b=L9cwn7BUmExP2evRpIBCsdWwkYc//vczyrDKKYgVKfDYPfs6g3xd7c+2CvBs08WmtNYrMDS7sFXH1lhjnAq2wMJP/XF7RkolyiEqLp+N05CybBrE9gb3D7BBa5kzvy13BSNTpF4GQpzjWfTRXUSm85dfH5QU1oqAuq1BiBZm7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211307; c=relaxed/simple;
	bh=RYBl9DHbzxDIIVCG0b2DhOXUs4OzFpKYZxTKUKVF2SQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bteLqqSHu4AQKnbqcKEm1RzRpqsUI5UWXTSg9/mtSIkRIvjUfCTWoXsG4n+g36H7Ms1QhbbKPyRdnGzlFbvqw6ZaWGnVvc3224dXaOEfuPjQdkhGHk4b2ijl6vkEo2iyXHLnuCHpLeIaXlBwYOJ2twrToK2YpAsN0IXFZfWR24I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbaNF2Uc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbaNF2Uc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0870A1F00898;
	Mon,  5 Oct 2026 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791211296;
	bh=i6NfVH70KDlIyGbVleA3hrHcNJmSl+/lLLi8EwhOh1A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=WbaNF2UcMAyQ57jKQO4hl2P8hOpY6jlmHMGuQQeQjtgw6xpcB1MS7BSIyEUoplmbo
	 BbHk1eO5jUtfQEHvgzu1tLdDQ11yAHhCHui2eGJ35RL4ARzo+XqWwuwolHR9YwSVgn
	 QxPOgy8yOYMuEFt/xojk2UxWywH6f+vr4DcI5vmOPoco0KX7YkAF9E7cK/h6gWurmu
	 VzrnOlQS4YFp86h6anNiFdpgvHDCCG4LazPrp0L3QfxIicclDNPslcqQ48bpOvZjcv
	 isjAplhcTHqHPxEQf4r+4/fvOvV9vjtVmZIVNZ2Ib03skzsEnsXvW/HfzOUDrVSzbU
	 0YF+yNdmSnsgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F17A33926397;
	Mon,  5 Oct 2026 14:41:35 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20261005
From: pr-tracker-bot@kernel.org
In-Reply-To: <32b99c092d7a668f114cecb3ecb22c28@paul-moore.com>
References: <32b99c092d7a668f114cecb3ecb22c28@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <32b99c092d7a668f114cecb3ecb22c28@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20261005
X-PR-Tracked-Commit-Id: 28b7260548af3d35773477993ad4e4de41578dd7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67f0943b394d920b6c142aad8c6af94340342ae7
Message-Id: <179121129454.1756535.611921338429434341.pr-tracker-bot@kernel.org>
Date: Mon, 05 Oct 2026 14:41:34 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 05 Oct 2026 06:24:05 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20261005

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67f0943b394d920b6c142aad8c6af94340342ae7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
