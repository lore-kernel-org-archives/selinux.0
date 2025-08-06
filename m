Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27181114
	for <selinux@vger.kernel.org>; Wed,  6 Aug 2025 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505198; cv=none; b=OdJTnzP4nDPYAnidS7OXfs6fFKyNgfZVMueaEz+5U1QgNfM0wUaiaz/fvpCjd4f5NWV2yiEHuDnWDJFnnKq6Foma5FJ8FoG++Sm7d9SSiee1To+Z4uoE89lk691y6oLRZN6yCamlX7CHlMx5lBh/hC3TTHwO0O97ENtw/qh/Gz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505198; c=relaxed/simple;
	bh=iQiM3uev8fbGi4Rl6KzYwkhUUfycQMC13cv63S2f0ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8lJiPKTXEOtdUNYcC02Kjtfj59MeLsY5UIoC1dP66VPOFu/IFvjZH6VKb9QijYIZ9YAoPouhHX+fbU7KkQD42f+DWUN5tVav3nvmxO0R411lgFD+ABHjT33fHIh2hBTOyTxkpTtWPZgSdcCbBpNLK+dL66KP1mv5FLCGqTZDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTus6mKJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTus6mKJ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31f4e49dca0so303160a91.1
        for <selinux@vger.kernel.org>; Wed, 06 Aug 2025 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754505196; x=1755109996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEYn+VJPK9NY+i7aLgJuLFAoynhwX+EwHwSE0XpViqE=;
        b=TTus6mKJi57FaJ/5AalqX/VAGWnHFJYF20wIkKRz5UhjzW4WOD745QAV119WPhqWak
         EywfRm+yo6BgiNtOSwCU0J7D6tX3ZeYDhsQMATgwafLARj3+CDaMm6Q5FdhBYnHtUxJO
         rYsKTpVbqKjsxHC3ha2BdNRMRuliaQhiVMPnk1x4w3GQDSk8gO7TcOHvqGTEvCqtDRjK
         mPZq9b1PvkuR1Ogs5jB98iRd3/0NrJ3LgMybw680xQW50/kKumZczeKgyCdCuycQzS7a
         MUUMml6GBwMTPjQBMGZNGYZEoT/Dy3gkgI+119BFRnw9Wm09fmIWZvQtaAH+EV5c2K2Y
         jr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754505196; x=1755109996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEYn+VJPK9NY+i7aLgJuLFAoynhwX+EwHwSE0XpViqE=;
        b=aCBhidBF+j91GL1GPkX9LTsD64dNoODUchknrsuQq+BOWtyFTWK39qmvI8m0rKZl2A
         PhzvWYF9KZMkaSyhmPnTjot+VkyHuVnVFv9YWGVL59URn3H0uEYKLCMiITrEWl7k3b9j
         Tkv9C/Oh6kizwqvtd6fNN6MBJ6gnYpAqz0tuExnfm7ZV9gEt+Sb2xQvUuQvG6Gf8ZlhS
         3a4iP70DHGLcc1yDbOoZb2Ys8f30T+btRWnxiwWFC5G5yvvsN4i1roz97tnYuvCSImMk
         +/A4pEpGErUJotUFEfEMvvPDwpznH0/WBYhO92WYib9wClOsN5VEYAbwkx3gKseYTeOb
         KUDw==
X-Gm-Message-State: AOJu0YzbnGbDcn2XAZJ/bQxr/Ou55L5Z5yWGZK5OC3NERVZ784w74O+K
	6ZIBsnDQwI8bNrEYpxnKUnah2CJ5cZbbPBWin89WuhOkBYm40efHAPN7ot3cm85/fhVka4LBIas
	b3eMkmIttCyL5unmNz7gjU5OliFL5EeM=
X-Gm-Gg: ASbGncs7UlY0qKChFNWsguky4l24kNy+cWmF9WmL62PmGSDxyn3V6He9R49aaVpvHm1
	EzxK9tUzvM8CRL3ipx7H/qjqMRtl8VX02J/X7cavLKHtQMgRh1iUBFDwXFT1lC5BVqkOAWbr8Vy
	tRmIMqCD/wAtzxH41HNX2BDA2fyJ0DFA8RYPN+kyC8WcQasU0gXr7NM9V51iwHyv+CIDJzYkHHu
	1MvMD4=
