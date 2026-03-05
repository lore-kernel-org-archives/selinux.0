Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8532B981;
	Thu,  5 Mar 2026 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697099; cv=none; b=EbtLZszRmV3AJw/Vz5N81uRuAy7CRrekdnjagEdort4wcTpdTDgMT50bTjdfcIqTyQ+J0cYoH0lf60m3/MAUNDBTTofziFrGv1GVB9055bCA5HnV4Mjox5RjnwYWEWpfe5gWpwOZ9CmYpjNN2dOQZU00L/3JHYzo/SOhez1vtIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697099; c=relaxed/simple;
	bh=DXb6Q+j9M90TXOArdiNg5D427m8pr/vCLDYd9DVf+U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L00EQybSxN9B6yxuQTu+gaRLTAz5lrL/cDtnyfY0oQoEV84cA86vMURHnQEvh28K3e1lZta9Fcm1qkaN93ZQ7BfmxxXOGPEHKDuW/MF2VEVOas/CdZ1NwaUebp0WtWlYtu+p2kuxJ6BZt2guPx3d8OqqY9C2oBljBV8hnFCEoLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=R5IThJm5; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="R5IThJm5"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1772697095; x=1773561096; bh=DXb6
	Q+j9M90TXOArdiNg5D427m8pr/vCLDYd9DVf+U4=; b=R5IThJm5qrA8YhhFrGyH
	sWwdVZ0Bse+PmNyiOSB2Mghl2rvfqwrjH8IhL756vyzcFSoPjrD7MXpRbpXEXAz5
	9+AFjS1gISBxsyU9OOqPdVvLpmBzDkpDhEdQJ01ZoaVfD3ivBJLifM61ENe2tSiU
	pWoss9+x2cFomS/gBZJ6zEW+g0gvwS89W3PW3B2t8JALkkV1u8E6m2yDBjbQDRek
	vbmNiWDll0vbe7tbpXls/ka876Q3iFg7plJmikpZSUXE8ajgYmDNJS/anFRvkKG6
	LwlADYBAiQhKdbIS5OXVUENYAwkKG8e6xBoG28fYBELc3j80VOfrO9FrpD6qLywS
	UA==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Thu, 05 Mar 2026 08:51:35 +0100 (CET)
Date: Thu, 5 Mar 2026 08:51:33 +0100
From: Antony Antony <antony@phenome.org>
To: Yan Yan <evitayan@google.com>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org, Nathan Harold <nharold@google.com>
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 8/8] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aak2BWlUbCCGbhp4@Antony2201.local>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com>

On Thu, Feb 26, 2026 at 05:44:51PM -0800, Yan Yan via Devel wrote:
> Hi Antony,
> 
> May I request that we also support updating the XFRMA_SET_MARK as part
> of the new XFRM_MSG_MIGRATE_STATE message?

yes I can add that. I would add XFRMA_SET_MARK/XFRMA_SET_MARK_MASK together.  
If you set only the SET_MARK mask will be 0xffffffff.

I am actually using xfrm_smark_init() which will accept both. 

> In Android, the primary use case for migration is switching the
> underlying physical network for an IPsec tunnel (e.g. VPN, Wifi
> calling). Currently, due to the limits of XFRM_MSG_MIGRATE, we are
> forced to use a separate UPDSA call to update the set-mark. Supporting
> XFRMA_SET_MARK within the migrate message would allow us to update the
> addresses and the routing mark together in one atomic call.
>
> Regarding the logic, I believe the set-mark can follow the same
> omit-to-clear pattern as XFRMA_ENCAP and XFRMA_OFFLOAD_DEV.
>
>
> What do you think?

good idea. I would try to test, otherwise please review/test this sepcific 
part xfrm_smark_init() set 0/0 when there is no SET_MASK.

Thanks.
-antony
