Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C030274668
	for <selinux@vger.kernel.org>; Fri,  8 Aug 2025 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754680112; cv=none; b=F4GJ5iaHZNAIWwa886f+CjU76AdTHAJpFL8c+pBlTMJx2N4sMfC/l0xO0LLxchmHzIAJisGPlofc7dfsotOF4gbRr28TfC1oBoSggkUIBpSnulZOnke7Wh8rV771+tCswfJ8fvbsjqXroFE2GOq4z5odK1ZvfS0dItz/E/OysGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754680112; c=relaxed/simple;
	bh=GeBbJszbChOiR5dOIH4IJffcbajJdqP9Z20tJImGBeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwOOcZ502GX+wfCN2x8JJbZded/mQU+hoGJmf8E+YvVDfcclJ7DQEKOSNJoIBIqdggliMReloKOLdkstOfgin1zA0O27watOgQVJyP4vl0NJXF8V+eIeRCiZk7c7MPnG5DQB+91sWKANRlpRCq/pj71CmyNtO4hVhAvKYaqjPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlEhzKc0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlEhzKc0"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2429d9d3755so25676445ad.3
        for <selinux@vger.kernel.org>; Fri, 08 Aug 2025 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754680109; x=1755284909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsjwIHc8Ie5m83W12a91iYxtlfNk7fFGLpdjCcrZrdI=;
        b=hlEhzKc0LbkozwvT5rPe5sBsrPZbrc557cqmpvuXoUba7WvX2mGvKnKdiPevKv7mc2
         fn8xSdadMUcpvPiWwp26NQAy6uZ7pjJ/If5HZ5pBv6CBjVrbSGNWsO8FlLubn5S2sppd
         rAck2ULcZFKfOEaQ760RQBK24su9hhe+31cmS7dtxC40Mmab18dJbEx1TDizVgJ3rUNU
         v94rEOcJYC9bYuUpXZ1hXROHeVvBTWqFJMQetudGjg0TBrA0kaZo1X5mJEBmb2/oZFNW
         PJwPVtpmewZALJ1Z+/faX16DRpVKs4wCJwn/9mWPuu04OiO95hyxAbS/b6sxMvTannzx
         XeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754680110; x=1755284910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsjwIHc8Ie5m83W12a91iYxtlfNk7fFGLpdjCcrZrdI=;
        b=G1cjVG8ybbec0G387xmoS7MXvqNAi/dgX0KIuRDqlLs7AeRp+hbRVVLPCLG7P0Z3+7
         vhVDIb07OnUNPGdvtGVUUdc/DgtolxhveRNxuwjM+6OvVgO5FH2gd61QC3eqozKaOdu1
         NruNGzSzyEjOrSFZMNoLuxxjzCLYg67RyiVru9YbMrAuhhGQ6dJLa2HlKm5DfSkf1Nm1
         TLFIcay4gDSgeJG7C0OMJiq979tyH+UYJUsAqLphH+NNvwUuYBahhumQDjIMW0530QyW
         Lmn1bPy2D005/5CspsOpZNXbFjfpQfHZRVKulz/USFd2WjvJoAoDWbl7mSDjtA0KA9Ns
         fRSw==
X-Forwarded-Encrypted: i=1; AJvYcCXkckmw3ERoOGzJ9udxS/9bT0GXU5JpcggS90Z2vSa6eJS+XikAQf1YJ0v5AIjqxncUGHNAeJxi@vger.kernel.org
X-Gm-Message-State: AOJu0YxBPate5dXKUxQEUbr1B9/AMYiJIuS/t9uxTs3YUBA0y2BynxMi
	ikBjJRHl1WK8lRxQB3DFYxB3uWXlwoTxyS0172CEDunrWCkg692mhd01BEZb67aoK2Z1uNJEeOK
	2wWlXPJcwYtaeVAaiOnPPPbGiG0b6ng4=
X-Gm-Gg: ASbGncvXb1YbfOHojNHHtg0vL+h1S88Nc5Ys49rdIK8trbI9rPWgb0zDvLJ/LcVhDou
	OAs/yB29khe9z8obkqmfCsIv59iGPMKw/85AqoDSc1Ojcy4z1manGpeh3+GzeeTIVI6xr7mksR9
	HEwfwUjYu0i6GjJN/yJFYemD8D2jpv8Gh1uqr9JK1sfV2G8qBrRarmxxORJrmVAHyOzkhvcgFUu
	4T2SWg=
