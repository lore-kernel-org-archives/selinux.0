Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D140911B
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903192; cv=pass; b=bb7I/yhrykNn3snJF65xGUvUtDPMyfPbF0WrwLVzlLOz9OChYnOEqtz4oErfgiYF4UX7Nm2Wf1QcFK2V2ZOJV9cpRAO9Ke7Ix+kW4yTr4ZlEyI8ZHr6kTLmGmBslOKCYKzIKwgPvyNSfxg/LICyzCQ8wdlagnSiQaETJ1Y0O9jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903192; c=relaxed/simple;
	bh=dA2c51uEFzUXDBmk0tbYUzwIbhE09fnSCFat3isXbj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CW8gkiH5ar/K1RpvrlIAQakx+5dQDsTHSROWmoSxbYZIvFgq3ozeRJCIfzTSkPiCuxzI99NqInYkInyrXkrXgrS2vK2B+mV/m/uLJlj1KMjuGVVFn+AkD7TEKdfSUuNRZdxhpAaVRADUKWtqIDgDgZ9GtSnwB/+El2yxHFnWNus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by+ap93F; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by+ap93F"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-44868d6a066so199757fac.3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784903189; cv=none;
        d=google.com; s=arc-20260327;
        b=HhA384oI2Bjf1WPpEepd/9ghs/KO9yhivFYNVRCrj3tzVXfffY0b9ZAHC4+Nnhh11C
         SEzmVP2wuvl5n4NjAw45k1I1WQoBul8DlzYp9SCZsQxzkDIyPtC2FMHRkSrrNK9Dfuqm
         DlPNSVbA9dXnh1DCsnzxgknCgGMP2EDB/Iosc8O3qawgAqfEkbc8nFeqKN5IJXtZdTgo
         JcZfyUt5vlrg0Jfj0xcg7XGkjwokNdfOn4+NiP41SQPJZC6XNk+ffsIpfOc/efquMjRG
         52sEabI2LV7jkaionynr2i6g/av0pfTQE9pZpxRR0cUuIjCidKSejtKc0OgD7qoDXeEp
         YVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=inMRNSXy9DspmU4AtYKsBjrwpWJH6GWs2S4DJ9kV0cc=;
        fh=GeJFfy1mgA0CYqJkxNBhbqhh0dQWMteeu5mXSYbSZds=;
        b=ml9/IasKrLD+PfmcM+Ns9Y33/utHc3n+QJPlAWz/LhivksN5z8d8Cf3aGWJVsh//gI
         nq2m0cG5E1j9lXEwqX9i7bbw179NvRxJNnP/RvzH973OP2UoZdhEJgZeVmYR+5sxvrRZ
         SQrGbfpbyXtqcXmWqnjZmNhl/tEgBzKFAfRxBJfab2V3Bu3AqXTlNjTwo69AnnfORnJT
         F9A3iMcHK6aEF1T2FSyqNHxozfnntmjV5dNcCDxkgkvwpJBVoNfHgcrqrEKylAb2yH77
         m0z1amYk8g+QxJ+oIlQojBNjE8LxtYSQ6x0LESrtBGnh/Plt5InkvvszNqbmEjCIh8uO
         wwEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784903189; x=1785507989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=inMRNSXy9DspmU4AtYKsBjrwpWJH6GWs2S4DJ9kV0cc=;
        b=by+ap93Fg6R6xJBu0DVFg8+BTlhszCf11+0QATrOukc6MnhIhJKhSXMYY1o/gE7Unl
         iMYIIE4xtAkGZJlRfoFjKs0gsfTOyn9e5sN8OPUpSlzyBqzDZhOexnJfQFbt7kovzroK
         rOo/te2PkgqLQIrAa6WfMV/a5UYG5WhU2QvfHHXzmIwZLsG/2vjUDGAsfSrfhsGSJKv0
         Y4m3lBuqhuQ3KWOByT7Ttw9Ac5x8bz6KgDDGH3s9HPSngvZvymg3Cxea503kg2Pt3e0c
         TwYm6+8LzUnvlqsh39Gs6Xt08z8CUE69V9o9ZmF6TYpQX5Fc0D1ntfcR8Vj2pmDl6+gN
         wnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903189; x=1785507989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=inMRNSXy9DspmU4AtYKsBjrwpWJH6GWs2S4DJ9kV0cc=;
        b=nW7FSD2i5/RUIMzJW7xWj77s9isSPZRKZB7XpEerGwWKeCUOiWoTPC+moUz2WKsOxY
         mR7huuNBZ+v0WxLdwCBwTTgNHEEiCfnK1VGwEwu3+HBMIyJmvpj8uI7OFWGDaTVFU+b0
         vTFGxL0PpJJNI7p/M/Qv/IHKLdkyrAYnwOki9ghKn1qNxZd7aBAalO31YaF3choJZHGg
         WIA1sGJRudBEPic3LBNaV+OW/QwzRySr32wy29+CmNO8KUDALjvEXBK8qJuxVzg9Cg3O
         nJcjzZzFRAbS9IjpC0mN4JkUUzZ1FKYLemmKOh3nBJPWtm2FVjXbZm3eeN59W/QOwvmh
         53fQ==
