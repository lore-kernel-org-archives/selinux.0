Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858BE363C59
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224632; cv=pass; b=MpNbLYZI6jepBOZvgazb4zeCwKc4lBfAWqrvvqFFIIMpUEpmks6sjY3md0JYL2LvewHvaD9u/5wxN3w9bOuaO17fgtUJkDe/LBvH+/0WGh+XlH072r9zPBZiwid1cq5BrA4f5J/5S+uD0OxAOdDYB83leTkm3nD2cnYlmtVysrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224632; c=relaxed/simple;
	bh=kBM4sjJ/fbrEmYRDYyPCs7kP7j2V3qHArgdNxsqryfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUiGAS/qjJIJXDwYEe3PIxagoogT6Y2/o75gfm9fC6WJcUdVCJ1xqJA1ba0ugGFhQG+ze0rOBCiwzi4fnuKrPd0A25XwU3oyD56a+TeKtRtAlpcE+qtq2SDgDPWCp1N2herPNzWesS/7hWI65Fhx3i3dO2V57xyWCrxtSKoEGKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvvcDsOG; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvvcDsOG"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3997a6196c5so38338991fa.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 07:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782224629; cv=none;
        d=google.com; s=arc-20240605;
        b=cTXZZBoTSDM1U6Aw4is+60hZAfioJSkK9Anjy6cfvmu0/ONnT3W3yHsBNRi1S62ENw
         AuZ1Cu0OYwbsJOK8KEm/uVc+eqHbU22Mbw2xR0tsWKdq4k30UoT4QQxECQ3V98H9lUHI
         nBMHxxKfNZ+DDx0Q3IoBwVSe/eDqPYkGW0QtnAjkS6G6g1uHpaaLg6UUfrGZdj/Wzp8A
         B15KrVw3YUELlguugcVTCKyqR8mdVVzdZBsNNtHe7zkAGTBoNHMI6nkqxGQqkqswOFC1
         BQh3ZSSLJ1tiH7Tap+Iy1Cwmy+D+adAkElDGVVVmZRAFi1Sq85jk4L/cdsYMbw3ZmoY5
         9xIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8CHRDQTNdlm/rizdhk5CnD8katfBO7GS64Tzk8bYhSY=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=TXlLiZa/ColkG1vMUzHdZ6cX5hNxU33M6UfhVG0G1af0OmBHKkr7WH8eXd0WOsvoin
         LWXopqCpEJo2fZOsl7eP5/WLSA47bU9tACx52cN4ANa0QbBt9XMUxLhU8MoM/ESnn22d
         qb0zopWY6zRnXi+eF+rE+Y7g+OArDqkwsCLcOzqvXEfivmuSgO/Z/EJUG7WC/OhDbX8x
         hjsR4hlXvUe2XFqqMW/NkAih2MSkkNkmBuEJ1kNrYaQYlGCxcEUK6hhMNUdbAhz+xjCf
         7SK4ZV8EDhZjwSNYxVgQJSmA2iYgNzGfo/Yi/bXxZvNJ3Nsy7hGs5Svk/9lq9wztZCf9
         h6RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782224629; x=1782829429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CHRDQTNdlm/rizdhk5CnD8katfBO7GS64Tzk8bYhSY=;
        b=hvvcDsOGPJMB7bF/ZJk029m59Qef1WbBrSZEyP1ddOzi5D2mEcxOj75qUIy8ITs8Qg
         IiMN58kAAXqBVFAPRc9+vAmGBBCCZ4/RXVXEVB95DdV+kLjWQOTSQBoxBqy7pOwlZUrG
         3jgqw+nKuivoQ91AH/RXHYy3Pkqru96q5T5T51y1Xz5Xy5+J6XWmz4zvmjs2bBVqezlO
         /z1LtZvDcueX5fjM/1REIepLVwIBwB1Fyv57UU1mzIZpdLqFSOfHB1J9upqtAmho5DcZ
         1RyVKAmOA/JKUJR6+JZSQSDR0I3ocGD59PH3GLt67V4wS7TsUOjgR+dnwzdS3GJfMQLK
         Mm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224629; x=1782829429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8CHRDQTNdlm/rizdhk5CnD8katfBO7GS64Tzk8bYhSY=;
        b=KFfI0s7Ha8VGFrN+QrLR/Eck/Z2BBsHEbYeAh7kMiAblwNWYN/Gd+P31DFitKgWMII
         +tsz5xcbQxbYEPdDMrcmmz4x10hehpYr9MtbKoo6im2wU8fX/sqoax2Q+IHA9YQ2V7Fp
         MTjiB4peZNATuzo1rPsNfn58/+LAcpLEm0YjCScnLrfsm1MDyg0HwziTktcMQwvfX8D4
         wbmvUduAMd600wOAjoDcFcAWjDQ5MGDXObZwEbuJCEQQrZYlc8dcTe8cEOpGAMY4TW3f
         EFf9gWD3gjLOApV0OWExrekfhncDaIbyqCXsCzUeE7/gNhQjfw59REo/vZDXh4s33fbL
         iyrQ==
X-Gm-Message-State: AOJu0Yxc2OlRcciwvUlqZKkdQA6XvZQHGB1OxnrWnpLlbz2nuf4mLtx6
	rv2MKk0YcqtkXtY193hNwzBe5bbg/NU5xwh6CeRGjzsO/XLQQdzd/LT8K+TERJc32nbluya5kq6
	3MWiVGNONhtno583TOKBRprfpONzUVUQ=
