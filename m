Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587CC2E7375;
	Sat, 11 Jul 2026 03:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783739300; cv=none; b=kJaaLhdPQ1Bkk0w4W5Efy5LHUoEUVzPQo74x6c9A3ASX788fMfvcaUk0vitpEPuJkAhF5NAIN9ml4kPw9BPS2/3LO/6eyh44jK3xzuVD4V8eNA5NMkKPyF1nJ3RnQrBizJe70lT9jnyhd11Uvbu9qKDlEftwfCXYdlFHMVPDXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783739300; c=relaxed/simple;
	bh=Litk8NMwV4Q/HO4dkYkA8QydvWD+A+hdFXnJvEuJVQw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NVT3X6oe2qv0GZoEnuvRkmdWCYvM4hai+fTaZh8/mliA4PbKAYOuVmQl97nXR9LOWmEbfCblGZzFjK4piVL8D0We54/RsFPXwW9YjYBHcVIC2SjlVRE/sCzl7dwf/s2JludGsiIsav8XH+m5CEHxrV570T98D5uLmLi0Z1fcISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy0wzhn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy0wzhn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4008A1F000E9;
	Sat, 11 Jul 2026 03:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783739299;
	bh=yO/r0Ta+1EhReojApMPg2eb7MrDAvPyHCpvZeay6YHw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Yy0wzhn4Ge2I72m0aweu+sdibzcMj8XtWjCgdmUnFzXrPsJ1ZLodFa2Jj7JQbZS+Z
	 ne61XER6isXeleeTqUwKrOMnP1WoJFjq1oSudwS5yKlG7msnLuaMpJeQanXgMSuTYG
	 qKqO79c19+R/bXFDs+MziI7tIQQkfQVpUpXjRSmAhN8As5w0tw30talxHAKAOaAD5o
	 EuSKqF13mHngNNkaRk5/MDVvUUaecXZ8wVAHBRkZLeh/4MOxWP4SxqsvteVlxJyf9+
	 Q14DtZTcYt1HJQPPdBbjS+jchd54C0JKcFEhzVJIRBRMJSDtNgpFj8k/W0dtyVppWG
	 M/EiTFPExbSkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A5639244DF;
	Sat, 11 Jul 2026 03:07:57 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20260710
From: pr-tracker-bot@kernel.org
In-Reply-To: <44e0f55f936543053d657f0a86a53bd9@paul-moore.com>
References: <44e0f55f936543053d657f0a86a53bd9@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <44e0f55f936543053d657f0a86a53bd9@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260710
X-PR-Tracked-Commit-Id: 56acfeb10019e200ab6787d01f8d7cbe0f01526f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccce5f6e7c86f103d76534e2d06d1c903dce551c
Message-Id: <178373927650.966321.14658904809038334287.pr-tracker-bot@kernel.org>
Date: Sat, 11 Jul 2026 03:07:56 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Jul 2026 15:13:45 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260710

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccce5f6e7c86f103d76534e2d06d1c903dce551c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
