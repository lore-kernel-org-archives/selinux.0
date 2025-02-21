Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC59B214817
	for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145954; cv=none; b=OKKcRmOCxNHreGjJXfLyEbNBopZ6CLiHJl2gV+9Ky+Joluh50EfNh1g3F8czdy7O/fMS3VosRzFBs9tsgQH12vD0KdsHoTjvp7ipJ+Te8ODclhXm44lpxObfq9KXSznU+OysgF4wk6Nt6nDYezGnsbr5QU8FJmF61yL6uZda8uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145954; c=relaxed/simple;
	bh=RkLmC2sGI9seh+uOyIDNcFOVMdpy7pt8K/zgTvLTCgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjILuSNu1yZz126+ImlIuqgzWxKc9OYyPmDWYOGc3DEGIDZVCNjLwuc1m7abjzjeEbIKcInnaa46/cb8Knuz+yHXtPGa+Qkwada25BHXy1yWjcrbo5Ff7+X0jYQvv8J4kUdpMO4K8yG33OwewrPULhIV9UqDZqL+bXD4x4s+Q7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiRQDpeY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiRQDpeY"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so4327933a91.0
        for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740145952; x=1740750752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5dV/oRHt4UgmMrXJv5EIA3iox0AblQLqH8vpO6QV04=;
        b=WiRQDpeYGga6QvZeziJOe+kqPmvRO+YZYWtDGwPGpk1aCIHKsml7dBic+C9RLGvIfP
         lIyKNJdPdwtiX7cpSMZ9vfrTJuqY3r96qBvSGns/xbyvgMF7PEfP8nifRvOJQeuaFWDM
         xxAqa35bphJE88cRjQsjVyC79owjiwVvEKKxcbJ74FNJyTd2jQcU4ZOORaLqe+8Tt2bi
         SH8BHao007zUWlAGbT9rmW+ZV9v2/Oe8VIxctpiujYXjaT0iA4x0Dss7fKEI9H0BK2Of
         Z9Q+og0WAjPBXZb8Yx5dKmcuwlEtVGNhXG/V688mVi/HzLGW0yr61xwks0+1E8TjrGX4
         gK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145952; x=1740750752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5dV/oRHt4UgmMrXJv5EIA3iox0AblQLqH8vpO6QV04=;
        b=GlRNiMG1xRJnp52mB+bGB6w/LJBhGZjogSxJUgxHnOniO6uZP3Fmv92Bse0jwUFrCe
         lxs9/u2NzC6n/ZOpQkGNLXT+ocgN1+S7u6GQ9bb1GBxf2DdaQBiBmjYJYdJuTagDVHNy
         dAw9plQJ45QBEF1dpJHxgxHSDWsgQnWCLL6XT5/hKYg1/MDjj+H4k8t0vX/+nam+A0LF
         PSln4qtA9FT0iER7XDTkUS8HqRY3yU6kDoCqHagmY3JE7Ece5eDBhglZbA5smibvfeW8
         0+UFxUQvjk48n77xSRPaGSu92x8A0Yc2lPU6qeC2WhgU+WLW5/yGAtv9BInvUnBdR46B
         UN9A==
X-Forwarded-Encrypted: i=1; AJvYcCVIASK3GG8f4g+nMpQZo0BRjUo6pBMwY8KczEQxtqxde+nw8pW+UpaPGpfKiuUBI+LGeersAfwE@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7ZRDEaAQbPaYVauf4hzdatiCMiVzMFBCGroEK+arnXu62GAL
	sOn7rFWlEhRG6dv97TZxmBVoN7+VWADiBVu9uBoZpBS0oY1/80ZiRorf/krawXY5vFnjKScZfjv
	yGOnKR7ziA2FQEPxdCEroO8244fI=
X-Gm-Gg: ASbGncvRpPugkEpLlVe9Bn4yBe4ACuW36IemPVbkf0knc6ZS0qCK2Fr91zxcPBRfv/4
	46CqRKLb+FcAyh8H+hKWfPuCIpJwRVF+LL1eTVGp3WczSN3hNp8swFz8xb3xEQKadT3cON1EzwZ
	EwD37CbuE=
X-Google-Smtp-Source: AGHT+IFpVS3CtEAK0T5mnq048OLh5LWndkT5H/1O8mtqZGNYo7RXZdwT+E4yVcnBg7v2Nz7jgVT9KDh84EZLOInK07U=
X-Received: by 2002:a17:90b:4c04:b0:2fa:b84:b304 with SMTP id
 98e67ed59e1d1-2fce7b221cemr4630485a91.22.1740145952163; Fri, 21 Feb 2025
 05:52:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211182159.37744-1-kippndavis.work@gmx.com>
 <CAJ2a_DdXpShgNYUgO6XRTPV=sKVC6+po6ZebHSVS5p3MNAx7ng@mail.gmail.com>
 <CAEjxPJ7eqMriJmcwoKPwSnLeKkgW+woYGwzKxyOQ1SnY1N0Eig@mail.gmail.com> <CAEjxPJ4CDt6NmsLJhLtGQCoKHR6vxnBqY0JB5RQCyx84PKO9rg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4CDt6NmsLJhLtGQCoKHR6vxnBqY0JB5RQCyx84PKO9rg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Feb 2025 08:52:21 -0500
