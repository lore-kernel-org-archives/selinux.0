Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A5346ACD
	for <selinux@vger.kernel.org>; Mon, 13 Apr 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100625; cv=pass; b=YZNRT9g3L+aPFD9r8F9R1DY1QcsQNE1I8tCDgCeRC5rYKidnPzZxHjws1YW0HAMzZX9+e65v5sEiINQvy0t0rCQPlt+bOBzMwyVHq1pTuOMhrH2FaZWvR4vW76ilI2QLwiUnNz0S3Fe4yXTr6m9pnWfqVBQcWikvhsjQC8n7guo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100625; c=relaxed/simple;
	bh=Z+b0ZECAqJfNW/F2wJOeNwpfdYXiYK+ERVdEdDe+Zms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1Oegb7G8zqqa/0qH7lS4xE3l/w/NMKahsuQrHYc7coORb9UNp33GkGh9cqZvpVw9333QSzfsdNDJ5dMWogzUSNWfX3M6ohpLsWu1hHLYzP+RC+laJZ8zpo8LlsuFi7H3NGSpc9racBoGv8HmGHEpAGjIYJKuk+pH+44fbHQ7LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mg9yOP+a; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg9yOP+a"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f344e880bso1032498b3a.3
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2026 10:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776100624; cv=none;
        d=google.com; s=arc-20240605;
        b=Ebo9F69+X2iAi+cXs2S2Zw2LKMgUpZXum5LTHPPqmzKIp1JVQg1AoBFeI2E0eiVm4Y
         moWveo5vz9aVxgbWxNq1PlMhM/TSmW41wgvDFtVf715XnHhD9xpMXX2dH5+1h2oDRWgY
         H0jHTfL7h/rln5/M5RTPfh2qMi7mg1cmThTlSLPR8cnxED0o4rY72NhFYNjfNJqtZZ1Q
         wPqTtm5wuDVgt+dwdMnPKE0UVSeRZJVyd0lqzoD5zSPppoPXEgQMiCOQkC572Z/QYoHe
         TnovI+3rHX+JcMuIApB0/ObWtyUa5uapAMb3wFnnbb9nXRRuQHhXsKYFyE+rIn7Pd7b7
         askQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BRAbh5NTmH7fPoUJt2iXhkljH90jFoJ00lEuAgJuvXo=;
        fh=9r0oqn1uMx8nxqrUiH4eRr8gurMDC2rLwMVRpYjDMic=;
        b=fRKloc0cOpkfxzvLYSckEc4w9vuW7bCJVgyNEcBN2RVyHxwE/5igJy5aT/yWzrG+8X
         wjZPXKw/Y72Lz681lT8ulY142I5WIPP79h+l+L9SZw5evQXr5JhhhxGEA3U5i+idjYHq
         9rtCWurK2rAFJA82PDnqRF5VRCxtPZ1rMHfDg+SQgwwv3SeKAwkoFJdVlSSdTncgDO35
         M4benUYu+GE+738b2fGk2TURRKGsx+YwOL/WSKshoEO6Qq3z9jZKzCzjPTi+P74ImG3Z
         JpEtM2PsZElyVcozXgVEScDFIQw8QrKG+S13ornX/SioDGFfL0yuNXXHCa6T36KFiars
         eexg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100624; x=1776705424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRAbh5NTmH7fPoUJt2iXhkljH90jFoJ00lEuAgJuvXo=;
        b=mg9yOP+aAdi9JL4gAaBghM3CSTkqAHQhe/NqMu/v5a4EKu/UYxDhF22zW2WGJXB4vb
         7LtCysAvS5QvrEo5JrbLKKiepmxSwrWwJgDdC8oRD/7+0RVe2pGDnXlFpSCsQ+DI2VFm
         /SSljwPCGkOSp29sUFIycWEWEbL5TqJkGAOrPq3OlOzuBiNaAE5JAqTQ3S/buc92OKw9
         TLFzsW7lFbsAaY3UpljzYcaG88O1rqy8VwHK1WCUnoUqtpfHVQhAcU7iGYHHUW3s503d
         hcw3gKI/ykxXG8EdqTOEu2IDAK8yf1uagWc9i6pWdM0eRTr+pSXt5nqIKBxCIy5KorQn
         Ua6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100624; x=1776705424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BRAbh5NTmH7fPoUJt2iXhkljH90jFoJ00lEuAgJuvXo=;
        b=NRkLPhHT9cmLyPO3tyG3qsP1pvqCA9fzjwmIG4f8PbQ3TbfiXX+UX15kMxTnzuc9ec
         xDzey9H0FQIiNThlicxchwgLYPf3htC1VYV3nicT/9qfOZo6B2toxF3WCyKdiEx5LFxM
         0G1atYlDt5TdxioPWSMolCeZVvPZm0YP37Hq7t+OzCEEsxptdyXm/iUM+sUpc0LZC5Sn
         JY16LGu8+SXYt8sF+Xcuj+vslZ3KmD2dzzyF4UoFSNNUvKITc/2JgV+QzDWigTbY5OxQ
         3FYvdbIyKjka5pfP3CuTZZG9iJ5xY/7p0LiQ29rUd+7Kjvpx64puYX6C6auXHuWuhP54
         osjA==
X-Forwarded-Encrypted: i=1; AFNElJ8+nUmdaBfPLqKCcDJMl/bwu04xB1LxulZVBm/DnMHR9BOZbZ1Gpqf9SOeLpqUyvbPOKPkQtkt7@vger.kernel.org
X-Gm-Message-State: AOJu0YwJpTb6oOk8yLC0xzzyjLPLUtvQ/MhthmpeWPENDyv5ED+yCjvX
	hrRsUAF23rf//O/W0Y21yDfpv4EtnkQxaUuPG+yNMoJPQuY+loBK2aB8F/23115DCEu39Ozo3P5
	Wh6Q2t0dO6D1hnzRgrYKgyoFOy6QqjpU=
