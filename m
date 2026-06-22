Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0D3537C8
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160409; cv=pass; b=E8dYxzcMW4R5tDU0l3Mfms3mtHOh/EOBeK2qdZpEud0ZTtLOZoD4XzJZy1EJ+aOkRsxQsUrvfr5abepx/JUCbDhx6rNYSToCvX18AUEEY74CZ/1U60gPak6MaYlPVp/skVsghCXRYsJ5JjSX5c1NbHadyfzlWSBbU96qlT5nq/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160409; c=relaxed/simple;
	bh=ffdHi5ITWM73ttHnoeB3Twqi8s2VgCN4Fm6+cJAhTNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjl+8tq6QRWOfQPSBPH8MbMnsY8vsw1rCRN7hHNfMyAq/bCp+bRnhbw81sw9wDrX84+K+SiKj7BYxHYb5q5oGs+tSaV/zdDDINKlE58zRKXhamhWLEWF6PLF22xOVPUXgU51kqukDfWN2OlF+lgrpoE4OWu388zJ5oOUTe/C7ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=li2A4C3u; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li2A4C3u"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so3587225a91.1
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 13:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782160407; cv=none;
        d=google.com; s=arc-20240605;
        b=CTDLAzK7Np5xwE74fotfrBRTHW46PV9feBRiBeI1sGuPOmIXuwA2qL9ydLQB4KzYyi
         AASwznotC5t3Ky+B5IFfC05l3k292TkYTEQ9GnKd+3it5z9jGw074DbqL/RitrzPrguz
         iTN34sgIDDeQeYAEjO9UnovQojhrpWPrlaMJ9CTbjdYYeSLxZxswF4v0PJ3W3Mf6Zaly
         ieb8WAULxBn686wcSVe/6wo5WL9xpWC5ORQp2gH+D+/p01pb931T276auqq/X5OW09vZ
         NYGZUqaIk0l9jZYxVVqEv8kV+2G+uoU0m+23cRxGgbo2KAIgXlFww6l3GNFoKI3tal1A
         U6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ITVQOm2fTUlQCXbZz9SyuwGTypWj3ln8Zg46Go470js=;
        fh=jRyevUK2w2AHXbqDg68JL/TGkgAfqiBixLBAah9ARNM=;
        b=Gr0WxlfbMcH0OLyDQVrp/fSrz48aJass1ZyFj+ADXrIRW9G/A7ZVetxmMINDEhHZiE
         +myB96R9V1PT5mhRzSms9useqX2veW6uI08nXKLWKsrRa7Fi6WAbd5ihgTJvP+H60N+6
         63alvuX24bD1OV6fhSxmjpSToXkvKsaEoLSfIv46hPHi9gBlwdk6o1164ijRvLvVmXa1
         BxYELNCxmVrj0Jd9Qd6mS4fSwrrOulC+Rao8IgrHE/m6Cr24GyfZ1cMXoRqB81BxzJPV
         kgIsFB4uMeXs2DRS1+HksKDoLUxbKXIUfarWwlu8xPJ3bYCaMdF/m9OJomZwbU3tVp8O
         veQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782160407; x=1782765207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITVQOm2fTUlQCXbZz9SyuwGTypWj3ln8Zg46Go470js=;
        b=li2A4C3utmk1VQKLDKBmwgTKPHlWmxsCLnhGTVGMfKMwBgHGxBZ0No22How90wdajJ
         94TszzNPXLZYVIPzR5rlWT4FUN/wj6OdFvIcZKeMpoSAyv3Azg4nOZX8PXnQJGcCJkQe
         emDbKgGKS//iLTrwx8Qgd9Ifc62QWJETdFPD8NXul+utBU6jBGIpwP9pa48Lyx6br1ix
         xmJIM6/2Jw90JwhZEICubf7XJcHw4X4bi2OiLgsHbo69+66mVn4JOGiMdMCad0RIjZAO
         BEC1jKXIFjKsWqf2BIJ9mSKPCbuUDx50RdKYROlfnxuUzHkFQpR26QP/geQrlLlZT3vX
         PNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782160407; x=1782765207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITVQOm2fTUlQCXbZz9SyuwGTypWj3ln8Zg46Go470js=;
        b=HkmjgyqWW49YKrPXr9qE4onyiyKOeTPtgvkeNVSeROaARUt+OK5Nlr+Nkqmhum0Tq3
         G+iH0XxszoZKCJUxldrFx4RYhhcXFBfPKG/C1Au6OD/u9Wnj1ajF4j1pO3+iNq/3vLSR
         Mzyswgadl1j2Lj8YHMnv3uM1Xgaq6MmFfnDLg9lc30PKYtGJFocufS2Z82FIuRquiX2I
         j2X1iva/c4uv0Xfd7zGPvIH0HvUj9yUZWPeZBFky6dVdBKwVNERGE4Oo2VngtYCymafo
         9y5WvzDFIgIYN0Rc5vaKZlTyHfS88Ph4EWfSigWmKF74JJpk8j09HVVCi9Pxvw3UH5zu
         vPqQ==
