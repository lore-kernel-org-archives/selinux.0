Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D585927
	for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965161; cv=none; b=ayb7a2TCnsgNp50uMm2X6Ue6Lw04cudIILjoXP0nOp/aTEAIsKk24RctGWiAoWugAXRma3A5L70EPOkiZT8HCqk1ugOVjzmDPSaAmf4IZ5u9LTcpETz1CymbEJ7zuZCuJF1iinjVh9Mj7jKf179qMg0bi0ePBz5vfsSm19EDihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965161; c=relaxed/simple;
	bh=TzmpKjd12/LGzS3Lk7R5NBSQSonUHYl/Ju82ExsxypI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kf5k7kJ6SpC6CXn22+cZ6hBFIJSHhENyHQqys3iMvaaOm4LNWTA/aJaXNExvCsIQKa64V/A62miIe/TmCs0I8ZG6FmrStjpfdPxXJs9ASJET2PMoB8HftXPdGgwPvnHMR7Ddb5zow5MX7MIIuXoqKBz3c/y6IZY0AG3jImL/Svc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU4Ay5rH; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU4Ay5rH"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-609fb0450d8so2162857b3.0
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710965159; x=1711569959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13vuA3tC9HjZkFHl+1pNdwTjAtmYzMmOh+oHSsbUJPs=;
        b=UU4Ay5rH3V2DNlnA1xYuU1Aj3EIBippyXIj9EFokkZgWhCmxmOesIyKdVPFu9gDaHK
         vNP7/b6jw3HAphypVAYoGwGQU5OR9wZwas7ufMmUG5T4htr/Qb+C6HbtavMJeeAB6hwi
         Hqub53dModCatV4QQqHqFI2sgvjhRgvEswhFMy5Tei7sFTpE+prPnNYNezmDrFCmiDrG
         TXXP1U9HYovlljEU50fsvQCKipJM8LoxSYp/JSweHP5qpwbcC5wXi9xf9asqWie/n55I
         x2bhCwSkaL8O/yMSCB4K1zCuhgvOc7AkjcwpPJZ+slQj2aaQxlX+1/gzKoHCos7xugLB
         ELaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965159; x=1711569959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13vuA3tC9HjZkFHl+1pNdwTjAtmYzMmOh+oHSsbUJPs=;
        b=ugiC93k0wNns5VnarNXGuAKl16ZJ9F6GxZMDAw7H/N+SYyC8eOLyL7jHDEkDUOkhDX
         oN9FyYLS+VALCT7qXKct0d5Dpk1PbArtqXhBKksBrxrK4a3L4FyBycTKbvTbmQXHpa17
         qJ698gvlnyDQr86ubgTpjoZLOM/h9HJ43xKddgHEZJ7LpFB0QAox/nwsky0jycpOpeKP
         0y+v5oEwcSbxbhyZQz/MmkiLwZIaxDDgwM0TubfZVA65rIezIbG5kZ8SsV/I0M35exlA
         Amy2xCLEWygPa8CpIEf4WeOm4ToHRrUl+bp2iBYvMivbV5ubJ/rLlCuDNeIFSAQdgwhH
         sKFw==
X-Gm-Message-State: AOJu0Yx+G3Boje6kfCoxz4Avp7iP7V2Dr7vGG3Y+F6qgSh/y/0rsk6i4
	IfMkXZST6jZ+QBCQdsoHuxDK3XL1g2iV9fUwhH4YVfbMZcCAo976ccruLqtWjlo1vt8FcFuYjiJ
	6d2hb9bXnDesX42EvEHpsypjnl2ApRpGY
X-Google-Smtp-Source: AGHT+IHhbKeMfszZEZQ2m6dhDx3zCcg4FhRG1u+MBMfE8eiR9xwjZs3Rtj7D6WFyTYZRhed/3L3r54mqS6zfRvvq2X0=
X-Received: by 2002:a0d:f905:0:b0:608:13ee:8f3f with SMTP id
 j5-20020a0df905000000b0060813ee8f3fmr3210442ywf.27.1710965157758; Wed, 20 Mar
 2024 13:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311145706.34885-1-cgzones@googlemail.com> <CAP+JOzQ7BspHg7ZMQs2WSJQ0RDdz=hjSB=DohU6KZvQhLOyG-g@mail.gmail.com>
In-Reply-To: <CAP+JOzQ7BspHg7ZMQs2WSJQ0RDdz=hjSB=DohU6KZvQhLOyG-g@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 Mar 2024 16:05:46 -0400
Message-ID: <CAP+JOzTO_HLCvDrpi4NE8MFPsZ0gw9VikCYQgA+6piuiOXws9w@mail.gmail.com>
Subject: Re: [PATCH 1/5] checkpolicy/fuzz: drop redundant notdefined check
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:19=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Mar 11, 2024 at 10:59=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The level_datum_t member notdefined is checked to be 1 during validatio=
n
> > and the fuzzer calls policydb_validate().
> > Drop the redundant check (as announced in the TODO).
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these 5 patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These 5 patches have been merged.
Thanks,
Jim

> > ---
> >  checkpolicy/fuzz/checkpolicy-fuzzer.c | 17 -----------------
> >  1 file changed, 17 deletions(-)
> >
> > diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/c=
heckpolicy-fuzzer.c
> > index a3da0b57..f3a17cce 100644
> > --- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
> > +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> > @@ -130,21 +130,6 @@ static int read_source_policy(policydb_t *p, const=
 uint8_t *data, size_t size)
> >         return 0;
> >  }
> >
> > -static int check_level(hashtab_key_t key, hashtab_datum_t datum, void =
*arg __attribute__ ((unused)))
> > -{
> > -       const level_datum_t *levdatum =3D (level_datum_t *) datum;
> > -
> > -       // TODO: drop member defined if proven to be always set
> > -       if (!levdatum->isalias && levdatum->notdefined) {
> > -               fprintf(stderr,
> > -                       "Error:  sensitivity %s was not used in a level=
 definition!\n",
> > -                       key);
> > -               abort();
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> >  static int write_binary_policy(FILE *outfp, policydb_t *p)
> >  {
> >         struct policy_file pf;
> > @@ -198,8 +183,6 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, siz=
e_t size)
> >         if (read_source_policy(&parsepolicydb, data, size))
> >                 goto exit;
> >
> > -       (void) hashtab_map(parsepolicydb.p_levels.table, check_level, N=
ULL);
> > -
> >         if (parsepolicydb.policy_type =3D=3D POLICY_BASE) {
> >                 if (link_modules(NULL, &parsepolicydb, NULL, 0, VERBOSE=
))
> >                         goto exit;
> > --
> > 2.43.0
> >
> >