X-Google-Smtp-Source: AGHT+IH3AMQUVctBWU23/ZuLYsP2YkEox/I6zUAXgofKR1iStKPXwNcuKUTcZ3INVKvOAmoVsSiQVvnufU3li7fG59w=
X-Received: by 2002:a17:90b:5185:b0:311:df4b:4b94 with SMTP id
 98e67ed59e1d1-32166c0fb00mr5259882a91.4.1754505195666; Wed, 06 Aug 2025
 11:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180149.1995-1-ericsu@linux.microsoft.com>
In-Reply-To: <20250806180149.1995-1-ericsu@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 6 Aug 2025 14:33:04 -0400
X-Gm-Features: Ac12FXxsV6FbvbaUsIGTu9NGebtToomwcm_Pzjp74FSdP70m8vKlrknODlf_a_A
Message-ID: <CAEjxPJ4MPBmjfr_e6x94XmDHUhZR+EJ0_Gqyjn8mbALL2HNKJw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: ericsu@linux.microsoft.com, danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:07=E2=80=AFPM <ericsu@linux.microsoft.com> wrote:
>
> From: Eric Suen <ericsu@linux.microsoft.com>
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
> To verify the logic introduced by this patch, my fork of the SELinux
> testsuite with relevant test cases is available here:
>   https://github.com/havefuncoding1/selinux-testsuite

Interesting approach. Added Daniel to the distribution. Can you please
also post your testsuite patch to the list for review as per
https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#submi=
tting-a-testsuite-patch