X-Gm-Features: AWEUYZl8wHpXzJPFZd2_2MfSqS6-G_-OcoggJnztOKyGrEpEajtSNICcFcTNqK0
Message-ID: <CAEjxPJ5yQD4=WK6xWDjx=vP+pXDBWNoaWPXQvH9MqX32NBipbQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add permission checks for loading other kinds
 of kernel files
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: kippndavis.work@gmx.com, selinux@vger.kernel.org, paul@paul-moore.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:24=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Feb 20, 2025 at 3:23=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Feb 17, 2025 at 3:58=E2=80=AFPM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > On Tue, 11 Feb 2025 at 19:22, <kippndavis.work@gmx.com> wrote:
> > > >
> > > > From: "Kipp N. Davis" <kippndavis.work@gmx.com>
> > > >
> > > > Although the LSM hooks for loading kernel modules were later genera=
lized
> > > > to cover loading other kinds of files, SELinux didn't implement
> > > > corresponding permission checks, leaving only the module case cover=
ed.
> > > > Define and add new permission checks for these other cases.
> > > >
> > > > Signed-off-by: Cameron K. Williams <ckwilliams.work@gmail.com>
> > > > Signed-off-by: Kipp N. Davis <kippndavis.work@gmx.com>
> > > >
> > > > ---
> > > > Changes in v2:
> > > >   - Removed the `-EACCES` return in default case in
> > > >     selinux_kernel_read_file() and selinux_kernel_load_from_file(),
> > > >     reverting previous fallback behavior.
> > > >   - Added a compile-time check in these functions to catch new
> > > >     READING/LOADING_XXX entries.
> > > >
> > > > Thanks for your review! I've adjusted the default case so as to not
> > > > return an error and depart from pre-existing logic. I first tried t=
o use
> > > > the pre-processor #errors but failed with the READING/LOADING_MAX_I=
D
> > > > enums, so I opted for BUILD_BUG_ON_MSG as a compile-time check with
> > > > those same enums instead to catch new entries.
> > > > ---
> > > >  security/selinux/hooks.c            | 56 +++++++++++++++++++++++--=
----
> > > >  security/selinux/include/classmap.h |  4 ++-
> > > >  2 files changed, 49 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 7b867dfec88b..67bf37693cd7 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -4096,7 +4096,7 @@ static int selinux_kernel_module_request(char=
 *kmod_name)
