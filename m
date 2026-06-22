Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515BD344D9F
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160346; cv=pass; b=kFlm6UyNmuT7sGjwhAd7rFVYjaMj0bSIs7/zdDWmcr97xhDEte37UwEsoXssfCTTK0FQF5g5RLz0NVY2JPuORV6Mp91SgvvzcLu0+YmFyJacDruMD/qu37s9tMhbKWAROeBlCxEj6JPpR1n/u66tZO9g6i2RxhQTpEHM4elOIB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160346; c=relaxed/simple;
	bh=0wgK12+SsgSSjLg/0fW5aQqS0x7RN/DAAN6KHaeNYJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWxXb2eXL+FizMf6qViM978LGfhpN9utAudJ4HIPnFu12pUViXeLgCT92n5FN0El8LHzfe9IbxhbRR82alJ3yqKdCJJXak40vdKO0HaCK8AuGLN0Dai/B5FBO+xZi8O497L6A3EbGcCq2zBXzJdgtGTc2Jgaiw/KJaYmpO+u/t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+jCsb0y; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+jCsb0y"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c88b59bfba7so2094083a12.1
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 13:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782160344; cv=none;
        d=google.com; s=arc-20240605;
        b=A8vVBmNkTgFunppAB5BbwRcOxGiNhF9MIVsi5lpNC9R5zOnCvJNWTnXk33ySGjKhTF
         nze10QnKKvu+/0UC5wM0ukanoIrwe2+PQTzxT9y+89DuITvhv4M+mp55zaS+HyjmiyWY
         EQxtJzu6MG14z5TKESdyOMsAgHWsaJKzHgj2fjYHr6zxY+XJsxa5/DJiEX09eaB7nA00
         +L/aCPiSlednk8iEF1ARcQlZAr2fkdngAdOIR1T0F1bfJkOW31UlfO14SAJcBiBMTOmX
         Vggk5ze0hKOXx/GUWStnlTGPdGeAnlnCVZpHFqHXjf4acXKV28hj5X5m6rD4Jk7W92Nt
         YCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=spwChoyUs1nzZmEDJFGxWfTFWBLmtlAOX3hdbGhhZH4=;
        fh=jRyevUK2w2AHXbqDg68JL/TGkgAfqiBixLBAah9ARNM=;
        b=OG2HC0RTDu5QW+9heggS+FGM+iwSkEsGUUmq1zAKQDOTe9CbDIVSZJ0n+q2OZcUNqo
         OXafV1Cq2pYdhifTWj2ys1pEmzI49hHqd1sYXDsWF27+kxjlA8DamCvi04H5wTAYduOw
         ppu4fbGgmbCZCW49NxpvvmHZV/pq8N5mgW0GS90lq/CEtEO8+lA57b++5g0T4bXyhB7i
         JyJckeDqUq50VeoeUzCtatJixmk4ZdT4Q0FKhKv4JNA8QfNqSTdy8TlrrTJXZNBxTQau
         ONejf2cSIBXJD/I7eh4qkDQpSNDvq2K6sBdAL2dxKyQyZ+xEXUTf25x6TWBwCGneupsF
         xwfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782160344; x=1782765144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spwChoyUs1nzZmEDJFGxWfTFWBLmtlAOX3hdbGhhZH4=;
        b=q+jCsb0ypyCfKMzN/M2UMeDRfDkouDjKLn6e4abwQK0jDQVh+PYlaaPaZtXz3IsEU2
         RVt0bXLX5tJUA+NwSAjHdRFeqdPmC5Tp/Ad+WwrbOFpiE0N8vFQK3Ag7Zw8CH6iLQN98
         VFYUioSShL0BvYboQhBEkKN6hGeVHM45XW6oYKk7osJspHTFiQkP1N5ZShxnBuyzjCgY
         7bzfn/qeS7J2w0dfcl4vpmEY0P3bbOiHoE2c4fS2VmOGriaY7s+HIPv0+MHtfxIZlxck
         RzPDWZcnVzI9VrgDnDI4bp07CEJ/+iXrIhekOGF8bXCuz81i+sAjb1XUeoFjAoFXHuX9
         6oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782160344; x=1782765144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=spwChoyUs1nzZmEDJFGxWfTFWBLmtlAOX3hdbGhhZH4=;
        b=K6HopAYK+rBIUyqkQeW/+2K4tRRHvHHanEw3c5oA1hr3BwT2bBA/bvnQLBmZ05akAZ
         oXO4FRYYW+B6yKEK5qF+pQtpVZwvaWc2aPhiCPo4wusBGA1UA4lrbqbVH38K2EfDD9Ns
         eR4/AuNKaX0os0e85YHMZyGkC5Ayqc0fgFKGUEU8FbgfT0hjyFt4e6YAXPn27Ar2FT0W
         ZGS5+MgglUFutGocosqJ+oGQS241RLTvxj5QgAyrPbAS2Em4MbuPLcxtxoqXksLSkmYN
         pFGg0KpAyzMzqrI6ALsSzM5aVRpxENm8OfdIaYt7aZzzEWAvsnt6+T9HvSau1/UDYJJE
         x/Vw==
X-Gm-Message-State: AOJu0YxX2gR5lbZ+l4iMccZpq29UKBpKJwoGNHhbHFcyHlogrjtj8V97
	vOU7sc3azBEtpGUIVft7Yqv747k/jeGrEQbimMwoY8guC+HEh3Q0PzSbKQr10vddlEHjW68Z46Z
	GIGFfdD1L+uCUNs2QFkKEPrIVav2cZUQ=
