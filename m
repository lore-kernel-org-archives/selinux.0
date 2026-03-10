Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87203CFF74;
	Tue, 10 Mar 2026 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161533; cv=none; b=TP5dcL0q3Qw2aJqVTO6Om7SlyswP8ZdPzUUYbEMruVhkDdeNUDrV0MxQO229Gh8WN/ilvTX180yOpchbsgM7nrA6yXdD0mUakGDD8eyBVcMdBU/mP9Epj9oBmYOtKz9AHX/LcW6iIIco6R8oISNMspkReQIOIMrXCAJ66baZ0ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161533; c=relaxed/simple;
	bh=qCCpDaL9t68wwaimcdy210aFh2IuYNoS23y6q1PkTPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhMKG+t8o+dr5C/ffQWYV5W9aPMGwYSqc75BL75R25O3LQXDzfmn60DXJQPhDKbdm1zPAyNll4Nfb39mxtubl+0zRRzeBNcNlT0srvnyegkXFSeoFBQ8JUkHg1Ux5HTAuKGw6izwclkXX0bvDI59+awBJQD636iyxrnHXKMhchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=i4oc/69g; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="i4oc/69g"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1773161525; x=1774025526; bh=qCCp
	DaL9t68wwaimcdy210aFh2IuYNoS23y6q1PkTPU=; b=i4oc/69gTuEDw0tQ6/Ot
	OZXHfl/aFwyS4drjBE9rjoUzKZmJ434cBW9ndUlww3DCrdJ8jFVvHv11AhsAvJw7
	0a9F9OH35fnLJtG1wTpdJU/fClwgltJ8+UlkcCJx04XnG2YGOPTaIb8NOtD07SdZ
	ID+r6B2s/T2CNPSrf7ZKjcyNErBmRxRV1DVKUPDWHIGXhPwl5geTF0mq2bzSjutu
	3YShtmwUqSX3tS80rzJbklOICPt+gKCGlqtXwsYfrezK3z4Wk2mGddmexZQN2iYz
	XN1CUc3NWwHnjra9NnC+gnTetHiMSoa8I7cK+85p4K0nbjZR4OqkBN2hoEZPx+E0
	5A==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Tue, 10 Mar 2026 17:52:03 +0100 (CET)
Date: Tue, 10 Mar 2026 17:52:01 +0100
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony@phenome.org>, Yan Yan <evitayan@google.com>,
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
Message-ID: <abBMMZWNp_zN23xL@Antony2201.local>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com>
 <aaF_SAQj4WT8jRaO@krikkit>
 <CADHa2dCF=Cq2SMYgjHcs71VedwYaDmUXPWnNbv=46+11Mz0otA@mail.gmail.com>
 <aa2K8pXXipCH8cke@Antony2201.local>
 <aa_750R5Jm5qPbNs@krikkit>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa_750R5Jm5qPbNs@krikkit>

On Tue, Mar 10, 2026 at 12:09:27PM +0100, Sabrina Dubroca wrote:
> 2026-03-08, 15:42:58 +0100, Antony Antony wrote:
> > On Fri, Feb 27, 2026 at 03:14:21PM -0800, Yan Yan via Devel wrote:
> > > > Anything that we leave as implicit copy will have to be "forever"
> > > > implicitly copied with this new MIGRATE_STATE op -- unless we find a
> > > > way to pass a new "clear these properties" flag (probably via a list
> > > > of XFRMA_* attribute names)
> > 
> > that is a limitation we should avoid. It would be nice to extend it
> > over time. We have been there before and it is a pain point. So it is
> > worth investigating alternatives if there is momentum here, otherwise
> > I would keep it simple:)
> 
> Well, because it's a known pain point, we shouldn't just jump into an
> implementation.
> 
> (FWIW, as a kernel-only developer, ie not involved at all in the *swan
> code, I don't have much of an opinion on which property should behave
> which way, just that we know what we're getting into)

Understandable. Partly *swan world, Android, IETF RFC guidelines, NIST et 
al. The *swan world usually wakes late after the time the kernel
reaches distributions.This is too late to fix kernel without breaking ABI.
standards world has its own path. Kernel often implements that what
makes practical sense in the moment and hard depreciate/remove ABI:)

I feel these days there are more interactions such as this, which is a good 
sign!

> > > That is true. I also have the concern that if all updatable attributes
> > > follow the "omit-to-clear" pattern, we lose the extensibility. Thus
> > > ideally we should switch to an "omit-to-inherit" model for some, if
> > > not all, attributes to ensure that adding new SA properties doesn't
> > > break backward compatibility.
> 
> Implicit copy ("omit-to-inherit") gets us in the situation we have
> with the old MIGRATE code, we don't have a way to _not inherit_
> properties. Well, apparently we do, based on what Antony wrote below.
> 
> 
> 
> > Here is my proposal. I extended the code and am testing it now; I hope
> > to send out v6 soon.
> 
> I think it would have been nice to postpone v6 a little bit so that
> others had time to answer here (and avoid a respin if there's some
> disagreement on what the behavior should be).
> 
> > How would omit-to-inherit look in practice? Specify almost all XFRMA
> > attributes supported in XFRM_MSG_NEWSA, minus some immutable ones.
> > The immutable attributes that come to mind are:
> > 
> >     - XFRMA_ALG_*      : crypto must not change during the life of an SA;
> >                          also *swan userspace does not keep this in memory
> >                          after the SA is installed, which is correct
> >                          behaviour.
> >     - XFRMA_SA_DIR     : direction is fixed at SA creation.
> >     - XFRMA_SEC_CTX    : security context is immutable.
> 
> So we should be rejecting an attempt to pass those attributes in a
> MIGRATE_STATE request.

yes. I added it o v6.It reject all unused attributes.  
NL_SET_ERR_MSG_ATTR(extack, attrs[i], "Unsupported attribute in 
XFRM_MSG_MIGRATE_STATE");

> > currently supported attributes, using omit-to-inherit semantics:
> > 
> >     sentinel value to clear, omit to inherit:
> >     - XFRMA_ENCAP              : encap_type=0 to clear
> 
> That would be a new special case value for that attribute, ok.
> 
> >     - XFRMA_OFFLOAD_DEV        : ifindex=0 to clear
> 
> OFFLOAD_DEV with xuo.ifindex=0 is a valid attribute to request offload
> and let the kernel figure out which device to use. We can't use that
> to clear/disable offload of an SA.

Good catch, thanks.

Two options to fix this:

Option 1: add XFRM_OFFLOAD_CLEAR to xfrm_user_offload flags in uapi xfrm.h:

#define XFRM_OFFLOAD_CLEAR  (1 << 7)
When set in XFRMA_OFFLOAD_DEV, it means remove offload rather than configure it.

Option 2: add a __u32 flags field to xfrm_user_migrate_state in uapi xfrm.h.
There is a __u16 reserved currently used for alignment, but 16 bits feels
too small if we want to cover clearing other attributes in the future.
A __u32 at the end of the struct avoids that constraint.

I am leaning toward option 2. Any preference? 


> For the rest, it seems that passing 0 is equivalent to omitting the
> attribute in the current code. Except XFRMA_SA_PCPU, where we consider
> UINT_MAX as "disable" (default value for x->pcpu_num), but we reject
> userspace passing us that value, and XFRMA_SA_PCPU containing 0 is a
> valid value.

yes XFRMA_SA_PCPU that would be UINT_MAX.

-antony
