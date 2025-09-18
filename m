Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071AD23AB98
	for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207574; cv=none; b=SoMCZ34H56YOroJtfx90XTJaWM6NWQKmMNnkFSKtp+DgD7Xm9Fp+1VZZyeu7N+5aK1AReE+NYWH4leCiUeNmc/P4tXdanUI//MHSe+RUxcdOhfsA2jyRyGE3Jes160+D3VDK4Fcei8w8+x9d8wzXDrByNlFcTD6r+K0/pFDGJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207574; c=relaxed/simple;
	bh=9AyjbZu/R6+7AfTH/imXIBSLKPGlymz6O9mTaOrNiZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELAmDj+Jn5tqetdc/gdt0qnBHhuaEHLF7bo1I085cCdBYxGvXK7R82BeiEwXhwxBaycWWnJrw8rYDIO+yQvD3LTPm7RH/5Ibi0ipfFEQSIM07E/OqZUsXkL6KHk/d0rXhahIOk8aNlD18ZiPf/7dr467c2o/6/T5HfZiEoTbeIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Eem/2qv+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Eem/2qv+"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5500891f00so606464a12.0
        for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758207572; x=1758812372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i5xXatEMur57KoQTvo+Bsthb7HXDozR76+usUBMQNA=;
        b=Eem/2qv+KZTSB0qWtXChxJG9tKsiVEqz5IjQD38P4a/NMnG0EKxRdZcm7sT1wTDOpt
         mmK94Wp+uza83RHiZjVZ1nRJbsAcoiflZbXIuIUdCZKn4hUOf4ego5cbidDR8Vs1P0nN
         ntAswCqTFu9qG7ypjOli98yeo5kpyDYDCLOlcflRTKQokH7CMp4JCXQc1XH67SwTisvL
         wiUQ/E+EgjYSnCCE3nZYA9pjskIFDfrEJClezCrdvjM3fFxpUHvH1+nuJJRCJNMZDtjl
         S82DEx92xB8lhqAqJgIUZ6RjeU/Puh19GyTlti6/tArjLOsDkVad5gGG5pSeAMVSp0ew
         KSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207572; x=1758812372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1i5xXatEMur57KoQTvo+Bsthb7HXDozR76+usUBMQNA=;
        b=k85M/0YmGgcHQBrVQpTkZsb1g9mBuKNukkyTptOwMoRdT9HSpOp833+u+3X6JySy5E
         RfLRHETHRCkrYkFgxn9oVZjqkLAAkkcSYE/j9Nqhzlf7C5ezBiXA3PQbswuk5EjwvnaA
         OL2ElVYfbTlbyKE+YRin8xDvFS0O3rheKw3FfO8cYKhGYMJkmgMN33kiWciqf/SGTv44
         VdZsaQdHhNSMxby8g+3RoZDkf3NxjGYLDQ6W07wIF2T3k9lcaiCoJWa+BNUuJneieyhL
         3fr0WDa5k79MEDjS5KpvSPddgMTbTCDQEoHxz0fOjEf4RGJVSAiuhmQozHjIgQsEMjLP
         TmcA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ+L7r4Cv7zfSJPUvhP247wh1CLNY7htArYl1R8is1GLFVAuyBgO0Ni9l0DAAlDNgSo87oeUqE@vger.kernel.org
X-Gm-Message-State: AOJu0YwhOWUa8P6SrXKEIWhQ1hlOwCYyUT2ioqnzvqmGGWN9uMEgjBAZ
	WChpQ2BcfTwwL51zD6LuaEzLRqVreXoz2jB19y9+pfq1kEPS15j4DyltTz1VVIBqi+uJq/ci8UQ
	k77s35PvIvoidtdmrSI62g4TTumJ2gdYGUzlFTANy
X-Gm-Gg: ASbGncucq8na3is1oTZb+tdPoN9ekQQI2N0oMWsSgwmFuAGlBc4ig9xNyvTBTIi2vdl
	SpyNpSC0ChbaM+aKaJm9tczdNo6qsELUoBKWR4VztAPhyRO5/eesaJHGwtgUOUnPiNiUfkzJ5ox
	XKVdBS5QPE8yStBQ0bXfoun/s0cDpWTyv3RZfwzKUZIw1TPtMLbVPmwSGgKXSDNIOJ44WSmi0/B
	+WZvGuvir7QgJVd+futDb2eHw==
X-Google-Smtp-Source: AGHT+IEUKmSYDo2DX3O9oD+BnxOBGtwu3LH/T/y6wuBdnPkqqAF5QaDTPZSlvkftb77Ze+YCyuOE8m6me+Fz4wVGHZg=
X-Received: by 2002:a17:902:f706:b0:267:6649:ec10 with SMTP id
 d9443c01a7336-268119b7b26mr78730635ad.4.1758207572052; Thu, 18 Sep 2025
 07:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821182021.304-1-ericsu@linux.microsoft.com>
 <1752d2d2f04b17d4da2e40990985be51@paul-moore.com> <CAEjxPJ6qiw_T+9u_GuYgmLXShhbcG7hSt34Z9kvpiH9AQ9nmKA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6qiw_T+9u_GuYgmLXShhbcG7hSt34Z9kvpiH9AQ9nmKA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 Sep 2025 10:59:19 -0400
