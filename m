Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014EC427A0C
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771809; cv=pass; b=QczvaFocTZMAY9DZfbb2F1Hrhy0KzV+7xuK9FE4CQ2KmOtZB509FCXR5W4K1hNY3lybDyFkddTOkSfn+qsEDjocEbI8azCfmnDyv9LA171EDM8F+7ui1k/4lNp/F8DOmyDtiinInXBkAHHc6v2gIigLElloIw4fTBYbfcfvOnuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771809; c=relaxed/simple;
	bh=8doZO+0nt23jZ6QDkJEXWpnmU8sPl/83uSFIjNkrFUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taq7YgouWzILddB8RUMJAKkF5Xpusf0D2MsRObC441BGzkqVGxqgupEH3vk34X5b1p6xCAEgsdFaL9Pez6KEKgjOOYNMO/geIG+Dqsj8QxNA+m+Jcav7CmkH44BA8ANz4N6ZvCPFea4nc+CgyWw1iVQFotvd9MfRJFUBEMSmSwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihPlAzDA; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihPlAzDA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bab2548e8bso38254955ad.0
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 08:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778771807; cv=none;
        d=google.com; s=arc-20240605;
        b=EoB/UYOjW5vLisit1WB+f1+jzd/l+g0svcmVOoiM1KoYHBlFkKKxwQ4w4HWi2+6Os0
         CK8m1EuAmuFEY/36ZKiWB26ZvEoI1O5pIj8nEoBJger10wxZH5pkU7mHZinuf3VCD5e3
         gCugBoW6UaNW9smB9zPVq1BIf6nUcBAl10lJ/346KoiD0fFR9vRH2v45wSakTn+DUdKZ
         GCtpCqgqlXZLtAZq7kWcu/fQet9op6Xe+gXr8r/P0pzw5Vq6N1WO+8ftxYf51mzsL7c3
         yR4yHjEdlZHlxkYEpqht76vReWxYtNOHuHgCU6wiTZHIrygGa5VpVnMxs22JD2CJWOnR
         fqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=304Vt0NTOeesUyHIPy7nA4Lu9tVGP8wckEEPJu3mKro=;
        fh=DvWZAzU82LH97j+nbEPl3ocxBkwLJhNecMFIXx6OQf0=;
        b=Gj/GcNMp2Z32PrBON58mTCBgreO3bnREreT0IZr6XJSEw5v07eVCOJlSKgTqCZwobY
         IBDN+W003oXPzQeFTTPh+JdIA+Geuumoo0YD897TU5BRPo0nVWM8JzoyIfg+XW58X+fQ
         iLfkBEwCUWFNtBtnnPgSlkEJXuI20Cul1MHV9JpR5toZEtZiM3QQi4tfjSZFZcukRIQ/
         D4hjOkRSjnkKChRSAlBJf8KG4jwsD+x/Yn8aYY4ks7AodYQwsZlVL1vIiXArqXQRsONB
         dvsE4i1X4HaHUoQTBrn4va0IVwOhRkM7bmwv8JX0A5zhHPK4318i77xhn3zC0ioFZCag
         LpJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778771807; x=1779376607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=304Vt0NTOeesUyHIPy7nA4Lu9tVGP8wckEEPJu3mKro=;
        b=ihPlAzDAFZX9BfIY6yz00VF5ar3uSvKRO5HMHB/MCLsXwP+jdbYvgzEqwldkTYTZd3
         9J/XrgoifgkMYXvrSLpNzpRM0FL7Kn25wwsOASWVh6qlQwSE38LGs/4Uis6egDH52/AW
         oPOzQGZG7eiyZiOLNN4zIyyLRGzbG4qlyMvC78g5e37EMJE7hIHp4lYACkjjdPF+3d4/
         CXT/9qQ8vJWBR62v0IdLB8G4RDXAzA+U7uS3oveKBBTviolUJ+vUv3abyzZosstfzn16
         ZrbxmoMCISi9syxLnRcP4f0rDDOrTy8oTXf0o12T5hq29a2WRtL+rA82xFutzKeguWRo
         GnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778771807; x=1779376607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=304Vt0NTOeesUyHIPy7nA4Lu9tVGP8wckEEPJu3mKro=;
        b=mRNSP26iTqalhuh31kjkXgbSOn4xX/AVS5yWPRrtCYfXBf8XXPBlXVl46nhRlipkVZ
         Ilrk9e7nkfkO4/R9iw4Bo0OMZnOM/HWrvHrooaD6YfUygJH8rAasfBcKysrcdw291zDf
         GGlrowijOzzTJiNLshRsnx6KDZQb1WscQQXLbrwhngF62e/Kog8hbe1iXmzuYTFaSynK
         LDX4qs31s1SqoHW/S3X+aIT1OnaG/c1WjxZlLAbAgNJi7evkeA03RYPCvpiqm5gDjS3u
         WYn3Lh96EUcr23NLXYeJA3hb2ND/b+NGofZWRyyw7IXNTFW1UR2MvNjceMF4q0KGiZ4O
         XV9g==
