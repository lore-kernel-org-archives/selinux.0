Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1353C2080C0
	for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146009; cv=none; b=szOWOVV8+Ej1BWdgj00zy3cnC+6NGQt+gnf2dyXNMZ1WtDGk+Dy6yTnqkZakAJt12Lq1KYXH1+L0SQm702iF51lBXPyJRkca3LyWEVjoL+zLaHHVKqB/HEDNsmp8R3Vyw33W8h6y9/gXTmNjwp+AhwCWr4YetrU1h1uRLvvn+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146009; c=relaxed/simple;
	bh=8DSL8jVIgjTW9dhaCr6AciGp1eehF0cA5DXzmFsYog0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXClce9xFvf+Bh87esmzWVZFFXAVlUECLEFlmuvBNV/ppB7tKCisbHeLDj2QjVe7NAhhQVX/epUu9khi+6L8cqSBPJHqVz3sZ8/jm7sb6WjK5nssWeXHkC25pHvWuVv8HjB10R2O14BQWzvZ3LJ+bPx+FuXCsYbozFSz3KDTNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFkYhOeY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFkYhOeY"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc3db58932so3211643a91.2
        for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 05:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740146007; x=1740750807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yldq5alWJ+h+YPVUrIoaKMBdn7kZJCq5F9o+9U6jG1o=;
        b=DFkYhOeYg3R0OM07/vo98z2AQbQKTh6dwbJqKQ6cB6ymQ4GRPr7mJ6DRhnI8y/ZijV
         dvRDquZDd+7sQ9vdxkYyXuR6mWN/tQefC28SubQfBVkAxOkTBiR8rXnIAtlp0vBRcES+
         OhcW6FpSITbaNPCWKRJx2BESd9w6eFA6N1pPs+uupz9t5evbfmI1urLXpZlGMnmYTdqI
         PruyGAQhzouJbf0ai+iMLrrCYsjQMDqW5QjdeHnALuKmsfd+ZODabyZodLb/QPIWzbRA
         Rwwdd+1PsW13ZnWHouNUP2BrtpyOVx+BvacP3UZRUEhZuQM8msnz05bseczgfc3DmB/f
         OOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740146007; x=1740750807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yldq5alWJ+h+YPVUrIoaKMBdn7kZJCq5F9o+9U6jG1o=;
        b=IwRpd/AYvYDrcLQyFEBR/fPxrQkeBLg7JIGTC2Y8Q6+IsaJP/Ox60HhLYY5uJCiOJV
         80Nl7qqZesRuLHcZ6+OzULRUQRNegK89kCTiQBgMlOwQraegz64S7FVr+zE5CjsDPhAK
         BQu1fQpP0ptpwZ9IzoOTXi5K2q2AeuwwMa71OWXP8p9/RTlpv2paPmZ9B6SEBSqookWT
         XkaGaGYgxVcggU655fqufY/8an/lSi95NA9HtAyaKVSL2SQbi0ald/ocGBneyZJWw7qQ
         WNJRcVDEwTfQOCyOwMeexOJJwzmk3+sJ/EZ8YokM1yi7Tkm9NRwF9vus2++vGf4jhtvd
         YCPQ==
X-Gm-Message-State: AOJu0Yy778czRaBZskzsn0SR6xK6vfRjEYMvpj4v2/GMpjni4rSg6FeZ
	nR+DUoXHA0NNFCM9M6Yd5wMqDNPdC6nWUXMfz+rphKEqOnce8AhYIMFC0ECbjroJWwXzYAa2KOE
	MPJ32oj1Q/c2bPtmBHzWKN78M6rM=
X-Gm-Gg: ASbGncsywhWf4OcxiP5wnFNx1tRQw2fM/AjPTsM1yiRr5eO/1Or5QDroa7730/QCdM0
	J8AOGLE6/5UDBr68RBLByppqU6fgbHgBT5C4AzBfoG5IADiwhjRsdJ/DkZlURL3u6uP5uqvg+RO
	xIHIsg7qc=
X-Google-Smtp-Source: AGHT+IHnsdwCp6AsYQgXVy9I/IeZ38vL4HfUqjmsZf0+k2gBmyMpTCoubtur9xrBwOCWA01mRE81WmVCK42hSIp5YEg=
X-Received: by 2002:a17:90b:3e83:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2fce7b04f5fmr5401754a91.28.1740146007268; Fri, 21 Feb 2025
 05:53:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211182159.37744-1-kippndavis.work@gmx.com>
In-Reply-To: <20250211182159.37744-1-kippndavis.work@gmx.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Feb 2025 08:53:16 -0500
X-Gm-Features: AWEUYZntwbI_ZNCkM-xhn-kMv4R7uu11ZOA0iKQXrwa2LKdzTI-00JeeDY4YeNA
Message-ID: <CAEjxPJ5ogMbvnUqSt5xMOs0At3JRdgJ-cP6CTTb8ux3zS5kMbA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add permission checks for loading other kinds
 of kernel files
To: kippndavis.work@gmx.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:22=E2=80=AFPM <kippndavis.work@gmx.com> wrote:
>
> From: "Kipp N. Davis" <kippndavis.work@gmx.com>
>
> Although the LSM hooks for loading kernel modules were later generalized
> to cover loading other kinds of files, SELinux didn't implement
> corresponding permission checks, leaving only the module case covered.
> Define and add new permission checks for these other cases.
>
> Signed-off-by: Cameron K. Williams <ckwilliams.work@gmail.com>
> Signed-off-by: Kipp N. Davis <kippndavis.work@gmx.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

