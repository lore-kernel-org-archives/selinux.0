Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA57318ED2
	for <selinux@vger.kernel.org>; Mon, 13 Apr 2026 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100698; cv=pass; b=A1VeiLOJfzXjRH8/IraaUdkBSJfxnnIbjgoRf2FAlXG+f343mtxXz8N0pWn4GLtmXgfPfk/KKJJwxP+rVXmYJ0Hrh6bFDydgpZ/yXgPsj/i6rVQqFxAoX/ce3Q+LlM84tggXGdsMXAjlRAmJ9OAiv+gnlwvKrHz+yCHmk2hgeuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100698; c=relaxed/simple;
	bh=zbyMKyJ30RCGOwXpD3DoxiFNGJy0XM7ArVHxPMfMSMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHhO0JyJ6tHocojZwdC7T6z5xQaeA+nYStJfSG3E+ZGi06kKiCqrN7jB46LNDFYUu86huXxgu3efFOW3/r4EH+QcfTTcaN0C7Htu+sIMYgQHOyf4/ZCwSOgVvsdG5oWUtfISbVqgy5rXjFKHgU28PrAHGNNZllMUbdJGM1g7RH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMoczvND; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMoczvND"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70c112cb61so3020547a12.0
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2026 10:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776100696; cv=none;
        d=google.com; s=arc-20240605;
        b=MReevz0Ehkc1uAKFK/uXwm07x010h5MdGrFQSUcM6DOVc0vmagI8pmPH9X8JV7qJq9
         LItmiOvyswaMPJ+If0IWhMkxxIHwXAAQtKPxsgeCkGRSQeiKxrymsd+FzpuqKNZQiCCb
         kwdvjo09voKGLQ6OaY0uJoC6OtnKqkmX2sybQ2BY9TqCrf9XI4ZU6q+wFKl+qBW86uNT
         9ZoJNsKtwYD0OECLXRmTEPGOqDPDAFui4PgOUzHe22XQd/yjMcmeTIJCX05QwYepvHZG
         7Qx0xK5EVwU30m0veJOGzLu2GeVgIsGjxCvvp3duzdS+kTNomCehTbqHcr09Z+WXx+8O
         HAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F15VRocv2P4WxR2dcWf1P3WLCWVPf+xJP5ArIPyWN8M=;
        fh=IGfiONjBC3hQH5RIAtRE/kZppo4L6aXJ/2v0lQW7DGI=;
        b=YDc32avWa7CI8MHUSLdCBfnU/OoZG/nUCMcgqftOzfvaoe0qEBoi1ECz5EIUbWyMc2
         bV+FSEz677EUOHClDtuPpF+VvCBwvrdTxXhKJu+rPn93bIrRSlflEUNVkovF9wyo53qK
         baFuLErw6t5D9kLv7PgOuQmlyjA+dmwKnVsKnZV2e4uhWVRGy6YU9fjqQbbKUOZ8wsGO
         4jknUk7ZZOhH0jNP1kc7D1MHF7516vgfHQY84AD4c1FcbwnqpzFH2u5IeQKb7ac3KMIs
         PrxSMbqsfSW4GKstm/orlG8OCg0vMcBXqHzOagX1gdEV9rsZuGofyuDyZ4A/hb8zbZJR
         aZqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100696; x=1776705496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F15VRocv2P4WxR2dcWf1P3WLCWVPf+xJP5ArIPyWN8M=;
        b=TMoczvNDmalCgyZurGKDOLxQGEFGdfERGtj3ontNbI1i946/LWfba62uKU5vpVLwkg
         On/v3Z/UOVx3hYGHJJwA3g714Qj7sq9qquNHcHPGmXXlxagvhZQsJzwRdwa7/NPZg3ov
         9UAEkACblJAZoViz6Aj7/0y/cM8/6q5mhhpbRoHnq54uguX1LpZC4zquW7EtagAM9a98
         ixI7NwuZUOnIm9LWhV0+8E/bLEDMlQ9WG2bnam+Si5ZLgL7vJL7TB4n0eu2Bdvz/Br9B
         kqlKvnmQmlbrvuAPscGCXkAwCG9LV5UwcnvzbrwrPiWZAND8ORpuxHKwFw2e7LYLh7pW
         fLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100696; x=1776705496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F15VRocv2P4WxR2dcWf1P3WLCWVPf+xJP5ArIPyWN8M=;
        b=hijBmQihj+65KKeGuriOOe/EzD8unK7RlLpbkA9ksnTgWbu14H2hjgTlTAN+2115wC
         XTYIPg34Kq6hX8W7FRlSOBmjUTKGdl8W7oiIicuc7OmUsn9diV8Fr4Qr8Ke7/Oz4OyIk
         qawdvyCha+lfbK2jzUIH7LAtFkLbMmPX5N6mfqSsN8pfrf/e4SQFXYMHda1IccJyr/GC
         g/xtHe2LVJEBbqgL/mwgtiqQxeD3/ZoQJgSThTtjqN87gOonAh5Sr0I0xwmLgr2tfvvk
         tJZULvh6G5WmRChKyUFAOjrrUbmvPg75CzAnbnUrdqeN14pPgtWasSA0WOdAxV77w5xq
         DFRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CS3WGBEN5vZWtdyYB2/cwlELKGf2BwrEkZN4aGeNdBptLxuW12wlRVmEn0H/YVsrNwt4V7XUL@vger.kernel.org