X-Google-Smtp-Source: AGHT+IEkmeZMISGj4xeuZgW5+Et7SZTO3FlW7AAbY0wnqGt/KTolZmsF5XV79chYNOiFl1kRfDcX/yygP3ikcHwMK1s=
X-Received: by 2002:a17:902:f688:b0:240:7235:6292 with SMTP id
 d9443c01a7336-242c224cca8mr73338075ad.39.1754680109368; Fri, 08 Aug 2025
 12:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180149.1995-1-ericsu@linux.microsoft.com>
 <CAEjxPJ4MPBmjfr_e6x94XmDHUhZR+EJ0_Gqyjn8mbALL2HNKJw@mail.gmail.com>
 <CAEjxPJ4Xk81Tc=o532SvqWeeig4wt-oOt8Np0DubUBbfFuVLnQ@mail.gmail.com> <34426151-7d7b-427b-912e-84174c4d9e92@linux.microsoft.com>
In-Reply-To: <34426151-7d7b-427b-912e-84174c4d9e92@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 8 Aug 2025 15:08:18 -0400
X-Gm-Features: Ac12FXx1nRL0igMHPMLxqlRGHNOxM5q2TyKlp056TeGZE_VLRHqRftBIokdMcFg
Message-ID: <CAEjxPJ75frqsXCg9K5y1tviQht7jU+CnsQ65+fuH3b7zdrFThw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: danieldurning.work@gmail.com, selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 2:57=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.co=
m> wrote:
>
> On 8/7/2025 6:46 AM, Stephen Smalley wrote:
> > On Wed, Aug 6, 2025 at 2:33=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> On Wed, Aug 6, 2025 at 2:07=E2=80=AFPM <ericsu@linux.microsoft.com> wr=
ote:
> >>> From: Eric Suen <ericsu@linux.microsoft.com>
> >>>
> >>> BPF token support was introduced to allow a privileged process to del=
egate
> >>> limited BPF functionality=E2=80=94such as map creation and program lo=
ading=E2=80=94to an
> >>> unprivileged process:
> >>>    https://lore.kernel.org/linux-security-module/20231130185229.26889=
56-1-andrii@kernel.org/
> >>>
> >>> This patch adds SELinux support for controlling BPF token access. Wit=
h
> >>> this change, SELinux policies can now enforce constraints on BPF toke=
n
> >>> usage based on both the delegating (privileged) process and the recip=
ient
> >>> (unprivileged) process.
> >>>
> >>> Supported operations currently include:
> >>>    - map_create
> >>>    - prog_load
> >>>
> >>> High-level workflow:
> >>>    1. An unprivileged process creates a VFS context via `fsopen()` an=
d
> >>>       obtains a file descriptor.
> >>>    2. This descriptor is passed to a privileged process, which config=
ures
> >>>       BPF token delegation options and mounts a BPF filesystem.
> >>>    3. SELinux records the `creator_sid` of the privileged process dur=
ing
> >>>       mount setup.
> >>>    4. The unprivileged process then uses this BPF fs mount to create =
a
> >>>       token and attach it to subsequent BPF syscalls.
> >>>    5. During verification of `map_create` and `prog_load`, SELinux us=
es
> >>>       `creator_sid` and the current SID to check policy permissions v=
ia:
> >>>         avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
> >>>                      BPF__MAP_CREATE, NULL);
> >>>
> >>> To verify the logic introduced by this patch, my fork of the SELinux
> >>> testsuite with relevant test cases is available here:
> >>>    https://github.com/havefuncoding1/selinux-testsuite
> >> Interesting approach. Added Daniel to the distribution. Can you please
> >> also post your testsuite patch to the list for review as per
> >> https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#=
submitting-a-testsuite-patch
> > Also, since you are introducing new permissions and a policy
> > capability, please include instructions in the commit description for
> > running your testsuite, see
> > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#a=
dd-new-permissions
> > and
> > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#a=
dding-a-new-selinux-policy-capability
> > for instructions and links to example previous commits.
>
> Hi Stephen, just posted patch for user space capability and it's
> available here
> https://lore.kernel.org/selinux/20250808183506.665-1-ericsu@linux.microso=
ft.com/
>
> also posted patch for the testsuite
> https://lore.kernel.org/selinux/20250808184711.291-1-ericsu@linux.microso=
ft.com/,
> and yes I ran the tests with policy cap enabled in my environment.

No need to re-submit the testsuite patch just for this, but on future
iterations, please include the instructions
in the commit message for how to temporarily enable the policy
capability and define the new permissions for
testing purposes, as shown in this example linked from the SELinux
kernel Getting Started wiki page:
https://github.com/SELinuxProject/selinux-testsuite/commit/023b79b8319e5fe2=
22fb5af892c579593e1cbc50

