Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E372F7EE1
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676691; cv=pass; b=l2ax9NkEuPbTGypQ55R7RU9HxvFD3kInDhR/aN+J76eTXI08Ac4FQ35pFH+SBIOfwDvqUwXPOMia10O3lM5PUIIdV9phaM25rZ4U/6fzc3DS3THls9pODIR0bgjQ6Mr2bLEwBQM/Xyb+NllWlRcFVzESrw94CSdC0uVAN/eM0hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676691; c=relaxed/simple;
	bh=JwEPZA4c1NxlzOxgfjvec0fhBx6LahwsLJhQVLv1/YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tL/NLTiC1drGIkmZ5VkVzeOEugArJD50obrJsGZBshqxY/Oq/OV90P/VXiJTj1dTK6EjFFfmsdMpz5xY1u5GivLFzJWqIgcmvaFhJjm1142U/pYzXJV8DMu2WgWZnRSl7pQJMJV39AfM3Jo+7ht16jo5wakLE0V1zOlprfH6KII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVfhvgNO; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVfhvgNO"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85d8615b09so1291973a12.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676687; cv=none;
        d=google.com; s=arc-20240605;
        b=j6mfWwtt0h7h5l1GJEVGgcyO1hDjfpP3ojPP2kmq07RSaj4qLlChMTX06HiXPLucYy
         c7cKboH/+KMvIBvB0FUTOOMn43onhIQyW3aczCK1d3H9H+FQnZ+wOt8ZjWyQZ58PLD7p
         mgsdxLRtohJtlV3cSr+pbAgrcSh8pv//3I0P8aQ1rt1Oax95zHG6UvFFZwPIIwHn5/V0
         +/By3J2vbdztiuDSKu3ReJUR4G9qvd9qo3rUC4NTczG2s+9F3WNb5hXVPpwqqTHN7sIh
         2CXY8fv74GP0woxwDt9gTyB7p0xjWDeyzXG+o1w7VRaRG74pJTEtfrmI/kIGzKO+MDNn
         LY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e/3ye6MSbpqoMUI5vq59CLdeNSeoW+lz8AJj7aWrgOo=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=gk/tkwf/xXg2ZA3MNAJBaAeGEuMxuk+/0/qtZrNECd2dp/xixarKuGJGoyo5mQ6/ol
         oUzWvlPAJD+1dB/0cq5Nko0051peWBK1+IVx34tKSLE/8TqI982uFD+XgQN1CG+9fSP2
         ekXu7mfEqfJECZ25eKPMRGNPRYsQKY9rRl4eG3uRn5hVyoOwaRqPJ8jg0ypdfeH25UEg
         RQ2/dJExdTZAvqx01tbYI21Ta4LH68FvfR7OqGLXuTZftSICxE5uZUXgrMGjhPvONBsb
         sWCgKtRGhthGrQGtf7HQTCKjN4zCsRUQHENF7I2M4nPIvoX2sUCotek5CChTwOO92V0m
         ihFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676687; x=1781281487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/3ye6MSbpqoMUI5vq59CLdeNSeoW+lz8AJj7aWrgOo=;
        b=SVfhvgNOEhC+pbJeR+DifeHWCI8T740otLk1dSz60QUTSGmMoRQmt07cgtz0Iv+9eO
         bK+RX62zDsn6VQrpZpF4rM5WV53A5gLHsqJwrHcLYFR4c8g6SarvCLGYuxihR44+V7iA
         S1m4YVG3zmCayRUTmkcd4/iHwUe95rCDhRBXuhFxTiFJax97yahv+28pef+kSProPwAY
         BVbI0afJP4uBDwrFvcEkiY0VsfZPLCSkLtXGMHJaxPCg1bcq+WXljwhOfvWbs6MWhdVw
         SdGUBO60GDyoQaf+GARxsLQpds0uRgACe7hFd7DZZrF3uz5sJJQrD8+4Dz37B8HEqgyV
         GxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676687; x=1781281487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e/3ye6MSbpqoMUI5vq59CLdeNSeoW+lz8AJj7aWrgOo=;
        b=i4uEKPgBwpcdweeTp06cK2y7htttPgoAA2NKHnM35/Y9eqyvmhyK+jODgof7QW0+Uo
         fuCyC3mqwCak7eknb3DeeZevwAS02drWyY5NNZr4iQHsfWHstH/z02UcroXV6tBfy1Km
         NFiy66eU575//mTwPNJZFNavOpZwZbfpfhUpglxfug7Nj39rRjrXKKOUyIEE5gpBG44m
         2eNKj6W7+aTXdxcnGL5zPp8eCiCY1fTGaDfscXkwJ1ZC4O1NjojEly/7woDTLTIfYWAP
         hlAui8JARY47B2K6ATay8RTyDfjr3Fvgo/goJpedrWEDIQkMqf2ggy1GZClxM67zMuwU
         NLpA==
