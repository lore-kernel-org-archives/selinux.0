Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B324B640;
	Sun,  8 Mar 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772980993; cv=none; b=NpCDi9jJeuvoJWugDxMZ3AFJgbkPqBI2/8IrBPb1+OLKNzGHshdvcGqtd9ATFGDMPARjJ0XpfJE6hVGC+uustUdUyp19bOrslW0sXKRCRHSAOUdz68v16FeOdOiFAXxUfzJ7YOwtUlog0wCQepPK6KbzzCIy09vZGUJKJJA15Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772980993; c=relaxed/simple;
	bh=VHqO/1tDQXmHHWssGWnPwminlmEdPs2EWuCGTKD/2O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac5tZ7ijQOE+KWqG3y9E9SgEsBwAplC+K4sSKJiBQal3TEs3O3cvHX6Jl2nqqlrhEPqSjGRGJq71/hZKpmzydRIxw0ypNSxb0nJiGK8dR4JiaxwSeNAiVj/wbI/Iu5FMkD1ZgOiPQh8Ryd51vpOBzKioFwSSU8XmXDfgNJoBslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=KJIwxlGW; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="KJIwxlGW"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received; s=oak1; t=
	1772980982; x=1773844983; bh=VHqO/1tDQXmHHWssGWnPwminlmEdPs2EWuC
	GTKD/2O8=; b=KJIwxlGWr5LFt8uufjFmkUMxMUJdgifZgVie/S1xutMWQuYpaVW
	DGmlTDhevW/Mf3FGRyVaJdbzR7GCt6o6LiZaojlUTeibV0DFlIPJuaYiquTELZuL
	7fzUDem+B7VW7yycml/nw2Laedy2EEP9AIDhyxgzwYt7b7KDCPX32w3rG5gnfpPa
	Ecbsv6ut2knxGrqInsPq+ermsdohS/Q3cTCTBa6BWt35+YlVENNE/nZFmYqACzDc
	fHvunwa5KuR+6JdvX3NDqGQtPr8fIXCIMzjXR81DLEUFFA4Nmek5khdptOMqRVaK
	/KEzTdTVPvJRBeDZzv91uakPNPgyxbICyGg==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Sun, 08 Mar 2026 15:43:00 +0100 (CET)
Date: Sun, 8 Mar 2026 15:42:58 +0100
From: Antony Antony <antony@phenome.org>
To: Yan Yan <evitayan@google.com>
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
	selinux@vger.kernel.org, Nathan Harold <nharold@google.com>
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 8/8] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aa2K8pXXipCH8cke@Antony2201.local>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com>
 <aaF_SAQj4WT8jRaO@krikkit>
 <CADHa2dCF=Cq2SMYgjHcs71VedwYaDmUXPWnNbv=46+11Mz0otA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHa2dCF=Cq2SMYgjHcs71VedwYaDmUXPWnNbv=46+11Mz0otA@mail.gmail.com>

On Fri, Feb 27, 2026 at 03:14:21PM -0800, Yan Yan via Devel wrote:
> > Anything that we leave as implicit copy will have to be "forever"
> > implicitly copied with this new MIGRATE_STATE op -- unless we find a
> > way to pass a new "clear these properties" flag (probably via a list
> > of XFRMA_* attribute names)

that is a limitation we should avoid. It would be nice to extend it
over time. We have been there before and it is a pain point. So it is
worth investigating alternatives if there is momentum here, otherwise
I would keep it simple:)

> That is true. I also have the concern that if all updatable attributes
> follow the "omit-to-clear" pattern, we lose the extensibility. Thus
> ideally we should switch to an "omit-to-inherit" model for some, if
> not all, attributes to ensure that adding new SA properties doesn't
> break backward compatibility.

Here is my proposal. I extended the code and am testing it now; I hope
to send out v6 soon.

How would omit-to-inherit look in practice? Specify almost all XFRMA
attributes supported in XFRM_MSG_NEWSA, minus some immutable ones.
The immutable attributes that come to mind are:

    - XFRMA_ALG_*      : crypto must not change during the life of an SA;
                         also *swan userspace does not keep this in memory
                         after the SA is installed, which is correct
                         behaviour.
    - XFRMA_SA_DIR     : direction is fixed at SA creation.
    - XFRMA_SEC_CTX    : security context is immutable.

