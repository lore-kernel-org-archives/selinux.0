Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEFF624
	for <selinux@vger.kernel.org>; Wed,  5 Jun 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611873; cv=none; b=CbP4txKEM3FCYHy5VQSZt+9l3IaoOdpYLQy9bv7vnfOCiUVw+blKt1jUFl/N/7jZXJnUh+t6nfQ1MI7lrezbWs19S6xVzl0gXaCrchzNpdGb12gZi9ZpWGi87W1RRp8ru14+25AIyAySlUMmp49283TCv66qdlk/exnMaCSuBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611873; c=relaxed/simple;
	bh=5qvz+KhrJISCa/kDOuz8uCBm4to/oQZhBQuwazfDWWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2adEv7ampNvqINcAVWri9hBvAG7O/EMmbL7zKuTn4iQizc+wQTMyalwVav1oqnBukC3nD4MlWQFolWeRaRRhgS/P+fAkihnt9gklVbCxVxUW9sQE+tiwDZNTAYKtekKh4SHYeTWsL6b5eeTxM+Bww0s+8NkKsBbaXpI2ZRc6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yin2Q5Vv; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yin2Q5Vv"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4eb076bec24so46768e0c.1
        for <selinux@vger.kernel.org>; Wed, 05 Jun 2024 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717611871; x=1718216671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVFPwbjwzM/6dUrrFSqBV+JA3ViMvqmz+1v8FAon2/g=;
        b=Yin2Q5VvxknfDzNl+xAgaLuNPP12Y1OJl5Fx0Y7RQR8pwDyCh8Do4zQViWH2KXbOmb
         LJp2Mh1gZir/DeLsz+Shbe4KN4HPTllbLEzBfIsiioBADgxfOl+2H8/FMrxXSGrVTQ8J
         ZwNNAbHJMj2UxxcFZKIAOwsHezI3vIx1upvnNQKZnuCdbOlm5wGamVoWDt+14iRBa+m5
         8Q3P48gdrl0D9XQrOifR32hrMGQi2cUMpOgqA+357Vt1AwYOJHu4Oj826MPOilZLkqZH
         e3ybdtiPaGtDpOj9yJ9WsLIQql58/OgGtr/ujQmbB1coplzvob8EDBvnK+9E9BG+yMMC
         RJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717611871; x=1718216671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVFPwbjwzM/6dUrrFSqBV+JA3ViMvqmz+1v8FAon2/g=;
        b=YXxVT9zVmWo3ff+Aw6vQ7QvEO+Pd49J6Lcl7Bf4AI9TtIE6dXdM0XmNIoC7d1FmhWM
         8E+b4ay5SruiswMfu4Nx9JNWsmDE9dtjni+IxeqgnFBG3SH9kYkquaCuIS0T3QeRfAvH
         h4VBn438Nko2y5VwkH+dmVGO+c88OM3C4zWs6vXJsQuu1lLxA6S5Dy4jXhnH6rJKWvB+
         6MxJan7HTo4rdG+JNggVNncCTChnt6zz8ZnmtMP7mvkC2jUg4kaWkj3VXn+1URcpmKzp
         jGPMNQdloUiz8YY+whhIMUkU7vOZw2lyyHGQeM3QiHxQUBmlRSss5iMvydYza524NOqR
         SI4g==
X-Forwarded-Encrypted: i=1; AJvYcCXp8pDaSO8r1hvl3qkCqB6ol/+lxiOZCdS+5MteuYyrz+28DWpWnMDHII5u3p/boklIde+tTyX2xhpile395MxN8V8Srd4hvw==
X-Gm-Message-State: AOJu0YyHgiZTtJgzzjvYbvmO4z+7ZjCjhiSpczjD/2UN3RsMtm5cvPTU
	HHKsdDP8127uAsgbeUMwvwNGxu6zvcWSw+NRyvQLJTgFebRlHhhza13wGYJKsP7vKwR3FhvX55V
	Rd6vMTnTCGijtubIMrEw+sEbko9A=
