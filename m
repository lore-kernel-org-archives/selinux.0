Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242D23ECBE3;
	Thu,  7 May 2026 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150259; cv=none; b=hsG9Opa1A5HEBaQ9cJ/qb78bllWmx3kWEhzEkO+GaADxVWm72V1kNn+knE/q6S/XRLQRl0iasU5H9w9hK8NDLnS6mVm/8dk7N1OuZwZNI8IYyajblEld6NYBQYE82TotNKDek92GAtBAe9hmoTalcs2lAImlwTPEQWFvQgNyVvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150259; c=relaxed/simple;
	bh=q2GDcTJH5Gml4hgrLQhk2hnCNMIXA6pVNtYa2h/zJ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqeh03TFJg/IcWWgKGWFCNHrQ69/IH+bmbMk/X6mtdIymQQNJsnP+nyjAX1vLuqDRsLZEj8ea82rdlKMqeLUarctcdKrl+pypuo8n3PBlIPt3XZDN6JBoZNE+T8ZVgKEbx3mMdvdISO3hQeaaFwUtscRo7hLy2YwehG20tmJNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=o14HmV0n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tj+zdkMr; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="o14HmV0n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tj+zdkMr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 36ABB13804E7;
	Thu,  7 May 2026 06:37:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 07 May 2026 06:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778150256; x=
	1778157456; bh=C7tVfCVjDHK8xC6J4c4N0pOKt1ByL7KntfOb2ttow/A=; b=o
	14HmV0nsYYWa2Ohy1cVMXJpW6ivjXoOhH/XjTo1N5K15+xj0xIJXkqv7DNxXEgJw
	AjSbnhHSUmL5kiNSbPezH1ebiP0xw9e8sLZmK0Fl7MYKRb+MPfGh6xNX0kLb8zVp
	il0B6KQWI+W5t2rc0lqeyVnASfijvS0lc0rGQ7mDBImxw3gk3H66UBDtC+XnBJCS
	iAjicUqrnYRuESEIGr1xaodzPGzblO18KelAociqM//xzp1kcm133PjwDhseofxz
	ZimaF5M6lS+o5ugFX/042SXXL0r+T8KK0/fozJ0aD1LZNk89MDhPFTbKsmwt04Ln
	8vKh4/XEEwyXWI91KlIHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778150256; x=1778157456; bh=C7tVfCVjDHK8xC6J4c4N0pOKt1ByL7KntfO
	b2ttow/A=; b=tj+zdkMrowag5srl3OULQ1pGx7+h87NOQ1hOr8djlQ3JyGw9Fck
	ddvg75iCVzgZhbqRVtTJFnWAaQn371wLqiKj08Z7DuGBk+jnaiD4FIv14bRm5fhJ
	37A8TkmYxG8YddQ04ZpNpYEN7Ic/pzByeXk9dXlUzQ3ZeHFdNPNUUGK+B+UchRao
	cIQM72jbPiN3vtiO9q73M9a9qgGutaG8OVReDvhcf4dlwqPvloXDCQiDyoE+buZs
	jq59eRPQRGlE/cHL9fOwsRIyIPxJz6zk2heB22bBtgEJKbHn2nttnLwGbz1sXx6j
	HrS95YEWcguD5BWKVBcIGl0VmaIfEIuml8Q==
X-ME-Sender: <xms:b2v8aXGVB-hLaTHujjtn_z2-A7Kn3WdSlpvhvrUPxRIrvFEdilUODg>
    <xme:b2v8aV8uc3NG-SiN-35cuhLagybTfszUeVvhq-6aEuo50lrsWE9UttZbX0Ky65qpF
    PrU5bnfFSSvUH00KUlEliZwf292UuZxO3fmpJMxZE7vVhuu2DixS75S>
X-ME-Received: <xmr:b2v8adP9CSyjMtF40BV3livYe84_6LLRgUzCqvy-dbySmEfvG3GPmStJLAOd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejvdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:b2v8abhL4njx5fwoloZ0WZpH_EqgtDo0g25M68g9qonD01J5VHdpng>
    <xmx:b2v8acQp_PNK5pTcc8Anz0HGyrEtY1UZgrDlmsI9R1t0frM3Sv8iyQ>
    <xmx:b2v8aerT5Oqr-ze7Ob9MgVZM1XPSSgRAsixEFfoRtIzvFPzvXCuThg>
    <xmx:b2v8aXaHtjlAI_xLqh8LfoJGKEtXiGb_tD-bD5cI60z0zR_X2OqH3g>
    <xmx:cGv8adbk3FwByP7jXoHczXCOqEJvrC7sKKkThNgptnSyeTgvUr4q3PlA>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 06:37:35 -0400 (EDT)
Date: Thu, 7 May 2026 12:37:34 +0200
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
Subject: Re: [PATCH ipsec-next v8 01/14] xfrm: remove redundant assignments
Message-ID: <afxrbgn6Kny4nF9v@krikkit>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-1-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <migrate-state-v8-1-4578fb016965@secunet.com>

2026-05-05, 06:31:28 +0200, Antony Antony wrote:
> These assignments are overwritten within the same function further down
> 
> commit e8961c50ee9cc ("xfrm: Refactor migration setup
> during the cloning process")
> x->props.family = m->new_family;
> 
> Which actually moved it in the
> commit e03c3bba351f9 ("xfrm: Fix xfrm migrate issues when address family changes")
> 
> And the initial
> commit 80c9abaabf428 ("[XFRM]: Extension for dynamic update of endpoint address(es)")
> 
> added x->props.saddr = orig->props.saddr; and
> memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> 
> ---
> v1->v2: remove extra saddr copy, previous line
> ---
>  net/xfrm/xfrm_state.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina
