Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BA324B22
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528813; cv=pass; b=SKlZziO9G3NhkYDXChPE2LKwv5I50ReuNC3tkHUY34VLf/WzIML7tOnVSFtn+WioQtP/rJtI1Bfw9NyzunwT5SV2qh+TO0dRX/B+gbbq5f6SOT9VCmvRrwS3YGWIDJo4t/UGIAE/HQx06/dKBc6qUfHq6WFqLqOqoPlyQGOV7vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528813; c=relaxed/simple;
	bh=FBbepYATYWpEGSNNZnriLrCT16jPitRNU2On4CTNEf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdoqYJn2V2+z6z75DFZZ4iJHpakezuxs6kcaS+gNQjJi00tSfLsiOSPq1gw2ORiIeiVbbkEI8VU7X7fxd8zVTYQVBsMT+8HpLFaBJfZZjoeBIMV5+TZl+rAjEHX76zilmhYvFP4UY3kqp7fZRCAvbs1CaqoyF6rgQ0wehpLpzQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYti29Ff; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYti29Ff"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43b7e186a0cso537184fac.0
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 06:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788528811; cv=none;
        d=google.com; s=arc-20260327;
        b=Eo3t/eof/rHe0wFZPPVVCrf1AhKzozzLyiTWmh8OXk7rkpuVMv1vLgVChAlmm2mRoJ
         XEMwQDQ5h7s0Mirz7kguZXpFvD3JErDyb1+HxaahRQM2hHFaJoH/a2/bIFnxb6NYuQkb
         dCXIHG9QF0Sru2bkJbde8dlzKotOjednQrAR0afwdHordiErf45jBIjQynBn/BjXJCmH
         mPQslkY6796OhQ5eJE+jyNEUz6f24v9seF7lkHowfaaDHZDPhNUJw0eJKvUFk93s/7MD
         LltChmXwWT6HrZox1yo59LoL1gQ0E/x1UfQGppHrPHk76MSn9RWbzFSeieSmNLouCg/X
         QGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jgBKg+yCKx/y1gQ4sA6E9GXrsA+pSTsQIMnFEB6HbmU=;
        fh=4HNm7X278YR8zaPFoLc1rblFsq8AjOmWOhdz/GsW+5Q=;
        b=d/L75GgdqiQkRpnm3Y5/5le8eHcKuo/oqKUOHWe3Ap9v/+3rbN3zNx44BEtCneuuh8
         9iNUGAnG0c6tDK+VnATl3beH+kR/h3sVwVSPn3i//92U5UTnLS5kC9udb0k0xw80PSRH
         MJSN9WKiMCrfXOpz7TKOVuLmEhS6GANkNR9v8f3RjuXYGJfdww5bzsHsVRXfHPTIPnjc
         wEqRQ7Kab32S6s4nW2zGHVuY5LzWhAEy2hrzQ5+hojq0EpQPTgiTgcOMt05EDlbPiD4f
         EHO+WsiRLU/LDkK7PwZFOBoxR2K7/DfGXUSc4Xfm053w/QEtLXU+YOHv9uw5u0znDPQc
         MQ7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788528811; x=1789133611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jgBKg+yCKx/y1gQ4sA6E9GXrsA+pSTsQIMnFEB6HbmU=;
        b=eYti29FfJWKV/oHPGgwVjSGh40C1Xh6tP02WgZtH7xKu6HckEvunhp4wyPHOWGKhQo
         biuy+1FkMMsiJ5TjqMFIk13fXRCp+aJQn6944740Myp07C2uEKa3ImOH0KCMtvmnbKSz
         fEaZeYeO7u6mBcFlMCkV/DL9fk9QLxf9KikndBD0BRr+4H8OeM3MGzc8vJTutRkulgxE
         s2+uWmIWqXvHX2xsR+fOe++stGv2KnJad57QzPF0I7P3+zxCuAOJjOrICJPp0LDLa9ws
         0JYMnSNJZJQsK2JdtxOzDGdcxPWc8cvUtNuh0J4ySEX8kpASERfkSoNGemxM4bV6Afcy
         hW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788528811; x=1789133611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jgBKg+yCKx/y1gQ4sA6E9GXrsA+pSTsQIMnFEB6HbmU=;
        b=R2BbJ2Kyd13Yx1cZ41QR8gS0HAmAtNDcbsZLczEZbYacn7ntfUoD5j5j/W5jktVbqz
         FNQ1R+s+7u2uJsBSb93gS2PpTxeVqGvrCBrosQwrV3x3LhpLZ0juPeadhDm+tuevCROp
         oP6PD4d8mqYudqw9WuIw6WLBWCjwgjhxxMPy9oglHgodE7bPncTf9QPj4R2BZVgNlpqL
         Yf7DmtWNbzrTYnhXDk2UqWeyEa1WVKTsNrCCi+EOm3ZfLDPdcPSfiAp/S7AY1lQeZ2Gq
         VpTIPfto769HhADRyMAl0LBdqBanby9LYRaHdONkm3XJ/BB9VL3v7ZDuv+/gOHzTFS83
         iJ6g==
X-Forwarded-Encrypted: i=1; AKwUvBzr44+nYObbwngSGkTzvkpeesUGF4vgpI5SC3rvW1dqgCmjfLknXhHW5/mAvkgFNuQ0a6teegmR@vger.kernel.org
X-Gm-Message-State: AFuF++nFC6suufnPJywd/0MTcMCcR2zI4tqK/QBEJoeYrGjUbtrVQqlQ
	mdDEoF/tUxDA7yJW0nzulKVttZ2urmrpWwECOQ/5o8sRhUS1O4qXhTZ4dSnxscUPeavGGXIF0lQ
	NxnK+xhy+PtVhSH0zN9Oln6Pqd6Mti84=
