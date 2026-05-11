Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7838F25F;
	Mon, 11 May 2026 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504262; cv=none; b=M0oGt5RKcsorw0314GBsNmAfdjqUsazoCXfGe/FV83dY0zs8urDAPfwQFATechpTKzEFDbaC4f/Ibx6g3CQulkkK6I8dAL3R3g54eFZj/mncn1v8J65pRGbMJ0KSBXF09iob+uHie/xfmsl3BkO87eqeHDF8tLOFb2pAMM0ESss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504262; c=relaxed/simple;
	bh=T+zncbAmIN2Y8Xk2STET9vNGfkNEwsoAfL1FFMPW80E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOVDD+QQ+qWsdgFi0hPzek9gZoW1Y8CLHchsk5KyEpez2nCu5ZGVOGy/VJF7xPLbPgKVtTNFeEkne3Zn+ItMcsm2R7oE5x53oKcKWt0y3DGZTFpcbC1751FrC0JvmbY2zKq7NoUNBk5YuE0+eyib6Si++s7A6vXxSFWcNSAD14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=UHfU/ReE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RFwEd2rv; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="UHfU/ReE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RFwEd2rv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 6C2A91380432;
	Mon, 11 May 2026 08:57:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 08:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778504257; x=
	1778511457; bh=9ZylBAjhvDw36cIdH/cZimW58y/qeCfbSIMHarjSv/E=; b=U
	HfU/ReE0eGF0atBgOVUXv4OilVhWJfQhktDLokRaQ55xfUQ5nXHW8ABWP1v1700i
	WPmjNbrZbuP9U685Q7Hzn+Jqkpe41FauBl+EauqDf0TkWtJfJJsf/bSUl08hUXgQ
	f1cuNj9EBiy8zG7mzbGaJlckDqlbCu6WPfeXcN2VV1ifggZmUfB0Tl92ZyeBp9EK
	VyWBxzaNQ6Eo2p3ogMz9XBTb/F8PzGVq6ItuCOhWKPSaBS1fL+BPiO/eFt5UnHRJ
	s+TOEQ6TN5BR0QvS3GWbEBifHZHXTVt/HzANrpVeBnnEXr3eA7O4GCi95kTl2mDy
	NKI3nmMSceAp3X2ZWkxcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778504257; x=1778511457; bh=9ZylBAjhvDw36cIdH/cZimW58y/qeCfbSIM
	HarjSv/E=; b=RFwEd2rvJl4W6cfGdJlaHfoXglNAWuooBpTU6Bv0s2AeZ765qZ3
	QDX8aHiO1lXER05/ccuGIqrULUU167isaAzKCmRBNHVLVxTp5dK82m+jvKiSdSfL
	IZXdsNcgNxUWTFt7ZuNq5WZn9083cVlHqR8VTNEb4TFswc1Qk0nTOdr8mfcwDxAx
	DwPUzMX8aThwC9LOljcna9LX0RocZkLfv46cvr8hFlA2m7kqIYMVuVMMDXNyGvWz
	UlOB4uCnpSm2A+ed6I1fq5HdvH+dzgUDf4Vc9yzLpnn0Zd0nOkMzgn2ktwib1g9D
	98jc4eETMWkqtagCTL9IKTm9SgQkqXf4emA==
X-ME-Sender: <xms:P9IBaiIa6ok3fBrwWxfukwjcaK6AvNR5gI2o8Yl-x308N_W-hwU_oA>
    <xme:P9IBaryzSLU6j_74eOGxkvKt2V_9t2LYKPmgkI6z8KeK8MLCKKhEvsESfx0v5rAE0
    aC-sl9Zd7gBQBMSvcTHQgQxZkjriVrNoYHxlcD5uxC_QSxKQesAzA-A>
X-ME-Received: <xmr:P9IBamxUgaFvD4OQe44zdJz1waE1axIN3-ae8cyVxjf1XbJq6yQ5h2tnpt0Iq3LJE49fvkgvIBawLDx_0kVgksU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekleelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:P9IBat2gizePE2hTqULqNwpw4FauESLg4RYoOOrJb0cJf_xFpje1XQ>
    <xmx:P9IBaoWosNg2YqzmWXKxrQ7V58Q7Gfk8x2aCUpq18PO3e6VjAeD-Fw>
    <xmx:P9IBahcyjK0jrzMydfaJDtMXvCoyPhdI8DUZCizgg92rT5b5P63CvQ>
    <xmx:P9IBap8OElGSCzktMKVkdzF4otyYXnVwr6nGm_P0qbEfJMu7I-RbUQ>
    <xmx:QdIBaouFlNyjobY9-si-kDTjl4P1jCpiO77iw-tT3vbL-0Xt00NPbteL>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 08:57:35 -0400 (EDT)
