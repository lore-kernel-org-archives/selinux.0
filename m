Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74F2331205;
	Mon,  9 Feb 2026 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770636128; cv=none; b=pJ0lqgP6KwiQMwOQUEvDs2M68jez1SSqOEsDHM/1ByQX2UHYbCbtgeoYysLQBUQDtrB5x/wiB43fSzQaaeJx9irx3R0Fl9PKTs89ftBSZvs+TvFLhzeUir3yEe3B3Dzcnhhpy4ZJ3/yGDpTfPCfV3Rj43T3tSXxyaI0gyN4np9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770636128; c=relaxed/simple;
	bh=/4vP3oQ0KZ3dUwcxXnlCQqQFTAUTGZpSvH9ZWjuUv4w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReOc2GFZMmkAldXL4J7n25eKoNmyNMybIdiIYKNE8bN5w+8ORhgGuExQJGcAiXaGWFae+sDSpM/wfrVfVtDC0un4DWdAliC1cizQyrQfzeD9RpNUD/cZGUxtBYlj6MPr/eAhJQOLaYezV6snLn2dOsJAr4h3BH7/69Gf1Oizmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Y45XC0kZ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Y45XC0kZ"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8C91F207BB;
	Mon,  9 Feb 2026 12:22:04 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G5el-hgALqPx; Mon,  9 Feb 2026 12:22:03 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A80BC2064C;
	Mon,  9 Feb 2026 12:22:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A80BC2064C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1770636123;
	bh=+No82JChBDhuYfPnY/XEp9tK1idnhcI1+B2RVGHAvXs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Y45XC0kZcMA3u5SrSaJl1iekhO2OjtTmf0J/S4GmoYVHbyH42y+NR1PSSYi/Vm6qH
	 lo/3K1+mBHEkEFThrq6iyBcmYQRXoxhf+zYWbvieCNbKkvId5BVUU1QPKwZcfyeH+g
	 Iy8Jj1J85H675GCytdoSYu1mU0t71ouLrSxd7vqQhGZM5rTu/OvzYBmVYADjq549x5
	 yZ+gw6v18WNQrUWvlPfbG0kCtlqwrAC76kowqFWf3Ye83mH0uaD3rQDY5j2Pv9dJH9
	 WTEjvgJ8SszdyTLwjV/I/KSPj4ejw50XYvlYNXiqJoY0eAEBLv6+JJy6eQ57R3oO71
	 Un1LKF2F/33rg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 12:22:02 +0100
Received: (nullmailer pid 1538112 invoked by uid 1000);
	Mon, 09 Feb 2026 11:22:01 -0000
Date: Mon, 9 Feb 2026 12:22:01 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: Paul Moore <paul@paul-moore.com>, SELinux <selinux@vger.kernel.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Network Development
	<netdev@vger.kernel.org>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
Message-ID: <aYnDWbxo-jAzR4ca@secunet.com>
References: <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
 <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
 <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
 <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com>
 <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
 <CAHC9VhRzRAR+hhn4TFADnHWpzjOxjmh0S_Hg_HktkPkKQ35ycg@mail.gmail.com>
 <74a70504-8ff8-4d97-b35f-774364779889@I-love.SAKURA.ne.jp>
 <7ef21dab-3805-4eae-80d7-9779aeff3f58@I-love.SAKURA.ne.jp>
 <aYmoDwO-YXrc4W1c@secunet.com>
 <85546d35-c7bd-49bf-b0c3-9677bde25859@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <85546d35-c7bd-49bf-b0c3-9677bde25859@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Feb 09, 2026 at 07:02:47PM +0900, Tetsuo Handa wrote:
> On 2026/02/09 18:25, Steffen Klassert wrote:
> > The problem is that, with adding IPsec offloads to netdevices, security
> > critical resources came into the netdevices. Someone who has no
> > capabilities to delete xfrm states or xfrm policies should not be able
> > to unregister the netdevice if xfrm states or xfrm policies are
> > offloaded. Unfortunately, unregistering can't be canceled at this stage
> > anymore. So I think we need some netdevice unregistration hook for
> > the LSM subsystem so it can check for xfrm states or xfrm policies
> > and refuse the unregistration before we actually start to remove
> > the device.
> 
> Unfortunately, unregistering is not always triggered by a user's request. ;-)

As far as I remember, a security context is not always tied to a
user request. It can also be attached to system tasks or objects.

> For example, we don't check permission for unmount when a mount is deleted
> due to teardown of a mount namespace. I wonder why you want to check permission
> for unregistering a net_device when triggered by a teardown path.

I just try to find out what's the right thing to do here.
If a policy goes away, packets that match this policy will
find another path through the network stack. As best, they
are dropped somewhere, but they can also leave on some other
device without encryption. A LSM that implements xfrm hooks
must be able to check the permission to delete the xfrm policy
or state.

> 
> > 
> > The same happened btw. when xfrm was made per network namespace.
> > Here we just leak the xfrm states and xfrm policies if some
> > LSM refuses to remove them.
> > 
> > I guess we need a solution for both cases.
> 
> Is replacing the NETDEV_UNREGISTER net_device with the blackhole_netdev applicable
> ( https://elixir.bootlin.com/linux/v6.19-rc5/source/net/xfrm/xfrm_policy.c#L3948 ) ?
> If no, there is no choice but break SELinux's expectation.

That could be an option to not accidentally send out
unencrypted packets. But finding the right place for
these checks would be preferable IMO.
