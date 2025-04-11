Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AECE1F03EF
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744402179; cv=none; b=SVckhTgaMkBK15DxQ6J4JfDD5g5FlcoFJ3KLdeUvioqzd0RY35CvmBixibrp6cB7Bk3mvN4TDERNpTTlduQ2pncIXJRS9FaviJfs37UCqy3nI1UPeyT64DgISPnxj2DnZSm1VT0mKs+uhoYGN8vKLooCqwcpGCStAi3DZKScpg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744402179; c=relaxed/simple;
	bh=21yvNPq4OdKIL+bkvchjbw/MGuaALNF22N0yQBLatR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZng75JPP11uDN4mZvzEjYU4a2+L363SYJEL0v3uanN3wshxW3aFrb2f6oF6gczmZAPQRxICzc2AYft6bGQ8Kr3DynHvolavqSA1FnP26mJvkSNuUgnHzuwmPLXjslGxwqebw5SpPd5l+nFQ46yw+YBVR1HOeEfjti6Wx7PTQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aVuDQUNP; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aVuDQUNP"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-702599fa7c5so23575947b3.1
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 13:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744402176; x=1745006976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GcjugSSYmWDoQ6ghXIELsbqGaG1SaMXcW6c00jIJHg=;
        b=aVuDQUNP1q8UJmP7yJOI+PGd+EvAngmS3u+IsbQYX7Z1UigqDJsPEWXaor8PdFwMog
         bnayzMgCMuPuZJE2HJs32ESFTu60dL8YBpzLeYPJKKhVOh2GnKmw3+GcvoCZN8db5l2q
         YF/0eLVS8HdVMjSmVT5Gxsjl9GymW5Lm9/sSY6jaIepqTPeKW7CDSF+JraXdk90cgjYp
         0+5CvyZnhYAr2jXgKH1J8G8gKmzirUZDnBsdSAQvAA4rcfSrkSpNaC/EqBk+xIVGkyTT
         8wLltvpa4Nfx2nJq9bmEzJt4N6Rns6piWHqln/u/O9dKmcCfDTtnu8SLLVPiw++85s4W
         RHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744402176; x=1745006976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GcjugSSYmWDoQ6ghXIELsbqGaG1SaMXcW6c00jIJHg=;
        b=X4flhsDcskml5E9vRpNqXBjIcuLNogkD1bXAPiD/kKOKCp4ywhDADX1OhB+qq8Yqj1
         cu3Nbq5J3OamHuplwW5A4eRwjf4m52fkrdC+yjRgEO4vClNy+R/wTV1QQENPjsWsS6zf
         Cdjr+z/I+7z8y//zJpg0/McHZYkmT12AUO25jkRjkAuUwk8zaahYCClnaRW0Y46jLuib
         xdZ8/bmxUzFQCPvlGojHbwUa2L3CYhVzbVuoX0iUOJLpF+KtH7w09KpDBGQzbOJ8SvPM
         evB7l9j969a0f8ZcBtBveTrOKN5+Z59jcJ7RIh8SjS9ZJQuddxkzGL5H2wK1slKMclod
         Tp6w==
X-Forwarded-Encrypted: i=1; AJvYcCXya3wulvvnSUo4cdN6lO54s2eRjov3ylJJZMumidXGHfaphZW7Ejm2FKuh7V29uQPy/rEMhlq3@vger.kernel.org
X-Gm-Message-State: AOJu0YwOIn0UlCDI50cjhqlF98MVs8u7ZXUqDJkiE2OHOb/6mWj3S7fe
	FfKk/TM3AouE85003P4eY5nPU6uQC5HhKAf7MRdbmcK24142Q9WkyB1+M87E1O7CC2ckecIVHso
	46O4YBgKEr8wPHDHvg2P5CeFCWXkbJq8Mkn2B
X-Gm-Gg: ASbGncvqFdcGD9BUtjwmQQOq2wh/loUmAfOeioVorp/JeGa3T9o4/ftkkRGsovl1kgR
	oxTsT/lDqzrqKnn0/uEccZua4fNHpi2waeDC5oN19LAOv+sE9gWg6uiUgNMvzPj5dAcrGac0U7e
	VjPIUswSl2B4XxNOUMusRTAA==
X-Google-Smtp-Source: AGHT+IEr+91wsNbiAEq6x0+fQAi0c6S+sEU6+/AksTONya6ApekmKG1cLBE7m3sZ0up3vpnnkD4115NERiH7CRon13c=
X-Received: by 2002:a05:690c:3692:b0:6fe:bf32:a427 with SMTP id
 00721157ae682-70558f8057amr68283557b3.0.1744402175968; Fri, 11 Apr 2025
 13:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-51-paul@paul-moore.com>
 <d16f307c-349b-4409-a237-ae7092584576@schaufler-ca.com>
In-Reply-To: <d16f307c-349b-4409-a237-ae7092584576@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Apr 2025 16:09:24 -0400
X-Gm-Features: ATxdqUELldJHXfGjYhNEDkIw1GjqNYtZz4Fa16Lgpfa5NTdJpD8GdzXyPKxnGuA
Message-ID: <CAHC9VhRgeb8NQpi0bzTt=P640_LZAm9=U8Efor=aXQdZRRBYsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 20/29] smack: move initcalls to the LSM framework
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 1:30=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 4/9/2025 11:50 AM, Paul Moore wrote:
> > As the LSM framework only supports one LSM initcall callback for each
> > initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
> > wrapped with a new function, smack_initcall() that is registered with
> > the LSM framework.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/smack/smack.h           |  6 ++++++
> >  security/smack/smack_lsm.c       | 16 ++++++++++++++++
> >  security/smack/smack_netfilter.c |  4 +---
> >  security/smack/smackfs.c         |  4 +---
> >  4 files changed, 24 insertions(+), 6 deletions(-)
> >
> > diff --git a/security/smack/smack.h b/security/smack/smack.h
> > index bf6a6ed3946c..709e0d6cd5e1 100644
> > --- a/security/smack/smack.h
> > +++ b/security/smack/smack.h
> > @@ -275,6 +275,12 @@ struct smk_audit_info {
> >  #endif
> >  };
> >
> > +/*
> > + * Initialization
> > + */
> > +int init_smk_fs(void);
> > +int smack_nf_ip_init(void);
> > +
> >  /*
> >   * These functions are in smack_access.c
> >   */
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index e09b33fed5f0..80b129a0c92c 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -5277,6 +5277,21 @@ static __init int smack_init(void)
> >       return 0;
> >  }
> >
> > +static int smack_initcall(void)
> > +{
> > +     int rc, rc_tmp;
>
> separate lines for the declarations please.

Done.

> > +     rc_tmp =3D init_smk_fs();
> > +     if (rc_tmp)
> > +             rc =3D rc_tmp;
>
> Replace these three lines with:
>
>  +      rc =3D init_smk_fs();

Done.

> > +
> > +     rc_tmp =3D smack_nf_ip_init();
> > +     if (!rc && rc_tmp)
> > +             rc =3D rc_tmp;
>
> Change this to
>
>  +      rc_tmp =3D smack_nf_ip_init();
>  +      return rc ? rc : rc_tmp;
>
> Also change rc_tmp to rc_nf and rc to rc_fs.

Done and done.

> > +
> > +     return rc;
> > +}
> > +
>
> Or:
>
> static int smack_initcall(void)
> {
>         int rc_fs =3D init_smk_fs();
>         int rc_nf =3D smack_nf_ip_init();
>
>         return rc_fs ? rc_fs : rc:nf;
> }

Done (with the typo fix you mentioned later).

Thanks for taking a look.


--
paul-moore.com
