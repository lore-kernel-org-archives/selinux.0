Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBF342144;
	Tue,  3 Feb 2026 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770153926; cv=none; b=IHPBahsDT8XrVSeD6ZH3XI8dyWqtxNlg8NlnjFl4X6KxMm/5VUyiWVjvVZnSOF1V4tkvZbRUZCPaczi7pH6Sy+QyO+Sy9JYZx5ZSKN5svLxhISzo2/ePE1sT9hOwtdf94yo0+p2j/4xOM5H5+jSN3I+pjvVf2P91FNzZ3fhRulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770153926; c=relaxed/simple;
	bh=qFW9S+v5QaMd+JvBgQDbj4ArShx1YkWFbJCBs3HOYJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jINrgxAD8Y03V5QBa/2uf2iMFKDYjpH1HG79GIYMCLg7SgeTFJF5x49XbuqdcFbg0i8PPvJeah+Tf8HYmGEXsLhx43G7OeLgsqFpGOTOgsS2s88PgJlsL5ocdj3Lm41Zmp1olb4fksbYq4FFbZuQHHF/tOL95G1HduVzVyl0Z9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ccevx2g1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lgKEZwEL; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ccevx2g1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lgKEZwEL"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E908F7A0017;
	Tue,  3 Feb 2026 16:25:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 03 Feb 2026 16:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1770153919; x=
	1770240319; bh=ZwhbhOJG6NZw1SreV9zymxsW/VCEObsxMCJqnetrwLw=; b=c
	cevx2g1b1K4rAOWr4hGhw3rZu4ELYHgu8efKTjRHPF/l26sj0mRVZ/uUSsjvpIta
	U2ZVffizFJOKzDPWMQHsUkWdleMnJGB/CKKLZiSXPKN5t0QH+6taijI5q05To5iD
	3yUB9yNm3m7MzzvX9m2kf1W8HRZq9mip57Sy+yCSx/FzkeAZ2F3LZ5tTwxkEvv4A
	00Sdh44HcRRZ0CwLymk9Z/sO/jHg17Q50xmf3Jx0SJctChbMk7Z813/MmH1mWPwD
	j0Xjj651OIeReNPJhXP+NL8dY9dwNiNlkgfgWLJcJizxZCTXqCwYlruVhnUUSVJ9
	K2XyxhGvzi9ngzxyjcQXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770153919; x=1770240319; bh=ZwhbhOJG6NZw1SreV9zymxsW/VCEObsxMCJ
	qnetrwLw=; b=lgKEZwELibAn3SNeg4cOqk9eGNTcOijmhatkwgl1ZBymHLfIt+y
	kkdlR/jUG7rk309cZB8KvDKko4dL+IcLdeR1Suy8OFk3cGjSylYWj86Y7hvxHedE
	LAyxqIaSH8nWcBEjMF6q//o5aWafe7zl1hXDN7u7m+U2SNivMgzSg7Evyo/V5hpe
	JyQusxsyh9PzmKXq5Ku5/QSBXF8whKd+IGi2ZXt1eSx++8S8oME6HJ4RzLfgf3hD
	7D6bK5QoqtkI/BfxyRWU/VKmRvvuH1ggB4+jqjQfNe4Amn7wsbLOILsq0XThpvoY
	wBKZ/8jWQsoFAcXAkhzRHeTV0XnxfdGlFuw==
X-ME-Sender: <xms:vmeCaeori3qy6y7NHmdrQon--_vUt98F_j4qFz-Ynyy9owOt9gO8WA>
    <xme:vmeCaYmtsudLFMRL7wAolABhg6GBdMSwQk-kutvS2z-jCRhIEsuKXrjxWlv21fkQh
    U3QNXQIvdcuXkKSLBh-uiCC0cISdJYgmwmqyD_V-iMEV4NzZvJcEQ>
X-ME-Received: <xmr:vmeCaZWVKrrAOcrtTybztETivKxitaqLDAAMzXcQ-vX9dupZNhtMCv21lIou>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhihrdgrnhhtohhnhiesshgvtg
    hunhgvthdrtghomhdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgv
    tghunhgvthdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtph
    htthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheptghhihgrtghhrghnghifrghnghesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:vmeCaURnh8TQzrXz3cKaFoAq8RKLpWyUO-suKe_oWb9dboGwxtYdxA>
    <xmx:vmeCacDC3Yuo4wg5YL16v5f99keT9sNx7tQvuTpgZb9O5ANlkZjHRg>
    <xmx:vmeCaXQHjXBGeyfkuBT_2rnabCxX1E3SSlBtNMcj8Rku4qdpB3r4BA>
    <xmx:vmeCaeSDTWJZJQRtpGoZ867u2ZPlnSPkCMva_5LQEw8WhizImzq9iQ>
    <xmx:v2eCaaeH1ayEg3gGYnkthF-zVw2xxzA9FrvLxzBcIPFUPc-GCBES88WW>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 16:25:17 -0500 (EST)
Date: Tue, 3 Feb 2026 22:25:15 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH ipsec-next v5 8/8] xfrm: add XFRM_MSG_MIGRATE_STATE for
 single SA migration
Message-ID: <aYJnuw5mB8qn236R@krikkit>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>

2026-01-27, 11:44:11 +0100, Antony Antony wrote:
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index a23495c0e0a1..60b1f201b237 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
[...]
> +struct xfrm_user_migrate_state {
> +	struct xfrm_usersa_id id;
> +	xfrm_address_t new_saddr;
> +	xfrm_address_t new_daddr;
> +	__u16 new_family;
> +	__u32 new_reqid;
> +};

