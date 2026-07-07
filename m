Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF4A33859C
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439448; cv=pass; b=hxomEfLvJQdV9Kp+3ljMTfrVQ70afcU0ssCWBue82PbJ1hK3EWoboJHr9Hme+2fkgMfNT+EgpHGVwWhsAYNqbDs8GS57+Kw1+PIhPuEqAUbmPqYJf2Hqv8WaPKqnNJBFHvr/S7QySQ2UUTiviq99eHvolk0DWdrCimSQ3y8qIM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439448; c=relaxed/simple;
	bh=zP8IfLOYBlKSlOcWYBg9GCYs2/VaOel1Puyz1WzqU1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erKdqCW/j3KW/cK/ah56aRODv5SSmEhpbtdP33rxoEJl4acHNr/sxwBia/pqju948GKqQhynkrAwkjFwv9UmwPgbzaJygMDYi+vx9Gk+pPmXbusDVmmKNbWPtav/olqjWaHCs0L+AwYM58HpHmvyJW6m7GSmtIEdbg8Epmvc4Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdfoHOJM; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdfoHOJM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423f236418so2953476b3a.1
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 08:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783439446; cv=none;
        d=google.com; s=arc-20260327;
        b=pkSSQrbBEpC4RqOmO/o0LqCVHHDQ84/Ot8vX0TOHpU0v8yRX4AJxs9N98W0UZKJKSM
         SDWQgnqIGDT/u5KoNSZ5n5efuTScwKaECWxfZobCFeg4St+d6i1GXhbvhrg1PeKOw/86
         kTdUNfe9Vn/6tulkvJuYR/Gsv5PDffpvNTaID2aV+V8lj1g+gB/cWkRIZWZmPbqG0iG1
         aDQ8alC/nuSW5pDMVRyx3ZpzQJAHvcEMhHuGYTJKjPpGK2VNw72gb8U8H48f+vyVGMyz
         E9vFLxlNbix+dbmCFv2UguuVKmXNJO28qfd25fgc1Q7N6aGkH5OXNyLWTR7PcEjg/4Eb
         5s3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7hf+mjE+GA5hWF0lSrdl5bDTgjfecb7SyvsM3h6j6+g=;
        fh=+O5qvHhNyEQOeRss5S0lbkmhZesXPyLJXCnCSsiG68M=;
        b=XCzmcl/Xtr9/mSpYEzzKbLfrDIPKzJtL6EGPzNzYul8AlmQTjo8tGbJpbe4TfEn/2V
         WfSWDKKCEiqC4H1UQfpxN6MwNzk3C2sb2QO2+EQ2XWyp4glcCWHpLm3cqeVlVr7PRE+s
         q8rKGcYRsJR4vmqNYURL5+BGC0Jir9JDDM6vEVKgLViISexYMAq6747z3imPWlP99Tyc
         u3+lTWRc+K9kAaWbLEhzs1HEf9AAjEItd3hSbhOofpNufiZmEQ16sXOiZY6nPiPWklR2
         jenVTIn433WzkFLtwO0yGl/JsMMYiOAlCptnw7VlFUR1Iso18YAsvTNQjIIxWYBtxlxp
         gnmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783439446; x=1784044246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7hf+mjE+GA5hWF0lSrdl5bDTgjfecb7SyvsM3h6j6+g=;
        b=fdfoHOJMYOwfjzw7+Mhyhh6s01QSXeFf9vVkC3SBDS7hiSkowAmSVk/3lPs/o54AeR
         k97nbTIvwKhm4ZocL+SXm45tKAyFN69kpRZSNoipVOHTjjcRbmmVJJ+hyuQ5bArTmhz7
         wXiffmOiBCjD4Jg2QIZ4A9S+2CkpKvaPBfD3TpKzijTbh5saq+aT0QfpFalcMsqWjLWl
         AFi6GmvYchvtvQMSrHyqqN2pdQeMIWTFm4qZG6ldI605kezWf4I2cobc3KnEvqhDb+EQ
         4eB9TK+CMszVSAOcgdI/8NRIjpqwIkf3WLkigFAzlowuCbfqsRmwDY6VPanTbx3nJgIV
         zsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783439446; x=1784044246;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7hf+mjE+GA5hWF0lSrdl5bDTgjfecb7SyvsM3h6j6+g=;
        b=rvGRPim+qtWTbt066nSitp5pDF0/E/5lw4V4De0I1NGRizlLVKDJ7QzFUIT+ERBRXS
         AhZ6cceKchVyQlY3QA9QUaV4il6d7nD9z5S59pgl6N+We/oU55wwQKKx7/WOa45SGqpJ
         cSgGDIun/xK6W8sviClncFMJ3Xp3RINIKdojUxbffgawmkcwm39MUxzVPpM4gi/TGASp
         BIxT0WsTJWMLFy5MVqDyalRgQ5FWi8b/c261LqIw/hmbOSFGpkQcKvyN2GYIniLv3J4t
         TK6Fqy9IDX43KaDz4kaE33WstrL/r+HRkYtrJadfqVB6lc19N4xsGh3tY0qMxmprWrLM
         O7OQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7vBgxWJ+PLhczJ4X79pxDvD7tXn/A4VLUgB+/8/3eaMLRg4Zli1k7mz4UZl2rv6DrA2/uzuYf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XRWSjOnD7HSPT6ZhSmCoRupMlpeGU0f0rQ45Swdq9du87tXQ
	SlXib3Yqkd+zlZUpw8e1Jo/k6nussqUUqwPhYBKcnIw9orTJuwvsruwrkkuMt7RcVOom9kpC/qP
	gx7MErHf3SSKo5i3H4JcYOi58XCN7gxsf/gz3
