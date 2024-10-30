Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FDE17579
	for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294116; cv=none; b=IpvrGT9Mj9S/csevmT+jqp6ZFVNVvlZepme1Vnd8WtXyjKlMVQpxNsGhmK0JFoKyt2VnCAmdlFpAWRW57GzzBnC8U2G9YiJzkJKhHMiVmAD6IApogTLjGQ2B53cKw+4kg5mZMACpF5YqGz0RoBnIiC/tqWaFNTC8BMgw4Q20aqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294116; c=relaxed/simple;
	bh=Q+GsrLbpnF+8ITdkyCdakVKEfJd6tMHsjt5IpIUYPTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pr2cTyZiX3UnPHWhFzl3dbx4WbLRZFb8/o/7Qofqe01dZjJDPYOjFw+xZVXujivSLA2nJCellu9awlyPzVMsfcp/Dftd8J5X7YDcqby5e0m6Q8PoobyqKLsHQTjzxCrlyD7yLoIqWeyU2Qv3wwIdv7waCWFD8XkZYMWIocI5O9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HM7Ceiiq; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM7Ceiiq"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ebc1af8e91so3320610eaf.1
        for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294114; x=1730898914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMahzV0I5GypJ3chIePx/ChpXXBS3rOuIcwR4+bLEzk=;
        b=HM7Ceiiq0zmlUpCt2G0y70I9YnJ4xjJfCiI1c5p+5XYkAT7nFoVOcKq+ImmWPpAYrY
         2cw7ah10QtjaskmzFJ64T1gAcnxnPTrCLpiYOEf47/d7jISJWlHgKFn5HTA1lqofOv8P
         Kzz98BxaOvETYl+1pWzd3Y2b8ZTY4tJSVT9tx6DgioNB5I4DzYo/aujl/TJ7JHCHFMDE
         pEEgcPA2xAOiRssgKg8+QUOoke4orWxc+6QhsZ6pZiyi02/4Uio1J5bQhdhwmf8nfZIB
         BYohst9KxUUvAF8O+Jfzw4sj6eW3hBJswpP9hYwySUXUCpLslobowiC37F/QpSBdo5OG
         1ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294114; x=1730898914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMahzV0I5GypJ3chIePx/ChpXXBS3rOuIcwR4+bLEzk=;
        b=FfJk4g+nRRBUHsHtmj1t4y/ZAOQjLrKs7krPTs31FZGUuQgyfa9HuXHnYMiVTrZMyw
         81UNHZJMmW6qL9nwl95ZgZMRdP6J+tpiT0GxhAlXJiyaTZ6uGjwyVQc2H8HIrbfUbRFZ
         icZandjvHRXHQJ9RXIAm3HrYC2x/k96o0ycrEnu4iEX+rabSRPrDYutKGmHEbUB+7f1N
         oPSqDaXvYv4N7RQ3X08Sl8Y1lTXYho3qaBCEyjHE5u6bWnQ3rK5CoPBSKHugS1gydiJ5
         3G9kgGZfuQIIvss1M8yEHIi2uB4CkUjNvnohDqeG36ycbvlDGGJoddZSoAllUqjfDCcF
         Leaw==
X-Gm-Message-State: AOJu0Yy3bqS/XYLQHgtIgQmVRm8PurFiHq3wo4iPGlv7Lf1SZ60oSEZ3
	mUW/07iV+D4pu/P7QhG/Xa21yrV0G4xiFzbPMJA2IIPsvzMkqU5g/PvCH3/XvEBYX3e4VYdE/a/
	b91KXBTGwjwl+0iiX8OzkdaHVhglenw==
X-Google-Smtp-Source: AGHT+IGRHM/J0h1cqOVsH0TyVrAmRFQ5en6lm5SDr729Z0GFt3OlNTNyCyPcWa/9uFU3OsaJUsFrPEm814QJErrJTkw=
X-Received: by 2002:a05:6358:6f17:b0:1c3:9799:3eaa with SMTP id
 e5c5f4694b2df-1c3f9f78e4amr736490955d.24.1730294113646; Wed, 30 Oct 2024
 06:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP+JOzRURZwsyvGzs3U7M7mw4NWD3Brh-K4wnztCS81MLYRHYg@mail.gmail.com>
 <20241023134318.733305-1-vmojzis@redhat.com> <CAP+JOzS2tm_7pXW46rWsOaMG1Nv=kKqFBQYsDbLfhFr4=F9QXQ@mail.gmail.com>
