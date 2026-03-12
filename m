Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB380302165;
	Thu, 12 Mar 2026 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333721; cv=none; b=bwSgRaE5qitckVxpwwryaNAqPHy38bcdyoVACUxQcqe1M5dVGpAiZCXDQdyVoPUdGZ4tXTMDsPUm8x7QanqekqUuTmU2Lhv5o1wPnqRWIa3ApeL7YWUHYSp/6Vvl8NVni/SNtmZGnCjaB6XTC3/krCERY4wDcB3Bd7ufITcT044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333721; c=relaxed/simple;
	bh=VFVApfv21FiWkANMhfUKrWN7JISt2PdOs46M5JzpQvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UV//bg3CaBFDY9vEe+bLXhzHo4Q7WW6Gg3apKudqWjwufUWsnl+JZBXv6nZ5zaBHM4yeLEe7MQQrzWi4qBesQ73BLH9hW2/ODgyZOSKfb3BE/V/HreJ3DKZ8kmGzY2DroqoxGTLMrvumtR+S1SKQ6ThmW/yocX/ttIMzbrud2Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoOXAdZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoOXAdZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B58C4CEF7;
	Thu, 12 Mar 2026 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773333721;
	bh=VFVApfv21FiWkANMhfUKrWN7JISt2PdOs46M5JzpQvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XoOXAdZSmhlP84Iviilz7IKwq6poxwZf0EUcJiPS1688CKBqqOwvo236tL7BNj7iO
	 +3uZVBbyAFhG6hhiI6EK0OY/zPC+vgoh1ZkcoonEvdgKabUNwXByLErRc/iWo1v0+P
	 eNA6b/PHhZl3Oz6m0Kh/gl0v9dJFE4IjHdTWWNaQGEWJjTEobohz0FhoBYgFIpZ+SX
	 Ko/3xopA3zeHgYPsHc6pc5mkebM2XCrH51XD/sof+uLteF67EPyMGrZzQUbXlHwmhY
	 OGuovWM8MXjiV/BaGMebOeKS8qkEQyAvMcAkwPjLVFtBdUjaXraJiCfF86uGGiNYD7
	 KaNwg96OcXwLg==
Date: Thu, 12 Mar 2026 16:41:54 +0000
From: Simon Horman <horms@kernel.org>
To: Antony Antony <antony@phenome.org>
Cc: antony.antony@secunet.com, evitayan@google.com,
	linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	herbert@gondor.apana.org.au, paul@paul-moore.com,
	devel@linux-ipsec.org, davem@davemloft.net, nakam@linux-ipv6.org,
	netdev@vger.kernel.org, edumazet@google.com,
	stephen.smalley.work@gmail.com, steffen.klassert@secunet.com,
	selinux@vger.kernel.org, linux-doc@vger.kernel.org,
	chiachangwang@google.com, omosnace@redhat.com, corbet@lwn.net,
	dsahern@kernel.org, skhan@linuxfoundation.org
Subject: Re: [devel-ipsec] Re: [ipsec-next,v6,12/14] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <20260312164154.GW461701@kernel.org>
References: <migrate-state-v6-12-9df9764ddb9e@secunet.com>
 <20260311195731.1147919-1-horms@kernel.org>
 <abHT2HLx-BvKnu-c@Antony2201.local>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abHT2HLx-BvKnu-c@Antony2201.local>

