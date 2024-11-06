Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7965B205131
	for <selinux@vger.kernel.org>; Wed,  6 Nov 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912101; cv=none; b=RNWOWjIofAnSUp/KX+zuCxFopOKHYq2O8ltz6aQC1NfvTZca1P7qVRefCSoU55e9Yqy8nYpdotXn1WzMMPXdjE2SIDohlR8a06lzm6168hGp/FYnqA+yWaGtQK/Z2KAAO91+JelZ4KinytFP0oXDk/jYQIixS6tsOrBLYUlpjqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912101; c=relaxed/simple;
	bh=++sxqV8Hz7TIg5CBIU3j35dxqS6QtS/JGqFQ2zsBG4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpdG15xmoQ+qdrQBDyk/EnrVWtfDp8BnQtzwx5IvHYuvOy3Gk3qypiB6/hhqj9j2GGsUWN2Ep7DP+azN17J/oZysKspek+wbcSrMsGFfD5GPMP93rzdPtnOUvWRCpAfdzUogiwvn6Tcc0I22ZV2FEAGSgZPnSd1eh+atwzlCdlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJwBQV4k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJwBQV4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730912098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++sxqV8Hz7TIg5CBIU3j35dxqS6QtS/JGqFQ2zsBG4w=;
	b=WJwBQV4kiY1MxOCbQgVFNqJFWnW8SB91cLvN0g3MI1DE2zJnPFpr+AxdkKA+V3IcoRMo+n
	ALw7W//dcsXl3DTRmMH10RO7qF10QeNDWbmeR9Cyg2RPNznRSDoCw4w8PZ1wL5mSmIRPQF
	Aqlc0gu3jFDSDS1pcyzGoiUSmBd80Vw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-B26f8XImOGqnktzZPsV8nQ-1; Wed, 06 Nov 2024 11:54:56 -0500
X-MC-Unique: B26f8XImOGqnktzZPsV8nQ-1
X-Mimecast-MFC-AGG-ID: B26f8XImOGqnktzZPsV8nQ
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2ca403f5dso12867a91.1
        for <selinux@vger.kernel.org>; Wed, 06 Nov 2024 08:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912096; x=1731516896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++sxqV8Hz7TIg5CBIU3j35dxqS6QtS/JGqFQ2zsBG4w=;
        b=n7tH/SNloiVvK1XB+D+fGYd+XmITmdkE3I8HybvjmSsbtciePDezrLvmBYsSQubq/A
         1PfDQcq9l9/H/kELUsVv0wUr/GDjQmIbw9zB5gHWnic5fDi9b0On+Xwabi/1FK964bEq
         Zh1LerhYB1PMxC5P4hgjWH/EATzXt90p2eE75OGBKdD+Egkrb1qJAR0YqIKQWwrO2fbb
         ktReZ6V3tXxmfVnz63DEmsBRWLY77qioUUAo/sHTASXDBXiJMccliEGi9og2mPtojMTT
         PmyqrxCGKq90IMQxFwqzGj91zxsytgupWWIIfMiXuYXNo3CXTV07AxypQZyI4vu5tI0G
         SWzg==
X-Forwarded-Encrypted: i=1; AJvYcCWIS/gXAlCHYAueU5qf+3ccnHEHSGtaIPix3YdQI08tkvHCOLv4BlXkpYcvjRFgSKOJ5Q9za7TP@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCk+MfD1xNM1JG43Tzgy+iorPnsO2hTaOKC6OwMxpCVNWTivb
	ItEAfLxNdPHGhG7uyh5MR7nvwG13Fdc0lUON7Kh/LsY8rBpa+VGu7WDBqUJ7dKpkCWEQfSsPPat
	jqv66n0L26i5C6CVBSY0W58cUYOPeoUd6Xxq5eh9uE+jMkMtSjbam5PiJDzllIQc4wHeCIdVU6q
	XkdfbySqHVMNwYYpQOU+f1vJyFl6tmfw==
X-Received: by 2002:a17:90a:d512:b0:2e0:8740:26d0 with SMTP id 98e67ed59e1d1-2e8f10580fcmr44145125a91.2.1730912095532;
        Wed, 06 Nov 2024 08:54:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/PAUsvw3T1cUDVzWsCFK0V8Wtzi4keS70YjhIVKI+WcftadE10roLRnwLb+Em7aqCvQXsxMh8oFs/OG2nVGs=
