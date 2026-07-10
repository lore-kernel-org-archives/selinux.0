Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3436AB4D
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706401; cv=pass; b=ojDQECNpxbWu9IEuQg6lEUbHVK+TMuf1GlLgvM1UxuIMjUqmNlYAU10faZu2GrzA+X+ZDmOAjjfzo8L3FLPLVJM4IYp9Bemx+KHGzJxyuYxdmezKgRBGyW81xjVDSkHHL1sBMIGfZHyhisJFTj+vrYmGmCYwESnosUINPDiLvKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706401; c=relaxed/simple;
	bh=kzjOyZARkb/ClVzEOQOXw9lJ8STBWCuzT3x/gUTrhBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/k6dH9m5Ko9E0ygcYuBVQ7siSiy9lf8JXCPI9O/F36ljMMv42NMGEzIRJseEppOrPCsFm3iwThj7lvBMr2QF54SF9/sI4yYINwCqFaUCw3G+KplziCGW+mMaxn+5Hf68PUC2kfrYr6C0BYelq0FKqMDNrTj1L0XDx8khhXW2wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1BwZRiX; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1BwZRiX"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8487b7b4066so854940b3a.1
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 11:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783706399; cv=none;
        d=google.com; s=arc-20260327;
        b=dt3pdIEBfBV1LC2CeakvmufERyFkpRLhGLwxey9sY2Ln1/u2SkvzLo0wjLHhNLDJpA
         y+r/KZlB5AiNbpwf4Ug3fIhfZdKzaAL+j02ffgKwbOOGLO81aDzzT+Hv2BtPrBFI/pHX
         UFD3TQvCU2Hx4qt4iybJMkKPH1MxaVisDLJZydjUhgLxtYMhk7a/1tASZxJmSaY3r+jJ
         WkxrYEAiUuDhWbcKA4vz7ASlxXvulPYF04f3sv6SkEf1Yd+GAFO1OHfwzujiIJzrA6dV
         CM+K6mHxipGVOJkp0oyO0NwB+aRGn1CJY6T7wAhyiCPhWIr1O0tv4EgmNJPvKNCmQaet
         U7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q+sdsjhjS1z20IplwVicgmKDMg55SKo8U0jUxnGkyn4=;
        fh=7EGa+Ad4nwVFc/fgrpwqDdoR1x4Q8ILDSj4eyayybjk=;
        b=VxRbwKcFIJjAJS6eG9lBqSv2qfPLEoGebTfpxzDRkctoGxPH//9HkkgS2sfL2b6D4E
         nBBl56WyJas1UxaNGDgE3bXJ0gX3JxS8h6SCLVW0WrgbNc5LefyakHR/eLsqC2pZlBrH
         iD6/Rr2T3PGrfP7N4woTkko3f72G6laMhiS1mgvUrmNbi91CuoO+AXWGPMfDW76EuI8F
         gKy1/CrJk7IG73HLUWhy334MhhF6joS6Mkjs8eZ11h05FU/Pepbua40+SybtJcbeGbgz
         LRQt9glO8zQJd/6V1es8KoDVWcggNceczcFaYo78NMMG9H+2p1zFKJbP0rkbmK2S7Vt1
         RiwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783706399; x=1784311199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q+sdsjhjS1z20IplwVicgmKDMg55SKo8U0jUxnGkyn4=;
        b=L1BwZRiXd204ORVsa4BrdJ9b7eNOgYyFc0fSXMD1w2hWlhhe+DLC/SJy61uO6nhURK
         5ee2v7ib/Y+1KnXGawCbnNOFysqOmDPXQkOIuIWEY7ctcSNw2BrW4Gw4mXiIP3Y4tf0E
         qnvIQr+s0joJLcEN/XO16FbaaU8k4+kSyp76uLhjE5NjDJZ8PyN0W1Kz4u48mQAUQWDU
         6mwBNsuLFKsLB2M5dCuJCr4DD/Hex3XMN19tblZlOxKYRhyinE5TyDRzogVk9UZdh0a6
         0HwXz2KbAr1+Hnh85X1FZQ3aEzxGx28umm26Yp8JMIExHvnoBAOGiF67QEhvLUwHr3at
         nKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706399; x=1784311199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+sdsjhjS1z20IplwVicgmKDMg55SKo8U0jUxnGkyn4=;
        b=tHr3pwOQH1PeQj+9ePZKIIlNdiSOuRK7k0YTI005MbUGsxxtdyT4J0jwrEbOb4f0Xe
         GBA5AKdKL3sTcv0LrIPuD4JQ7RUXMmZUgoaELHnd5MelyCGo2FB5t0mELc9kIa/hRMj0
         eCsp03KnUi2WzFL8Epa5npVbvb58v7gcUHkez7HTDIT7LwH3sssFT/w6PCztfAUme0Sr
         /kc75riyX8QlQ2Fsaha6EojUt0WHkD5FZFzA3FPFQkUgmQjKlgGaOhDPeKTgnw4aZhfg
         bwNNa5g/jLLOSKe/Q3ISEIAyfNW+pPuT1tazoHA90l5z93yTTEclZaU0GpkBQsz5K9IF
         SdJQ==
