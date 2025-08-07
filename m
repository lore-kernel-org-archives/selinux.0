Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812F26281
	for <selinux@vger.kernel.org>; Thu,  7 Aug 2025 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574410; cv=none; b=CQd7Ae4tz3wmg8Jfr2f4qr84e45apVBxYcU4RxYslIAO7/kVHjmRjhzr85ZH1tOu2FfCb1kP6VcqiqUluSacQHXpINlXkmpj6iGmOz1mGN3f0z5Aq+B54TfAj8IxsXJZ3jADCGfiGWuO3WE26mi5vfAXVHSeBbmuThlSLVqDvRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574410; c=relaxed/simple;
	bh=XgQIMKXZypefAPws8BgnEPhFcW+uQDfhigmekBIqr+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISQpa4HCYa2v/FYFiL01Y2Oq3p7RBuELGaUFcvDiAOJagAGMoCEpAEj2/HcRh4IyUTBh1mIhGbfSuUxuHBEbJ85P248lL7b2WLXvmquK94SHivcKxT8PU2HHeBlkt7UoDrJL5W5H9LriUWrDeyCf9itym5sIulwfBUWpQXUhWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQvR9ooN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQvR9ooN"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso914019b3a.1
        for <selinux@vger.kernel.org>; Thu, 07 Aug 2025 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754574408; x=1755179208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofgsuSG9CM4UzSPbKaMZBz1USZaI6AQJqc3AUctwRs0=;
        b=HQvR9ooN1cOD04C01mpRlxWE8ti6h25C4T/HIR83u6tH6RQyhkhc/RnkmDZThEasYM
         g7salnz5VyVsBKNDeF/h3nJy7CDYM0WKrRAwRwrr25t1ts61pMj9KRahOYJvH7PCSH8p
         YM8+VucTTXt8b9vy8Q7jKOI0pqPd6OE4CwffIdAdNbPYG9RoRX1pV4O4QbX8R8AS70mu
         ojg9wX3Zv186AjAMQojJUziuzmZbreaGnqJGuWhxmAokSMy7tgV4CD022uYXtCRqgjlJ
         Es5EoR6HQP5dRUnB7f2CekuMjI5uThQxqgusqOhhUah4jiwbFXaL5doCCjMvPFC+0izh
         kIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754574408; x=1755179208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofgsuSG9CM4UzSPbKaMZBz1USZaI6AQJqc3AUctwRs0=;
        b=lxg9b0Mv+ssMLpJCs/75qZdtohb69GH38NLLSZX7AtcIzghgz6GcKKr10iJKqipIjx
         aJkBjqCAyhcksOs3voKwUDbkud+eiSrZO/xD7zF0lFPi4LY+ehqvCvHZhxooRdy1kn07
         JqegttLIqNz6WbCvdSQJKZpMC+Ca15umq7PtW7sOLuJObiTvga0UEDmJOS4WYFWcLoxo
         yiU1tdYleOqnzpVK0pTnXZixRF9eaY5WZZ4K7TUqsMhZXy4Fx+Rvy/A67xwGLkNzYHyE
         l5MePTWJ1/a3DnyDWoWrE6SfeATZHRWDPvqa5ljjuiFGqsXFcSWEMOhD90BKBGXEd8Tw
         JiRQ==
X-Gm-Message-State: AOJu0YyVjyK8j8d06XCUEVWWihyhYMc/pjmaRJVEZ3m2+Yzb98+w8pIF
	zRKLr+V0RJF9ymdNcngsynmQL+TcaSShv05CwZCXEI6x6P94vo6bu90a+iyR0aO4f81fktKs2be
	u1IeNwjlcuw7UP/DBBzq0xiLH0tEhcVQ=
