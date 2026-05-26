Received: from oak.phenome.org (oak.phenome.org [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204CE3C0A11;
	Tue, 26 May 2026 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822460; cv=none; b=FoTfpXJruBCOY0IqnS3gwDrSwp+qQNsXixMj1p2mldk4YFk4PIL00xqc4hPXLBGU7NVG8IU7t3GvGJNN5LuLS1m26NGzTEsYFuMVtPgz7PsrA6dPYWsOHv/imr1Fa2X0PPAi5OCFhyOSbnyIdYcgkNArjFATWMmqwzF9WD+dtKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822460; c=relaxed/simple;
	bh=M/g5qZJAEi3c0rfXk/iGFYVZpdLPlDrwWEcToZ1Muw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTD+ZviWKwwyMr1WGJv0sQueTanGwkPPBFpJ4qli34T0hqGgJcGuTrlAKI+B+xdnKor8meiHdwVLNL1SLrzsYKwWWKwwm+hauRrS3rDZRdv5iv5tnxCLfFouarFo3bZoOwqnTQFL5RUXKtZrYeBhPW9jsCxRg9qxQYp0WOPL9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=nGrIY5vx; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="nGrIY5vx"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received; s=oak1; t=
	1779822100; x=1780686101; bh=M/g5qZJAEi3c0rfXk/iGFYVZpdLPlDrwWEc
	ToZ1Muw8=; b=nGrIY5vx1rXmnNUZGjHv9MnabMFkaZtEgQWFNG5dwhF0Xds0/LI
	2su/3AdgVLFjsAwqEC7SQ+Rx1YWDccGzNGrLUIJhrpcwb6YCR+Hn0fjs+pBdvJoL
	EbzHgIdaapUc/FgGSIPmnMuSSo33q87VZvOTLbe0eDO4AZtTwluL9Lw4IelPOA0v
	4gcyIPH7sNqMORPh7uFRAsnGcfUZVRWT9kVQF0UnxyTTc9pbY/IBuB156WnYl5zQ
	I+uLmjkjJoG+RImahCaGP+qHFtsW53bMpFvopTrYXzsLFDQZV+cyUmhkYFc3QINh
	3SLvXBNcKgXhO64friL3of5Lkebp2NPQDxw==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Tue, 26 May 2026 21:01:37 +0200 (CEST)
Date: Tue, 26 May 2026 21:01:35 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
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
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v8 12/14] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <ahXuD2XrvCzN5HyR@Antony2201.local>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-12-4578fb016965@secunet.com>
 <agGdwbo2GFhPP78z@krikkit>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agGdwbo2GFhPP78z@krikkit>

On Mon, May 11, 2026 at 11:13:37AM +0200, Sabrina Dubroca wrote:
> 2026-05-05, 06:34:29 +0200, Antony Antony wrote:
>
> [...]
>  include/net/xfrm.h          |  16 ++-
>  include/uapi/linux/xfrm.h   |  21 ++++
>  net/xfrm/xfrm_device.c      |   2 +-
>  net/xfrm/xfrm_policy.c      |  19 +++
>  net/xfrm/xfrm_state.c       |  29 +++--
>  net/xfrm/xfrm_user.c        | 281 +++++++++++++++++++++++++++++++++++++++++++-
>  security/selinux/nlmsgtab.c |   3 +-
>  7 files changed, 357 insertions(+), 14 deletions(-)
>
> If the omission of xfrm_compat.c is intentional, maybe worth
> making a note of that?

Fixed in v9.

> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> @@ -684,12 +684,20 @@ struct xfrm_migrate {
> +	struct xfrm_mark        old_mark;
> +	struct xfrm_mark       *new_mark;
> +	struct xfrm_mark        smark;
> +	u16			msg_type;
> +	u32			flags;
> +	u32			new_reqid;
> +	u32			nat_keepalive_interval;
> +	u32			mapping_maxage;
> +	const struct xfrm_selector *new_sel;
>
> afkey doesn't zero its array of xfrm_migrate, so those new fields will
> contain garbage there. Hopefully nobody is using it, but...

Fixed in v9: set msg_type = XFRM_MSG_MIGRATE explicitly in
xfrm_migrate_copy_old() so the PF_KEY path always takes the correct
selector branch regardless of whether the caller zeroes the array.

> @@ -2104,7 +2112,7 @@
> -		       struct xfrm_user_offload *xuo,
> +		       const struct xfrm_user_offload *xuo,
>
> nit: unrelated clean up

Split out into a separate patch in v9.

> +/* Flags for xfrm_user_migrate_state.flags */
> +enum xfrm_migrate_state_flags {
> +	XFRM_MIGRATE_STATE_NO_OFFLOAD = 1,
>
> nit: maybe XFRM_MIGRATE_STATE_CLEAR_OFFLOAD?

Done in v9.

> +	XFRM_MIGRATE_STATE_UPDATE_SEL = 2,
>
> "update sel" to me sounds more like "overwrite the whole thing" than
> "copy some bits, fix up others". The name is already long, but maybe
> "XFRM_MIGRATE_STATE_UPDATE_H2H_SEL"?

Done in v9.

> +static void xfrm_migrate_copy_old(struct xfrm_migrate *mp,
> +				  const struct xfrm_state *x,
> +				  struct xfrm_mark *new_mark_buf)
> +{
> +	*new_mark_buf              = x->mark;
> +	mp->new_mark               = new_mark_buf;
>
> Do you really need a separate buffer for that? Or could you just use
>     mp->new_mark = &x->mark;
> and skip the new_marks array in xfrm_migrate()?
> I find that new_marks array quite ugly, so I'd like to get rid of
> it. If that doesn't work, I'd prefer to stuff new_mark_buf directly
> inside struct xfrm_migrate, and then set mp->new_mark pointing to it.

Done in v9: new_marks[] removed, mp->new_mark = &x->mark directly.
new_mark in struct xfrm_migrate changed to const struct xfrm_mark *.

> +			xfrm_migrate_copy_old(mp, x, &new_marks[i]);
>
> nit: maybe swap mp and x, just to match the order of xfrm_state_migrate()?
>
> It would also be a bit easier to review if you split this refactoring
> (and the corresponding changes to xfrm_state_clone_and_setup) into a
> separate patch.

> -	memcpy(&x->sel, &orig->sel, sizeof(x->sel));
> +	...
> +		} else {
> +			x->sel = *m->new_sel;
>
> nit: the mix of copy styles (memcpy and struct assignment) within this
> function, but especially here for x->sel, is a bit unpleasant.

fixed.

> -	struct xfrm_migrate m[XFRM_MAX_DEPTH];
> +	struct xfrm_migrate m[XFRM_MAX_DEPTH] = {};
>
> I'm not really opposed to this change, but what prompted it?

It was prompted after v6 review — when xuo was an embedded struct,
mp->xuo.ifindex could be uninitialized when xuo was NULL. However, in
v9 xuo reverted to a pointer, so the = {} is no longer necessary, kept it
as defensive programming.


> +	if ((um->flags & XFRM_MIGRATE_STATE_NO_OFFLOAD) &&
> +	    attrs[XFRMA_OFFLOAD_DEV]) {
>
> Not a strong objection, but they don't really have to be? "don't
> inherit and set it from the one provided" sounds ok.
> XFRMA_OFFLOAD_DEV with !XFRM_MIGRATE_STATE_NO_OFFLOAD (inherit and
> also set from request) seems more problematic.

Agreed. Exclusivity check dropped in v9. XFRMA_OFFLOAD_DEV takes
precedence via if/else so NO_OFFLOAD is redundant when both are set.
The "inherit AND set" case doesn't exist in the code.

> +		if (x->sel.prefixlen_s != x->sel.prefixlen_d ||
> +		    x->sel.prefixlen_d != prefixlen ||
> +		    !xfrm_addr_equal(&x->sel.daddr, &x->id.daddr, x->sel.family) ||
> +		    !xfrm_addr_equal(&x->sel.saddr, &x->props.saddr, x->sel.family)) {
>
> I think we need to be careful about families here too. id and sel
> could have different ones.

Fixed in v9: use x->props.family for prefixlen and xfrm_addr_equal.
AF_UNSPEC selector falls through to IPv4 comparison — this fixes it.
Mixed-family transport mode sounds odd and hopefully not allowed in
practice; this fix rejects it naturally.

> +	if (attrs[XFRMA_NAT_KEEPALIVE_INTERVAL] &&
> +	    nla_get_u32(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL]) && !m.encap) {
>
> if (nla_get_u32_default(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL], 0) && !m.encap)

> +	} else if (!(um->flags & XFRM_MIGRATE_STATE_NO_OFFLOAD) && x->xso.dev) {
>
> nit: this would be a bit more readable with
>     bool inherit_offload = !(um->flags & XFRM_MIGRATE_STATE_NO_OFFLOAD);
>
> copy_user_offload is doing almost exactly the same thing (copy from
> and xso to an xuo). It would be better to extract some helper
> (xso_to_xuo() ?) and use it in both places, otherwise they'll almost
> certainly get out of sync.

Done in v9.

> +	m.mapping_maxage = attrs[XFRMA_MTIMER_THRESH] ?
> +		nla_get_u32(attrs[XFRMA_MTIMER_THRESH]) : x->mapping_maxage;
>
> m.mapping_maxage = nla_get_u32_default(attrs[XFRMA_MTIMER_THRESH], x->mapping_maxage);

thanks.

> +	m.nat_keepalive_interval = attrs[XFRMA_NAT_KEEPALIVE_INTERVAL] ?
> +		nla_get_u32(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL]) :
> +		x->nat_keepalive_interval;
>
> m.nat_keepalive_interval = nla_get_u32_default(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL], x->nat_keepalive_interval);

fixed in v9

-antony
