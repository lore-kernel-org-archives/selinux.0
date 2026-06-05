Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54DD318146
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665243; cv=pass; b=lBNiNlV3fsOUxgz46QpCFnapIRRXCEKg6O08B9cK2CsBHF2pl1iSHz0PKieoHy6euuC9aTVmkzem0vrqRvcI2T+eb8ZNwpGJCAeh//AFP+mF2HUHBWLurqNMS0AQBYMuxwi22awFRX8KhZBr1pdySx7TuQSUDv7TxGgISgW+jXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665243; c=relaxed/simple;
	bh=nUjzFOM8eUKYh3mUICuKjpSdxon6C7ENTn7if0BEPgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPj0veaAgJ8ewkQechFXB93CkHNV33VsshT6tE0RcXRtl8lbxTEueuMpyGaNANkpfRatBNOwAoCbcykSI9Dnic2BSWuyH+k4pHgsqia2TtIUQ9wenhdMzRoEEryrRk1HjVJLXuv3pfB/yJTX5ZEjo3D5LL9TC6w+TwG4zO0InAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRSJoq9K; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRSJoq9K"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-396775c26f9so18177191fa.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780665240; cv=none;
        d=google.com; s=arc-20240605;
        b=YpNUsv7Y7n6JAWP++CqIbGezSrQ/9xNA/A1vLIk5l+hIoY8X/c6Y/5knO7JJoKWqKE
         k4qH2IndP82NfLSyeu6F4THD68oQktCCr17FH4gFiJDmxKwJxYWtjVTFirgJuv6HLhTj
         cATzilmr579d1WY4I+I05YiB1hTrgZrk+N/45ALnrWF9WOa+To5HdGKs6qtlwKTiz0nZ
         oKJaAOxCur9oLyPVa58QmJASQ08vfUsDNrhTjgtMJoV37KV0UkuW1EI7i/h1rpY6fiYG
         A4FPmWr42YKFBz3asC5lqABtNlL9PZ1A6PKAFJkq9S/6B22gBGOw9fZlse/NzwF3JAJ8
         tovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R/VPTaNLoEFN93WToqRVX2/KpYqaWCO+PqMFo/e7Nuw=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=cDee3fQZjCx833Zkvy9Zg/AKDcdzFl0qh2fUNToXX4Ea3k++8uYl36Swx0bziTFsSl
         PgtZwz765K8OK2Z7KQZddZLgiuFq6zUleaVLC1g6l6cZa+arbhVBuaZAexO+6+aeVRbJ
         V/X2xFGEOOHyhGZG67pKih1x0Udu3W0p+Xdkbf5iBMRxHxfOEKjQI06b6jwxkdKAFnEs
         YaqHxzLS+NtDajQZWLrVeqShCApWympuDu4bpHoorMQYS9HTQu001KHPdo+zZnSh3Go6
         N1UAaFELfEQimnNGXJUvOLyx1abz8hxSfuG8eJDynK8KhRVrLg3W6uZe1tl+xqgSfxh3
         PS2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780665240; x=1781270040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/VPTaNLoEFN93WToqRVX2/KpYqaWCO+PqMFo/e7Nuw=;
        b=GRSJoq9KObExA5VQ3cklS0uk1qVyrnMUkQG0pIkdLXrumQk4aJbo9fVE69L++v/EjA
         tkRWFhtpEMwqzMEV+BMRfJt+KLMpGCpyFf5VrEv6ItlPjj+WcDfeckAsgC8YgVYIoKLt
         GQWh6mFtqj6aOcXpd36GN2NC6pEVJloBFotlI8czv21EKIsi0Ovxsy8u5MjuXemielg1
         5AwDyiGw09RUucUGzvcuXSzGnhnS7bXzPK+pJ9RPl8Myzt1T4WcRdWnsfRMJyDlJaTkD
         uOpRqTqI5uQfKdUXMDEJmQPa9JJuy/oZ24Zrna+LJP4fx9gB0chblvV5VAJvV66VpP/x
         w3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780665240; x=1781270040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R/VPTaNLoEFN93WToqRVX2/KpYqaWCO+PqMFo/e7Nuw=;
        b=XV7zpnva6gGRpyObCYCwtNNfU+QDToNoIdpkNyUw2VzA8yXl2iQIqYdoWYFwe0DnDA
         nAYwgIB3u58rBuUQPhTiOjm4Ew/k9GdJ70uI3DEtwF2OGAsMOvkkfNGjHwrqbfWIBU1W
         TjNMbcp25bLBvmBqZmkDUJPCyw6/+1RcGECqTdxAYbPDMw22fnp8bgvCs/oxML5Ax//i
         Ht0vEhzMLECVjAFG6fuTWw8YUXPRmO0Ct12jcU47rJaGRVhmzkv+CedfNNvfQKF3/eIi
         QeMdJ9ums2MXo6Jmf4JoQhGwER6Pe/1UwByNxJKcFrFN9bbWR5JvnP3wubAsztuDzT1P
         +Geg==
