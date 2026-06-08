Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D1330B11
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934740; cv=pass; b=oiTreYZwEPMc/AK9+7/TYdqPcxWH6psEqFgxdVbuzJfscakASj7v8CyX7TVYHteHIe4igxTQGn8eChi3CSoYUYg5R891GEuDbu0+n5TGaBM7iZ/YGbgh6S8/TOS2zW7pYm17yrAoYjxZqob0FgEt2YAUFMLfeZ18aE2DFaN59WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934740; c=relaxed/simple;
	bh=xM7sjaKygo6qIaSripGng+7sG3cz4WdrELNkv8X+p4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAWMNmYLUtdSI9GnX/2wuXlvTTsJDsaDqJVaRaQv0WPio4HafO2I1kaNhpg/nsPYaNd0p7wU9zfIAu+C0YdBFg9WuJtYmhAFOUF02sDPfmGQsWUYWn5ZpGEnbQbu6O9hVOJUBqj4nR4xA1khRbPYxl/m/P6IdXA/Sce4ulJ1qTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOg7Wszn; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOg7Wszn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf1f074a12so47081205ad.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 09:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934738; cv=none;
        d=google.com; s=arc-20240605;
        b=EAHciRW3Z8lfHg+vmpxIo+wB3KvCBlJZNaBo/8qkrqWGNm7aE2Eo7/PJKhFBOLwygb
         HZNu1UGOaBeYbeBKtYPQ5FfyY4aeB5V+YL/NCfIKdZhEuZ4z6iiwxJ0SNlpy2AspMj//
         ZlWFPMxJ+Hdf/BArYriha4YBCPz8re8ycUUVg8exDecQVCpDnokc/327/aqMI00np0MZ
         88EIrDQcPDET+7kGLkUwuJtkHbyo2tlUSNky063bdvwctiQUIHqtfy6yskI9oHWcW5tI
         V/mCAxtPa6l5ABJ/J3mI0S9S1MdUTpmWfHvOvDgP+ZSedc0bgbeLnl9lrpdGor60Kobl
         GtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZF20Sn4g+K7UE+PThUTZCvaLR+LxLHST1UuI+5Ba6g=;
        fh=teCuqbtyRM4Tgu/qjn48lO8vG8x3Xo0e287DZw7JaQM=;
        b=YHFf6W3P4mk9jjm39/GDDIqKo6FsnQZKY8NC0VBIOe1hscWFCitDoinEKfKCFdibpd
         LBvjJ2ku6D7Fr+h8ml+v0pQzEP8XQstD2LA+pJqsA+pHA5QBYTshY1TNY2sAO4fM+vWS
         CuP4URiI8LRUG64lv1Mem9QsbSGSa2haAyfwxdpSLtcGiTHbDy1yGVPbcJVQ7FDrmWq7
         cSFcp4qt06iATQ2yfFudOlAhWTK3SW/l14GRO8p+Zl2Hrs0gUayXr9u+jPfWkrKW42jl
         ut//ZIfYosecPNndhBVBSFTiS/koUUtBOoipzSvTuwWFGrupbwOvwU6d7F6U00slZYDd
         NdTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780934738; x=1781539538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZF20Sn4g+K7UE+PThUTZCvaLR+LxLHST1UuI+5Ba6g=;
        b=FOg7Wszn8e7ll61N8kKOJ5heX9o8+A7pTaQ4OUn9uRo4pt8IZqBpbTeIGhhKSa4n63
         JMOeDtNdxU5vA2yk8Ed8qPy95kV4LgQTwJydK9IPSXtkHbnDiXxx10hqYOFb/pNF5NVe
         dXeYg2jpgbSEe4Bcx0+J5P5A4ag+rboAPKVpPrAnh2LIgrktZYgmnS1XrsPA7XFofdJN
         rghplQqVjB6h+ieKHTjudTANKuuoEIOBWRykq6mYK2/p/JzEtYYgTju5XhoUscSDWqZE
         k4JiM5NTuoSwg2jz6SA6x/121xMx9D7gKmt2r2kvwW+q2slbAr9SO6rff14F799JpC+3
         b29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934738; x=1781539538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZF20Sn4g+K7UE+PThUTZCvaLR+LxLHST1UuI+5Ba6g=;
        b=oj7TtnX4+ztJZP4w+axqQnwQVYa2vFap6LpsAl5pO/DfCd1CJ7xAN6cgHFS9r780Ka
         sT2MhkLl8SEgj9oa4FzD6Pi7tXyEYG4YG/HK5/RGKmk9mbWfrGcOtJwp3v3XlFTL+6Nu
         1iy6ZWQQODmX3iLvGDSVSsptcyWh9zzTQPJtxEZLHaIHF4Muv99yqecSC+knplg6tZr0
         olinZGkLvmSFferWDr7J1J0xc0dGyTH5ls0BX0+d6olYl6s3qFY3YwDvhNY+o82cxnYB
         XNcbqHtwOTP+VNR68epYyXbm4t5hrSsgoFYZKmX2ABfQIYjbEyUkX7ubNsZiIyA0Vo1f
         Em/A==
