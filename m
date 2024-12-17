Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B7142E77
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452922; cv=none; b=Wr4d/GApFuqMUXTFcDviOo1p0qbKB2SNuEfIjXzCNAL+A9Q89mZxVHvvEF6Tx6KEOTtRVL3NqBF05+N+3ehLoqMzBniJ93CnLhFrdsMOLZr6eqlOqCFTR9W8pOh2Kj/GT8uo/Yh34t5AkxJwQ7uAr3Fayd9mlqb+sYvYw4el960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452922; c=relaxed/simple;
	bh=xi+EvDv3mfP7FJNM7jdAx/U/zCcNzlpG//oDHVtyOAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2wGilCn1BCmegSS0xVfP2NgC/tArsOG+a9ZDlGJW/bEJRJngQQsrRxj/z/sd5RjUXsWlkaejjjVDI8iv8PuDRKr9ExcsRYnUVnmzkbaWng8PzqsM1sn4rLZQOC/mqliv8ag418G0c15dgub6wIjIQKcPwoTcg1ZcaRuEumCkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DMWimmlg; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DMWimmlg"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6eff0f3306fso42124647b3.2
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 08:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734452919; x=1735057719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oplx5EF9Uv6U6y0+zlXvsrW8UpMXAgXXwfP/18u7p/8=;
        b=DMWimmlgUENUoyOyh9659i7Av5UKOCFH7XAFr1kRu6R20PAXJ/jkYY1OyTNU8wUA9V
         OHgiaNuwjRaiCK5rIx4Gm17pj5py2aozbmpfaa32KCYZRnGpxMwmygRVgNW1LEGxMKZ9
         dBxzgrJfSw+0Z51JpLrQhG9aFYsTg/jxYcoYI8WR0BCS84wRYHhOlJ4U/xCVQBCzQzfY
         cVrDsKilC/HO2L2E4pY4QKNAK33A+VYr7CEzzTpJRHTup4ePNFlsoOexg/AybuaFK5mj
         CqVjjKjsxK30XMAHO8NCSiAklQcbPWO7P6kRjXBMG3vvpuqfR5CMV0txhuf53l4VD/47
         dtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734452919; x=1735057719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oplx5EF9Uv6U6y0+zlXvsrW8UpMXAgXXwfP/18u7p/8=;
        b=NufDjjUIPgYMcAKIE/iBv1Chxjccd6f34r5J+8hebZKp1/KgfpfpQKbOP4QE4PWojX
         48PVFPTU+awy/jIIZBdp79iMVzIYXRn8WMRtIks8gsAfkxDWeNpE+Z8RpI+Z/U2i02Vn
         1bzC3g83SXBFwCSdeDK7uFoiia16A6cuosXuPQVOd4yjm1GBhVeRohl7Ye84a0KNOtIr
         MeifKRBxpXzCM/omSZUUZJGZZi0H4x8XXmCoVMuVerxhakUhYEoR99dO970wHFyg1aBl
         YsD2//2vPFL1UqUatoN36UDk1gRpEZI6aS69pzOWM+NWltUvyDQYryWgJK65M/7XIjGT
         jEZA==
X-Forwarded-Encrypted: i=1; AJvYcCWSUyTeo7k/f+3oCjFkfIY6PGYLqBtgowdjiG+PTy735241YTTSkErcuWNT0deSHUpMy67lIStH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaxy4/Lp5xNB3iOqjgjJJ4691iz1qVAxfDUmX1NuvCVJUbfCVE
	/JDoUYUy50zOhW7mlpXlOv7yivk1o81D2W+/M3HK3P6czcAdhrSaX1fEB3b6/+8UC8dD+J0AJIy
	nSaJmf3tI5JLO6kMGi83IV0/VToMfKB7p8vVo
X-Gm-Gg: ASbGncu1Q7ub0nI285nXbDOxSh/496dIrTCX5lLJOy3sLcunBYSrp8i7Ku0CI29RESV
	njQ6dbQvMgFuqlNNPZfMKrq9KgeUry/g0UDSK
X-Google-Smtp-Source: AGHT+IGc5fBo1Pf0q19qCQSdLfh3T0jW14Juegj81JBHUIpwPQbSXQ3S+6e28+PUlrptzsHP39NFArMWHgbJK3AEG5k=
X-Received: by 2002:a05:6902:2413:b0:e39:8b94:16e6 with SMTP id
 3f1490d57ef6-e43508bbc94mr13345721276.39.1734452918882; Tue, 17 Dec 2024
 08:28:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNuVK=Pt6Vx8xiUF7WFhCD3VrqjW=dvox4wHWZfHBCEDTQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuVK=Pt6Vx8xiUF7WFhCD3VrqjW=dvox4wHWZfHBCEDTQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Dec 2024 11:28:28 -0500
Message-ID: <CAHC9VhTqe9roT1dySDXDMQzbOSZyA0f34H0a1xinDSLd-TyQTw@mail.gmail.com>
Subject: Re: kernel-secnext aarch64 builds missing?
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: kernel-secnext@googlegroups.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 4:17=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> Hi Paul,
>
> It seems that aarch64 builds of the secnext kernel stopped appearing
> in [1] some time ago (and kernel-secnext testing results for aarch64
> stopped appearing as well). Were they intentionally stopped or is
> there a problem that prevents them from being produced?
>
> The new Testing-Farm-based selinux-testsuite CI matrix includes
> aarch64 + secnext kernel, so it is somewhat affected (until [2] it has
> been quietly installing rawhide kernels instead and passing; now it
> will fail when no secnext kernel is available). Any chance the aarch64
> builds could be reinstated?

[NOTE: adding the selinux list since it is somewhat related]

Hi Ondrej,

Yes, sadly for some reason Fedora Rawhide, which I use to build the
kernel-secnext kernels, started panicking my aarch64 system *hard*
after an update some time ago and I was forced to disable the
kernel-secnext builds.  Unfortunately the issue appeared to be due to
some userspace, or compiler change, that affected the entire system
and once my build chroot was updated using dnf the entire chroot was
bricked.  I saw similar problems on my aarch64 dev/test VMs.  I dug
around on the RH bugzilla and didn't see any reports, nor anything
obvious via google searches.  I was hoping to go back and try to debug
and/or restore the chroot and VM but I haven't had the time.

As a reference point, Fedora 41, Alama v9.5, and Ubuntu 24.04 are all
working fine on my aarch64 system so I doubt there is some hardware
issue.

Are you aware of any nasty aarch64 problems in Rawhide, either now or
starting back in October?

--=20
paul-moore.com
