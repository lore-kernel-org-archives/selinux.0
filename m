Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F83603F1;
	Thu, 26 Feb 2026 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129170; cv=none; b=b2ZON5ylUOTQQbBM2vtsl7uIUeYWY1/yRvl8PKGQiSHG6jGwnLqz0j6DKicw5cBIXZ/rziur9qgFpDu5L+PcuucRWzTaKl6WZB06tJthCC/hrYO7NIz6Edwcq3z/oNO6v0pkbj4Z4iGA/+7bqLEBHjLQ3bD93KA4wL2Gf/JpXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129170; c=relaxed/simple;
	bh=zGyl0dVMrQPdeIbUTyoagNf+Us0VQHjLNTDIi2rlqzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dncq/Xq88lXCyvZIwf6XwpbtnkPEgroLgW56LrNvXS3lfRdfljvV8KL3lp0WrX1FJAViJJPtPpqQ79XDCstbRKHL0pyFjxhoTKNTL2BZ5tb1liLM5xoOTZMwzFrqmJnMBVYypTuePHSUC4LU2My1nLsPTojl7HPDEzXYqDiTvo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=o5SrI38K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X/3exm+q; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="o5SrI38K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/3exm+q"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F84C7A011B;
	Thu, 26 Feb 2026 13:06:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 26 Feb 2026 13:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1772129163; x=
	1772215563; bh=HAd4jZnRQqV58u6dnwwRQCl41Ao62HR8EgeasTaiJS0=; b=o
	5SrI38KvZft5+ceHEBMqOLRfivBn7Wt0eK5Zfe15+zFQzglN/wtDAZghU1TDKj/s
	YtWofXLJ6Cjrrm783jSFpLzSiDsQ2VV17s+F9kcB53BmqYBsi80TfCe1Sa0IdY2u
	aLJ8B9ha9XktJut1RboGrzqJ/yVZE8XDpIbYgP0xGYhtoMwcERAOyGBgQ9oPkjON
	Kk5E2sgAc/QdQ0v0VkwI33jykNNcU1lrfGwE5RVnr7WUTtxDI479lr6SSxqZ4BUP
	DMELzxHi1u874rtrEOBtRPwVJTQbcp7nO6R9dKSr6JWiTF34dzF4fh8GA528r4tu
	uTfJs5D8Xizvim/p96cLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772129163; x=1772215563; bh=HAd4jZnRQqV58u6dnwwRQCl41Ao62HR8Ege
	asTaiJS0=; b=X/3exm+qhBQNykcW6Tha1Vc9o8bBAGanopbXsedozYGB/Wz9NiT
	ew4mZx1URwUKptaDp4s4HPQM1zFK9kf4IUZ9u3fIs3bcUSZRQPygg2IlXTsiwKix
	6BMuPFNiy6bv4I5H+fFHnAQcY0LF2e/0S698Hcq5JgFA2R4xDgYZDBgLgutyMDn6
	9T0rd4+7pZXgEEP+pgei3tywgsMt2gXMB+IJGDvbh0V2kT6HcAaYM0FN0eSQpYrE
	YpEUr/F3d2DvhkgZmInfM65s0iv8lID+Qf2Mz3GRSdCgT/ixdaT3/64txLZMaozA
	6V9H3yLkg/pdL3/mGWdlG4RHsvjN8Z5YBcg==
X-ME-Sender: <xms:iougaUyhXDLmY5IztmJfljrXkzKxoEUclu0IJiuyxYdRrxRiK1-knQ>
    <xme:iougaZqMhaZl-5-ujIsqul7Li_vMnxRi3v0jjPT47gjiUuXVXlJ1_8OoEv_bX-HHt
    0Rn1QLpvzyA0jZW3oW9F8aikFtgVzkvfaO9kQUtHlKwQW6-6m6h4sWr>
X-ME-Received: <xmr:iougafn43ag-dxl8ghmU6mtHHrN31L6xBnF0wkqpxrjfdkHcNSLiSngLMk93>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeijedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedukedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhihsehphhgvnhhomhgvrdhorh
    hgpdhrtghpthhtoheprghnthhonhihrdgrnhhtohhnhiesshgvtghunhgvthdrtghomhdp
    rhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomh
    dprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghu
    pdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:iougaaxutct568Q7vu5p6zXr-n5o7ypZymEKm9wdmrVlDrdRc4hBng>
    <xmx:iougac2w5AG_mdqCPBlY_nox3VDRbtanyEgA80X7LIfHqzot61BslA>
    <xmx:iougaeDSFh086ans__hRTcTlLLT-rVvHSXSqhr9o8aASrAbebkuiew>
    <xmx:iougaZ9bnDyb7a73VQ2Y6X3BtG3r26O6abaxtoiEVJR0-icUIo8PWw>
    <xmx:i4ugaRNcuXcD6rBbfxOtMfMGVmby_LxDcM3-s787r-EaNAx5LvW3YE7s>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 13:06:01 -0500 (EST)
