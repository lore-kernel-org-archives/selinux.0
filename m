Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10102309B9
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755193651; cv=none; b=uYeq1T8Xa+YTh66rA+Vhv7j2cmQ3oWvgiVyY5ze1gl8Fx+DYb40pn1CKTAo0uoe2ExKt9un+yCNE8Joi1FHxbjWKbgBCXzhLQGW92R2Je/goF3A6SVmqc5ARBicjuVLJUN9GjeMeYMLeuUW5aWozZBXV4ILLE+Pku9vngzJ1OMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755193651; c=relaxed/simple;
	bh=xdNg5BbS/ezqTA0Kk0jHvrfS8T1ePIygTCdJrP9Gn4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S09fMH074/2NaZRYPGh2jFj1MVFbKPvh2Aef+kMBUyn1L7oFk0g4Uj5cpM5hVcHPEHc2TOvoDi9FBNiOHldWL1yJK0d5jnNZwEyrV3c6+khRUPjCW7sbCS+3rl5Ha7nE6deBwe3LoNXiARlsNRHssSiDndrzRyJcrlRyI69D4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQyP8ipm; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQyP8ipm"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-89021b256d1so193512241.1
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755193649; x=1755798449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYTnGGA7V5+bD5Za59hrUrkk3oWGoUsmiwl+ow/X6j0=;
        b=iQyP8ipm2QkBtfIfGWBOU8AYOd0kjfWMuh8PR7a8jbfNcOYtqk3pn7pdV3Uqot7Klt
         E8I0X0fYHipPmtquWX2OxddOLpG29dU/EQouiZIvC/B8BVkQwDjr6gR7pIDd5m5+5qIX
         d2J9Uo9Dl57TzLPFDzsZsKPLIvjHbPLFAUTMuVDoBv761Xlc1Lda0OD9oIFZeU1K7iW5
         ruBdqN/wGCcImTL+2Qaplz/PyQxpWypFYbpmKUH7yewhEyKoC6j+h2Co2YUlyFErwiUc
         TKdefb0IipdEk3pXZ0PFO64RuitWitxQpZLUPKh+EXCIw5CRx9RDHpz3bhVUPKUnexbg
         QwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755193649; x=1755798449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYTnGGA7V5+bD5Za59hrUrkk3oWGoUsmiwl+ow/X6j0=;
        b=Cp/jIIF++Bc/8K8XqDKig52Wrz/1t/6+c0Q2m8dMeTOtFHbH9OdvtTwoleSW47UP82
         Z1T55dQaPo7YmuyH4d6JlBPYSVZRxjWFV8kO0ot8YlYqbIR2k80CnM8akP16ToNOerzB
         7bqG65dGGRaYRGqeOPQME9/0xoGg4bpdpUW4DwVahHDpxum9Uf1WOzZV5T7u8Em5Pd+X
         YdUuLlH/DU8PKiYnzpkj3OFjr7cJ0XzIZhZeZMZgq9XcrG3MIrNsSMsWwftjpd4ndE2E
         tvQitY4kg6Mjg5FCfFNCY6bWARYUAaaOtXbdCpi1TRke8wwG/aNF1YPQG2tJwYNqSNJL
         pMCw==
X-Forwarded-Encrypted: i=1; AJvYcCVZczGSBln1S1Lx48lwHtIxCEYpDFJSQeQhG9rOyGL73+ovEz0Vhib9eUJUDG6t8h3PsIDLY/gu@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8rghlXqBf+fVJA6RqibP/tlFCry+jfd7s5Hfex78X6D1SpzZ
	2tp1Ip4MiIG05b6EkntP5AcRIQ+f3og3+d6/Ge/bAY0vuJ2E+SEOLzemUXCG5PLRJ5YmIQpHfls
	moGIX2cjYFyTiJol5kubO+HlVl6Al6P63bw==
X-Gm-Gg: ASbGncto17s3hBU38s1i5y1qtNaYGqm3s0gFd4ixcjG06rg6JtkS1H4r+BfeIv+ml3d
	BhmSkx1/VTNTxnKRmmw2mThGYMpN+wbnelV/F11gacwcfE7yZAuxOCzaksyM6bh4GBSH2rCZU2t
	QQ1XDhpoIe+YI2Hof7TrrwXBI2AA3ZvkcVMUfiTsKs1n/L4E/j62uS3jIaY+3A4o1RwLhtqHjug
	RS2bEqIi1KE8Ow=
X-Google-Smtp-Source: AGHT+IHkiho3DlRVf7GWV8wPZQNFIk9wp+8c2BLMu7iKgYEn/aod0RRY9TGVluTq5brhGSiFs8yV8loJauaVugGlQtc=
X-Received: by 2002:a05:6102:3f13:b0:4fc:d0e5:23fe with SMTP id
 ada2fe7eead31-51001e042cdmr1615650137.15.1755193648702; Thu, 14 Aug 2025
 10:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DBRASSYXDGO0.2X50XS44GR1WL@gmail.com> <CAEjxPJ5y9fV+B0_WrT71+NymwHubVVgbNePCa5+tM0deamWA-Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ5y9fV+B0_WrT71+NymwHubVVgbNePCa5+tM0deamWA-Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 14 Aug 2025 13:47:17 -0400
X-Gm-Features: Ac12FXyRIYBOEJisrUH8JVEihSbiaB-hk1e4m0ByYJQWX0BxsVapmxqBMIJpWPk
Message-ID: <CAP+JOzRkLMewUzpbdeQZDx7gR=t4eMysQkThxgBr8sfoaB-f7w@mail.gmail.com>
Subject: Re: [PATCH v3] seunshare: fix the frail tmpdir cleanup
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Rahul Sandhu <nvraxn@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 2:29=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 1, 2025 at 2:21=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
> >
> > > I would think the idiomatic C way of doing this would be to use fts(3=
)
> > > or nftw(3).
> > > setfiles/restorecon originally used nftw(3) but later switched to
> > > fts(3) for reasons I don't recall.
> >
> > It's worth noting that fts (3) is not actually mandated by POSIX from a
> > portability perspective, however we do already depend on it for other
> > parts of the userspace[1] (as you mentioned), and shims exist for other
> > libcs, for example musl[2], so I don't think this is a huge deal.  I
> > can't speak for setfiles and restorecon, but nftw's api is pretty crap
> > compared to fts, so, like them, I'd rather use fts for this than nftw
> > even though nftw is part of posix[3].
> >
> > I think dirfds are fine to use here, however I'm happy to send a v2
> > using fts if you wish - would you like me to do so?
>
> Maybe wait and see what other SELinux userspace maintainers think - I
> am just one opinion here.
>

Since we use both fts and dirfds in other places, I am ok with either
one. I don't think you need to redo the patch just to use fts.
Jim

> >
> > [1] https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/=
selinux_restorecon.c#L17
> > [2] https://github.com/void-linux/musl-fts
> > [3] https://pubs.opengroup.org/onlinepubs/9699919799/functions/nftw.htm=
l
>
