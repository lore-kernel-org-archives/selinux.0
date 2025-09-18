Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE82EA154
	for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201699; cv=none; b=guMfynRLAK2xlg027AOfrwQxXzgclT12snmT2VRanApVEl+B1tJyWVgUo5U7/nL9M4KWTRyiTGkGKkC3432CvW+MMko6DOaRxerx51aXilL1AqqKq3IbU7CnChqALP/z6FaUHRyttYhOTx2+qHSoc6VtO2wE4zdklf9CvZ2qGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201699; c=relaxed/simple;
	bh=0j9dj3N0UkMkYMRznfeqZe26IOMGTLrjVtwgp/94ftE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+iMG4SmNhuaE3sRoi9RlZqZqJgKdzCeFO3DmimtPs662lEU38MnJdFUeosS6zKmR7xbr8KAumw8mmtjYyAV6fSp8KAE8FwlHLSvXmC1h8F0mmQEqo4E6HBWigQs+4c/tI6tFBcUObGT4jXUK+ZOzIWzD0GIbhgYEwrV1JrNk1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXInTZtW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXInTZtW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32dc4faa0d7so703066a91.1
        for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758201697; x=1758806497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXxuG0XXZ2CUEkR517o9YLIawLxCf0z3nLMq0JlK2WM=;
        b=FXInTZtWk9lNifOfcq3mUbyoCim2i1/72uOqSjB0jlhH4BL6PCE1Fcsi8Q174XenKC
         fk4R32NwAU4UNelj5ufp2yzoB/igtQdwY6LVN/pdFBnam1y4rqhmTXMv3IcOZSKuzAxF
         63Yqf1fGW0UlodCHZe1gdFSH0nLEi381U3zi37QnVvycweg55c0VbQK97LqmeVC5FRzW
         dwRAupooBNS1UKY0v/2hhk0nSza4OT7v/6/WzPJgkHHMf+P3fstVPmBMP7lLc4IzY0iN
         PAnyKcCf4FZGEC0kPnb4ZJXQpVtXexD2UTM30St+nje0QBDwrEW+tRPyXyh9yJFKExFl
         ou5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201697; x=1758806497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXxuG0XXZ2CUEkR517o9YLIawLxCf0z3nLMq0JlK2WM=;
        b=PX2a0LmDk5HGjIsEDU3GSK2Ah4y4T2TRIObqabcHRdk2l23NTB2NpbNPDqr+IEAz7A
         YA2Fw6D+EIXa31CI3kneKhLxoD+RONeb8+MmpB7N0+6Rn35B4VzWfGEK527RRMP2wprq
         Xso392amY8bRRHhbY3G5aTQ67QkQaeeWG3lEjF0RXZJECz3GIGpDy9Kgd2YZfvAEY3y2
         ZjzqPNi7NAZDtMg+bc2dRv1CXwTKGVZDn8Q+IN7fP9xONyyy+X8+DsL5u8i1eg8QFGEh
         WAP+Ko+L+hcA2Y2In5e2DnOJB06ODqYGj9yJ/z6o/wPMcBDiYrGmWAHYZpbWxNA5pXKR
         yAfw==
X-Forwarded-Encrypted: i=1; AJvYcCUSM/EP254fjC2E+LSQLiv9Wk/0z38jMHS8nedO/WN1ovUckDs3w7Rjr036dJEQPUy6D2UZzSxY@vger.kernel.org
X-Gm-Message-State: AOJu0YzifLfX2z1Xdzca/9PitdcyxlgOkzmdSE6FHvMt6++0KLmsY56F
	r9V+MmeUuh4JfwCqc3ct3gmxNgeADkLiusY1CUr93YvC1p9JdNnQZNRVKnJDTjClIWtP8gFOFde
	oakdfijcr6bccnFT7Blq87Qj3IEK6zi8=
X-Gm-Gg: ASbGncsOS9YkxiEBhqA4UeRKs8eaufVBvIqzbBpsTkVaDs1QAAcBTTKzAmnP29WLLDr
	T37yNomZ5PeGMFoH5J5yjk7+VV08m8tqW7Ci1sOcCT5YDBw3Zfg7HZEoCaJdUmGEiLGHUyLyiOB
	7xk7Uv93b1UhClFMUQdw2S0BJVlwuHhOcpqWPMNk7CIg/kUkOQQJzsOtlPQSPnHKNmZPPFsL9sO
	RzBNvCl08hQtV3YPrD0TzMCNw==
