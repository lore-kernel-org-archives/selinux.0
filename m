Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F91C3F0C
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979917; cv=pass; b=UHocVwcSEkAhAQtnOFDfpSyt9JTCfzKIxlBpsHb0fHThvqlqE79I4HuIvdrFDxsKGEiGacoYN7DjktoJFmIo+1yXSrxH/dGfTq/xsJaZyibW8YJgfT0Lwfg8sISosMRDtB+U7HX2PRMY3Tg61BbedYRaiOEh7XeTxVokfIqc0LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979917; c=relaxed/simple;
	bh=lVu2qOuDsLLdm4e4Po82p+i3Cfrvhx2x0e3SClOyxzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbLrMdaT9d20W0RXbCmRx/Q2CNvw9cTGH+INx/JyRs+SjzpPUKJwNy6E86Qx4mMlx6joZNbmKjDV66cge4bEXXhrqCMaIFDoSTKlR/iLH1uousVfRcn1iYfxD8G2+A7zbGttANd4tNOfjleFLFoK1L5RQtLjlFS6kn6rxKknVM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf/dHGek; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf/dHGek"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-394413a63d3so97508481fa.1
        for <selinux@vger.kernel.org>; Thu, 28 May 2026 07:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779979913; cv=none;
        d=google.com; s=arc-20240605;
        b=A8bliCbqTlj5KBY3g/RMpZu2W9Jn8Lxc+7igYvWVW1kbnDn/8xaGIDEzap9KOk/WKY
         9zU6WV49+GZ2sRGSijldDGDGkJy29tUrpTfWjKh2HNjH0hf6gvXvjeOEyJi5GPxiEjD5
         XQBpNZ9eulS1CsFIoFNP6xe9eBfu1u6TsVTh0KuQyAvhyw7t0sYaZO916aiDWKOO2Ybt
         RzDOsKVSAh1gIslPiqlhjLKmwXl6tuByyje2RtVVoLiHff00ey5MeTvKKwFCLf9C2nRe
         RETnVddpC9ljTR9U1BUIBianoAo9olfMZu+Lk4A8GN8i+ClDN8DC8gwjEY9be07+eZLH
         MjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kNIv7W5wIUOzF8oFKDZSsPDoIFEsgKmZ9OGGtcyAWos=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=DGcgw15O1BkmYlYZklky2oeP942C2Zf9QI1AGo653DgjCfTWAsACcXzedzi63PHXcO
         AUpYN3slMCNAgg7fXsy1gzV9oVxO88DOnGnt6ADZV25QmOA/P4ZBsh9LGsuvCFddpM+3
         ye1RyC3ESc7RgA2iIGoBkvTsY1KmlVsOLPS6TjqasG79N0gBUPxqkMOn6e2itiyIcNUQ
         WYb/nwZBujwN9EmS4fTjn6gB4Y1mZ6/DcJNWe0fBwrnnP977KFlD2c6lx7nhyaYM36Kg
         +ep0NQCNmIpJ2ve00nriMZMe2sVV3ZmDIjq/AJWLQdelpb/8vRFq6UuqlFoPfKyjBMRB
         OyQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779979913; x=1780584713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNIv7W5wIUOzF8oFKDZSsPDoIFEsgKmZ9OGGtcyAWos=;
        b=Yf/dHGekr0IQxn3b2gxtyoDrYTMuMah5OCou7N/1XQa7PJVnbrWvQJfy8rc4JfsRhD
         0VQ5/mX3LhIKZOk5mFexngJsM9FIxasmOUrIurFMf9gNGOqUVc8NWLiId5hFR4RXZhvO
         vauUJ3xDYtbi7md8KqZ783XY763sU8rp/qnp6V6eOBtkZX9iygfZFEtPLG6t+//x7OD3
         W+lW9PGonUUrj+qdC74LKJmxDWRPk1QaLvB/c7X2WJLA4caZ0t2FSdj+Um0MhuZvThi3
         Wa2dCMSKSDsZjY/Lsf6MXYbiqBeoXZoa46789yKWnWSxgqI+x1OIG0/RT1BE9XNIRSyS
         ni4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779979913; x=1780584713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kNIv7W5wIUOzF8oFKDZSsPDoIFEsgKmZ9OGGtcyAWos=;
        b=aZtvEuJtdipN0QQhanTUcVJwwd2QUdJ6ZamLa3cKRlNZ1/5M5W8Uxw4GJmdBgUSCUH
         y9qR577w61jW/WEgo+jHT6bs6CBLsylkpKFR3sWNrg0zi77mm13cRJ3YrWJMiMxlmwY8
         SdJ2BSgQWiOmTAEvj3n505mnDp4cDHgMz44+P6rLha0sJOEDIUsLC3hLCnFvuqz33bWC
         4XnRDccGMspemFUXRcb2SFbQBBkRH60vvj/4Ar/APWNB7ad/wHy2b9A1ilI0AdY7wLVs
         7lggHYtWGK3FHWP9iJO+OCq+Q6UIapGy/QlFJkS1F8A3TsUr8IuT7sF2hNFKoVGEaal4
         bnzQ==
