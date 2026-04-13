Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140931F9BC
	for <selinux@vger.kernel.org>; Mon, 13 Apr 2026 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100471; cv=pass; b=ktCQDGDJzN3e4fuC6wqQ+T17ZPhn0c5+/Zb7v1xseuv+sTKIvTdkmZfmTX1xZbTkUypFFCMYUSJj0O0gj0HrEOgbLaLxDDiS50fZCCAfNNphxGJbU6GYjKTgRWuZqqMqzSXHRL3tTXcGZs3jNsE8dvQJ+QZsDXSIzNlAmVe1cew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100471; c=relaxed/simple;
	bh=VEo/oE2HvhgNYpPq6jIVYwyaLzkrrSIVz4Dd73v+Fh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9dhUSV2XdvWrM2m6YOdT7UMfZzMKbzqvkcmQrMte1jzxMmDp+eZm0UiSzNJmeXfKWNhpo5+R7WeraSfluRb6vq8XVumlFo+MGiQFk4/L3WeY9NOQgnL4hzKqL3B8GnykN/PCD73u1gptZ1K9jxM+FXtP0n8elbAaQjRNfoBQcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj5z+on6; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj5z+on6"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c742723c863so3020938a12.0
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2026 10:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776100468; cv=none;
        d=google.com; s=arc-20240605;
        b=EW27+ClegTJ3rXB4iVJ4ASXQ93obyiJ/Z880VcpJjzMB9dRAaPwFFEvmCt/SmylF04
         V2L6SZaQDJf1OPIQZVv9IvjzxxtD+6+oB0G2RMZ1+39uM8fioSLxfgpYAdvBIdtOwWkl
         atjYBb0OpLARhItLSJKbHtRQSZjaAKbjXMI363XvJUGsOtDuBmhC8vih9jgCJUm5Qaxx
         gedxQ6KtSNLhd3ynyyaxKmdGqR1WCnH+rgCf1sKaLKuRWitYynDdHZ8qjM3ZtceOuOOW
         0Oy3/nC4Zj0nQmqwhHbAYsrgnW5a3CcYmjvk/1BySH3mNsSXJpJ1MG6ozZbztL1liV8T
         Q/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QygrDBL2RtJkB6vENTKE5mRPBFDruU3+BPQuEukfRvo=;
        fh=ZWVI/z+9t8nYVekNG4JuFJuU+KZMHV6NyVTR6Z7Mb0Y=;
        b=avGgGsTbIAASZoYHG49RAXcj+kJk0fnnCFLJoz0SRoHdFWz5uDMPfUKIyVaxhZUuFE
         wk6dSlWwpZV/lKnfgCEBE9wHhtzKdaAKWxinjB26xaCPhWAzGuDX9oRyZLjvomgZ/88h
         s1YBRXGyfpqfIZ+yRTcxsaiZ028zTAHqtOhevytdSe21VHGrw56HC/Dhe7DddSC3Ero1
         9SHtgsWq/hkrAm90vChfp/wZQGZAkzuDM/19fDEBnh5rXzfFCxIw1L7F086ZyMuIWjbV
         d3EmVbh6c94mZnbQ8cwd/4kcIa66uS+eUAePDuZ9b/hm5MDmZn/342opJU6W0f0PgUB0
         B3qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100468; x=1776705268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QygrDBL2RtJkB6vENTKE5mRPBFDruU3+BPQuEukfRvo=;
        b=Yj5z+on6aB6E7BPFj7kEZrEgqUQPRAUhfKXR9lIb8t4ad9wuu7nm/sdjTgxouuejWb
         Ep3iY61f3J0daxpiTE8XxYT5kARfGQ3zmfF8UJo6/PEXOxK26FUaCe9TxnFIDCz9/ulB
         wdFA2ejEu92zqxARlHk60AgQSzmXmB4+adbvp6Kf9sbcfPE9GBaNqiRz70N9WuRmTLqJ
         cD83cbuXu22Jzmydt3Aw4Uz+RSL9yt2SES8PzphGIIvES+I3oHhns21MwdHWGkJXiLfc
         3DPLVhl5Pr0I9D1hVBkRywuQXk6+rc5Xpo8VSkW5xxv3wPOiUwurizZfyBBjVar9rT2z
         U/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100468; x=1776705268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QygrDBL2RtJkB6vENTKE5mRPBFDruU3+BPQuEukfRvo=;
        b=jLOfqYcQF9JaZc8yqBTTR8cDEOXBn1CCmq1P03gXEBT/XqVaV04XJugXij91BZdtD1
         ebGvujjKCbcFQlAiqANhlPwg8kRoDTeZrHerUDCthPI8cFV9ELpWEDXdzh1I9i765V5J
         wPFXjXUwpld36P0row34aleq5xic4uGFyTA+mFmz8oKvKMHijtphM5vPGHDnCjtzp3jo
         b1Q9Qi/+csJ7fxPJo+ImASbyYgjzIFz5inZ9G/60A256ZX0hcPIhbDE9tNazqTSydNZ8
         lgxIMnd6+whq5SAxlqzGniD9YvSnDlHydn7/qeYzqKrifU6KF6x7Q1e4JCkkCk+ytj2+
         svuQ==