>
> >>> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> >>> ---
> >>>   security/selinux/hooks.c                   | 107 ++++++++++++++++++=
++-
> >>>   security/selinux/include/classmap.h        |   2 +-
> >>>   security/selinux/include/objsec.h          |   4 +
> >>>   security/selinux/include/policycap.h       |   1 +
> >>>   security/selinux/include/policycap_names.h |   1 +
> >>>   security/selinux/include/security.h        |   6 ++
> >>>   6 files changed, 118 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >>> index 335fbf76cdd2..ef9771542737 100644
> >>> --- a/security/selinux/hooks.c
> >>> +++ b/security/selinux/hooks.c
> >>> @@ -733,6 +733,8 @@ static int selinux_set_mnt_opts(struct super_bloc=
k *sb,
> >>>                  goto out;
> >>>          }
> >>>
> >>> +       sbsec->creator_sid =3D current_sid();
> >>> +
> >>>          if (strcmp(sb->s_type->name, "proc") =3D=3D 0)
> >>>                  sbsec->flags |=3D SE_SBPROC | SE_SBGENFS;
> >>>
> >>> @@ -7002,9 +7004,13 @@ static int selinux_ib_alloc_security(void *ib_=
sec)
> >>>   static int selinux_bpf(int cmd, union bpf_attr *attr,
> >>>                         unsigned int size, bool kernel)
> >>>   {
> >>> +       bool bpf_token_perms =3D selinux_policycap_bpf_token_perms();
> >>>          u32 sid =3D current_sid();
> >>>          int ret;
> >>>
> >>> +       if (bpf_token_perms)
> >>> +               return 0;
> >>> +
> >>>          switch (cmd) {
> >>>          case BPF_MAP_CREATE:
> >>>                  ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MA=
P_CREATE,
> >>> @@ -7086,10 +7092,34 @@ static int selinux_bpf_prog(struct bpf_prog *=
prog)
> >>>                              BPF__PROG_RUN, NULL);
> >>>   }
> >>>
> >>> +static int selinux_bpffs_creator_sid(const union bpf_attr *attr)
> >>> +{
> >>> +       struct path path;
> >>> +       struct super_block *sb;
> >>> +       struct superblock_security_struct *sbsec;
> >>> +
> >>> +       CLASS(fd, f)(attr->token_create.bpffs_fd);
> >>> +
> >>> +       if (!fd_file(f))
> >>> +               return SECSID_NULL;
> >>> +
> >>> +       path =3D fd_file(f)->f_path;
> >>> +       sb =3D path.dentry->d_sb;
> >>> +       if (!sb)
> >>> +               return SECSID_NULL;
> >>> +
> >>> +       sbsec =3D selinux_superblock(sb);
> >>> +       if (!sbsec)
> >>> +               return SECSID_NULL;
> >>> +
> >>> +       return sbsec->creator_sid;
> >>> +}
> >>> +
> >>>   static int selinux_bpf_map_create(struct bpf_map *map, union bpf_at=
tr *attr,
> >>>                                    struct bpf_token *token, bool kern=
el)
> >>>   {
> >>>          struct bpf_security_struct *bpfsec;
> >>> +       u32 ssid;
> >>>
> >>>          bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> >>>          if (!bpfsec)
> >>> @@ -7098,7 +7128,15 @@ static int selinux_bpf_map_create(struct bpf_m=
ap *map, union bpf_attr *attr,
> >>>          bpfsec->sid =3D current_sid();
> >>>          map->security =3D bpfsec;
> >>>
> >>> -       return 0;
> >>> +       if (!token)
> >>> +               ssid =3D bpfsec->sid;
> >>> +       else {
> >>> +               ssid =3D selinux_bpffs_creator_sid(attr);
> >>> +               if (ssid =3D=3D SECSID_NULL)
> >>> +                       return -EPERM;
> >>> +       }
> >>> +
> >>> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__MAP=
_CREATE, NULL);
> >>>   }
> >>>
> >>>   static void selinux_bpf_map_free(struct bpf_map *map)
> >>> @@ -7113,6 +7151,7 @@ static int selinux_bpf_prog_load(struct bpf_pro=
g *prog, union bpf_attr *attr,
> >>>                                   struct bpf_token *token, bool kerne=
l)
> >>>   {
> >>>          struct bpf_security_struct *bpfsec;
> >>> +       u32 ssid;
> >>>
> >>>          bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> >>>          if (!bpfsec)
> >>> @@ -7121,7 +7160,15 @@ static int selinux_bpf_prog_load(struct bpf_pr=
og *prog, union bpf_attr *attr,
> >>>          bpfsec->sid =3D current_sid();
> >>>          prog->aux->security =3D bpfsec;
> >>>
> >>> -       return 0;
> >>> +       if (!token)
> >>> +               ssid =3D bpfsec->sid;
> >>> +       if (token) {
> >>> +               ssid =3D selinux_bpffs_creator_sid(attr);
> >>> +               if (ssid =3D=3D SECSID_NULL)
> >>> +                       return -EPERM;
> >>> +       }
> >>> +
> >>> +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__PRO=
G_LOAD, NULL);
> >>>   }
> >>>
> >>>   static void selinux_bpf_prog_free(struct bpf_prog *prog)
> >>> @@ -7132,10 +7179,18 @@ static void selinux_bpf_prog_free(struct bpf_=
prog *prog)
> >>>          kfree(bpfsec);
> >>>   }
> >>>
> >>> +#define bpf_token_cmd(T, C) \
> >>> +       ((T)->allowed_cmds & (1ULL << (C)))
> >>> +
> >>>   static int selinux_bpf_token_create(struct bpf_token *token, union =
bpf_attr *attr,
> >>>                                      const struct path *path)
> >>>   {
> >>>          struct bpf_security_struct *bpfsec;
> >>> +       u32 sid =3D selinux_bpffs_creator_sid(attr);
> >>> +       int err;
> >>> +
> >>> +       if (sid =3D=3D SECSID_NULL)
> >>> +               return -EPERM;
> >>>
> >>>          bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> >>>          if (!bpfsec)
> >>> @@ -7144,6 +7199,29 @@ static int selinux_bpf_token_create(struct bpf=
_token *token, union bpf_attr *att
> >>>          bpfsec->sid =3D current_sid();
> >>>          token->security =3D bpfsec;
> >>>
> >>> +       bpfsec->perms =3D 0;
> >>> +
> >>> +       /**
> >>> +        * 'token->allowed_cmds' is a bit mask of allowed commands
> >>> +        * Convert the BPF command enum to a bitmask representing its=
 position in the
> >>> +        * allowed_cmds bitmap.
> >>> +        */
> >>> +       if (bpf_token_cmd(token, BPF_MAP_CREATE)) {
> >>> +               err =3D avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, =
BPF__MAP_CREATE_AS, NULL);
> >>> +               if (err)
> >>> +                       return err;
> >>> +
> >>> +               bpfsec->perms |=3D BPF__MAP_CREATE;
> >>> +       }
> >>> +
> >>> +       if (bpf_token_cmd(token, BPF_PROG_LOAD)) {
> >>> +               err =3D avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, =
BPF__PROG_LOAD_AS, NULL);
> >>> +               if (err)
> >>> +                       return err;
> >>> +
> >>> +               bpfsec->perms |=3D BPF__PROG_LOAD;
> >>> +       }
> >>> +
> >>>          return 0;
> >>>   }
> >>>
> >>> @@ -7154,6 +7232,30 @@ static void selinux_bpf_token_free(struct bpf_=
token *token)
> >>>          token->security =3D NULL;
> >>>          kfree(bpfsec);
> >>>   }
> >>> +
> >>> +static int selinux_bpf_token_cmd(const struct bpf_token *token, enum=
 bpf_cmd cmd)
