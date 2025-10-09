Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EE4A23
	for <selinux@vger.kernel.org>; Thu,  9 Oct 2025 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023897; cv=none; b=L+GxRku7P1oc7b2IZwwEmGKNATjuWtHPYDKPwwRH6VTZhvqSmd4XTzfxpZNWwBWWV5Z5T++rD1+a7wVRlvYuJ6itRP7RSQvGfSuCWNssD6RF6GxUxkqbikkPm1QRCDuY1p89laimf9cEu8sxghLUb3ua4bmrrq6qm6ZPdn5omYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023897; c=relaxed/simple;
	bh=wkVh04HwU82pIRbojlTmgRv/77j/FmkBRRTKfrtK4g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnTLrP1GAEHRP+3+ZjByF3QIPG9dbcSYQaxGnV03gF8C7f3ImxYyNkm2wvSv60Ef/V9uDXttFlRPpZNXbjujLNNyJTLdJ5PZ5eo4WdHs7lI3gQZ/N5X4tpkYOMSXNzunldZOlyyh1OPg5J336HYtDRJZZvidlFcaaT224LvowZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLTpeu4c; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLTpeu4c"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33292adb180so1062091a91.3
        for <selinux@vger.kernel.org>; Thu, 09 Oct 2025 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760023895; x=1760628695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfrdwZ8iEyFVwn/QIwZuYJKaPrsVPC8RExi7fw8Be8E=;
        b=YLTpeu4c/QBcyRzmVMmAKw65+c4uyrv/QuO7ZA9iNBZVdPsIYTjm0maHgL4pSMXLka
         rEYDJroNbpBro/PTZrFMfcjQFfgRrDdx4z90dsA04YhL6WXLfWJ5KHnO2AYsuJvtLuIs
         gc0EW7JSWUjXuMNAlBgGs1Aatuaj2T1jKLJdhiVKp9LC7tk6VOVqGJDonCzFhGs+ke39
         eHS5fPvH3+w++MnmgnaO3btzzUcIQApN3SidpE3SKU1gw+h4tZaoGddTdt7J96CavyIH
         Ke+KnrsgRmZYTC4TbdJeJJnvc8YYT9Pejk4os8qgtWoJ6arFzspJfzVq0We+NEiD9o99
         IWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023895; x=1760628695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfrdwZ8iEyFVwn/QIwZuYJKaPrsVPC8RExi7fw8Be8E=;
        b=X4R3axEgu+F3J7i1klPlvnR/HzQBloc0nPFy+VXSBrVJu6Lv4FPuXh8iA258qDJA89
         WP/dfQGE3YVZnYousszAfbUfvpiJo88AZwZXHtKpvRZxZTdWY3U+3fnR3gx6UrUD3eeF
         EiE0L/Y0ulBdDt1gQLkdvN6QzFMLRMT9k9alGzpK74UhPgvh5ti+5j4uj/skuSwcWfpj
         eIQVL/fiCLKP38+ny75gtdlkST7wJ40OXh2fv/YlkU3WokEQFoJnRQ9wG/29K8PEpF2f
         kG7SMb2MEAsJlkIg2mqywFFDSnky5wl10NKv1qdjngdG9zmpovJTVVEz6mOO361aGP2R
         nKfQ==
X-Gm-Message-State: AOJu0YxKTthXIGNsWQyI8R6DSFXGU5VXmLAht7snOSdEEzdt0yjgC7oa
	oZDgL3GeTSqDzXxIDd6TcF+XxsCvxYg3iDt400upt1J/D3YLNmgfEVkxexaiJQbSscREL2X3H+I
	uQrKzSCESEMygfXeOHvfEBP0u9NNiClo=
X-Gm-Gg: ASbGncs+nOtvKKzkebDHMeeRjfDrN/EMl4HIwoKVyRx0jLuMlugcKR6kwm3EWrAbB9V
	VO8EZ+7DZG8AspSrsjojDVIuotWritvD2l7EvP62/9zcoXKt3MOsgfdFNCA/PE5lMcvaKsecn6f
	w3IMRkAdwXtz6ES9i6TJA5vgVtJQA2VvdcHstZvh9NMyHK7kdhTCWdIryctfJIrW9WVo1c4gJlG
	i9EDhs0BS1jbzKBqtNly1+4NXZfSgiuxYFm4gDqk9ViC069MXHF
