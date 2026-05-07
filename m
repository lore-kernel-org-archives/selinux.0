Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B63CAE70;
	Thu,  7 May 2026 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148842; cv=none; b=A6D6Fm7I3veO64Lm6i1ulYT/uf5CNnowbtd6Wvj77T9vyj7vHdr6fFLIC/4ClVAQ+1e2z9fsC+2oCIkKO1HeJyX7Vxg3EYJlcxC5mmZqLhCsbYEoW6EjmCJTgE4/UYaz4DUHhruixiwfLLGmtNvsw+nL5qZm+lZiBawaPxWsInM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148842; c=relaxed/simple;
	bh=Pduj4URnW69trNA43ahMRzfHJFsP5v1YTGwtCVEOylc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPtUzEe5m4Q7RAjUXjrk2Res95Gc7wmIogPoig7sjxFCEnInYcqj6SuToQOpaI5areETU2UA4zlOv7R7fI9KPAR2gTjsfquUXBFKe9kb81vl6MqDQb5wtSchW03JkLZ/UWqoclWa0lI9hnyCjCDUH3pl18HwfGJYEqFnnaFFbAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=P2UFzXu7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sy9W1BhA; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="P2UFzXu7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sy9W1BhA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id D464713803BC;
	Thu,  7 May 2026 06:13:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 07 May 2026 06:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778148837; x=
	1778156037; bh=3FFUwq2v3e8bOgdMOV9uftE2p5x+Umzu6kxFgcUWFEc=; b=P
	2UFzXu7W9rgKh3ENHsVU8C5GXS9sWGE52PpxjB/wjbBsbAP0aMPNsnydBmPQrGz2
	Nd94z2/lCLK/5ZCLsocZpdlkF9PwsevLWDhAIm/KV+p8bbiA38DoJj5i+Mgp6GcR
	ZgmC9Slj3Q+LmFpUO5SudQZ0kCOyR32uftdiWAEpFAoQgyFr+Luc7EBJ/owNBXjT
	H0PMkUkd/H0dxla7X9yflJqTz4wgLvgccvQVIs2J36KKB5U9l80IVbG1vZ/YiT4x
	0VdMg+VXDutnIxA4XoLCpOdHelxCIw8oQ8FNNzLsy+r+ldx4Gv1zmk824K0TFA/c
	z8q113eq7+bsH80bStjhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778148837; x=1778156037; bh=3FFUwq2v3e8bOgdMOV9uftE2p5x+Umzu6kx
	FgcUWFEc=; b=Sy9W1BhARSXvwYpzXiI8J2Hc8eNBNFHQZPs22vkmcNx/haidZGk
	Fj0qEQb+dJ7mVT8vWdk8fP8LACJEfHV0d3CqgI9mBUE57ewShNZpBxkE54wsZoA2
	C/+tMmw8ZQJsaYGM9rRZcDyb20cSGWHGaLcK/XQuQuEEPr9PSs7qG2YEKeW3je0+
	PtfcD1mUCXakPWfuXf5X8E7m0px1LwxIZsv3gP5DN/GGgssT5AQeZVypPLZdABD0
	G8cWBz3VBIMzIgZbXpQCj9aqEFgG9xYwKJ4hgJ9PpRupexwwJKipLOy03dSnZzYL
	HXDkCtj8y7UXwAZB7VodCUS7OD3QavoCWIw==
X-ME-Sender: <xms:5WX8aZzzkbVCOSu0gbRfnzox6OfRlx7POdWeER2lQ47Rs-rYLKLycQ>
    <xme:5WX8aa7om2GgvxIvDnOFcrFhpBCgfo5VXjDgYM_gypokqUHDHXnDFuMyWSa9Xoa4T
    wYoqkvv9srBNZS_rsepP2y5aiT_NFdTJEU6nOrvUpwtra5L9yEeEss>
X-ME-Received: <xmr:5WX8aXZLmG3vvoTlYcZ9SCMTLzhtgy--rwkFWzC6ggybCZl-hsAr2mZsNQJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedvvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtse
    hsvggtuhhnvghtrdgtohhmpdhrtghpthhtoheprghnthhonhihrdgrnhhtohhnhiesshgv
    tghunhgvthdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepughsrghhvghrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5WX8aR_MfSh4EqAbTUR04TsA2-f96kmsQjs1L_6phe8RaC-TFfyvzg>
    <xmx:5WX8aZ9fgh_9JnRkFlXlPKcId606E2c68rCbgb0igYwisk5zAJt8RQ>
    <xmx:5WX8aSmEUJe---C9Uq3zk64vJYp6j_hCvOot8dYm5K5OMsaSVftj2w>
    <xmx:5WX8aUks_X_qmnjmuOuBAe_WMjnI6bC2_tJ0X1CcJEZLophYCPctyg>
    <xmx:5WX8aW0VfLEVcEdS9p96tL-tFt4rMpj6JF67pWPFdsZMllD-DIhnGBbV>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 06:13:56 -0400 (EDT)
Date: Thu, 7 May 2026 12:13:55 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Antony Antony <antony.antony@secunet.com>,
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
Subject: Re: [PATCH ipsec-next v8 04/14] xfrm: fix NAT-related field
 inheritance in SA migration
Message-ID: <afxl47oV1qlo6v-2@krikkit>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-4-4578fb016965@secunet.com>
 <afxcVV83k7CxImwC@krikkit>
 <afxh6tZDV7RwXQ_a@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afxh6tZDV7RwXQ_a@secunet.com>

2026-05-07, 11:56:58 +0200, Steffen Klassert wrote:
> On Thu, May 07, 2026 at 11:33:09AM +0200, Sabrina Dubroca wrote:
> > 2026-05-05, 06:32:43 +0200, Antony Antony wrote:
> > > During SA migration via xfrm_state_clone_and_setup(),
> > > nat_keepalive_interval was silently dropped and never copied to the new
> > > SA. mapping_maxage was unconditionally copied even when migrating to a
> > > non-encapsulated SA.
> > 
> > mapping_maxage should be harmless (0/unused on non-encap), but I think
> > migrating nat_keepalive_interval should be considered a fix:
> > 
> > Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
> > 
> > (maybe even split out of this series, but that would cause a conflict
> > with the previous patch)
> 
> Can this be backported without the previous patches?
> If not, we might need to split it out.

git cherry-pick managed to handle the small context change, so it's
probably fine like this.

-- 
Sabrina
