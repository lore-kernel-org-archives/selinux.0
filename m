Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9A1F462D
	for <selinux@vger.kernel.org>; Mon, 18 Aug 2025 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522132; cv=none; b=pxP7QHQkQz5PiCBgQsp+sQKrMFVj5jPLj76FaIpD0YZX6qCtgGXQL3ORaO8x9KKS5BN3vhdc2yrmjqQ/8aUMafdyxlAMNiqU+zBTNaRWQSPu/SkgVsvOtu5qU7ThZhWQrUcZnQNZ1R4jdmVXdzgnVytjAelIAZAtgO03idJpdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522132; c=relaxed/simple;
	bh=Yu5wXHweYC+7uw2bLXNg9Zx6SAg3LgmRfIMA09JWC2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYZBB/3oHxw7BlMWl6+2ojjqZZCZ5Y7jyo4PjV5r5Dtq6iE6U09Mu3YvZIabK/NWc9MIdQTl9mbfPSi65a+XuJbYEk1y0Jd+DmtLkHQM2S3ZE/xj9AglN1hMleqMmG3b3khH2QFkwTbw9ReXtOyS4GES0Civo0Yuujaxce+xfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azEvkHFe; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azEvkHFe"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e202e0so3213483a91.2
        for <selinux@vger.kernel.org>; Mon, 18 Aug 2025 06:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755522130; x=1756126930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6Hkp+Ql0DCw8Fjo9TOkdgJ2k+jl3fnJ7pgYpOY6UBo=;
        b=azEvkHFedobwESvmSLWX0TFZFc1Kuf3VOybyeVYl/72cg44vmnRWqB8QvpKQrAMQCK
         W5AB0xKatfp/6GkB4PiWNHHnGaeJ0Edt96RFGjBdzflPYOGx9wtLeXpWWbpKL2mWqtiS
         kDXtcAikAR6P5g0p4sB/QIkR8aaF6g1SfxC3jBuKbYAl5NlmD4bh8giAMmJi2Rzgqq2R
         VqaWgcB1m5uA4uVq/oaC8DR5qW84fVkt6/ZBKHUDSHBzLUa6YItujIc3IYxFpC0ID6yn
         c1FIZB6ALLQJgmUiNLHhRktYf6GI8www6B7JXW0vXm48SCUigB8gG9neSJR5q5dATevx
         2JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755522130; x=1756126930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6Hkp+Ql0DCw8Fjo9TOkdgJ2k+jl3fnJ7pgYpOY6UBo=;
        b=gKl8WhgIKTNN4mim8PQpNk3TDG4lsPDQppOlRzKWNj/8Fr0kzz3QmEOsgynhumV5zq
         SaVEwtPXefK3z1VFlvdNag44ISkq2bR6RBQmb1GGS8fua264vfajmW2Ikc/cDdiLqF9j
         9UYYgvQe6iPrDW/rbTeNDHCWeO0cLt/7HLYRFL8QwU2bruAVSoK+ekGTOyNSX0em81PQ
         7FD4QFK8e+KGlmHUGGOfz6cGET2Z5A9AXiP6w4Aw1EYVpZ9y8oFMaBnl9lsaAIdZMShd
         f/C4pnZXfbOVBbulAinRHQcXFyVK3uJjCl2XjVxPpYe160it854kBT0Cgg/t/FOnQQ3/
         viEg==
X-Gm-Message-State: AOJu0YyFf5DtqvVA+eyC46C55jb/HZgyG7gjdN9ZGl7lIY19Ni1KtQVT
	JcyU84Gj07WC8SRWlfcqtXto5QjCV9fsRmnLgVCP+6kJkRCU88Q2oCHX/ZS3jJkO/fmU3SPE1RY
	vqjvGfgiow4/BIpZ7que7OGJDXH+n1vyaUh12
X-Gm-Gg: ASbGncvmYnks/93CBYVVLe/iqieb5zUWUvw4en+TiJcsPrMvcEPkLaCbv9PBinskXtx
	a+631X/YAM7NrUEFLLk0TUcLAvJOLeucd/ZG/d9zlKR5uFhf6aMXdODTK+vzbkaTZxaNsI3FYrG
	Lv72Jf919pH1p5yASciuxY42rVMKGVZgE2qUYaDdtOBDBdGznQpgKpCsae9zTWQ2xx6uf1pGhdU
	PITpVE=