X-Gm-Gg: AfdE7clh07S4A2boaQRwyCxi4y8lhnOdsst4ovuMHI1LvhFQUMZpFKpPAhRhEdoRBBc
	5mrP3QQ8+yC000xApvbcC5xIdnn2+GQSbd2DwXXfi8NX/LWdD1GQFZMP0uvrjF6yySsC6H3ZtW6
	PktzQU3wzCl8a2zzH375QVX5qf6GOCmEx0w6Gw1zOUgY8mG9oULyzkGst+xYPICdnk9hyk3RLAl
	en0hHTH6ndDNBrwVAuY7lppaGZTF5PB4dHeHa00kk8OAHxVNt8H4P+bks0esAo6yTQDzvsl
X-Received: by 2002:a05:6a21:1493:b0:3a3:a9c4:3d60 with SMTP id
 adf61e73a8af0-3bb34863d25mr17355185637.27.1782160344425; Mon, 22 Jun 2026
 13:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622124222.31518-1-stephen.smalley.work@gmail.com> <CAP+JOzRVpQib920=h9Yf=nwLRrsW-rQ4HkERKNVUrVJ5qGvtRA@mail.gmail.com>
In-Reply-To: <CAP+JOzRVpQib920=h9Yf=nwLRrsW-rQ4HkERKNVUrVJ5qGvtRA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 16:32:12 -0400
X-Gm-Features: AVVi8CcSQvaOMErkhsvE8NB-2Zw81Ga5EZcnh-QRfFjmQHhZ17FQJBd0DrdXMFY
Message-ID: <CAEjxPJ4RexbrdMJou=++CvbCrprSN7qcN=9KvVOGR7TP-gSFbA@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: fix out-of-bounds read in parse_raw sensitivity parsing
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:44=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jun 22, 2026 at 8:42=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: netliomax25-code <netliomax25@gmail.com>
> >
> > parse_raw() advanced the cursor with raw +=3D numdigits(sens) + 1 after
> > sscanf(raw, "s%u", &sens), assuming the consumed length equals the digi=
t
> > count of the parsed value. sscanf %u accepts a leading minus, so a leve=
l
> > like "s-1" stores UINT_MAX and numdigits() returns 10 while only two
> > characters were read; raw jumps 11 bytes past a 4-byte buffer and the
> > following *raw =3D=3D ':' test reads out of bounds. The range reaches
> > parse_raw from trans_context()/untrans_context() -> extract_range() ->
> > compute_trans_from_raw() for any context sent to the mcstransd socket;
> > trans_context splits the range on its first dash, so a high level such
> > as "s0-s-1" arrives here as "s-1". parse_category() uses the same
> > numdigits-based advance at two sites, shielded today only by the
> > MAX_CATS checks. Use sscanf %n to advance by the characters actually
> > consumed at all three sites and drop numdigits().
> >
> > Fixes: https://github.com/SELinuxProject/selinux/pull/533
> > Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>
> > ---
> >  mcstrans/src/mcstrans.c | 23 +++++++++--------------
> >  1 file changed, 9 insertions(+), 14 deletions(-)
> >
> > diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> > index c494e76e..b5c8d54a 100644
> > --- a/mcstrans/src/mcstrans.c
> > +++ b/mcstrans/src/mcstrans.c
> > @@ -173,41 +173,35 @@ err:
> >         return -1;
> >  }
> >
> > -static int numdigits(unsigned int n)
> > -{
> > -       int count =3D 1;
> > -       while ((n =3D n / 10))
> > -               count++;
> > -       return count;
> > -}
> > -
> >  static int parse_category(ebitmap_t *e, const char *raw, bool allowinv=
erse,
> >                           bool fromconfig)
> >  {
> >         int inverse =3D 0;
> >         unsigned int low, high;
> >         while (*raw) {
> > +               int n =3D 0;
> >                 if (allowinverse && *raw =3D=3D '~') {
> >                         inverse =3D !inverse;
> >                         raw++;
> >                         continue;
> >                 }
> > -               if (sscanf(raw, "c%u", &low) !=3D 1)
> > +               if (sscanf(raw, "c%u%n", &low, &n) !=3D 1)
> >                         return -1;
> >                 if (low >=3D MAX_CATS)
> >                         return -1;
> >                 if (!fromconfig && low >=3D maxbit)
> >                         return -1;
> > -               raw +=3D numdigits(low) + 1;
> > +               raw +=3D n;
> >                 if (*raw =3D=3D '.') {
> >                         raw++;
> > -                       if (sscanf(raw, "c%u", &high) !=3D 1)
> > +                       n =3D 0;
> > +                       if (sscanf(raw, "c%u%n", &high, &n) !=3D 1)
> >                                 return -1;
> >                         if (high >=3D MAX_CATS)
> >                                 return -1;
> >                         if (!fromconfig && high >=3D maxbit)
> >                                 return -1;
> > -                       raw +=3D numdigits(high) + 1;
> > +                       raw +=3D n;
> >                 } else {
> >                         high =3D low;
> >                 }
> > @@ -242,11 +236,12 @@ static int parse_ebitmap(ebitmap_t *e, ebitmap_t =
*def, const char *raw)
> >  static mls_level_t *parse_raw(const char *raw, bool fromconfig)
> >  {
> >         mls_level_t *mls =3D calloc(1, sizeof(mls_level_t));
> > +       int n =3D 0;
> >         if (!mls)
> >                 return NULL;
> > -       if (sscanf(raw, "s%u", &mls->sens) !=3D 1)
> > +       if (sscanf(raw, "s%u%n", &mls->sens, &n) !=3D 1)
> >                 goto err;
> > -       raw +=3D numdigits(mls->sens) + 1;
> > +       raw +=3D n;
> >         if (*raw =3D=3D ':') {
> >                 raw++;
> >                 if (parse_category(&mls->cat, raw, false, fromconfig) <=
 0)
> > --
> > 2.54.0
> >