X-Gm-Features: AS18NWBPvst4Ka4WrxQ4l8s4vUvRJVfahEwJnzqHqaqjb-CAle_L7hVbKaIGReI
Message-ID: <CAHC9VhREWrw=2u66pbba+KC=SrSTfZ=5bn7jiqngyHh7qyv3Xg@mail.gmail.com>
Subject: Re: [PATCH v3] SELinux: Add support for BPF token access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 9:36=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Sep 17, 2025 at 5:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Aug 21, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
> > >
> > > BPF token support was introduced to allow a privileged process to del=
egate
> > > limited BPF functionality=E2=80=94such as map creation and program lo=
ading=E2=80=94to an
> > > unprivileged process:
> > >   https://lore.kernel.org/linux-security-module/20231130185229.268895=
6-1-andrii@kernel.org/
> > >
> > > This patch adds SELinux support for controlling BPF token access. Wit=
h
> > > this change, SELinux policies can now enforce constraints on BPF toke=
n
> > > usage based on both the delegating (privileged) process and the recip=
ient
> > > (unprivileged) process.
> > >
> > > Supported operations currently include:
> > >   - map_create
> > >   - prog_load
> > >
> > > High-level workflow:
> > >   1. An unprivileged process creates a VFS context via `fsopen()` and
> > >      obtains a file descriptor.
> > >   2. This descriptor is passed to a privileged process, which configu=
res
> > >      BPF token delegation options and mounts a BPF filesystem.
> > >   3. SELinux records the `creator_sid` of the privileged process duri=
ng
> > >      mount setup.
> > >   4. The unprivileged process then uses this BPF fs mount to create a
> > >      token and attach it to subsequent BPF syscalls.
> > >   5. During verification of `map_create` and `prog_load`, SELinux use=
s
> > >      `creator_sid` and the current SID to check policy permissions vi=
a:
> > >        avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
> > >                     BPF__MAP_CREATE, NULL);
> > >
> > > The implementation introduces two new permissions:
> > >   - map_create_as
> > >   - prog_load_as
> > >
> > > At token creation time, SELinux verifies that the current process has=
 the
> > > appropriate `*_as` permission (depending on the `allowed_cmds` value =
in
> > > the bpf_token) to act on behalf of the `creator_sid`.
> > >
> > > Example SELinux policy:
> > >   allow test_bpf_t self:bpf {
> > >       map_create map_read map_write prog_load prog_run
> > >       map_create_as prog_load_as
> > >   };
> > >
> > > Additionally, a new policy capability bpf_token_perms is added to ens=
ure
> > > backward compatibility. If disabled, previous behavior ((checks based=
 on
> > > current process SID)) is preserved.
> > >
> > > Changes in v2:
> > > - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
> > >   creator_sid from wrong file descriptor
> > > - Removed unnecessary checks for null, per review comments from
> > >   the first patch
> > >
> > > Changes in v3:
> > > - Removed check for 'sid =3D=3D SECSID_NULL' in selinux_bpf_token_cre=
ate and
> > >   allow it to fall through to the permission checks which will fail a=
s
> > >   access denied to unlabeled_t
> > >
> > > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> > > Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> > > Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
>
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index e474cd7398ef..d949e9c5aa31 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -733,6 +733,8 @@ static int selinux_set_mnt_opts(struct super_bloc=
k *sb,
> > >               goto out;
> > >       }
> > >
> > > +     sbsec->creator_sid =3D current_sid();
> >
> > A few things come to mind as I'm looking at the new creator_sid field.
> >
> > First, we should explicitly initialize @sbsec->creator_sid to
> > SECINITSID_UNLABELED in selinux_sb_alloc_security() just as we do the
> > other fields.  Yes, the LSM framework does some basic clearing, but thi=
s
> > is safer long term and it isn't likely that superblock allocation is
> > going to be common enough to where the extra assignment is going to be
> > a concern.
> >
> > While I don't think this is an immediate issue, I think it's a good ide=
a
> > to ensure that the selinux_cmp_sb_context() function compares the
> > @sbsec->creator_sid fields and only returns true/"match" if they are th=
e
> > same.
>
> Hmm...that raises another question in my mind - what happens if
> multiple processes mount bpffs filesystems currently - do they each
> get their own superbock or is that shared?

Good question.  If the superblock is shared among all mount instances
we need to do some extra work to determine the creator label/SID for
each instance.

> If the latter, then making this part of the comparison will block
> subsequent mounts by tasks with different SIDs.
> But not doing something here would lead to using whoever was the last
> mounter for the SID, so I agree something needs to happen.

Eric, can you look into the code and do some testing?

> > > @@ -7144,10 +7180,15 @@ static void selinux_bpf_prog_free(struct bpf_=
prog *prog)
> > >       kfree(bpfsec);
> > >  }
> > >
> > > +#define bpf_token_cmd(T, C) \
> > > +     ((T)->allowed_cmds & (1ULL << (C)))
> > > +
> > >  static int selinux_bpf_token_create(struct bpf_token *token, union b=
pf_attr *attr,
> > >                                   const struct path *path)
> > >  {
> > >       struct bpf_security_struct *bpfsec;
> > > +     u32 sid =3D selinux_bpffs_creator_sid(attr->token_create.bpffs_=
fd);
> > > +     int err;
> > >
> > >       bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> > >       if (!bpfsec)
> >
> > This isn't an issue with your code, and to be clear I'm not asking you
> > to fix this, but more as a FYI/TODO for me (or anyone else who would
> > care to do it), after the BPF token patch is merged, we should move the
> > @bpfsec allocation/lifecycle-management for tokens out to the LSM
> > framework so it can properly handle multiple LSMs.
>
> This already happened in the LSM tree, just hasn't been merged to the
> SELinux tree yet.

Ah, yes, I forgot all about Blaise's patch!  My apologies.  At least
that is one less thing for the TODO list ;)

--=20
paul-moore.com
