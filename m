Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C041325E
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103269; cv=pass; b=PZGoltm3xjlHJu+XNYn4R/rsemC7jGE6g5InsDbqdVsLac+D/i373WoPlNjKA0s/FAr9Z+a2R4vL8Wj5zF2LElp3H3cG/XRBrfQFr9PsWH8upEkK3X+xVOyUbVPzSRiMeB7013zRaBpxfttMCUkaj/n3YRg0ykgffxKIqvkxTiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103269; c=relaxed/simple;
	bh=TwryIgLXpx+Ie2dBBTsr8dp25+b1gnHtHG0J/JA3064=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+1ppAbZYsdDqGtjOjmuH/kq30w/bGpQOxBuuHqpMqajPqtX0hOedbq5jM1NYyuBSniYAwGFmRCc8MAx51VocxpszvHb+NJmoZ1r6+Xz0We4VdWGC4gurrEOwT4CUNsHcqVWZI/nq4ZmHD5ur9dNszrXrc+jQwuKbmhQkwT/anU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCfanxvZ; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCfanxvZ"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39677245e15so65163161fa.1
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 07:54:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781103266; cv=none;
        d=google.com; s=arc-20240605;
        b=c53n1IrD5dSrMVWBoi47SMdoIDpRbt7bLqmIS2tVICg+tG8pRrav/XAEGoayoWoV0m
         kPfxMIoi+xVqHg9Y2DI8IfVlojywe/ZpD++v1l92BZ6CVBMfaBGXhrIVTuM3BhQKcWp2
         qVbwuyfLkYGGes9oU1MtnZt85UT60zkztg6FOpzb5XiO9cLEhN2WK/GorMPxSNaOO4nv
         23d8ACT1OIGYY3idf8BJu4yPy6uXatQy3tcblFKMpECjXOkTp/+Xm42AU7v7o2wcL6Ih
         Rhd/GQfJymkrp69liKMfweBMFGLNfcvubMGYvhCwYUmVg+9jC7tFMk85CdXbi4CZ8OmV
         zk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aWJlIEHY9iuRg9RB75dUcopRAmZt8QovnM7eR2F0emo=;
        fh=DRN1TIR+TVwLqT23/erRGE6uikUQCqHkxvZie5yZYxg=;
        b=K+Dtaq1VSdY4NdXkIc5Yc6WMsXfjpCxTupSTFn4ns9yCay2d4xr46dcjLqxflARCAH
         p/YuUtbHGCNK1l7UP2NQ0TTbuv4IWdCCX2VG/BkWNvFIKfLrpU8ZPeTwrKuxeFv3+knb
         /Zq0goSMYzzBGTGOsHPRC+69Pt7xTxBUCpX3rGHur8HIkUjiCmAp9p5y0up93pJQiZwD
         Z6mnwzoEMda0wMLIKuDyn64FIYys9oL3AELQ4i6WUoDIqwt9DcZ9+UUP1Rf3CI8pvrZQ
         f14T/OLm9W7dZj/k7hOJ/KmbwJavW7e8YfqpSwo07vXV97ITWzWSVgXrFZLBtQNAt6df
         Uy+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781103266; x=1781708066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWJlIEHY9iuRg9RB75dUcopRAmZt8QovnM7eR2F0emo=;
        b=UCfanxvZLzjTHa+9OY37e29OhZ3Y3qA8prWAY8QwLG77C7/Mbv19zaBXfwAmdi6Cp6
         h4HKYFKGx26l8vx6hsN9VoefWZzZoUqskcwy+bb8fmMES8pyR+SSvXCo6THPNeIPE89C
         lyeWDG/P3k/L2/04S4SCKhXstEFVYflMya3XE2aGB+SeJ5yiYcdYHad0xzfqy4DEokyh
         XaBc8NiKncuta/oMTf1mMJDA4w2Nh81wvC9ZDg4XLBQvBthwRivqHCfh2UdXNe/NtHB9
         zl3hoCBn1X/z7q4yROykXHeAB1owvTCkfHrm1CXRqOPBf6P3rtIZ31b4UcoTKWA3YkEF
         1Onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781103266; x=1781708066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWJlIEHY9iuRg9RB75dUcopRAmZt8QovnM7eR2F0emo=;
        b=KqmNuROTIQJWP6BeXbDH4tAyhjyL/3nzMTxo0n9dt/5qR6rx9JbKX811Yvh1t8yI15
         z25Pn2dsLd7y1U+F350jcxyNIK1eZIIrGpD8Zoeus93cBMJAnE/hHJYfAgeO3axTBJMR
         tiGF/aUrW45Aq17dFPmlDnArduLPdIS73VPhgUtyy+P3xst0ASwwVZ+U7U2yyZRqbw9j
         StUE31xg0QaGj1tjsGsn7jVNlQVEti6Z6qQ5+EOaGGwG5XSsUmWplYvrNuQuaH40BEqo
         R6ldO2tvjHuI14nZoo/cse3jEoFqUlFNDLrJBimLKAcHsjdl8tqUEA+I+41VCyKc+6P6
         865Q==
