Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59376634
	for <selinux@vger.kernel.org>; Fri,  8 Nov 2024 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731024551; cv=none; b=tkdEWAzhv4kG7hSMfoCUoC0jMJAsuH75e9BfbrvsOSzCVGt1BglCTp2p0xkxMw8oeFdHDDa8URqL8ECx+hI7OUifcny4BKgeW14UpHy/B7k0z2WeWojcoMPlK4+kin2gkF9HbDjaiwmAMagI6QdhLZaBkbDW5EY/NEpaLjEmyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731024551; c=relaxed/simple;
	bh=bJ2P20AN8cDjZQ0XfwgDLYWnqcBSl8k5ypfy5tVqflk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUDJBL1TReVFRW8e7076P3bgxwoC//tbOQlzooiqEbMlRa01xtLx1Wg6xjohuRY+Nfk8aeHr1Jt2SrmHCW9xHAzGElf77pcu097gWc0ny5wPsAU4GCgVvWr6hNMCel9QsdckZsGZSrmRDcMMD3FMBj8vfddAIKIOgThtUspWdUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YViT8mGW; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YViT8mGW"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28fd8cdfb8so1578926276.3
        for <selinux@vger.kernel.org>; Thu, 07 Nov 2024 16:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1731024548; x=1731629348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbCwZydrQslWxwqzFgVm6Z6/uYlo1zjGWUOPL95a3K0=;
        b=YViT8mGW8dR+t4PTbkDbAp4rrF2mPSnwy2j6fkiLZ2vnxOO9xytrlfX6gxXYurxrqb
         7qRUlk2L9sdMGqXCGkZzfw+nK3I4Iu/zUCgKFurTzvwYub5zuIjHrMwpnEsWcF2e++Tl
         /9tkLwYbtNmKNhuASWZ4lOon5vaK9UIZDNhMbSVLiV+IrNzU3GxTeM1T5Py95H/ojcv5
         bGqulrvx2q1WUeFjTiziOlM2US8WDLpIYZqo7YJL3ANC3jwso3rIqFrQXfmd9BDCSFq3
         ynCi0wudfdgLFIz4iV/EqLMC3qT2rTxgAxxS/YXdPDyo+iZCHa9DSS87ISr4ulfaHLWe
         uKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731024548; x=1731629348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbCwZydrQslWxwqzFgVm6Z6/uYlo1zjGWUOPL95a3K0=;
        b=GANSBhMr0R6CKS+FaLocDU9v6hhxv+5EvU7nC2iU6wtSvxvqlZ3Fv4Z8fqnfagAdEU
         +mjV6Ur4Nd+IEc0bmAKWuO2Z0V80T8/vMQrGWZu6xKahXF2ToeINAE7NdwT1S8OkjOfR
         kVzuhmHr/D8ZBlLau3w+hpRBb7ktabWhFwefjXZA9vGjgVooIlDvhAnTsHZiZkB5Zl2c
         Asn1b8c6uxTq+V2n0Aa8Q36IVfzEFV2ZrQxZ3OASzUcmcQixB8Utfo+Zvhc4dJDCDZU2
         X7kPEt2yewftbZU+QjvMqegPrZlUrml+fswwBGu1+PAPhyqGToDU4zBu3M5h9HC3bpDd
         qUCg==
X-Forwarded-Encrypted: i=1; AJvYcCVMYzijstkOFiGZz+/p2gbUQis3K2wHjl322Gpwm1xcJbNHu9TBs1xfVVrkev6iFQ/8MG8AalBh@vger.kernel.org
X-Gm-Message-State: AOJu0YyW2S/y9GzNundJoOY6jTqvFCtMy3dzfO/Y1KpcA8ujrCL7K2Zo
	6yKp3v54vmHbuGlwuNHGazL0WvkfCw/br6zrIeEXIUranZ6rto+jwoE7OfC2TN8/jPrQDeyrCD4
	xVlfPGD5XOI079YRWfS7GIIyvEULgA1CfoUns
X-Google-Smtp-Source: AGHT+IEFY/Z5gF8qAR4zZA1iORWkmzMJW8bQ2tPZYEKW7ACn+ixJs7j+yN1gMVbsT56MLsOsXKPmyf5zuDrLEq7uS74=
X-Received: by 2002:a05:6902:2d04:b0:e30:cbdd:7c85 with SMTP id
 3f1490d57ef6-e337f841ad8mr1283168276.11.1731024548355; Thu, 07 Nov 2024
 16:09:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106155509.1706965-1-omosnace@redhat.com>
