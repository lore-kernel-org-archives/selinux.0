Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92550386C2E;
	Tue, 10 Mar 2026 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140977; cv=none; b=lysm5zPb1F8zp2etYUHGabpb9SIsstd7MZlMlZZbqBThsmMM0z2wxUd44CbAuEFte1k1BF8HgnJpoH03QKeCagWIRtd1YQscSwW2Cuk1RZaFR9VtaipRPCfHcX87+JZLEogukk7vjO5w1I6uKodZBjOe/PMQUT/UteM3jlHCQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140977; c=relaxed/simple;
	bh=D1TU5+bgyWZr5DTDUOEouVlMxlUQIRkeVz1AcpbLWxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNAXUnEXL8vbl98yKqEyo39bovFT4/DWTyZk4c546JJUv/GEVtNveDOayPriQnOSp8Qfzn57QVGmnVTvlOallw0PNByYuUmc4f6CBbaWQTpjA6OacBBCgZcZhIE0EKG3ENOGv6fi0IRZ3Ga9tjDR/+pjD1KXb3yZpUCPz5KZNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=M2ajF4Cv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F/QL+qel; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="M2ajF4Cv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F/QL+qel"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 688851400191;
	Tue, 10 Mar 2026 07:09:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 07:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773140972; x=
	1773227372; bh=PpMh1qJdcNzbGD+FAq/1b2Hnmjr4RpZnquUKWY751yg=; b=M
	2ajF4CvTUMlCtMPVJu6gQp7C9uHESGoxlp4muOH/EirAk2rvMMc0Cwj7z8Ilw3mH
	7zf5g9VvsEJW1adTykc3txLb8yUusWYlo1p7F3jkzIKI+K7K/gXYsIjjU6biaR3I
	d9SSAYb19eafhpBDqse2acYMLhr6IBjnsDf33DfuB05jUmBbJuSFAHCFApWl+ENA
	ay7PuAaqYlqs5jiT+EdfcyaAAfEJ+CItCB2Erw3tsK7NyVpnDSHDe25+W+l/bRN1
	iYP2xtMoyoIWAi1xOCpGVE7lS/hbFYrfJIECCtvIDgDX67ZAq3AqW9eFuFtTGuSM
	sJ9J5l1lD69V4yv6I98Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773140972; x=1773227372; bh=PpMh1qJdcNzbGD+FAq/1b2Hnmjr4RpZnquU
	KWY751yg=; b=F/QL+qel7qTFhEYt1rPq30qVbNOLr/k3MAJIVphs1jFEoAu2854
	7t8QdZKeKHU73JmLX8MWq7v7ZiJ4WizxkfeSkJnXABBhLcXI+cDos+7AkAZ5G6TK
	VySRnFDZKFDSNneHTXMZhDbgO7hH6KWR7X5wQnaPPBbatGdyvVhUkxayHk+k/q3N
	4DPa2Aq3pNoDQwZuEqb5yxRiPli7pVI8GgKDhjJIF41juJaibDFCREbY2zhrImyT
	QbVs/hdVy4aeCCtrlqXdI9pocpys49Fyz/xBgCJabSCJkKbrALutuwC5DACQuXGb
	MCrx8m/OVbRVucywq+pzk0jlKcAnpdCcqlQ==
X-ME-Sender: <xms:6fuvaULayUQoLniv5X5xeIsdK4ZdsYDWQMg8w72JyRzXqYBpZ66FwA>
    <xme:6fuvaTZylznNd32mAGK8-FBYc0JXVoET8lTh182z4NnoVTJHEb5_4PEtbox1S5IWw
    Kb8LZf9OyvPQ_7ZRgRXYV9GOn6zJU94cG3fv0yIzQFM0A0kEdOs13Q>
