Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15801D5CDD
	for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073259; cv=none; b=kUJW/9kzf2LGftz9Wmwis66UGIZOYWFkUZrlhle3vLNTeGGCR+oDMx64feH67uiCj52ue2emUfFQ2Sb+8e2/JbHEOW6c/zTUSHDSLa5Dnorx5mlLn5YS82bORR3TF8mj5ZhZX/Bv8Xrn2OcXfkIHzVa0tNgWpAJI5BFF5NmMres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073259; c=relaxed/simple;
	bh=8rPnFaNq1SfJ7jVpZvL0HRIukQfDe+00TekDIZglHqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTqYQQS+dBO1889erAHuKnVvNq0emX1vijNPLLaeWFLMj/FsC04xWHHVAaGnJnTptERqbUV8Fy/GYsr9MqOK4r2g4pNyvJEJDLuzHybyEgVB8Zay8B6xT6thVNtKYum4ByxRecfFBepRWNsloEHrK1Pe5REKHikvsDrZ23iv8UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gzl4uYnY; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gzl4uYnY"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f7440444efso9379377b3.2
        for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 09:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740073257; x=1740678057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu7DO/yBBwA/XGaFJzr9sCM18a7jAEeqhWVP0InQkzI=;
        b=Gzl4uYnY65hl2BR5i6mgM3CNtkSXWslno2D8Dnpl+u8ocKicHeVFJwa7ZZtC4wMFH8
         gmtg2x/k9zMLSV0SDP11z8Vq/O5eDfxb2JcdNr9OeFUJHY6SaRyIDQYslyFujIQlSUpW
         B0co0t6aeKkBZrI/KxZEhi830groy6lXNgCMQLi09gqASilQ6Db+Hef2YEh4Ik14nLM5
         k0laCRFdlOpu3swydEUVYl9oYAwsXHdVzFhb9IZpu1kgLFjEiYHzh2eMgNY3VvAZMYJ6
         7Tx+rCj+FnzkJV6XIwzPtKoudM8Ji38ghEA5u96gxg0kUn+rOzYbdyvAwbZP8gMK4nDC
         U6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073257; x=1740678057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu7DO/yBBwA/XGaFJzr9sCM18a7jAEeqhWVP0InQkzI=;
        b=MenxHE0oUkRMMgWStR8h/3d+2vc/zjvAMqL7nxt7FBx2PW/l9XWWKfqMq84xPnVDWZ
         O7dWacZAdhS5qcw5MpR0uQsAMB6Q+uD5bV3M5DkKUpkrDk2luhnFfYQEd5SO8T0AUQ3P
         r2N7ilKU1P1qyBKHU1D/8tdWhV/AaijDsab/pAYaSRNuoDg0szsdgItJ/iqQq2IcoVtY
         QZzSzU1qd7VE6DPDEK33TyYpW/1azlvkl8u4aftL7xhcphJCOEaJbzIBTubpcqmMDgWp
         gqqeoQcgh8bMoBy05da8OIILDegE5Ulvau94eeV1t08QpIEgNvJ4j75FThfnZyliK/Kt
         UIdA==
X-Forwarded-Encrypted: i=1; AJvYcCUGrB0L9hov8cu8y+MLCtElvLF1BfozI8+xckbsY3UW5ExUdx4ixSfequ79nuKGz4mLwS65B1bf@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6TphxcQgri+f0W/NlmES0blwi5rdcu9S2v6ICbXIPoGugCvE
	TYzBU+vXciPyvB9e6Dr0WPMk2+IG+20SSUlqKV1eE+37GwK0/HyMGp3TVfpZExo1fv5oF0C6z5C
	EWC54pYNHNO4878QL/+7LppHc0dXCDSWG7dVo
X-Gm-Gg: ASbGncv7xf2Vuw8Uk95A14bZ1ZdCs1SiMv0XYK7KBrRSVgsZ7+uaYrtMe+lS6bb9433
	I9IOUxXyI4kM1auyXi+GZOLb9sKNQFwxhOspzvr5Mu1HURkLyui6BHQLoyB5jLijZRdBBULQS
X-Google-Smtp-Source: AGHT+IGOC3n697KQWN6744ppAX2UiJaNpyU2qsRLzjIySb2kBI0edUGzQLUx4OZtKin2ejcQnHHBTTRTr9VNGFYZed0=
X-Received: by 2002:a05:690c:6283:b0:6f9:a75f:f220 with SMTP id
 00721157ae682-6fb58361e38mr219054337b3.25.1740073256563; Thu, 20 Feb 2025
 09:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com> <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
In-Reply-To: <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Feb 2025 12:40:45 -0500
X-Gm-Features: AWEUYZkFZy4bmFlQEibuzns5VOKgC88N9W9hwaf8Sszpl0Su5qJth6e0K_A3KCU
Message-ID: <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:43=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Oct 23, 2024 at 5:23=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > Replace the (secctx,seclen) pointer pair with a single lsm_context
> > pointer to allow return of the LSM identifier along with the context
> > and context length. This allows security_release_secctx() to know how
> > to release the context. Callers have been modified to use or save the
> > returned data from the new structure.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: ceph-devel@vger.kernel.org
> > Cc: linux-nfs@vger.kernel.org
> > ---
> >  fs/ceph/super.h               |  3 +--
> >  fs/ceph/xattr.c               | 16 ++++++----------
> >  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
> >  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
> >  include/linux/lsm_hook_defs.h |  2 +-
> >  include/linux/security.h      | 26 +++-----------------------
> >  security/security.c           |  9 ++++-----
> >  security/selinux/hooks.c      |  9 +++++----
> >  8 files changed, 50 insertions(+), 70 deletions(-)
> >
>
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 76776d716744..0b116ef3a752 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -114,6 +114,7 @@ static inline struct nfs4_label *
> >  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
> >         struct iattr *sattr, struct nfs4_label *label)
> >  {
> > +       struct lsm_context shim;
> >         int err;
> >
> >         if (label =3D=3D NULL)
> > @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, struc=
t dentry *dentry,
> >         label->label =3D NULL;
> >
> >         err =3D security_dentry_init_security(dentry, sattr->ia_mode,
> > -                               &dentry->d_name, NULL,
> > -                               (void **)&label->label, &label->len);
> > -       if (err =3D=3D 0)
> > -               return label;
> > +                               &dentry->d_name, NULL, &shim);
> > +       if (err)
> > +               return NULL;
> >
> > -       return NULL;
> > +       label->label =3D shim.context;
> > +       label->len =3D shim.len;
> > +       return label;
> >  }
> >  static inline void
> >  nfs4_label_release_security(struct nfs4_label *label)
> >  {
> > -       struct lsm_context scaff; /* scaffolding */
> > +       struct lsm_context shim;
> >
> >         if (label) {
> > -               lsmcontext_init(&scaff, label->label, label->len, 0);
> > -               security_release_secctx(&scaff);
> > +               shim.context =3D label->label;
> > +               shim.len =3D label->len;
> > +               shim.id =3D LSM_ID_UNDEF;
>
> Is there a patch that follows this one to fix this? Otherwise, setting
> this to UNDEF causes SELinux to NOT free the context, which produces a
> memory leak for every NFS inode security context. Reported by kmemleak
> when running the selinux-testsuite NFS tests.

I don't recall seeing anything related to this, but patches are
definitely welcome.

--=20
paul-moore.com
