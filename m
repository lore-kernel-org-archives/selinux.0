Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F57101DB
	for <selinux@vger.kernel.org>; Thu,  4 Apr 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247821; cv=none; b=bUffVTvqTKbPAhgQ6QAQkBFHvElSBWTElFbdMKSUSVowSCXgO+gPKYzroODE6qfNnp28+iTlY+1gnw1cvEPP4hO9eQoH7TzphxJRab60Rr7jYoq18TYDr+P+7tQ4ifM/U23bH3WPN8rRwDdt6HkccJgNlt5NjwZjruiYJNM+Ed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247821; c=relaxed/simple;
	bh=wk8pbwn125LZ3Y1r6/e83o6f3IXsAaaEVlMKBHjFfw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iu3FFqnYppxxGrKQ76jxWVRMVCI9+P/NGdhFI2lXPbcEEfmbSidm5iuNFfSnkaqhpVm4MLzREGOA5w2inuKrveQcW8AHLRgUJFBz2ekMsRiJ2L1bTNsnlsl1TgLLJcZP3znBfYikYfTUGp3knizE9APrEtSf+LtI9OFiGJw+eEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7Xj9der; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7Xj9der"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-479c3616fceso377773137.3
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2024 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712247819; x=1712852619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QETQDs8yy2cqYA123elZGPGcV3x84ynFTQH8eTVtIGI=;
        b=Z7Xj9dertdnAS1E1bBcny/HplViprttY1aQC6UkKPidLLCXid+i/G2E4OwuvW+cj/k
         I0kdSpgFDL1zsDZO4BwOLX088oxQsN8Q8ekLfVr5etSd7YqMpU7GeOTz6Q1VBxN63JZ+
         5wHRo45bi/rjhqQRjI39gWeix+FAfFIhVB5J5OVhv38bFcprvfY1WJ7nr2pjV0t+KFex
         ALGOwgkPBsre/HJ6aXAsfif17Y4599lXgQj6D+vGJJuqP8YGuERdmC8BtV45N22pYlZl
         0voQ4z4zJ0faYXlEe5vcMInKA10OvVdvjx1nhpCUIZuAqGCDIXFzMKRVtIeP/GQdIFs6
         ZM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247819; x=1712852619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QETQDs8yy2cqYA123elZGPGcV3x84ynFTQH8eTVtIGI=;
        b=FhXwkpYOu1u8FtYi0aumbLO0l+H9jvauwRIbeAZChquVcFO5sj8gKr1n9uNnhh7s82
         uyni9qOzlOcEcCatUNXtZT9M9sHqE12Bv1mzYj+TocUdSfr8i8xofR9nV0oUJpDUEeqt
         iIlzKT53fzxorS8nRGiJkHVcQ9ryVIFC0yrvsJC+4BVyH1JELI4NYL/5oRHMCdNbf1ah
         K4D1J//KTD9LIU+m8jq5Hv/odoE8of9YuMltePWTQbs+5j9XCq3GUZkHS0Fd7Fk/5Z1H
         AclVweSL24XZi82gXgbCqPT2i2ETk4QX7x+uanmjyi0fTsD5Cfz3y3t0SyEKpsF5kc6N
         PiVA==
X-Gm-Message-State: AOJu0YwSiBQPRONM4ZNuxjwrIDzyELU8MUE60TAn7drHMBvi1Ep2nLhB
	G9ZaE+x8+fAS62Ps2MghDPoWG0+RAoWCCxqQMpxVf5F4Hv1Duq+ruPhUaNHphS/Rxf1baf80RAI
	uAdlndz1hnwuMbWUp92vUWjm8EjE=
X-Google-Smtp-Source: AGHT+IGMPWy5YynmR9/gFHcQWMpTslrvD3zQdWBKNcx4XaTys6nCQVmnU7F6u9QCcyj5+CfgHFGytlg95mc8bUeYEAM=
X-Received: by 2002:a05:6102:954:b0:479:d42d:f92e with SMTP id
 a20-20020a056102095400b00479d42df92emr1417323vsi.24.1712247818682; Thu, 04
 Apr 2024 09:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402154238.104378-1-cgoettsche@seltendoof.de> <CAP+JOzQ9eHY6TxmSB+uDwB0wWvRiNSZ8_KpzQKjo14yve_zxwg@mail.gmail.com>
In-Reply-To: <CAP+JOzQ9eHY6TxmSB+uDwB0wWvRiNSZ8_KpzQKjo14yve_zxwg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 4 Apr 2024 12:23:23 -0400
Message-ID: <CAP+JOzT+6jsx9A1Rz5WvP3ctvWzhH5dj8Kt4C4HGBxnoLPaRqg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: constify function pointer arrays
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:51=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Tue, Apr 2, 2024 at 11:46=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The function pointer arrays are never changed, declare them const.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/policydb.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index 0c23a7a2..49f9e8af 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -1126,7 +1126,7 @@ static int cat_index(hashtab_key_t key, hashtab_d=
atum_t datum, void *datap)
> >         return 0;
> >  }
> >
> > -static int (*index_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t dat=
um,
> > +static int (*const index_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum=
_t datum,
> >                                 void *datap) =3D {
> >  common_index, class_index, role_index, type_index, user_index,
> >             cond_index_bool, sens_index, cat_index,};
> > @@ -1409,7 +1409,7 @@ static int cat_destroy(hashtab_key_t key, hashtab=
_datum_t datum, void *p
> >         return 0;
> >  }
> >
> > -static int (*destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t d=
atum,
> > +static int (*const destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_dat=
um_t datum,
> >                                   void *datap) =3D {
> >  common_destroy, class_destroy, role_destroy, type_destroy, user_destro=
y,
> >             cond_destroy_bool, sens_destroy, cat_destroy,};
> > @@ -3410,7 +3410,7 @@ static int cat_read(policydb_t * p
> >         return -1;
> >  }
> >
> > -static int (*read_f[SYM_NUM]) (policydb_t * p, hashtab_t h,
> > +static int (*const read_f[SYM_NUM]) (policydb_t * p, hashtab_t h,
> >                                struct policy_file * fp) =3D {
> >  common_read, class_read, role_read, type_read, user_read,
> >             cond_read_bool, sens_read, cat_read,};
> > --
> > 2.43.0
> >
> >