> >>> +{
> >>> +       struct bpf_security_struct *bpfsec;
> >>> +
> >>> +       if (!token || !token->security)
> >>> +               return -EINVAL;
> >>> +
> >>> +       bpfsec =3D token->security;
> >>> +       switch (cmd) {
> >>> +       case BPF_MAP_CREATE:
> >>> +               if ((bpfsec->perms & BPF__MAP_CREATE) !=3D BPF__MAP_C=
REATE)
> >>> +                       return -EACCES;
> >>> +               break;
> >>> +       case BPF_PROG_LOAD:
> >>> +               if ((bpfsec->perms & BPF__PROG_LOAD) !=3D BPF__PROG_L=
OAD)
> >>> +                       return -EACCES;
> >>> +               break;
> >>> +       default:
> >>> +               break;
> >>> +       }
> >>> +
> >>> +       return 0;
> >>> +}
> >>>   #endif
> >>>
> >>>   struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
> >>> @@ -7585,6 +7687,7 @@ static struct security_hook_list selinux_hooks[=
] __ro_after_init =3D {
> >>>          LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
> >>>          LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
> >>>          LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
> >>> +       LSM_HOOK_INIT(bpf_token_cmd, selinux_bpf_token_cmd),
> >>>   #endif
> >>>   #ifdef CONFIG_PERF_EVENTS
> >>>          LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> >>> diff --git a/security/selinux/include/classmap.h b/security/selinux/i=
nclude/classmap.h
> >>> index 5665aa5e7853..a6ed864af64c 100644
> >>> --- a/security/selinux/include/classmap.h
> >>> +++ b/security/selinux/include/classmap.h
> >>> @@ -171,7 +171,7 @@ const struct security_class_mapping secclass_map[=
] =3D {
> >>>          { "infiniband_endport", { "manage_subnet", NULL } },
> >>>          { "bpf",
> >>>            { "map_create", "map_read", "map_write", "prog_load", "pro=
g_run",
> >>> -           NULL } },
> >>> +           "map_create_as", "prog_load_as", NULL } },
> >>>          { "xdp_socket", { COMMON_SOCK_PERMS, NULL } },
> >>>          { "mctp_socket", { COMMON_SOCK_PERMS, NULL } },
> >>>          { "perf_event",
> >>> diff --git a/security/selinux/include/objsec.h b/security/selinux/inc=
lude/objsec.h
> >>> index 1d7ac59015a1..b7e55e5c6d9c 100644
> >>> --- a/security/selinux/include/objsec.h
> >>> +++ b/security/selinux/include/objsec.h
> >>> @@ -87,6 +87,8 @@ struct superblock_security_struct {
> >>>          u32 sid; /* SID of file system superblock */
> >>>          u32 def_sid; /* default SID for labeling */
> >>>          u32 mntpoint_sid; /* SECURITY_FS_USE_MNTPOINT context for fi=
les */
> >>> +       u32 creator_sid;        /* SID of privileged process and is u=
sed to */
> >>> +                                               /* verify bpf operati=
ons */
> >>>          unsigned short behavior; /* labeling behavior */
> >>>          unsigned short flags; /* which mount options were specified =
*/
> >>>          struct mutex lock;
> >>> @@ -164,6 +166,8 @@ struct pkey_security_struct {
> >>>
> >>>   struct bpf_security_struct {
> >>>          u32 sid; /* SID of bpf obj creator */
> >>> +       u32 perms;      /* allowed AV permissions, e.g. BPF__MAP_CREA=
TE, */
> >>> +                               /* for requested bpf commands */
> >>>   };
> >>>
> >>>   struct perf_event_security_struct {
> >>> diff --git a/security/selinux/include/policycap.h b/security/selinux/=
include/policycap.h
> >>> index 7405154e6c42..cde6aaf442cd 100644
> >>> --- a/security/selinux/include/policycap.h
> >>> +++ b/security/selinux/include/policycap.h
> >>> @@ -17,6 +17,7 @@ enum {
> >>>          POLICYDB_CAP_NETLINK_XPERM,
> >>>          POLICYDB_CAP_NETIF_WILDCARD,
> >>>          POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> >>> +       POLICYDB_CAP_BPF_TOKEN_PERMS,
> >>>          __POLICYDB_CAP_MAX
> >>>   };
> >>>   #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> >>> diff --git a/security/selinux/include/policycap_names.h b/security/se=
linux/include/policycap_names.h
> >>> index d8962fcf2ff9..cd5e73f992ea 100644
> >>> --- a/security/selinux/include/policycap_names.h
> >>> +++ b/security/selinux/include/policycap_names.h
> >>> @@ -20,6 +20,7 @@ const char *const selinux_policycap_names[__POLICYD=
B_CAP_MAX] =3D {
> >>>          "netlink_xperm",
> >>>          "netif_wildcard",
> >>>          "genfs_seclabel_wildcard",
> >>> +       "bpf_token_perms",
> >>>   };
> >>>   /* clang-format on */
> >>>
> >>> diff --git a/security/selinux/include/security.h b/security/selinux/i=
nclude/security.h
> >>> index 8201e6a3ac0f..d3832e4ad4fb 100644
> >>> --- a/security/selinux/include/security.h
> >>> +++ b/security/selinux/include/security.h
> >>> @@ -209,6 +209,12 @@ static inline bool selinux_policycap_netif_wildc=
ard(void)
> >>>                  selinux_state.policycap[POLICYDB_CAP_NETIF_WILDCARD]=
);
> >>>   }
> >>>
> >>> +static inline bool selinux_policycap_bpf_token_perms(void)
> >>> +{
> >>> +       return READ_ONCE(
> >>> +               selinux_state.policycap[POLICYDB_CAP_BPF_TOKEN_PERMS]=
);
> >>> +}
> >>> +
> >>>   struct selinux_policy_convert_data;
> >>>
> >>>   struct selinux_load_state {
> >>> --
> >>> 2.50.1.windows.1
> >>>
> >>>
>