X-Google-Smtp-Source: AGHT+IEnjpkTWLCQa+CWj7BavA5ALvKGzVwQe85nvKFpYbfFsEBJjiEExOrH1PCFbaVN1zCXE1Rm7mKuObPQUoR+2TE=
X-Received: by 2002:a17:90b:384f:b0:32e:59e7:c37f with SMTP id
 98e67ed59e1d1-32ee3ef0cd6mr8705000a91.12.1758201696382; Thu, 18 Sep 2025
 06:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918020434.1612137-1-tweek@google.com>
In-Reply-To: <20250918020434.1612137-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 18 Sep 2025 09:21:25 -0400
X-Gm-Features: AS18NWC6hAaYPr9mZDSCAKWisfn4LDvK8z5iTIGk5nKtO93zNOxjlf-1udEy7BM
Message-ID: <CAEjxPJ6qe2WzikK64qH+iqeWd2BkTk+tgq1tMUf1u6H7UYrH1Q@mail.gmail.com>
Subject: Re: [PATCH v3] memfd,selinux: call security_inode_init_security_anon
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Isaac Manjarres <isaacmanjarres@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:04=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
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

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

For testing, I reverted the previous revert of the memfd_class policy
capability on selinux userspace, built and installed the modified
libsepol, and then followed the instructions in the testsuite commit
description.
Also confirmed manual execution of the tests in both enforcing and
permissive mode yields the expected behavior, and the WARN_ON() was
not triggered.

> ---
> Changes since v2:
> - Add WARN_ON when using unexpected class. Return -EACCES instead
>   of -EPERM
> - Remove extra new line
> - Rebase on selinux/dev
>
> Changes since v1:
> - Move test of class earlier in selinux_bprm_creds_for_exec
> - Remove duplicate call to security_transition_sid
>
> Changes since RFC:
> - Remove enum argument, simply compare the anon inode name
> - Introduce a policy capability for compatility
> - Add validation of class in selinux_bprm_creds_for_exec
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
> index 0e47b4bb8d40..2b685f9dd61d 100644
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
> @@ -2319,6 +2320,10 @@ static int selinux_bprm_creds_for_exec(struct linu=
x_binprm *bprm)
>         new_tsec =3D selinux_cred(bprm->cred);
>         isec =3D inode_security(inode);
>
> +       if (WARN_ON(isec->sclass !=3D SECCLASS_FILE &&
> +                   isec->sclass !=3D SECCLASS_MEMFD_FILE))
> +               return -EACCES;
> +
>         /* Default to the current task SID. */
>         new_tsec->sid =3D old_tsec->sid;
>         new_tsec->osid =3D old_tsec->sid;
> @@ -2371,8 +2376,8 @@ static int selinux_bprm_creds_for_exec(struct linux=
_binprm *bprm)
>         ad.u.file =3D bprm->file;
>
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
> @@ -2382,8 +2387,8 @@ static int selinux_bprm_creds_for_exec(struct linux=
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
> @@ -2978,10 +2983,18 @@ static int selinux_inode_init_security_anon(struc=
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
> @@ -3001,7 +3014,10 @@ static int selinux_inode_init_security_anon(struct=
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
> index 135a969f873c..231d02227e59 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -18,6 +18,7 @@ enum {
>         POLICYDB_CAP_NETIF_WILDCARD,
>         POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
>         POLICYDB_CAP_FUNCTIONFS_SECLABEL,
> +       POLICYDB_CAP_MEMFD_CLASS,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinu=
x/include/policycap_names.h
> index ff8882887651..454dab37bda3 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -21,6 +21,7 @@ const char *const selinux_policycap_names[__POLICYDB_CA=
P_MAX] =3D {
>         "netif_wildcard",
>         "genfs_seclabel_wildcard",
>         "functionfs_seclabel",
> +       "memfd_class",
>  };
>  /* clang-format on */
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index 0f954a40d3fc..5d1dad8058b1 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -209,6 +209,11 @@ static inline bool selinux_policycap_functionfs_secl=
abel(void)
>                 selinux_state.policycap[POLICYDB_CAP_FUNCTIONFS_SECLABEL]=
);
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
