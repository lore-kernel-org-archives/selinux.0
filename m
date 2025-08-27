Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663321BCA07;
	Wed, 27 Aug 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301042; cv=none; b=CCo6iYiArZeGaY3sCvJjlDS/ASz7qPOI5JHXKHlRqIOHVxuGNRLxNNlgKMIL9/gRK3d2m43XNjNiX9Y8l1KaE+J7EDu12baw6USbvakkwZv8teMnFE0bthttRDR3quNcr5EGEKYaMqIz3vi5CT0n4XPcdRLMKIoPtpMvblwwsdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301042; c=relaxed/simple;
	bh=hjx/uoa80SZqvUAo5XbxoL3ZPIhgVRCbYC4iMT9S2jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBjwFlTnTESoPr8cSRlnYrXGNXUaPOaMKfSXjE/Ie4p3dYwSyw6e7S49TjtAJw/qbyI4SjvccqbuvB+kMHlzI6W2evLRBEeOQvFCHTO9rdP2AdEQvAtaZzGhDZVT9XZ6e9QiIrHIA5ls2lQK4g1DyAGuuJAwy39BlljkwkhV1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBT8DDmz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBT8DDmz"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326e5f058so4682378a91.3;
        Wed, 27 Aug 2025 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756301040; x=1756905840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+Z6EZIQR0o/UT5Ew23/Zd4wA8+f+oOfKWhDtiUSUCA=;
        b=XBT8DDmzfoRlnfWCkoozU9fH7X5aE6fUsoDh1H3Tdz9eiOis7xkdyRTQTXhpnWu1OM
         DVNL+/9Fqth4VfphaWMpUIHpqXHXsirZFaHHoLpKycUIL9WdoNePcrWm0ou0TAZtd1sK
         pNzrYL6dIn8dPUUtXVHAKIlr18EVhiYJWEK5f8LWx+UNttg+uWsfJonRt+rhG8N1XPbz
         N3EQMU/ZJ4cJS92AbdAYqmB0ZUNlPQPVIWsKZuqponowRKbYhQu99Zai4GulVwqK+E3R
         DMnRKDmd4qCFKb1ZKuZo1fdwPAQmHJ5p43ZE0OXNgfgvRCjXwKk5bW39w6jl/9IizaYd
         TilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301040; x=1756905840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+Z6EZIQR0o/UT5Ew23/Zd4wA8+f+oOfKWhDtiUSUCA=;
        b=JLIn+PiHVb7MR1Or9emlqyKBld4iRSDPewclBNgWtojWKmxviptBsstNu8CQj5hZJJ
         FuhLrpWLgCNgXpaCw6BznVS7HvJpvwhMnL84WigkGKrA3n0qlLH7dUi5Oibh498SLSBY
         HAYkV7GHht62qXvVQ5TvTBzjagbG/GgPIEDw3U0AeG9tCv+WWhkzSxNdrRAyWt9k82Od
         O62Svc/8UL8ozGFIfdKW/Ywfke7vQmNTR0tT83kAC9znHUw7F3kAX8RwXnpIiAXTzxxv
         J/yypp1ZrPFC88K4LAAHZDCv/t6Q7XvYuQABne9H9QXIIhVgkkkfTqX6XwALQt4bAmkY
         5FGg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ25/Fy7fvOMO72+V1KpaPnSFpfC3tPc8f2/9CoHQV9+eiYD3U7mvdSygHJ0UKY5DKv7hmMdyTSKePQxjxhmz3dWBah1z1@vger.kernel.org, AJvYcCW1dEOlKGKQqMYdspVI8HV3f+BvNPZtXeaK3XzjrfAVkkEEJGCvpChMj0GfzH+uK55LLZXrW1E+tQ==@vger.kernel.org, AJvYcCWnpTXof8VfdWjez7IS8eDQCJ/oso1JzPHBB3QEDSWVTh3o7vdhbXtjMpNq2rqh24Tg1MRE1rLVJmwn+xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztUnWNGsTLBbvLmeTNCVWJTxwsi0OC9NKiOd/vKtXBcF0XhHtC
	/RlPUJ+a5BRVhZHx/Jo0N246IoV1Dp9Ow35TzAMFWTbaLpqEXlpmJrA+cuUqiE9rTLg/TYI2xHG
	3cS9XvVuK4ru935PqGxGRUH3f+qp0gcM=
