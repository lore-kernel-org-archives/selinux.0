Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D628DEE4
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076604; cv=none; b=XwobLTQbzCeSWkc6aGj0GIgo2knHx/XgO4bjc7aff5zev98XhN8IDclX4OpzkPINH9HWEDaaVN95eLRJCWj0lQojItxvB7CDyHXN86h0WeVnng5HQigqd5GwQi8jztbP4putk5izUtvV0xdfIOvbhwMHj4zIAtpcYjp1/fhJSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076604; c=relaxed/simple;
	bh=hA4NKIYyxSIHjMoqbXO3rA8bV7CEkDCpC0DBeMHKdp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfL/lTSdsQt6rT0guEKLoJwWxYnI+xJe2VZPSO4GhfMNtdPEMU9G9k16IaYETsQX2EFe2GiwP/FrvziXn8wI0WcqFPAp/9AlajbPsPbW9cOKYP0+BK7jGTwKsrOIWRHBJ+GiYVl1/Qv1aF92rPZem9O/s2HwPZLqN1WFNCaCgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5uBrqbE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5uBrqbE"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31c4a546cc2so1235211a91.2
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754076602; x=1754681402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el+HHVdTtpru7Nv20EaX2im7fiFClRfBUe5QPnCQOCk=;
        b=V5uBrqbEA7dVYb/H1DyRQy0RIjMcQ7NjvXoDJATy1NeGK6EkKGcThecv7VrQQof1mm
         2zyqb4HIr+Mv76EEC/yN5LVbSUiPo6fzmXihvcYqu7FGSddVb3LV4tmLyn4qZBoiEcVs
         +MIhSMhhfU+SpEva7IiNwfxpp7iRdEn28eOBwMuaKBCsuA/66s7Z/S705brCoH4/FP9N
         wBi599TP7GduNiv7d2W0HzqFXRWhacDL6EoBGGRy3dtSgywxLwxczKrHqKJEK+IuUE9t
         fo6ng0nYswNLYeZBeQOZLO3CR8R7TS676KbgwnnFnqXTd+nMbVT35zZaWryr+MkgzrAx
         TRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754076602; x=1754681402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=el+HHVdTtpru7Nv20EaX2im7fiFClRfBUe5QPnCQOCk=;
        b=HqBNsM+uRSEQEmgF5KgAlSwsy4E3FmOZn5cvgzSh5hNpxZUZwRGiGE3bZDmFcCdVxo
         Y+pGrVUV2FoHC/O0smtLJfI3j4bpTxGw7culEEPFX4+Qh3UsEvlj6Qdre4TDQOkuAF5f
         k+CXZbzbD5E0suUHheakkNXiRGu/tagUAOeA8Lm+Hs2lmex9jy3LHffewRdLGAFnu+uK
         PtlMPq/m0PRdc6PtJl5PoK68Ana7URu7pLZw43QubdOl/IDMwlgIwGQIr3tWWDUko1jL
         HCOPA6RUaPrlh3QsvjoMsIFE5X6vcZ+NibU/R+mvkinIE55Q5YV0tveNhTXfwvQkM7Cq
         bCNg==
X-Gm-Message-State: AOJu0YwFM6KSJA9wB1/p/yGwZgSI8TdUBc3XhMvq4kzwoyABxVKdJpRS
	mV2lhJxcEo+IeWp9xi6ZonxHSMVzy6l41Fw8uxftYGJkRbkp/3jhtL1K1IwTLFAJmccyuwKA6TU
	IwY6Ho7Dh0KRKrCt3Z2H3p+NvVTgYevc=
X-Gm-Gg: ASbGncusNtaK8Ayzqvkys65Ely0OFRRYcC5/iys6Ehwc9cNghgOIEfA1bGkZG44/W5A
	QTgzg4pgbDv5cO6NSVnEKBeFX1ilNtmGVs5vBQ/IxnszBaNWF5knpE/lCJJOikStXg3rwKw9f7A
	GMYppoKqB2JjHlhf7F2hukvAvlwrI6EgMs5bmNMaiWoiKVuMq1v3bwYkGYceRV5SFotADgYIQEx
	y64PLU=