currently supported attributes, using omit-to-inherit semantics:

    sentinel value to clear, omit to inherit:
    - XFRMA_ENCAP              : encap_type=0 to clear
    - XFRMA_OFFLOAD_DEV        : ifindex=0 to clear

omit to inherit; send attr with value 0/0 to clear:
    - XFRMA_SET_MARK / XFRMA_SET_MARK_MASK
    - XFRMA_MARK               : omit-to-inherit old_mark; note XFRMA_MARK
                                 serves dual purpose -- old_mark in the
                                 fixed header is the SA lookup key, and
                                 XFRMA_MARK attribute sets the new mark.

set to zero to move from NAT to no-NAT; inherit when absent:
    - XFRMA_NAT_KEEPALIVE_INTERVAL
    - XFRMA_MTIMER_THRESH

omit to inherit; send 0 to clear:
    - XFRMA_TFCPAD             : TFC padding
    - XFRMA_SA_EXTRA_FLAGS     : e.g. DONT_ENCAP_DSCP, OSEQ_MAY_WRAP;
                                 yes, these can change.
    - XFRMA_IF_ID              : xfrm interface ID; relevant when the SA
                                 moves to a different xfrm interface.
    - XFRMA_COADDR             : Care-of Address (Mobile IPv6).

    - XFRMA_REPLAY_ESN_VAL / XFRMA_REPLAY_VAL : may be later replay type 
      should not change.


Basic migration supported via fixed header fields (new_* fields):
    - src and dst address family
    - src and/or dst address
    - reqid

I also added old_mark to the SA lookup alongside the SPI, so the SA
can be uniquely identified when marks are in use. XFRMA_MARK can then
be used to set the new mark value independently.

regards,
-antony

> 
> On Fri, Feb 27, 2026 at 3:26 AM Sabrina Dubroca <sd@queasysnail.net> wrote:
> >
> > 2026-02-26, 17:44:51 -0800, Yan Yan via Devel wrote:
> > > Hi Antony,
> > >
> > > May I request that we also support updating the XFRMA_SET_MARK as part
> > > of the new XFRM_MSG_MIGRATE_STATE message?
> > >
> > > In Android, the primary use case for migration is switching the
> > > underlying physical network for an IPsec tunnel (e.g. VPN, Wifi
> > > calling). Currently, due to the limits of XFRM_MSG_MIGRATE, we are
> > > forced to use a separate UPDSA call to update the set-mark. Supporting
> > > XFRMA_SET_MARK within the migrate message would allow us to update the
> > > addresses and the routing mark together in one atomic call.
> > >
> > > Regarding the logic, I believe the set-mark can follow the same
> > > omit-to-clear pattern as XFRMA_ENCAP and XFRMA_OFFLOAD_DEV.
> >
> > I think this raises a wider question: clearly definining and
> > documenting which attributes need to be explicitly provided
> > ("omit-to-clear" as you write), and which will be implicitly copied.
> >
> > Currently it looks like we copy:
> >  - all the crypto stuff (aalg/aead/etc)
> >  - security context stuff
> >  - coaddr
> >  - replay/replay_esn
> >  - pcpu_num, if_id, tfcpad
> >  - dir
> >  - mark
> >  - extra_flags
> >
> > but not
> >  - nat_keepalive_interval
> >  - offload
> >  - encap
> >
> > [gathered from a quick read of xfrm_state_clone_and_setup + the
> > definition of xfrma_policy]
> >
> > Anything that we leave as implicit copy will have to be "forever"
> > implicitly copied with this new MIGRATE_STATE op -- unless we find a
> > way to pass a new "clear these properties" flag (probably via a list
> > of XFRMA_* attribute names), but then we could also implement that
> > with the existing MIGRATE code.
> >
> > --
> > Sabrina
> 
> 
> 
> --
> --
> Best,
> Yan
> -- 
> Devel mailing list -- devel@lists.linux-ipsec.org
> To unsubscribe send an email to devel-leave@lists.linux-ipsec.org
