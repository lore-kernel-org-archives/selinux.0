Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7084D296BBC
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373377; cv=pass; b=S9t2CfpzjUjAaJlBib9g74YT/uMPrzWZKC7x0k9w5EgJKbxDokTn8Y9wwZq3AHjRUm9P1Vkn9m5pk81eAdBsaERPCATCDa/uXHlw0bzvj3XRXpnpJBV4nBRLHTztMPsrBlS38rnHDUSC/tteSxPt/OP5XZfoMxyTWw2FCUIvXhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373377; c=relaxed/simple;
	bh=p+VyL32fHCAk6iEDdkUVec1+Sh39jbD9t0mA0koPsF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mn3TsWuvJ2TtKjroeH0HdzkObUkUsNKywk2C4X7xxlyHFDtNXr1PcCOq7VaS8muYZVaYElYEIlLsId7wr+/ZfgrpbcC042IECgdR96/L3LDObyR3n32J+VRVC7Q/jljcEQdmC2q9cmBXEI6zxqElTZcQFDA7YkPr4SlTCMBAJMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnhdOO20; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnhdOO20"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so752955e87.1
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 07:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779373374; cv=none;
        d=google.com; s=arc-20240605;
        b=D/QWoz6ok1krSpPNe7DBbO05QjN83MMFmaUWX8MbVsVzFxeR8zTR/yMwu0xoj4dL9G
         f3dS/QuNpWiRkUB7uON7x5zkIw7tcYGD1/BbzmmyFWy3LBA6osgRdWnGTtaB5uiJTtav
         AR7vMEkqTlRozlLp32eOy4vCtZqQec1d5oXsfnpEhknnPPyAmjM52LA/5BlEkTBjkOS5
         ngOBgahP4159NuPTOJMlGJeC4BZgOf5tc/zh43/aZfETj6mGATeaGlA2T1zVfQJCiJRf
         gWhbMJxO1PTajWFdlYf/366UOOqgi0igC4jT9zE9YlugqqyxTwPqhblQr77LxnJaJlBf
         6upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SfKf8q/RgEv9TOUb91SdDwH+WY61r3XdpKQscMnvCZ8=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=AyWY2pMJfUqo2LKGIHWbQ8TxMlgF93MivH+gql0lj87dj3gHjnVVtDqYrQEZMp/YRl
         3A6smnLnfk+sk0czGzQBaEMTHtIcDHE0IBUVFoULkXWLHKJP7GZWgv5PP6dtqraBdG6I
         b/V829oE2sDkmvsZ3TzoX+8jWraSUc9a/1Jn1QjjAW5ZgvemsTbuyNaSxq29hZETY2L9
         Ur/UCGsPkTxs+at0P6cOhgClTb/deOW2u3ndxBFvcmvip+LQ6lOXtiLTyGqI6eFn4+14
         ed0hIvlE7jgBTOav87j3pMkKGrcTwePnUifGImOvKzlyWLN1kjr+cN/NjfI9whZz47fX
         Z2Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779373374; x=1779978174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfKf8q/RgEv9TOUb91SdDwH+WY61r3XdpKQscMnvCZ8=;
        b=NnhdOO20GASYWK4Zoe22qmi1pVxamut0B1u5SsMO0c5M+l0VGbCLiiM6+dcdecIwRv
         9vQUht/FqCR9sfgV+DqfabDswvRBUZIW8Y/q6qk9HBuhPEvFj+a4J0ocgSiAi4/S1fjJ
         HSbawDqDFY92YuNV+n1XD8ZDWXzJdB0JvERnze9GDiF8Yk0SwFOvqjfmZ0DWNu7E0foV
         IHBvoisxpEfo9lv+P1z6w8hd058wdCzCG/7d0XCYlSphrFV5R91UnY/0eh8vLRVNHW40
         u4YvLkxTRe4rWIbYvcTXUOJD7r6+2uAcmAOOgLoOqIvo4ewvCHP0E1zqk0t0InznPQNn
         0D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373374; x=1779978174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SfKf8q/RgEv9TOUb91SdDwH+WY61r3XdpKQscMnvCZ8=;
        b=ANr1/C0tDBwbOBKJfb2Uetl4GeG9qDnd6KqNlq0dCpwein2dYiQ2rnNE/lS2ztzvoI
         ghAM5laNwm5ujPnN4xUt8ue3/km1p1PdOnKXDNf1YZ3hyvShrYd0t2UHcmuOhttdFO/a
         NtNZPpqVqZDD916vYwHWrcr3iOrHniqGfeFvNQ5wx5hgdnm6aLFBfhCMXpuwhXhu2fZs
         vdDFo1wJWP9DBx+jFwApN5OAYg8EIfuxjEs15mDYjBceGf6TllORzUkuAclSOasEWMXu
         NZ5BrWoJPu/E2j4ovpPddApDm11KhUXWPHtRPgOQH78mUYvs6KA5p2qW5uPCveOuKp63
         Pcpw==