X-Google-Smtp-Source: AGHT+IE8MHZx9eMimHRVT/upkGABjWoZirqz236bzXrCD/ZTG5kOGa453biD7b5sZ5l2D86mraBc21BZyiDJAXg0a30=
X-Received: by 2002:a17:90b:3b81:b0:31e:c8fc:e630 with SMTP id
 98e67ed59e1d1-321162d29b8mr1198976a91.26.1754076601503; Fri, 01 Aug 2025
 12:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801154637.143931-1-danieldurning.work@gmail.com> <CAEjxPJ799AYzKGMJr5vmcP+b_ikPncy-vwaKZudRMRokwyuXMQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ799AYzKGMJr5vmcP+b_ikPncy-vwaKZudRMRokwyuXMQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 Aug 2025 15:29:50 -0400
X-Gm-Features: Ac12FXxTbbeUnvXxX3gKvuzAesorZpqCw94CpjOPUFEFDMEgrgIvOwoTdcfmnJ4
Message-ID: <CAEjxPJ7d=LJ=Rxyiy6TpjEETVhkAkKxJci0Hog1v+55V8jvpdw@mail.gmail.com>
Subject: Re: [PATCH] selinux: implement bpf_token_cmd and bpf_token_capable hooks
To: danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 2:38=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 1, 2025 at 11:49=E2=80=AFAM <danieldurning.work@gmail.com> wr=
ote:
> >
> > From: Daniel Durning <danieldurning.work@gmail.com>
> >
> > Implement bpf_token_cmd and bpf_token_capable hooks for SELinux.
> > For both hooks we check against the token SID, to support
> > delegation. We could add a further check based on process SID
> > when the token is first created.
>
> I agree with the approach - it is consistent with how tokens are used.
> I suppose we could perform a process-based check in
> selinux_bpf_token_create() if it was generic, or add one to each of
> these hooks if we want a different permission for different cmd or cap
> values.

Ah, actually that doesn't look viable at least for the token capable
checks, since those look like they can occur from outside of process
context if I am reading the code correctly.

>
> We may need to wrap these checks with a new policy capability (see
> security/selinux/include/policycap.h and related code) to avoid
> breaking compatibility on existing systems using BPF tokens, if any.
>
> >
> > Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> > ---
> >  security/selinux/hooks.c | 48 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 335fbf76cdd2..bffddffe0b25 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -7154,6 +7154,52 @@ static void selinux_bpf_token_free(struct bpf_to=
ken *token)
> >         token->security =3D NULL;
> >         kfree(bpfsec);
> >  }
> > +
> > +static int selinux_bpf_token_cmd(const struct bpf_token *token, enum b=
pf_cmd cmd)
> > +{
> > +       struct bpf_security_struct *bpfsec =3D token->security;
> > +       u32 sid =3D bpfsec->sid;
> > +       int ret;
> > +
> > +       switch (cmd) {
> > +       case BPF_MAP_CREATE:
> > +               ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_C=
REATE,
> > +                                  NULL);
> > +               break;
> > +       case BPF_PROG_LOAD:
> > +               ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__PROG_=
LOAD,
> > +                                  NULL);
> > +               break;
> > +       default:
> > +               ret =3D 0;
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int selinux_bpf_token_capable(const struct bpf_token *token, in=
t cap)
> > +{
> > +       u16 sclass;
> > +       struct bpf_security_struct *bpfsec =3D token->security;
> > +       u32 sid =3D bpfsec->sid;
> > +       u32 av =3D CAP_TO_MASK(cap);
> > +
> > +       switch (CAP_TO_INDEX(cap)) {
> > +       case 0:
> > +               sclass =3D SECCLASS_CAP_USERNS;
> > +               break;
> > +       case 1:
> > +               sclass =3D SECCLASS_CAP2_USERNS;
> > +               break;
> > +       default:
> > +               pr_err("SELinux:  out of range capability %d\n", cap);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return avc_has_perm(sid, sid, sclass, av, NULL);
> > +}
> > +
> >  #endif
> >
> >  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
> > @@ -7525,6 +7571,8 @@ static struct security_hook_list selinux_hooks[] =
__ro_after_init =3D {
> >         LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
> >         LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
> >         LSM_HOOK_INIT(bpf_token_free, selinux_bpf_token_free),
> > +       LSM_HOOK_INIT(bpf_token_cmd, selinux_bpf_token_cmd),
> > +       LSM_HOOK_INIT(bpf_token_capable, selinux_bpf_token_capable),
> >  #endif
> >
> >  #ifdef CONFIG_PERF_EVENTS
> > --
> > 2.50.1
> >