>
> ---
> Changes in v2:
>   - Removed the `-EACCES` return in default case in
>     selinux_kernel_read_file() and selinux_kernel_load_from_file(),
>     reverting previous fallback behavior.
>   - Added a compile-time check in these functions to catch new
>     READING/LOADING_XXX entries.
>
> Thanks for your review! I've adjusted the default case so as to not
> return an error and depart from pre-existing logic. I first tried to use
> the pre-processor #errors but failed with the READING/LOADING_MAX_ID
> enums, so I opted for BUILD_BUG_ON_MSG as a compile-time check with
> those same enums instead to catch new entries.
> ---
>  security/selinux/hooks.c            | 56 +++++++++++++++++++++++------
>  security/selinux/include/classmap.h |  4 ++-
>  2 files changed, 49 insertions(+), 11 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7b867dfec88b..67bf37693cd7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4096,7 +4096,7 @@ static int selinux_kernel_module_request(char *kmod=
_name)
>                             SYSTEM__MODULE_REQUEST, &ad);
>  }
>
> -static int selinux_kernel_module_from_file(struct file *file)
> +static int selinux_kernel_load_from_file(struct file *file, u32 requeste=
d)
>  {
>         struct common_audit_data ad;
>         struct inode_security_struct *isec;
> @@ -4104,12 +4104,9 @@ static int selinux_kernel_module_from_file(struct =
file *file)
>         u32 sid =3D current_sid();
>         int rc;
>
> -       /* init_module */
>         if (file =3D=3D NULL)
>                 return avc_has_perm(sid, sid, SECCLASS_SYSTEM,
> -                                       SYSTEM__MODULE_LOAD, NULL);
> -
> -       /* finit_module */
> +                                       requested, NULL);
>
>         ad.type =3D LSM_AUDIT_DATA_FILE;
>         ad.u.file =3D file;
> @@ -4123,7 +4120,7 @@ static int selinux_kernel_module_from_file(struct f=
ile *file)
>
>         isec =3D inode_security(file_inode(file));
>         return avc_has_perm(sid, isec->sid, SECCLASS_SYSTEM,
> -                               SYSTEM__MODULE_LOAD, &ad);
> +                               requested, &ad);
>  }
>
>  static int selinux_kernel_read_file(struct file *file,
> @@ -4131,10 +4128,32 @@ static int selinux_kernel_read_file(struct file *=
file,
>                                     bool contents)
>  {
>         int rc =3D 0;
> -
> +       BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
> +                 "New kernel_read_file_id introduced; update SELinux!");
>         switch (id) {
> +       case READING_FIRMWARE:
> +               rc =3D selinux_kernel_load_from_file(contents ? file : NU=
LL,
> +                               SYSTEM__FIRMWARE_LOAD);
> +               break;
>         case READING_MODULE:
> -               rc =3D selinux_kernel_module_from_file(contents ? file : =
NULL);
> +               rc =3D selinux_kernel_load_from_file(contents ? file : NU=
LL,
> +                               SYSTEM__MODULE_LOAD);
> +               break;
> +       case READING_KEXEC_IMAGE:
> +               rc =3D selinux_kernel_load_from_file(contents ? file : NU=
LL,
> +                               SYSTEM__KEXEC_IMAGE_LOAD);
> +               break;
> +       case READING_KEXEC_INITRAMFS:
> +               rc =3D selinux_kernel_load_from_file(contents ? file : NU=
LL,
> +                               SYSTEM__KEXEC_INITRAMFS_LOAD);
> +               break;
> +       case READING_POLICY:
> +               rc =3D selinux_kernel_load_from_file(contents ? file : NU=
LL,
> +                               SYSTEM__POLICY_LOAD);
> +               break;
> +       case READING_X509_CERTIFICATE:
> +               rc =3D selinux_kernel_load_from_file(contents ? file : NU=
LL,
> +                               SYSTEM__X509_CERTIFICATE_LOAD);
>                 break;
>         default:
>                 break;
> @@ -4146,10 +4165,27 @@ static int selinux_kernel_read_file(struct file *=
file,
>  static int selinux_kernel_load_data(enum kernel_load_data_id id, bool co=
ntents)
>  {
>         int rc =3D 0;
> -
> +       BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
> +        "New kernel_load_data_id introduced; update SELinux!");
>         switch (id) {
> +       case LOADING_FIRMWARE:
> +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__FIRMWA=
RE_LOAD);
> +               break;
>         case LOADING_MODULE:
> -               rc =3D selinux_kernel_module_from_file(NULL);
> +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__MODULE=
_LOAD);
> +               break;
> +       case LOADING_KEXEC_IMAGE:
> +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__KEXEC_=
IMAGE_LOAD);
> +               break;
> +       case LOADING_KEXEC_INITRAMFS:
> +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__KEXEC_=
INITRAMFS_LOAD);
> +               break;
> +       case LOADING_POLICY:
> +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__POLICY=
_LOAD);
> +               break;
> +       case LOADING_X509_CERTIFICATE:
> +               rc =3D selinux_kernel_load_from_file(NULL,
> +                               SYSTEM__X509_CERTIFICATE_LOAD);
>                 break;
>         default:
>                 break;
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 03e82477dce9..cfac41d12f7d 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -63,7 +63,9 @@ const struct security_class_mapping secclass_map[] =3D =
{
>         { "process2", { "nnp_transition", "nosuid_transition", NULL } },
>         { "system",
>           { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
> -           "module_request", "module_load", NULL } },
> +           "module_request", "module_load", "firmware_load",
> +           "kexec_image_load", "kexec_initramfs_load", "policy_load",
> +           "x509_certificate_load", NULL } },
>         { "capability", { COMMON_CAP_PERMS, NULL } },
>         { "filesystem",
>           { "mount", "remount", "unmount", "getattr", "relabelfrom",
> --
> 2.48.1
>
