Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FDB33CE80
	for <selinux@vger.kernel.org>; Fri, 16 Jan 2026 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582729; cv=pass; b=Ibvu1UAUPtu70fur2iBXrXS8As8LI0BVH2N0CQEDBpGEKqQilqB5jL92E0RjnnIkI+ONH+CGdRByzgcp+O296NdsQUbdZC17enUXMgTV0iEUCSc7BVAJDknIhsTbhHoaDvaY+F+vwL9sdHCig0ffWl58MdOz5nwi68tG7EdmVTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582729; c=relaxed/simple;
	bh=FkYqPR080OfoBAuQy9optFwsOG7cfVx5lAgyQWx4o/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6PXPSv2FIMRtsxNUUJzZbb0ZRtmR3YFGyR8Zz/qcMz4krwCTToW01riUfuqVxBFA+Y1e1acqjlNSNf5cU0/7a8m64cVJypsHrTEYFkDvLVcJ5VfrdI2D8pKg4tYx+4RyngZaEC7513aECNlcOjn8jNSAj1CKQ4G40twB77sJFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsgSfg8i; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsgSfg8i"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso1461329a12.1
        for <selinux@vger.kernel.org>; Fri, 16 Jan 2026 08:58:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768582722; cv=none;
        d=google.com; s=arc-20240605;
        b=euY8ebd4H3m+9s/Kt2hI/DWnyfDaGA2z9o8ddIxuYzeoJmx+pWREVTvBjywFhLuwXk
         IGLdTna8BJuclPnZ/4iKcnlBm3cZlH10DWu1q8YRP5g7+sNbnb7ZvBdL5NMKPyOw1vZT
         GvlExHbhEye9NM0YBGZBjVfKuNFZ7OjoSIIfHyuJwPVSQorin6CTHPqmmVHp5LWz0S5Q
         1iuvkAOg3hhnDKbQAULwo4BN2pTvvN9/6mBP8isljrrBewiRnWMoHfIZUMeU2W7P5Vxu
         VAmlLV1vxSrqAyZ6SQCaZOjKqFtW2grZTJvoXDWaMD+AEasi1KvWc1SGynf0nEXY4iWL
         KjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oP5CLRf+DhXRcw+ROdqtxREaaT4XKBb5d80U7oO+zhg=;
        fh=SfZ5EYkHaJZ51oj8H8MyyfWb8kx486pagBR0u7MDvj0=;
        b=X+bhQ8F00wgwej01EGuODl2qB0QugAKkNG3gs/e0F8ZWFEShFrYGS+DiSWrfaGFt5M
         /xbINqvMWjJd3+ZM6l7j46mWgduXN9I2XxF6WlxdbGeAoHfkLDx5J9LUdtlCimOeLVag
         rt0seRJPztdjByj+TtAWjeSONzYK9olXzNFJ0x5oluvPm/irnFspNMW4VCE/MLIqhrBd
         r5agTs28cgcgoZ4zrObUQcSKn7lulQREgyg/JY8H1MPFv9Meg5fq8P1zcL0X9CmNoCCI
         IUMN9pSTzaOcyKeTi3tR/8CZSOcsqZ8wKAeLJFfxGN/zhs9yPphEuL+FtmBjbY6ChShU
         RnNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768582722; x=1769187522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP5CLRf+DhXRcw+ROdqtxREaaT4XKBb5d80U7oO+zhg=;
        b=CsgSfg8iu5pPtuSaknk3sYL/Ct3lcekAL64GstztMCPBcUHzR1eX89g9O++eMza5mK
         ULUnjtkH3Rskph68CkiaSfYefjIQ/0aeWing5/pHG8au1NvySwzUPtY6p9+0o6N5wfqz
         NYEcDxswdpOXyibQH+Pio/oQgM5MafSQjdIeMVLhTGCtGNddMvR/H3eb8+9rSO9X5KFA
         ifCUqaqRYncEp0BJtNM+w8j5iFQlH3umIK7NbnjQxZoqAzvi5x4IufvXn+9Sj6p82KsE
         vWkCOPI9clUL9KbTjirerIrTtLq1MV1d2HWCCwVvp+IQccHzxkPzsD9TElT2CvCjdtdn
         cLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768582722; x=1769187522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oP5CLRf+DhXRcw+ROdqtxREaaT4XKBb5d80U7oO+zhg=;
        b=RwOwteIyESaboDHx1vzJCP6R4nGeHJV9oSZOh0SqWoxWoqUrnWsW5DuT79xHnaOM/2
         rja8enRmAaBCuYu3Iev2FJsO9nC70dpbxn/LaeQ01H4oIjA/pZYb6EFzx/zbvzN+mYfD
         ExDbuIQ4mlreBFq+Pdu/5LbHAjlnmYsI71vhvb9xFoLZtKtykT/yYi1ktVs3jsMmg17w
         Pd9fQTfawmU6G3dXcEWYIRu6eItgfn/qLTSDCxWoQfks9af5qFjF6HEp8HKtIH6wewqg
         nuJQKuixFSk62NcpY2pRoQXdMDj9OVnVxANjelOLiWqva10wXRBCjMjN7QnArpRNC8Md
         Gm6g==
