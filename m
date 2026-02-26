Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F1D372B3D;
	Thu, 26 Feb 2026 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120815; cv=none; b=nIzOtrfd72yv7TWlMLB7YZMM9CqCCyYM8kopSh+7LC9ocSN2CtULowrdxAigWQQ1nETzVVo6gaxTq+Ry3EeA523v9179tZ6/LAZ3tV1kEgelEX8GS8W5AkomQNsC3BKEguWvYcEkLsS5TYes+fCIfQTH0LTkmjAf40gXPQ8UnC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120815; c=relaxed/simple;
	bh=Sg9Rejxo873wnXgB7FQIKx5XI+HK9ciPu3aOtetz09s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBEGVrT/szeStGnbZ5JB7+XQ66TjCnq8rLqQK20viI0/ptzuFtAmh+eijjT1shng8AhSw02d3rpkW3cAOJ//OuCIH2mq/jsfdoGtMlkyqBjKSQTr9XvXcU0FofRHO7HnyNLP7Ho8n7D7BjaCHZvJANFlOHn7QCnrAI7jQtokE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=emKI5/GZ; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="emKI5/GZ"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1772120810; x=1772984811; bh=Sg9R
	ejxo873wnXgB7FQIKx5XI+HK9ciPu3aOtetz09s=; b=emKI5/GZtdqNs80W9MMy
	Re3Z4UnM64Q+0/qnYITiDFpo2biEiFZ/TW5h/ViBkJytoWNRlp7/UAbMzpl8zDzu
	LegeQwZ1uFn2zNt72wM7nJJsNKiS8/HnpMWuC7PX/34pzVEAUyl3La2J7FegZ5dI
	+o0qySutSRgUcxPxSYSktaIsxULLcb79guhkE6bI++Qm4Yt7MDae7zLLY1++TUE+
	uPbu6Txru3c7kwPWEbcLsw5G507eCBxgqA8KvXKdD8jQzgACBa0jNcOwmPY2e/FS
	q1BqPsO6gx5/H96sXWvjj1nj+L4GJkg6D9wN3npyx5rg49GXjv5Jsoyhl4DB/Y4o
	hg==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Thu, 26 Feb 2026 16:46:50 +0100 (CET)
Date: Thu, 26 Feb 2026 16:46:49 +0100
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
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
Message-ID: <aaBq6RtWZXYdvhQY@Antony2201.local>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <aYJnuw5mB8qn236R@krikkit>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYJnuw5mB8qn236R@krikkit>

Hi Sabrina,

Thanks for your extensive review. Along the way I also noticed a couple of 
more minor issues and fixed them. I will send
a v6 addressing the points from this email.

On Tue, Feb 03, 2026 at 10:25:15PM +0100, Sabrina Dubroca via Devel wrote:
> 2026-01-27, 11:44:11 +0100, Antony Antony wrote:
> > diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> > index a23495c0e0a1..60b1f201b237 100644
> > --- a/include/uapi/linux/xfrm.h
> > +++ b/include/uapi/linux/xfrm.h
> [...]
> > +struct xfrm_user_migrate_state {
> > +	struct xfrm_usersa_id id;
> > +	xfrm_address_t new_saddr;
> > +	xfrm_address_t new_daddr;
> > +	__u16 new_family;
> > +	__u32 new_reqid;
> > +};
> 
> I'm not entirely clear on why this struct has those fields (maybe, in
> particular, new_saddr but no old_saddr, assuming that id.daddr is
> old_daddr). My guess is:
> 
>   - usersa_id because it's roughly equivalent to a GETSA request,
>     which makes the old_saddr unnecessary (id uniquely identifies the
>     target SA)
> 
>   - new_{saddr,daddr,family,reqid}
>     equivalent to the new_* from xfrm_user_migrate (+reqid)
> 
> Is that correct?

Yes, exactly. The SA is looked up via xfrm_usersa_id, which uniquely
identifies it, so old_saddr is not needed. old_daddr is carried in
xfrm_usersa_id.daddr.

> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 2e03871ae872..945e0e470c0f 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> [...]
> > @@ -2159,9 +2158,10 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
> >  			       struct xfrm_user_offload *xuo,
> >  			       struct netlink_ext_ack *extack)
> >  {
> > -	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
> > +	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family) ||
> 
> [piggy-backing on this patch review, but it's an older issue, and may
> also be present in a few other places]
> 
> Is it valid to call xfrm_addr_equal without checking new_family ==
> old_family? My feeling is "no", addresses of different families can't
> be equal at all.
> 
> What we end up doing here:
> old_family = AF_INET, new_family = AF_INET6
> old_daddr has only 4B containing valid data, we're comparing the whole
> 16B to new_daddr (but what's in the other 12B?)
> 
> old_family = AF_INET6, new_family = AF_INET
> we're comparing using new_family, so we only compare the first 4B of
> old_daddr to the new address

good catch. It existed before. I will send a fix as part of this series.

> 
> 
> > +	    x->props.reqid != xc->props.reqid) {
> >  		/*
> > -		 * Care is needed when the destination address
> > +		 * Care is needed when the destination address or reqid
> >  		 * of the state is to be updated as it is a part of triplet.
> 
> I'm quite confused by this bit. The existing code is "unchanged daddr,
> use _insert, otherwise _add" (to let _add check for collisions that
> are irrelevant with an unchanged daddr?). The new code is for a change
> of reqid. Why does reqid need to be handled with care? And should the
> reqid condition be reversed (same reqid => use _insert)?

I revisited it and reqid change does not need insert. _add is good enough.  
Fixed. Thanks.

> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index 26b82d94acc1..79e65e3e278a 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> [...]
> > +static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
> > +				 struct nlattr **attrs, struct netlink_ext_ack *extack)
> > +{
> > +	int err = -ESRCH;
> > +	struct xfrm_state *x;
> > +	struct xfrm_state *xc;
> > +	struct net *net = sock_net(skb->sk);
> > +	struct xfrm_encap_tmpl *encap = NULL;
> > +	struct xfrm_user_offload *xuo = NULL;
> > +	struct xfrm_migrate m = {};
> > +	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);
> 
> I don't know if Steffen requires it, but networking normally uses
> reverse xmas tree order. 

It is good to keep that style. Fixed.

> > +	if (!um->id.spi) {
> > +		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
> > +		return -EINVAL;
> > +	}
> > +
> > +	copy_from_user_migrate_state(&m, um);
> > +
> > +	x = xfrm_user_state_lookup(net, &um->id, attrs, &err);
> > +	if (!x) {
> > +		NL_SET_ERR_MSG(extack, "Can not find state");
> > +		return err;
> > +	}
> > +
> > +	if (!x->dir) {
> > +		NL_SET_ERR_MSG(extack, "State direction is invalid");
> 
> Why this restriction?
> Also, should there be a match against XFRMA_SA_DIR? (I don't see one in
> xfrm_user_state_lookup)

The !x->dir check is not strictly necessary. It was a leftover from an 
earlier iteration that was dropped. I removed it

 
> I think we should also reject attributes that we're not handling for
> all new netlink message types. This would give us more freedom of
> interpretation in future updates to this code.

good idea. I have added new validate attributes patch


> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	if (attrs[XFRMA_ENCAP]) {
> > +		encap = kmemdup(nla_data(attrs[XFRMA_ENCAP]), sizeof(*encap),
> 
> I guess you c/p'd this from the old migrate code but... do we really
> need a kmemdup here? xfrm_state_clone_and_setup() will make another
> copy to assign to x->encap so here encap could just point to
> nla_data(attrs[XFRMA_ENCAP])?

why not:) It is time to change, though it is a widely used pattern in the 
same file.

> 
> 
> > +				GFP_KERNEL);
> > +		if (!encap) {
> > +			err = -ENOMEM;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	if (attrs[XFRMA_OFFLOAD_DEV]) {
> > +		xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
> > +			      sizeof(*xuo), GFP_KERNEL);
> 
> And same here, I don't think we actually need a copy of that memory.

changed. thanks.

> 
> > +		if (!xuo) {
> > +			err = -ENOMEM;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	xc = xfrm_state_migrate_create(x, &m, encap, net, xuo, extack);
> > +	if (!xc) {
> > +		if (extack && !extack->_msg)
> > +			NL_SET_ERR_MSG(extack, "State migration clone failed");
> 
> NL_SET_ERR_MSG_WEAK(...)

thanks I was looking for this!

> 
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	spin_lock_bh(&x->lock);
> > +	/* synchronize to prevent SN/IV reuse */
> > +	xfrm_migrate_sync(xc, x);
> > +	__xfrm_state_delete(x);
> > +	spin_unlock_bh(&x->lock);
> > +
> > +	err = xfrm_state_migrate_install(x, xc, &m, xuo, extack);
> > +	if (err < 0) {
> > +		/*
> > +		 * In this rare case both the old SA and the new SA
> > +		 * will disappear.
> > +		 * Alternatives risk duplicate SN/IV usage which must not occur.
> > +		 * Userspace must handle this error, -EEXIST.
> > +		 */
> > +		goto out;
> > +	}
> > +
> > +	err = xfrm_send_migrate_state(um, encap, xuo, nlh->nlmsg_pid,
> > +				      nlh->nlmsg_seq);
> > +	if (err < 0)
> > +		NL_SET_ERR_MSG(extack, "Failed to send migration notification");
> 
> I feel this is a bit problematic as it will look like the operation
> failed, but in reality only the notification has not been sent (but
> the MIGRATE_STATE operation itself succeeded).

It is not critical, however, the best choice is let the userspace decide.
How about this 

if (err < 0) {
                NL_SET_ERR_MSG(extack, "Failed to send migration notification");
                err = 0
} 

most likely cause is out of memory.

> 
> > +out:
> > +	xfrm_state_put(x);
> > +	kfree(encap);
> > +	kfree(xuo);
> > +	return err;
> > +}
> > +
> 

-antony