X-Gm-Message-State: AOJu0Yz+XM3iCjfQqVHVEOAjI1hr9IKD5buffr8uBrpvDhBONvzJ8dc3
	khgjKq0soA8XmqvS/WJ33EXd9hvCcBeLcArwJqkqWgwnBB5uCA71Lft1xpOfuVZVKYaUYTojN6i
	+MyElEVVa8LVLo5KsCUoe3M097S/OKwDjMQ==
X-Gm-Gg: Acq92OGIi0DWHV9YeArjrn0pmJZHeyEhLwP03/p5CW+zxp7wqloUc3M4lyRhLHDgNXa
	akN12gfsvT/+ypwCfhDZx84O3w3cHmcCJq5fZKVpJ0WJiGQKoZ1umEZwMKTCoZgFXWkI+mHw+1p
	Bx7IknqaX54vRx6PQkZlMB6F7zD27g9SXVmR2jP6RjxZ5ZHP7R5eEEon8y/aB+KtcC1W9hSC9xY
	7yjNHOZPHB2xgYxE7261PgYuH3uglbTsEh6t5CjxgTjHU3zgcpxg63dDyklVf3Xo/Qu8U8tF2xc
	HZdGT9O19ygfTn8=
X-Received: by 2002:ac2:5ded:0:b0:5a8:6cbc:60f3 with SMTP id
 2adb3069b0e04-5aa2ba95dc0mr802819e87.34.1779373373331; Thu, 21 May 2026
 07:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508121327.91410-1-kalevi@kolttonen.fi> <20260508121327.91410-4-kalevi@kolttonen.fi>
 <CAP+JOzSFLvqda8NwEu3x8u5oH5pjfrsxHOvAcPHsRyfGAzDbHA@mail.gmail.com>
In-Reply-To: <CAP+JOzSFLvqda8NwEu3x8u5oH5pjfrsxHOvAcPHsRyfGAzDbHA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 21 May 2026 10:22:42 -0400
X-Gm-Features: AVHnY4JOsIXYOvZjJA9cIR-At--JNg1Epkdzk4gn-tWGj-V0MU-7nkzAUWV3n2U
Message-ID: <CAP+JOzTgXzg=FPaphcf1sQOYRwA429d_k+bUdLz6AWyuiO8dRg@mail.gmail.com>
Subject: Re: [PATCH 3/4] checkpolicy: add missing strdup() failure checks
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 11:33=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, May 8, 2026 at 8:18=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
> >
> > add missing strdup() failure checks. Also add one missing
> > 'return -1' statement on error.
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 4f775111..755a8428 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1499,10 +1499,15 @@ static int define_typebounds_helper(const char =
*bounds_id, const char *type_id)
> >         }
> >
> >         id =3D strdup(type_id);
> > +       if (!id) {
> > +               yyerror("Out of memory!");
> > +               return -1;
> > +       }
> >         value =3D (type->flavor !=3D TYPE_ALIAS) ? type->s.value : type=
->primary;
> >         type =3D get_local_type(id, value, 0);
> >         if (!type) {
> >                 yyerror("Out of memory!");
> > +               return -1;
> >         }
> >
> >         if (!type->bounds)
> > @@ -3559,6 +3564,10 @@ int define_filename_trans(void)
> >                 append_filename_trans(ftr);
> >
> >                 ftr->name =3D strdup(name);
> > +               if (!ftr->name) {
> > +                       yyerror("out of memory");
> > +                       goto bad;
> > +               }
> >                 if (type_set_cpy(&ftr->stypes, &stypes)) {
> >                         yyerror("out of memory");
> >                         goto bad;
> > @@ -4510,6 +4519,10 @@ int define_user(void)
> >         }
> >
> >         id =3D strdup(username);
> > +       if (!id) {
> > +               yyerror("out of memory");
> > +               return -1;
> > +       }
> >
> >         if ((usrdatum =3D declare_user()) =3D=3D NULL) {
> >                 free(id);
> > --
> > 2.54.0
> >
> >
