Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7911B0F0D;
	Sat, 30 Nov 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733003420; cv=none; b=INCgaO6weuPmViiKFxO2n6JXQE0zGNFUB2mRuY96JWU67vJORCchppLDB3ubCgcTAkIAs7IzyvDl8ahHuWSVtIFoz+4ZybJW2ey02jtgx5qs+lG2QuGtQ+79H/MwJC23l74il+e8rHEhVwnpETmwxtbWqiC1B2kFxoCDeVQDfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733003420; c=relaxed/simple;
	bh=L5NMkdPfru4nikC/duEdmEfBroExYcZtiGQcQ078vUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j+MHI/AIbRc878x6BdY50oOvQGjAEAuut1rQJqRfoXWLV3v+EACDPXOHbfQt5MbZMQV4v1uEETwsxaLGZkedQzsmYIKLOZcocfrR34OWqZJ1eB9Tx4lnUj0pmgOanEpTx+wVEsgyujk/MFA1r50emeg6TMtvdjV/xYogu5pwwx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2o91f7I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2o91f7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19770C4CED4;
	Sat, 30 Nov 2024 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733003420;
	bh=L5NMkdPfru4nikC/duEdmEfBroExYcZtiGQcQ078vUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K2o91f7IWVZD9WmHCJ0rhtqHQ7veNc7y8WKM7P4qiQAdq3FqPq+RoUywMQLJrb77Z
	 Nr3tWjhOSr6AGPhbO/TrouGfrMb4kijEKteEa8TpGUbp8K6tkjIJPVwLkEVwura48y
	 NlM82o2NEOpg8Q2E9do/35oJPIZwTbzs3hVF33YQZ/7dM2BjyyLDETWcH8jUQ4vInC
	 R5p+IucN0tjJux2kbUm/DEMiwF2dXWdVpsnSCxdpMAKm7luE9l1trn80UPHXruCUn3
	 JiZksrSmQLfGBO5J7Pba5fcWyQes/xEogilE9oZm6w84KTi5pVdMAvu716MWMig+to
	 pYAwLAOl3ccNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF2D380A944;
	Sat, 30 Nov 2024 21:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selinux: use sk_to_full_sk() in selinux_ip_output()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173300343374.2487269.7082262124805020262.git-patchwork-notify@kernel.org>
Date: Sat, 30 Nov 2024 21:50:33 +0000
References: <20241126145911.4187198-1-edumazet@google.com>
In-Reply-To: <20241126145911.4187198-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+2d9f5f948c31dcb7745e@syzkaller.appspotmail.com, paul@paul-moore.com,
 stephen.smalley.work@gmail.com, omosnace@redhat.com, selinux@vger.kernel.org,
 kuniyu@amazon.com, brianvv@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Nov 2024 14:59:11 +0000 you wrote:
> In blamed commit, TCP started to attach timewait sockets to
> some skbs.
> 
> syzbot reported that selinux_ip_output() was not expecting them yet.
> 
> Note that using sk_to_full_sk() is still allowing the
> following sk_listener() check to work as before.
> 
> [...]

Here is the summary with links:
  - [net] selinux: use sk_to_full_sk() in selinux_ip_output()
    https://git.kernel.org/netdev/net/c/eedcad2f2a37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


