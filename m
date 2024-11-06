Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EE11DCB06
	for <selinux@vger.kernel.org>; Wed,  6 Nov 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909610; cv=none; b=TPt98YY+1rGuXgIRzgF67AQ7UTe4RxDouDqBMs6BGTPek2kioJZ2wE4ipAN9QvEvHeFiTvC8szI60f7X3iYOd6wCcAJP2hylWBUgwZoDCy67zXUqHiGiVb+3boIiTf95kck+aSJl8AqYr0U0Fyn4GFVi169Zr41gXFWGVTDOwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909610; c=relaxed/simple;
	bh=bv3/rlPRDtLUJmWm0YAo7VqvOVpmHgyu+NFk1LMsekg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccXceGynlEaTi2qRZeHDjs8JA/DdFMSkmxEKlZMHgZq47mIWoko5H6SrCRZkDuNo/iq8Sm0rj+o9lZMy/tLxZjFMGUiZ7mZXBybBUgz/JHbxGAlQcrp5w8UbEyktjai8lPtxhFg9q8m4l7Im+lMAKQxW18zktb6Xu/Ji9gDeMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hU/YAvu3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hU/YAvu3"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso7264a12.1
        for <selinux@vger.kernel.org>; Wed, 06 Nov 2024 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730909606; x=1731514406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv3/rlPRDtLUJmWm0YAo7VqvOVpmHgyu+NFk1LMsekg=;
        b=hU/YAvu3V3AKoCL0JQeAwrYpOeqIzwE1bk9WndnCxcDQe2rVvHAu/zO6xOHqI2MG2t
         Kfu47KcbINiUWk3IyPoxp+gZy3KrpmhAQlowXZ90SnMGJVX+KmY30CPcJ5QFWJTunkM3
         vHF+XmTFmUzmj8P6E0FS/AvQLkncgsBmdhMlhd+Nrog9r8LL2scepdGqSq2arA9MP6Te
         HTXFficdROcgyNmHsi9jxq6NwwJUKTQwOeO863YzM3HjwgbI07KjkNHQ67WVR6DJ36GT
         deJMWUfzWokpF1ZuxV+7jjJmCshTEVXeknkNnUWb0Ue4aK0S0Q8v3fiMFtYfijgpQ3UF
         iG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909606; x=1731514406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bv3/rlPRDtLUJmWm0YAo7VqvOVpmHgyu+NFk1LMsekg=;
        b=ji+RQeHVaWJ/w8s5UTmxrF4NkawuA+sFsGCiibaa5gB6Mb2jFDlc1eDM+duokVOSz4
         St4vsjoXxsSmfg5XqYu/e0iaRxT/dy7m+1wXyy5M3Y3HlQofwklYCjDBGMakEoMjr5ut
         Dxsy1eeU19lhe35yYyPY6MJN32Ole/dK1/gl87dhOP9QxWOxU5uGL1Qlo49ntAWfmRB8
         crt/vOhMVKs7za4BR0jPmHOA95qLhqbsGH1IHDiJWjsGRhxH1Rj1kuJcNd2I2F1nebA4
         +ffJceSN4Zn1xVPxdR+5YFsu+HqhDSqlU4baR4mZDHo7kSHw3T36njV5Pmuc2wXFLYiP
         WdyA==
X-Forwarded-Encrypted: i=1; AJvYcCWm3bF0ylyldI8Gv26Bpry3EoLK1fPsu0qbERnY0gS+MTUz8GjZwyVXyeSpwSScKm5FtTGI9b1+@vger.kernel.org
X-Gm-Message-State: AOJu0YxzzUIRUmwO7iDvTxAJHnwA/cpPwv42PvQD32FKRcODdFQ1Ievm
	/pbR838MF+ynMJDPpdLgmJuPacRO7O55mR32OOOSph37H3UTSu60Hs7tmu88OyWtS0y0svU3YQd
	lm99hXXUzDhE59lg0IOw/weBHXansLKcBrAIq
X-Google-Smtp-Source: AGHT+IG31oDzIcRRZTXFrc4mSbTzWqOQQfaIeoJMNJyfUTYdBMy9A+Bq3DpljUJqC6apMGKNF0ibhLvsqlER0Z4uNjo=
X-Received: by 2002:a05:6402:280a:b0:5ce:dc71:5928 with SMTP id
 4fb4d7f45d1cf-5cef54d1b5emr3165558a12.12.1730909605487; Wed, 06 Nov 2024
 08:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106155509.1706965-1-omosnace@redhat.com>
In-Reply-To: <20241106155509.1706965-1-omosnace@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Nov 2024 17:13:14 +0100
Message-ID: <CANn89iKag19EPvnQRthsG98pfjriRwtS+YND0359xFijGAoEYg@mail.gmail.com>
Subject: Re: [PATCH] selinux,xfrm: fix dangling refcount on deferred skb free
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 4:55=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
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

Can we explain why TCP packets sitting in TCP receive queues would
need to keep xfrm_state around ?

With thousands of TCP sockets. I would imagine that a similar issue
would be hit,
regardless of f35f821935d8 ("tcp: defer skb freeing after socket lock
is released") and 68822bdf76f1 ("net: generalize skb freeing deferral
to per-cpu lists")

We remove the dst from these incoming packets (see skb_dst_drop() in
tcp_data_queue() and tcp_add_backlog()),
I do not see how XFRM state could be kept ?