X-Forwarded-Encrypted: i=1; AJvYcCXXD/ptOvFIjFfuXlIGJ/et8PoxfGgccjj60O8m/YU3WTIxlw8IFVNnrady7hBBHJuu2ZB1OtHV@vger.kernel.org
X-Gm-Message-State: AOJu0YzjhWoOVU5riQ1b9b56kk2NphFnog0/ZV6TlGPpipRcsJn4l+tE
	y9Ta+RenmNSkMV9FNLaTddI5CkvVTUwaY4pImTyPkIH87c9lVsKDtA15+bbyCBvE2R1GNKg61F0
	94yq6AwIR/msHw90gy30g8VHvYdM7tlM=
X-Gm-Gg: AY/fxX4c8Qol31rgCnXQhAOgMpUIA5f+C3MjzeK24n/SQ46lDPf94C2rgwhAeBHjgap
	+77y5K+uIGObSfS/ro3dalaGfcJB5w/mivW/VIOCIS7q6EUWjNppii5pIXED98HPoa/gG1R6it3
	tWq4uNBP4vKY05x0x9w/H4dDHvoxywkVh9QHo3WrcodDMrCyZ1EVXr3EJa4QhYx69FVQ382i3CC
	JVDTACe0xIKFkqL+Gj2mMl5Zay1KYCZrhKh//08rcv1WiZ+a/9lcnhzdq/2cVdINqPpWK8=
X-Received: by 2002:a17:90b:56c4:b0:32e:7bbc:bf13 with SMTP id
 98e67ed59e1d1-35273298fdbmr3004467a91.34.1768582722046; Fri, 16 Jan 2026
 08:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aWlLs1o5gk7k5osk@1wt.eu> <CAJ2a_DeFC5Z2VKXoDDkKmhcB8cft_ZtU1UtriPX292q4GRyh-A@mail.gmail.com>
 <CAEjxPJ4ct1tWUs14C7Hdj=xZBK08qJ4XMfqZ_SAAq2=icMXm5w@mail.gmail.com> <aWpZsLEVc0lQ5kxO@1wt.eu>
