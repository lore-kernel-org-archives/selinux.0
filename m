Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA02384CCB
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224543; cv=pass; b=cvIDjxxGESt2TwH+PU7YuUDlBo9eF/F/OWMonmJsHknRiY2Oo4dbp15HORJG5ThoitaUzRyfJfbU+vdNrs3RXUoPeWCnwkl67FdIgX71SGpGail5346Q9KmenrD1j3lcheQKvTb0MX10Xpn9C5n3frGp7eTuzR8kVLkk91Y07X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224543; c=relaxed/simple;
	bh=MqJMW40jflFLBUkIE7r0LJ5nyDD1aWW2/kGLReSIA0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kt/o6Oksw8PB62fWEmhwfmQvM7bBATrKe1ToNKYqr9UlQ6SUlmdSPSOKYr4b0/6fiEia1DdmNGNsXDFDTn0A7/ufkzVAQGdINzISNIKfKmfJlmCxZSZoPIFnWgMBQx9EkL/RS9kFaaQf60nFrUUyaOEzKQGIudOmIphVACZQRHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o78SzCXt; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o78SzCXt"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5ad4ee80f65so4970830e87.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 07:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782224540; cv=none;
        d=google.com; s=arc-20240605;
        b=HNExJ1YpCXa8n4sQAsaKmsUa1hOOvW0LZi3z1iSrGIm6Pw5gAmoUqEb41nMZuAdCH9
         9P8xCEQ0wjOtd+yBCHyTkI0nNFmKYXBhPfN9pFHMjypHexXeMLkuP4GNWRT5AyXEnGTU
         EVPRcp93aj/lv6VBDtJ6kWpEReipI/vz3QiC4Y/m94djUbVaBr4Y6daHDgnkmN4Y9yjR
         03UJSdGepIz2mVZv3SZzxPApeVnJgrIvWdfZk78envPPWuHxeKbNhweDYEDBf9JzpSjR
         WEYV3EeE8VN/nDUmLQoOdmXWCn4zZeUf0wlSo2DEx57L/rsgyw9NZaPLL734NQv/8JzY
         ANUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fw1AM6OqanWbBwIPJbYrzE1wVGPiIH1m+UHZVHJDvsI=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=i9wbqcdXKqxnPPHbLRNGVZxRw1z4597HoY8TEOwPuukbikvNUlrET5nt24Xu+9w9xG
         gjPclkZbEocTdQzdo1Y3Me7pkTuQPXOt10bVyaFfSVJoqij5DGx/jmVMXVSmakfSJj25
         tkW98mYTYPT63r4caIZystjH2903VhaKoBb3ZPy1C4x5Kl926/U4jz0SNLzHE6UXe9Ou
         qFx17mCp+rAPmP8MUBk+9VPlXiuTS0hMclhe4lAltjkbNHyne8tHWhHabmMXtYbcZICL
         VjovZQb7qq/KFNUxzMUXOefB02pLu23/b2hGVsINqYoDUgNcbkRM8XYgCc+v8hERaBgy
         sbYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782224540; x=1782829340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw1AM6OqanWbBwIPJbYrzE1wVGPiIH1m+UHZVHJDvsI=;
        b=o78SzCXttNAfzgQ0Fe31wLq12LdKpIQlN/HUMSWJTnIWg1rcKSC7oGYbfII4yoiD5q
         YmcXr3EeVLlKgLBmD+UaTdNitlv+h+QUOlITjJsRP1Z55Ave31eJOnaG4Y9xVh5Esomu
         u463be60OUI354mybAsc8SUY2gL38tSO76UhtijhFT96dfZ7BSyZw88Y0kap+tbIZCE6
         pCGw6PCtDDd+az7yAKKzTH5cU6vBRLUfwQ4vWEizjykULmqhLQVhB02za03uBFVPoQW2
         X7qubChSMLpq6P/mA2I8Uv3xBTpkdKcksyfbfw2d3M3UBnBUFQIevC9+f5nh607ZFKod
         5jzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224540; x=1782829340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fw1AM6OqanWbBwIPJbYrzE1wVGPiIH1m+UHZVHJDvsI=;
        b=LdUZS48cw1dU50dFTnALOSk+IFIubh6mXN1nM0LFtL9DXCiaWf7zTRq76bFTb9prTC
         R41Scp77OZaGp6WoMq30JVNJ4JOzgqbLne6oTWfkOmKILGHwWpYJUklCF5MbUodpETx8
         8bbQTL3C125JSeGGTpYt9zrPQlnwRO4bGLOt4tYKQeu52RVSHCNiTcY9170htCOD3y3P
         xuNTKxm5KMZVQSmH/6L1MXIVOQtTWaLdYnOZkYnAyGtiNGLhtHahIkSY6a1hFZSDMZ5R
         5AIPZlgzaeA1QylvnQrgnk9LFJmBsfCxf/vSXlHlK8wCnBUQDIooE5PngU8++eQl1PCj
         ujZQ==
X-Gm-Message-State: AOJu0YyPFMacPhLv3e9/eARZyzPtcGE4+pT4lQoYKYxZGiDxCnRYtbQc
	wtoMW4culbthE56oPINBsB0kQbCB62pXBHT4MJ02XerKQjP+8aWjuQW4k6/bPfwlNpSfmwYnstX
	FiZTDb3qs1C+7FiweNVZKPCfr4Bcc7+A=
