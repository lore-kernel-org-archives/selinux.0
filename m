Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56E2BEC4E
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256594; cv=pass; b=PWIyt5NmAoZGESfqHBHhC1vLjbICas9fEvLoq4V6lpkYvgId2v4UpqRQ7wOv6h2AkmCLbTKYjyz6zpNtzkleuejpVdgJVItdSGGuPUjK74S2Vz4soEf7gnAqkR9kRtpOeyGYAEwKeedLri3b/2XxRSxH6m7hvimwbZeMVPomuf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256594; c=relaxed/simple;
	bh=M8EjYk3MWR85F2C3oasBgUNot8htQ94fM00K+CrogZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzpDVCZd7GmZNbad71VP4bAy0zmG/iq+XM/LT4MmjGVdq8PJN5aO1LZsmeWAB2870JF/OMuMkN9hVpZU0sYRE0WjAUvSPOHe06+5Wpq4f+P8aH/bfWa4gVmKlKvYvFZ8d7kfU5r8hMcStv5Da/iPPpuHMlBXXjkJGeHca7QBNSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOt9Ftnl; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOt9Ftnl"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-459281bc13bso155725fac.2
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 13:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787256592; cv=none;
        d=google.com; s=arc-20260327;
        b=lbvSDm9fCfx/gSkJrR/dtx65yP670byYCwI6YciJBYMw36vbxIJHpZOHI5sDQQWrlg
         EhU7vC74s8FYvIDOojWArr/gMJGkw/12huVAcx+/tNNGsc796Lj4l9m+wrJvHNpgRw2V
         LGPcjvLwD7AxMxcjD+RRLsWX+PS5oiRuXa7xL7rrSWvOVEl4AzqZQQ6lbKoaIPa9KNqC
         WDqelMCGAdr2wDrlwC69wx9Xz5tGhBWUFHb7WlNm+0HCjbj10fK5qcIzS/ToapKtctf5
         TNPiNNnudqhw6ANKFQDZS+W3n00aTKpPXbQr0a/K129JoHc2veC5mdJWhg1OqtFNYeWC
         bTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M8EjYk3MWR85F2C3oasBgUNot8htQ94fM00K+CrogZ0=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=P/bJddBcYpQoYP3OJRJF5HUO2/iL+PHT17oMLbYi56seXVxQ2riqE3u2C+7cHt3oUG
         AO4bVAG4IfpLOwUgKEYa2IaPvAKl2/gnNPm/oYhYW4X17tptuiN2KBEQikKCNtEy7Q0M
         Ysg3Mby/tWqW6EJetMtDkBsKeZ0je/eFtey7G6zUI5IclRNah5xkRDRfCBnUxYKhuoY2
         e8YrCSBBMCnFTSkBhUXgEJl/NYndZN5TsoUxiwmAU43BI8U7gnf2NvsO1E8evkg5jFg3
         izJUEhn0ImNMpWvgCxgTcfJ2q0qzriGUmE3epUP/ef4S0xh2nbHX3pSfqNGAw9053+GX
         j5hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787256592; x=1787861392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M8EjYk3MWR85F2C3oasBgUNot8htQ94fM00K+CrogZ0=;
        b=FOt9FtnlxAw314ibk+RyT9SQFQ47suMn0qcpV4B2ob4C7inn20zIIgxpwASR7t60fr
         +Rt8KtCeXcP5WnX9UBbeV5KHSoGt8qmn0Kb2isWaQtJEysKU3qaAKp94Ji7TDmTTszBC
         XysHqts0W0u81MQ3JSCmkuBm1x0BdAF4btYFJ15QUJ+gw4GQYfrvaq5zQqFIkNE4esD3
         O/oHhcZ/KlRz14hcI+z6RJ23UQCOA254eyPPPB0Xwqi4H1vVC8h9Z+hi4gquW8bm2xeG
         rdLa8UH6jG0f9vr/4TKe8TWSP5EnwTWSpL1BTa+mGjsnfWfRnVXMaike62EapefKjlOO
         M4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787256592; x=1787861392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M8EjYk3MWR85F2C3oasBgUNot8htQ94fM00K+CrogZ0=;
        b=Xj/dlB73qdHg+iStSJRmiuFlJ6MJsGJLqaFF7rIxywZCYSJevgIAMUN06nkRyVvR6n
         YtRnYprPIkv95ayltQgQ5S3dASdNlY4VUG6MixMTM18586LfhJcarwpPYPei/ilGoqCi
         2B5mtE1+lQaC8eBM0ErOIJ975JakPqDtyT3p2FjhSyt2vV9nu0w2fH3sWIdOgQ0e0C4E
         +NGs9Ole96cZuvY7hbVKR4Fi4Wcv4uGYuJa+/FrUZ0DCRdX3zfOrKrIe3yA6P3Q56+oL
         GZQP8fm7knZVWI1bDFdZvJKHBx0n1GtpNPzL8K4di/vIFFZagFi/JTChrmiWQDwaTw5B
         7m9A==
