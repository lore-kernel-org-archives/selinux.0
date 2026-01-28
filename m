Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2A37418C
	for <selinux@vger.kernel.org>; Wed, 28 Jan 2026 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632086; cv=pass; b=FiI0FK5eV8IuFgIZ1SlLyPYyHGm9gIVQZAqPF5hLW1bmjXrKGeyv9TOod1exUKxXY0ZbQO/iSCzfLDUQ+prX/bDJHD74MyAqlWa/4Af5Qlns8n6g7jBcyqYlzXKVkyD6dttV6NUKCurEKHWtc5dqDuJ9jOs1A8nQgLuXtOUgmaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632086; c=relaxed/simple;
	bh=zmsqaLqEBOwvnqBtmWu3iIYJncGugaOHgearrXQM8ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXvTaEpFdI2BdAwTNvrkkxt1hLr0gRsLEbt3iSsQSEPMXT+6RjKMRORCGKyvJc2MyIbL8YjY+u2hXrWwVVra1EET2SCii0JXMl8ye/wcqN86pysuX8XKDxYSAREAywcBYT0Jus1QnT+sEpF5SM4wIQEit4RYV2IjV7e3Vao7D38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJ7e0p/t; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ7e0p/t"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-383122fbc9bso2127611fa.1
        for <selinux@vger.kernel.org>; Wed, 28 Jan 2026 12:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769632083; cv=none;
        d=google.com; s=arc-20240605;
        b=b66wCwO04Gmg2FidudmVa7CSIS9K9kqEwr72nR8XpOwL/npZn/KL1aSviMCJRAnwpk
         jXRKs7cDIZlpjXH0ASdoRmIfQAv0gC4UtX4oz0YrrRL+BNgi3H2vg76mqrVW0Pmluldt
         StOewG9vUL6Cfli6mwhLEWTVH8fmCGgLe+j6vhXdgpy6HPD5EayovfWZfIS8TNfZ0Rm/
         IDT2EScD+PhWFf6tWtCJpTmaX/g0cbAGxf4HQ7X9FTJOU/qWdQEZXhSPWyCTFgPdD+hW
         Pm5b4Krh2oSbhGrAA+VA1WGffeWhjj3r9v3Sooa0xI7/h8V2FzvARxwZv5QJBhuP/MAE
         n7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZOLHdchvWIOIfbrkfbV4mhv4ngweUHeO5Xitgs7Rh3A=;
        fh=64kfzEJR+k3A/Bo0EjJbS2mTPctgdvPLOIBcE6p3LTk=;
        b=aYQE1cJuNIwAq8QGlt0ht/hWbzggkVZPBua5hpoLTmSZypJCk5YnOiSMaPGTAerS85
         aMgQDP1pbriizkMORiToDRsIxwHHuFzArg6tNXnOfZwz5dPTuhN7kbUo3m5WCMq9vEhb
         3zCDjB2b41BeaWINno+DVJECeI+zjRK7xV7CWLkJG/h+6NuMRUFca2W4YArtuxsirO9S
         R2ZjNCQWjYwpM6cro0tJJ93RTpYTIzifJeLODqZqWRcK5Wta8t5RbVMO5r6wO42rI6Uq
         D93kxurKU0qRu4u1gkH5Qn3YKvnRsDVnfAETwaKL/0wEimZ2c0G2Tl7zqHr+v07d402b
         nnAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769632083; x=1770236883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOLHdchvWIOIfbrkfbV4mhv4ngweUHeO5Xitgs7Rh3A=;
        b=WJ7e0p/tI7DQn+G6fwz+c+ddayqxPS5C6yKEYy5ds3Y4C0yXOZB2r4omJBSJgcPfa2
         liRmwPuMDFo4BkTI9rzsVUXOGU6XFk9aqiycojGOaVsFuMjAl0jKq5KuPkC49/AqbmA5
         qO0QLGD3q6yMttrflrpDkvTZ4s32ErwnBp3+Afc/JqmO84G7FDRackMCmkecWTOt1i3o
         G5cJh30I2VykNzgWWKmqA4SLLPeyz6XI/3HfxpuW303HtQKpZiiq4DS0BWsaCGjyycJD
         Bhi5t7Hn305ns7y6escMfFIVhJ5RXfwN4iGFVvpWEKh4tbpTf9qrZUJ6S09YOCETw6jl
         FmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769632083; x=1770236883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOLHdchvWIOIfbrkfbV4mhv4ngweUHeO5Xitgs7Rh3A=;
        b=hRweqogVM6qhbheiO2Nenqw+ltK7xfwdqPZ0D0MW0nzSanyA1qySgRGlmF1luhUAQ6
         s97sLQuPNkWIvoXbe3IFa+/J+GgoBYgw9v7kbH6za5Col5EHRkPo+xPdJtlyLysO9IQ5
         APi1bmUnKhRD32HJoWPYPP00z37ANziscPgquk1pYHCrfZe6mak9TmpcL8WQePLUVDFo
         I4nxHMA/bOWR+JiV8eodVXwT79SUel+BHpkE6PZz5jMTgFOxsJzRi8ZLckdoWFURZ7CT
         CA4KdfP/txRf3idODjbOMnEO/CdcafMLp2IUAQEw4hia6u54q+4WapdEoEXAa4gWsrry
         +m3Q==
