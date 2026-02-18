Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409FA2F12DA;
	Wed, 18 Feb 2026 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406563; cv=none; b=GA+YZ2AQ6kecBXnmgCiVsmlbnT/W7Ec3RdCN3hZGBZ6qF0nxpTDapIABcg/6LriUqAgNkdQr7J9bn7Qcy3XlvVa8f/B62V335fZisn2mV1BFh3DwktrJjFuA910tsfy7obKWrqqmkLBgRyZ9JrNtK4Xy879Xd2xoYYb2hIqcO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406563; c=relaxed/simple;
	bh=QRP7P7HRDTjKaJCK7nZalWkI+8t9AnotE0IPAlsvm+Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iwi0Z/NRxbvtswHBCZb0xDwTmVX2iOWkTMMwPrgFwtsnVZPnHFivrs+aQ2jB0wySp9YzOkexbVakpf0rNBrKDAilmlgROlHe0zM7utw9+dOkRObRjQpYS7wt7SjfOevlxU8q5gAvLzF+d1SSf46dEdBpNwsXVJyUGelYDtoHvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Ws+9EyYY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Ws+9EyYY"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1F5F2206DF;
	Wed, 18 Feb 2026 10:22:39 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5g7Yrxvle39P; Wed, 18 Feb 2026 10:22:38 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 43460201D3;
	Wed, 18 Feb 2026 10:22:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 43460201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1771406558;
	bh=DX/NNPfsIZ+Oe102Ohr9kgE/Q+rSKqtQyPHB3ln9zdE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Ws+9EyYYlL1LR4zicdaAQl1zDc6n39Nh0luR0bmbQ1fg+G7BQLIYcsqW/K/Am9i9X
	 5XTvw+F5X6NDI+OYGxtUjFNhWqdDXi+8+AejjAkAMAOBQ93Zv6eUw+N3cU52mQe+SP
	 Kk4P15i+iv1TfNUY4JjsrXtUseAuAJTWSMDkudXWJI4gmVlz3LNd2tA9Hu7g85Cade
	 7OGfW1IGS2z/69PUZ5PJrFR+1ZIy/6BD+RGs5YQxSY4hp9kb9R3DoNFhwiQi2wyuKr
	 EyNwg6+v7z0iG+zPjDgrzmO6JVA2BgId917gSBsGxERDGBgdh7n2QN7Xby/DlP4YF7
	 2dVMOlxYskL1A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 10:22:37 +0100
Received: (nullmailer pid 3178201 invoked by uid 1000);
	Wed, 18 Feb 2026 09:22:36 -0000
Date: Wed, 18 Feb 2026 10:22:36 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: Paul Moore <paul@paul-moore.com>, SELinux <selinux@vger.kernel.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Network Development
	<netdev@vger.kernel.org>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
Message-ID: <aZWE3F8ppQgN3Gwe@secunet.com>
References: <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
 <CAHC9VhRzRAR+hhn4TFADnHWpzjOxjmh0S_Hg_HktkPkKQ35ycg@mail.gmail.com>
 <74a70504-8ff8-4d97-b35f-774364779889@I-love.SAKURA.ne.jp>
 <7ef21dab-3805-4eae-80d7-9779aeff3f58@I-love.SAKURA.ne.jp>
 <aYmoDwO-YXrc4W1c@secunet.com>
 <85546d35-c7bd-49bf-b0c3-9677bde25859@I-love.SAKURA.ne.jp>
 <aYnDWbxo-jAzR4ca@secunet.com>
 <7c17884d-dbf1-4c2c-9813-0c5369cfdcc9@I-love.SAKURA.ne.jp>
 <aY76t_xYCHmLq6Ur@secunet.com>
 <d20f1b63-714f-48ba-9bee-cd074205404f@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d20f1b63-714f-48ba-9bee-cd074205404f@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Fri, Feb 13, 2026 at 10:59:15PM +0900, Tetsuo Handa wrote:
> On 2026/02/13 19:19, Steffen Klassert wrote:
> On 2026/02/13 19:19, Steffen Klassert wrote:
> >> The NETDEV_UNREGISTER path can be triggered by just doing "unshare -n ip addr show"
> >> (i.e. implicit cleanup of a network namespace due to termination of init process in
> >> that namespace). We are not allowed to reject the cleanup_net() route.
> > 
> > And here we come to the other problem I mentioned. When a LSM policy
> > rejects to flush the xfrm states and policies on network namespace
> > exit, we leak all the xfrm states and policies in that namespace.
> > Here we have no other option, we must flush the xfrm states and
> > policies regardless of any LSM policy. This can be fixed with
> > something like that:
> 
> This something is what I explained at
> https://lkml.kernel.org/r/1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp .
> The "task_valid" argument does not always reflect whether LSM policy can reject or not.

That was to fix the memleak on network namespace exit.
The task_valid check should be ok for xfrm_policy_flush()
and xfrm_state_flush().

> 
> Anyway, the patch to add xfrm_dev_unregister(dev) seems OK if we do like
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?h=next-20260123&id=fc0f090e41e652d158f946c616cdd82baed3c8f4 ?

That would be OK as a first fix. Later we should
just unlink policies and states from the device,
as explained in my last mail.