In-Reply-To: <20241106155509.1706965-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Nov 2024 19:08:57 -0500
Message-ID: <CAHC9VhQLDCu4S+SiY=s=tpxPFLn4AJiuhijAVS63QayfRoPN8A@mail.gmail.com>
Subject: Re: [PATCH] selinux,xfrm: fix dangling refcount on deferred skb free
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 10:55=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> SELinux tracks the number of allocated xfrm_state/xfrm_policy objects
> (via the selinux_xfrm_refcount variable) as an input in deciding if peer
> labeling should be used.
>
> However, as a result of commits f35f821935d8 ("tcp: defer skb freeing
> after socket lock is released") and 68822bdf76f1 ("net: generalize skb
> freeing deferral to per-cpu lists"), freeing of a sk_buff object, which
> may hold a reference to an xfrm_state object, can be deferred for
> processing on another CPU core, so even after xfrm_state is deleted from
> the configuration by userspace, the refcount isn't decremented until the
> deferred freeing of relevant sk_buffs happens. On a system with many
> cores this can take a very long time (even minutes or more if the system
> is not very active), leading to peer labeling being enabled for much
> longer than expected.
>
> Fix this by moving the selinux_xfrm_refcount decrementing to just after
> the actual deletion of the xfrm objects rather than waiting for the
> freeing to happen. For xfrm_policy it currently doesn't seem to be
> necessary, but let's do the same there for consistency and
> future-proofing.
>
> We hit this issue on a specific aarch64 256-core system, where the
> sequence of unix_socket/test and inet_socket/tcp/test from
> selinux-testsuite [1] would quite reliably trigger this scenario, and a
> subsequent sctp/test run would then stumble because the policy for that
> test misses some rules that would make it work under peer labeling
> enabled (namely it was getting the netif::egress permission denied in
> some of the test cases).
>
> [1] https://github.com/SELinuxProject/selinux-testsuite/
>
> Fixes: f35f821935d8 ("tcp: defer skb freeing after socket lock is release=
d")
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lis=
ts")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h   |  2 ++
>  include/linux/security.h        | 10 ++++++++++
>  net/xfrm/xfrm_policy.c          |  1 +
>  net/xfrm/xfrm_state.c           |  2 ++
>  security/security.c             | 26 ++++++++++++++++++++++++++
>  security/selinux/hooks.c        |  2 ++
>  security/selinux/include/xfrm.h |  2 ++
>  security/selinux/xfrm.c         | 17 ++++++++++++++++-
>  8 files changed, 61 insertions(+), 1 deletion(-)

...

> diff --git a/security/security.c b/security/security.c
> index 6875eb4a59fcc..f6a985417f6f8 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5295,6 +5295,19 @@ int security_xfrm_policy_delete(struct xfrm_sec_ct=
x *ctx)
>         return call_int_hook(xfrm_policy_delete_security, ctx);
>  }
>
> +/**
> + * security_xfrm_policy_deleted() - Handle deletion of xfrm policy
> + * @ctx: xfrm security context
> + *
> + * Handle deletion of xfrm policy. This is called on the actual deletion
> + * of the policy from the xfrm system. References to the policy may be
> + * still held elsewhere, so resources should not be freed yet.
> + */
> +void security_xfrm_policy_deleted(struct xfrm_sec_ctx *ctx)
> +{
> +       call_void_hook(xfrm_policy_deleted, ctx);
> +}
> +
>  /**
>   * security_xfrm_state_alloc() - Allocate a xfrm state LSM blob
>   * @x: xfrm state being added to the SAD
> @@ -5345,6 +5358,19 @@ int security_xfrm_state_delete(struct xfrm_state *=
x)
>  }
>  EXPORT_SYMBOL(security_xfrm_state_delete);
>
> +/**
> + * security_xfrm_state_deleted() - Handle deletion of xfrm state
> + * @x: xfrm state
> + *
> + * Handle deletion of xfrm state. This is called on the actual deletion
> + * of the state from the xfrm system. References to the state may be
> + * still held elsewhere, so resources should not be freed yet.
> + */
> +void security_xfrm_state_deleted(struct xfrm_state *x)
> +{
> +       call_void_hook(xfrm_state_deleted, x);
> +}

I'm not really liking the names or the descriptions above.  The
"_deleted" hooks are named a little too close to the existing
"_delete" hooks for comfort; I can see people mistakenly calling the
wrong hooks and causing problems in the future.  I'd also suggest a
change in the hooks description to clarify the "actual deletion"
aspect as that is confusing when you later talk about how references
still may exist.  The xfrm hooks have a "_delete" to authorize the
deletion of the object, and a "_free" to finally release any LSM state
associated with the object once all the references are gone; using
"_put" may be problematic without an associated "_get", but how about
something along the lines of "_release" or "_drop" with a description
that talks about all references to the xfrm object being released or
dropped?

> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 90ec4ef1b082f..35372bdba7279 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -321,6 +320,14 @@ int selinux_xfrm_policy_delete(struct xfrm_sec_ctx *=
ctx)
>         return selinux_xfrm_delete(ctx);
>  }
>
> +/*
> + * LSM hook implementation that handles deletion of labeled SAs.
> + */
> +void selinux_xfrm_policy_deleted(struct xfrm_sec_ctx *ctx)
> +{
> +       atomic_dec(&selinux_xfrm_refcount);
> +}
> +
>  /*
>   * LSM hook implementation that allocates a xfrm_sec_state, populates it=
 using
>   * the supplied security context, and assigns it to the xfrm_state.
> @@ -389,6 +396,14 @@ int selinux_xfrm_state_delete(struct xfrm_state *x)
>         return selinux_xfrm_delete(x->security);
>  }
>
> +/*
> + * LSM hook implementation that handles deletion of labeled SAs.
> + */
> +void selinux_xfrm_state_deleted(struct xfrm_state *x)
> +{
> +       atomic_dec(&selinux_xfrm_refcount);
> +}
> +
>  /*
>   * LSM hook that controls access to unlabelled packets.  If
>   * a xfrm_state is authorizable (defined by macro) then it was
> --
> 2.47.0

--=20
paul-moore.com