X-Received: by 2002:a17:90a:d512:b0:2e0:8740:26d0 with SMTP id
 98e67ed59e1d1-2e8f10580fcmr44145107a91.2.1730912095236; Wed, 06 Nov 2024
 08:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106155509.1706965-1-omosnace@redhat.com> <CANn89iKag19EPvnQRthsG98pfjriRwtS+YND0359xFijGAoEYg@mail.gmail.com>
In-Reply-To: <CANn89iKag19EPvnQRthsG98pfjriRwtS+YND0359xFijGAoEYg@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 6 Nov 2024 17:54:43 +0100
Message-ID: <CAFqZXNumyhpRvrZ6mAK9OVxbte=_3MG195i_+Z1j79PsE=6k_g@mail.gmail.com>
Subject: Re: [PATCH] selinux,xfrm: fix dangling refcount on deferred skb free
To: Eric Dumazet <edumazet@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:13=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Nov 6, 2024 at 4:55=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > SELinux tracks the number of allocated xfrm_state/xfrm_policy objects
> > (via the selinux_xfrm_refcount variable) as an input in deciding if pee=
r
> > labeling should be used.
> >
> > However, as a result of commits f35f821935d8 ("tcp: defer skb freeing
> > after socket lock is released") and 68822bdf76f1 ("net: generalize skb
> > freeing deferral to per-cpu lists"), freeing of a sk_buff object, which
> > may hold a reference to an xfrm_state object, can be deferred for
> > processing on another CPU core, so even after xfrm_state is deleted fro=
m
> > the configuration by userspace, the refcount isn't decremented until th=
e
> > deferred freeing of relevant sk_buffs happens. On a system with many
> > cores this can take a very long time (even minutes or more if the syste=
m
> > is not very active), leading to peer labeling being enabled for much
> > longer than expected.
> >
> > Fix this by moving the selinux_xfrm_refcount decrementing to just after
> > the actual deletion of the xfrm objects rather than waiting for the
> > freeing to happen. For xfrm_policy it currently doesn't seem to be
> > necessary, but let's do the same there for consistency and
> > future-proofing.
> >
> > We hit this issue on a specific aarch64 256-core system, where the
> > sequence of unix_socket/test and inet_socket/tcp/test from
> > selinux-testsuite [1] would quite reliably trigger this scenario, and a
> > subsequent sctp/test run would then stumble because the policy for that
> > test misses some rules that would make it work under peer labeling
> > enabled (namely it was getting the netif::egress permission denied in
> > some of the test cases).
> >
> > [1] https://github.com/SELinuxProject/selinux-testsuite/
> >
> > Fixes: f35f821935d8 ("tcp: defer skb freeing after socket lock is relea=
sed")
> > Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu l=
ists")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
>
> Can we explain why TCP packets sitting in TCP receive queues would
> need to keep xfrm_state around ?
>
> With thousands of TCP sockets. I would imagine that a similar issue
> would be hit,
> regardless of f35f821935d8 ("tcp: defer skb freeing after socket lock
> is released") and 68822bdf76f1 ("net: generalize skb freeing deferral
> to per-cpu lists")
>
> We remove the dst from these incoming packets (see skb_dst_drop() in
> tcp_data_queue() and tcp_add_backlog()),
> I do not see how XFRM state could be kept ?

The problem is not with the xfrm_state reference via dst_entry, but
the one in skb_ext (skb->extensions) -> sec_path
(skb_ext_get_ptr(skb->extensions, SKB_EXT_SEC_PATH)) -> the xvec
array. But you have a point that I should say that in the commit
message...

And I think you're right that even without those commits a delay in
processing the RCU free callbacks could cause a similar issue, it just
wouldn't be as easy to trigger. That made me look deeper into history
which commit actually added the decrement on free and it turns out it
was done intentionally as a bugfix - see commit e4e8536f65b5
("selinux: fix the labeled xfrm/IPsec reference count handling").
Before that commit the logic was similar to what my patch is doing, so
I could be re-introducing another bug here :-/ The commit message is
not very helpful there - Paul, do you happen to remember what the
issue was that prompted it? I guess there can be some alloc's that
won't have a matching delete in the right circumstances? Or something
involving the selinux_xfrm_policy_clone() case?

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

