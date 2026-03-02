Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276223E0C74;
	Mon,  2 Mar 2026 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461324; cv=none; b=SWK/bloF2QWSa0oLp0JZyTPfAyBVARU4S1AC+YCJDy7xNIytYlnQhvCLoIFfPYlTgVa3ytMRWgJWSMxcpLunIhwSDcjsKsyMfSwMHsjIY+lQRseE4T7ZCgIB3CBvdegFska3e0lT5zEbFiccHvw+CNWfT+6v2cjycblVNp7bFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461324; c=relaxed/simple;
	bh=koIZhQ4bt5ZeOXIHx4KyJOhhI4N8ov9r3ZR2G3owpNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuGXZEYsaDt30Ds95hxVZc3dbfbjLYCJIHa4ur0xn8HARhUWlIH7Bceb3MmLugbOwOsWpIg2cjQJNLrGszTpOMv4MK21mocUk53LlTOX5r268bnoskIyWAkLQear+ZSDOwh5Ce30EjbBPrdMJQbZARNszIbQVJhyfILQquU9DQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=c4aj1A20; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="c4aj1A20"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1772461319; x=1773325320; bh=koIZ
	hQ4bt5ZeOXIHx4KyJOhhI4N8ov9r3ZR2G3owpNw=; b=c4aj1A20W1rfMFj89Uzk
	p1VqSYqdLJoOrIYraC16negIRxe+YAaIZMhWjcXfBz7QpZcVSBoKwcWl5cwhrH1z
	lSnK7srPeykjYBO7Y4ui37ZCWXpy3pFd1qt7jdxP3YWAkpXzrNfWuEPeqJ6R8F+C
	nJl91YJZXyfLX+eazEApfkAmDHA87dueNAqTlOyuWPfJX972F4+OxNSYgs4JIIQC
	eyKJTMj0XNqzSL/yDkg5/VMpUukJZhUVzU+506vS3IVKtuApXnMiLWU1osxJPcua
	vVKbOytAOahhKCxaoHQ1PN1V0bj8ZKr+pTc/kKgRTYIUXJbxfLZ7M969hbtdqnko
	zg==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Mon, 02 Mar 2026 15:21:59 +0100 (CET)
Date: Mon, 2 Mar 2026 15:21:57 +0100
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony@phenome.org>,
	Antony Antony <antony.antony@secunet.com>,
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
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 8/8] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aaWdBRn_ON3K_HVX@Antony2201.local>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <aYJnuw5mB8qn236R@krikkit>
 <aaBq6RtWZXYdvhQY@Antony2201.local>
 <aaCLh-FXAqbQ6y9q@krikkit>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaCLh-FXAqbQ6y9q@krikkit>

On Thu, Feb 26, 2026 at 07:05:59PM +0100, Sabrina Dubroca via Devel wrote:
> 2026-02-26, 16:46:49 +0100, Antony Antony wrote:
> > Hi Sabrina,
> > 
> > Thanks for your extensive review. Along the way I also noticed a couple of 
> > more minor issues and fixed them. I will send
> > a v6 addressing the points from this email.
> 
> Thanks Antony.
> 
> Just a few things related to your reply:
> 
> > On Tue, Feb 03, 2026 at 10:25:15PM +0100, Sabrina Dubroca via Devel wrote:
> > > 2026-01-27, 11:44:11 +0100, Antony Antony wrote:
> > > > diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> > > > index a23495c0e0a1..60b1f201b237 100644
> > > > --- a/include/uapi/linux/xfrm.h
> > > > +++ b/include/uapi/linux/xfrm.h
> > > [...]
> > > > +struct xfrm_user_migrate_state {
> > > > +	struct xfrm_usersa_id id;
> > > > +	xfrm_address_t new_saddr;
> > > > +	xfrm_address_t new_daddr;
> > > > +	__u16 new_family;
> > > > +	__u32 new_reqid;
> > > > +};
> > > 
> > > I'm not entirely clear on why this struct has those fields (maybe, in
> > > particular, new_saddr but no old_saddr, assuming that id.daddr is
> > > old_daddr). My guess is:
> > > 
> > >   - usersa_id because it's roughly equivalent to a GETSA request,
> > >     which makes the old_saddr unnecessary (id uniquely identifies the
> > >     target SA)
> > > 
> > >   - new_{saddr,daddr,family,reqid}
> > >     equivalent to the new_* from xfrm_user_migrate (+reqid)
> > > 
> > > Is that correct?
> > 
> > Yes, exactly. The SA is looked up via xfrm_usersa_id, which uniquely
> > identifies it, so old_saddr is not needed. old_daddr is carried in
> > xfrm_usersa_id.daddr.
> 
> Thanks. Maybe worth adding a small note in the commit message to
> describe the behavior of that new op? (pretty much what you wrote
> here)

Yes good idea. Done!


> I know the old stuff isn't documented much, I'm not asking for an
> extensive new file in Documentation.
> 
> 
> [...]
> > > > +	err = xfrm_state_migrate_install(x, xc, &m, xuo, extack);
> > > > +	if (err < 0) {
> > > > +		/*
> > > > +		 * In this rare case both the old SA and the new SA
> > > > +		 * will disappear.
> > > > +		 * Alternatives risk duplicate SN/IV usage which must not occur.
> > > > +		 * Userspace must handle this error, -EEXIST.
> > > > +		 */
> > > > +		goto out;
> > > > +	}
> > > > +
> > > > +	err = xfrm_send_migrate_state(um, encap, xuo, nlh->nlmsg_pid,
> > > > +				      nlh->nlmsg_seq);
> > > > +	if (err < 0)
> > > > +		NL_SET_ERR_MSG(extack, "Failed to send migration notification");
> > > 
> > > I feel this is a bit problematic as it will look like the operation
> > > failed, but in reality only the notification has not been sent (but
> > > the MIGRATE_STATE operation itself succeeded).
> > 
> > It is not critical, however, the best choice is let the userspace decide.
> > How about this 
> > 
> > if (err < 0) {
> >                 NL_SET_ERR_MSG(extack, "Failed to send migration notification");
> >                 err = 0
> > } 
> > 
> > most likely cause is out of memory.
> 
> Does userspace really check the extack it gets back when the operation
> succeeds? But ok, that seems fine to me. 

From recollection, at least one of the *swan log it, and over time
you start to notice the pattern. That said, out-of-memory is a tough case.
When that happens, all bets are off anyway. So it really comes down to
personal preference. I prefer to set something to notify.

My frustration when testing, typically on a low-memory VM, was watching 'ip 
xfrm monitor' and not seeing a netlink notification, left wondering what had 
happened.


> 
> [Looking at the existing callers of xfrm_nlmsg_multicast, many
> existing calls seem to completely ignore the return value
> (km_state_notify -> xfrm_send_state_notify, km_policy_notify ->
> xfrm_send_policy_notify, which are called from the main NETLINK_XFRM
> ops), so at least returning 0 would be consistent with those (but
> there's no extack on failing to notify for the other ops)]

You picked up an interesting design choice I made. Since PF_KEY/AF_KEY
is on life support I omitted going through km_state_notify.  So I would
like to have extack when it is possible.

-antony