>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> ---
>  security/selinux/hooks.c                   | 107 ++++++++++++++++++++-
>  security/selinux/include/classmap.h        |   2 +-
>  security/selinux/include/objsec.h          |   4 +
>  security/selinux/include/policycap.h       |   1 +
>  security/selinux/include/policycap_names.h |   1 +
>  security/selinux/include/security.h        |   6 ++
>  6 files changed, 118 insertions(+), 3 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 335fbf76cdd2..ef9771542737 100644
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
> @@ -7086,10 +7092,34 @@ static int selinux_bpf_prog(struct bpf_prog *prog=
)
>                             BPF__PROG_RUN, NULL);
>  }
>
> +static int selinux_bpffs_creator_sid(const union bpf_attr *attr)
> +{
> +       struct path path;
> +       struct super_block *sb;
> +       struct superblock_security_struct *sbsec;
> +
> +       CLASS(fd, f)(attr->token_create.bpffs_fd);
> +
> +       if (!fd_file(f))
> +               return SECSID_NULL;
> +
> +       path =3D fd_file(f)->f_path;
> +       sb =3D path.dentry->d_sb;
> +       if (!sb)
> +               return SECSID_NULL;
> +
> +       sbsec =3D selinux_superblock(sb);
> +       if (!sbsec)
> +               return SECSID_NULL;
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
> @@ -7098,7 +7128,15 @@ static int selinux_bpf_map_create(struct bpf_map *=
map, union bpf_attr *attr,
>         bpfsec->sid =3D current_sid();
>         map->security =3D bpfsec;
>
> -       return 0;
> +       if (!token)
> +               ssid =3D bpfsec->sid;
> +       else {
> +               ssid =3D selinux_bpffs_creator_sid(attr);
> +               if (ssid =3D=3D SECSID_NULL)
> +                       return -EPERM;
> +       }
> +
> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__MAP_CRE=
ATE, NULL);
>  }
>
>  static void selinux_bpf_map_free(struct bpf_map *map)
> @@ -7113,6 +7151,7 @@ static int selinux_bpf_prog_load(struct bpf_prog *p=
rog, union bpf_attr *attr,
>                                  struct bpf_token *token, bool kernel)
>  {
>         struct bpf_security_struct *bpfsec;
> +       u32 ssid;
>
>         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>         if (!bpfsec)
> @@ -7121,7 +7160,15 @@ static int selinux_bpf_prog_load(struct bpf_prog *=
prog, union bpf_attr *attr,
>         bpfsec->sid =3D current_sid();
>         prog->aux->security =3D bpfsec;
>
> -       return 0;
> +       if (!token)
> +               ssid =3D bpfsec->sid;
> +       if (token) {
> +               ssid =3D selinux_bpffs_creator_sid(attr);
> +               if (ssid =3D=3D SECSID_NULL)
> +                       return -EPERM;
> +       }
> +
> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__PROG_LO=
AD, NULL);
>  }
>
>  static void selinux_bpf_prog_free(struct bpf_prog *prog)
> @@ -7132,10 +7179,18 @@ static void selinux_bpf_prog_free(struct bpf_prog=
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
> +       u32 sid =3D selinux_bpffs_creator_sid(attr);
> +       int err;
> +
> +       if (sid =3D=3D SECSID_NULL)
> +               return -EPERM;
>
>         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>         if (!bpfsec)
> @@ -7144,6 +7199,29 @@ static int selinux_bpf_token_create(struct bpf_tok=
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
> @@ -7154,6 +7232,30 @@ static void selinux_bpf_token_free(struct bpf_toke=
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
> +       if (!token || !token->security)
> +               return -EINVAL;
> +
> +       bpfsec =3D token->security;
> +       switch (cmd) {
> +       case BPF_MAP_CREATE:
> +               if ((bpfsec->perms & BPF__MAP_CREATE) !=3D BPF__MAP_CREAT=
E)
> +                       return -EACCES;
> +               break;
> +       case BPF_PROG_LOAD:
> +               if ((bpfsec->perms & BPF__PROG_LOAD) !=3D BPF__PROG_LOAD)
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
> @@ -7585,6 +7687,7 @@ static struct security_hook_list selinux_hooks[] __=
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
> index 5665aa5e7853..a6ed864af64c 100644
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
> index 1d7ac59015a1..b7e55e5c6d9c 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -87,6 +87,8 @@ struct superblock_security_struct {
>         u32 sid; /* SID of file system superblock */
>         u32 def_sid; /* default SID for labeling */
>         u32 mntpoint_sid; /* SECURITY_FS_USE_MNTPOINT context for files *=
/
> +       u32 creator_sid;        /* SID of privileged process and is used =
to */
> +                                               /* verify bpf operations =
*/
>         unsigned short behavior; /* labeling behavior */
>         unsigned short flags; /* which mount options were specified */
>         struct mutex lock;
> @@ -164,6 +166,8 @@ struct pkey_security_struct {
>
>  struct bpf_security_struct {
>         u32 sid; /* SID of bpf obj creator */
> +       u32 perms;      /* allowed AV permissions, e.g. BPF__MAP_CREATE, =
*/
> +                               /* for requested bpf commands */
>  };
>
>  struct perf_event_security_struct {
> diff --git a/security/selinux/include/policycap.h b/security/selinux/incl=
ude/policycap.h
> index 7405154e6c42..cde6aaf442cd 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -17,6 +17,7 @@ enum {
>         POLICYDB_CAP_NETLINK_XPERM,
>         POLICYDB_CAP_NETIF_WILDCARD,
>         POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> +       POLICYDB_CAP_BPF_TOKEN_PERMS,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinu=
x/include/policycap_names.h
> index d8962fcf2ff9..cd5e73f992ea 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -20,6 +20,7 @@ const char *const selinux_policycap_names[__POLICYDB_CA=
P_MAX] =3D {
>         "netlink_xperm",
>         "netif_wildcard",
>         "genfs_seclabel_wildcard",
> +       "bpf_token_perms",
>  };
>  /* clang-format on */
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index 8201e6a3ac0f..d3832e4ad4fb 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -209,6 +209,12 @@ static inline bool selinux_policycap_netif_wildcard(=
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
> 2.50.1.windows.1
>
>
