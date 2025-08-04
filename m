Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2781265CAB
	for <selinux@vger.kernel.org>; Mon,  4 Aug 2025 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313665; cv=none; b=Wd5Cgbe+ierEMyUOJUNM0D7H/k6e81w/JJ0533xOcagqAILon0Er22QR4HhwFZlTdHp0pFD/fwwu9RSQdIGsStC8sm2VZwh8Ei0pAfDWua6PooCGqvyZxhmg4ABg023dbOhZcj48i0oVxOmqSTsul/6sN+1Bn8hY/F+PQzFQ4bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313665; c=relaxed/simple;
	bh=V5EIAmaoGA+U3/42D4NmHLPM5UJnEraLyfTOV+TXdSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4S+bLYrVPY2M+nTi3T8nNXXzxpC24i4JvGXxBCc99Sqh1LCUdY2pH1lXS3YXNYtqnQHZvkmhs/37J8uqRoSe/ELg22VJ4VkDgqgrwe7LGA7/fR9qvPYH1LAHyzPDJCpabMeFIunXHAkARcbkgi/oaivwem0BYB8i3tmP7eJkeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjQmKw+M; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjQmKw+M"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32106b0930eso3034358a91.0
        for <selinux@vger.kernel.org>; Mon, 04 Aug 2025 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754313663; x=1754918463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uot8t5TccdK2R8Q6qYcThEbnZh2Gm1OB2846Q43Ufns=;
        b=KjQmKw+M8L7+ha5rXUGzASsTHoo/zE9cjKzvxkfZeTqT80HsduLb4Vb4WtFhRMd6oa
         +XTrxQ9TxOfP9iQzEeDJNd4QATB+huP68xJ1s23VsFAQzbIMSZMz/DvhxagDRtWz11YP
         nXa65gaHV0CKqv0mEnAspPcZAA9ZAvER1fVyRuvRbYvaxc0zvoZTBEXBaXx9iPvY62bN
         8+FN6GHAYhp3ottcvHyhkKH0BjL63zxcvyDub1CNqMwplonA6wS2DktLTdQ4imcsHVJN
         BBx+R+HffBEkK3xGUUqxS95l2o72uSRmZBcCKPMmT7/mUIpqVHr/Vybzkq193aXepsYi
         vWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754313663; x=1754918463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uot8t5TccdK2R8Q6qYcThEbnZh2Gm1OB2846Q43Ufns=;
        b=JhEbeJ2OvshOfE9nCurjcevYhVUeO7nd8qZLIvFAEM596KoqNDxnBeBxeDw8VTtDSF
         b2g4XI5gvJ2qxgxlEvBSmtHdtFgWec0nCulq3FyrXK0bspjNFDBJ5w9MyPI4pFS+Q3nQ
         9O3vwS8Ag5FI57ppVE8O05Lf0NuQj67uk7lkgY/QLjMYgBvZO1WAPrJeNcNBElRur0Bw
         baNGFBSeUheADYJRpVHPrh+FZuzuDAt3fHt2i4Bat2DYhYLsw/DC4naHzn70GwwxGwxC
         AXdkQ27MyT0vQccemYtWuM/+MDb//pB1h/hA3FPbE6WRbQycuPSE64D451EMKtRzu7ra
         wXcQ==
X-Gm-Message-State: AOJu0YwOSRiFziNKmQZ1kHs3sW/1zWdIf3x57gpyDnTGAmDZ3OguwgYT
	gAvkcrCs2x4RgjLqANOtuJsy14rHVdQoiWDcBu8N474NjWIR8uyA938OE5wNpC15evrnIzHDQI1
	req1e99G/LiaFrrIdmOnVJSHs13i38xY=
X-Gm-Gg: ASbGnctZVzZ5fT6Y/90Kg7VmvKgi/ejWcAUrKgRZ2sLwxb2xi66zy5oE6qhX5Ooe1xs
	Td4BNfPSEDefjfpoGt7lhJPMuRjWDJba/BoiC/KZ7Nh9DqG+Cbuui9Xr9/FkzQ+wDSRbbD6yheT
	7MghapVYljmeVPbXqNgucloeTwMd2HI28r2Mg78UJhBgWXbiSWrNh/6+bQwlxGU3HL/wDlSlhU8
	lpb9ze+zqdwBdWtjg==
X-Google-Smtp-Source: AGHT+IE3GKEQI+xrBiffpsleoqIvp6GcsEMbAfsyo8jVJ2OMmeaiulgc5PdxLGPhSoz6/97SShug16uHZA2IJ6V3E8E=
X-Received: by 2002:a17:90b:1d8b:b0:321:2160:bf76 with SMTP id
 98e67ed59e1d1-3212160c1c8mr8625105a91.25.1754313662984; Mon, 04 Aug 2025
 06:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801154637.143931-1-danieldurning.work@gmail.com> <CAEjxPJ799AYzKGMJr5vmcP+b_ikPncy-vwaKZudRMRokwyuXMQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ799AYzKGMJr5vmcP+b_ikPncy-vwaKZudRMRokwyuXMQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 4 Aug 2025 09:20:51 -0400
X-Gm-Features: Ac12FXwcHt7Ozs4TeDK6BBsOQUjL-X1FjwO5bTgeRuFV84gC9aKq7QeZhLh_JrU
Message-ID: <CAEjxPJ7yg=0mCMLLWdzS5qRUhQZ3Juc_wv8ZEPKf9uY-zSTs4A@mail.gmail.com>
Subject: Re: [PATCH] selinux: implement bpf_token_cmd and bpf_token_capable hooks
To: danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	Eric Suen <ericsu@linux.microsoft.com>
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
>
> We may need to wrap these checks with a new policy capability (see
> security/selinux/include/policycap.h and related code) to avoid
> breaking compatibility on existing systems using BPF tokens, if any.

I have added some notes with links to examples of how to add a new
SELinux policy capability to the SELinux kernel Getting Started guide
at:
https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#addin=
g-a-new-selinux-policy-capability

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