X-Gm-Gg: ASbGncstVx2Z8JD0M+IxdeNucw136KvBpLLvTuWE6EZuJbUm6wrvcvymOo4LgOtSuIp
	0MhalIsvaolJvz7PyPrfpWi+EjO4JwtljVIIxhLvozCCcy41tIesSSI/Ktm5rhfYUQyBGepHX40
	/hyOE33ptLm+O2axbxVW/Ggpv5N9fX/Y5216Ph6qFyjZIejAcU9m9leL03ggzBCwVCR7QzokSgW
	MYKTPI=
X-Google-Smtp-Source: AGHT+IFqToF9gBp+UyFTqKlU5wNf+zGDiS/bnFnnJhMueM+agaECoZFQMDP9MtD0GJBSwP2SR02RjH7cGdZdRQCzIbI=
X-Received: by 2002:a17:90b:17c4:b0:31e:6f0a:6a1a with SMTP id
 98e67ed59e1d1-32515e12e55mr24232684a91.3.1756301039423; Wed, 27 Aug 2025
 06:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826031824.1227551-1-tweek@google.com>
In-Reply-To: <20250826031824.1227551-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 27 Aug 2025 09:23:47 -0400
X-Gm-Features: Ac12FXwwVCVh8Q4CW3b7vD2Y1uA9d0c9oJmdXy-DlkO1Tt715Tn3W-AtphEbLg8
Message-ID: <CAEjxPJ6G2iK9Yp8eCwbwHQfF1J3WBEVU42kAMQHNuuC_H5QHNw@mail.gmail.com>
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:18=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
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

This looks good to me, but do you have a test for it, preferably via
patch for the selinux-testsuite?
See https://github.com/SELinuxProject/selinux-testsuite/commit/023b79b8319e=
5fe222fb5af892c579593e1cbc50
for an example.

Otherwise, you can add my:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changes since RFC:
> - Remove enum argument, simply compare the anon inode name
> - Introduce a policy capability for compatility
> - Add validation of class in selinux_bprm_creds_for_exec
>
>  include/linux/memfd.h                      |  2 ++
>  mm/memfd.c                                 | 14 +++++++++--
>  security/selinux/hooks.c                   | 27 ++++++++++++++++++----
>  security/selinux/include/classmap.h        |  2 ++
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  5 ++++
>  7 files changed, 46 insertions(+), 6 deletions(-)
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
> index c95a5874bf7d..429b2269b35a 100644
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
> @@ -2366,9 +2367,12 @@ static int selinux_bprm_creds_for_exec(struct linu=
x_binprm *bprm)
>         ad.type =3D LSM_AUDIT_DATA_FILE;
>         ad.u.file =3D bprm->file;
>
> +       if (isec->sclass !=3D SECCLASS_FILE && isec->sclass !=3D SECCLASS=
_MEMFD_FILE)
> +               return -EPERM;
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
> @@ -2378,8 +2382,8 @@ static int selinux_bprm_creds_for_exec(struct linux=
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
> @@ -2974,10 +2978,18 @@ static int selinux_inode_init_security_anon(struc=
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
> @@ -2996,6 +3008,13 @@ static int selinux_inode_init_security_anon(struct=
 inode *inode,
>
>                 isec->sclass =3D context_isec->sclass;
>                 isec->sid =3D context_isec->sid;
> +       } else if (is_memfd) {
> +               isec->sclass =3D SECCLASS_MEMFD_FILE;
> +               rc =3D security_transition_sid(
> +                       sid, sid,
> +                       isec->sclass, name, &isec->sid);
> +               if (rc)
> +                       return rc;
>         } else {
>                 isec->sclass =3D SECCLASS_ANON_INODE;
>                 rc =3D security_transition_sid(
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
> 2.51.0.261.g7ce5a0a67e-goog
>