X-Google-Smtp-Source: AGHT+IH6zU6x+velEUJJ91uRrHH1g18h1pmHls/kwZd7flhhqWuvxfyQv7qCW+PR3SYaSL4VLlArhJ/DAOgziZq1KVE=
X-Received: by 2002:a17:90b:224a:b0:336:9dcf:ed14 with SMTP id
 98e67ed59e1d1-33b51375a05mr11307431a91.23.1760023894651; Thu, 09 Oct 2025
 08:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008234613.2150-1-ericsu@linux.microsoft.com>
In-Reply-To: <20251008234613.2150-1-ericsu@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Oct 2025 11:31:23 -0400
X-Gm-Features: AS18NWA24UtdGZ9hBaPGiymcCWZ4MPccDhSNVHYFSw4eSW4LaQ0Orf-1juG-1BU
Message-ID: <CAEjxPJ42NoxmtEDfZVqUSEP6GMTTys0ZCUUxgybhJKXBO42ygw@mail.gmail.com>
Subject: Re: [PATCH v5] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:46=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.co=
m> wrote:
>
> BPF token support was introduced to allow a privileged process to delegat=
e
> limited BPF functionality=E2=80=94such as map creation and program loadin=
g=E2=80=94to
> an unprivileged process:
>   https://lore.kernel.org/linux-security-module/20231130185229.2688956-1-=
andrii@kernel.org/
>
> This patch adds SELinux support for controlling BPF token access. With
> this change, SELinux policies can now enforce constraints on BPF token
> usage based on both the delegating (privileged) process and the recipient
> (unprivileged) process.
>
> Supported operations currently include:
>   - map_create
>   - prog_load
>
> High-level workflow:
>   1. An unprivileged process creates a VFS context via `fsopen()` and
>      obtains a file descriptor.
>   2. This descriptor is passed to a privileged process, which configures
>      BPF token delegation options and mounts a BPF filesystem.
>   3. SELinux records the `creator_sid` of the privileged process during
>      mount setup.
>   4. The unprivileged process then uses this BPF fs mount to create a
>      token and attach it to subsequent BPF syscalls.
>   5. During verification of `map_create` and `prog_load`, SELinux uses
>      `creator_sid` and the current SID to check policy permissions via:
>        avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
>                     BPF__MAP_CREATE, NULL);
>
> The implementation introduces two new permissions:
>   - map_create_as
>   - prog_load_as
>
> At token creation time, SELinux verifies that the current process has the
> appropriate `*_as` permission (depending on the `allowed_cmds` value in
> the bpf_token) to act on behalf of the `creator_sid`.
>
> Example SELinux policy:
>   allow test_bpf_t self:bpf {
>       map_create map_read map_write prog_load prog_run
>       map_create_as prog_load_as
>   };
>
> Additionally, a new policy capability bpf_token_perms is added to ensure
> backward compatibility. If disabled, previous behavior ((checks based on
> current process SID)) is preserved.
>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>