X-Gm-Message-State: AOJu0Yxw7YQVbYDrvGTvTtmR7KWflFGkTbMbFLmNgfUEbcPlEZZwS+ye
	37Zw4kh0G9kxIUpAEaFpyW2GB1u1PkAmmXwA9ufvtSyqUU0Lo6XKhFvYK5KAm3IO5pjNX4SDB9r
	O2cSAQN0DTMhjjHu1/p5F3Hcb2GadAk4=
X-Gm-Gg: Acq92OHiVIrDamn9TNAh7oFTdJQboYwOOGi1MZqn2lyGBHPPKBfsJytJuQ8qsYXTIxo
	josLOuSEI5p5zWhREmesMQ6YgWkwInsPDMXjQHH9H2i0tsPhM7abGWz0k7QXJGiHqrM4YhlZoIm
	Jq6wrCXl0zHLgUTD/ziJFC2VKCkgGMcwaBUbjhImhLjkMiBOif5HwvaGYC6t4J63vodJQzBGSRS
	NgvJAyuoLH3FzO3StE01Cpr8Fpe4crKhQALssCPCiyaPh/OaVW/0y12N/YfVkDBHbnXD3JaXlx7
	0Oc76sWPhNluIl4=
X-Received: by 2002:a2e:be8c:0:b0:396:9630:5ed with SMTP id
 38308e7fff4ca-396d08aa2a4mr9088581fa.15.1780665239809; Fri, 05 Jun 2026
 06:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604201228.61342-1-jwcart2@gmail.com> <CAEjxPJ6k3CdqejBZ7s3m6d3wGd9CFMv_F5iHZRD+NgjxgLqabg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6k3CdqejBZ7s3m6d3wGd9CFMv_F5iHZRD+NgjxgLqabg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 09:13:48 -0400
X-Gm-Features: AVVi8Cf3_TJ6FQb5wk0scSlpZGXSRGVFe4_8io9Vxz0joq_UV8xasCsqjbvBltg
Message-ID: <CAP+JOzQN5i2Kqd5JXoa0DJObdMXb_+QwKbywM_0FLBBvJdfwwg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Ensure dst gets set when copying range transitions
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 7:57=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 4, 2026 at 4:19=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > If there are no range transition rules or an error occurs when
> > malloc'ing the first rule, dst will never get set.
> >
> > Set dst to NULL immiediately and when exiting upon an error after
> > the range transition rule list has been destroyed.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
Merged.
Jim

> > ---
> >  libsepol/src/link.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > index 004bb61a..70742fc8 100644
> > --- a/libsepol/src/link.c
> > +++ b/libsepol/src/link.c
> > @@ -1498,6 +1498,7 @@ static int copy_range_trans_list(range_trans_rule=
_t *rules,
> >  {
> >         range_trans_rule_t *rule, *new_rule =3D NULL;
> >
> > +       *dst =3D NULL;
> >         for (rule =3D rules; rule; rule =3D rule->next) {
> >                 new_rule =3D (range_trans_rule_t *)malloc(
> >                         sizeof(range_trans_rule_t));
> > @@ -1528,6 +1529,7 @@ static int copy_range_trans_list(range_trans_rule=
_t *rules,
> >  cleanup:
> >         ERR(state->handle, "Out of memory!");
> >         range_trans_rule_list_destroy(new_rule);
> > +       *dst =3D NULL;
> >         return -1;
> >  }
> >
> > --
> > 2.54.0
> >
> >