X-Gm-Gg: ASbGncvb+L84d3KCL4CjgmRNqeYebeaGiI7m4p1qb7WpPGkbongqlLPnIWlCxLi8N+X
	qw2BahG8QIlT6403q/un/QauFKxAxNfHjlJHvG5VFcYEKr701kg0qWfQHAoj4Ne/yUhBp4IPboy
	ADULohFp/YRidTLcby0WmWyVOpEGOo1hCoCJOQJysx2NU/nRTTgiAMIt6QnUulDPDTgiAmx4/vY
	MzVyaE=
X-Google-Smtp-Source: AGHT+IG2j6pmwPfuIrEDSPrIBLHk1SuCTJyw/hPPyzVaRCj6XJ5O9C7hT7nq1bYgfM8spQT4bzEidSc+Hz6KEV/msG0=
X-Received: by 2002:a17:902:e5c3:b0:23f:ecc1:ed6f with SMTP id
 d9443c01a7336-2429f562ac1mr105349575ad.17.1754574407835; Thu, 07 Aug 2025
 06:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180149.1995-1-ericsu@linux.microsoft.com> <CAEjxPJ4MPBmjfr_e6x94XmDHUhZR+EJ0_Gqyjn8mbALL2HNKJw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4MPBmjfr_e6x94XmDHUhZR+EJ0_Gqyjn8mbALL2HNKJw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 7 Aug 2025 09:46:36 -0400
X-Gm-Features: Ac12FXx8AOKX9EWHNFuTUtrS_NHLDkOE_eYCU98gcLZGLq6bhV4LneETTLNUPvw
Message-ID: <CAEjxPJ4Xk81Tc=o532SvqWeeig4wt-oOt8Np0DubUBbfFuVLnQ@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: ericsu@linux.microsoft.com, danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:33=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 6, 2025 at 2:07=E2=80=AFPM <ericsu@linux.microsoft.com> wrote=
:
> >
> > From: Eric Suen <ericsu@linux.microsoft.com>
> >
> > BPF token support was introduced to allow a privileged process to deleg=
ate
> > limited BPF functionality=E2=80=94such as map creation and program load=
ing=E2=80=94to an
> > unprivileged process:
> >   https://lore.kernel.org/linux-security-module/20231130185229.2688956-=
1-andrii@kernel.org/
> >
> > This patch adds SELinux support for controlling BPF token access. With
> > this change, SELinux policies can now enforce constraints on BPF token
> > usage based on both the delegating (privileged) process and the recipie=
nt
> > (unprivileged) process.
> >
> > Supported operations currently include:
> >   - map_create
> >   - prog_load
> >
> > High-level workflow:
> >   1. An unprivileged process creates a VFS context via `fsopen()` and
> >      obtains a file descriptor.
> >   2. This descriptor is passed to a privileged process, which configure=
s
> >      BPF token delegation options and mounts a BPF filesystem.
> >   3. SELinux records the `creator_sid` of the privileged process during
> >      mount setup.
> >   4. The unprivileged process then uses this BPF fs mount to create a
> >      token and attach it to subsequent BPF syscalls.
> >   5. During verification of `map_create` and `prog_load`, SELinux uses
> >      `creator_sid` and the current SID to check policy permissions via:
> >        avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
> >                     BPF__MAP_CREATE, NULL);
> >
> > To verify the logic introduced by this patch, my fork of the SELinux
> > testsuite with relevant test cases is available here:
> >   https://github.com/havefuncoding1/selinux-testsuite
>
> Interesting approach. Added Daniel to the distribution. Can you please
> also post your testsuite patch to the list for review as per
> https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#sub=
mitting-a-testsuite-patch

Also, since you are introducing new permissions and a policy
capability, please include instructions in the commit description for
running your testsuite, see
https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#add-n=
ew-permissions
and
https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#addin=
g-a-new-selinux-policy-capability
for instructions and links to example previous commits.