X-ME-Received: <xmr:6fuvaXgZP87od0Wj-DoTNRgS_qNHnAZlYicGGTLUm9zoDEphq3vHsw3sOhZp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhihsehphhgvnhhomhgvrdhorh
    hgpdhrtghpthhtohepvghvihhtrgihrghnsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pegrnhhtohhnhidrrghnthhonhihsehsvggtuhhnvghtrdgtohhmpdhrtghpthhtohepsh
    htvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpdhrtghpthhtohep
    hhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghm
    segurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6fuvaY5_MYlbgUx4ykA-Q2VM4biPHyHCwk8iiGA4cngYuBmdtrtC3A>
    <xmx:6fuvafor4dAi9Sl4qSKJO7yFCWlELz16HzzB7geXrrSFKAWhVLb-oA>
    <xmx:6fuvaVik3W9UOYEyBtU9WiENoDLcdXZnaV2n6mH0_EU3owVxZ-ZzJQ>
    <xmx:6fuvaXvwOZ3UOy_SNwI2aJGt5PdD9TEFNpW-EEyXTmC6_5hjMGhpgw>
    <xmx:7PuvafHgjEAy1_HGKrJ9r-Q8SUR6n2IPyjY0K2efWtu1O5Ba6p0b154N>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 07:09:29 -0400 (EDT)
Date: Tue, 10 Mar 2026 12:09:27 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony@phenome.org>
Cc: Yan Yan <evitayan@google.com>,
	Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org, Nathan Harold <nharold@google.com>
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 8/8] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aa_750R5Jm5qPbNs@krikkit>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com>
 <aaF_SAQj4WT8jRaO@krikkit>
 <CADHa2dCF=Cq2SMYgjHcs71VedwYaDmUXPWnNbv=46+11Mz0otA@mail.gmail.com>
 <aa2K8pXXipCH8cke@Antony2201.local>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa2K8pXXipCH8cke@Antony2201.local>

2026-03-08, 15:42:58 +0100, Antony Antony wrote:
> On Fri, Feb 27, 2026 at 03:14:21PM -0800, Yan Yan via Devel wrote:
> > > Anything that we leave as implicit copy will have to be "forever"
> > > implicitly copied with this new MIGRATE_STATE op -- unless we find a
> > > way to pass a new "clear these properties" flag (probably via a list
> > > of XFRMA_* attribute names)
> 
> that is a limitation we should avoid. It would be nice to extend it
> over time. We have been there before and it is a pain point. So it is
> worth investigating alternatives if there is momentum here, otherwise
> I would keep it simple:)

Well, because it's a known pain point, we shouldn't just jump into an
implementation.

(FWIW, as a kernel-only developer, ie not involved at all in the *swan
code, I don't have much of an opinion on which property should behave
which way, just that we know what we're getting into)

> > That is true. I also have the concern that if all updatable attributes
> > follow the "omit-to-clear" pattern, we lose the extensibility. Thus
> > ideally we should switch to an "omit-to-inherit" model for some, if
> > not all, attributes to ensure that adding new SA properties doesn't
> > break backward compatibility.

Implicit copy ("omit-to-inherit") gets us in the situation we have
with the old MIGRATE code, we don't have a way to _not inherit_
properties. Well, apparently we do, based on what Antony wrote below.



> Here is my proposal. I extended the code and am testing it now; I hope
> to send out v6 soon.

I think it would have been nice to postpone v6 a little bit so that
others had time to answer here (and avoid a respin if there's some
disagreement on what the behavior should be).

> How would omit-to-inherit look in practice? Specify almost all XFRMA
> attributes supported in XFRM_MSG_NEWSA, minus some immutable ones.
> The immutable attributes that come to mind are:
> 
>     - XFRMA_ALG_*      : crypto must not change during the life of an SA;
>                          also *swan userspace does not keep this in memory
>                          after the SA is installed, which is correct
>                          behaviour.
>     - XFRMA_SA_DIR     : direction is fixed at SA creation.
>     - XFRMA_SEC_CTX    : security context is immutable.

So we should be rejecting an attempt to pass those attributes in a
MIGRATE_STATE request.

> currently supported attributes, using omit-to-inherit semantics:
> 
>     sentinel value to clear, omit to inherit:
>     - XFRMA_ENCAP              : encap_type=0 to clear

That would be a new special case value for that attribute, ok.

>     - XFRMA_OFFLOAD_DEV        : ifindex=0 to clear

OFFLOAD_DEV with xuo.ifindex=0 is a valid attribute to request offload
and let the kernel figure out which device to use. We can't use that
to clear/disable offload of an SA.

For the rest, it seems that passing 0 is equivalent to omitting the
attribute in the current code. Except XFRMA_SA_PCPU, where we consider
UINT_MAX as "disable" (default value for x->pcpu_num), but we reject
userspace passing us that value, and XFRMA_SA_PCPU containing 0 is a
valid value.

-- 
Sabrina