X-Gm-Message-State: AOJu0Yz/mpLTW2MaM0H/BrXFg3Athbu2oLHPPY5OkvE9qG3pD8TISFI4
	JEwQQ2M3nPFkY9F0xgBJTwWZYS/S7MaCj+QjrGFdE80YFtU6YeCb6QNoUJxNECEg11qa+INKKxK
	+sThj7KmbHLfm4T8a22dX5Z7y3lXSy74=
X-Gm-Gg: Acq92OG2r/XQO64bOclGTomgJrbjmZU2IMKVWLpkqbHtRe2zm2Fiw5uGP87aYS+s1aC
	EuznUH91bQEnhS5yshduCoR3kGvTz8tLKpnIDUTOnQfI5gvgatfqU6bDNe7iS2fpBjcIhkNLRv7
	t7SxTudrMMeT21LSGjPpJOQ19EtFCCOeJSAGRrPNfPQJz01swwkd213km4SvrdPYS5L71Shr1YB
	P3pr/sa8AF0UdK+EVj2vTLqiU0lb9cOJHW9s3twd9VLLs1XsU16fL8D2si1rrlhHC/BFmn875+b
	OUzHL9jt1IOivfs=
X-Received: by 2002:a05:651c:b21:b0:38e:2de3:f8ad with SMTP id
 38308e7fff4ca-396d07beeb8mr72020271fa.4.1781103265656; Wed, 10 Jun 2026
 07:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605191355.281484-1-stephen.smalley.work@gmail.com> <CAEjxPJ4k-3a3QfruDYnE8dO9srD9qVf_OM0X_RyojyzMaWadSQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4k-3a3QfruDYnE8dO9srD9qVf_OM0X_RyojyzMaWadSQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 10 Jun 2026 10:54:13 -0400
X-Gm-Features: AVVi8CeWAT2-kHk_jyrDc5NRT1ofXONUMbSltAgjpcZ_O4JuQB1q5Nm06PPS03I
Message-ID: <CAP+JOzRQ3EdNV2jULyq-kLdmJrATfKtYCfcb_pW2hwWH-Q0Jzw@mail.gmail.com>
Subject: Re: [PATCH] add test for fts_* availability
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, Pepper Gray <hello@peppergray.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 3:00=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 5, 2026 at 3:14=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: Pepper Gray <hello@peppergray.xyz>
> >
> > check if fts libs are-builtin (glibc) or add -flts
> > to use standalone fts (musl)
> >
> > fix: #514
> > Fixes: https://github.com/SELinuxProject/selinux/pull/515
> > Signed-off-by: Pepper Gray <hello@peppergray.xyz>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  Makefile                | 6 ++++++
> >  libselinux/src/Makefile | 3 ---
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 0e70f3d4..0e465f94 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -27,6 +27,12 @@ else
> >                 -fno-common
> >  endif
> >
> > +# check for fts_* availability
> > +H :=3D \#
> > +ifneq (yes,$(shell printf '${H}include <fts.h>\nint main(void){return =
fts_close(0);}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=3Dimplicit=
-function-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> > +export FTS_LDLIBS :=3D -lfts
> > +endif
> > +
> >  ifneq ($(DESTDIR),)
> >         LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> >         LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index c0e18321..9982faad 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -99,9 +99,6 @@ override LDFLAGS +=3D -L/opt/local/lib -undefined dyn=
amic_lookup
> >  LD_SONAME_FLAGS=3D-install_name,$(LIBSO)
> >  endif
> >
> > -# override with -lfts when building on Musl libc to use fts-standalone
> > -FTS_LDLIBS ?=3D
> > -
> >  override CFLAGS +=3D -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCR=
E_CFLAGS)
> >
> >  # check for strlcpy(3) availability
> > --
> > 2.54.0
> >