X-Gm-Gg: AfdE7clKwzRpO8jOwI6DZ82SlqIA8WQhKef81wY92MZ33NBp0kU9JST82ni25ZZb410
	GGOoaCU7U+OCcg7Wh4Vd+DbZGWSgs9Ij9TRFGuYIsFHTkTb8/BbI7LT9s46vqyyn2p6hF3p3Hiz
	O8S4TCq385kHl71OpWEtULGqim/8UE6jT2i2U6D4faEqPLLBLTcaQ8S495J4bz4M+epyL0d7wem
	O9449RSamAbclHTaBMKzEnf4RKP/07fZE8diXSGZaIuiXwzf6oXURk1SvpsFmT+m//a/oXECH+E
	JHBg
X-Received: by 2002:a05:651c:b0e:b0:393:d706:7bc with SMTP id
 38308e7fff4ca-39a20755105mr7766541fa.0.1782224628456; Tue, 23 Jun 2026
 07:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622173541.174998-1-jwcart2@gmail.com> <20260622173541.174998-4-jwcart2@gmail.com>
 <CAEjxPJ5BBE4drznHE-kC33BRkurpBrWrQRsSf+PZp3tzr2ZeCg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5BBE4drznHE-kC33BRkurpBrWrQRsSf+PZp3tzr2ZeCg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 23 Jun 2026 10:23:37 -0400
X-Gm-Features: AVVi8Cdk4lU6OBzWnr1zaV1231HgYyVAynoMfGl3XA_ybiZhbYkeY4cZFeOVbWc
Message-ID: <CAP+JOzSi=1PG7dRpzwM6isUrU3h+_J11ob_LZrKdk5A7HgMtCg@mail.gmail.com>
Subject: Re: [PATCH 4/6 v3] libsepol/cil: Add overflow checks and cil_reallocarray
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:09=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 22, 2026 at 1:36=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > The CIL stack implementation uses "stack->size *=3D 2" to grow the
> > size of the stack without checking for overflow and calls
> > cil_realloc() using a multiplcation that could overflow.
> >
> > Use __builtin_smul_overflow() to grow the stack size and exit
> > with an error if there is an overflow. Add the function
> > cil_reallocarray() that checks for overflow of the multiplication
> > of the array member size with the number of members and exits with
> > an error if there is an overflow.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> > v3: Previously in patch 0003
> >     Use the __builtin_mul_overflow() family of functions
> >     Add a cil_reallocarray() function
> >
> >  libsepol/cil/src/cil_mem.c   | 12 ++++++++++++
> >  libsepol/cil/src/cil_mem.h   |  1 +
> >  libsepol/cil/src/cil_stack.c |  9 ++++++---
> >  3 files changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
> > index aeffdae2..4f75122a 100644
> > --- a/libsepol/cil/src/cil_mem.c
> > +++ b/libsepol/cil/src/cil_mem.c
> > @@ -74,6 +74,18 @@ void *cil_realloc(void *ptr, size_t size)
> >         return mem;
> >  }
> >
> > +void *cil_reallocarray(void *ptr, size_t nmemb, size_t size)
> > +{
> > +       size_t array_size;
> > +
> > +       if (__builtin_mul_overflow(nmemb, size, &array_size)) {
> > +               cil_log(CIL_ERR, "Overflow\n");
> > +               exit(1);
> > +       }
> > +
> > +       return cil_realloc(ptr, array_size);
> > +}
> > +
> >  char *cil_strdup(const char *str)
> >  {
> >         char *mem =3D NULL;
> > diff --git a/libsepol/cil/src/cil_mem.h b/libsepol/cil/src/cil_mem.h
> > index 7ec316af..f3f40c46 100644
> > --- a/libsepol/cil/src/cil_mem.h
> > +++ b/libsepol/cil/src/cil_mem.h
> > @@ -34,6 +34,7 @@
> >  void *cil_malloc(size_t size);
> >  void *cil_calloc(size_t num_elements, size_t element_size);
> >  void *cil_realloc(void *ptr, size_t size);
> > +void *cil_reallocarray(void *ptr, size_t nmemb, size_t size);
> >  char *cil_strdup(const char *str);
> >  int cil_asprintf(char **strp, const char *fmt, ...);
> >
> > diff --git a/libsepol/cil/src/cil_stack.c b/libsepol/cil/src/cil_stack.=
c
> > index d9c7b0c0..6fd051f8 100644
> > --- a/libsepol/cil/src/cil_stack.c
> > +++ b/libsepol/cil/src/cil_stack.c
> > @@ -77,9 +77,12 @@ void cil_stack_push(struct cil_stack *stack, enum ci=
l_flavor flavor, void *data)
> >         stack->pos++;
> >
> >         if (stack->pos =3D=3D stack->size) {
> > -               stack->size *=3D 2;
> > -               stack->stack =3D cil_realloc(stack->stack,
> > -                                          sizeof(*stack->stack) * stac=
k->size);
> > +               if (__builtin_smul_overflow(stack->size, 2, &stack->siz=
e)) {
> > +                       cil_log(CIL_ERR, "Overflow\n");
> > +                       exit(1);
> > +               }
> > +               stack->stack =3D cil_reallocarray(
> > +                       stack->stack, sizeof(*stack->stack), stack->siz=
e);
>
> No real effect but you switched the sizeof(*stack->stack), stack->size
> order relative to the cil_reallocarray() interface.

That was just sloppiness on my part. I just replace the '*' with a ','
and didn't think about the order.
I will fix it.
Jim

>
> >         }
> >
> >         stack->stack[stack->pos].flavor =3D flavor;
> > --
> > 2.54.0
> >