X-Forwarded-Encrypted: i=1; AFNElJ84AVXs6eZk+LJO33IXI7OY2ZU2+6ZQvRoz/1jfbG6Syym+3i3XIyD7UsPtSjAfdOuNTGoaQ/M+@vger.kernel.org
X-Gm-Message-State: AOJu0YxGBijRCxEGwflx14T53Wfd8EsnFs8Xnscygt5KhtvwdxMz8rIh
	hbCl70xnzLLRj+gt0LAShImPfsD8ueMiSVAmAS9zwW7VEheheRiIIjuJ6+3QMwrLw9u838HHAN/
	XPjuM5pQ7/UhGEOk5zSUzm+tEYQj8nHI=
X-Gm-Gg: AeBDietv48iF3rI6elUFpRER+TocPMD2a+GcmoJmjcYEzLgXOxV1ctJ2ivx8JBSDbEe
	Ak/NNObVRV34nsYEB7dUFPqOVebHoBuLTJa5WdnEqnFmv06pTZdX2F0FsdwuYpeH5wT9qz3foVj
	CNnKvDoWWKdUxFOw+X2W3SSNTqLWFmEuEYB3cJ1opBMVmMEuQ0Qxd6U03E/dT6dT1vzAzfI7EGI
	mOb/ZpxfgkQ6gUtSuOMwWlDkqWzukqkLBUjOhzt/L4v78wvQUmXLXbHTlIFYSJUcbTHtJKM4I8y
	w/SDyvI=
X-Received: by 2002:a05:6a00:1ad1:b0:823:d58:c4ab with SMTP id
 d2e1a72fcca58-82f0c1d9e56mr14680702b3a.2.1776100468322; Mon, 13 Apr 2026
 10:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <20260318184400.3502908-2-song@kernel.org>
In-Reply-To: <20260318184400.3502908-2-song@kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 13 Apr 2026 13:14:17 -0400
X-Gm-Features: AQROBzBriwFuNxM2IXwsxZCb4zVhy8FAovjmyaSwr6r7rMOyTsP9GenvDd6CfXg
Message-ID: <CAEjxPJ5UU9riMZt57bODXHpxPLn2RKGJ02r7HWvdD979a-2ycA@mail.gmail.com>
Subject: Re: [PATCH 1/7] lsm: Add granular mount hooks to replace security_sb_mount
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
> Add six new LSM hooks for mount operations:
>
> - mount_bind(from, to, recurse): bind mount with pre-resolved
>   struct path for source and destination.
> - mount_new(fc, mp, mnt_flags, flags, data): new mount, called after
>   mount options are parsed. The flags and data parameters carry the
>   original mount(2) flags and data for LSMs that need them (AppArmor,
>   Tomoyo).
> - mount_remount(fc, mp, mnt_flags, flags, data): filesystem remount,
>   called after mount options are parsed into the fs_context.
> - mount_reconfigure(mp, mnt_flags, flags): mount flag reconfiguration
>   (MS_REMOUNT|MS_BIND path).
> - mount_move(from, to): move mount with pre-resolved paths.
> - mount_change_type(mp, ms_flags): propagation type changes.
>
> These replace the monolithic security_sb_mount() which conflates
> multiple distinct operations into a single hook, and suffers from
> TOCTOU issues where LSMs re-resolve string-based dev_name via
> kern_path().
>
> The mount_move hook is added alongside the existing move_mount hook.
> During the transition, LSMs register for both hooks. The move_mount
> hook will be removed once all LSMs have been converted.
>
> Some LSMs, such as apparmor and tomoyo, audit the original input passed
> in the mount syscall. To keep the same behavior, argument data and flags
> are passed in do_* functions. These can be removed if these LSMs no
> longer need these information.
>
> All new hooks are registered as sleepable BPF LSM hooks.
>
> Code generated with the assistance of Claude, reviewed by human.
>
> Signed-off-by: Song Liu <song@kernel.org>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com # for selinux on=
ly