X-Gm-Gg: AfdE7cn79wEOD2UQMbQYs3utcxe6IJk+Zyv2p3UpgF7DBXMhtUNr2Enmftzw4FcfEUg
	J0kSHC7rZ0s/wqapINJEjpzmXTMk8VGBd5mgLuUooeB/TdhoTZsLX82rm9KNOaIGObfiNo2ABlJ
	azKt+alrqgqgEBJ55oOmH9g7Wo4ZT2MfOK6HSdobtUIPpyRUNds7nHVB8hZP/bDZhR4NyxapyQY
	Ph90K2F6WWHEqu92tLqZ6sQxaeBuuVHFP8Ow1GiT0Zu83R5/n3c0UpbEq1LQzZUEWpcxA==
X-Received: by 2002:a05:6512:8053:b0:5aa:75c9:d317 with SMTP id
 2adb3069b0e04-5ade474cddcmr689869e87.45.1782224539700; Tue, 23 Jun 2026
 07:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622173541.174998-1-jwcart2@gmail.com> <20260622173541.174998-3-jwcart2@gmail.com>
 <CAEjxPJ7z08VwnAudM7Ljr+9duzV5CcDzJJnsE7BrrnUpMokqDw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7z08VwnAudM7Ljr+9duzV5CcDzJJnsE7BrrnUpMokqDw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 23 Jun 2026 10:22:07 -0400
X-Gm-Features: AVVi8Ce2NRoCyDG_ONrzDtGiPy0iywPioQ2ufe0uhoOgCfiyqUq3hg1nAF0pXd4
Message-ID: <CAP+JOzTnJUNSo3Y4=3UJ2CusV_Ym73RBRrEsRJZnsqQxhBmg3g@mail.gmail.com>
Subject: Re: [PATCH 3/6 v3] libsepol/cil: Add overflow checks for circular
 reference checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:06=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 22, 2026 at 1:36=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > When resolving aliases a check is made for circular references.
> > Similar checks for circular references are made for user, role,
> > and type bounds and for class permissions (class mappings and
> > class permission sets make circular references possible).
> >
> > These checks use the common idiom of using "limit *=3D 2", but
> > there is no check for overflow.
> >
> > Use the __builtin_mul_overflow() family of functions that will
> > do the multiplication while checking for overflow.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> > v3: Use the __builtin_mul_overflow() family of functions
> >     Split out cil_stack fixes to a new patch
> >
> >  libsepol/cil/src/cil_resolve_ast.c |  5 ++++-
> >  libsepol/cil/src/cil_verify.c      | 20 ++++++++++++++++----
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_=
resolve_ast.c
> > index bdbb871a..a805ca17 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -652,8 +652,11 @@ static int cil_resolve_alias_to_actual(struct cil_=
tree_node *current,
> >                 }
> >
> >                 if (steps =3D=3D limit) {
> > +                       if (__builtin_smul_overflow(limit, 2, &limit)) =
{
> > +                               cil_tree_log(current, CIL_ERR, "Overflo=
w");
> > +                               return SEPOL_ERR;
> > +                       }
> >                         steps =3D 0;
> > -                       limit *=3D 2;
> >                         a2 =3D a1;
> >                 }
> >         }
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verif=
y.c
> > index eb732e44..240f3b23 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -975,8 +975,11 @@ static int __cil_verify_user_pre_eval(struct cil_t=
ree_node *node)
> >                         }
> >
> >                         if (steps =3D=3D limit) {
> > +                               if (__builtin_smul_overflow(limit, 2, &=
limit)) {
> > +                                       cil_log(CIL_ERR, "Overflow");
>
> cil_log() appears to require the caller to provide the terminating \n,
> unlike cil_tree_log().
> This is repeated below.

Thanks, I will fix that.
Jim

>
> > +                                       goto exit;
> > +                               }
> >                                 steps =3D 0;
> > -                               limit *=3D 2;
> >                                 u1 =3D u2;
> >                         }
> >
> > @@ -1028,8 +1031,11 @@ static int __cil_verify_role(struct cil_tree_nod=
e *node)
> >                 }
> >
> >                 if (steps =3D=3D limit) {
> > +                       if (__builtin_smul_overflow(limit, 2, &limit)) =
{
> > +                               cil_log(CIL_ERR, "Overflow");
> > +                               goto exit;
> > +                       }
> >                         steps =3D 0;
> > -                       limit *=3D 2;
> >                         r1 =3D r2;
> >                 }
> >
> > @@ -1060,8 +1066,11 @@ static int __cil_verify_type(struct cil_tree_nod=
e *node)
> >                 }
> >
> >                 if (steps =3D=3D limit) {
> > +                       if (__builtin_smul_overflow(limit, 2, &limit)) =
{
> > +                               cil_log(CIL_ERR, "Overflow");
> > +                               goto exit;
> > +                       }
> >                         steps =3D 0;
> > -                       limit *=3D 2;
> >                         t1 =3D t2;
> >                 }
> >
> > @@ -2112,8 +2121,11 @@ static int __cil_verify_classperms(struct cil_li=
st *classperms,
> >         } else {
> >                 steps++;
> >                 if (steps > limit) {
> > +                       if (__builtin_umul_overflow(limit, 2, &limit)) =
{
> > +                               cil_log(CIL_ERR, "Overflow");
> > +                               goto exit;
> > +                       }
> >                         steps =3D 1;
> > -                       limit *=3D 2;
> >                         orig =3D cur;
> >                 }
> >         }
> > --
> > 2.54.0
> >