X-Google-Smtp-Source: AGHT+IE1mSCiUYU4tie7MvxKkpnW59nv6QCvkN6xLB9MIuZQLuGfKvEbs+PalTjM1Z8VZVVs/jkUqIfUWRpJDLUfql0=
X-Received: by 2002:a05:6122:3683:b0:4ea:feca:6c67 with SMTP id
 71dfb90a1353d-4eb3a517130mr4371816e0c.16.1717611870712; Wed, 05 Jun 2024
 11:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-11-cgzones@googlemail.com> <871q5be1cl.fsf@redhat.com>
In-Reply-To: <871q5be1cl.fsf@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 5 Jun 2024 14:24:19 -0400
Message-ID: <CAP+JOzT8Oncxa-WNYFqP9xNUuxZusnoeb45cDMSZmzyvQeFjBQ@mail.gmail.com>
Subject: Re: [PATCH 11/15] checkpolicy: fix use-after-free on invalid sens alias
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 1:38=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
> > During compilation sensitivity aliases share the level with their prime
> > sensitivity, until after the level has been fully defined they are
> > deduplicated.  If an error happens by that time the cleanup will free
> > the shared level multiple times, leading to a use-after-free.
> >
> > Make use of the added new member of the struct level_datum.
> >
> > Example policy:
> >
> >     class c sid e class c{i}sensitivity S alias L;
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
>
> This patch seems to be skipped/missed. Others in this series were merged
> or commented.
>
> Petr
>

We ended up going a different direction than this patch. I didn't like
adding another field to the level_datum struct and we eventually ended
up changing the "defined" field to "notdefined" and reworking things
in a better way.
See commit:
fe16f586d5e1da78e4374fdd5ff938524dd792d0

Thanks,
Jim

>
> > ---
> >  checkpolicy/fuzz/checkpolicy-fuzzer.c | 7 +++++++
> >  checkpolicy/policy_define.c           | 3 +++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/c=
heckpolicy-fuzzer.c
> > index 0d749a02..d0221f3f 100644
> > --- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
> > +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> > @@ -134,6 +134,13 @@ static int check_level(hashtab_key_t key, hashtab_=
datum_t datum, void *arg __att
> >  {
> >       const level_datum_t *levdatum =3D (level_datum_t *) datum;
> >
> > +     if (levdatum->copy) {
> > +             fprintf(stderr,
> > +                     "Error:  sensitivity %s is still a copy!\n",
> > +                     key);
> > +             abort();
> > +     }
> > +
> >       // TODO: drop member defined if proven to be always set
> >       if (!levdatum->isalias && !levdatum->defined) {
> >               fprintf(stderr,
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 44236797..360cff68 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -756,6 +756,7 @@ int define_sens(void)
> >       }
> >       level_datum_init(datum);
> >       datum->isalias =3D FALSE;
> > +     datum->copy =3D FALSE;
> >       datum->level =3D level;
> >
> >       ret =3D declare_symbol(SYM_LEVELS, id, datum, &value, &value);
> > @@ -795,6 +796,7 @@ int define_sens(void)
> >               }
> >               level_datum_init(aliasdatum);
> >               aliasdatum->isalias =3D TRUE;
> > +             aliasdatum->copy =3D TRUE;
> >               aliasdatum->level =3D level;
> >
> >               ret =3D declare_symbol(SYM_LEVELS, id, aliasdatum, NULL, =
&value);
> > @@ -1035,6 +1037,7 @@ static int clone_level(hashtab_key_t key __attrib=
ute__ ((unused)), hashtab_datum
> >                       return -1;
> >               }
> >               levdatum->level =3D newlevel;
> > +             levdatum->copy =3D FALSE;
> >       }
> >       return 0;
> >  }
> > --
> > 2.43.0
>
>