X-Gm-Message-State: AOJu0YyNrt3TYo7l0RPpzxCnXC+zwyE2fm6Fgmr05D1nn967j9e1uhKW
	ZBDesSWWRWES1360HNBDOAUX1Bh8mPcTjKXYL47qLO4hQU+X7CPUjet7cIuapro/FMQvMFDn24S
	jM0JSc6BbzZNP8AQqBbYRxPBjwNJZ0Fk=
X-Gm-Gg: Acq92OHNt3L0ywWP83QhTCvArj59ZSCQOVh6vELZBHxcGvRGT56EPy679OvPwVUyBAI
	ZfwIkaqacGXgxRowYiai0oqmQr1PfShsETa8oKesDdUxQ7b6rSN5phWObB2b+AZAkKBgewTsoBJ
	+Ghw5XVUzqbKRWhVP8QNpU9vKDaCxnlRWk8wr3dUbfMQlv9MbeQnfXcoWBcXOtPlHJUH0WQPIDa
	bBKGQJ5aoa4fr8RFaEzMgwPMpjMcm3Vklwu2l/yFEP2IzUPPoqXikDDq4X8S5Z01+O3+qXD4EKH
	qmVwD+nyA7qkggCKoQ==
X-Received: by 2002:a05:6a21:a38b:b0:3b4:6f45:d8f1 with SMTP id
 adf61e73a8af0-3b4ccf8f97amr5179347637.26.1780676686798; Fri, 05 Jun 2026
 09:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604171837.263447-1-stephen.smalley.work@gmail.com> <CAP+JOzRDg-4nHbtkXY8mfCx_JcUiC=3a2oZ7AmwaY7nY48EdDg@mail.gmail.com>
In-Reply-To: <CAP+JOzRDg-4nHbtkXY8mfCx_JcUiC=3a2oZ7AmwaY7nY48EdDg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:24:34 -0400
X-Gm-Features: AVHnY4LHxIZAvGfuqnoRMu9n4I89Xas2yJFYD4xZe0Sx6vPww9IiRiMIKO3Dcck
Message-ID: <CAEjxPJ5XTQMHjWAf2+-2NodkxAgy3iOO5ZP1+L+fysEauKSTug@mail.gmail.com>
Subject: Re: [PATCH] libselinux: restorecon_xattr: clear dir_xattr_* after freeing
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:31=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jun 4, 2026 at 1:18=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > We need to clear dir_xattr_* after freeing to prevent potential UAF on
> > a subsequent call to selinux_restorecon_xattr().
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>
> > ---
> >  libselinux/src/selinux_restorecon.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 224a5a33..10807867 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -2021,17 +2021,17 @@ cleanup:
> >         (void)fts_close(fts);
> >         errno =3D rc;
> >
> > -       if (dir_xattr_list) {
> > -               /* Free any used memory */
> > -               current =3D dir_xattr_list;
> > -               while (current) {
> > -                       next =3D current->next;
> > -                       free(current->directory);
> > -                       free(current->digest);
> > -                       free(current);
> > -                       current =3D next;
> > -               }
> > +       /* Free any used memory */
> > +       current =3D dir_xattr_list;
> > +       while (current) {
> > +               next =3D current->next;
> > +               free(current->directory);
> > +               free(current->digest);
> > +               free(current);
> > +               current =3D next;
> >         }
> > +       dir_xattr_list =3D NULL;
> > +       dir_xattr_last =3D NULL;
> >         return -1;
> >  }
> >
> > --
> > 2.54.0
> >
