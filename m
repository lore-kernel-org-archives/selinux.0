Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792430087;
	b=nOydpmKn3d/CnXEFQ0pQ0a5zt+HBoY3mSXKjUweJu/1R5biVjq6tasgfXxWUZhpuRqC/
	 94b18p+PZjKjtd/9/jLvBbArZJpGq6LZxrFb15cL8kJIjmdTT23/Auc+2QkVWzFYXhK4S
	 TAyO3IsdOoN8j+Q/dObE2L5uxaRfOhks9EzYt5tOguLBkeQrQsA/jQZ0PyBJ+DI/nZ1oA
	 p4AlIXFT7uV5Jul0Dax9p/gpSfMw2PIVCspVZH/1qGUboK6cvU9fvAeWnY6rgKkz1M+aH
	 VJgtSYFjAG7d7jAW+vf7D6GuAQqDFx1lYH3+7teSJH3swwaLP6GUYncRzGiDfc9gSdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=sn/Dg2nRYypdg9K6AS/WuQNlTgdEjyASXFDLC9W2h50=;
	b=LQgAZOLA8PiCV6jEX2IHxO1UgxbJscUsoxJY/TBo5IPwJB+wdSCW/cDnTRvviNwuYavm
	 lu0CL1SWa7Z++DnFbMnKodihioX4RraUmUKkWXoevjmtEJTK2AUW7xf7Z4ayWVOJh2mqG
	 d3/YaY2c1KxL2HOjdrW/0I/OwlWoyGFQKv7tCK1qHDEyzp5SGz+o3BbUZaIOpXVFrlm9q
	 RuC2GTmJVPgy3QovPD+3llTjjt/jNghu+xV6yEZDy1VyAyHUlkqCa44scuG1NKnkhAsnv
	 FqDRunhNI8GYJyJYaihEHO4DyxgNQktgZagQDXo4JW1jI0eZNg3Ab3vOugIJxumyNUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BO8xEt2F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6C606A31F
	for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 17:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CE6C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BO8xEt2F
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67921b515a7so2459001d50.2
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 10:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792430086; cv=none;
        d=google.com; s=arc-20260327;
        b=HKw+NCj8DcbE+1CkzQEbP2vM1viCeQEPMKuTMxOVbSCBzyyWqy+m1j1LR9qZZkE7fF
         UENWKnCKi8Kud5RQrUVBMHdIziYE+olvqW1Y2e0jzZ8ntF6cSD7orZzgNEBGAGG+rMDL
         B/HBSHrQo96cGfHzg2P9boxxKwT9oBlioKpj2Get9Ed4wNvc8+nHXzWKgBOjeo/R5gxp
         LdTn97sf93IiQpUyv4eiHfQ0myZugJLiDLAEJi6wbc9IfvmjTJ3/WL9RyOE1RFU/hqId
         mRvaBo9lSvMWnuGMFZUIwOCiQu5/4eEERbloCc0oFnVPC6Slz+As5bck8k1p74LO9SxV
         mKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sn/Dg2nRYypdg9K6AS/WuQNlTgdEjyASXFDLC9W2h50=;
        fh=dJFGPQcIdBSKfAGSkBBiK4EUt5+B5+Lca+i7TUzU1Gg=;
        b=mF759iIxPKY1RqvrwtISGjujcUUEQ08Y50CtS+iGNyQncjqiDFWETBPQqLXPbtw2v4
         GWGqB9QpHZAre1OtA6wFKzycmI4oyccqqStk41JNywyWiF7BvRDmP3Yq9YpMwD6+jVyI
         MSRYKmql3fhkbXbvzYGfU7ewpz+2C86AAYSSXOOrpQgzRHgyKYinrcjN3NhxNqP78agM
         q/6RSWVrjNfXgpGcKiQg/E2QX38ymWVo9q5dnUsICfT83VK3XF7DTgHXedmmZHW7ut2R
         bWJQhlN8W2qrlyh5djE8GTbf/zmF4EVbII7zhAXTtDfwDHjISvzUdS5qZoJ4GzRgeY9d
         SrdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792430086; x=1793034886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sn/Dg2nRYypdg9K6AS/WuQNlTgdEjyASXFDLC9W2h50=;
        b=BO8xEt2FzdghnWZlwfWXlESIgAAVUHpz0DdP7iPt73d0SvGf1ryX2dwHjgj4IDP/02
         goiJRD1pFmgkPJ6wqk6XBRDXWac1a+bVHDej0jrU4nIIV9RCFFJoIpVvncfO5UdBCgY9
         SPmS/w+fmR9knxbcDUBfx/n/nucV4feKzV/9JDFFrQdB3lk6Q0oKF82hd2MJ0PcwJLPK
         fsBh6Czh6Cznt0mRs65l6BDuiuXJD44pXXtE/0m0oGX3sey9pFWwYfgJlDDZ1et3I+q9
         gsYcM5E/eb0unOy8osDnj54Bl3glQuTmxGwV6HYRVzKaGkPL2tLcS48Z+ZRy98MNYW2Q
         d7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430086; x=1793034886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sn/Dg2nRYypdg9K6AS/WuQNlTgdEjyASXFDLC9W2h50=;
        b=Y5XoT6i8rkw0KvyE/banKrs4v+DQhDJ1GJk2l/absjJBgY6nGrJDma4x21qT7DkIMV
         dCojiZWyjGLT5nZy32Jc87W+5/jNWlYyfyZX1kbRmxVXPZw55M+WiJxfKxrXXrK1nLng
         wj9f9Ku5+G3PaEb4C9wtqTitGn0dnHWRM9Xw39CoyNd5KuAe+mHiuPrTa7aUOM72Vgrg
         ffYmSQTxEU9mRq8+q7H9B58B5sCQvoUfqyIk4PHngjK+IflTqJMTMt06Qu41kkaf4bPu
         KujmiP7m4Ad0oolgGt9fQGQtK8Pj3x9fR9kAvImb/QiOlvWuN+bpz/tDH9GijaEkjDOQ
         typQ==
