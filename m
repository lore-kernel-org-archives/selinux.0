Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7E37BE66;
	Thu,  7 May 2026 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158621; cv=none; b=SPbO1SO2oLw1aeO7sEqTtMvueYE3AmlqErRjPoRKF21MpS7469gOTGbMtkA37sv9fD+sLMSystrqw2h9NUhhHYgtqEbvmMY/lxyViojI6YWNMzMYe3OhEVpUPfaztVfguFstYZF2ewUf+yKEMCdEXcUA90Bc3gjw243h37Z2J7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158621; c=relaxed/simple;
	bh=YeBSOjoQJst5vxg1qThBdYEONOm6zcnWolc0/DZvzKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2+/vJNNceQADPOCJ9OOkCA5ukooGVVQ9yO1C0PTCad+axMofwch/fWo/qkSneXCoD0GoXYz2izcMHFDOAUjZgzaRX9xOkHiB+1cWGQS7E02ey9jxyOxjbqxZ+Y7mDi+LYOfG+NYgSTPFCDvqBw2v8BII6OpAKTiiZrhWDRN0yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Kw2PvHUe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QL3RCSL+; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Kw2PvHUe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QL3RCSL+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 74E361300336;
	Thu,  7 May 2026 08:56:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 07 May 2026 08:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778158614; x=
	1778165814; bh=T/0q7vYOuuf9zCnxo2miOS7GAZBPCeln6tzioafOeXc=; b=K
	w2PvHUeqpJar2J8oCETYKNcmwhl3rZx2TO9hvu6Y9nO7ZiM5N+CsreSF520sY8P8
	XqdU5VCXxiMyl7r4qQQ2nHzl6027cBt1yADAH6Fir4SWTteVWxy+rGy2fwNZ+iof
	bOenzpHXwxvbmU2H3gugltiLVBeM/fAtEA2OV+/bw3XiLP6VJOchiiXRJL456C9P
	NuzTcz6t0txto6VVFS3adLb7XrNvuBs2hN/lpdOVLo5chfO+tc2ybOj9GN1ji8Jj
	3saY005Hww7jSLDWH4bwYDVVGjgd05sPZU5kACXl9kREeewymGT22b1Jj+mwo4kA
	xw9ob4Y4I52ZsgiOFJyew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778158614; x=1778165814; bh=T/0q7vYOuuf9zCnxo2miOS7GAZBPCeln6tz
	ioafOeXc=; b=QL3RCSL+Uu+mgaxp8WZAlqHCqVA3SCsk8vLP4BxCwbNk1VGdl5n
	m5kiFAYwAuoGy1zsthRmZVlbKwHAtM2X8/ssiyRtRL/zXPxK0jZQDnsyFxtulFgr
	9OVEgYiuyv/HUeZb0MIGrzvY//25K9On2uF/IH0c0yUbtpZpjloSb3aryapJWcb6
	aaYs25AgdDI6Ty0ncalPonBB7sg6PDKd+VJyNPSDvQHpVxvzu9B10BTYH/qVwbA5
	h9M/FCocmI3nd1S86dm+1uENK37O7HZXYImWTo3NrZoxiIyR7aqQOBSejSZ4RZyR
	nLF8DCeDNA0CXOsJjy1+iRZk53QTHLcxkQQ==
X-ME-Sender: <xms:FIz8abCYt4tJ7DItpoFjtoXLOKJbOuoPODRGi-HJUjcd7ROc3iaaiQ>
    <xme:FIz8aTIqY-g7_YX_xQM6SmjKsYX7GB0-DUxB0jmLxarWk9PHuiDwstonGaPoH3qFw
    aXPBMLbmnXeEgkXZrQNCFCLGLaguh0Ijjo3sBOk5PCms7gCWF6Z33A>
X-ME-Received: <xmr:FIz8aarI-7KpFZEBKp_yq3UHO2QwL8xOjPcyT8EGOP7Mk2lbcp1xfKDdS976>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedvvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhihrdgrnhhtohhnhiesshgvtg
    hunhgvthdrtghomhdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgv
    tghunhgvthdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepughsrghhvghrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FIz8aUPTRpoxBBkb2Hgc7iRRmFYVtM9HO663HWtkxdt6rvVLATfRjg>
    <xmx:FIz8afPBtPtoWFnC7KDxbbBzmgRnEMXdSjiWOfWE2rvtzVlEKZJaLQ>
    <xmx:FIz8ae3ZixrKMDQQvZujjx8mQAj0OS-thmSDSiTynsTZ3mNAdbzrRw>
    <xmx:FIz8ab3I_rdMEmL9tmnxAKsgIfWke2tzQubHc6ri7Q3XgYtHvjwAlg>
    <xmx:Foz8adEXXa7JlyYj4-GvkWWN5QUKToFEQ5iXRJK1lgKdIARnVho319tu>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 08:56:52 -0400 (EDT)
Date: Thu, 7 May 2026 14:56:50 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Masahide NAKAMURA <nakam@linux-ipv6.org>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next v8 09/14] xfrm: add error messages to state
 migration
Message-ID: <afyMEvHebp4VFxE4@krikkit>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-9-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <migrate-state-v8-9-4578fb016965@secunet.com>

2026-05-05, 06:33:49 +0200, Antony Antony wrote:
> Add descriptive(extack) error messages for all error paths
> in state migration. This improves diagnostics by
> providing clear feedback when migration fails.
> 
> After xfrm_init_state() use NL_SET_ERR_MSG_WEAK() as fallback for
> error paths not yet propagating extack e.g. mode_cbs->init_state()
> 
> No functional change.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> 
> ---
> v5->v6: - in case dev_state_add() extack already set
> 	- after xfrm_init_state() use NL_SET_ERR_MSG_WEAK() as fallback
> v4->v5: - added this patch
> ---
>  net/xfrm/xfrm_state.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina
