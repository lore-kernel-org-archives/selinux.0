Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4276BB5B;
	Sat, 12 Apr 2025 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744427396; cv=none; b=hm2+HB0Rmo/bDT3SRYJd5eu86XDfN6LJfV8Vg1KyGoyyw+cyp2+4CNzy9vzS5s8QrlRc4uJ6ijLkFUxCIh9Yd/iu5fBthXPWxBFnobXMvl+EKoCszJ6QDB6avTGm/nUVQSSnl+vdbPIogXsp7qvd+WeQRFLJqcVtYvK+V+2H40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744427396; c=relaxed/simple;
	bh=CBeENBrTVXW0PAsUf92hhmnrDnQcfKlRF606weSY6N8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eyF2VcJodKdgVd5pFhrabXeQxGyo0o1nDLTY7KykE81yvhpvQPDMqjyauV6LFbgYRJIGHvwF9nhyZZmr1jqwGwByX3UtwNvuDIEivG2+AHT68ZWRjcOhbuRpypxqFg4v2fWIDh7ct4gg3crhPm6Onv8FW4moH8TU/pqkBOpG4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRojthLl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRojthLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6DCC4CEE2;
	Sat, 12 Apr 2025 03:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744427395;
	bh=CBeENBrTVXW0PAsUf92hhmnrDnQcfKlRF606weSY6N8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FRojthLl+tUoNV5WBP+azTBzU99ED6vtIVZHeU2lzXdHWxyNZJvRi8Y2QYTDBBmsq
	 LrEZpOms1WTAvvjNaxVRNlBv++EnjxvcjkLN3JhgDduTR2040SuOIntwif6aMajFVN
	 ZGtonK1Rv9UtOf4tewN3V08z4CnyAVbtH4SDjnq+nMya4lvYHQvG6CWuYJUoPnhetZ
	 gBXTfPIyra4cFH/xcaA29tBEkNLNlCpy/SQKuGtV7GKD0Hq8sFB+Lp56pCj+aQ8W+q
	 LHL4WZD4R3KEBA6WCYnac01cP2V5ZUm1snjzK3Npyc1YkgqqnoCmQHs1wbwrwHamX8
	 n2oU+ZTWsDeUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3422738111DD;
	Sat, 12 Apr 2025 03:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/4] net: Retire DCCP socket.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174442743301.560477.12051877102722069656.git-patchwork-notify@kernel.org>
Date: Sat, 12 Apr 2025 03:10:33 +0000
References: <20250410023921.11307-1-kuniyu@amazon.com>
In-Reply-To: <20250410023921.11307-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, willemb@google.com, pablo@netfilter.org,
 kadlec@netfilter.org, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, casey@schaufler-ca.com, kuni1840@gmail.com,
 netdev@vger.kernel.org, selinux@vger.kernel.org,
 linux-security-module@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Apr 2025 19:36:43 -0700 you wrote:
> As announced by commit b144fcaf46d4 ("dccp: Print deprecation
> notice."), it's time to remove DCCP socket.
> 
> The patch 2 removes net/dccp, LSM code, doc, and etc, leaving
> DCCP netfilter modules.
> 
> The patch 3 unexports shared functions for DCCP, and the patch 4
> renames tcp_or_dccp_get_hashinfo() to tcp_get_hashinfo().
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/4] selftest: net: Remove DCCP bits.
    https://git.kernel.org/netdev/net-next/c/b2bdce7adc90
  - [v3,net-next,2/4] net: Retire DCCP socket.
    https://git.kernel.org/netdev/net-next/c/2a63dd0edf38
  - [v3,net-next,3/4] net: Unexport shared functions for DCCP.
    https://git.kernel.org/netdev/net-next/c/22d6c9eebf2e
  - [v3,net-next,4/4] tcp: Rename tcp_or_dccp_get_hashinfo().
    https://git.kernel.org/netdev/net-next/c/235bd9d21fcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