I'm not entirely clear on why this struct has those fields (maybe, in
particular, new_saddr but no old_saddr, assuming that id.daddr is
old_daddr). My guess is:

  - usersa_id because it's roughly equivalent to a GETSA request,
    which makes the old_saddr unnecessary (id uniquely identifies the
    target SA)

  - new_{saddr,daddr,family,reqid}
    equivalent to the new_* from xfrm_user_migrate (+reqid)

Is that correct?


> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 2e03871ae872..945e0e470c0f 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
[...]
> @@ -2159,9 +2158,10 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
>  			       struct xfrm_user_offload *xuo,
>  			       struct netlink_ext_ack *extack)
>  {
> -	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
> +	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family) ||

[piggy-backing on this patch review, but it's an older issue, and may
also be present in a few other places]

Is it valid to call xfrm_addr_equal without checking new_family ==
old_family? My feeling is "no", addresses of different families can't
be equal at all.

What we end up doing here:
old_family = AF_INET, new_family = AF_INET6
old_daddr has only 4B containing valid data, we're comparing the whole
16B to new_daddr (but what's in the other 12B?)

old_family = AF_INET6, new_family = AF_INET
we're comparing using new_family, so we only compare the first 4B of
old_daddr to the new address


> +	    x->props.reqid != xc->props.reqid) {
>  		/*
> -		 * Care is needed when the destination address
> +		 * Care is needed when the destination address or reqid
>  		 * of the state is to be updated as it is a part of triplet.

I'm quite confused by this bit. The existing code is "unchanged daddr,
use _insert, otherwise _add" (to let _add check for collisions that
are irrelevant with an unchanged daddr?). The new code is for a change
of reqid. Why does reqid need to be handled with care? And should the
reqid condition be reversed (same reqid => use _insert)?


> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 26b82d94acc1..79e65e3e278a 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
[...]
> +static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
> +				 struct nlattr **attrs, struct netlink_ext_ack *extack)
> +{
> +	int err = -ESRCH;
> +	struct xfrm_state *x;
> +	struct xfrm_state *xc;
> +	struct net *net = sock_net(skb->sk);
> +	struct xfrm_encap_tmpl *encap = NULL;
> +	struct xfrm_user_offload *xuo = NULL;
> +	struct xfrm_migrate m = {};
> +	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);

I don't know if Steffen requires it, but networking normally uses
reverse xmas tree order.

> +	if (!um->id.spi) {
> +		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
> +		return -EINVAL;
> +	}
> +
> +	copy_from_user_migrate_state(&m, um);
> +
> +	x = xfrm_user_state_lookup(net, &um->id, attrs, &err);
> +	if (!x) {
> +		NL_SET_ERR_MSG(extack, "Can not find state");
> +		return err;
> +	}
> +
> +	if (!x->dir) {
> +		NL_SET_ERR_MSG(extack, "State direction is invalid");

Why this restriction?
Also, should there be a match against XFRMA_SA_DIR? (I don't see one in
xfrm_user_state_lookup)


I think we should also reject attributes that we're not handling for
all new netlink message types. This would give us more freedom of
interpretation in future updates to this code.

> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (attrs[XFRMA_ENCAP]) {
> +		encap = kmemdup(nla_data(attrs[XFRMA_ENCAP]), sizeof(*encap),

I guess you c/p'd this from the old migrate code but... do we really
need a kmemdup here? xfrm_state_clone_and_setup() will make another
copy to assign to x->encap so here encap could just point to
nla_data(attrs[XFRMA_ENCAP])?


> +				GFP_KERNEL);
> +		if (!encap) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +	}
> +
> +	if (attrs[XFRMA_OFFLOAD_DEV]) {
> +		xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
> +			      sizeof(*xuo), GFP_KERNEL);

And same here, I don't think we actually need a copy of that memory.

> +		if (!xuo) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +	}
> +
> +	xc = xfrm_state_migrate_create(x, &m, encap, net, xuo, extack);
> +	if (!xc) {
> +		if (extack && !extack->_msg)
> +			NL_SET_ERR_MSG(extack, "State migration clone failed");

NL_SET_ERR_MSG_WEAK(...)

> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	spin_lock_bh(&x->lock);
> +	/* synchronize to prevent SN/IV reuse */
> +	xfrm_migrate_sync(xc, x);
> +	__xfrm_state_delete(x);
> +	spin_unlock_bh(&x->lock);
> +
> +	err = xfrm_state_migrate_install(x, xc, &m, xuo, extack);
> +	if (err < 0) {
> +		/*
> +		 * In this rare case both the old SA and the new SA
> +		 * will disappear.
> +		 * Alternatives risk duplicate SN/IV usage which must not occur.
> +		 * Userspace must handle this error, -EEXIST.
> +		 */
> +		goto out;
> +	}
> +
> +	err = xfrm_send_migrate_state(um, encap, xuo, nlh->nlmsg_pid,
> +				      nlh->nlmsg_seq);
> +	if (err < 0)
> +		NL_SET_ERR_MSG(extack, "Failed to send migration notification");

I feel this is a bit problematic as it will look like the operation
failed, but in reality only the notification has not been sent (but
the MIGRATE_STATE operation itself succeeded).

> +out:
> +	xfrm_state_put(x);
> +	kfree(encap);
> +	kfree(xuo);
> +	return err;
> +}
> +

-- 
Sabrina
