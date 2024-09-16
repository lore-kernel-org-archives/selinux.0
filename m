Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3A1662F4;
	Mon, 16 Sep 2024 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498802; cv=none; b=cN+1JjcH8Cl4MBAR4+HCfLOcsZ4gt6zhIEud/OtSy4AwDbouaXq0mjhv4n6myHE2DnEbZSEWvmvwI843iMd878Erarlk3lCK09pT757iLV84uaGwljd4vQeCGZMp9wReqY5PdZpQNb1hqSv9SC7lLVuUM5JWE4GcNiuaAXAF9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498802; c=relaxed/simple;
	bh=pd35wtIgtW9sWAca+92EE7xKAeRwkY339b3PaNjTJNo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nEyYmrDk2HeRKnTZb6dGraVFINqwCEVDZv2/bi0+I2NF2oQVVvAVy+PyBH43kzCBDjk8pFUfrwgpgJ2VyLdwi5FhaNVEV3WxgeUnmd41Ok0syxfdV92sB4QBMl6nkz/7x9zzDTBIOPCaOtl+9R8ZLJHttHzBCwIO5PKDsh0JVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sw5Eyzto; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sw5Eyzto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF13FC4CECC;
	Mon, 16 Sep 2024 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726498801;
	bh=pd35wtIgtW9sWAca+92EE7xKAeRwkY339b3PaNjTJNo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sw5Eyzto0Zu7okM9LDGtnrshvp6oGPMWQmgEaNt3DMbiP/jme4DvxHKImsfpGDHld
	 Oy2/GmYSx6oPm2gHNDpwLa07YBAjO0o/bL+cKGfLcONJoJkbOJf3rlG4GKueLHNytS
	 g6Ky1g1KrqQ8Kk4tdLcI2V9dKnPYh8hXtVFYuMC80rL81UMDL+ZTTlsmp/TPrGYGgU
	 6/blZqnrUlwLdS2SMlkwhk4T3Q0PP4blzjaWZx773yClk87Tr67NpIGj4EEZouqdPz
	 NBCZNUsdh7341xPCTn/EWTlOeZi/qPbmX63+sUqfq4KhOHUDKMp4IKNPuN+T1ePBUc
	 0fAgitLEux8MQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A33BF3806651;
	Mon, 16 Sep 2024 15:00:04 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20240911
From: pr-tracker-bot@kernel.org
In-Reply-To: <c6139509267be86f56f189c243d57426@paul-moore.com>
References: <c6139509267be86f56f189c243d57426@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <c6139509267be86f56f189c243d57426@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240911
X-PR-Tracked-Commit-Id: d19a9e25a722d629041ac8fd320a86c016e349d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8
Message-Id: <172649880347.3724525.14889475854046218235.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 15:00:03 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 21:18:33 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240911

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad060dbbcfcfcba624ef1a75e1d71365a98b86d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