X-Gm-Message-State: AOJu0YyXWv+QMjT6lVDB3c/ckNZSEwc2M/3LCWvHIXfr4DEgDvCHT2N9
	D3z6VNl/9MRKSmvFu8GXk1VuUmssUDx8pArvslSFb75K1JzVW91JBSQRSX5rkSFIyugKyvV8o4A
	HfI36f8vxyT7K/BkTSDBljVis/z9w0bM=
X-Gm-Gg: AeBDietg1J/29GGhsi950cWEEB0RlLn42H7L6BEfk4cyRfC4h+Lq9xzr7laIt1khvxb
	ZkxQMEUyRkJP4jLZ5JWF+N+rL73EdIK1f+YEAMomifSGZ8PyTZEqh+JaXatD9xFlFrG64UUljHi
	KKnLzjoeKM7Lnwhl6IXmxKzu1z871WTB1Nu7bDWROn2xvtjtR6FjLUCaiLWOkQXdUcT7PQEbf6u
	6sjUXNwzrzl2zhF7Jd7Fe24SbzPt1diDxacPv0KywgDFD8eyhTvhmhWr0Iy3qL7UXcnZOafZnh5
	+srsR1o=
X-Received: by 2002:a05:6a00:f99:b0:823:9c6:1985 with SMTP id
 d2e1a72fcca58-82f0c288c79mr14697645b3a.16.1776100695927; Mon, 13 Apr 2026
 10:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <20260318184400.3502908-8-song@kernel.org>
In-Reply-To: <20260318184400.3502908-8-song@kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 13 Apr 2026 13:18:04 -0400
X-Gm-Features: AQROBzDMToOoMkTBxw1JVrqkX7aPgT7CuehV5_REXeUNyYzsXUc_KGEXz4KU6kY
Message-ID: <CAEjxPJ69Fqah25_q1V=VrO5cyXNOv0HYjzky=FQ62QycPb_QFQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] lsm: Remove security_sb_mount and security_move_mount
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, john.johansen@canonical.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 2:44=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Now that all LSMs have been converted to granular mount hooks,
> remove the old hooks:
>
> - security_sb_mount(): removed from lsm_hook_defs.h, security.h,
>   security.c, and its call in path_mount().
> - security_move_mount(): removed and replaced by security_mount_move()
>   in do_move_mount(). All LSMs now use mount_move exclusively.
>
> Code generated with the assistance of Claude, reviewed by human.
>
> Signed-off-by: Song Liu <song@kernel.org>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com # for selinux on=
ly