X-Gm-Message-State: AFq9FYKekU9JI0XkoJ2qSflr8kPV2zVh+NrTuVoEAuwU4CIipsg2TBD0
	oemWVZQE+fULb5XPmKT9Sthv5ZHPJdQrxODVtQhDJT7609G0nsdB0aIR+EWd6s9BxWKZ2DMJNqv
	m9k17e6vy57p+s9WA/se3iqbruXys2Ow=
X-Gm-Gg: AYBFou33GqYppvukUekqRum0+rVK5vpFBx6S4ylGkO34hOSYVqHH2A2BwXZF6nxhUzS
	z5AHWTzZy9Cz1e+RfZkJz0+QUUUXcwMdaeDSKGZSbvFY4QRIbtR3y4ASFZzode/i//cAtFl+Ptq
	vRyaqBjEN1PVfuTk49mnRY11QRVrXdx7+qEy+3qJdB7TOrb/khAKgMPZu8+Ky+RejBCHbPls+kM
	QlLeFXemLm2Ua0zmzE81MRNsb/eL2mUt8JlhltRtx71jEGNGYcL3OIiRrGraRDI9H27myI54YW6
	iw1iU6MSAEsng6jpH+GRnHxNF5h5GZkfpgOFz15iTJxtQjtyjBWW4FU=
X-Received: by 2002:a05:690e:1208:b0:679:c6ba:9208 with SMTP id
 956f58d0204a3-679ca9098f1mr3094738d50.102.1792430085981; Mon, 19 Oct 2026
 10:14:45 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <71419b5cb9dc6c289ac7a64b9fe44a3b29bb5d56.camel@infradead.org>
In-Reply-To: <71419b5cb9dc6c289ac7a64b9fe44a3b29bb5d56.camel@infradead.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 19 Oct 2026 13:14:34 -0400
X-Gm-Features: AclHuK9PfeA7ARDy42YF9_odhK4q4kbcJjQuwjMFFlUHlsxoNwZb_YKkVqeK5YI
Message-ID: <CAEjxPJ4fydhRXZTxcbu+d-Gzw9qa-u65cqB2gD0Qs6TT++MrRg@mail.gmail.com>
Subject: Re: [PATCH] tests/tun_tap: set an owner on the device for the relabel tests
To: David Woodhouse <dwmw2@infradead.org>
Cc: selinux@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:05=E2=80=AFPM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> tun_relabel creates a persistent tun device with neither an owner nor
> a group, then reattaches to it from a new context without
> CAP_NET_ADMIN, exercising the tun_socket { relabelfrom relabelto }
> checks. That reattach only works because the kernel permits anyone at
> all to attach to an ownerless device.
>
> Kernel commit 3ca459eaba1b ("tun: fix group permission check") made
> such an attach require CAP_NET_ADMIN, and all six relabel tests failed
> with EPERM from the kernel's capability check before the LSM hooks
> were reached. That commit was reverted in a70c7b3cbc06 ("tun: revert
> fix group permission check"), but these tests should not depend on
> which way the kernel resolves that question.
>
> Set an owner on the device before making it persistent. The reattach
> is then permitted by the kernel's owner check either way, with no
> capability required, and control reaches the LSM relabel checks that
> these tests exist to exercise.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
