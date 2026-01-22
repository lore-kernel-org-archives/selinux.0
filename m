Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7B443C050;
	Thu, 22 Jan 2026 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079027; cv=none; b=DLXebC9nnnnF7q2G5zJXs0tF6lFczfmJxS1ae50s/mJzbgPA0lHh1G2pAOD7KSGLwUskVhJa/pYq+Fjdj5SyLuNwqD/zbSAqMTXqp3Y1XknZmK/ADN9SwuyDjDPXSi6bEEtlOGhxrtSC1FOASI44fgEqcr2UwZhg5vPrUgZjhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079027; c=relaxed/simple;
	bh=MS9OKYTyTcB4St88J3kjOMxqr6qydLzq5+rFqUKIl1U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3IXW/x3Yb8GWHVPcPFIz8WYhCPFbOtYQ+KB6zMPtbPA5Qjfo7WrOVCXeUWxIUY3kjB+LeeFRkCwflh0x3MEYblRwBnR42I7/UKr6s9sTn2Hz+w75joc03Xv0cV1JRqHMbYSd9esPbO3gCuMDu6deJlSSdicbGDDjj+1JDGWqCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QZp3xUXa; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QZp3xUXa"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 57B3420853;
	Thu, 22 Jan 2026 11:50:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IkP7Erp8dMmt; Thu, 22 Jan 2026 11:50:17 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B07E62019D;
	Thu, 22 Jan 2026 11:50:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B07E62019D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1769079017;
	bh=c1aSZu+8LTmz5cVQKNlhVszfW/irmSsHfvWOFd1abBM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=QZp3xUXaWK3Zb1B4CaB6W2TydunP57z9zw/t+FdWVPsbEI/2bVGLEpqy+QDkBhV9c
	 tYxOq33JbsY6oJXz19AN38rHoZM6K7UACiU2GXUA0rMywRd+wUofh0h93bAku+EVEk
	 3YqRb/cGyKggKWHqmaJLWTk4ti3Y80Z+EZq9Iu4XST/zmVcKzMIh1M0wUq9DmpvImt
	 YfPW4285sn0DPEdwB9j/+l+wdrtvBOowI4hzkYsz+Ng4t4t9C1Kx+ZeTQQfP6AoTu/
	 pzHoOmdTKLaXYQ7L2OiKAurhGOdPwS1RlcmyL6rGrwOF4Hgu/DLPO+KiqaRq76SADl
	 AAWy4vsD/cbBw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 11:50:17 +0100
Received: (nullmailer pid 1680181 invoked by uid 1000);
	Thu, 22 Jan 2026 10:50:16 -0000
Date: Thu, 22 Jan 2026 11:50:16 +0100
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
Message-ID: <aXIA6JdfwK1CEMeX@secunet.com>
References: <cover.1768811736.git.antony.antony@secunet.com>
 <b134abaf18390d1bcdd59d2192687bac0e2c2710.1768811736.git.antony.antony@secunet.com>
 <aXH9BvGTxfaGRN4j@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXH9BvGTxfaGRN4j@secunet.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Jan 22, 2026 at 11:33:42AM +0100, Steffen Klassert wrote:
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
> Otherwise we might hand out the same sequence number etc. more than
> one time. Unfortunately xfrm_migrate() has the same problem, the
> error recovery mechanism in xfrm_migrate() looks broken.

The xfrm_migrate() problem is nasty, looks like we can't recover
if the state migration fails. We probably have to delete the
states and wait for the userspace to insert new ones.

Another thing, xfrm_user_state_lookup() returns a reference on x,
you should drop it somewhere.