Should probably credit Daniel Durning for the bpf_token_capable()
implementation in the patch description, not just the changelog (which
won't be included when the patch is applied). Otherwise,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changes in v2:
> - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
>   creator_sid from wrong file descriptor
> - Removed unnecessary checks for null, per review comments from
>   the first patch
>
> Changes in v3:
> - Removed check for 'sid =3D=3D SECSID_NULL' in selinux_bpf_token_create =
and
>   allow it to fall through to the permission checks which will fail as
>   access denied to unlabeled_t
>
> Changes in v4:
> - Added initialization of creator_sid in selinux_sb_alloc_security
> - Enabled handling of creator_sid in selinux_cmp_sb_context and
>   selinux_sb_clone_mnt_opts
> - Minor updates based on review comments
>
> Changes in v5:
> - Moved to dev-staging branch instead of main
> - Added implementation of selinux_bpf_token_capable which is originally
>   from Daniel's patch
>   https://lore.kernel.org/selinux/20250801154637.143931-1-danieldurning.w=
ork@gmail.com/
>
>  security/selinux/hooks.c                   | 116 ++++++++++++++++++++-
>  security/selinux/include/classmap.h        |   2 +-
>  security/selinux/include/objsec.h          |   2 +
>  security/selinux/include/policycap.h       |   1 +
>  security/selinux/include/policycap_names.h |   1 +
>  security/selinux/include/security.h        |   6 ++
>  6 files changed, 125 insertions(+), 3 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2b685f9dd61d..ba2fcd0a7d8a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -736,6 +736,8 @@ static int selinux_set_mnt_opts(struct super_block *s=
b,
>                 goto out;
>         }
>
> +       sbsec->creator_sid =3D current_sid();
> +
>         if (strcmp(sb->s_type->name, "proc") =3D=3D 0)
>                 sbsec->flags |=3D SE_SBPROC | SE_SBGENFS;
>
> @@ -907,6 +909,8 @@ static int selinux_cmp_sb_context(const struct super_=
block *oldsb,
>                 if (oldroot->sid !=3D newroot->sid)
>                         goto mismatch;
>         }
> +       if (old->creator_sid !=3D new->creator_sid)
> +               goto mismatch;
>         return 0;
>  mismatch:
>         pr_warn("SELinux: mount invalid.  Same superblock, "
> @@ -966,6 +970,7 @@ static int selinux_sb_clone_mnt_opts(const struct sup=
er_block *oldsb,
>         newsbsec->sid =3D oldsbsec->sid;
>         newsbsec->def_sid =3D oldsbsec->def_sid;
>         newsbsec->behavior =3D oldsbsec->behavior;
> +       newsbsec->creator_sid =3D oldsbsec->creator_sid;
>
>         if (newsbsec->behavior =3D=3D SECURITY_FS_USE_NATIVE &&
>                 !(kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_contex=
t) {
> @@ -2585,6 +2590,7 @@ static int selinux_sb_alloc_security(struct super_b=
lock *sb)
>         sbsec->sid =3D SECINITSID_UNLABELED;
>         sbsec->def_sid =3D SECINITSID_FILE;
>         sbsec->mntpoint_sid =3D SECINITSID_UNLABELED;
> +       sbsec->creator_sid =3D SECINITSID_UNLABELED;
>
>         return 0;
>  }
> @@ -7037,6 +7043,9 @@ static int selinux_bpf(int cmd, union bpf_attr *att=
r,
>         u32 sid =3D current_sid();
>         int ret;
>
> +       if (selinux_policycap_bpf_token_perms())
> +               return 0;
> +
>         switch (cmd) {
>         case BPF_MAP_CREATE:
>                 ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_CRE=
ATE,
> @@ -7118,10 +7127,29 @@ static int selinux_bpf_prog(struct bpf_prog *prog=
)
>                             BPF__PROG_RUN, NULL);
>  }
>
> +static u32 selinux_bpffs_creator_sid(u32 fd)
> +{
> +       struct path path;
> +       struct super_block *sb;
> +       struct superblock_security_struct *sbsec;
> +
> +       CLASS(fd, f)(fd);
> +
> +       if (fd_empty(f))
> +               return SECSID_NULL;
> +
> +       path =3D fd_file(f)->f_path;
> +       sb =3D path.dentry->d_sb;
> +       sbsec =3D selinux_superblock(sb);
> +
> +       return sbsec->creator_sid;
> +}
> +
>  static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *a=
ttr,
>                                   struct bpf_token *token, bool kernel)
>  {
>         struct bpf_security_struct *bpfsec;
> +       u32 ssid;
>
>         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>         if (!bpfsec)
> @@ -7130,7 +7158,12 @@ static int selinux_bpf_map_create(struct bpf_map *=
map, union bpf_attr *attr,
>         bpfsec->sid =3D current_sid();
>         map->security =3D bpfsec;
>
> -       return 0;
> +       if (!token)
> +               ssid =3D bpfsec->sid;
> +       else
> +               ssid =3D selinux_bpffs_creator_sid(attr->map_token_fd);
> +
> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__MAP_CRE=
ATE, NULL);
>  }
>
>  static void selinux_bpf_map_free(struct bpf_map *map)
> @@ -7145,6 +7178,7 @@ static int selinux_bpf_prog_load(struct bpf_prog *p=
rog, union bpf_attr *attr,
>                                  struct bpf_token *token, bool kernel)
>  {
>         struct bpf_security_struct *bpfsec;
> +       u32 ssid;
>
>         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>         if (!bpfsec)
> @@ -7153,7 +7187,12 @@ static int selinux_bpf_prog_load(struct bpf_prog *=
prog, union bpf_attr *attr,
>         bpfsec->sid =3D current_sid();
>         prog->aux->security =3D bpfsec;
>
> -       return 0;
> +       if (!token)
> +               ssid =3D bpfsec->sid;
> +       else
> +               ssid =3D selinux_bpffs_creator_sid(attr->prog_token_fd);
> +
> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__PROG_LO=
AD, NULL);
>  }
>
>  static void selinux_bpf_prog_free(struct bpf_prog *prog)
> @@ -7164,10 +7203,15 @@ static void selinux_bpf_prog_free(struct bpf_prog=
 *prog)
>         kfree(bpfsec);
>  }
>
> +#define bpf_token_cmd(T, C) \
> +       ((T)->allowed_cmds & (1ULL << (C)))
> +
>  static int selinux_bpf_token_create(struct bpf_token *token, union bpf_a=
ttr *attr,
>                                     const struct path *path)
>  {
>         struct bpf_security_struct *bpfsec;
> +       u32 sid =3D selinux_bpffs_creator_sid(attr->token_create.bpffs_fd=
);
> +       int err;
>
>         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>         if (!bpfsec)
> @@ -7176,6 +7220,29 @@ static int selinux_bpf_token_create(struct bpf_tok=
en *token, union bpf_attr *att
>         bpfsec->sid =3D current_sid();
>         token->security =3D bpfsec;
>
> +       bpfsec->perms =3D 0;
> +
> +       /**
> +        * 'token->allowed_cmds' is a bit mask of allowed commands
> +        * Convert the BPF command enum to a bitmask representing its pos=
ition in the
> +        * allowed_cmds bitmap.
> +        */
> +       if (bpf_token_cmd(token, BPF_MAP_CREATE)) {
> +               err =3D avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, BPF_=
_MAP_CREATE_AS, NULL);
> +               if (err)
> +                       return err;
> +
> +               bpfsec->perms |=3D BPF__MAP_CREATE;
> +       }
> +
> +       if (bpf_token_cmd(token, BPF_PROG_LOAD)) {
> +               err =3D avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, BPF_=
_PROG_LOAD_AS, NULL);
> +               if (err)
> +                       return err;
> +
> +               bpfsec->perms |=3D BPF__PROG_LOAD;
> +       }
> +
>         return 0;
>  }
>
> @@ -7186,6 +7253,49 @@ static void selinux_bpf_token_free(struct bpf_toke=
n *token)
>         token->security =3D NULL;
>         kfree(bpfsec);
>  }
> +
> +static int selinux_bpf_token_cmd(const struct bpf_token *token, enum bpf=
_cmd cmd)
> +{
> +       struct bpf_security_struct *bpfsec;
> +
> +       bpfsec =3D token->security;
> +       switch (cmd) {
> +       case BPF_MAP_CREATE:
> +               if (!(bpfsec->perms & BPF__MAP_CREATE))
> +                       return -EACCES;
> +               break;
> +       case BPF_PROG_LOAD:
> +               if (!(bpfsec->perms & BPF__PROG_LOAD))
> +                       return -EACCES;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
> +static int selinux_bpf_token_capable(const struct bpf_token *token, int =
cap)
> +{
> +       u16 sclass;
> +       struct bpf_security_struct *bpfsec =3D token->security;
> +       u32 sid =3D bpfsec->sid;
> +       u32 av =3D CAP_TO_MASK(cap);
> +
> +       switch (CAP_TO_INDEX(cap)) {
> +       case 0:
> +               sclass =3D SECCLASS_CAP_USERNS;
> +               break;
> +       case 1:
> +               sclass =3D SECCLASS_CAP2_USERNS;
> +               break;
> +       default:
> +               pr_err("SELinux:  out of range capability %d\n", cap);
> +               return -EINVAL;
> +       }
> +
> +       return avc_has_perm(sid, sid, sclass, av, NULL);
> +}
>  #endif
>
>  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
> @@ -7619,6 +7729,8 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>         LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
>         LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
>         LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
> +       LSM_HOOK_INIT(bpf_token_cmd, selinux_bpf_token_cmd),
> +       LSM_HOOK_INIT(bpf_token_capable, selinux_bpf_token_capable),
>  #endif
>  #ifdef CONFIG_PERF_EVENTS
>         LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 3ec85142771f..90cb61b16425 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -171,7 +171,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
>         { "infiniband_endport", { "manage_subnet", NULL } },
>         { "bpf",
>           { "map_create", "map_read", "map_write", "prog_load", "prog_run=
",
> -           NULL } },
> +           "map_create_as", "prog_load_as", NULL } },
>         { "xdp_socket", { COMMON_SOCK_PERMS, NULL } },
>         { "mctp_socket", { COMMON_SOCK_PERMS, NULL } },
>         { "perf_event",
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 1d7ac59015a1..3b41f75cdac9 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -87,6 +87,7 @@ struct superblock_security_struct {
>         u32 sid; /* SID of file system superblock */
>         u32 def_sid; /* default SID for labeling */
>         u32 mntpoint_sid; /* SECURITY_FS_USE_MNTPOINT context for files *=
/
> +       u32 creator_sid; /* SID of privileged process and is used to veri=
fy bpf operations */
>         unsigned short behavior; /* labeling behavior */
>         unsigned short flags; /* which mount options were specified */
>         struct mutex lock;
> @@ -164,6 +165,7 @@ struct pkey_security_struct {
>
>  struct bpf_security_struct {
>         u32 sid; /* SID of bpf obj creator */
> +       u32 perms; /* allowed AV permissions, e.g. BPF__MAP_CREATE, for r=
equested bpf commands */
>  };
>
>  struct perf_event_security_struct {
> diff --git a/security/selinux/include/policycap.h b/security/selinux/incl=
ude/policycap.h
> index 231d02227e59..dbf39358ae6a 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -19,6 +19,7 @@ enum {
>         POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
>         POLICYDB_CAP_FUNCTIONFS_SECLABEL,
>         POLICYDB_CAP_MEMFD_CLASS,
> +       POLICYDB_CAP_BPF_TOKEN_PERMS,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinu=
x/include/policycap_names.h
> index 454dab37bda3..6e2b808e12e8 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -22,6 +22,7 @@ const char *const selinux_policycap_names[__POLICYDB_CA=
P_MAX] =3D {
>         "genfs_seclabel_wildcard",
>         "functionfs_seclabel",
>         "memfd_class",
> +       "bpf_token_perms",
>  };
>  /* clang-format on */
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index 5d1dad8058b1..d1f16d7f684d 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -214,6 +214,12 @@ static inline bool selinux_policycap_memfd_class(voi=
d)
>         return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_MEMFD_CLASS=
]);
>  }
>
> +static inline bool selinux_policycap_bpf_token_perms(void)
> +{
> +       return READ_ONCE(
> +               selinux_state.policycap[POLICYDB_CAP_BPF_TOKEN_PERMS]);
> +}
> +
>  struct selinux_policy_convert_data;
>
>  struct selinux_load_state {
> --
> 2.50.1
>
