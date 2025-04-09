Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD95172767;
	Wed,  9 Apr 2025 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206592; cv=none; b=W0LERsmoTTw1d5HcQ2lI3ZmA9rmzYrk6WX7BIIxwQEA61+hSzxVRlSvlszhmGQVQsAJYGpU4P+TiLleMth5M4veWpLoS5lw5HN3HvetAOQAmvzU3uX5vd4MA/VYZt0sm5TlPd/G+Pua/0kqM3s/IC5ZEguTfshjEIwLFZ+KwoRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206592; c=relaxed/simple;
	bh=OYf0UFBbqCo6CLjwr/J0wXSIXXNTgsDA387uekNdmbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmT/2/CeGgyOk69sxdJ1qajyjbkVI5VhMG5xrZuKZm+5NuojkMz7nHN+0c2zOOAVboSwUkTgwvrV/NlrR0v71XbSKUdgmNjzKtTK2dZHggahUq5oyoVwM90YVkRJpXZFNJFmoEb5liwBZVGC6xxduoRfKfFBLCRG6Hs48iWMsl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVSQyr4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVSQyr4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1401C4CEE2;
	Wed,  9 Apr 2025 13:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744206591;
	bh=OYf0UFBbqCo6CLjwr/J0wXSIXXNTgsDA387uekNdmbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cVSQyr4BdDbHE8rV74/CAaqbtv7GyM+/pVrJwUzI4IqJzZAF66B+gmUBYt8a3/RQM
	 IiHpKUggEXL90TVqWcy9UBD9aSESTsdZ97ir4BhqBMa7fk3Tb18I4mVpNW1yx3bLLn
	 HycTOI76+iw64G6yLcP3yjt7JiWUMftkKEw2UQhzG8dzMepKVIi+vTIarqnmeNCgpI
	 JgxTG86DF/s3Nt1vxrAZKJ1ni2Kxk659yUbpBCCbJLBicWnSVNWjxIMhMA6H0uzrB6
	 ZLvcaPo+Au4Z9pPM//ub6dnTbFrBB4FCOcIVzkM7CN2ZS8aQh+FSrRgqX10ca86KwZ
	 xMpsL0zjQ17cQ==
Date: Wed, 9 Apr 2025 06:49:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, "Neal Cardwell"
 <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, "Pablo Neira
 Ayuso" <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 0/4] net: Retire DCCP socket.
Message-ID: <20250409064949.6c992d15@kernel.org>
In-Reply-To: <20250409003014.19697-1-kuniyu@amazon.com>
References: <20250409003014.19697-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Apr 2025 17:29:07 -0700 Kuniyuki Iwashima wrote:
> As announced by commit b144fcaf46d4 ("dccp: Print deprecation
> notice."), it's time to remove DCCP socket.
> 
> The patch 2 removes net/dccp, LSM code, doc, and etc, leaving
> DCCP netfilter modules.
> 
> The patch 3 unexports shared functions for DCCP, and the patch 4
> renames tcp_or_dccp_get_hashinfo() to tcp_get_hashinfo().
> 
> We can do more cleanup; for example, remove IPPROTO_TCP checks in
> __inet6?_check_established(), remove __module_get() for twsk,
> remove timewait_sock_ops.twsk_destructor(), etc, but it will be
> more of TCP stuff, so I'll defer to a later series.

So it builds now but appears to break 1/3rd of the selftests :)
-- 
pw-bot: cr
