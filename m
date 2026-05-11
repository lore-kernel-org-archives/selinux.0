Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA293AA1A1;
	Mon, 11 May 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490827; cv=none; b=LPFJKUCvEFB6TZAYzcucmgQuFZXjPL7k3wVFufHtw2YJD7fqEyx94NhW4crxSxLawSQJLPQCtdrXDJxfKL52jr/XuZ36ghIVVSt5Z37RJpHnR3Kz7RDSwKmWMNmtknzlElbmIQGAiChGdzAw6A4RQZwXoSZewqZF4X7d9pReS/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490827; c=relaxed/simple;
	bh=qf/SbQn1jGFBBGGSETlOsx5iiJ1jHVImvSbUVVSTUB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGLVnFf3KiQkaQhlE0zu0kU6TQZR07FdmSSKtq8mJaTUfXz04nchjHLbtlEs3QSS6bWmlqAMgu0i9cZMBOqrEUrBQSs/vmiRRUdFADSwRU063ePgGD4IYnE6E0rvKqHxLcBu6QDE7BHP9VIjoAyDq4g+fycTOh4VdWsSfe4Hq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=YGWPYOSG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q/il3wTy; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="YGWPYOSG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q/il3wTy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id DD31813801C3;
	Mon, 11 May 2026 05:13:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 05:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778490821; x=
	1778498021; bh=oG1CScb7r9i2f+vs6+tHiK4YQ7SVJ+GUiKslUmUQvBw=; b=Y
	GWPYOSGLBR0jTihk3TMfP6Sm2Nm1e8xVTJOUf09OvI8Y5f5u+pDstgK5mXrUjIhv
	v/1RhkAnf/9O5sPaonypIUiMgJYZu2CNVu/yyAyE0xQdB3kNZRxuf+sTpJ7cqW60
	t29fJkbTlUBzK52Bc+S92HEichTYhAksJD5NXjBCPtD5GTln9IFMVgvycgQnam9X
	yeGZWFhvSGAj3Qq4h+4UMQHZizOoX+cAgsSXMr54hRffXDbS8MAIFgfgJid2ugfW
	LblU8lPZBnMC7hMr5+CLjaKSs9PQO2EzwsPmbPc7myKNiZsoRaXJK2ugwGfjj6cB
	G/zmwTShkVKiIdBLx4fyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778490821; x=1778498021; bh=oG1CScb7r9i2f+vs6+tHiK4YQ7SVJ+GUiKs
	lUmUQvBw=; b=Q/il3wTyZZuc86xDqbBYJuIlFR92dwM7unbc59UANniNRwbMGt+
	jyuanN/I7L6fSWbmdzaPYevCOyPH3lv0V+tKAuxgzQ90ikgipOXqP6WQKacFY80C
	43FP4dQsHjcTIdUmRd4A4RvlGBRmQqwfGyFbzG1fIpq8oYVgonKMEl7RoDqxBZQq
	hrrc8fBz3bjeUWX2SHIMqFOBLkObTNBkigbnCP9ne+eKKE4CfBLl6sDqCmXgm+/1
	JEqsIYgwjaVD1qHlOTfWuAXXWxSenwxp8bZmblLxZrbvh6XQ47q/1RwVgDaIzBZX
	xv9gfrhxn5VIcCip6+dDMekk5Q2dReBGP0g==
X-ME-Sender: <xms:xJ0BagiZ-zAQ-3goGft4Gk4WFXYb-km9TaORQhkmRh-ErRk9UJsmmw>
    <xme:xJ0Baqpfxv_OVcPMPK4WLnZSP8bcKj9wQhuHYNz6cffrbw72Fgnn6pmDhFjFMM2KP
    OhIJUzPlF8EA4BNG2EQGdnhNo_j4lJDHatRr63L7owjEcWUzKiNhYj_>
X-ME-Received: <xmr:xJ0BasJc4yTSxSiTsPaSZ19zEQbRGHwyE5bWjHJaQzuUwLuTqhq-QH-G8sZZBvxfVqowqc_0sJTe7PGgWyGjNsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekheeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:xJ0BantxDn8HL-wKBcK7i8TiJPbjYn1ipV1xLJdW0XVEQh68BWo-Xw>
    <xmx:xJ0BastveSgh53GwbB3MVostjOGt0UL7AL4velhiHsrE5uPHWRghJQ>
    <xmx:xJ0BauXumXHy5dUw2OdT7_b18fjaVbk1Eb5bZGM4nAkfFZCoTPc3Jw>
    <xmx:xJ0BalWGdNS61BK3nnQ3Adf6ftQ7rwD2_hp5lDIRZAz45kwYpMQjJg>
    <xmx:xZ0BaomnMoVObO4lyaHS0RWsUvtAQgLDpIxObW6yA8bi6rvisxhEun5O>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 05:13:39 -0400 (EDT)
