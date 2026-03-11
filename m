Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42233D501;
	Wed, 11 Mar 2026 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261800; cv=none; b=T7iyAoD5QrJBZ+2c2n3I73ggv89CyZjrjD2ofmybgfqIHMgE7uvR0u6ITYV/ttrV3u62EPpKFrvCFWmhnXoHd8k7KHhcJdbCh4x2A2m2AEA7PXDw6LKdko2olFdrWiUCd1i13WBTicx1+hui65ipvGMyzy+0l+1ZE7gcbPXFDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261800; c=relaxed/simple;
	bh=K2UPoZ3AQus8f8/byrx4bf7R8jiPRJuprbDp/3VZiuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvjCINcrmCctBJJXcxoIiyVdZYvTP4kf7SABvL03WhFGl5Rj51WKQcbW1E/KzU9nxoogHyGMjqo3G/ed6KuZlvCj8sgPfB1Df4x3Q0HMyRmEbK+uzYLfq5l93kjq3nM51Ezf1U4wQrjAoM7vBnCD3Se4ZU/Y4Ghul54yWSDfd0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=Rl6bTBVQ; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="Rl6bTBVQ"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1773261789; x=1774125790; bh=K2UP
	oZ3AQus8f8/byrx4bf7R8jiPRJuprbDp/3VZiuY=; b=Rl6bTBVQXERqYGBuW+Ci
	OyRuddDOwsNd6zvhTeZxE+OzIwXXKKTB+DmyIj2VzopxB0vteqoHhQAUBtA309ci
	CSmm4ICnS7nWSviYBRSFaKDtuFjHwFuG+8lE0R0gkU7aHLoPl7I6wSX+CxQY9bbm
	XEqcDe63ugf3mG+/DOrr1EOiSUROjiFcfRVX/8+2KO3ix/2IcC5pn5hNqacmvVvP
	YFOqyLid/bm8G1VTWqG11O2PiqMplH4MvMhyYDX5vMA4pRDCJRWyrb6WHEnhfbXt
	ja6QpyP7qDMdeQ0cimuw/JSzwgACt97gxGjxoCio5Wjoteb71Dc1gLvarkpXwPLP
	lg==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Wed, 11 Mar 2026 21:43:06 +0100 (CET)
Date: Wed, 11 Mar 2026 21:43:04 +0100
From: Antony Antony <antony@phenome.org>
To: Simon Horman <horms@kernel.org>
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
Message-ID: <abHT2HLx-BvKnu-c@Antony2201.local>
References: <migrate-state-v6-12-9df9764ddb9e@secunet.com>
 <20260311195731.1147919-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311195731.1147919-1-horms@kernel.org>

Hi Simon,