X-Gm-Gg: AfdE7cmGTp1k9cytxqTmXW/OD6KAUIW5GMM0N0kRT9Vv6HIWWPBHezfNuZLreKZuzvZ
	adQWrm77snBJtoBrTa0EMv01NeIMXP45W7EW0WDf8068paGTGJV1lUkrYqJJm+mKiMeQXr2A7r7
	3l7KI0c8A9i1CmNXQLNyKb8XO6XyburGM2WjJFH2hwm+BJ64uIAKPxwwZI+ktaXTCGWUF6BbWqU
	7AMaMbKTWm04/MsoLp4xQXrV6KPK2+JyxNlvNc8yDt/IPAJ0IgjuSN7aQVAqOM3aMOOi0xZ
X-Received: by 2002:a05:6a00:3699:b0:845:d274:c01a with SMTP id
 d2e1a72fcca58-84826e7394bmr5867737b3a.51.1783439446399; Tue, 07 Jul 2026
 08:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703114733.1243995-1-omosnace@redhat.com>
In-Reply-To: <20260703114733.1243995-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Jul 2026 11:50:34 -0400
X-Gm-Features: AVVi8CfexIOee4iVVgRQTzjhQ-VcY4eykr7jQlsH4nJY25NQAVTgfcEvJuZKMbE
Message-ID: <CAEjxPJ75Le_hOqNeu2VZ7DvVNBrxn7zo9zD3T3M77BLHscc1bw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix incorrect execmem checks on overlayfs
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 7:47=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> The commit fixing the overlayfs mmap() and mprotect() access checks
> failed to skip the execmem check in __file_map_prot_check() for the case
> where the "mounter check" is being performed. This check should be
> performed only against the credentials of the task that is calling
> mmap()/mprotect(), since it doesn't pertain to the file itself, but
> rather just gates the ability of the calling task to get an executable
> memory mapping in general.
>
> The purpose of the "mounter check" is to guard against using an
> overlayfs mount to gain file access that would otherwise be denied to
> the mounter. For execmem this is not relevant, as there is no further
> file access granted based on it (notice that the file's context is not
> used as the target in the check), so checking it also against the
> mounter credentials would be incorrect.
>
> Fix this by passing a boolean to [__]file_map_prot_check() and
> selinux_mmap_file_common() that indicates if we are doing the "mounter
> check" and skiping the execmem check in that case. Since this boolean
> also indicates if we use current_cred() or the mounter cred as the
> subject, also remove the "cred" argument from these functions and
> determine it based on the boolean and the file struct.
>
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Sashiko noted a possible pre-existing issue in our code regarding how
we are testing for anonymous mappings:
https://lore.kernel.org/selinux/20260703115632.0761F1F000E9@smtp.kernel.org=
/T/#t
which we may want to investigate separately but for this patch:
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/hooks.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1a713d96206f5..87790f6f0d4de 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3969,13 +3969,14 @@ static int selinux_file_ioctl_compat(struct file =
*file, unsigned int cmd,
>
>  static int default_noexec __ro_after_init;
>
> -static int __file_map_prot_check(const struct cred *cred,
> -                                const struct file *file, unsigned long p=
rot,
> -                                bool shared, bool bf_user_file)
> +static int __file_map_prot_check(const struct file *file, unsigned long =
prot,
> +                                bool shared, bool mounter_check,
> +                                bool bf_user_file)
>  {
>         struct inode *inode =3D NULL;
>         bool prot_exec =3D prot & PROT_EXEC;
>         bool prot_write =3D prot & PROT_WRITE;
> +       const struct cred *cred =3D mounter_check ? file->f_cred : curren=
t_cred();
>
>         if (file) {
>                 if (bf_user_file)
> @@ -3984,7 +3985,7 @@ static int __file_map_prot_check(const struct cred =
*cred,
>                         inode =3D file_inode(file);
>         }
>
> -       if (default_noexec && prot_exec &&
> +       if (!mounter_check && default_noexec && prot_exec &&
>             (!file || IS_PRIVATE(inode) || (!shared && prot_write))) {
>                 int rc;
>                 u32 sid =3D cred_sid(cred);
> @@ -4013,11 +4014,11 @@ static int __file_map_prot_check(const struct cre=
d *cred,
>         return 0;
>  }
>
> -static inline int file_map_prot_check(const struct cred *cred,
> -                                     const struct file *file,
> -                                     unsigned long prot, bool shared)
> +static inline int file_map_prot_check(const struct file *file,
> +                                     unsigned long prot, bool shared,
> +                                     bool mounter_check)
>  {
> -       return __file_map_prot_check(cred, file, prot, shared, false);
> +       return __file_map_prot_check(file, prot, shared, mounter_check, f=
alse);
>  }
>
>  static int selinux_mmap_addr(unsigned long addr)
> @@ -4033,9 +4034,11 @@ static int selinux_mmap_addr(unsigned long addr)
>         return rc;
>  }
>
> -static int selinux_mmap_file_common(const struct cred *cred, struct file=
 *file,
> -                                   unsigned long prot, bool shared)
> +static int selinux_mmap_file_common(struct file *file, unsigned long pro=
t,
> +                                   bool shared, bool mounter_check)
>  {
> +       const struct cred *cred =3D mounter_check ? file->f_cred : curren=
t_cred();
> +
>         if (file) {
>                 int rc;
>                 struct common_audit_data ad;
> @@ -4047,15 +4050,16 @@ static int selinux_mmap_file_common(const struct =
cred *cred, struct file *file,
>                         return rc;
>         }
>
> -       return file_map_prot_check(cred, file, prot, shared);
> +       return file_map_prot_check(file, prot, shared, mounter_check);
>  }
>
>  static int selinux_mmap_file(struct file *file,
>                              unsigned long reqprot __always_unused,
>                              unsigned long prot, unsigned long flags)
>  {
> -       return selinux_mmap_file_common(current_cred(), file, prot,
> -                                       (flags & MAP_TYPE) =3D=3D MAP_SHA=
RED);
> +       return selinux_mmap_file_common(file, prot,
> +                                       (flags & MAP_TYPE) =3D=3D MAP_SHA=
RED,
> +                                       false);
>  }
>
>  /**
> @@ -4087,8 +4091,9 @@ static int selinux_mmap_backing_file(struct vm_area=
_struct *vma,
>         if (vma->vm_flags & VM_EXEC)
>                 prot |=3D PROT_EXEC;
>
> -       return selinux_mmap_file_common(backing_file->f_cred, backing_fil=
e,
> -                                       prot, vma->vm_flags & VM_SHARED);
> +       return selinux_mmap_file_common(backing_file, prot,
> +                                       vma->vm_flags & VM_SHARED,
> +                                       true);
>  }
>
>  static int selinux_file_mprotect(struct vm_area_struct *vma,
> @@ -4149,11 +4154,11 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
>                 }
>         }
>
> -       rc =3D __file_map_prot_check(cred, file, prot, shared, backing_fi=
le);
> +       rc =3D __file_map_prot_check(file, prot, shared, false, backing_f=
ile);
>         if (rc)
>                 return rc;
>         if (backing_file) {
> -               rc =3D file_map_prot_check(file->f_cred, file, prot, shar=
ed);
> +               rc =3D file_map_prot_check(file, prot, shared, true);
>                 if (rc)
>                         return rc;
>         }
> --
> 2.55.0
>
