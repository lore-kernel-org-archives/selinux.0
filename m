Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03413AD506;
	Tue,  7 Apr 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569042; cv=none; b=eXKYFNx99iegf2/SwHeunlo68tp2mDujlU7luvHGpvHCbY0/uFxEDOI7dYhg1B0hZJfFuv0m+Tm6GBf15Tvn0f9mrB4QYGsFFLvY8FXFvvUUcA8NB3MyyYKVwecl6JtJhSySrlKl5T05HUS8MHjacDv4T1l/49tC/tsbpZVZ2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569042; c=relaxed/simple;
	bh=I8Yh8w5RqR2TlarL0EXjxRT50/mPd1NH/1bFddxO9JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2kNSXvcaHxlPquWMbzdMZg+KuFzk8U3XW/JoGk39/fPXv2MSPfleBx6kAFspzOlQR3I0Nbcr5zVOTM78gF8AGCNDqorjmreHG4e7xQ6ynLpWQyriNBdJk837dqGN7i800IcbqGJCBJ1vOFoIemrDJ5NurK2pABi8o450bLJNvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=UKxbmTUD; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="UKxbmTUD"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1775568606; x=1776432607; bh=I8Yh
	8w5RqR2TlarL0EXjxRT50/mPd1NH/1bFddxO9JE=; b=UKxbmTUD+fmcX5k+eTUD
	ThP7rBvbdkC3CCwEa2YCki2xsX9xRnkOsx1UKeM5H+umHGLAXiom3erEUc9jM7mG
	eFQzqm2vELwrkSe4E2wHOGGRDvz9kVZhiJOUhNrBsVl86WVR1i3k+/PtGbcuGpyQ
	28LYiUbPKRNvm2YcYV8dfdFMnjrmyTtlyRhLIBmuqUISaYsnJW8e+FyfpbG8DFyc
	9FEA5k/5MZ8wFlrqtR4rbEwBYhuxLdMBDmFiZqtTNFukMISLzv+M5mMfLzoIMaqT
	HrMsNe+afPwJGNartsca2d/zpUpCTNb+sc1ibYZGNKyDd7BBEckNm4/HG42FpVbS
	BQ==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Tue, 07 Apr 2026 15:29:59 +0200 (CEST)
Date: Tue, 7 Apr 2026 15:29:37 +0200
From: Antony Antony <antony@phenome.org>
To: Antony Antony <antony@phenome.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
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
	selinux@vger.kernel.org, Nathan Harold <nharold@google.com>,
	Yan Yan <evitayan@google.com>
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 8/8] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <adUGwQbs3L6esfZv@Antony2201.local>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com>
 <aaF_SAQj4WT8jRaO@krikkit>
 <CADHa2dCF=Cq2SMYgjHcs71VedwYaDmUXPWnNbv=46+11Mz0otA@mail.gmail.com>
 <aa2K8pXXipCH8cke@Antony2201.local>
 <aa_750R5Jm5qPbNs@krikkit>
 <abBMMZWNp_zN23xL@Antony2201.local>
 <CADHa2dCdFKE4Wg-uSmYLmh1-JEf=rZOA2WUmRbTy0S0rp+rz+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADHa2dCdFKE4Wg-uSmYLmh1-JEf=rZOA2WUmRbTy0S0rp+rz+A@mail.gmail.com>

On Fri, Mar 13, 2026 at 05:32:15PM -0700, Yan Yan via Devel wrote:
> > yes I can add that. I would add XFRMA_SET_MARK/XFRMA_SET_MARK_MASK together.
> > If you set only the SET_MARK mask will be 0xffffffff.
> 
> > I am actually using xfrm_smark_init() which will accept both.
> 
> Great! Thanks for supporting that.
> 
> > Option 1: add XFRM_OFFLOAD_CLEAR to xfrm_user_offload flags in uapi xfrm.h:
> >
> > #define XFRM_OFFLOAD_CLEAR  (1 << 7)
> > When set in XFRMA_OFFLOAD_DEV, it means remove offload rather than configure it.
> >
> > Option 2: add a __u32 flags field to xfrm_user_migrate_state in uapi xfrm.h.
> > There is a __u16 reserved currently used for alignment, but 16 bits feels
> > too small if we want to cover clearing other attributes in the future.
> > A __u32 at the end of the struct avoids that constraint.
> >
> > I am leaning toward option 2. Any preference?
> 
> I'm also in favor of option 2 for better extensibility.
> 
> >     - XFRMA_REPLAY_ESN_VAL / XFRMA_REPLAY_VAL : may be later replay type
> >       should not change.
> 
> I agree we should keep the replay type immutable. Changing ESN flag on
> the fly would make it hard to keep both sides synced, and I'm not
> aware of any use case for this.

While testing XFRM_MSG_MIGRATE_STATE we ran into an issue with x->sel
migration in transport mode. In transport mode the selector is typically
a single-host entry matching the SA's saddr and daddr, so after
migration it only needs to be updated with the new addresses.

For this common case I added XFRM_MIGRATE_STATE_UPDATE_SEL to
xfrm_user_migrate_state.flags. When set, the kernel validates that the
existing selector is a single-host match for the SA addresses and
derives the new selector from new_daddr/new_saddr with the appropriate
mask for the new family.

I think this is the main use case. However, for corner cases out there,
the selector is not a simple single-host entry,
struct xfrm_user_migrate_state now carries a new_sel field. When
XFRM_MIGRATE_STATE_UPDATE_SEL is not set, new_sel is used as-is for
the migrated SA.

-antony