> ---
>  fs/namespace.c                |  6 +-----
>  include/linux/lsm_hook_defs.h |  4 ----
>  include/linux/security.h      | 16 ---------------
>  kernel/bpf/bpf_lsm.c          |  2 --
>  security/apparmor/lsm.c       |  1 -
>  security/landlock/fs.c        |  1 -
>  security/security.c           | 38 -----------------------------------
>  security/selinux/hooks.c      |  2 --
>  8 files changed, 1 insertion(+), 69 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index de33070e514a..ba5baccdde67 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4108,7 +4108,6 @@ int path_mount(const char *dev_name, const struct p=
ath *path,
>                 const char *type_page, unsigned long flags, void *data_pa=
ge)
>  {
>         unsigned int mnt_flags =3D 0, sb_flags;
> -       int ret;
>
>         /* Discard magic */
>         if ((flags & MS_MGC_MSK) =3D=3D MS_MGC_VAL)
> @@ -4121,9 +4120,6 @@ int path_mount(const char *dev_name, const struct p=
ath *path,
>         if (flags & MS_NOUSER)
>                 return -EINVAL;
>
> -       ret =3D security_sb_mount(dev_name, path, type_page, flags, data_=
page);
> -       if (ret)
> -               return ret;
>         if (!may_mount())
>                 return -EPERM;
>         if (flags & SB_MANDLOCK)
> @@ -4538,7 +4534,7 @@ static inline int vfs_move_mount(const struct path =
*from_path,
>  {
>         int ret;
>
> -       ret =3D security_move_mount(from_path, to_path);
> +       ret =3D security_mount_move(from_path, to_path);
>         if (ret)
>                 return ret;
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 6bb67059fb43..95537574c40b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -69,8 +69,6 @@ LSM_HOOK(int, 0, sb_remount, struct super_block *sb, vo=
id *mnt_opts)
>  LSM_HOOK(int, 0, sb_kern_mount, const struct super_block *sb)
>  LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block=
 *sb)
>  LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
> -LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path=
,
> -        const char *type, unsigned long flags, void *data)
>  LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
>  LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
>          const struct path *new_path)
> @@ -79,8 +77,6 @@ LSM_HOOK(int, 0, sb_set_mnt_opts, struct super_block *s=
b, void *mnt_opts,
>  LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
>          struct super_block *newsb, unsigned long kern_flags,
>          unsigned long *set_kern_flags)
> -LSM_HOOK(int, 0, move_mount, const struct path *from_path,
> -        const struct path *to_path)
>  LSM_HOOK(int, 0, mount_bind, const struct path *from, const struct path =
*to,
>          bool recurse)
>  LSM_HOOK(int, 0, mount_new, struct fs_context *fc, const struct path *mp=
,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 6e31de9b3d68..3610a49304c6 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -372,8 +372,6 @@ int security_sb_remount(struct super_block *sb, void =
*mnt_opts);
>  int security_sb_kern_mount(const struct super_block *sb);
>  int security_sb_show_options(struct seq_file *m, struct super_block *sb)=
;
>  int security_sb_statfs(struct dentry *dentry);
> -int security_sb_mount(const char *dev_name, const struct path *path,
> -                     const char *type, unsigned long flags, void *data);
>  int security_sb_umount(struct vfsmount *mnt, int flags);
>  int security_sb_pivotroot(const struct path *old_path, const struct path=
 *new_path);
>  int security_sb_set_mnt_opts(struct super_block *sb,
> @@ -384,7 +382,6 @@ int security_sb_clone_mnt_opts(const struct super_blo=
ck *oldsb,
>                                 struct super_block *newsb,
>                                 unsigned long kern_flags,
>                                 unsigned long *set_kern_flags);
> -int security_move_mount(const struct path *from_path, const struct path =
*to_path);
>  int security_mount_bind(const struct path *from, const struct path *to,
>                         bool recurse);
>  int security_mount_new(struct fs_context *fc, const struct path *mp,
> @@ -818,13 +815,6 @@ static inline int security_sb_statfs(struct dentry *=
dentry)
>         return 0;
>  }
>
> -static inline int security_sb_mount(const char *dev_name, const struct p=
ath *path,
> -                                   const char *type, unsigned long flags=
,
> -                                   void *data)
> -{
> -       return 0;
> -}
> -
>  static inline int security_sb_umount(struct vfsmount *mnt, int flags)
>  {
>         return 0;
> @@ -852,12 +842,6 @@ static inline int security_sb_clone_mnt_opts(const s=
truct super_block *oldsb,
>         return 0;
>  }
>
> -static inline int security_move_mount(const struct path *from_path,
> -                                     const struct path *to_path)
> -{
> -       return 0;
> -}
> -
>  static inline int security_mount_bind(const struct path *from,
>                                       const struct path *to, bool recurse=
)
>  {
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 65235d70ee23..3e61c54f9b48 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -350,7 +350,6 @@ BTF_ID(func, bpf_lsm_release_secctx)
>  BTF_ID(func, bpf_lsm_sb_alloc_security)
>  BTF_ID(func, bpf_lsm_sb_eat_lsm_opts)
>  BTF_ID(func, bpf_lsm_sb_kern_mount)
> -BTF_ID(func, bpf_lsm_sb_mount)
>  BTF_ID(func, bpf_lsm_sb_remount)
>  BTF_ID(func, bpf_lsm_sb_set_mnt_opts)
>  BTF_ID(func, bpf_lsm_sb_show_options)
> @@ -383,7 +382,6 @@ BTF_ID(func, bpf_lsm_task_prctl)
>  BTF_ID(func, bpf_lsm_task_setscheduler)
>  BTF_ID(func, bpf_lsm_task_to_inode)
>  BTF_ID(func, bpf_lsm_userns_create)
> -BTF_ID(func, bpf_lsm_move_mount)
>  BTF_ID(func, bpf_lsm_mount_bind)
>  BTF_ID(func, bpf_lsm_mount_new)
>  BTF_ID(func, bpf_lsm_mount_remount)
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 7fe774535992..13a8049b1b59 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1713,7 +1713,6 @@ static struct security_hook_list apparmor_hooks[] _=
_ro_after_init =3D {
>         LSM_HOOK_INIT(capget, apparmor_capget),
>         LSM_HOOK_INIT(capable, apparmor_capable),
>
> -       LSM_HOOK_INIT(move_mount, apparmor_move_mount),
>         LSM_HOOK_INIT(mount_bind, apparmor_mount_bind),
>         LSM_HOOK_INIT(mount_new, apparmor_mount_new),
>         LSM_HOOK_INIT(mount_remount, apparmor_mount_remount),
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 6e810550efcb..5f723a70baa4 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1857,7 +1857,6 @@ static struct security_hook_list landlock_hooks[] _=
_ro_after_init =3D {
>         LSM_HOOK_INIT(mount_reconfigure, hook_mount_reconfigure),
>         LSM_HOOK_INIT(mount_change_type, hook_mount_change_type),
>         LSM_HOOK_INIT(mount_move, hook_move_mount),
> -       LSM_HOOK_INIT(move_mount, hook_move_mount),
>         LSM_HOOK_INIT(sb_umount, hook_sb_umount),
>         LSM_HOOK_INIT(sb_remount, hook_sb_remount),
>         LSM_HOOK_INIT(sb_pivotroot, hook_sb_pivotroot),
> diff --git a/security/security.c b/security/security.c
> index 356ef228d5de..af95868af34d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1039,29 +1039,6 @@ int security_sb_statfs(struct dentry *dentry)
>         return call_int_hook(sb_statfs, dentry);
>  }
>
> -/**
> - * security_sb_mount() - Check permission for mounting a filesystem
> - * @dev_name: filesystem backing device
> - * @path: mount point
> - * @type: filesystem type
> - * @flags: mount flags
> - * @data: filesystem specific data
> - *
> - * Check permission before an object specified by @dev_name is mounted o=
n the
> - * mount point named by @nd.  For an ordinary mount, @dev_name identifie=
s a
> - * device if the file system type requires a device.  For a remount
> - * (@flags & MS_REMOUNT), @dev_name is irrelevant.  For a loopback/bind =
mount
> - * (@flags & MS_BIND), @dev_name identifies the        pathname of the o=
bject being
> - * mounted.
> - *
> - * Return: Returns 0 if permission is granted.
> - */
> -int security_sb_mount(const char *dev_name, const struct path *path,
> -                     const char *type, unsigned long flags, void *data)
> -{
> -       return call_int_hook(sb_mount, dev_name, path, type, flags, data)=
;
> -}
> -
>  /**
>   * security_sb_umount() - Check permission for unmounting a filesystem
>   * @mnt: mounted filesystem
> @@ -1141,21 +1118,6 @@ int security_sb_clone_mnt_opts(const struct super_=
block *oldsb,
>  }
>  EXPORT_SYMBOL(security_sb_clone_mnt_opts);
>
> -/**
> - * security_move_mount() - Check permissions for moving a mount
> - * @from_path: source mount point
> - * @to_path: destination mount point
> - *
> - * Check permission before a mount is moved.
> - *
> - * Return: Returns 0 if permission is granted.
> - */
> -int security_move_mount(const struct path *from_path,
> -                       const struct path *to_path)
> -{
> -       return call_int_hook(move_mount, from_path, to_path);
> -}
> -
>  /**
>   * security_mount_bind() - Check permissions for a bind mount
>   * @from: source path
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 415b5541ab9e..446e9e242134 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7477,8 +7477,6 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>         LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
>         LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
>
> -       LSM_HOOK_INIT(move_mount, selinux_move_mount),
> -
>         LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security)=
,
>         LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files=
_as),
>
> --
> 2.52.0
>