X-Gm-Gg: AYBFou1VqeLg3jfmhz3H7lM17/igLtELRFFixp6EQvKVz64jt5RnxFyIqLqaK2ecCGe
	HAiMqRt0LJpAxD3W7DbIEoJ4unYBYX6Sw8jeGHpFxz7Dol3GxtAxjPjLk59URLGpAjY+P8tDU5c
	P5mrqZTVJE9XNlQFp6HlpjXJzOUzz36O9uVjunum5pLu+vpwsEkzgUol5N/GCoYFPnDp99BEvof
	IT3OXC3BfMSWfbFX9a/2TMq7CIlPXaVQCvATMokq0H+D5Y6dCvIwWUyX7YP/Pmm5gs9cE3Qzj9S
	2fpvyjVea6o66um37+ZeTXtm2ptqQ/IpVku2qlrMyB6qOBhqySEvlau3
X-Received: by 2002:a05:6870:c204:b0:448:aaaa:6b93 with SMTP id
 586e51a60fabf-47551d53f9dmr4587669fac.17.1788528810890; Fri, 04 Sep 2026
 06:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903155837.516393-1-omosnacek@gmail.com> <87ik4l18wm.fsf@redhat.com>
In-Reply-To: <87ik4l18wm.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 09:33:19 -0400
X-Gm-Features: AcwNN1W0a6EPJVfRfOsZMXRSR_bi2FmICQfSgka8R343nIfIyR22mIbm1lO44zs
Message-ID: <CAEjxPJ5Rtvp8MOuaxUPduJ6Mi6NEW1OzOdyxTtBx_tfr-gwN3w@mail.gmail.com>
Subject: Re: [PATCH userspace] SECURITY.md: update Ondrej's email address and
 add GPG fingerprint
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 9:15=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com> writes:
>
> > I'm going to use my personal email for upstream contributions from now
> > on. Update SECURITY.md to reflect this.
> >
> > Also add my GPG fingerpint. The key is not yet signed by other patries,
> > but I've been using it to sign my git commits for a while now. It can b=
e
> > also found at:
> > * https://github.com/WOnder93.gpg
> > * https://gitlab.com/omos.gpg
> > * https://keyserver.ubuntu.com/pks/lookup?search=3DCEEE4E9CF1676119&fin=
gerprint=3Don&op=3Dindex
> >
> > Link: https://lore.kernel.org/selinux/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz=
7VYpK8KuseMQS-9tNA@mail.gmail.com/
> > Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> > ---
> >  SECURITY.md | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/SECURITY.md b/SECURITY.md
> > index 52ab863c..1f255c81 100644
> > --- a/SECURITY.md
> > +++ b/SECURITY.md
> > @@ -40,7 +40,8 @@ window.
> >    *  (GPG fingerprint) 578C 4211 832F 0A7E A2C5  A7C2 21A4 6E60 3F74 4=
ECF
> >  * Jason Zaman, perfinion@gentoo.org
> >    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0=
EAF
> > -* Ondrej Mosnacek, omosnace@redhat.com
> > +* Ondrej Mosn=C3=A1=C4=8Dek, omosnacek@gmail.com
> > +  *  (GPG fingerprint) 9F17 354B 2928 339C 5130  906D CEEE 4E9C F167 6=
119
> >
>
> I hereby verify that this is Ondrej's key
>
> Petr Lautrbach
> -----BEGIN PGP SIGNATURE-----
>
> iQIzBAEBCgAdFiEEcgDrLD9eSIRjwM6ezcroySfGvjEFAmqavYQACgkQzcroySfG
> vjG7tg/+KTaC0uj3MQz4henqElcCjNsuhPhmQ/8mVGyzRGvCr3UaH1OBazvmM7Fb
> 88vaDkV3A95ZLYZRk7X/aANlYB44f4I1ncIew9H+bOISaehCTO86xQXs0z8qNSol
> 2bduHbDT22wWDvgxqhGnc9UEd7dPwLvf/jQ3lLabavfslK+G0PKxSaoBVX8Yz1ZH
> /J1z5AxnIGIl5UQpYoIzXsmwK/fIcvGZ8q0+XPLEi7pz9fzpS+QE8Jp04U/QSdKo
> 1TN9RtsLgCXIvlcXbEZjpBLBxI3lW1bLnq2tJlfj5YtT7RnI4TSzwaZ8HC5TsDU/
> qhUEXzMAUmKcOvfvZJ8b6w/ehbN3BkcDyUDtdMEZXLyzZjNoJttOa0FoW9nfwoeU
> wnLS7hTVdNnkVui1VWuq9GWtqhbgp6+KDYtBbE7GHzzvycMBJOIZakgwaOsc7pvQ
> +vddPu75XwnzyJmC3/kEnGUsOyHyPfwJZ4/+Etos48KZHOE/2I6skmoRXhGasAe/
> 9NTL1vM5eKWhZWZV2QMAgkgoB7oulPC+EZXKiBrE13uTACibUCKO/ZC1+XLlIIDE
> kvUQEgfhct2WTunr/DBquqU/4AojIsNZdOa3SVAez+viFWf29v40edtKGVRUTZG9
> dx0J1hK5KP92kErl4am8G088DHAnU5jeXbtrB8gGTmmhRqXxTIs=3D
> =3D/OCL
> -----END PGP SIGNATURE-----

Thanks, for reference, something mangled the email which prevented
directly verifying your signature - AI helped me by suggesting this:
python3 -c "import quopri, sys;
sys.stdout.buffer.write(quopri.decodestring(sys.stdin.buffer.read()))"
< email.txt | gpg --verify

So with that done,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
