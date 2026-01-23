Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1B324716;
	Fri, 23 Jan 2026 05:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769146936; cv=none; b=B2Y7pl0RuCTJ8jXV5wl/xHHFCDvrKJ9T5Q2hadIM0b3tRl7TLHkAGI273HWEClDVSSrEjMnP3+hhT6a/EkcwjLP0iTNuzIFqLGaSTqd7/K66FjTijpaJSDDzE++Kc8O2Yh25fK29dPsd79sd16lYCx0lC0vN7ZjmVX1pu8vyJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769146936; c=relaxed/simple;
	bh=x29JAg4vInVBwBj5v09QW/0mIT8veRgcMZ17Kmqszh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYyee66zj1YwSZEXJpZ+vtU/vopnXvGHiyx9UaPR+dFU0D4cVsQWgkZXRBeOWxqv1enNvcQDwqhVgp2HE0TFUXWFHrfZMyb607pwNOjUCUJRNIYKIt3aZ5YW05EfHvr0pQCfl6Mo99Jv2/IsChuSDFfNBNrqS/Mk6zUlmI2nZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=WrpbQyU1; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="WrpbQyU1"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1769146916; x=1770010917; bh=x29J
	Ag4vInVBwBj5v09QW/0mIT8veRgcMZ17Kmqszh4=; b=WrpbQyU1rDQD5yueZGBA
	IYA88FYTD3ygKrv4hA1mogv3stDyA7SDdo6IyK+O7c4qFIm5kgj7OlexRxFaj6HL
	kgVgz4iD2VDzcgd9KGG/oDkznDkiBbnXV9XXbRVzUXuf5KaN49Du0QtNirkw1fnV
	fJFsWyXGDPxpOOrXhHnlrP7gHPvbFGpGdg8Ij2WhRoNpw2I7zn2s25lFZ4ybxMcm
	LBLotLQCwlqDD7YO42G4DGt1BF67ePu2/YUlYYE0pcgDAvEZj24O3TTxWtz3O5Sp
	cv8xyuJuT3qb6Si/Oz68+0H0yJegxMUgNwpfaxazH4s4/cNNFxLLECw/jK9SwRnw
	sg==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Fri, 23 Jan 2026 06:41:53 +0100 (CET)
Date: Fri, 23 Jan 2026 06:41:52 +0100
From: Antony Antony <antony@phenome.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Antony Antony <antony.antony@secunet.com>,
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
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v4 5/5] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aXMKIPhuiJiNUd1b@Antony2201.local>
References: <cover.1768811736.git.antony.antony@secunet.com>
 <b134abaf18390d1bcdd59d2192687bac0e2c2710.1768811736.git.antony.antony@secunet.com>
 <aXH9BvGTxfaGRN4j@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXH9BvGTxfaGRN4j@secunet.com>

On Thu, Jan 22, 2026 at 11:33:42AM +0100, Steffen Klassert via Devel wrote:
> On Mon, Jan 19, 2026 at 09:54:55AM +0100, Antony Antony wrote:
> > +
> > +static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
> > +				 struct nlattr **attrs, struct netlink_ext_ack *extack)
> > +{
> > +	int err = -ESRCH;
> > +	struct xfrm_state *x;
> > +	struct net *net = sock_net(skb->sk);
> > +	struct xfrm_encap_tmpl *encap = NULL;
> > +	struct xfrm_user_offload *xuo = NULL;
> > +	struct xfrm_migrate m = { .old_saddr.a4 = 0,};
> > +	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);
> > +
> > +	if (!um->id.spi) {
> > +		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
> > +		return -EINVAL;
> > +	}
> > +
> > +	err = copy_from_user_migrate_state(&m, um);
> > +	if (err)
> > +		return err;
> > +
> > +	x = xfrm_user_state_lookup(net, &um->id, attrs, &err);
> > +
> > +	if (x) {
> > +		struct xfrm_state *xc;
> > +
> > +		if (!x->dir) {
> > +			NL_SET_ERR_MSG(extack, "State direction is invalid");
> > +			err = -EINVAL;
> > +			goto error;
> > +		}
> > +
> > +		if (attrs[XFRMA_ENCAP]) {
> > +			encap = kmemdup(nla_data(attrs[XFRMA_ENCAP]),
> > +					sizeof(*encap), GFP_KERNEL);
> > +			if (!encap) {
> > +				err = -ENOMEM;
> > +				goto error;
> > +			}
> > +		}
> > +		if (attrs[XFRMA_OFFLOAD_DEV]) {
> > +			xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
> > +				      sizeof(*xuo), GFP_KERNEL);
> > +			if (!xuo) {
> > +				err = -ENOMEM;
> > +				goto error;
> > +			}
> > +		}
> > +		xc = xfrm_state_migrate(x, &m, encap, net, xuo, extack);
> > +		if (xc) {
> > +			xfrm_state_delete(x);
> 
> This xfrm_state_delete() comes too late. You need to synchronize this
> with xfrm_state_clone_and_setup() by holding the state lock.

yes. I added a lock, x->lock, and within the lock call __xfrm_state_delete()
That seems to work, not encountring a deadlock.

> Otherwise we might hand out the same sequence number etc. more than
> one time. Unfortunately xfrm_migrate() has the same problem, the
> error recovery mechanism in xfrm_migrate() looks broken.
