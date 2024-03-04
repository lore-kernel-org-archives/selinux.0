Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871B79924
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579990; cv=none; b=ism3xBcFJQ3AjJHT5+6JThZwF82swL4W2WYGxUbz3XVr6ep1Ex1yFjsllBPRmH1g2FYo+Qxm55FuYfHAHpeUzSRuXY+yNuHtyOJSGRviiOacx/EAC+zzM26NkfA+TvprPJN06tAkK6IU5zxSOAzypptH7EeNCNjRy+X1rbGsrd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579990; c=relaxed/simple;
	bh=R+UHpA4zLX99ScIZfQVVIHMTfiJSi0cSrLbSZqHV1Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceuaXlt6UDJwT+ckCxgb3QkgctGzcFD9tNyvAcsOcVnO1uMQItg1b6GRtPFREigO5fZ0SSPXv30/Vcbus3JyV6jxJ9oj7Qv1OL/IpRbBHSZ5oXaFcwl9ju5XtwGNfrPvSHLyMMIUSe7cftdCO04bDaPK771ExQhkUW58a2XN+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWQOyM5K; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWQOyM5K"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7dad2d1c9edso1896992241.1
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579988; x=1710184788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ae4EqoQxG71WmErCzQpEIpk/9v1ABmkIh4KgpB2JEg=;
        b=QWQOyM5K8gyyeHwtyzQySdopN5UYOqjX1n256BVAdTGh7kZ9HUnyj1MO5QXsb2qYla
         0uLoY/vVxkQ8N1kXkqGbObupVr5BbkXlhyyj8jEkPatgrdcgPGf8QWDxoYbcGsbmtdno
         5nBLeg9y3thwaU3ljTAVSbYNBQlokl9hKBZ02zeeh7AIqkGAzC34hAvlRgUo/CoeB7Py
         uPsYTUt2L2gtKeT/oGcobRydn557XgLNT8KNduUsxmOQJ4qrjFastDxs4LligG1oUBZ+
         3RG/Kx2jOunPkO7TxJzqyoGpwJIiKdHCg4SvG6HuCe0AwBJkxpLz3252qwcbMhq+q9l1
         ZOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579988; x=1710184788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ae4EqoQxG71WmErCzQpEIpk/9v1ABmkIh4KgpB2JEg=;
        b=WzaLNMPv2V9xe6NtC247zxcTK0jGu1aEPgBSGqZUpimhmeoXrL/xi7zroftQZKjrI8
         bR41BTytw6BF7jz3JQmwz5hmOzyFStcLn1mppCSqoT3Z+TGU+WkJAPWj7XTp93vpmOow
         80myMjEyg9S1ubmD6Jf5dklU3hm+8YMrMy+hAF7A7KC+ubGHAbhraW58k5yWgd+jpMXL
         Q2HmPv4j/XKoEUrGLT/k//h8MNNH7HdD5eUAN5CKBNaHNfDusoUQeBBUcAlVF8PfwX85
         IPwnml1OMsfyKLrJPXpErKQbtf7ijIilxPAz5bTqVNIFNSEJpJvx53OULYHZUubNbisc
         hqOQ==
X-Gm-Message-State: AOJu0YzxVgtEQxe7e4KYuhB3KiCzGj0HfsE/o/F6dzJjBFOFfgSCCP8u
	b7/SkRZRusaTr0+2p9khZ/g+3LcQq6nc5m5AgAbn1oLhoJDq0D24mXmD2QveZhszRB1/mraTvAd
	G8mC1fenjLMHTrxyFzpvpi/w2fvk=
X-Google-Smtp-Source: AGHT+IF6aSLd1trBKInsBOhKgcLl4RBBpB/9UYzJrOcKgmSed6NJQHfX0tZcvpDqg6mrkwC+ehbvxv3Af8x7HuuaM/I=
X-Received: by 2002:a67:f893:0:b0:471:e2ca:4023 with SMTP id
 h19-20020a67f893000000b00471e2ca4023mr5865990vso.25.1709579988162; Mon, 04
 Mar 2024 11:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-9-cgzones@googlemail.com> <CAP+JOzQP+SmXvGvUmyEFgD995QSABc3MBrP2tCJZA-ZKfbBYtg@mail.gmail.com>
In-Reply-To: <CAP+JOzQP+SmXvGvUmyEFgD995QSABc3MBrP2tCJZA-ZKfbBYtg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:19:37 -0500
Message-ID: <CAP+JOzQkvHxT5cCXJDDuPKOTPbOuDfBNZrz-yWbFJYc+yfMbUg@mail.gmail.com>
Subject: Re: [PATCH 09/15] libsepol: use typedef
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:37=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 8:55=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Convert the only usage of the raw type struct level_datum to use the
> > typedef.  Simplifies refactorizations on the type.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/module_to_cil.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index ee22dbbd..417c5307 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -2390,7 +2390,7 @@ static int boolean_to_cil(int indent, struct poli=
cydb *UNUSED(pdb), struct avrul
> >
> >  static int sens_to_cil(int indent, struct policydb *pdb, struct avrule=
_block *UNUSED(block), struct stack *UNUSED(decl_stack), char *key, void *d=
atum, int scope)
> >  {
> > -       struct level_datum *level =3D datum;
> > +       level_datum_t *level =3D datum;
> >
> >         if (scope =3D=3D SCOPE_DECL) {
> >                 if (!level->isalias) {
> > --
> > 2.43.0
> >
> >