In-Reply-To: <aWpZsLEVc0lQ5kxO@1wt.eu>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Jan 2026 11:58:30 -0500
X-Gm-Features: AZwV_QioPguVh6EN8CrlEYi035PEFJVLg5iJo6cCQ2Q4W09gU765x48KoKHNmE4
Message-ID: <CAEjxPJ6xyngQaWGiih+LkJ=C7yvJYMEp7Nr92tzC+hVJy0R3PQ@mail.gmail.com>
Subject: Re: Suspected off-by-one in context_struct_to_string()
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Paul Moore <paul@paul-moore.com>, security@kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 10:30=E2=80=AFAM Willy Tarreau <w@1wt.eu> wrote:
>
> Hi Stephen,
>
> On Fri, Jan 16, 2026 at 10:12:15AM -0500, Stephen Smalley wrote:
> > On Fri, Jan 16, 2026 at 3:16 AM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > On Thu, 15 Jan 2026 at 21:20, Willy Tarreau <w@1wt.eu> wrote:
> > > >
> > > > Hello,
> > > >
> > > > we've received a suspected vulnerability report on the kernel secur=
ity
> > > > list, that was clearly generated by AI and really not clear at all =
on
> > > > the root causes nor impacts. We first dismissed it and it kept comi=
ng
> > > > back a few times. I'm not pasting it because it's more confusing th=
an
> > > > interesting, though I can pass it to the maintainers if desired. I'=
m
> > > > also purposely *not* CCing the reporter, as the address changed a f=
ew
> > > > times, and once you respond you receive a new copy of the same repo=
rt.
> > > > Clearly this bot deserves a bit more tuning.
> > > >
> > > > The report claimed that the call to mls_compute_context_len() didn'=
t
> > > > properly reflect the size needed by mls_sid_to_context() due to an
> > > > off-by-one that would result in the trailing zero being written too=
 far.
> > > > Initially we thought that was wrong since there are +1 everywhere i=
n
> > > > all lengths calculation in the function. But revisiting it today ma=
de
> > > > us realize that this indeed seems to be true: the +1 that are every=
where
> > > > are in fact due to the surrounding delimiters, and the first one th=
at
> > > > appeared to be the one accounting for the trailing zero was in fact
> > > > for the starting colon.
> > > >
> > > > In context_struct_to_string(), we have this:
> > > >
> > > >         *scontext_len +=3D strlen(sym_name(p, SYM_USERS, context->u=
ser - 1)) + 1;
> > > >         *scontext_len +=3D strlen(sym_name(p, SYM_ROLES, context->r=
ole - 1)) + 1;
> > > >         *scontext_len +=3D strlen(sym_name(p, SYM_TYPES, context->t=
ype - 1)) + 1;
> > >
> > > I think this +1 from the type name length covers the trailing NUL
> > > byte, since mls_compute_context_len() and mls_sid_to_context() cover
> > > the one byte space for the separating colon between type and optional
> > > MLS component.
> >
> > That is correct. The MLS portion is conditional on whether MLS is
> > enabled; hence, the +1 for the type length computation includes the
> > terminating NUL,
> > and then the mls_compute_context_len() starts at 1 for the leading ":"
> > if MLS is enabled. The code could admittedly be clearer but I don't
> > believe this is a bug.
>
> OK and I, too, think that mls_compute_context_len() stands by what
> its name implies. But then *who* is responsible in all this chain
> for allocating the room for the trailing zero that is being appended
> at the end ?
>
> Or is this the last +1 of this block maybe ?
>
>      *scontext_len +=3D strlen(sym_name(p, SYM_USERS, context->user - 1))=
 + 1; // ':'
>      *scontext_len +=3D strlen(sym_name(p, SYM_ROLES, context->role - 1))=
 + 1; // ':'
>      *scontext_len +=3D strlen(sym_name(p, SYM_TYPES, context->type - 1))=
 + 1; // \0 ?
>
> I'm asking because nothing is really clear, and if it happens to work as
> intended, it's not super clear why.

Yes, it is that last +1. Historically, originally the MLS support was
a Kconfig option and the entire
mls_*() parts were compiled out altogether if MLS was disabled. In
that situation, the context
ended with the type name and thus counting the NUL aka '\0' byte there
made sense. Later the MLS
support was changed to be dynamically determined at policy load time,
but that function still returns 0
if MLS is disabled so the NUL byte is still counted in the type name
length computation above.
Happy to split it out into its own line and move after the mls_*()
funciton if it would be easier to read.