X-Gm-Message-State: AOJu0YzrPumUNr7XODEY65l3KP7shIXxtKMwUuvwexGKCA9UmceBf01L
	tIAM6ANpkcWWzdNJ/TwUeAhFZ1DU46PhPMNY/9pxq0HqUu5XOvDiR0jHeKY3rd62QXpyUDaxiy7
	dgQbShAFdr30sqnFLLbWUBxKseYNxJWY=
X-Gm-Gg: Acq92OE6Zw3Uyyz20shGB0PgQWI24AeJ0lU/lN4QgmVI+WpRThJk09hfCDGHRhw/SdT
	xXmTfTtyyfY46At6p2PVAn+fNMPj4icmgfc1JjFXN/PC15pAmOd6Jc9rgCRzHyMLAsMbfQ5jfAq
	EFfebVqrp90lPpZHDVrLgSSxkNmKLj4Q59z6zLWfqXhqTWS1IPIuoXnGJthJz4X7J6udvL30V6j
	kuAA/AHpr+eE+wb4RiOpQOvWY7EamYq7yza+BejawBurT/PJuP60rp3HWe4ElcXHRxOtZJKX9j4
	Kui/1agVvDfAInY=
X-Received: by 2002:a2e:a54b:0:b0:38e:d3e6:a89a with SMTP id
 38308e7fff4ca-395d8d0020dmr89289761fa.20.1779979912971; Thu, 28 May 2026
 07:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521190627.34885-1-jwcart2@gmail.com> <CAEjxPJ7ffu6udbmgMcHRPe1=u9j_+5z9QnXxk-NWDGSO0aAuuA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7ffu6udbmgMcHRPe1=u9j_+5z9QnXxk-NWDGSO0aAuuA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 28 May 2026 10:51:41 -0400
X-Gm-Features: AVHnY4IFkyA-fogJzrzUaYLdDM5jEYMPK1sr49WY2fr-QbVVCMa52uuh2gEov24
Message-ID: <CAP+JOzSVEokog8net3fLZtg=xU4f1VSHT4gSFBR-OS9P-Kao+g@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: In module_to_cil skip empty conditional blocks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 9:19=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, May 21, 2026 at 3:06=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > When converting a module to CIL, skip conditional blocks that do
> > not have either a true block or a false block.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Out of curiosity, when is this possible?

Tunables. I don't know why this hasn't come up before.

When I was testing the patch to correctly choose tunableif or
booleanif I came across this:

Original in module:
if (tun1b) {
   allow tbd self : CLASS1 PERM1;
}

Output in CIL (before patch):
(allow tbd self (CLASS1 (PERM1)))
(tunableif (tun1b)
)

Original in module:
optional {
  require {
    tunable tun1a;
  }
  if (tun1a) {
     allow tbc self : CLASS1 PERM1;
  }
}

Output in CIL (before patch):
(optional base_optional_3
    (allow tbc self (CLASS1 (PERM1)))
    (tunableif (tun1a)
    )
)

Jim

>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> > ---
> >  libsepol/src/module_to_cil.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index 89cd0b9b..5f1e4dbf 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -1426,6 +1426,8 @@ static int cond_list_to_cil(int indent, struct po=
licydb *pdb, struct cond_node *
> >         struct cond_node *cond;
> >
> >         for (cond =3D cond_list; cond !=3D NULL; cond =3D cond->next) {
> > +               if (!cond->avtrue_list && !cond->avfalse_list)
> > +                       continue;
> >
> >                 rc =3D cond_expr_to_cil(indent, pdb, cond->expr, cond->=
flags);
> >                 if (rc !=3D 0) {
> > --
> > 2.54.0
> >
> >