X-Gm-Message-State: AOJu0YwkBNkSzzorO0U/woFQ827Vwk9JfEq9UlutIAQwzlbP8I5yeicV
	kE0Gum9feEO61UC5mkJteokWgZFaIjCBRqn1qbSIvqTi14Tv6U+wO3bvpP2aaC4sGkuqZBW6tcz
	AXYk4nT6qvQh9GRsY4oqDmCQ+QLe9pco=
X-Gm-Gg: AfdE7cmd/sHTeyV/VOYHvNyZZst60LkLe7WFMK8KTIdSFNC3ZtAxwM/sN3lSX4xVd2K
	s3VCqryAmSPWt3Wqr8QLdOQ7czcs4YBjMDBmEXQNqOt+k7HWUGU7ptjCmT+N0wp2NQu9IM2DRfg
	Z7QqGD+99iSKXnFs6UmLqg2/QsGxDkVgStGcZw0tEp2cjiKhfjdF3hKk5aLl0IEu45cFUBUi96O
	oy0xwJqMBe1G2v0oOEcGuXVDw40HZGxvWYZtF6K+BvB5ZnYSMRMhNaKQmqdb1+O0jyJbCC2
X-Received: by 2002:a05:6a21:d8c:b0:3b4:605c:2163 with SMTP id
 adf61e73a8af0-3bb32204417mr18019641637.4.1782160407556; Mon, 22 Jun 2026
 13:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622153325.17783-1-stephen.smalley.work@gmail.com> <CAP+JOzQT+NMiFncd3A5Yut_0J0m0FzbZ1YnmEkg0jOmdSxQ5SQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQT+NMiFncd3A5Yut_0J0m0FzbZ1YnmEkg0jOmdSxQ5SQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 16:33:16 -0400
X-Gm-Features: AVVi8CdVzaqczKixIsedwr7ELLXvkpuOOTXMM851wF_a8wamBqhdCeRcrpnrFhQ
Message-ID: <CAEjxPJ4WMoBMgA44X94QB9PgO7eJor30TfpetKUeJ4OZnjQGbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libsepol: bound type values in type_set_expand
 negset loop
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 2:38=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jun 22, 2026 at 11:33=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: netliomax25-code <netliomax25@gmail.com>
> >
> > type_set_expand() iterates set->negset and dereferences
> > p->type_val_to_struct[i] for each set bit without checking i against
> > p->p_types.nprim. type_val_to_struct is allocated with nprim entries, a=
nd
> > the sibling loop over set->types already guards the index with that sam=
e
> > nprim check. For a base or module policy, role_read() fills role->types
> > (including negset) from the file via type_set_read(), and
> > policydb_index_others() expands it through policydb_role_cache() and
> > type_set_expand() during policydb_read(), before policydb_validate()
> > runs. A policy whose role negset has a bit at or above nprim then cause=
s
> > an out-of-bounds read of type_val_to_struct. Apply the same bound to th=
e
> > negset loop. The single fix also covers the other callers, expand_rule(=
)
> > and expand_convert_type_set().
> >
> > Fixes: https://github.com/SELinuxProject/selinux/pull/532
> > Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Both merged.

>
> > ---
> >  libsepol/src/expand.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 0bd61c82..8d7fe519 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -2783,6 +2783,13 @@ int type_set_expand(type_set_t *set, ebitmap_t *=
t, policydb_t *p,
> >         /* Now do the same thing for negset */
> >         ebitmap_init(&neg_types);
> >         ebitmap_for_each_positive_bit(&set->negset, tnode, i) {
> > +               /*
> > +                * invalid policies might have more types set in the eb=
itmap than
> > +                * what's available in the type_val_to_struct mapping
> > +                */
> > +               if (i >=3D p->p_types.nprim)
> > +                       goto err_neg;
> > +
> >                 if (p->type_val_to_struct[i] &&
> >                     p->type_val_to_struct[i]->flavor =3D=3D TYPE_ATTRIB=
) {
> >                         if (ebitmap_union(&neg_types,
> > --
> > 2.54.0
> >