> ---
>  fs/namespace.c                |  35 ++++++++++--
>  include/linux/lsm_hook_defs.h |  12 ++++
>  include/linux/security.h      |  50 +++++++++++++++++
>  kernel/bpf/bpf_lsm.c          |   7 +++
>  security/security.c           | 101 ++++++++++++++++++++++++++++++++++
>  5 files changed, 199 insertions(+), 6 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 854f4fc66469..de33070e514a 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2875,6 +2875,10 @@ static int do_change_type(const struct path *path,=
 int ms_flags)
>         if (!type)
>                 return -EINVAL;
>
> +       err =3D security_mount_change_type(path, ms_flags);
> +       if (err)
> +               return err;
> +
>         guard(namespace_excl)();
>
>         err =3D may_change_propagation(mnt);
> @@ -3007,6 +3011,10 @@ static int do_loopback(const struct path *path, co=
nst char *old_name,
>         if (err)
>                 return err;
>
> +       err =3D security_mount_bind(&old_path, path, recurse);
> +       if (err)
> +               return err;
> +
>         if (mnt_ns_loop(old_path.dentry))
>                 return -EINVAL;
>
> @@ -3319,7 +3327,8 @@ static void mnt_warn_timestamp_expiry(const struct =
path *mountpoint,
>   * superblock it refers to.  This is triggered by specifying MS_REMOUNT|=
MS_BIND
>   * to mount(2).
>   */
> -static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_=
flags)
> +static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_=
flags,
> +                             unsigned long flags)
>  {
>         struct super_block *sb =3D path->mnt->mnt_sb;
>         struct mount *mnt =3D real_mount(path->mnt);
> @@ -3334,6 +3343,10 @@ static int do_reconfigure_mnt(const struct path *p=
ath, unsigned int mnt_flags)
>         if (!can_change_locked_flags(mnt, mnt_flags))
>                 return -EPERM;
>
> +       ret =3D security_mount_reconfigure(path, mnt_flags, flags);
> +       if (ret)
> +               return ret;
> +
>         /*
>          * We're only checking whether the superblock is read-only not
>          * changing it, so only take down_read(&sb->s_umount).
> @@ -3357,7 +3370,7 @@ static int do_reconfigure_mnt(const struct path *pa=
th, unsigned int mnt_flags)
>   * on it - tough luck.
>   */
>  static int do_remount(const struct path *path, int sb_flags,
> -                     int mnt_flags, void *data)
> +                     int mnt_flags, void *data, unsigned long flags)
>  {
>         int err;
>         struct super_block *sb =3D path->mnt->mnt_sb;
> @@ -3384,6 +3397,9 @@ static int do_remount(const struct path *path, int =
sb_flags,
>         fc->oldapi =3D true;
>
>         err =3D parse_monolithic_mount_data(fc, data);
> +       if (!err)
> +               err =3D security_mount_remount(fc, path, mnt_flags, flags=
,
> +                                           data);
>         if (!err) {
>                 down_write(&sb->s_umount);
>                 err =3D -EPERM;
> @@ -3713,6 +3729,10 @@ static int do_move_mount_old(const struct path *pa=
th, const char *old_name)
>         if (err)
>                 return err;
>
> +       err =3D security_mount_move(&old_path, path);
> +       if (err)
> +               return err;
> +
>         return do_move_mount(&old_path, path, 0);
>  }
>
> @@ -3791,7 +3811,7 @@ static int do_new_mount_fc(struct fs_context *fc, c=
onst struct path *mountpoint,
>   */
>  static int do_new_mount(const struct path *path, const char *fstype,
>                         int sb_flags, int mnt_flags,
> -                       const char *name, void *data)
> +                       const char *name, void *data, unsigned long flags=
)
>  {
>         struct file_system_type *type;
>         struct fs_context *fc;
> @@ -3835,6 +3855,9 @@ static int do_new_mount(const struct path *path, co=
nst char *fstype,
>                 err =3D parse_monolithic_mount_data(fc, data);
>         if (!err && !mount_capable(fc))
>                 err =3D -EPERM;
> +
> +       if (!err)
> +               err =3D security_mount_new(fc, path, mnt_flags, flags, da=
ta);
>         if (!err)
>                 err =3D do_new_mount_fc(fc, path, mnt_flags);
>
> @@ -4146,9 +4169,9 @@ int path_mount(const char *dev_name, const struct p=
ath *path,
>                             SB_I_VERSION);
>
>         if ((flags & (MS_REMOUNT | MS_BIND)) =3D=3D (MS_REMOUNT | MS_BIND=
))
> -               return do_reconfigure_mnt(path, mnt_flags);
> +               return do_reconfigure_mnt(path, mnt_flags, flags);
>         if (flags & MS_REMOUNT)
> -               return do_remount(path, sb_flags, mnt_flags, data_page);
> +               return do_remount(path, sb_flags, mnt_flags, data_page, f=
lags);
>         if (flags & MS_BIND)
>                 return do_loopback(path, dev_name, flags & MS_REC);
>         if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
> @@ -4157,7 +4180,7 @@ int path_mount(const char *dev_name, const struct p=
ath *path,
>                 return do_move_mount_old(path, dev_name);
>
>         return do_new_mount(path, type_page, sb_flags, mnt_flags, dev_nam=
e,
> -                           data_page);
> +                           data_page, flags);
>  }
>
>  int do_mount(const char *dev_name, const char __user *dir_name,
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 8c42b4bde09c..6bb67059fb43 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -81,6 +81,18 @@ LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super=
_block *oldsb,
>          unsigned long *set_kern_flags)
>  LSM_HOOK(int, 0, move_mount, const struct path *from_path,
>          const struct path *to_path)
> +LSM_HOOK(int, 0, mount_bind, const struct path *from, const struct path =
*to,
> +        bool recurse)
> +LSM_HOOK(int, 0, mount_new, struct fs_context *fc, const struct path *mp=
,
> +        int mnt_flags, unsigned long flags, void *data)
> +LSM_HOOK(int, 0, mount_remount, struct fs_context *fc,
> +        const struct path *mp, int mnt_flags, unsigned long flags,
> +        void *data)
> +LSM_HOOK(int, 0, mount_reconfigure, const struct path *mp,
> +        unsigned int mnt_flags, unsigned long flags)
> +LSM_HOOK(int, 0, mount_move, const struct path *from_path,
> +        const struct path *to_path)
> +LSM_HOOK(int, 0, mount_change_type, const struct path *mp, int ms_flags)
>  LSM_HOOK(int, -EOPNOTSUPP, dentry_init_security, struct dentry *dentry,
>          int mode, const struct qstr *name, const char **xattr_name,
>          struct lsm_context *cp)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..6e31de9b3d68 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -385,6 +385,17 @@ int security_sb_clone_mnt_opts(const struct super_bl=
ock *oldsb,
>                                 unsigned long kern_flags,
>                                 unsigned long *set_kern_flags);
>  int security_move_mount(const struct path *from_path, const struct path =
*to_path);
> +int security_mount_bind(const struct path *from, const struct path *to,
> +                       bool recurse);
> +int security_mount_new(struct fs_context *fc, const struct path *mp,
> +                      int mnt_flags, unsigned long flags, void *data);
> +int security_mount_remount(struct fs_context *fc, const struct path *mp,
> +                          int mnt_flags, unsigned long flags, void *data=
);
> +int security_mount_reconfigure(const struct path *mp, unsigned int mnt_f=
lags,
> +                              unsigned long flags);
> +int security_mount_move(const struct path *from_path,
> +                       const struct path *to_path);
> +int security_mount_change_type(const struct path *mp, int ms_flags);
>  int security_dentry_init_security(struct dentry *dentry, int mode,
>                                   const struct qstr *name,
>                                   const char **xattr_name,
> @@ -847,6 +858,45 @@ static inline int security_move_mount(const struct p=
ath *from_path,
>         return 0;
>  }
>
> +static inline int security_mount_bind(const struct path *from,
> +                                     const struct path *to, bool recurse=
)
> +{
> +       return 0;
> +}
> +
> +static inline int security_mount_new(struct fs_context *fc,
> +                                    const struct path *mp, int mnt_flags=
,
> +                                    unsigned long flags, void *data)
> +{
> +       return 0;
> +}
> +
> +static inline int security_mount_remount(struct fs_context *fc,
> +                                        const struct path *mp, int mnt_f=
lags,
> +                                        unsigned long flags, void *data)
> +{
> +       return 0;
> +}
> +
> +static inline int security_mount_reconfigure(const struct path *mp,
> +                                            unsigned int mnt_flags,
> +                                            unsigned long flags)
> +{
> +       return 0;
> +}
> +
> +static inline int security_mount_move(const struct path *from_path,
> +                                     const struct path *to_path)
> +{
> +       return 0;
> +}
> +
> +static inline int security_mount_change_type(const struct path *mp,
> +                                            int ms_flags)
> +{
> +       return 0;
> +}
> +
>  static inline int security_path_notify(const struct path *path, u64 mask=
,
>                                 unsigned int obj_type)
>  {
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 0c4a0c8e6f70..65235d70ee23 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -383,6 +383,13 @@ BTF_ID(func, bpf_lsm_task_prctl)
>  BTF_ID(func, bpf_lsm_task_setscheduler)
>  BTF_ID(func, bpf_lsm_task_to_inode)
>  BTF_ID(func, bpf_lsm_userns_create)
> +BTF_ID(func, bpf_lsm_move_mount)
> +BTF_ID(func, bpf_lsm_mount_bind)
> +BTF_ID(func, bpf_lsm_mount_new)
> +BTF_ID(func, bpf_lsm_mount_remount)
> +BTF_ID(func, bpf_lsm_mount_reconfigure)
> +BTF_ID(func, bpf_lsm_mount_move)
> +BTF_ID(func, bpf_lsm_mount_change_type)
>  BTF_SET_END(sleepable_lsm_hooks)
>
>  BTF_SET_START(untrusted_lsm_hooks)
> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..356ef228d5de 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1156,6 +1156,107 @@ int security_move_mount(const struct path *from_p=
ath,
>         return call_int_hook(move_mount, from_path, to_path);
>  }
>
> +/**
> + * security_mount_bind() - Check permissions for a bind mount
> + * @from: source path
> + * @to: destination mount point
> + * @recurse: whether this is a recursive bind mount
> + *
> + * Check permission before a bind mount is performed. Called with the
> + * source path already resolved, eliminating TOCTOU issues with
> + * string-based dev_name in security_sb_mount().
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_mount_bind(const struct path *from, const struct path *to,
> +                       bool recurse)
> +{
> +       return call_int_hook(mount_bind, from, to, recurse);
> +}
> +
> +/**
> + * security_mount_new() - Check permissions for a new mount
> + * @fc: filesystem context with parsed options
> + * @mp: mount point path
> + * @mnt_flags: mount flags (MNT_*)
> + * @flags: original mount flags (MS_*, used by AppArmor/Tomoyo)
> + * @data: filesystem specific data (used by AppArmor)
> + *
> + * Check permission before a new filesystem is mounted. Called after
> + * mount options are parsed, providing access to the fs_context.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_mount_new(struct fs_context *fc, const struct path *mp,
> +                      int mnt_flags, unsigned long flags, void *data)
> +{
> +       return call_int_hook(mount_new, fc, mp, mnt_flags, flags, data);
> +}
> +
> +/**
> + * security_mount_remount() - Check permissions for a remount
> + * @fc: filesystem context with parsed options
> + * @mp: mount point path
> + * @mnt_flags: mount flags (MNT_*)
> + * @flags: original mount flags (MS_*, used by AppArmor/Tomoyo)
> + * @data: filesystem specific data (used by AppArmor)
> + *
> + * Check permission before a filesystem is remounted. Called after
> + * mount options are parsed, providing access to the fs_context.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_mount_remount(struct fs_context *fc, const struct path *mp,
> +                          int mnt_flags, unsigned long flags, void *data=
)
> +{
> +       return call_int_hook(mount_remount, fc, mp, mnt_flags, flags, dat=
a);
> +}
> +
> +/**
> + * security_mount_reconfigure() - Check permissions for mount reconfigur=
ation
> + * @mp: mount point path
> + * @mnt_flags: new mount flags (MNT_*)
> + * @flags: original mount flags (MS_*, used by AppArmor/Tomoyo)
> + *
> + * Check permission before mount flags are reconfigured (MS_REMOUNT|MS_B=
IND).
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_mount_reconfigure(const struct path *mp, unsigned int mnt_f=
lags,
> +                              unsigned long flags)
> +{
> +       return call_int_hook(mount_reconfigure, mp, mnt_flags, flags);
> +}
> +
> +/**
> + * security_mount_move() - Check permissions for moving a mount
> + * @from_path: source mount path
> + * @to_path: destination mount point path
> + *
> + * Check permission before a mount is moved.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_mount_move(const struct path *from_path,
> +                       const struct path *to_path)
> +{
> +       return call_int_hook(mount_move, from_path, to_path);
> +}
> +
> +/**
> + * security_mount_change_type() - Check permissions for propagation chan=
ges
> + * @mp: mount point path
> + * @ms_flags: propagation flags (MS_SHARED, MS_PRIVATE, etc.)
> + *
> + * Check permission before mount propagation type is changed.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_mount_change_type(const struct path *mp, int ms_flags)
> +{
> +       return call_int_hook(mount_change_type, mp, ms_flags);
> +}
> +
>  /**
>   * security_path_notify() - Check if setting a watch is allowed
>   * @path: file path
> --
> 2.52.0
>