Date: Mon, 11 May 2026 14:57:33 +0200
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
Subject: Re: [PATCH ipsec-next v8 14/14] xfrm: add documentation for
 XFRM_MSG_MIGRATE_STATE
Message-ID: <agHSPUBZg0tHezM-@krikkit>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-14-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <migrate-state-v8-14-4578fb016965@secunet.com>

Overall a very document, thanks. Some comments:

2026-05-05, 06:34:55 +0200, Antony Antony wrote:
> +    struct xfrm_user_migrate_state {
> +        struct xfrm_usersa_id  id;       /* spi, daddr, proto, family */
> +        xfrm_address_t         new_daddr;
> +        xfrm_address_t         new_saddr;
> +        struct xfrm_mark       old_mark; /* SA lookup: key = v & m */
> +        struct xfrm_selector   new_sel;  /* new selector (see Flags) */
> +        __u32                  new_reqid;
> +        __u32                  flags;    /* XFRM_MIGRATE_STATE_* */
> +        __u16                  new_family;
> +        __u16                  reserved;
> +    };

Thinking about the UAPI a bit more, maybe this would be a good time to
start introducing a "proper" netlink API for XFRM? Instead of having
the main properties in a fixed struct, and a few attributes as an
afterthought, use attributes as the main way to exchange information?

Then we can start adding the attributes as alternative to the fixed
headers in some other ops, and later start deprecating the current
API?

(for some reason this thought only popped up when I had the html
rendering in front of me, sorry it's so late in the process)

[...]
> +Flags
> +=====
> +
> +The ``flags`` field in ``xfrm_user_migrate_state`` controls optional
> +migration behaviour. Unknown flag bits are ignored.

Maybe better to reject unknown flag bits (as well as unknown
attributes beyond XFRMA_MAX), so that we can fully control their
behavior, and not risk incorrectly migrating an SA if a "too-recent"
userspace passes attributes we don't know (then if we fail to handle
them in the kernel, the SA may not handle the traffic).

(Steffen and you will have a much better understanding of the security
risks here than me)



> +Migration Steps
> +===============

maybe add:

Userspace is expected to:

> +#. Install a block policy to drop traffic on the affected selector.
> +#. Remove the old policy.
> +#. Call ``XFRM_MSG_MIGRATE_STATE`` for each SA.
> +#. Reinstall the policies.
> +#. Remove the block policy.
> +
> +Block Policy and IV Safety
> +--------------------------
> +
> +Installing a block policy before migration is required to prevent
> +traffic leaks and IV reuse in counter mode.
> +
> +AES-GCM IV uniqueness is critical: reusing a (key, IV) pair allows
> +an attacker to recover the authentication subkey and forge
> +authentication tags, breaking both confidentiality and integrity.
> +
> +``XFRM_MSG_MIGRATE_STATE`` atomically copies the sequence number and
> +replay window from the old SA to the new SA and deletes the old SA.
> +The block policy ensures no outgoing packets are sent in the migration
> +window, preventing IV reuse under the same key.

Does it matter that the copy is done atomically if we expect userspace
to install a block policy? (without the block, I'll have to recheck to
convince myself whether it would be safe, and TBH I'm still a bit
confused by patch 8)

> +Feature Detection
> +=================
> +
> +Userspace can probe for kernel support by sending a minimal
> +``XFRM_MSG_MIGRATE_STATE`` message with a non-existent SPI:
> +
> +- ``-ENOPROTOOPT``: not supported (``CONFIG_XFRM_MIGRATE`` not enabled)
> +- any other error: supported


xfrm_user_rcv_msg

if (type > XFRM_MSG_MAX)
        return -EINVAL;


Userspace will hit that on a kernel that may have migrate but not
XFRM_MSG_MIGRATE_STATE, no?


[...]
> +Error Handling
> +==============
> +
> +If the target SA tuple (daddr, SPI, proto, family) is occupied by an existing
> +unrelated SA, the operation returns ``-EEXIST``.

All this happens under xfrm_cfg_mutex, so if we did an initial lookup
for the new SA before starting the operation, we could ensure there's
no dupe, and the mutex would guarantee no insertion. No?

-- 
Sabrina