In-Reply-To: <CAP+JOzS2tm_7pXW46rWsOaMG1Nv=kKqFBQYsDbLfhFr4=F9QXQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 30 Oct 2024 09:15:03 -0400
Message-ID: <CAP+JOzQgvojbNZMwqU+ux-V68zO9NLBkux_aFG9iOcxrPpb1nQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] libsepol/cil: Initialize avtab_datum on declaration
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 3:10=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Oct 23, 2024 at 9:46=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> w=
rote:
> >
> > avtab_datum.xperms was not always initialized before being used.
> >
> > Fixes:
> > Error: UNINIT (CWE-457):
> > libsepol-3.7/cil/src/cil_binary.c:977:2: var_decl: Declaring variable "=
avtab_datum" without initializer.
> > libsepol-3.7/cil/src/cil_binary.c:1059:3: uninit_use_in_call: Using uni=
nitialized value "avtab_datum". Field "avtab_datum.xperms" is uninitialized=
 when calling "__cil_cond_insert_rule".
> >  \# 1057|                       }
> >  \# 1058|               }
> >  \# 1059|->             rc =3D __cil_cond_insert_rule(&pdb->te_cond_avt=
ab, &avtab_key, &avtab_datum, cond_node, cond_flavor);
> >  \# 1060|       }
> >
> > Error: UNINIT (CWE-457):
> > libsepol-3.7/cil/src/cil_binary.c:1348:2: var_decl: Declaring variable =
"avtab_datum" without initializer.
> > libsepol-3.7/cil/src/cil_binary.c:1384:3: uninit_use_in_call: Using uni=
nitialized value "avtab_datum". Field "avtab_datum.xperms" is uninitialized=
 when calling "__cil_cond_insert_rule".
> >  \# 1382|       } else {
> >  \# 1383|               avtab_datum.data =3D data;
> >  \# 1384|->             rc =3D __cil_cond_insert_rule(&pdb->te_cond_avt=
ab, &avtab_key, &avtab_datum, cond_node, cond_flavor);
> >  \# 1385|       }
> >  \# 1386|
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These four patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_binary.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index 3dec1883..3d920182 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -975,7 +975,7 @@ static int __cil_insert_type_rule(policydb_t *pdb, =
uint32_t kind, uint32_t src,
> >  {
> >         int rc =3D SEPOL_OK;
> >         avtab_key_t avtab_key;
> > -       avtab_datum_t avtab_datum;
> > +       avtab_datum_t avtab_datum =3D { .data =3D res, .xperms =3D NULL=
 };
> >         avtab_ptr_t existing;
> >
> >         avtab_key.source_type =3D src;
> > @@ -997,8 +997,6 @@ static int __cil_insert_type_rule(policydb_t *pdb, =
uint32_t kind, uint32_t src,
> >                 goto exit;
> >         }
> >
> > -       avtab_datum.data =3D res;
> > -
> >         existing =3D avtab_search_node(&pdb->te_avtab, &avtab_key);
> >         if (existing) {
> >                 /* Don't add duplicate type rule and warn if they confl=
ict.
> > @@ -1346,7 +1344,7 @@ static int __cil_insert_avrule(policydb_t *pdb, u=
int32_t kind, uint32_t src, uin
> >  {
> >         int rc =3D SEPOL_OK;
> >         avtab_key_t avtab_key;
> > -       avtab_datum_t avtab_datum;
> > +       avtab_datum_t avtab_datum =3D { .data =3D data, .xperms =3D NUL=
L };
> >         avtab_datum_t *avtab_dup =3D NULL;
> >
> >         avtab_key.source_type =3D src;
> > @@ -1372,7 +1370,6 @@ static int __cil_insert_avrule(policydb_t *pdb, u=
int32_t kind, uint32_t src, uin
> >         if (!cond_node) {
> >                 avtab_dup =3D avtab_search(&pdb->te_avtab, &avtab_key);
> >                 if (!avtab_dup) {
> > -                       avtab_datum.data =3D data;
> >                         rc =3D avtab_insert(&pdb->te_avtab, &avtab_key,=
 &avtab_datum);
> >                 } else {
> >                         if (kind =3D=3D CIL_AVRULE_DONTAUDIT)
> > @@ -1381,7 +1378,6 @@ static int __cil_insert_avrule(policydb_t *pdb, u=
int32_t kind, uint32_t src, uin
> >                                 avtab_dup->data |=3D data;
> >                 }
> >         } else {
> > -               avtab_datum.data =3D data;
> >                 rc =3D __cil_cond_insert_rule(&pdb->te_cond_avtab, &avt=
ab_key, &avtab_datum, cond_node, cond_flavor);
> >         }
> >
> > --
> > 2.47.0
> >
> >