X-Gm-Message-State: AOJu0Yytw5CowrL/+yoeR+ApSBZBvwvggeAWkYHW/gVycW1FNi1QQB70
	qVjFouihbVGIn2YQsLwmLSnPWHzNSBkKtz6CL+QCVHjkPcFQY3c2HWxXJfFn2Q32bu52Soisrat
	eph8BWmvPX1pYQJiQo+mnlWwxuBSYqws=
X-Gm-Gg: AR+sD12tO8wFTRy+jfOYpOlkzIloXS281oGlsOPAKZDXKl7FVJwyW8vhZ13Fq2fG7uq
	AxHRddHc7vB1c9xQ0syGAINeVlHijNIDaOruvqnVTJV2D7Fo5u8m8hKDjIpy4ClmcBkUNmiK4BI
	NTU9YE5I5sLjrHDtXsOMkf7SWc3FClhdQPbvTjEAcKHvDQVEOXH2Rbu9TO2St6SERlgsB5OM2YA
	rEJmeTwd5yb+3N814CRnph5dmiI0cOaTOBAUtNYbBnMx60bBBI8NJd6Q1tZD8CElMHIub2jidfq
	eSMNSMagBbQaSx2e461npEg+PUPP4xj/lx8E+KctrdwtGtvqXqRfSIQ0
X-Received: by 2002:a05:6870:16d4:b0:448:3eb2:8c8c with SMTP id
 586e51a60fabf-46350f869e9mr797387fac.6.1787256592031; Thu, 20 Aug 2026
 13:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820154143.12706-1-jwcart2@gmail.com> <CAEjxPJ50V=sQrV21z5-+3fXizB1hNEgiCZAP-6tm1a8d1TzXDg@mail.gmail.com>
In-Reply-To: <CAEjxPJ50V=sQrV21z5-+3fXizB1hNEgiCZAP-6tm1a8d1TzXDg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Aug 2026 16:09:40 -0400
X-Gm-Features: AcwNN1XmE1Ph-aBFIkhoGdGm54MGu8yFJ6AXQJ2ylBL0ytd-JsJjon-VDMZI16g
Message-ID: <CAEjxPJ5T0e8A4=OrbsneehbjBP_pPSJhE7aJkDF56bT6AXCAsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: Validate expressions do not mix tunables
 and booleans
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 1:04=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 20, 2026 at 11:41=E2=80=AFAM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > A conditional expression should never have a mixture of both
> > tunables and booleans. This is not allowed in CIL, checkpolicy,
> > or checkmodule and could only occur in a maliciously crafted
> > binary policy.
> >
> > When validating the policy, validate that conditional expressions
> > do not contain a mixture of both tunables and booleans and exit
> > with an error if they do.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, both merged.