> > > >                             SYSTEM__MODULE_REQUEST, &ad);
> > > >  }
> > > >
> > > > -static int selinux_kernel_module_from_file(struct file *file)
> > > > +static int selinux_kernel_load_from_file(struct file *file, u32 re=
quested)
> > > >  {
> > > >         struct common_audit_data ad;
> > > >         struct inode_security_struct *isec;
> > > > @@ -4104,12 +4104,9 @@ static int selinux_kernel_module_from_file(s=
truct file *file)
> > > >         u32 sid =3D current_sid();
> > > >         int rc;
> > > >
> > > > -       /* init_module */
> > > >         if (file =3D=3D NULL)
> > > >                 return avc_has_perm(sid, sid, SECCLASS_SYSTEM,
> > > > -                                       SYSTEM__MODULE_LOAD, NULL);
> > > > -
> > > > -       /* finit_module */
> > > > +                                       requested, NULL);
> > > >
> > > >         ad.type =3D LSM_AUDIT_DATA_FILE;
> > > >         ad.u.file =3D file;
> > > > @@ -4123,7 +4120,7 @@ static int selinux_kernel_module_from_file(st=
ruct file *file)
> > > >
> > > >         isec =3D inode_security(file_inode(file));
> > > >         return avc_has_perm(sid, isec->sid, SECCLASS_SYSTEM,
> > > > -                               SYSTEM__MODULE_LOAD, &ad);
> > > > +                               requested, &ad);
> > > >  }
> > > >
> > > >  static int selinux_kernel_read_file(struct file *file,
> > > > @@ -4131,10 +4128,32 @@ static int selinux_kernel_read_file(struct =
file *file,
> > > >                                     bool contents)
> > > >  {
> > > >         int rc =3D 0;
> > > > -
> > > > +       BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
> > > > +                 "New kernel_read_file_id introduced; update SELin=
ux!");
> > > >         switch (id) {
> > >
> > > Should READING_UNKNOWN be handled?
> > > It seems not to be used currently in-tree, but maybe stay on the safe=
 side?
> >
> > IMHO, no. READING_UNKNOWN/LOADING_UNKNOWN aren't intended to be used
> > and would be a bug elsewhere in the kernel.
> >
> > >
> > > > +       case READING_FIRMWARE:
> > > > +               rc =3D selinux_kernel_load_from_file(contents ? fil=
e : NULL,
> > > > +                               SYSTEM__FIRMWARE_LOAD);
> > > > +               break;
> > > >         case READING_MODULE:
> > > > -               rc =3D selinux_kernel_module_from_file(contents ? f=
ile : NULL);
> > > > +               rc =3D selinux_kernel_load_from_file(contents ? fil=
e : NULL,
> > > > +                               SYSTEM__MODULE_LOAD);
> > > > +               break;
> > > > +       case READING_KEXEC_IMAGE:
> > > > +               rc =3D selinux_kernel_load_from_file(contents ? fil=
e : NULL,
> > > > +                               SYSTEM__KEXEC_IMAGE_LOAD);
> > > > +               break;
> > > > +       case READING_KEXEC_INITRAMFS:
> > > > +               rc =3D selinux_kernel_load_from_file(contents ? fil=
e : NULL,
> > > > +                               SYSTEM__KEXEC_INITRAMFS_LOAD);
> > > > +               break;
> > > > +       case READING_POLICY:
> > > > +               rc =3D selinux_kernel_load_from_file(contents ? fil=
e : NULL,
> > > > +                               SYSTEM__POLICY_LOAD);
> > > > +               break;
> > > > +       case READING_X509_CERTIFICATE:
> > > > +               rc =3D selinux_kernel_load_from_file(contents ? fil=
e : NULL,
> > > > +                               SYSTEM__X509_CERTIFICATE_LOAD);
> > > >                 break;
> > > >         default:
> > > >                 break;
> > > > @@ -4146,10 +4165,27 @@ static int selinux_kernel_read_file(struct =
file *file,
> > > >  static int selinux_kernel_load_data(enum kernel_load_data_id id, b=
ool contents)
> > > >  {
> > > >         int rc =3D 0;
> > > > -
> > > > +       BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
> > > > +        "New kernel_load_data_id introduced; update SELinux!");
> > > >         switch (id) {
> > >
> > > dito
> > >
> > > > +       case LOADING_FIRMWARE:
> > > > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__=
FIRMWARE_LOAD);
> > > > +               break;
> > > >         case LOADING_MODULE:
> > > > -               rc =3D selinux_kernel_module_from_file(NULL);
> > > > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__=
MODULE_LOAD);
> > > > +               break;
> > > > +       case LOADING_KEXEC_IMAGE:
> > > > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__=
KEXEC_IMAGE_LOAD);
> > > > +               break;
> > > > +       case LOADING_KEXEC_INITRAMFS:
> > > > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__=
KEXEC_INITRAMFS_LOAD);
> > > > +               break;
> > > > +       case LOADING_POLICY:
> > > > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__=
POLICY_LOAD);
> > > > +               break;
> > > > +       case LOADING_X509_CERTIFICATE:
> > > > +               rc =3D selinux_kernel_load_from_file(NULL,
> > > > +                               SYSTEM__X509_CERTIFICATE_LOAD);
> > > >                 break;
> > > >         default:
> > > >                 break;
> > > > diff --git a/security/selinux/include/classmap.h b/security/selinux=
/include/classmap.h
> > > > index 03e82477dce9..cfac41d12f7d 100644
> > > > --- a/security/selinux/include/classmap.h
> > > > +++ b/security/selinux/include/classmap.h
> > > > @@ -63,7 +63,9 @@ const struct security_class_mapping secclass_map[=
] =3D {
> > > >         { "process2", { "nnp_transition", "nosuid_transition", NULL=
 } },
> > > >         { "system",
> > > >           { "ipc_info", "syslog_read", "syslog_mod", "syslog_consol=
e",
> > > > -           "module_request", "module_load", NULL } },
> > > > +           "module_request", "module_load", "firmware_load",
> > > > +           "kexec_image_load", "kexec_initramfs_load", "policy_loa=
d",
> > >
> > > In the SELinux world the word "policy" refers mostly to the SELinux p=
olicy.
> > > Maybe rename the permission verb "policy_load" to
> > > "security_policy_load" or similar? (it seems to be used by IMA,
> > > loadpin and zram currently)
> >
> > I don't really see how that is less ambiguous since SELinux policy is
> > a security policy too, but don't have any strong feelings either way.
> > We have the load_policy permission in the security class for loading
> > SELinux policy, so if we use security_policy_load here, then we'll end
> > up with SECURITY__LOAD_POLICY and SYSTEM__SECURITY_LOAD_POLICY.
> > What could go wrong?
>
> Sorry, that last one would be SYSTEM__SECURITY_POLICY_LOAD to be
> precise, but the point remains.

Also, it appears that this policy_load is used by non-security code as
well, so that's another reason to not rename it.
