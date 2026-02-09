Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A2363C75;
	Mon,  9 Feb 2026 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629141; cv=none; b=LNeC7siF8h8f77mLK/6j8j0Qub+sliet+57yXegvP1xsFV1QWcd+o0gbEHJQIcB4o1DLWjmxmbNZIfYsgdNG/KJ9Vdnmf6pY6BzCq+p3bqp4vDz35fzKw1xPANOdlHij/mwXrFUqmd4bzV79mlYD5FOruuzicraomsS4Im/9Xuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629141; c=relaxed/simple;
	bh=05K8TWV9dpvcJhZ2rqQO6azRpczq1hfALsFzwpyjmr8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gASh9o/CqBrzoiwxSj3VlVB19xc5lABdyk5Vvv3t+raQSPF90eHCBGD1xMFMI2W4kND/zT6mQnopTKnx2Gz/zzrpOcGzdqJIznHVHYfe4xtso0l5VyMifVs8DLsbH4YU8KwDKjUwnXA4eBHdCl8lzpy5MR179VeQbRDiNGsVJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=WGTOzOTv; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="WGTOzOTv"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EB464207B0;
	Mon,  9 Feb 2026 10:25:37 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WzmFvrKXPlOt; Mon,  9 Feb 2026 10:25:37 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1DA08200BC;
	Mon,  9 Feb 2026 10:25:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1DA08200BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1770629137;
	bh=X8/Gkp4jZDTvQCCNExEJYRQtaBUiRVRdsdPll8FLG5E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=WGTOzOTvIqFfkq6uXmajzatZtPH0eWqzvl0/OQnkKEsAbhOcZcpGppRlEsHigC11K
	 rD4EtmGnQj9tOJKQ7VygO85RK0KkvOtwA3Zh5af5TSkq9lXYMXXQ0Cbor+4ovidkbs
	 Cbf7fgQBWkMn4eiGhA5jphv6zL8IJP6GDSr2zfuvmxC34wP6+5tcHx/dor9NjxwgbO
	 H5zt2EK8r9MGuyj/aElM3aLpwyN/qnwmzY4XmQFH5zPu0BTXyTlwnb+eIyrZjUHCQG
	 +t6154sMs5716nE05TuRBl6WZakJbDlJ0n98o8FrvItQHcck27HnXTQNriXH5AB0PE
	 WOiBlrqjwvLjQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 10:25:36 +0100
Received: (nullmailer pid 1423521 invoked by uid 1000);
	Mon, 09 Feb 2026 09:25:36 -0000
Date: Mon, 9 Feb 2026 10:25:35 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: Paul Moore <paul@paul-moore.com>, SELinux <selinux@vger.kernel.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Network Development
	<netdev@vger.kernel.org>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
Message-ID: <aYmoDwO-YXrc4W1c@secunet.com>
References: <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
 <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
 <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
 <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
 <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com>
 <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
 <CAHC9VhRzRAR+hhn4TFADnHWpzjOxjmh0S_Hg_HktkPkKQ35ycg@mail.gmail.com>
 <74a70504-8ff8-4d97-b35f-774364779889@I-love.SAKURA.ne.jp>
 <7ef21dab-3805-4eae-80d7-9779aeff3f58@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ef21dab-3805-4eae-80d7-9779aeff3f58@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Feb 04, 2026 at 10:57:30PM +0900, Tetsuo Handa wrote:
> On 2026/02/04 19:15, Tetsuo Handa wrote:
> > On 2026/02/04 7:40, Paul Moore wrote:
> >>         This is not an unusual request for such a proposed change, and
> >> is something that I would expect a LSM maintainer to do without much
> >> hesitation.  If you are unwilling to investigate this, can you explain
> >> why?
> > 
> > Because I'm not familiar with how XFRM works; I'm not a user of LSM XFRM hooks.
> > 
> > I can't judge whether the current code is COMPREHENSIVELY GATING;
> > I can't imagine what the state you call COMPREHENSIVELY GATING is.
> 
> Steffen Klassert worried that killing xfrm_dev_state_flush_secctx_check() and
> xfrm_dev_policy_flush_secctx_check() might violate a LSM policy and you agreed
> ( https://lkml.kernel.org/r/CAHC9VhQ54LRD7k_x6tUju2kPVBEHcdgBh46_hBN8btG0vhfy_w@mail.gmail.com ),
> but the reality is that nobody in the world has enforced an LSM policy for almost 9 years
> that makes xfrm_dev_{state,policy}_flush() no-op. That is, xfrm_dev_state_flush_secctx_check()
> and xfrm_dev_policy_flush_secctx_check() had been effectively unused.
> 
> Killing xfrm_dev_state_flush_secctx_check() and xfrm_dev_policy_flush_secctx_check()
> increases "system's stability" without sacrificing "authorization".
> 
> It is up to SELinux developers to discuss what actions to take as a compensation for
> killing xfrm_dev_state_flush_secctx_check() and xfrm_dev_policy_flush_secctx_check().
> The compensation might be to add LSM hooks to immediately before the point of no return.

The problem is that, with adding IPsec offloads to netdevices, security
critical resources came into the netdevices. Someone who has no
capabilities to delete xfrm states or xfrm policies should not be able
to unregister the netdevice if xfrm states or xfrm policies are
offloaded. Unfortunately, unregistering can't be canceled at this stage
anymore. So I think we need some netdevice unregistration hook for
the LSM subsystem so it can check for xfrm states or xfrm policies
and refuse the unregistration before we actually start to remove
the device.

The same happened btw. when xfrm was made per network namespace.
Here we just leak the xfrm states and xfrm policies if some
LSM refuses to remove them.

I guess we need a solution for both cases.
