Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91438BDDF;
	Fri, 23 Jan 2026 05:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769147914; cv=none; b=ZUux+kDlWE70M7r3pkQy924LGj2bXJpGikYj1Qe4RykZY45jRAznOIwH2lDPCFsZjqI/lAGk30GYrLw1FmMPzZulbDd8rvXJjpGnuJvG9ZhUJRFiCgCU+pRl+POKMSZfCiSCaGZt72TDnY5F0+IaMHPao9tWNOzBuphRNxcoObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769147914; c=relaxed/simple;
	bh=oa8X0qP2QkGOcIuqF9LmOdehGABhvX7tzO4kLybdI9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezP3LUMBajOnqNxN6+vCni4wNgxPJ+H71zc6iMmZkXGZSDnNBlJ9iHD+oumka2iIyGTKwR83A3c8COldwsOfiIjclIiofk8acwCA12fGj1I8L/oWQFJhqTxtc9UHaMiLEJEYAmIAhL6FjrVUUuUo3TjKSz3LHU9xEaLCyK0A6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=P+VtH0Oe; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="P+VtH0Oe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1769147904; x=1770011905; bh=oa8X
	0qP2QkGOcIuqF9LmOdehGABhvX7tzO4kLybdI9g=; b=P+VtH0Oe7SenEEHxqhrK
	kKl1U7yFFu8flEi6sm9C0zEwyRErW9hwDVpZBOzvMYqfSjAcz7tXiWsozx+bIcjI
	RXpbjXqi5UtMeuXuA66GWiHRLuJaAOKpAMvedo3pDi+qunCDiWyrJKwpX1bs170o
	SaJZjl7DZjYDp/ohxl/TSJ1evIFWn0xNOoMrxM4gq3gskrRlLyuulcEO4ffpUcb/
	XYsqihDRPnZfxiTrD/DsYr4B6qqsdz5gO0XFotoD2uTif8Woh3JMOgf/b20pugt+
	LD/JjLa/csy6emaYU9YNOoU/PL40TtHzpGlwyyVJGJHzWix7Efs0+5OuUpKHlice
	DA==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Fri, 23 Jan 2026 06:58:24 +0100 (CET)
Date: Fri, 23 Jan 2026 06:58:22 +0100
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
Message-ID: <aXMN_m7_PFxr_AO8@Antony2201.local>
References: <cover.1768811736.git.antony.antony@secunet.com>
 <b134abaf18390d1bcdd59d2192687bac0e2c2710.1768811736.git.antony.antony@secunet.com>
 <aXH9BvGTxfaGRN4j@secunet.com>
 <aXIA6JdfwK1CEMeX@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXIA6JdfwK1CEMeX@secunet.com>

On Thu, Jan 22, 2026 at 11:50:16AM +0100, Steffen Klassert via Devel wrote:
> On Thu, Jan 22, 2026 at 11:33:42AM +0100, Steffen Klassert wrote:
> > On Mon, Jan 19, 2026 at 09:54:55AM +0100, Antony Antony wrote:
> > > +
> > > +static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
> > > +				 struct nlattr **attrs, struct netlink_ext_ack *extack)
> > > +{
> > > +	int err = -ESRCH;
> > > +	struct xfrm_state *x;
> > > +	struct net *net = sock_net(skb->sk);
> > > +	struct xfrm_encap_tmpl *encap = NULL;
> > > +	struct xfrm_user_offload *xuo = NULL;
> > > +	struct xfrm_migrate m = { .old_saddr.a4 = 0,};
> > > +	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);
> > > +
> > > +	if (!um->id.spi) {
> > > +		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	err = copy_from_user_migrate_state(&m, um);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	x = xfrm_user_state_lookup(net, &um->id, attrs, &err);
> > > +
> > > +	if (x) {
> > > +		struct xfrm_state *xc;
> > > +
> > > +		if (!x->dir) {
> > > +			NL_SET_ERR_MSG(extack, "State direction is invalid");
> > > +			err = -EINVAL;
> > > +			goto error;
> > > +		}
> > > +
> > > +		if (attrs[XFRMA_ENCAP]) {
> > > +			encap = kmemdup(nla_data(attrs[XFRMA_ENCAP]),
> > > +					sizeof(*encap), GFP_KERNEL);
> > > +			if (!encap) {
> > > +				err = -ENOMEM;
> > > +				goto error;
> > > +			}
> > > +		}
> > > +		if (attrs[XFRMA_OFFLOAD_DEV]) {
> > > +			xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
> > > +				      sizeof(*xuo), GFP_KERNEL);
> > > +			if (!xuo) {
> > > +				err = -ENOMEM;
> > > +				goto error;
> > > +			}
> > > +		}
> > > +		xc = xfrm_state_migrate(x, &m, encap, net, xuo, extack);
> > > +		if (xc) {
> > > +			xfrm_state_delete(x);
> > 
> > This xfrm_state_delete() comes too late. You need to synchronize this
> > with xfrm_state_clone_and_setup() by holding the state lock.
> > Otherwise we might hand out the same sequence number etc. more than
> > one time. Unfortunately xfrm_migrate() has the same problem, the
> > error recovery mechanism in xfrm_migrate() looks broken.
> 
> The xfrm_migrate() problem is nasty, looks like we can't recover
> if the state migration fails. We probably have to delete the
> states and wait for the userspace to insert new ones.

userspace should notice the inconsistany. Most of them are ENOMEM or EMSGSIZE

> 
> Another thing, xfrm_user_state_lookup() returns a reference on x,
> you should drop it somewhere.

There is a call a few lines bellow, the label was "error:"  I renamed it to  
"out:" for clariy.

+out:
+       xfrm_state_put(x);
+       kfree(encap);
+       kfree(xuo);
+       return err;