Date: Mon, 11 May 2026 11:13:37 +0200
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
Subject: Re: [PATCH ipsec-next v8 12/14] xfrm: add XFRM_MSG_MIGRATE_STATE for
 single SA migration
Message-ID: <agGdwbo2GFhPP78z@krikkit>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-12-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <migrate-state-v8-12-4578fb016965@secunet.com>

2026-05-05, 06:34:29 +0200, Antony Antony wrote:
> Add a new netlink method to migrate a single xfrm_state.
> Unlike the existing migration mechanism (SA + policy), this
> supports migrating only the SA and allows changing the reqid.
> 
> The SA is looked up via xfrm_usersa_id, which uniquely
> identifies it, so old_saddr is not needed. old_daddr is carried in
> xfrm_usersa_id.daddr.
> 
> The reqid is invariant in the old migration.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> 

[...]
>  include/net/xfrm.h          |  16 ++-
>  include/uapi/linux/xfrm.h   |  21 ++++
>  net/xfrm/xfrm_device.c      |   2 +-
>  net/xfrm/xfrm_policy.c      |  19 +++
>  net/xfrm/xfrm_state.c       |  29 +++--
>  net/xfrm/xfrm_user.c        | 281 +++++++++++++++++++++++++++++++++++++++++++-
>  security/selinux/nlmsgtab.c |   3 +-
>  7 files changed, 357 insertions(+), 14 deletions(-)

If the omission of xfrm_compat.c is intentional, maybe worth
making a note of that?


> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 4b29ab92c2a7..e33e524cd909 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -684,12 +684,20 @@ struct xfrm_migrate {
>  	xfrm_address_t		new_saddr;
>  	struct xfrm_encap_tmpl *encap;
>  	struct xfrm_user_offload *xuo;
> +	struct xfrm_mark        old_mark;
> +	struct xfrm_mark       *new_mark;
> +	struct xfrm_mark        smark;
>  	u8			proto;
>  	u8			mode;
> -	u16			reserved;
> +	u16			msg_type; /* XFRM_MSG_MIGRATE or XFRM_MSG_MIGRATE_STATE */
> +	u32			flags;
>  	u32			old_reqid;
> +	u32			new_reqid;
> +	u32			nat_keepalive_interval;
> +	u32			mapping_maxage;
>  	u16			old_family;
>  	u16			new_family;
> +	const struct xfrm_selector *new_sel;
>  };

afkey doesn't zero its array of xfrm_migrate, so those new fields will
contain garbage there. Hopefully nobody is using it, but...


> @@ -2104,7 +2112,7 @@ void xfrm_dev_resume(struct sk_buff *skb);
>  void xfrm_dev_backlog(struct softnet_data *sd);
>  struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t features, bool *again);
>  int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
> -		       struct xfrm_user_offload *xuo,
> +		       const struct xfrm_user_offload *xuo,
>  		       struct netlink_ext_ack *extack);

nit: unrelated clean up


> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index a23495c0e0a1..34d8ad5c4818 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
[...]
> +/* Flags for xfrm_user_migrate_state.flags */
> +enum xfrm_migrate_state_flags {
> +	XFRM_MIGRATE_STATE_NO_OFFLOAD = 1, /* do not inherit offload from existing SA */

nit: maybe XFRM_MIGRATE_STATE_CLEAR_OFFLOAD?

> +	XFRM_MIGRATE_STATE_UPDATE_SEL = 2, /* update host-to-host selector from saddr and daddr */

"update sel" to me sounds more like "overwrite the whole thing" than
"copy some bits, fix up others". The name is already long, but maybe
"XFRM_MIGRATE_STATE_UPDATE_H2H_SEL"? (if only so that userspace devs
don't think they know what "update sel" means, so they have to read
the doc instead of possibly guessing wrong :))


> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index cf05d778e2dd..9ecc4c8ba693 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4643,6 +4643,22 @@ static int xfrm_migrate_check(const struct xfrm_migrate *m, int num_migrate,
>  	return 0;
>  }
>  
> +/*
> + * Fill migrate fields that are invariant in XFRM_MSG_MIGRATE: inherited
> + * from the existing SA unchanged. XFRM_MSG_MIGRATE_STATE can update these.
> + */
> +static void xfrm_migrate_copy_old(struct xfrm_migrate *mp,
> +				  const struct xfrm_state *x,
> +				  struct xfrm_mark *new_mark_buf)
> +{
> +	mp->smark                  = x->props.smark;
> +	mp->new_reqid              = x->props.reqid;
> +	mp->nat_keepalive_interval = x->nat_keepalive_interval;
> +	mp->mapping_maxage         = x->mapping_maxage;
> +	*new_mark_buf              = x->mark;
> +	mp->new_mark               = new_mark_buf;

Do you really need a separate buffer for that? Or could you just use

    mp->new_mark = &x->mark;

and skip the new_marks array in xfrm_migrate()?

I find that new_marks array quite ugly, so I'd like to get rid of
it. If that doesn't work, I'd prefer to stuff new_mark_buf directly
inside struct xfrm_migrate, and then set mp->new_mark pointing to it.


> +}
> +
>  int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>  		 struct xfrm_migrate *m, int num_migrate,
>  		 struct xfrm_kmaddress *k, struct net *net,
> @@ -4650,6 +4666,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>  		 struct netlink_ext_ack *extack, struct xfrm_user_offload *xuo)
>  {
>  	int i, err, nx_cur = 0, nx_new = 0;
> +	struct xfrm_mark new_marks[XFRM_MAX_DEPTH] = {};
>  	struct xfrm_policy *pol = NULL;
>  	struct xfrm_state *x, *xc;
>  	struct xfrm_state *x_cur[XFRM_MAX_DEPTH];
> @@ -4682,6 +4699,8 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>  			nx_cur++;
>  			mp->encap = encap;
>  			mp->xuo = xuo;
> +			xfrm_migrate_copy_old(mp, x, &new_marks[i]);

nit: maybe swap mp and x, just to match the order of xfrm_state_migrate()?

It would also be a bit easier to review if you split this refactoring
(and the corresponding changes to xfrm_state_clone_and_setup) into a
separate patch.


> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 043e573c4f32..44244bd323ea 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1974,11 +1974,25 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
>  		goto out;
>  
>  	memcpy(&x->id, &orig->id, sizeof(x->id));
> -	memcpy(&x->sel, &orig->sel, sizeof(x->sel));
> +	if (m->msg_type == XFRM_MSG_MIGRATE_STATE) {
> +		if (m->flags & XFRM_MIGRATE_STATE_UPDATE_SEL) {
> +			u8 prefixlen = (m->new_family == AF_INET6) ? 128 : 32;
> +
> +			memcpy(&x->sel, &orig->sel, sizeof(x->sel));
> +			x->sel.family      = m->new_family;
> +			x->sel.prefixlen_d = prefixlen;
> +			x->sel.prefixlen_s = prefixlen;
> +			memcpy(&x->sel.daddr, &m->new_daddr, sizeof(x->sel.daddr));
> +			memcpy(&x->sel.saddr, &m->new_saddr, sizeof(x->sel.saddr));
> +		} else {
> +			x->sel = *m->new_sel;

nit: the mix of copy styles (memcpy and struct assignment) within this
function, but especially here for x->sel, is a bit unpleasant.

> +		}
> +	} else {
> +		memcpy(&x->sel, &orig->sel, sizeof(x->sel));
> +	}
>  	memcpy(&x->lft, &orig->lft, sizeof(x->lft));

[...]
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 03fa4cabf601..a49edf7d6f78 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
[...]
> @@ -3125,7 +3145,7 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
>  			   struct nlattr **attrs, struct netlink_ext_ack *extack)
>  {
>  	struct xfrm_userpolicy_id *pi = nlmsg_data(nlh);
> -	struct xfrm_migrate m[XFRM_MAX_DEPTH];
> +	struct xfrm_migrate m[XFRM_MAX_DEPTH] = {};

I'm not really opposed to this change, but what prompted it?


[...]
> +static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
> +				 struct nlattr **attrs, struct netlink_ext_ack *extack)
> +{
> +	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);
> +	struct net *net = sock_net(skb->sk);
> +	struct xfrm_user_offload xuo = {};
> +	struct xfrm_migrate m = {};
> +	struct xfrm_state *xc;
> +	struct xfrm_state *x;
> +	int err;
> +
> +	if (!um->id.spi) {
> +		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
> +		return -EINVAL;
> +	}
> +
> +	if (um->reserved) {
> +		NL_SET_ERR_MSG(extack, "Reserved field must be zero");
> +		return -EINVAL;
> +	}
> +
> +	if ((um->flags & XFRM_MIGRATE_STATE_NO_OFFLOAD) &&
> +	    attrs[XFRMA_OFFLOAD_DEV]) {
> +		NL_SET_ERR_MSG(extack,
> +			       "XFRM_MIGRATE_STATE_NO_OFFLOAD and XFRMA_OFFLOAD_DEV are mutually exclusive");

Not a strong objection, but they don't really have to be? "don't
inherit and set it from the one provided" sounds ok. (it's a bit
unnecessary to say "don't inherit", but not an issue)

