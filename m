Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F73C060C;
	Thu,  7 May 2026 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146016; cv=none; b=qHgX1skkC1N4Mzs6J97D3bvh1rvDn2LB19WiOMMMTmR1iYkZYH2OB3wTbfFq1fKJrhjwzk6T+KoyUx9Ed7SkkcX+r/Qkg4nV9iJjcwGs8UroB0oTtootwuJwzcx1WRq8CFK/P5yTLa4EWmPgZYQIiZvSWkYTh5HqdSH3SJVfHao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146016; c=relaxed/simple;
	bh=Zo3fg+NFkvKqceewB96F6ZZGnyUTHoGjFxPbcjBusYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZBbJF5qfQAJ5tUkH+02ltXNSZtp+ZVp5Anf16n6B6l6BFTESfLS9QF08F6JqscphOYnDHb0lhS4U43pSlBxo800nbwNd84OLfUwGxeWucXonHPOMXGmQmwOh8YZ17IbwwYm6M6VcOkaQDuwv9XP+MasdwXpz9dSzp6VrSFGLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=WQCJ3d3D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vB85BIFd; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="WQCJ3d3D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vB85BIFd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id BF9431380119;
	Thu,  7 May 2026 05:26:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 07 May 2026 05:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778146012; x=
	1778153212; bh=dyuIOlvvoXqiYdKWiBRGqggzExiM1Bavzi5yk+4YmzA=; b=W
	QCJ3d3DH3VDyV6e2/IHHRI4AQ7Ee9A+p0hgPjRWU3ErchVE8OumgDYDT5k4FAeej
	rVrM4u+c3R7WqRu8TqipEEHPRjhTautvnSRL4lhCtZf4wxrYIPbR4SlvlxXYDHpj
	GE3TdCEpkpuXYnIm0t9y05cNVUqN1jIe5xT8eE31n7Gs9lq7bZC06+7ommp+Qsqu
	HYEavYaXXohppvQb40VaR+Ol5TmN3rddua0OxaJvmeOrJGL/CgmgTP6ecTw+W6xY
	yYae+QPDv5T2b7+g/rbFOkcD8bpb/lUICaEMvYf1TGwPfPz0TleSdi8tK3C4XaUZ
	57hVQjMPsZDbMVWBz3Eug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778146012; x=1778153212; bh=dyuIOlvvoXqiYdKWiBRGqggzExiM1Bavzi5
	yk+4YmzA=; b=vB85BIFd3VJWCwCvKQXu8I2SG0HmBGNN8AfhIJf/oiZ9cAbhY/b
	HIPEk76eA3R5AAsbjd6ToildsRirEb8s3KHnFPvlvVZAtG99Z9W4JS3IuobJOkHe
	dsch1OB1KlrXC92G20BC1CQPLZceF6/U2KlTlUFvMJtivUesOW597OlvsryfDrev
	hrQ0K/hutj57JivgpNZzRyOwRXfj0elg4kJYY2FLzBkNdOj+z5ynrdHSG8dmGGvW
	1CqpyTRxtz4d7dDA/VMM+HRyD+TTSUaiwVr3QTLKpkxtmnM0yL+1kOF14Y3dmhT3
	ywb/9qxiH8qUe512YJGCcsgPk5gTniVxEKw==
X-ME-Sender: <xms:3Fr8aS_pY1ztldVPsr1ARAA5XkgETcU3vio_l61GI7DzKBeRbGPoJA>
    <xme:3Fr8aUWKJ-kl-3xtV4YzCO8XfJDuX8UrkQCCW46C8G75248VcxxcsuKvWxkaRdVGF
    AuljbFtfzSuDnIPtULwSM5cthy4kmvrRyeorujn31qRp0COi6ITUkXA>
X-ME-Received: <xmr:3Fr8acHCbYCDRhQUoxwfxBgJwRY3AVdAGXXjYJXADXSM5wyom_QLDJgwMAd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejudduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:3Fr8aQ75svl913xXKPMZrSNupQe34Uh7wCpPMv_eXiUdra7ciUn3Hw>
    <xmx:3Fr8aWI72afoevaAXx_u7J6iWwBknd3Wcs5WVxaADonp_NwDQRu1YQ>
    <xmx:3Fr8aTBIgV_aIo9-vA8NaVQnvzgzf2W0B3QVju3vqDPNoNts_p50rQ>
    <xmx:3Fr8aUTtUlUf5Ir-m5jiqiC4bpY2EkUv8DbP5sV1XemksNJ518YQRQ>
    <xmx:3Fr8aQxd4pkoGHInUl250eRSqBt7Po02ro8psEdG4f12FUUJN5J2KQ1K>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 05:26:51 -0400 (EDT)
Date: Thu, 7 May 2026 11:26:49 +0200
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
Subject: Re: [PATCH ipsec-next v8 03/14] xfrm: allow migration from UDP
 encapsulated to non-encapsulated ESP
Message-ID: <afxa2RNjJGNeD7zf@krikkit>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-3-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <migrate-state-v8-3-4578fb016965@secunet.com>

2026-05-05, 06:32:30 +0200, Antony Antony wrote:
> The current code prevents migrating an SA from UDP encapsulation to
> plain ESP. This is needed when moving from a NATed path to a non-NATed
> one, for example when switching from IPv4+NAT to IPv6.
> 
> Only copy the existing encapsulation during migration if the encap
> attribute is explicitly provided.
> 
> Note: PF_KEY's SADB_X_MIGRATE always passes encap=NULL and never
> supported encapsulation in migration. PF_KEY is deprecated and was
> in feature freeze when UDP encapsulation was added to xfrm.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Tested-by: Yan Yan <evitayan@google.com>
> ---
>  net/xfrm/xfrm_state.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

If someone complains about this we can add a sysctl
"preserve_old_encap_on_migrate".

-- 
Sabrina