X-Gm-Message-State: AOJu0YyhraMmD6niWwJ3QRJuaqpPZ2PimgJupJBeHAAa5Ness7sh6ez2
	ouJ2O5oNTHLzPCATfWVbYuCNNWUzzoKdvsjBq8+azL19oTIKoyGdZb/LjBH5tla40O6nVYOPc1Z
	7rgPfAN05Wvbv5iRpe/jWJSmOs743lY6XZieV
X-Gm-Gg: Acq92OHIg0qnv13eGQjUfj5MFfwkQSjw4O2c1q5fkJjDPlC+Tt2aIm8vnRsVhqhiqC0
	t9+Gk/BgNCXHJiadnkTZZJZR3B13Pm1lpciDuVzvfAqvk+VTNx98FlYhosDtONPti24C0rLeKqd
	r/HqTEHFMepA4Dp/iYG/qLkBv/o6e+6/iI+1aLJJpqLL61J+N27dQ6faaT9Zw2xb7r/9bO8VuMu
	LvQZeCGBDOeYynk6i0n2tOn7WV9JAVRphpFAIUt40vWQ0Q+G1PApY8ZhR6ZYctp1P9ZaZf3JX7X
	l+ZFbugMqS6Fq+igXQ==
X-Received: by 2002:a17:903:1247:b0:2c0:b35d:ed54 with SMTP id
 d9443c01a7336-2c1e85e04c7mr183750845ad.35.1780934738413; Mon, 08 Jun 2026
 09:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605191355.281484-1-stephen.smalley.work@gmail.com> <CAEjxPJ63zyB8EYL0ngjrg=D-Sxd2NrWNkNzX4gnk6fa3v12-pQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ63zyB8EYL0ngjrg=D-Sxd2NrWNkNzX4gnk6fa3v12-pQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 8 Jun 2026 12:05:27 -0400
X-Gm-Features: AVVi8CegZFvIUI0imiRJHYJEOhuJyK4_bzWqDYpjLVgFneXxqvvGQ59giA5Y8Ik
Message-ID: <CAEjxPJ5ZzkgpaYSr-yVbYj1ZDommPC8UJh5XB84xo=3FtH-fMQ@mail.gmail.com>
Subject: Re: [PATCH] add test for fts_* availability
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, Pepper Gray <hello@peppergray.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:47=E2=80=AFAM Stephen Smalley
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
>
> I recall seeing some bug reports where -o /dev/null is not supported
> by some cross-compiler toolchains and therefore triggers errors on
> them.

Never mind on this comment - looks like that was fixed in ld long ago,
https://sourceware.org/bugzilla/show_bug.cgi?id=3D19526#c12

>
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
>
> I assume this was originally added here to ensure a successful make if
> run from libselinux/src or from libselinux rather than at top-level;
> is this not necessary here?
>
> >  override CFLAGS +=3D -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCR=
E_CFLAGS)
> >
> >  # check for strlcpy(3) availability
> > --
> > 2.54.0
> >