X-Gm-Message-State: AOJu0YxNiZdsz5ExqOD9eK44CurPBdpqUADWBAYSH+ObX+Ipz3c8fkTg
	TQuF1HmYFESOU4Q1x/8fJQKfoq/hrmTgCe7wapIClSlIbkBPFFINCZBU88dQDbYv4FaNgm413X8
	Ty0sbY1VC44lOvqH4IOpHis3b/PaAFRw=
X-Gm-Gg: AZuq6aLx1cFtOphPHeHnNQzVvDSeFQJm86Nj7UU0+36HvNCO+Qe+9cuVHudqKuHrk52
	8mSEMILuX6CAdcRJ62gKMC0irSuu087FrKtDoWKOb8yN+/Abt0P6rlLA+MOLofYGyyV917Gz/Hd
	F47VNPu16aG1lYlzAJsoGvqIjXcMiAn5AHxoqBZUYwi3hzzLpKWxrVE5oKlSbIBoMyOJIfrSv34
	Xs9FdP3E6lRsOoOFMki4xbDXJrDHGSQOZqv1zHAjffZUXRDTQkRIhLNVj8B0yzY3E9/GEtcfyZq
	TjY=
X-Received: by 2002:a05:651c:545:b0:385:b6e7:8162 with SMTP id
 38308e7fff4ca-3861c951476mr31606391fa.33.1769632082730; Wed, 28 Jan 2026
 12:28:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227143911.1630813-1-thomas.petazzoni@bootlin.com> <CAP+JOzRZBfW53JSN3kSyZdUtk8Hdv2TGKt567LMh0fFEOegrvQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRZBfW53JSN3kSyZdUtk8Hdv2TGKt567LMh0fFEOegrvQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 28 Jan 2026 15:27:51 -0500
X-Gm-Features: AZwV_QhIVePN0eiGBiIkLZhIS9NAGfguV4Rm3mGUkc2qxtbBuHk0pSKRc-8WHkw
Message-ID: <CAP+JOzSsQY5-+8W6=+Uo1+-zPGfyJ5V1nc9y-Si+Uesi0Zd8PQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux/src/Makefile: build python module without isolation
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Bernd Kuhls <bernd@kuhls.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 10:08=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Sat, Dec 27, 2025 at 9:39=E2=80=AFAM Thomas Petazzoni
> <thomas.petazzoni@bootlin.com> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The "pip install" logic in libselinux/src/Makefile tries to get
> > setuptools from the network, which is not correct as during the
> > build/installation, there shouldn't be any network access, or
> > downloading of arbitrary resources from the network.
> >
> > This causes build issues in Debian:
> >
> >   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1121121
> >
> > And in Buildroot:
> >
> >   https://autobuild.buildroot.net/results/0e9/0e9de0c0d8b6ec57eea9f8834=
f02076b296ba4f1/build-end.log
> >
> > To fix this, we use the --no-build-isolation pip install argument so
> > that pip install is allowed to use the system-provided setuptools,
> > instead of wanting to download this one.
> >
> > This patch is derived from
> > https://sources.debian.org/src/libselinux/3.9-4/debian/patches/Build-py=
thon-module-without-isolation-Closes-1119155.patch,
> > with the change that --no-build-isolation is passed unconditionally,
> > regardless of whether $(DESTDIR) is empty or not.
> >
> > Signed-off-by: Bernd Kuhls <bernd@kuhls.net>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index f7412cd1..0dbba7f4 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -198,7 +198,7 @@ ifneq ($(DISABLE_SHARED),y)
> >  endif
> >
> >  install-pywrap: pywrap
> > -       CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pi=
p install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTD=
IR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
> > +       CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pi=
p install --no-build-isolation --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" &=
& echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS)=
 .
> >         install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/_=
_init__.py
> >         ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(P=
YCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
> >
> > --
> > 2.52.0
> >
> >