XFRMA_OFFLOAD_DEV with !XFRM_MIGRATE_STATE_NO_OFFLOAD (inherit and
also set from request) seems more problematic.

> +		return -EINVAL;
> +	}
> +
> +	copy_from_user_migrate_state(&m, um);
> +
> +	x = xfrm_state_lookup(net, m.old_mark.v & m.old_mark.m,
> +			      &um->id.daddr, um->id.spi,
> +			      um->id.proto, um->id.family);
> +	if (!x) {
> +		NL_SET_ERR_MSG(extack, "Can not find state");
> +		return -ESRCH;
> +	}
> +
> +	if (um->flags & XFRM_MIGRATE_STATE_UPDATE_SEL) {
> +		u8 prefixlen = (x->sel.family == AF_INET6) ? 128 : 32;
> +
> +		if (x->sel.prefixlen_s != x->sel.prefixlen_d ||
> +		    x->sel.prefixlen_d != prefixlen ||
> +		    !xfrm_addr_equal(&x->sel.daddr, &x->id.daddr, x->sel.family) ||
> +		    !xfrm_addr_equal(&x->sel.saddr, &x->props.saddr, x->sel.family)) {

I think we need to be careful about families here too. id and sel
could have different ones.

[...]
> +	if (attrs[XFRMA_MTIMER_THRESH]) {
> +		err = verify_mtimer_thresh(!!m.encap, x->dir, extack);
> +		if (err)
> +			goto out;
> +	}
> +
> +	if (attrs[XFRMA_NAT_KEEPALIVE_INTERVAL] &&
> +	    nla_get_u32(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL]) && !m.encap) {

if (nla_get_u32_default(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL], 0) && !m.encap)

> +		NL_SET_ERR_MSG(extack,
> +			       "NAT_KEEPALIVE_INTERVAL requires encapsulation");
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (attrs[XFRMA_OFFLOAD_DEV]) {
> +		m.xuo = nla_data(attrs[XFRMA_OFFLOAD_DEV]);
> +	} else if (!(um->flags & XFRM_MIGRATE_STATE_NO_OFFLOAD) && x->xso.dev) {

nit: this would be a bit more readable with

    bool inherit_offload = !(um->flags & XFRM_MIGRATE_STATE_NO_OFFLOAD);

> +		xuo.ifindex = x->xso.dev->ifindex;
> +		if (x->xso.dir == XFRM_DEV_OFFLOAD_IN)
> +			xuo.flags = XFRM_OFFLOAD_INBOUND;
> +		if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET)
> +			xuo.flags |= XFRM_OFFLOAD_PACKET;

copy_user_offload is doing almost exactly the same thing (copy from
and xso to an xuo). It would be better to extract some helper
(xso_to_xuo() ?) and use it in both places, otherwise they'll almost
certainly get out of sync.

> +		m.xuo = &xuo;
> +	}
> +
> +	if (attrs[XFRMA_MARK])
> +		m.new_mark = nla_data(attrs[XFRMA_MARK]);
> +
> +	if (attrs[XFRMA_SET_MARK])
> +		xfrm_smark_init(attrs, &m.smark);
> +	else
> +		m.smark = x->props.smark;
> +
> +	m.mapping_maxage = attrs[XFRMA_MTIMER_THRESH] ?
> +		nla_get_u32(attrs[XFRMA_MTIMER_THRESH]) : x->mapping_maxage;

m.mapping_maxage = nla_get_u32_default(attrs[XFRMA_MTIMER_THRESH], x->mapping_maxage);

> +	m.nat_keepalive_interval = attrs[XFRMA_NAT_KEEPALIVE_INTERVAL] ?
> +		nla_get_u32(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL]) :
> +		x->nat_keepalive_interval;

m.nat_keepalive_interval = nla_get_u32_default(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL], x->nat_keepalive_interval);


-- 
Sabrina