>
> >
> > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> > ---
> >  security/selinux/hooks.c                   | 107 ++++++++++++++++++++-
> >  security/selinux/include/classmap.h        |   2 +-
> >  security/selinux/include/objsec.h          |   4 +
> >  security/selinux/include/policycap.h       |   1 +
> >  security/selinux/include/policycap_names.h |   1 +
> >  security/selinux/include/security.h        |   6 ++
> >  6 files changed, 118 insertions(+), 3 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 335fbf76cdd2..ef9771542737 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -733,6 +733,8 @@ static int selinux_set_mnt_opts(struct super_block =
*sb,
> >                 goto out;
> >         }
> >
> > +       sbsec->creator_sid =3D current_sid();
> > +
> >         if (strcmp(sb->s_type->name, "proc") =3D=3D 0)
> >                 sbsec->flags |=3D SE_SBPROC | SE_SBGENFS;
> >
> > @@ -7002,9 +7004,13 @@ static int selinux_ib_alloc_security(void *ib_se=
c)
> >  static int selinux_bpf(int cmd, union bpf_attr *attr,
> >                        unsigned int size, bool kernel)
> >  {
> > +       bool bpf_token_perms =3D selinux_policycap_bpf_token_perms();
> >         u32 sid =3D current_sid();
> >         int ret;
> >
> > +       if (bpf_token_perms)
> > +               return 0;
> > +
> >         switch (cmd) {
> >         case BPF_MAP_CREATE:
> >                 ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_C=
REATE,
> > @@ -7086,10 +7092,34 @@ static int selinux_bpf_prog(struct bpf_prog *pr=
og)
> >                             BPF__PROG_RUN, NULL);
> >  }
> >
> > +static int selinux_bpffs_creator_sid(const union bpf_attr *attr)
> > +{
> > +       struct path path;
> > +       struct super_block *sb;
> > +       struct superblock_security_struct *sbsec;
> > +
> > +       CLASS(fd, f)(attr->token_create.bpffs_fd);
> > +
> > +       if (!fd_file(f))
> > +               return SECSID_NULL;
> > +
> > +       path =3D fd_file(f)->f_path;
> > +       sb =3D path.dentry->d_sb;
> > +       if (!sb)
> > +               return SECSID_NULL;
> > +
> > +       sbsec =3D selinux_superblock(sb);
> > +       if (!sbsec)
> > +               return SECSID_NULL;
> > +
> > +       return sbsec->creator_sid;
> > +}
> > +
> >  static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr =
*attr,
> >                                   struct bpf_token *token, bool kernel)
> >  {
> >         struct bpf_security_struct *bpfsec;
> > +       u32 ssid;
> >
> >         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> >         if (!bpfsec)
> > @@ -7098,7 +7128,15 @@ static int selinux_bpf_map_create(struct bpf_map=
 *map, union bpf_attr *attr,
> >         bpfsec->sid =3D current_sid();
> >         map->security =3D bpfsec;
> >
> > -       return 0;
> > +       if (!token)
> > +               ssid =3D bpfsec->sid;
> > +       else {
> > +               ssid =3D selinux_bpffs_creator_sid(attr);
> > +               if (ssid =3D=3D SECSID_NULL)
> > +                       return -EPERM;
> > +       }
> > +
> > +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__MAP_C=
REATE, NULL);
> >  }
> >
> >  static void selinux_bpf_map_free(struct bpf_map *map)
> > @@ -7113,6 +7151,7 @@ static int selinux_bpf_prog_load(struct bpf_prog =
*prog, union bpf_attr *attr,
> >                                  struct bpf_token *token, bool kernel)
> >  {
> >         struct bpf_security_struct *bpfsec;
> > +       u32 ssid;
> >
> >         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> >         if (!bpfsec)
> > @@ -7121,7 +7160,15 @@ static int selinux_bpf_prog_load(struct bpf_prog=
 *prog, union bpf_attr *attr,
> >         bpfsec->sid =3D current_sid();
> >         prog->aux->security =3D bpfsec;
> >
> > -       return 0;
> > +       if (!token)
> > +               ssid =3D bpfsec->sid;
> > +       if (token) {
> > +               ssid =3D selinux_bpffs_creator_sid(attr);
> > +               if (ssid =3D=3D SECSID_NULL)
> > +                       return -EPERM;
> > +       }
> > +
> > +       return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__PROG_=
LOAD, NULL);
> >  }
> >
> >  static void selinux_bpf_prog_free(struct bpf_prog *prog)
> > @@ -7132,10 +7179,18 @@ static void selinux_bpf_prog_free(struct bpf_pr=
og *prog)
> >         kfree(bpfsec);
> >  }
> >
> > +#define bpf_token_cmd(T, C) \
> > +       ((T)->allowed_cmds & (1ULL << (C)))
> > +
> >  static int selinux_bpf_token_create(struct bpf_token *token, union bpf=
_attr *attr,
> >                                     const struct path *path)
> >  {
> >         struct bpf_security_struct *bpfsec;
> > +       u32 sid =3D selinux_bpffs_creator_sid(attr);
> > +       int err;
> > +
> > +       if (sid =3D=3D SECSID_NULL)
> > +               return -EPERM;
> >
> >         bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> >         if (!bpfsec)
> > @@ -7144,6 +7199,29 @@ static int selinux_bpf_token_create(struct bpf_t=
oken *token, union bpf_attr *att
> >         bpfsec->sid =3D current_sid();
> >         token->security =3D bpfsec;
> >
> > +       bpfsec->perms =3D 0;
> > +
> > +       /**
> > +        * 'token->allowed_cmds' is a bit mask of allowed commands
> > +        * Convert the BPF command enum to a bitmask representing its p=
osition in the
> > +        * allowed_cmds bitmap.
> > +        */
> > +       if (bpf_token_cmd(token, BPF_MAP_CREATE)) {
> > +               err =3D avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, BP=
F__MAP_CREATE_AS, NULL);
> > +               if (err)
> > +                       return err;
> > +
> > +               bpfsec->perms |=3D BPF__MAP_CREATE;
> > +       }
> > +
> > +       if (bpf_token_cmd(token, BPF_PROG_LOAD)) {
> > +               err =3D avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, BP=
F__PROG_LOAD_AS, NULL);
> > +               if (err)
> > +                       return err;
> > +
> > +               bpfsec->perms |=3D BPF__PROG_LOAD;
> > +       }
> > +
> >         return 0;
> >  }
> >
> > @@ -7154,6 +7232,30 @@ static void selinux_bpf_token_free(struct bpf_to=
ken *token)
> >         token->security =3D NULL;
> >         kfree(bpfsec);
> >  }
> > +
> > +static int selinux_bpf_token_cmd(const struct bpf_token *token, enum b=
pf_cmd cmd)
> > +{
> > +       struct bpf_security_struct *bpfsec;
> > +
> > +       if (!token || !token->security)
> > +               return -EINVAL;
> > +
> > +       bpfsec =3D token->security;
> > +       switch (cmd) {
> > +       case BPF_MAP_CREATE:
> > +               if ((bpfsec->perms & BPF__MAP_CREATE) !=3D BPF__MAP_CRE=
ATE)
> > +                       return -EACCES;
> > +               break;
> > +       case BPF_PROG_LOAD:
> > +               if ((bpfsec->perms & BPF__PROG_LOAD) !=3D BPF__PROG_LOA=
D)
> > +                       return -EACCES;
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return 0;
> > +}
> >  #endif
> >
> >  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
> > @@ -7585,6 +7687,7 @@ static struct security_hook_list selinux_hooks[] =
__ro_after_init =3D {
> >         LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
> >         LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
> >         LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
> > +       LSM_HOOK_INIT(bpf_token_cmd, selinux_bpf_token_cmd),
> >  #endif
> >  #ifdef CONFIG_PERF_EVENTS
> >         LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index 5665aa5e7853..a6ed864af64c 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -171,7 +171,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
> >         { "infiniband_endport", { "manage_subnet", NULL } },
> >         { "bpf",
> >           { "map_create", "map_read", "map_write", "prog_load", "prog_r=
un",
> > -           NULL } },
> > +           "map_create_as", "prog_load_as", NULL } },
> >         { "xdp_socket", { COMMON_SOCK_PERMS, NULL } },
> >         { "mctp_socket", { COMMON_SOCK_PERMS, NULL } },
> >         { "perf_event",
> > diff --git a/security/selinux/include/objsec.h b/security/selinux/inclu=
de/objsec.h
> > index 1d7ac59015a1..b7e55e5c6d9c 100644
> > --- a/security/selinux/include/objsec.h
> > +++ b/security/selinux/include/objsec.h
> > @@ -87,6 +87,8 @@ struct superblock_security_struct {
> >         u32 sid; /* SID of file system superblock */
> >         u32 def_sid; /* default SID for labeling */
> >         u32 mntpoint_sid; /* SECURITY_FS_USE_MNTPOINT context for files=
 */
> > +       u32 creator_sid;        /* SID of privileged process and is use=
d to */
> > +                                               /* verify bpf operation=
s */
> >         unsigned short behavior; /* labeling behavior */
> >         unsigned short flags; /* which mount options were specified */
> >         struct mutex lock;
> > @@ -164,6 +166,8 @@ struct pkey_security_struct {
> >
> >  struct bpf_security_struct {
> >         u32 sid; /* SID of bpf obj creator */
> > +       u32 perms;      /* allowed AV permissions, e.g. BPF__MAP_CREATE=
, */
> > +                               /* for requested bpf commands */
> >  };
> >
> >  struct perf_event_security_struct {
> > diff --git a/security/selinux/include/policycap.h b/security/selinux/in=
clude/policycap.h
> > index 7405154e6c42..cde6aaf442cd 100644
> > --- a/security/selinux/include/policycap.h
> > +++ b/security/selinux/include/policycap.h
> > @@ -17,6 +17,7 @@ enum {
> >         POLICYDB_CAP_NETLINK_XPERM,
> >         POLICYDB_CAP_NETIF_WILDCARD,
> >         POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> > +       POLICYDB_CAP_BPF_TOKEN_PERMS,
> >         __POLICYDB_CAP_MAX
> >  };
> >  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> > diff --git a/security/selinux/include/policycap_names.h b/security/seli=
nux/include/policycap_names.h
> > index d8962fcf2ff9..cd5e73f992ea 100644
> > --- a/security/selinux/include/policycap_names.h
> > +++ b/security/selinux/include/policycap_names.h
> > @@ -20,6 +20,7 @@ const char *const selinux_policycap_names[__POLICYDB_=
CAP_MAX] =3D {
> >         "netlink_xperm",
> >         "netif_wildcard",
> >         "genfs_seclabel_wildcard",
> > +       "bpf_token_perms",
> >  };
> >  /* clang-format on */
> >
> > diff --git a/security/selinux/include/security.h b/security/selinux/inc=
lude/security.h
> > index 8201e6a3ac0f..d3832e4ad4fb 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -209,6 +209,12 @@ static inline bool selinux_policycap_netif_wildcar=
d(void)
> >                 selinux_state.policycap[POLICYDB_CAP_NETIF_WILDCARD]);
> >  }
> >
> > +static inline bool selinux_policycap_bpf_token_perms(void)
> > +{
> > +       return READ_ONCE(
> > +               selinux_state.policycap[POLICYDB_CAP_BPF_TOKEN_PERMS]);
> > +}
> > +
> >  struct selinux_policy_convert_data;
> >
> >  struct selinux_load_state {
> > --
> > 2.50.1.windows.1
> >
> >