X-Google-Smtp-Source: AGHT+IHvAk1CzHYrnuSIgbSZlRTMYadhcDMI+k9yt77AgjNNhayuI+FrxGud/Uw5CRxCsppE1hNwGKAHWY2ao1BQdjw=
X-Received: by 2002:a17:90b:2fcd:b0:31f:7160:df4b with SMTP id
 98e67ed59e1d1-3234dbbfcfemr14432942a91.15.1755522038550; Mon, 18 Aug 2025
 06:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816201420.197-1-ericsu@linux.microsoft.com>
In-Reply-To: <20250816201420.197-1-ericsu@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 Aug 2025 09:00:27 -0400
X-Gm-Features: Ac12FXwzVfXJp3XCqzk2tCaM4mBFbjX9flbAm3MYezDyvRO2i8ft5EZclI8xnxI
Message-ID: <CAEjxPJ64tMA5zsYh=NHa4gBeC6ytDqS8DenfFc5S5H95m_Aeow@mail.gmail.com>
Subject: Re: [PATCH v2] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 4:14=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> BPF token support was introduced to allow a privileged process to delegat=
e
> limited BPF functionality=E2=80=94such as map creation and program loadin=
g=E2=80=94to an
> unprivileged process:
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
> badkward compability. If disabled, previous behavior ((checks based on

backward compatibility

> current process SID)) is preserved.
>
> Changes in v2:
> - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
>   creator_sid from wrong file descriptor
> - Removed unnecessary checks for null, per review comments from
>   the first patch
>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> ---
>  security/selinux/hooks.c                   | 93 +++++++++++++++++++++-
>  security/selinux/include/classmap.h        |  2 +-
>  security/selinux/include/objsec.h          |  4 +
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  6 ++
>  6 files changed, 104 insertions(+), 3 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 335fbf76cdd2..29b35ed4c306 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -733,6 +733,8 @@ static int selinux_set_mnt_opts(struct super_block *s=
b,
>                 goto out;
>         }
>
> +       sbsec->creator_sid =3D current_sid();
> +
>         if (strcmp(sb->s_type->name, "proc") =3D=3D 0)
>                 sbsec->flags |=3D SE_SBPROC | SE_SBGENFS;
>
> @@ -7002,9 +7004,13 @@ static int selinux_ib_alloc_security(void *ib_sec)
>  static int selinux_bpf(int cmd, union bpf_attr *attr,
>                        unsigned int size, bool kernel)
>  {
> +       bool bpf_token_perms =3D selinux_policycap_bpf_token_perms();
>         u32 sid =3D current_sid();
>         int ret;
>
> +       if (bpf_token_perms)
> +               return 0;
> +
>         switch (cmd) {
>         case BPF_MAP_CREATE:
>                 ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_CRE=
ATE,
> @@ -7086,10 +7092,29 @@ static int selinux_bpf_prog(struct bpf_prog *prog=
)
>                             BPF__PROG_RUN, NULL);
>  }
>
> +static int selinux_bpffs_creator_sid(u32 fd)
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
> @@ -7098,7 +7123,12 @@ static int selinux_bpf_map_create(struct bpf_map *=
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
> @@ -7113,6 +7143,7 @@ static int selinux_bpf_prog_load(struct bpf_prog *p=
rog, union bpf_attr *attr,
>                                  struct bpf_token *token, bool kernel)
>  {
>         struct bpf_security_struct *bpfsec;
> +       u32 ssid;
>
>         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>         if (!bpfsec)
> @@ -7121,7 +7152,12 @@ static int selinux_bpf_prog_load(struct bpf_prog *=
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
> @@ -7132,10 +7168,18 @@ static void selinux_bpf_prog_free(struct bpf_prog=
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
> +
> +       if (sid =3D=3D SECSID_NULL)
> +               return -EPERM;

Still doing a hardcoded return of -EPERM here with no log or audit
message or way to override if permissive.
Is this even possible? If so, would still prefer to let it fall
through to the permission checks that will show up as access denied to
unlabeled_t,
which will alert the user and offer the option of overriding via
permissive mode or an allow rule.

>
>         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>         if (!bpfsec)
> @@ -7144,6 +7188,29 @@ static int selinux_bpf_token_create(struct bpf_tok=
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
