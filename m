Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CBB1BF2F;
	Wed,  3 Apr 2024 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712114163; cv=none; b=kruTPF3MZaJo0DxsHTCaW6VZqaEsLeBiW1IzInhOKjkR4WRURMbv/t8/Hh5ibV6dCFLxEokuYbAOEos+5MIpERVZYjuIH1ntAmkaYhAYGoK+G6D8wx2+NPAq5QSM/DzLs5/BSeF7/h2YVdwsCbLkMjdT7zhqqW2IQwuqb3gFQ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712114163; c=relaxed/simple;
	bh=bMzr4KHa+nmRRnhUTLpVtPbUCZRPUPjWOldS+v4Ff88=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B2vVFbS2peK3IKq2i5eDfx07ROBVviOjpkdFLku3i5xOsWzFms3SeRgnYT5W4Csp5MxxNNArvLdOLOPxZr4J7dYDPXCKCmcdU6oNQnok8G2GhdM36/2fbI3C/m7U0Vn5CXw9LRZwD8hj7/mAnB/B3LTCs4WxvjsbcC6E1TQYf5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+7kBdTo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+7kBdTo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E99EC433C7;
	Wed,  3 Apr 2024 03:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712114163;
	bh=bMzr4KHa+nmRRnhUTLpVtPbUCZRPUPjWOldS+v4Ff88=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K+7kBdToKbtsIsEALZzsy6IMFoApXrs4+RvmteShRsDoidyHwX+WQ74oPsmlHRNYk
	 tyVLPbcClVXNuItTAg4Klq25qH3OhQYGscl0b4aW64ZLlKc+pfmgtJoX4U1TE0ID92
	 jFIdwYw81kVh5HjMjaFGE/qoY1e0a32DdgUnUrT59Md4um1y4meHSVuPgCrMsBols+
	 P9/7Nk1JBhBXIk/EtkyJ0ucR9FKOHgpM8EKSZKGI1FNTE00x7dri55MgxiPhZF0sQz
	 2+tDdlMRIVBMJ3r4RDLSnzHPdCnL9otE9pYXmBJmE6E+jW6NeztWTc/Jko44bYsM2v
	 9D+kq4tUzwN1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13823D9A153;
	Wed,  3 Apr 2024 03:16:03 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20240402
From: pr-tracker-bot@kernel.org
In-Reply-To: <cf11f516883d7fbf75a34f7981174e73@paul-moore.com>
References: <cf11f516883d7fbf75a34f7981174e73@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <cf11f516883d7fbf75a34f7981174e73@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240402
X-PR-Tracked-Commit-Id: 37801a36b4d68892ce807264f784d818f8d0d39b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e92c1e6cd876754b64d1998ec0a01800ed954a6
Message-Id: <171211416306.5415.8875759484655659073.pr-tracker-bot@kernel.org>
Date: Wed, 03 Apr 2024 03:16:03 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 02 Apr 2024 23:11:46 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240402

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e92c1e6cd876754b64d1998ec0a01800ed954a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
