Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE8156236
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777261; cv=none; b=mD8ws9ArSkbiskvpYyomM7MxwmGpZls8NpHI3ITF1JIXjBLK+ZzgZANtOpHqDN8vcWlXag/FVFse81DWrHc+6UbtFomc1l1EA92zlBHr0EWXodNUBO9zVTZhw414miEf64ACzCNOfoug3Gy+Td6kiaAvdPj9fqbVztkY7v1F6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777261; c=relaxed/simple;
	bh=tVy7FluSaExdxJPoivXziQLhjiRYxcrk9dCQjRo7GVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNe0eFX3SQK1z184hZ1GP7t8HyTvMvvBZiSJMT7/D8G4g7odPJmqvn4E6biaX3ZzsmpQjA456/CiRW+W+XuTrWrn4YjsUBIfDY0xCIKkWDE4TvzB0BZSN1q7O847VwUYrFeOqTkbSIqYmCiK6DfopsDA0D405+/DsElvMOpC49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5oBf3m2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5oBf3m2"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso6702547a91.0
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759777259; x=1760382059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKfJAmIcedDgU9MOQ0Acx1HaYciMQ8xGBfRJhSDlEKw=;
        b=a5oBf3m2jyxdzN+MeU87WWCSp9ZgTjPKtBy1xyozVv+hCxq/ccY2Zdn5gC6S6qDbTj
         51seV82z+dxOLhSwt+Uf2Tj7XDcTo2uJapt/901wmbnN84hMbo0StQFqtWaP/hMiN6aa
         1quAlZo1yzNgpBoTuonBP3AR2nRKbJOuqP7JA5ETkeuYrNsar7mlKBHqCq1JofeU+BTu
         s4IZgBJrEN/0DP6h/ivXqRDASDTxKbPBabtZ9dffcKiJ8dJ86ByaF7nyscRssuvMnKkO
         ze7nxSFoLPx8LHu1o6quWRFz7yB7UxwjLc2CulPXJG0iE8iU7qQLQkPvZLDR57T8ofT2
         cqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759777259; x=1760382059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKfJAmIcedDgU9MOQ0Acx1HaYciMQ8xGBfRJhSDlEKw=;
        b=NGZzE8VIHzgzCAg2Fd38JD0ZTyUAmwAt2Hdy53nZ66py6m462QPc88ZtD8RgrXxRQ2
         cJZJzLe8Ip/GcRAUKuPw7qrLfXBhMPqSVoYbFgIV+8/6iUpa5mWXerclRgLwMUoreP83
         bEpTwFDnu7YBo39Smw0jLtovCot3ciPtCvpncbNZaOJNl9O9GcPhVWbCiwd1ACSyn0Gz
         OPi0BD/ze3J3XL0q33h7pHWfrGDF0DD1qE5cOJVpxGMlkJ9BxGxh9MK+4rMXIXSgH4j5
         +8YL5E752b+2aw/xFoBOay4FZuQki7NNQOp8R9rtVgoxkKubWBzv1n4Oca49Q4yJdiJp
         bSRA==
X-Gm-Message-State: AOJu0YxuqAB2LVzMncyqsRMUV8kt1vSXoXItps87M5fODfF/kzd/8TGC
	zCPcYfS+hH78l7pTxAivm/dtq+S8/fOUNywZYLhqBcMXGJi+ZgrtBfRL1Lh65r0gP5aovuJnufs
	EIZAAIRz+qlalNEhCaFwH4byJ6g/J/tw=
X-Gm-Gg: ASbGncugfkc/ELvoO3kXAglM6y6VMAZS922YqHnsRySNTQ2ybR93HrHTA/APQG7/euD
	S4d0KvtHJdFr4RPgpUHKNcWm55uM5OYb//6cYAALN/ZaHYnba1+nrrN/zLx1cyHglf/HhOg5Zy4
	qhsnYQcmrrLY9+YPpwrpoidNy8oEQrvpy7zajIkQvcVypnaYdZqohT+MTKaY0nY2wit9J6qTouz
	YHiuHUdXyJWjsyXIYPSWrRb54rQQ94=
X-Google-Smtp-Source: AGHT+IE8rSqK3gwV8LiEHnn5vPUmlzBCBlE8QUUd6ou6hRhxlv4T6/4/szKMUqUX4sq9vdzvOyBRQP2edwAN2mUzx5M=
X-Received: by 2002:a17:90b:37cf:b0:335:2d25:7a7a with SMTP id
 98e67ed59e1d1-339edaadd9bmr807360a91.10.1759777258446; Mon, 06 Oct 2025
 12:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006172205.429-1-ericsu@linux.microsoft.com>
In-Reply-To: <20251006172205.429-1-ericsu@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 15:00:47 -0400
X-Gm-Features: AS18NWD3zLS2ybj1yv9hIrBaqNjvqagDn_baD6nYBgNUGLKeAcKQqAK_Er36eG8
Message-ID: <CAEjxPJ46pVykPEeXT73G5h_sAXuU68+w4kfW-fQrfM0EMq+xzw@mail.gmail.com>
Subject: Re: [PATCH v4] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:22=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.co=
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
>  security/selinux/hooks.c                   | 93 +++++++++++++++++++++-
>  security/selinux/include/classmap.h        |  2 +-
>  security/selinux/include/objsec.h          |  2 +
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  6 ++
>  6 files changed, 102 insertions(+), 3 deletions(-)
>

