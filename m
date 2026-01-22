Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128C9302147;
	Thu, 22 Jan 2026 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078038; cv=none; b=rd9ExQqMh8J0P08bnzuuyzoVcdgC+iz4hdSswAf0pv/N4wRV6MjBwkYHY8dEsAbZJQPAjTH+507KdLLz1NpNxGDuC9ptGOtZmzAwTLcascQsM1eTQ58WAxm9yzO3wa/ou6TL3qqm8ZCscbuvag61qvb2nRLthzXX8QHPrQ2EjaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078038; c=relaxed/simple;
	bh=vZpCkFfsmKgn23EtxwSEhcFIHFpfsGSIFAqLSt8IBRk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1MuueXefwmbMxbZ97ZV0lGqIIqbBsHhLeGjhGDyx+2OZnsSZt89AvM0itQlmqZDT7DcXkpNEw/eWKxcWS+URjk1bpDUt3fYNl9pn7p8PkKAYgGjHGTykXnT2+PUJ8xEhCkRM4NqANd42+EeAdGuiGT1beIiIJ14GKBnpTg45/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=WabI5oCo; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="WabI5oCo"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CD7832089F;
	Thu, 22 Jan 2026 11:33:45 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gPtyFwTTFlis; Thu, 22 Jan 2026 11:33:45 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 3412B20049;
	Thu, 22 Jan 2026 11:33:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 3412B20049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1769078025;
	bh=2qr3cgmUzoYOcfrgMpvvg/oiMbFlfcTLWs1AGHXfEyQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=WabI5oCoNIKE5qJeor8XymCCa7Nb9p9lnbI01ySNTnvamdRBs25VvmJ4Y1bwsdQEO
	 FKvq3gAKvqO7XYbgzJ+9uKmO12UrjLXvwcmjaY6cEi9KlcsUOA7FI1sdKr/Bb39mvn
	 X1qgvuCw5BEvZVmPWqK0kfUKsDNqVSTYef+PtcML/Bu7CB4cI3m0ozFblzKtPtN+aG
	 SVDR9mJdJsIqAWpwCbs03E7nL6kdg7AAjOgiYuk0CHUtqkYftKRf3LXTXusEQXEOuG
	 6A3OZ3qiHNjgqvkcesfmS9SBiPqA9RERX+MGsS8mu2xK3O7XnJAkajNEv4Wrzb7bY5
	 rBzGsi5s3rf3Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 11:33:43 +0100
Received: (nullmailer pid 1665856 invoked by uid 1000);
	Thu, 22 Jan 2026 10:33:42 -0000
Date: Thu, 22 Jan 2026 11:33:42 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Chiachang Wang
	<chiachangwang@google.com>, Yan Yan <evitayan@google.com>,
	<devel@linux-ipsec.org>, Simon Horman <horms@kernel.org>, Paul Moore
	<paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, <linux-kernel@vger.kernel.org>,
	<selinux@vger.kernel.org>
Subject: Re: [PATCH ipsec-next v4 5/5] xfrm: add XFRM_MSG_MIGRATE_STATE for
 single SA migration
Message-ID: <aXH9BvGTxfaGRN4j@secunet.com>
References: <cover.1768811736.git.antony.antony@secunet.com>
 <b134abaf18390d1bcdd59d2192687bac0e2c2710.1768811736.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b134abaf18390d1bcdd59d2192687bac0e2c2710.1768811736.git.antony.antony@secunet.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Jan 19, 2026 at 09:54:55AM +0100, Antony Antony wrote:
> +
> +static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
> +				 struct nlattr **attrs, struct netlink_ext_ack *extack)
> +{
> +	int err = -ESRCH;
> +	struct xfrm_state *x;
> +	struct net *net = sock_net(skb->sk);
> +	struct xfrm_encap_tmpl *encap = NULL;
> +	struct xfrm_user_offload *xuo = NULL;
> +	struct xfrm_migrate m = { .old_saddr.a4 = 0,};
> +	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);
> +
> +	if (!um->id.spi) {
> +		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
> +		return -EINVAL;
> +	}
> +
> +	err = copy_from_user_migrate_state(&m, um);
> +	if (err)
> +		return err;
> +
> +	x = xfrm_user_state_lookup(net, &um->id, attrs, &err);
> +
> +	if (x) {
> +		struct xfrm_state *xc;
> +
> +		if (!x->dir) {
> +			NL_SET_ERR_MSG(extack, "State direction is invalid");
> +			err = -EINVAL;
> +			goto error;
> +		}
> +
> +		if (attrs[XFRMA_ENCAP]) {
> +			encap = kmemdup(nla_data(attrs[XFRMA_ENCAP]),
> +					sizeof(*encap), GFP_KERNEL);
> +			if (!encap) {
> +				err = -ENOMEM;
> +				goto error;
> +			}
> +		}
> +		if (attrs[XFRMA_OFFLOAD_DEV]) {
> +			xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
> +				      sizeof(*xuo), GFP_KERNEL);
> +			if (!xuo) {
> +				err = -ENOMEM;
> +				goto error;
> +			}
> +		}
> +		xc = xfrm_state_migrate(x, &m, encap, net, xuo, extack);
> +		if (xc) {
> +			xfrm_state_delete(x);

This xfrm_state_delete() comes too late. You need to synchronize this
with xfrm_state_clone_and_setup() by holding the state lock.
Otherwise we might hand out the same sequence number etc. more than
one time. Unfortunately xfrm_migrate() has the same problem, the
error recovery mechanism in xfrm_migrate() looks broken.