X-Gm-Message-State: AOJu0Yy/ZzbMtNtY6A6BKaCKsSt672S5s2GR/j2sPHB4Rj1wUye/5Swd
	WBPAMD0uoyeX4KIosiK8S7MF7WTC3bXnwjkNk9tOhrL9MHItHf7/ZUBt/VziXOT9A07lkrca4dc
	KcZWZXzFmLgYywdh4B2d8Sf2vahs2oLo=
X-Gm-Gg: Acq92OE7w4vs/Dwhw6ay7UpPiMAAkDTAXpC0gRCUoTYL/8PK+Xw5IAiV+YqNw15W0WN
	+3gI17QTJHkkxB0iJ4ESa863NIfKIIS07VQ8efBeNXLf49MMtOE67qaTzbu4BQ/9XUg6PyVzV2g
	jwtVzDc+cB/pMTPVrnLbqst1oLhznq0kvcaSCzeE8uKjDOwWhFIIxvH5c6La2T0tleL75s7NWHv
	WYpA5aWln0KjGMHNZ+ZSsi1AAKgns+rPPsQ8rxuRCWm0lGcetuT0ZDF+G159YIPsVX94NLbnGhd
	ghch4gaYLCPWxW74Cg==
X-Received: by 2002:a17:903:2ac7:b0:2bd:a5f:1d04 with SMTP id
 d9443c01a7336-2bd2f4f5a66mr84335575ad.9.1778771806464; Thu, 14 May 2026
 08:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512192631.751908-1-stephen.smalley.work@gmail.com> <871pfe88k6.fsf@redhat.com>
In-Reply-To: <871pfe88k6.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 14 May 2026 11:16:35 -0400
X-Gm-Features: AVHnY4KEaMZ_TJsmC4-AfPmIgUvCDiWNkD2kYbyvmWLtf7pv3StzVwmixJmI7NQ
Message-ID: <CAEjxPJ4dsGnnA6BTmwrbA0_VCRn-c8+UZyXZDpJcF_uw-9b_zw@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: switch seunshare_mount_file() to use open()
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 8:44=E2=80=AFAM Petr Lautrbach <plautrba@redhat.com=
> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > seunshare_mount_file() currently uses fopen() to create the dst
> > if it doesn't already exist. Switch to using open() with
> > explicitly specified flags including O_NOFOLLOW and an explicitly
> > specified mode for the new file.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Thanks for the Acks; let me know if you plan to merge or if I should.
Also, I was wondering what if any validation we want to do for
seunshare_mount_file src/dst files before calling mount() on them;
there aren't currently verify_directory/check_owner_uid() calls for
them unlike for the directories passed to seunshare_mount().

>
> > ---
> >  sandbox/seunshare.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> > index a1900eaa..17a727e7 100644
> > --- a/sandbox/seunshare.c
> > +++ b/sandbox/seunshare.c
> > @@ -304,18 +304,20 @@ static int seunshare_mount(const char *src, const=
 char *dst, struct stat *src_st
> >   */
> >  static int seunshare_mount_file(const char *src, const char *dst)
> >  {
> > -     int flags =3D 0;
> > -
> >       if (verbose)
> >               printf(_("Mounting %s on %s\n"), src, dst);
> >
> >       if (access(dst, F_OK) =3D=3D -1) {
> > -              FILE *fptr;
> > -         fptr =3D fopen(dst, "w");
> > -              fclose(fptr);
> > +             int fd =3D open(dst, O_WRONLY | O_CREAT | O_NOFOLLOW | O_=
CLOEXEC, 0600);
> > +             if (fd < 0) {
> > +                     fprintf(stderr, _("Failed to create mount point %=
s: %m\n"), dst);
> > +                     return -1;
> > +             }
> > +             close(fd);
> >       }
> > +
> >       /* mount file */
> > -     if (mount(src, dst, NULL, MS_BIND | flags, NULL) < 0) {
> > +     if (mount(src, dst, NULL, MS_BIND, NULL) < 0) {
> >               fprintf(stderr, _("Failed to mount %s on %s: %s\n"), src,=
 dst, strerror(errno));
> >               return -1;
> >       }
> > --
> > 2.54.0
>