What is this patch relative to? Didn't apply for me on
selinux/dev-staging or selinux/dev.
Optimally should target selinux/dev-staging at this point since it has
the memfd patch and hence its policy capability defined, and your new
one should go after that one.

Also, did you ever explain why your implementation lacks a
bpf_token_capable() hook and whether that still needs to be addressed?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e7a7dcab81db..ae26bb927bdf 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -726,6 +726,8 @@ static int selinux_set_mnt_opts(struct super_block *s=
b,
>                 goto out;
>         }
>
> +       sbsec->creator_sid =3D current_sid();
> +
>         if (strcmp(sb->s_type->name, "proc") =3D=3D 0)
>                 sbsec->flags |=3D SE_SBPROC | SE_SBGENFS;
>
> @@ -895,6 +897,8 @@ static int selinux_cmp_sb_context(const struct super_=
block *oldsb,
>                 if (oldroot->sid !=3D newroot->sid)
>                         goto mismatch;
>         }
> +       if (old->creator_sid !=3D new->creator_sid)
> +               goto mismatch;
>         return 0;
>  mismatch:
>         pr_warn("SELinux: mount invalid.  Same superblock, "
> @@ -954,6 +958,7 @@ static int selinux_sb_clone_mnt_opts(const struct sup=
er_block *oldsb,
>         newsbsec->sid =3D oldsbsec->sid;
>         newsbsec->def_sid =3D oldsbsec->def_sid;
>         newsbsec->behavior =3D oldsbsec->behavior;
> +       newsbsec->creator_sid =3D oldsbsec->creator_sid;
>
>         if (newsbsec->behavior =3D=3D SECURITY_FS_USE_NATIVE &&
>                 !(kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_contex=
t) {
> @@ -2565,6 +2570,7 @@ static int selinux_sb_alloc_security(struct super_b=
lock *sb)
>         sbsec->sid =3D SECINITSID_UNLABELED;
>         sbsec->def_sid =3D SECINITSID_FILE;
>         sbsec->mntpoint_sid =3D SECINITSID_UNLABELED;
> +       sbsec->creator_sid =3D SECINITSID_UNLABELED;
>
>         return 0;
>  }
> @@ -6915,6 +6921,9 @@ static int selinux_bpf(int cmd, union bpf_attr *att=
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
> @@ -6996,10 +7005,29 @@ static int selinux_bpf_prog(struct bpf_prog *prog=
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
> @@ -7008,7 +7036,12 @@ static int selinux_bpf_map_create(struct bpf_map *=
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
> @@ -7023,6 +7056,7 @@ static int selinux_bpf_prog_load(struct bpf_prog *p=
rog, union bpf_attr *attr,
>                                  struct bpf_token *token, bool kernel)
>  {
>         struct bpf_security_struct *bpfsec;
> +       u32 ssid;
>
>         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>         if (!bpfsec)
> @@ -7031,7 +7065,12 @@ static int selinux_bpf_prog_load(struct bpf_prog *=
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
> @@ -7042,10 +7081,15 @@ static void selinux_bpf_prog_free(struct bpf_prog=
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
> @@ -7054,6 +7098,29 @@ static int selinux_bpf_token_create(struct bpf_tok=
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
> @@ -7064,6 +7131,27 @@ static void selinux_bpf_token_free(struct bpf_toke=
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
>  #endif
>
>  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
> @@ -7495,6 +7583,7 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>         LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
>         LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
>         LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
> +       LSM_HOOK_INIT(bpf_token_cmd, selinux_bpf_token_cmd),
>  #endif
>  #ifdef CONFIG_PERF_EVENTS
>         LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 04a9b480885e..0af64019a3c3 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -173,7 +173,7 @@ const struct security_class_mapping secclass_map[] =
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
> index c88cae81ee4c..8f4d1c404ecd 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -65,6 +65,7 @@ struct superblock_security_struct {
>         u32 sid; /* SID of file system superblock */
>         u32 def_sid; /* default SID for labeling */
>         u32 mntpoint_sid; /* SECURITY_FS_USE_MNTPOINT context for files *=
/
> +       u32 creator_sid; /* SID of privileged process and is used to veri=
fy bpf operations */
>         unsigned short behavior; /* labeling behavior */
>         unsigned short flags; /* which mount options were specified */
>         struct mutex lock;
> @@ -142,6 +143,7 @@ struct pkey_security_struct {
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
> index bd402d3fd3ae..ea55b7c10da4 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -16,6 +16,7 @@ enum {
>         POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
>         POLICYDB_CAP_NETLINK_XPERM,
>         POLICYDB_CAP_NETIF_WILDCARD,
> +       POLICYDB_CAP_BPF_TOKEN_PERMS,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinu=
x/include/policycap_names.h
> index ac1342d6d5bb..e9f53e6a4aeb 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -19,6 +19,7 @@ const char *const selinux_policycap_names[__POLICYDB_CA=
P_MAX] =3D {
>         "userspace_initial_context",
>         "netlink_xperm",
>         "netif_wildcard",
> +       "bpf_token_perms",
>  };
>  /* clang-format on */
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index e7827ed7be5f..3d9e6f9dfa9a 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -208,6 +208,12 @@ static inline bool selinux_policycap_netif_wildcard(=
void)
>                 selinux_state.policycap[POLICYDB_CAP_NETIF_WILDCARD]);
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