On Wed, Mar 11, 2026 at 09:43:04PM +0100, Antony Antony wrote:
> Hi Simon,
> 
> On Wed, Mar 11, 2026 at 07:57:31PM +0000, Simon Horman via Devel wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > 
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> > ---
> > xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
> > 
> > This patch adds a new netlink method to migrate a single xfrm_state.
> > Unlike the existing migration mechanism (SA + policy), this supports
> > migrating only the SA and allows changing the reqid.
> > 
> > > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > > index 4b29ab92c2a7..ae2a1cf2311a 100644
> > > --- a/include/net/xfrm.h
> > > +++ b/include/net/xfrm.h
> > > @@ -683,11 +683,17 @@ struct xfrm_migrate {
> > >  	xfrm_address_t		new_daddr;
> > >  	xfrm_address_t		new_saddr;
> > >  	struct xfrm_encap_tmpl *encap;
> > > -	struct xfrm_user_offload *xuo;
> > > +	struct xfrm_user_offload xuo;
> > 
> > [ ... ]
> > 
> > > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > > index 2f23ca5b62a9..de8b038fc08c 100644
> > > --- a/net/xfrm/xfrm_policy.c
> > > +++ b/net/xfrm/xfrm_policy.c
> > > @@ -4642,6 +4642,19 @@ static int xfrm_migrate_check(const struct xfrm_migrate *m, int num_migrate,
> > >  	return 0;
> > >  }
> > >
> > > +/* Fill migrate fields that are invariant in XFRM_MSG_MIGRATE: inherited
> > > + * from the existing SA unchanged.
> > > + */
> > > +static void xfrm_migrate_copy_old(struct xfrm_migrate *mp,
> > > +				  const struct xfrm_state *x)
> > > +{
> > > +	mp->smark                  = x->props.smark;
> > > +	mp->new_reqid              = x->props.reqid;
> > > +	mp->nat_keepalive_interval = x->nat_keepalive_interval;
> > > +	mp->mapping_maxage         = x->mapping_maxage;
> > > +	mp->new_mark               = x->mark;
> > > +}
> > > +
> > >  int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
> > >  		 struct xfrm_migrate *m, int num_migrate,
> > >  		 struct xfrm_kmaddress *k, struct net *net,
> > > @@ -4680,7 +4693,10 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
> > >  			x_cur[nx_cur] = x;
> > >  			nx_cur++;
> > >  			mp->encap = encap;
> > > -			mp->xuo = xuo;
> > > +			if (xuo)
> > > +				mp->xuo = *xuo;
> >                                      ^^^^
> > >  			xfrm_migrate_copy_old(mp, x);
> > >
> > 
> > What happens to mp->xuo when xuo is NULL?
> 
> thanks. I also red this on NIPA AI reviews. I will fix it in the next 
> version.

Thanks, good to know.

> 
> > 
> > The xfrm_migrate structure changed its xuo field from a pointer
> > (struct xfrm_user_offload *xuo) to an embedded value
> > (struct xfrm_user_offload xuo).
> > 
> > In xfrm_migrate(), when the xuo parameter is NULL (PF_KEY path via
> > pfkey_migrate, or XFRM_MSG_MIGRATE without XFRMA_OFFLOAD_DEV), the
> > 'if (xuo) mp->xuo = *xuo' branch is skipped, leaving mp->xuo with
> > uninitialized stack data.
> > 
> > Both callers declare 'struct xfrm_migrate m[XFRM_MAX_DEPTH]' on the
> > stack without zeroing:
> > 
> > net/key/af_key.c:pfkey_migrate() {
> >     struct xfrm_migrate m[XFRM_MAX_DEPTH];
> >     ...
> >     err = xfrm_migrate(&sel, dir, XFRM_POLICY_TYPE_MAIN, m, i,
> >                        k.local && k.remote ? &k : NULL, net,
> >                        NULL, 0, NULL);
> > }
> > 
> > net/xfrm/xfrm_user.c:xfrm_do_migrate() {
> >     struct xfrm_migrate m[XFRM_MAX_DEPTH];
> 
> -  struct xfrm_migrate m[XFRM_MAX_DEPTH];
> +  struct xfrm_migrate m[XFRM_MAX_DEPTH] = {};
> 
> this should fix it.

Yes, I agree that should fix the problem.

> 
> >     ...
> >     err = xfrm_migrate(&sel, dir, type, m, n, k, net, encap, xuo, extack);
> > }

...