X-Gm-Gg: AeBDietlizm3VlGRhab+GxI74lxnRTSEoEKZccTkoQbe8bTJrPEco0v242yfjxqFmii
	TthHAHea88Lc5LUO/kdIrSsKZafUBZK9Z/L4DLOfw0uGa6CmLYv8xfuKV89MXF0Unvc/5NG6tAn
	NlCE7TPjDeCR4k5yaoRw4iMAvt5a1C+SaeE4NuhGlm/KtT9yYoEkyJsitCGS9mcddayyB/vvciF
	pX9vpeohP04jUksM+p49Z3zrD0LDpeiBb9dd47vt2fNPQlYMhCu0IASo1+4E/eCWnYlfCZgD4B4
	GO4uwWc=
X-Received: by 2002:a05:6a00:1f0e:b0:82f:5125:a327 with SMTP id
 d2e1a72fcca58-82f5125a71emr888914b3a.27.1776100623918; Mon, 13 Apr 2026
 10:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <20260318184400.3502908-5-song@kernel.org>
In-Reply-To: <20260318184400.3502908-5-song@kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 13 Apr 2026 13:16:52 -0400
X-Gm-Features: AQROBzD6lyXWHoKW5RWqw1gdlCZn4rvcVErICJ7ENPulk3A0gDivj2NjCp7Gp1A
Message-ID: <CAEjxPJ5iDbnZj9gXb=GHORoXGwRP4EG0yUEH8MPmGqJWZEONWQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] selinux: Convert from sb_mount to granular mount hooks
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, john.johansen@canonical.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 2:44=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Replace selinux_mount() with granular mount hooks, preserving the
> same permission checks:
>
> - mount_bind, mount_new, mount_change_type: FILE__MOUNTON
> - mount_remount, mount_reconfigure: FILESYSTEM__REMOUNT
> - mount_move: FILE__MOUNTON (reuses selinux_move_mount)
>
> The flags and data parameters are unused by SELinux.
>
> Code generated with the assistance of Claude, reviewed by human.
>
> Signed-off-by: Song Liu <song@kernel.org>

Not expecting you to do this, but after this lands, I think it would
make sense to revisit the SELinux checks and further specialize them
while providing backward compatibility.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com

> ---
>  security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d8224ea113d1..415b5541ab9e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2778,19 +2778,37 @@ static int selinux_sb_statfs(struct dentry *dentr=
y)
>         return superblock_has_perm(cred, dentry->d_sb, FILESYSTEM__GETATT=
R, &ad);
>  }
>
> -static int selinux_mount(const char *dev_name,
> -                        const struct path *path,
> -                        const char *type,
> -                        unsigned long flags,
> -                        void *data)
> +static int selinux_mount_bind(const struct path *from, const struct path=
 *to,
> +                             bool recurse)
>  {
> -       const struct cred *cred =3D current_cred();
> +       return path_has_perm(current_cred(), to, FILE__MOUNTON);
> +}
>
> -       if (flags & MS_REMOUNT)
> -               return superblock_has_perm(cred, path->dentry->d_sb,
> -                                          FILESYSTEM__REMOUNT, NULL);
> -       else
> -               return path_has_perm(cred, path, FILE__MOUNTON);
> +static int selinux_mount_new(struct fs_context *fc, const struct path *m=
p,
> +                            int mnt_flags, unsigned long flags, void *da=
ta)
> +{
> +       return path_has_perm(current_cred(), mp, FILE__MOUNTON);
> +}
> +
> +static int selinux_mount_remount(struct fs_context *fc, const struct pat=
h *mp,
> +                                int mnt_flags, unsigned long flags,
> +                                void *data)
> +{
> +       return superblock_has_perm(current_cred(), fc->root->d_sb,
> +                                  FILESYSTEM__REMOUNT, NULL);
> +}
> +
> +static int selinux_mount_reconfigure(const struct path *mp,
> +                                    unsigned int mnt_flags,
> +                                    unsigned long flags)
> +{
> +       return superblock_has_perm(current_cred(), mp->dentry->d_sb,
> +                                  FILESYSTEM__REMOUNT, NULL);
> +}
> +
> +static int selinux_mount_change_type(const struct path *mp, int ms_flags=
)
> +{
> +       return path_has_perm(current_cred(), mp, FILE__MOUNTON);
>  }
>
>  static int selinux_move_mount(const struct path *from_path,
> @@ -7449,7 +7467,12 @@ static struct security_hook_list selinux_hooks[] _=
_ro_after_init =3D {
>         LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>         LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
>         LSM_HOOK_INIT(sb_statfs, selinux_sb_statfs),
> -       LSM_HOOK_INIT(sb_mount, selinux_mount),
> +       LSM_HOOK_INIT(mount_bind, selinux_mount_bind),
> +       LSM_HOOK_INIT(mount_new, selinux_mount_new),
> +       LSM_HOOK_INIT(mount_remount, selinux_mount_remount),
> +       LSM_HOOK_INIT(mount_reconfigure, selinux_mount_reconfigure),
> +       LSM_HOOK_INIT(mount_change_type, selinux_mount_change_type),
> +       LSM_HOOK_INIT(mount_move, selinux_move_mount),
>         LSM_HOOK_INIT(sb_umount, selinux_umount),
>         LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
>         LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
> --
> 2.52.0
>
