Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FB253B58;
	Fri, 23 Jan 2026 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157142; cv=none; b=M78JNxLxlDUDLtlreuYJtb1gEhzxEZVV91E4GaEkZYmAwmMiNf8kk7NLvUatuBGULapNRVmm2RQlB9QBp6I2tPhR+DxiI9+I8s+u2EaubNGn2+9qxemu6m2LyQ40ypsI6awFQtN6e+MEQ9YArNZPdeYxwT2Q0vV1+NWk+8QxiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157142; c=relaxed/simple;
	bh=pe/U8R1GHGgSVphOhGhvbyXMon4vZEqHjodKszec0Ow=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkHWRSxfd2KhYC2szWwv32O7KqwfhbR+dJdD/ye8y4GYrNVogP9BdwXrJU3b8L4ihWodIRzYABWYVutF9ZSyvk5B9Ui5zsyAIdNLueRtSzlpI9ILt+Kn/G6opY76OKw4db8p8AVPcKgeMa79q6MFbTduDzE2A8Jy3WnI39Cz6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=S0JW/Se4; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="S0JW/Se4"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4295F2087C;
	Fri, 23 Jan 2026 09:32:17 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3NzD6L_K90UO; Fri, 23 Jan 2026 09:32:16 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 968B1201E4;
	Fri, 23 Jan 2026 09:32:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 968B1201E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1769157136;
	bh=JPf6CgXjsnmZXM26M5Jo8AsLktests7HCe2DYHQMJk8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=S0JW/Se4RoCYu4h3aegzIuTPjHv46y79aCxGMF3F+hrR0DECz+QVPxvCMWBLpDYwm
	 qrFeNSzVG+tbdoaZjFhXibf55f+YGOBXCD7zxwJe7+aCM5UNFiNrkubrboK+5CH/x8
	 He1zkZPjx/PKHIEyXVfZTTD3/asEOz1ZAWbkTfchDCK1246dF/JHRh5MW/ad5kKMg1
	 nO9sQJ2a/X6h+BKvYnPHyIFBWprs3H2rN+4fzQBPnr0mF5PdwfR/ofZ3Bt2sAgZFOd
	 Tar9jbSvoiMNZ6kpxicwCKrGUrykRQlAQ+UnCCW4eAMUAyDHcmvBfP1f0PqGEtVrBZ
	 ebyMRWFqKkhXw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 09:32:15 +0100
Received: (nullmailer pid 2692962 invoked by uid 1000);
	Fri, 23 Jan 2026 08:32:15 -0000
Date: Fri, 23 Jan 2026 09:32:15 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony@phenome.org>
CC: Antony Antony <antony.antony@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Chiachang Wang
	<chiachangwang@google.com>, Yan Yan <evitayan@google.com>,
	<devel@linux-ipsec.org>, Simon Horman <horms@kernel.org>, Paul Moore
	<paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, <linux-kernel@vger.kernel.org>,
	<selinux@vger.kernel.org>
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v4 5/5] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aXMyD4zss0wnXf7h@secunet.com>
References: <cover.1768811736.git.antony.antony@secunet.com>
 <b134abaf18390d1bcdd59d2192687bac0e2c2710.1768811736.git.antony.antony@secunet.com>
 <aXH9BvGTxfaGRN4j@secunet.com>
 <aXIA6JdfwK1CEMeX@secunet.com>
 <aXMN_m7_PFxr_AO8@Antony2201.local>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXMN_m7_PFxr_AO8@Antony2201.local>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Fri, Jan 23, 2026 at 06:58:22AM +0100, Antony Antony wrote:
> On Thu, Jan 22, 2026 at 11:50:16AM +0100, Steffen Klassert via Devel wrote:
> > On Thu, Jan 22, 2026 at 11:33:42AM +0100, Steffen Klassert wrote:
> > > On Mon, Jan 19, 2026 at 09:54:55AM +0100, Antony Antony wrote:
> > > > +
> > > > +static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
> > > > +				 struct nlattr **attrs, struct netlink_ext_ack *extack)
> > > > +{
> > > > +	int err = -ESRCH;
> > > > +	struct xfrm_state *x;
> > > > +	struct net *net = sock_net(skb->sk);
> > > > +	struct xfrm_encap_tmpl *encap = NULL;
> > > > +	struct xfrm_user_offload *xuo = NULL;
> > > > +	struct xfrm_migrate m = { .old_saddr.a4 = 0,};
> > > > +	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);
> > > > +
> > > > +	if (!um->id.spi) {
> > > > +		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	err = copy_from_user_migrate_state(&m, um);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	x = xfrm_user_state_lookup(net, &um->id, attrs, &err);
> > > > +
> > > > +	if (x) {
> > > > +		struct xfrm_state *xc;
> > > > +
> > > > +		if (!x->dir) {
> > > > +			NL_SET_ERR_MSG(extack, "State direction is invalid");
> > > > +			err = -EINVAL;
> > > > +			goto error;
> > > > +		}
> > > > +
> > > > +		if (attrs[XFRMA_ENCAP]) {
> > > > +			encap = kmemdup(nla_data(attrs[XFRMA_ENCAP]),
> > > > +					sizeof(*encap), GFP_KERNEL);
> > > > +			if (!encap) {
> > > > +				err = -ENOMEM;
> > > > +				goto error;
> > > > +			}
> > > > +		}
> > > > +		if (attrs[XFRMA_OFFLOAD_DEV]) {
> > > > +			xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
> > > > +				      sizeof(*xuo), GFP_KERNEL);
> > > > +			if (!xuo) {
> > > > +				err = -ENOMEM;
> > > > +				goto error;
> > > > +			}
> > > > +		}
> > > > +		xc = xfrm_state_migrate(x, &m, encap, net, xuo, extack);
> > > > +		if (xc) {
> > > > +			xfrm_state_delete(x);
> > > 
> > > This xfrm_state_delete() comes too late. You need to synchronize this
> > > with xfrm_state_clone_and_setup() by holding the state lock.
> > > Otherwise we might hand out the same sequence number etc. more than
> > > one time. Unfortunately xfrm_migrate() has the same problem, the
> > > error recovery mechanism in xfrm_migrate() looks broken.
> > 
> > The xfrm_migrate() problem is nasty, looks like we can't recover
> > if the state migration fails. We probably have to delete the
> > states and wait for the userspace to insert new ones.
> 
> userspace should notice the inconsistany. Most of them are ENOMEM or EMSGSIZE
> 
> > 
> > Another thing, xfrm_user_state_lookup() returns a reference on x,
> > you should drop it somewhere.
> 
> There is a call a few lines bellow, the label was "error:"  I renamed it to  
> "out:" for clariy.
> 
> +out:
> +       xfrm_state_put(x);

Yes, this makes it more clear that we hit this even without error.

Maybe you should do a 'if (!X)' check on the retuen value of
xfrm_user_state_lookup(). This woulds make the structure of
the function even clearer.
