Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127164;
	b=HQqAecABB6eEBCDsRepiJgjvl8dbe95JKUc7I75/s1GVA8llOstLexrJb8qpMhxAiRFv
	 LeQ2YlSY3r8xef/jYR9wuMVeGGPmvfG4lHvySzAJU/IQgdGNp1XU0qhb1mYCN+jk45LVj
	 6LujYcDBStqLDwDBCiA0knjQHe/H0f/Ap58aE4LaIuFowKdXu0HpW2P7VcSEa0z0AeR6l
	 CKCw0BYS8rWkPyhIm/5GjooJf2+dVgTYSa5QjECvPKzybNXjEfm0s0WAfoFzxByq88y8D
	 DRi/CepKGt+Vxqz19ahgf1b4afMWHls++c+zxRgbIumzrEO0EV3ggqVPIE75trkQA2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127164;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=jYvJawoY4X4i7qPPfWvHkIeGcb66dRvIHLWCzZKVIJs=;
	b=WkSWTgHn16OpW6K++t7M7zv1Z+KrUeOPOQ7ZE0kUxoBtK32S5wX85MICypGH+FiMOh5J
	 Mhb9XAQKwL0PaaYBs7g1wXpf5fKkIpdcJnXzr45rUI6nFM5UyL+rfs4JhfN9hMc22KGgd
	 ipHvQLhLW86s2SMN42YUT42arDRTPqj/pJVI9fpjqboZxNCTyvQwpRHy5yhE8QttMYAK/
	 pBc2n4GscoB4xNH3Z/8SMFFfu6ZBD159ZNBoMcyQIOWIIWNerKeP2nKOFxKeM487qMzP7
	 4K/x3WaF+rdZvbqyi618Bz3wQHNfQV9FE92rw9n6QRR9+TvvmzNICmwt3r1yASFFjpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Txrjvwd0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1F606A32A;
	Thu, 19 Nov 2026 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Txrjvwd0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430B31F000C4;
	Thu, 19 Nov 2026 22:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127164;
	bh=jYvJawoY4X4i7qPPfWvHkIeGcb66dRvIHLWCzZKVIJs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Txrjvwd0qt91YXde3Zj4zDCt4m+pUk/+uLdhUv2Qh5MD2ZkOVVWjqDls3MwiXtMxi
	 02jQOtRMc0fXFK5CXoBCv1lguv0c1z7Yikmv30w2D93/uH+67b4d3bqphFiTRYkDQu
	 aF9ybE5fO9UhmSv6b+DUT78VAvNsRIAy1J9+pIaNOiDh2iEU7o69mpSQFdoyJVPD3t
	 1HWzDhdkck546EzxiB80qhF3ordSgx2c1lTJXyzlVbGIbRmWn/ZOD/k+zSfVGMWYCE
	 nGy65EeuLoQX4TQjQxfjU+qKipn/H+i4PqRHG0ndOQ5EiGJQzM4O7cGef0TsjcTPOu
	 P4PABCgGBVu6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A5063808209;
	Thu, 19 Nov 2026 22:26:04 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20261119
From: pr-tracker-bot@kernel.org
In-Reply-To: <d583b944b32f1a6f9bb27005d628ba9a@paul-moore.com>
References: <d583b944b32f1a6f9bb27005d628ba9a@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <d583b944b32f1a6f9bb27005d628ba9a@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20261119
X-PR-Tracked-Commit-Id: beb0ae6bcd7505e2e61babe5d98a8dd3b3f03c7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65e4fd942f72a9dba0e4e257290c4fa1aa756854
Message-Id: <179512716269.3897686.4271920883163310731.pr-tracker-bot@kernel.org>
Date: Thu, 19 Nov 2026 22:26:02 +0000
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

The pull request you sent on Thu, 19 Nov 2026 16:22:18 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20261119

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65e4fd942f72a9dba0e4e257290c4fa1aa756854

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
