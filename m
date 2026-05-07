Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0543E95BA;
	Thu,  7 May 2026 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150136; cv=none; b=rpkfOGUM7HejMFo7mN7qimQ+dflXloyOkpZlcZvApxXdoc7B3JothUvo0q2yr+yqzRQq5B4apPdNmmxBYUcE/UjXPK+vQr0n29gzdMqghK1JyxPWyJg30Pb/aF6aBqcHO1lRim/cp4QETsyL8u8zfzGE4pwthzbxnueayp/2G28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150136; c=relaxed/simple;
	bh=DgTO+VGmFlJhPiTcIPyNB+OMobHIw/8r3o1xJ0ktouc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB516r30laZiRho5LH1YrICa2W6NThoVkWgy1AAcfiWBZ18FI3gSF1NUwZ7WF3Ita9bbRYjWS6MnaWx6cNEILI4zbZoLTuO6Uzoj4vF0vebvOBF5iLCeo07P2AKvfRYyEDwyv2w1bxmrlspj1URFlzNR6DyO37KAyDXPMtlUM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ctsj23li; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qr0eRA4d; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ctsj23li";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qr0eRA4d"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id ED8BF1380380;
	Thu,  7 May 2026 06:35:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 07 May 2026 06:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778150132; x=
	1778157332; bh=yb3pfp489SiZmeD4X5jRsuO6RSm4oj08RuE6p+AZK00=; b=c
	tsj23lizm678n+r79wKt+qo1/ApF6OpkdO1A8P3HP713lqtMY944gp6N18tRwoKT
	gcetWQ1qQoaWGdsz+madjYoGh538kk2rqOzjdCWJ3n0Jf57dwsNL7Vv/NPHKq0Nt
	yhykUtLB+hguzCbolP7Qe2Y0FoPTCp+lj0i4oCyF+n0rFI/myY4HiLODQDviHyKp
	LG6ILJPqSxxdaglxSyNbhDY8/JwyeOtDnFJUqX6anKwcFlvEACrj+M2IEcnMHZw+
	xoDkYQFdStWklBLL7NxkgQnwW8ojCPPXUsIEhZy8oqp+Q4sjCy2R5weOFmUk6X0m
	o9gMjKS2i1YccUK4frS0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778150132; x=1778157332; bh=yb3pfp489SiZmeD4X5jRsuO6RSm4oj08RuE
	6p+AZK00=; b=Qr0eRA4dyYpremnsB2rb6gwDN4rJQvOv5cz4IMS5Ojb8S+wzWbx
	mRlAuHdoC29coIofayPOgR5J21lKNlntyuj/hs+G/vgD7eZUWwuKVzK8bpWtZK2p
	kUhu/fKeMbvVmUSixpY6y/rQou8k+FnqeG4Pa8g3WHoPmz9MLykXwA6WbOiBRfcn
	9GQVBZx/c/xNvc8iyW9fSFdWt1EFF8NluvVI8f4Xv6pU9TA1ms3Mfp3goxYb0iRG
	1GnB5o83wXINBiszT9Z9sVJzAPMvXBdolYnAKW/C2w2Qrob6TDIHjuQlOFtsp/1j
	4fwjwm6vCU3zljid8ZzLPl13UpBDJbuNixg==
X-ME-Sender: <xms:82r8aVA52NefOqQ5QW4ofIqG6ykhOPGUTdzdi92NdGM79Igi608_cw>
    <xme:82r8aVJOF3aUpVi5aybuy2lJiIu8iVXq8AWKwfyC-zCn6I_L8NZjM5n2Kj53bT55e
    XZySXFQ5NcLXjZtviGaSBa5o_rFsjIvAFAOCq0_DeP2CiPjzRbbeMHf>
X-ME-Received: <xmr:82r8aUrqo-5X9exBOq-DAjlFBimaLOXLNR-ZOfOwU4X90aadBTECTn8Zh8VV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejvdegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:82r8aWPkks6C_rlHw_2-3hTRNyhya8qaLq0IHXdlT46s0gvaaRKZLQ>
    <xmx:82r8aZPM-iBsaoGXzOnO6yKxLHt45Ko7cutGpUdDY7I07mZN3YTuPw>
    <xmx:82r8aQ0ganICRfJmc3_3jQGUs3WnfSOiXpceU987Vp7j4Vi7NedFRw>
    <xmx:82r8aV1kIzrcY1gpTtJeWTrddDY2f-zP3ULtjjE1UrY78Muj9ZoXrw>
    <xmx:9Gr8afGCHC_4jO4usHIuFEu4zTG3eVqOTNH0uV0EJfWCTUWdXoZLTQMa>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 06:35:31 -0400 (EDT)
Date: Thu, 7 May 2026 12:35:29 +0200
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
Subject: Re: [PATCH ipsec-next v8 07/14] xfrm: check family before comparing
 addresses in migrate
Message-ID: <afxq8Vu3IZVZP6-1@krikkit>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-7-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <migrate-state-v8-7-4578fb016965@secunet.com>

2026-05-05, 06:33:18 +0200, Antony Antony wrote:
> When migrating between different address families, xfrm_addr_equal()
> cannot meaningfully compare addresses, different lengths.
> Only call xfrm_addr_equal() when families match, and take
> the xfrm_state_insert() path when addresses are equal.
> 
> Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

This fix doesn't simply cherry-pick on top of net, I don't know if the
stable maintainers will handle the (pretty trivial in the context of
reviewing this patch series, but maybe not for them) conflict.

I think xfrm_migrate_state_find, and probably xfrm_alloc_userspi, need
the same kind of check.

> ---
> v5->v6: added this patch
> ---
>  net/xfrm/xfrm_state.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 85fd80520184..327a855253e6 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -2159,10 +2159,11 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
>  			       struct xfrm_user_offload *xuo,
>  			       struct netlink_ext_ack *extack)
>  {
> -	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
> +	if (m->new_family == m->old_family &&
> +	    xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
>  		/*
> -		 * Care is needed when the destination address
> -		 * of the state is to be updated as it is a part of triplet.
> +		 * Care is needed when the destination address of the state is
> +		 * to be updated as it is a part of triplet.

nit: the previous patch rewords this comment, and now you're
reindenting it. it would be a bit nicer to do both in the previous
patch, and only add the family check in this patch.

>  		 */
>  		xfrm_state_insert(xc);
>  	} else {
> 
> -- 
> 2.47.3
> 

-- 
Sabrina
