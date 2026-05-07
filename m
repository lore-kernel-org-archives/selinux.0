Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804973D5673;
	Thu,  7 May 2026 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148689; cv=none; b=k7iv+/luLUCGOts+bcIMkgQnvlQdSwiystPz+jkTDY5by9ex0MkcI0mM69zoqV7uLujwMeiFLRTO+VGfUW5m1oZYOGSXJd1gkcwU22J6S8R6qU4jSMQgF3zQpfAOVMo3UXq+8+de5APiZlXdruFOUqWhjSQsDsXqnXc+yVaE1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148689; c=relaxed/simple;
	bh=aADs9oSMSK8Xza/MsQNzBwuvvMeXhlpveKI0n7J8k9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DunZCVoKiovm4z0FtKymhm9ouANTQGFL7hTG/BQCRQsYq5PRqsSKbg3jxeC0uDhGCzzsqGpafqv3f9TNCsrWgoXqlLF9YxrZWafBcxKaqwioFqAxf8QdGidNpBykNjm/bLJ7IAh59/FAXnBHSXho7PDsuSpimeyZM//TibT/WHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ARiC8uE4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M9/p6hCF; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ARiC8uE4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M9/p6hCF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id CF0201380220;
	Thu,  7 May 2026 06:11:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 07 May 2026 06:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778148677; x=
	1778155877; bh=3t4hXUjheiudoU94vji1xmcdKSOZDuXpqBx7T7981lQ=; b=A
	RiC8uE4p074LLDMZ9uy6+rdSgBjE/LRekvWY52Cf4F9Ws/OZUPyo+KPWITgG0BeZ
	e9rX4TazJAehkNL7FND0H8I9zRjZAvpUbwxGFdv1jkqAllf/MhEHLfx7KqC7nb6O
	L4PvdkRHYd38SODSVm995Po5fXSoY01tDchwIduL5V9PXEu00u0BMROq3CKTJw8a
	RTOUo1xAGFqezSoAUG5a6u6p2lJS1MTD5PRaGUNBkvOGsv++QCSVnnYBwXkOgeOc
	uITtTnWVIb6G52anNq7gBxxjzMjzzULkgjUI5drBgEFnTNpxOQxWL1NcF69jGsaD
	6gS4Kpto5lcjOySdgxKgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778148677; x=1778155877; bh=3t4hXUjheiudoU94vji1xmcdKSOZDuXpqBx
	7T7981lQ=; b=M9/p6hCF/cWtftPX5I7qR5Kial1YEF++HRZ8h1ftDUbeS6lkax4
	ce2Mc0MqRuMZ9WBPdM+E2Fc+NzIosjOAt5i1l2S6vdHn9fiyzwOQhi9+amUcioOy
	puYDIURm0EO0FZiNxAs9QVAdVh09qrdhlYnacnNy0KQojPfdtTtK+7//FjtN3Xa1
	KswdClZrATuAh+DnSWokmPpqNSmTqZpbb9x+DrUyWwtY+PIcmwgCuZXXU01CvS/c
	Qhvo+9+Iz3L4Z/Db1MtaaIUeBAEjunXX+P9ys0n3zjNYemMhkHSCdvYgZ5SlgsY1
	07uAcfT8cQmly+tvICuJ+zUdO0XSXVZRqSg==
X-ME-Sender: <xms:RWX8aRMxgrvola_k7v81qEW8RU3nk89esctVCFzz5AYFQZwpcZa3Sw>
    <xme:RWX8aVn-0puaVkpZzkf7PK621Y95vHFDb5b43Y0bCDZdtg-rPLB7BvC1RT4Aduw2T
    cwRHC4MPoA7lqX5cc5zzDwZ0z36uJd_hf54o-5rPIulkAhLfy6acgjK>
X-ME-Received: <xmr:RWX8aUUnKPjst1kMh22CP7LRuZHlER1ovPb1YN77-rtYjNHU5BqcYumgj0c5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejvddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:RWX8aUJdDozCiOCnIu8US_njQ4CRRaD1IGLG8ZTm7ULwmS7PDljccQ>
    <xmx:RWX8aYaduYwOXo21T6Ex6eSsFQ9z0uWL_t3wM2sleAX-ib6Db2vYVA>
    <xmx:RWX8aYRpZxz4eSHAeS1MiIdvLwF0GM2sZblt3Bux2G4c84qe2XLsng>
    <xmx:RWX8aQiWsBYDJh3bF3C9WctJMatIkQhcdvUW3dtFLjPxi0TblPEyDg>
    <xmx:RWX8aYDRIdGJmiZ8Jjgbuyzazp-GcJVIEIX1U7qU_WVWhs32qRkSmleM>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 06:11:16 -0400 (EDT)
Date: Thu, 7 May 2026 12:11:15 +0200
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
Subject: Re: [PATCH ipsec-next v8 06/14] xfrm: split xfrm_state_migrate into
 create and install functions
Message-ID: <afxlQwq3URiHYXkP@krikkit>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-6-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <migrate-state-v8-6-4578fb016965@secunet.com>

2026-05-05, 06:33:07 +0200, Antony Antony wrote:
> To prepare for subsequent patches, split
> xfrm_state_migrate() into two functions:
> - xfrm_state_migrate_create(): creates the migrated state
> - xfrm_state_migrate_install(): installs it into the state table
> 
> splitting will help to avoid SN/IV reuse when migrating AEAD SA.
> 
> And add const whenever possible.
> No functional change.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

(I was going to mention xuo, but I see it's handled later on)

-- 
Sabrina
