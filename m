Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255B1DF26E;
	Mon,  8 Sep 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348865; cv=none; b=NJwgssJy+sVaSqOQtVkESwOuy57JL7k88Enib9a54pjuyxGhEleVzt6LZyYxjCci4iBgNI6EybMcAa8lcoZnpahDdk+GClH7qBYM375Jyo9wo6iNTUqNoR19ghrtg24ZphSLMBnHeiR9HLb5Hi9HBXPXtD1OAju46zBrHVoC/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348865; c=relaxed/simple;
	bh=uAjfT1L3OyOOxDwRnSPnci+e8sb9M2EIL0YCmuLss6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwGVTQ/82vULB+rTqptJGADQyVWo+amuH+viBOpfxxvRHcoA1u094BsfAW1P+VFg1COKjLq4G2WNmc6hk03OkagWEPlBKmvulIMYvJ1P5po1/s+rKfCwCb7hhBd3lYMUWxYuf3XhshTW1H2xy3XcwHpju/oYHk3kyA2SIfQ9D8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSbiB32f; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSbiB32f"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so3053739a12.3;
        Mon, 08 Sep 2025 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757348863; x=1757953663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eqksz8Elm+j9d5P5oS54jOmzSpQqif5zj7qYCyq5Noc=;
        b=OSbiB32fecLlXpCzbIjM3fUkwSGcMlKuyB156grqexROrKQ9R6LBPFlnIjPhu3MYOX
         c4UyA7ZiCsalS9K6ZRPFLm9e0V62CT1kZueRv/m6K3yAbdEqao5BYn4KDVhl1e9cKW77
         DhaIs+Eiid7ujETRA6oxLLBEOKrE8koga68mFHIwkQSpkmXNLCO/G5igC92vmBssJfqV
         HILkX0vfUDO8u1OwbypY1oSBqh/1M2vOm+sMyC0FQ1fNy5OgxwXL6+kp8eWloAz1Aot7
         /MaFpN2Zin7dI8i8a+uDQWrYkNFFZ79TiXpOoDU9UpXN8/RyvBof/fQd+GvHI/5A0S9C
         4LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757348863; x=1757953663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eqksz8Elm+j9d5P5oS54jOmzSpQqif5zj7qYCyq5Noc=;
        b=KjL+BlNv7LOXmX5+3SWWxk0XO7JRM5OY5d37S9fCFJEDpRsowhVhDYUhOLFtjM15LZ
         03PLh4m5IY7OvORFWmMUILnJYtE6ex7KBgnnJCTSkMPA3JN4MASsUG+HzqVaJgwMGQ+F
         7n/PVakR0fGKQfbEB6aElT/1fNLIY4U+y0uEv6m0zmDUqkr4m/MBLo9CqsTPmbsN3fK8
         ue1Ize9G7DRwcH/ZlU8VjAtDLnkScXC48GjnlfSBB2kHZPCoAA2S8NuqNG+EA8C9HZSZ
         +cABobQbtYQDgP/FBmrr4x4ELf+5f5S4XF0WSb4rE9Drin4O/XCPcATaqSXSIKzRw2IR
         8RoA==
X-Forwarded-Encrypted: i=1; AJvYcCUJZoiTSD/QU47rrm9vyCthZoxZD476+/N+QYR23U8p7GzaHHbIdQLVDqN72u+cUhUZjXudoTHIxxuzxmY=@vger.kernel.org, AJvYcCVK3+5B59VjPEvcJ/npT3jKLrVSMPDm5HfA/TjRo3IdCG63jmfl5+2aCGDusn15oUjubR3wXSNfVw==@vger.kernel.org, AJvYcCXAt6MJAJiJPzCoKQ569Y5+cC3DyCEUPSyHSvk2XaauNAsAYReHMyBDWBoQ+LLTpZ/u6rO8Itvp4Q4UoJgxu7fE9+z3qaRX@vger.kernel.org
X-Gm-Message-State: AOJu0YynCQ3OfUI/wgcfWIDtk2gNps2AJv3R4R4FK7/yBbGddwp5zmhg
	RhsCY2qT3TIeAqHOYqwJ/WEOq9ewzEc4akTav+66xcaSn85uA+/jWAxVQmXzcAxT7ZE//aAvzps
	OHXBDZ/rA6p3aPEZiTislcMc8x8dsu5o=
X-Gm-Gg: ASbGnct+BOBkERH5Gd4RmTgGkSL1q5BNchYG+q/KFYG9sKvwDJr9NYfpcou0sp1VnIW
	TnE0SC3VhXWAbDpBMlNKr78txkiNCxYCDnUQtZ6ojztlllciLugH7dM2HwkVGxMdKKfqiTPfZga
	CcCKlPpuTa7TBULWAT0ZwUlJQFasHdnapTe/PA6zHid6Ed0/UpN0uuffuGD7FANrRVo0Vz2UOhz
	MkUBaSMwDD0UeW6lw==
X-Google-Smtp-Source: AGHT+IEDHB8CQ3IuTWj7RQjTDdTxecjnrrL3Sce+3gGLzG/rmTLFq4zmdmZQREIb8tm2hwLEHCSVH3EIkU0L2w92lBA=
X-Received: by 2002:a17:90b:3d04:b0:32b:623d:ee9e with SMTP id
 98e67ed59e1d1-32d43eff92bmr11113951a91.14.1757348862937; Mon, 08 Sep 2025
 09:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908013419.4186627-1-tweek@google.com>
In-Reply-To: <20250908013419.4186627-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 8 Sep 2025 12:27:30 -0400
X-Gm-Features: Ac12FXzOq5uQaG3MIFlG7lf0qwtknS8Lq4am64oYOyVC_0QFQ4mNZM_xLLwrHZk
Message-ID: <CAEjxPJ6QfUZijh3PEpHs_Yw6Hmte92-rg8gkvMw9cD=JxA+CMA@mail.gmail.com>
Subject: Re: [PATCH v2] memfd,selinux: call security_inode_init_security_anon
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Isaac Manjarres <isaacmanjarres@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 9:34=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> Prior to this change, no security hooks were called at the creation of a
> memfd file. It means that, for SELinux as an example, it will receive
> the default type of the filesystem that backs the in-memory inode. In
> most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> be hugetlbfs. Both can be considered implementation details of memfd.
>
> It also means that it is not possible to differentiate between a file
> coming from memfd_create and a file coming from a standard tmpfs mount
> point.
>
> Additionally, no permission is validated at creation, which differs from
> the similar memfd_secret syscall.
>
> Call security_inode_init_security_anon during creation. This ensures
> that the file is setup similarly to other anonymous inodes. On SELinux,
> it means that the file will receive the security context of its task.
>
> The ability to limit fexecve on memfd has been of interest to avoid
> potential pitfalls where /proc/self/exe or similar would be executed
> [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> similarly to the file class. These access vectors may not make sense for
> the existing "anon_inode" class. Therefore, define and assign a new
> class "memfd_file" to support such access vectors.
>
> Guard these changes behind a new policy capability named "memfd_class".
>
> [1] https://crbug.com/1305267
> [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.com=
/
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

When you revise a patch, you aren't supposed to retain other's tags
since they haven't technically reviewed, agreed to, or tested the
revised change.
That said, I have now done so and thus these tags can remain!

> ---
> Changes since v1:
> - Move test of class earlier in selinux_bprm_creds_for_exec
> - Remove duplicate call to security_transition_sid
>
> Changes since RFC:
> - Remove enum argument, simply compare the anon inode name
> - Introduce a policy capability for compatility
> - Add validation of class in selinux_bprm_creds_for_exec
>
>  include/linux/memfd.h                      |  2 ++
>  mm/memfd.c                                 | 14 ++++++++++--
>  security/selinux/hooks.c                   | 26 +++++++++++++++++-----
>  security/selinux/include/classmap.h        |  2 ++
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  5 +++++
>  7 files changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> index 6f606d9573c3..cc74de3dbcfe 100644
> --- a/include/linux/memfd.h
> +++ b/include/linux/memfd.h
> @@ -4,6 +4,8 @@
>
>  #include <linux/file.h>
>
> +#define MEMFD_ANON_NAME "[memfd]"
> +
>  #ifdef CONFIG_MEMFD_CREATE
>  extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned in=
t arg);
>  struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
> diff --git a/mm/memfd.c b/mm/memfd.c
> index bbe679895ef6..63b439eb402a 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -433,6 +433,8 @@ static struct file *alloc_file(const char *name, unsi=
gned int flags)
>  {
>         unsigned int *file_seals;
>         struct file *file;
> +       struct inode *inode;
> +       int err =3D 0;
>
>         if (flags & MFD_HUGETLB) {
>                 file =3D hugetlb_file_setup(name, 0, VM_NORESERVE,
> @@ -444,12 +446,20 @@ static struct file *alloc_file(const char *name, un=
signed int flags)
>         }
>         if (IS_ERR(file))
>                 return file;
> +
> +       inode =3D file_inode(file);
> +       err =3D security_inode_init_security_anon(inode,
> +                       &QSTR(MEMFD_ANON_NAME), NULL);
> +       if (err) {
> +               fput(file);
> +               file =3D ERR_PTR(err);
> +               return file;
> +       }
> +
>         file->f_mode |=3D FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
>         file->f_flags |=3D O_LARGEFILE;
>
>         if (flags & MFD_NOEXEC_SEAL) {
> -               struct inode *inode =3D file_inode(file);
> -
>                 inode->i_mode &=3D ~0111;
>                 file_seals =3D memfd_file_seals_ptr(file);
>                 if (file_seals) {
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c95a5874bf7d..6adf2f393ed9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -93,6 +93,7 @@
>  #include <linux/fanotify.h>
>  #include <linux/io_uring/cmd.h>
>  #include <uapi/linux/lsm.h>
> +#include <linux/memfd.h>
>
>  #include "avc.h"
>  #include "objsec.h"
> @@ -2315,6 +2316,9 @@ static int selinux_bprm_creds_for_exec(struct linux=
_binprm *bprm)
>         new_tsec =3D selinux_cred(bprm->cred);
>         isec =3D inode_security(inode);
>
> +       if (isec->sclass !=3D SECCLASS_FILE && isec->sclass !=3D SECCLASS=
_MEMFD_FILE)
> +               return -EPERM;
> +
>         /* Default to the current task SID. */
>         new_tsec->sid =3D old_tsec->sid;
>         new_tsec->osid =3D old_tsec->sid;
> @@ -2366,9 +2370,10 @@ static int selinux_bprm_creds_for_exec(struct linu=
x_binprm *bprm)
>         ad.type =3D LSM_AUDIT_DATA_FILE;
>         ad.u.file =3D bprm->file;
>
> +
>         if (new_tsec->sid =3D=3D old_tsec->sid) {
> -               rc =3D avc_has_perm(old_tsec->sid, isec->sid,
> -                                 SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, =
&ad);
> +               rc =3D avc_has_perm(old_tsec->sid, isec->sid, isec->sclas=
s,
> +                                 FILE__EXECUTE_NO_TRANS, &ad);
>                 if (rc)
>                         return rc;
>         } else {
> @@ -2378,8 +2383,8 @@ static int selinux_bprm_creds_for_exec(struct linux=
_binprm *bprm)
>                 if (rc)
>                         return rc;
>
> -               rc =3D avc_has_perm(new_tsec->sid, isec->sid,
> -                                 SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
> +               rc =3D avc_has_perm(new_tsec->sid, isec->sid, isec->sclas=
s,
> +                                 FILE__ENTRYPOINT, &ad);
>                 if (rc)
>                         return rc;
>
> @@ -2974,10 +2979,18 @@ static int selinux_inode_init_security_anon(struc=
t inode *inode,
>         struct common_audit_data ad;
>         struct inode_security_struct *isec;
>         int rc;
> +       bool is_memfd =3D false;
>
>         if (unlikely(!selinux_initialized()))
>                 return 0;
>
> +       if (name !=3D NULL && name->name !=3D NULL &&
> +           !strcmp(name->name, MEMFD_ANON_NAME)) {
> +               if (!selinux_policycap_memfd_class())
> +                       return 0;
> +               is_memfd =3D true;
> +       }
> +
>         isec =3D selinux_inode(inode);
>
>         /*
> @@ -2997,7 +3010,10 @@ static int selinux_inode_init_security_anon(struct=
 inode *inode,
>                 isec->sclass =3D context_isec->sclass;
>                 isec->sid =3D context_isec->sid;
>         } else {
> -               isec->sclass =3D SECCLASS_ANON_INODE;
> +               if (is_memfd)
> +                       isec->sclass =3D SECCLASS_MEMFD_FILE;
> +               else
> +                       isec->sclass =3D SECCLASS_ANON_INODE;
>                 rc =3D security_transition_sid(
>                         sid, sid,
>                         isec->sclass, name, &isec->sid);
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 5665aa5e7853..3ec85142771f 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -179,6 +179,8 @@ const struct security_class_mapping secclass_map[] =
=3D {
>         { "anon_inode", { COMMON_FILE_PERMS, NULL } },
>         { "io_uring", { "override_creds", "sqpoll", "cmd", "allowed", NUL=
L } },
>         { "user_namespace", { "create", NULL } },
> +       { "memfd_file",
> +         { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } }=
,
>         /* last one */ { NULL, {} }
>  };
>
> diff --git a/security/selinux/include/policycap.h b/security/selinux/incl=
ude/policycap.h
> index 7405154e6c42..dabcc9f14dde 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -17,6 +17,7 @@ enum {
>         POLICYDB_CAP_NETLINK_XPERM,
>         POLICYDB_CAP_NETIF_WILDCARD,
>         POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> +       POLICYDB_CAP_MEMFD_CLASS,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinu=
x/include/policycap_names.h
> index d8962fcf2ff9..8e96f2a816b6 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -20,6 +20,7 @@ const char *const selinux_policycap_names[__POLICYDB_CA=
P_MAX] =3D {
>         "netlink_xperm",
>         "netif_wildcard",
>         "genfs_seclabel_wildcard",
> +       "memfd_class",
>  };
>  /* clang-format on */
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index 8201e6a3ac0f..72c963f54148 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -209,6 +209,11 @@ static inline bool selinux_policycap_netif_wildcard(=
void)
>                 selinux_state.policycap[POLICYDB_CAP_NETIF_WILDCARD]);
>  }
>
> +static inline bool selinux_policycap_memfd_class(void)
> +{
> +       return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_MEMFD_CLASS=
]);
> +}
> +
>  struct selinux_policy_convert_data;
>
>  struct selinux_load_state {
> --
> 2.51.0.384.g4c02a37b29-goog
>
