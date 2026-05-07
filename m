Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557EE3FA5CD;
	Thu,  7 May 2026 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160419; cv=none; b=ev1tnpa2b6ldNflKluixLb5P6Zs90r78Spi/a+D+CFR/8IydBhe7Os8SOc2aRKaa8qkC5wCOg10wyF7OdtiyE1tG+8xaYE0IiXl6Yixuj3ESmVxAEj29oyw7lnUmVWvElOteyad3u80IEu6fpRW0y/un/HLRDj2FyDN9QjVK4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160419; c=relaxed/simple;
	bh=e7cI2CRlGxOIqCNZGeZpROA7pHpYAzCWZEjE0OEXs6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyBAYEiPNUuSFvCMiCPZU/BXVuo835z9BCIGUulrgWKYv0LhoSTPSl3dxZAkfrmQxasJFjvNIxCH0TEKnHkz3j2SzqAYSaM8Moc7pOiCWGY7uZ1f9HcLg/7uk3k82s4IjZWQ0TPUZaeWAw2jJ1yxuU14TOQJhuVOfBdBg9iUbD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=E5dbnpw1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KR30JmtT; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="E5dbnpw1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KR30JmtT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 691701300336;
	Thu,  7 May 2026 09:26:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 07 May 2026 09:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778160413; x=
	1778167613; bh=RtFbl6Ia2yXhJKiRS1RPNkHNw34xJHyi2Bt4SAeOI5o=; b=E
	5dbnpw1tjZsUkI9HqshhE12c10a3iko46kATp5d/KUO6y7Ei6CmUNQwxPXEdY1ID
	uIwodgnpxzoyAWSItHqrNnER5h1hwk0aUBET+rmklAcoeuIUamhJzzjloqHqNfOa
	9KPAZgB/Xj8Ys9z2aJh9X1LU4DsPNX+QTp1Ugugx1eYSV4chFiJ8HnUZ5BYzW1J6
	y+RNgYNh2GGQb66gjMuTGqQLWZjElkX1QP8ceE9gJNoZ2U3SdiXWXATWn2fffoX1
	H6WlsvnaKPK8WVr1CMPH0oTIOZH1DEpdlc0KMnvQOsqtojQmOISVCrmLo4YcVzin
	t0itBnbCqzARz9yycP2wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778160413; x=1778167613; bh=RtFbl6Ia2yXhJKiRS1RPNkHNw34xJHyi2Bt
	4SAeOI5o=; b=KR30JmtTSDfz9l6OGsWUPh0/yu79ihWHxqAE4IG9T+p6O/0QJtA
	FGA+MoxLXHTkHtWFGu2+GWU0Vkpwa1w8d9xzIZsQ70sFF9dJSn3utQZyQ4tInfIG
	OBB7awf7dFcicwGGxZRk7dL3gDkTk4hF0hktAjUSSPncNaBsq7Rrzheh6fHID1gs
	PJmXt5h8XufwPxIPwf47MD8xHTthej+zxw6C5gTrFboIu0O+RT+PJ61a3cEWvnx1
	4jf414tnBN0JHJb6r/qkwik4cSOogwYG9bdKPzSYt/naXZsubqiUfs7SJf2lNkWV
	164QPBAV7atcL0Xqr4u5spsW/YHpqiDoIdw==
X-ME-Sender: <xms:HJP8acELhSxUnoUS7tUiyqrBCwJyMwWAeTfbHiZayH3sU9m5EPvtlA>
    <xme:HJP8aW9u6sa0hZWrVNr7KWfs3GK-sRg3VlRD_5uRSnetFAcfIrnWGkYJFzMysECJB
    ClfYTJPILV9bpgVcmvanHOc1ipzcuRfn9zZZ8nzxWMHUr0NsxBv2Dw>
X-ME-Received: <xmr:HJP8aaOkHsj5_7QEdPwmiegwZ5gVDE7fZW6SwKGC_WpCNnXLaoKyRLak4MY5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedvvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhihrdgrnhhtohhnhiesshgvtg
    hunhgvthdrtghomhdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgv
    tghunhgvthdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepughsrghhvghrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HJP8aUgyTKN4mQxPSB1eipEbWLj7M2tBi6SrSnz-C3-ySugmBbsE9Q>
    <xmx:HJP8aRS1-JQ7pW3mZZGH9lWa5mKBNJM-l4DUm3VCUuZT_YL05GcZSw>
    <xmx:HJP8afoEVimLLWN3HZhogc9Ve8f-rJT-UPjuza35Vizhk513oXaGzg>
    <xmx:HJP8aUbLvJw1--j2LkZKDR--wKanLfHyHBsyrMCmwkz1E8M04bFrbw>
    <xmx:HZP8aWbY1UjMssSJB3tYI__51NNZPiuhEx9aPgJwdCI07hDwUyOgQ4EX>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 09:26:51 -0400 (EDT)
Date: Thu, 7 May 2026 15:26:50 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Masahide NAKAMURA <nakam@linux-ipv6.org>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next v8 10/14] xfrm: move encap and xuo into struct
 xfrm_migrate
Message-ID: <afyTGssXu6Jl3SYH@krikkit>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-10-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <migrate-state-v8-10-4578fb016965@secunet.com>

2026-05-05, 06:34:04 +0200, Antony Antony wrote:
> In preparation for an upcoming patch, move the xfrm_encap_tmpl and
> xfrm_user_offload pointers from separate parameters into struct
> xfrm_migrate, reducing the parameter count of
> xfrm_state_migrate_create(), xfrm_state_migrate_install(), and
> xfrm_state_migrate().
> 
> The fields are placed after the four xfrm_address_t members where
> the struct is naturally 8-byte aligned, avoiding padding.
> 
> No functional change.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> 
> ---
> v5->v6: added this patch.
> ---
>  include/net/xfrm.h     |  7 ++-----
>  net/xfrm/xfrm_policy.c |  4 +++-
>  net/xfrm/xfrm_state.c  | 20 +++++++-------------
>  3 files changed, 12 insertions(+), 19 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina
