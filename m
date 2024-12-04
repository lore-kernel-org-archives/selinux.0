Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC17F9;
	Wed,  4 Dec 2024 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733273754; cv=none; b=IWHO1NRzyHt9c8p+sclqLvxs7wTm+kFyZABrrLdVQ/ZmAYEOrjH7gWmosDn6VEqWq0SRkB8MXfg1jJgrLYXkFepcDbU9TrGquGX7t2M232hoSG9Hi/qV3byuz48JwI5NSzW99dt794RY9x1rBmCAF9J2/8mvqhMtxQaipYSwZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733273754; c=relaxed/simple;
	bh=VoiVy/YggsyxE8Q9d5aC0EsZoTIb9mFcAscWf9rm1h8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrkAFUmpqAiAh+5uxNEAdyd4MPc/+j+svTAXvSV2R5BuHYJgAiBqC0vE42iwnXfI9PoJe9rAif74gUsxqw06LxV/p6mhXcPSuXaDqh2QPeELdymJwtTx7rxmug4kYqY4oSaafrG4HJMHS5SxpY8MdOEZ96wBB5yf1sxYqEKbupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IauoFxdK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IauoFxdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66258C4CEDC;
	Wed,  4 Dec 2024 00:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733273753;
	bh=VoiVy/YggsyxE8Q9d5aC0EsZoTIb9mFcAscWf9rm1h8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IauoFxdKBgckRWMimIuEJ3aaks3OeF9XRd3tZ689vj7EGe7WKIP1N5x/15jUNhcH7
	 gP/6PBIAgFcI4Ur2IVJnxqMy0qPn0cxUrPCJYIdGliwxbYYNZBBuLP9ywZUtVGxnBR
	 ZpB1fpZCaGfLT8bmUpHGc48oYhBiUKit4M3aEStqLvDO+EGwqUuu4TGt3HIoalsm4N
	 QRhfDyiKO+weHvX0/35XI5ABxLk9XYSp9EN0Ny6wBaeobyARYfr0wAgsXwxZ3L1PJi
	 //ifysel+iL0klQ7CrCxlOd2DCgipmH3qK0SoPcbt9gA3VFP7gxzIjAUW8v5DEBM4D
	 83gms16v05lWA==
Date: Tue, 3 Dec 2024 16:55:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 pabeni@redhat.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+2d9f5f948c31dcb7745e@syzkaller.appspotmail.com,
 stephen.smalley.work@gmail.com, omosnace@redhat.com,
 selinux@vger.kernel.org, kuniyu@amazon.com, brianvv@google.com
Subject: Re: [PATCH net] selinux: use sk_to_full_sk() in selinux_ip_output()
Message-ID: <20241203165552.07ba0619@kernel.org>
In-Reply-To: <CAHC9VhQFEsPfAZ2MLw7mB7xwOFHPA+TXf9fv9JQDMEFfsZDWJQ@mail.gmail.com>
References: <20241126145911.4187198-1-edumazet@google.com>
	<173300343374.2487269.7082262124805020262.git-patchwork-notify@kernel.org>
	<CAHC9VhQFEsPfAZ2MLw7mB7xwOFHPA+TXf9fv9JQDMEFfsZDWJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 15:50:46 -0500 Paul Moore wrote:
> > This patch was applied to netdev/net.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:  
> 
> Jakub, do you know when we can expect to see this sent up to Linus?

If I'm looking at our schedule right - Thursday (5th) evening EU time.