X-Gm-Message-State: AOJu0Yysv7J5jnVnLNYNMRVwQLhA6RDaZN7uOO0bE4QceDYyCP/9Fjad
	vr7yW/vpWPA4STsYMMdn0R12XZ/onaNs29hE8kjCy5xsBRQ9qTdZP0UTH8ctoRT5tMBAeUxlmAa
	yuP7zPgRGBQI2ttDMJQ20cpJ5YISsZ4x3AA==
X-Gm-Gg: AR+sD130Z/S7U8yppFjGXN+QplmWTCOhq2Io3aQ1dkEJHT7MIyJBoOvINVXi9mJcOSz
	u8VQMUlncVb5m3gYNsvciH/OJ3iWAivW+dQ0jVOXTOBUOL3WbiSGGgxqYqtHWJ6zz6hvar46Twx
	YJ4ymJe5Z93Wy0HnVxitqqfC8XqSXNdtduljwXRLrJfIN+ctErk41m1PlwRtUzELFONtV5HGtUz
	pKMLcwaA/CsK3P3KAStnmAr40swW4YISthehz06bFZq96ewfc79nyYxWKuU5t/RYdSj2nN1
X-Received: by 2002:a05:6870:712a:b0:456:6157:7848 with SMTP id
 586e51a60fabf-457a11b0e85mr4057377fac.39.1784903188424; Fri, 24 Jul 2026
 07:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721185357.64896-2-stephen.smalley.work@gmail.com>
 <20260721185357.64896-4-stephen.smalley.work@gmail.com> <104ecf4e-7dc5-4bab-8f3b-b73f0aca5d41@suse.de>
In-Reply-To: <104ecf4e-7dc5-4bab-8f3b-b73f0aca5d41@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:26:16 -0400
X-Gm-Features: AUfX_myOvAi6SoZs3APuTB1pdyLy-sPkKxItzPfNQ4jPpKJVsYeLAfiT-abLR5A
Message-ID: <CAEjxPJ6pKtPU7ozYg6D_OaVe7gLPnjT+Azw+gZygNT6Tj+W5Cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] python/sepolicy: add a pyproject.toml file
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 6:20=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> On 7/21/26 8:53 PM, Stephen Smalley wrote:
> > Add a pyproject.toml file for the sepolicy python module.  This
> > required also updating setup.py to avoid defining author outside of
> > pyproject.toml, and I further updated the authors to refer to the list
> > like libselinux since Dan is enjoying retirement.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/505
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >   python/sepolicy/pyproject.toml | 19 +++++++++++++++++++
> >   python/sepolicy/setup.py       |  2 --
> >   2 files changed, 19 insertions(+), 2 deletions(-)
> >   create mode 100644 python/sepolicy/pyproject.toml
> >
> > diff --git a/python/sepolicy/pyproject.toml b/python/sepolicy/pyproject=
.toml
> > new file mode 100644
> > index 00000000..472faf7a
> > --- /dev/null
> > +++ b/python/sepolicy/pyproject.toml
> > @@ -0,0 +1,19 @@
> > +[build-system]
> > +requires =3D ["setuptools", "wheel"]
> > +build-backend =3D "setuptools.build_meta"
> > +
> > +[project]
> > +name =3D "sepolicy"
> > +version =3D "3.11"
> > +description =3D "Python tools for SELinux policy analysis (sepolicy, s=
epolgen)"
> > +license =3D "GPL-2.0-or-later"
> > +authors =3D [
> > +    { name =3D "SELinux Project", email =3D "selinux@vger.kernel.org" =
}
> > +]
> > +dependencies =3D [
> > +    "libselinux-python",
> > +    "libsemanage-python",
> > +]
> > +
> > +[project.scripts]
> > +sepolicy =3D "sepolicy.__main__:main"
> > diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
> > index ca0396b5..5c4f2e5d 100644
> > --- a/python/sepolicy/setup.py
> > +++ b/python/sepolicy/setup.py
> > @@ -8,8 +8,6 @@ setup(
> >       name=3D"sepolicy",
> >       version=3D"3.11",
> >       description=3D"Python SELinux Policy Analyses bindings",
> > -    author=3D"Daniel Walsh",
> > -    author_email=3D"dwalsh@redhat.com",
> >       packages=3D[
> >           "sepolicy",
> >           "sepolicy.templates",
>
> lgtm, or at least i don't see the warning anymore in the build system

Thanks, both merged.