On Wed, Mar 11, 2026 at 07:57:31PM +0000, Simon Horman via Devel wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
> 
> This patch adds a new netlink method to migrate a single xfrm_state.
> Unlike the existing migration mechanism (SA + policy), this supports
> migrating only the SA and allows changing the reqid.
> 
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index 4b29ab92c2a7..ae2a1cf2311a 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -683,11 +683,17 @@ struct xfrm_migrate {
> >  	xfrm_address_t		new_daddr;
> >  	xfrm_address_t		new_saddr;
> >  	struct xfrm_encap_tmpl *encap;
> > -	struct xfrm_user_offload *xuo;
> > +	struct xfrm_user_offload xuo;
> 
> [ ... ]
> 
> > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > index 2f23ca5b62a9..de8b038fc08c 100644
> > --- a/net/xfrm/xfrm_policy.c
> > +++ b/net/xfrm/xfrm_policy.c
> > @@ -4642,6 +4642,19 @@ static int xfrm_migrate_check(const struct xfrm_migrate *m, int num_migrate,
> >  	return 0;
> >  }
> >
> > +/* Fill migrate fields that are invariant in XFRM_MSG_MIGRATE: inherited
> > + * from the existing SA unchanged.
> > + */
> > +static void xfrm_migrate_copy_old(struct xfrm_migrate *mp,
> > +				  const struct xfrm_state *x)
> > +{
> > +	mp->smark                  = x->props.smark;
> > +	mp->new_reqid              = x->props.reqid;
> > +	mp->nat_keepalive_interval = x->nat_keepalive_interval;
> > +	mp->mapping_maxage         = x->mapping_maxage;
> > +	mp->new_mark               = x->mark;
> > +}
> > +
> >  int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
> >  		 struct xfrm_migrate *m, int num_migrate,
> >  		 struct xfrm_kmaddress *k, struct net *net,
> > @@ -4680,7 +4693,10 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
> >  			x_cur[nx_cur] = x;
> >  			nx_cur++;
> >  			mp->encap = encap;
> > -			mp->xuo = xuo;
> > +			if (xuo)
> > +				mp->xuo = *xuo;
>                                      ^^^^
> >  			xfrm_migrate_copy_old(mp, x);
> >
> 
> What happens to mp->xuo when xuo is NULL?

thanks. I also red this on NIPA AI reviews. I will fix it in the next 
version.

> 
> The xfrm_migrate structure changed its xuo field from a pointer
> (struct xfrm_user_offload *xuo) to an embedded value
> (struct xfrm_user_offload xuo).
> 
> In xfrm_migrate(), when the xuo parameter is NULL (PF_KEY path via
> pfkey_migrate, or XFRM_MSG_MIGRATE without XFRMA_OFFLOAD_DEV), the
> 'if (xuo) mp->xuo = *xuo' branch is skipped, leaving mp->xuo with
> uninitialized stack data.
> 
> Both callers declare 'struct xfrm_migrate m[XFRM_MAX_DEPTH]' on the
> stack without zeroing:
> 
> net/key/af_key.c:pfkey_migrate() {
>     struct xfrm_migrate m[XFRM_MAX_DEPTH];
>     ...
>     err = xfrm_migrate(&sel, dir, XFRM_POLICY_TYPE_MAIN, m, i,
>                        k.local && k.remote ? &k : NULL, net,
>                        NULL, 0, NULL);
> }
> 
> net/xfrm/xfrm_user.c:xfrm_do_migrate() {
>     struct xfrm_migrate m[XFRM_MAX_DEPTH];

-  struct xfrm_migrate m[XFRM_MAX_DEPTH];
+  struct xfrm_migrate m[XFRM_MAX_DEPTH] = {};

this should fix it.

>     ...
>     err = xfrm_migrate(&sel, dir, type, m, n, k, net, encap, xuo, extack);
> }
> 
> The uninitialized mp->xuo.ifindex is later read in
> xfrm_state_migrate_create() and xfrm_state_migrate_install():
> 
> net/xfrm/xfrm_state.c:xfrm_state_migrate_create() {
>     ...
>     /* configure the hardware if offload is requested */
>     if (m->xuo.ifindex && xfrm_dev_state_add(net, xc, &m->xuo, extack))
>         goto error;
> }
> 
> net/xfrm/xfrm_state.c:xfrm_state_migrate_install() {
>     ...
>     if (xfrm_state_add(xc) < 0) {
>         NL_SET_ERR_MSG(extack, "Failed to add migrated state");
>         if (m->xuo.ifindex)
>             xfrm_dev_state_delete(xc);
>         ...
>     }
> }
> 
> If the stack garbage contains a non-zero ifindex value,
> xfrm_dev_state_add() will be called with random ifindex and flags,
> potentially causing spurious hardware offload attempts or migration
> failures.
> 
> Previously, 'mp->xuo = xuo' unconditionally set the pointer to NULL in
> these paths, which was then properly checked as 'if (m->xuo)'.
> 
> Should mp->xuo be zero-initialized when xuo is NULL, either by adding
> 'else memset(&mp->xuo, 0, sizeof(mp->xuo))' after the if-block, or by
> zero-initializing the m[] arrays in the callers?

thanks,
-antony