X-Gm-Message-State: AOJu0Yy09jwVnsM+/0EmG2xct7KbxWsTcFD1Lm3PBzFjnRJCyvJeoPiP
	Tj+Jyz9O5Bu3s6zULZArN18Yypmc6+mlKKAI+8fkdW3ym2BLKCI2yMeaVq93RFpbVzwp+6ebuKS
	b/w4wzgEc++HQWI8R94XmovZuTaNb3XM=
X-Gm-Gg: AfdE7clm8DNBwZrJ72npeF3+tFzTDuRKvtQF0NfCrGomCzGtu2kQgkilFWeIryN9oOo
	pNm0fFUxKVFkVXvOMu5/Y8uFC+YCnwHGT6qWViuIPQHudcsTUnYl4LEi1ISiCqi7WG/RvzUjFvo
	ilRhgIIq0eLQ9UtYmT9CQQEUaU7zoW/3D187T0Z9ro+JAhDxMpLwsUV4xQuZgPpjcngxP5xupGs
	RqVJvaLR5dE9LA4mZACxHCz+HGmOGKScWUTKDg5lh8WQfUkW6zpph0MFL5TTYE2EH+CRaIk
X-Received: by 2002:a05:6a00:13a6:b0:847:9bdb:2cd1 with SMTP id
 d2e1a72fcca58-8488970b240mr69340b3a.54.1783706399550; Fri, 10 Jul 2026
 10:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710081533.451115-1-jonderka@redhat.com>
In-Reply-To: <20260710081533.451115-1-jonderka@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 10 Jul 2026 13:59:48 -0400
X-Gm-Features: AVVi8Cdu8yaaLgLHsDhEO5iXuTa-hXDZU3iwnckQFivJTZEQkq95GCQwGCHt9Ok
Message-ID: <CAEjxPJ4c+U7UXEBim0LPSTYDEhgmzG_-iR_LGny-eaUUfTWLkA@mail.gmail.com>
Subject: Re: [PATCH] skip inet_socket/mptcp when CONFIG_MPTCP is not enabled
To: Jan Onderka <jonderka@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 4:19=E2=80=AFAM Jan Onderka <jonderka@redhat.com> w=
rote:
>
> Signed-off-by: Jan Onderka <jonderka@redhat.com>
> ---
>  tests/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/Makefile b/tests/Makefile
> index 4fe6f3c..6db1ae6 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -148,10 +148,12 @@ endif
>  endif
>
>  # MPTCP is supported since kernel 5.6, but only works with SELinux
> -# since 6.5
> +# since 6.5. Skip when the running kernel was built without MPTCP.
>  ifneq ($(shell ./kvercmp $$(uname -r) 6.5),-1)
> +ifeq ($(shell grep -qE '^CONFIG_MPTCP=3D(y|m)' /lib/modules/$$(uname -r)=
/config 2>/dev/null && echo true),true)

This test won't work when building and booting your own kernels by
hand, which at least for me is the common pattern.

>  SUBDIRS +=3D inet_socket/mptcp
>  endif
> +endif
>
>  # nlmsg test dependencies: policy >=3D 30, nlmsg permission, netlink_xpe=
rm capability
>  ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] =
&& [ -f /sys/fs/selinux/class/netlink_route_socket/perms/nlmsg ] && grep -q=
 1 $(SELINUXFS)/policy_capabilities/netlink_xperm && echo true),true)
> --
> 2.55.0
>
>