Date: Thu, 26 Feb 2026 19:05:59 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony@phenome.org>
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
Message-ID: <aaCLh-FXAqbQ6y9q@krikkit>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <aYJnuw5mB8qn236R@krikkit>
 <aaBq6RtWZXYdvhQY@Antony2201.local>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaBq6RtWZXYdvhQY@Antony2201.local>

2026-02-26, 16:46:49 +0100, Antony Antony wrote:
> Hi Sabrina,
> 
> Thanks for your extensive review. Along the way I also noticed a couple of 
> more minor issues and fixed them. I will send
> a v6 addressing the points from this email.

Thanks Antony.

Just a few things related to your reply:

> On Tue, Feb 03, 2026 at 10:25:15PM +0100, Sabrina Dubroca via Devel wrote:
> > 2026-01-27, 11:44:11 +0100, Antony Antony wrote:
> > > diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> > > index a23495c0e0a1..60b1f201b237 100644
> > > --- a/include/uapi/linux/xfrm.h
> > > +++ b/include/uapi/linux/xfrm.h
> > [...]
> > > +struct xfrm_user_migrate_state {
> > > +	struct xfrm_usersa_id id;
> > > +	xfrm_address_t new_saddr;
> > > +	xfrm_address_t new_daddr;
> > > +	__u16 new_family;
> > > +	__u32 new_reqid;
> > > +};
> > 
> > I'm not entirely clear on why this struct has those fields (maybe, in
> > particular, new_saddr but no old_saddr, assuming that id.daddr is
> > old_daddr). My guess is:
> > 
> >   - usersa_id because it's roughly equivalent to a GETSA request,
> >     which makes the old_saddr unnecessary (id uniquely identifies the
> >     target SA)
> > 
> >   - new_{saddr,daddr,family,reqid}
> >     equivalent to the new_* from xfrm_user_migrate (+reqid)
> > 
> > Is that correct?
> 
> Yes, exactly. The SA is looked up via xfrm_usersa_id, which uniquely
> identifies it, so old_saddr is not needed. old_daddr is carried in
> xfrm_usersa_id.daddr.

Thanks. Maybe worth adding a small note in the commit message to
describe the behavior of that new op? (pretty much what you wrote
here)

I know the old stuff isn't documented much, I'm not asking for an
extensive new file in Documentation.


[...]
> > > +	err = xfrm_state_migrate_install(x, xc, &m, xuo, extack);
> > > +	if (err < 0) {
> > > +		/*
> > > +		 * In this rare case both the old SA and the new SA
> > > +		 * will disappear.
> > > +		 * Alternatives risk duplicate SN/IV usage which must not occur.
> > > +		 * Userspace must handle this error, -EEXIST.
> > > +		 */
> > > +		goto out;
> > > +	}
> > > +
> > > +	err = xfrm_send_migrate_state(um, encap, xuo, nlh->nlmsg_pid,
> > > +				      nlh->nlmsg_seq);
> > > +	if (err < 0)
> > > +		NL_SET_ERR_MSG(extack, "Failed to send migration notification");
> > 
> > I feel this is a bit problematic as it will look like the operation
> > failed, but in reality only the notification has not been sent (but
> > the MIGRATE_STATE operation itself succeeded).
> 
> It is not critical, however, the best choice is let the userspace decide.
> How about this 
> 
> if (err < 0) {
>                 NL_SET_ERR_MSG(extack, "Failed to send migration notification");
>                 err = 0
> } 
> 
> most likely cause is out of memory.

Does userspace really check the extack it gets back when the operation
succeeds? But ok, that seems fine to me.

[Looking at the existing callers of xfrm_nlmsg_multicast, many
existing calls seem to completely ignore the return value
(km_state_notify -> xfrm_send_state_notify, km_policy_notify ->
xfrm_send_policy_notify, which are called from the main NETLINK_XFRM
ops), so at least returning 0 would be consistent with those (but
there's no extack on failing to notify for the other ops)]

-- 
Sabrina
