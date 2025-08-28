Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B55310628;
	Thu, 28 Aug 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387802; cv=none; b=oiLaDcL9MLpNOPVojlz2QvN+KjbUtnID7ikBGnNSbquMPETxbt/WtEhNNcjELGe/gJY8Z4DY3lChUlm8Tc2Q+EIGQwDUFqjSUQcS5ktmunCX8TuDDy1+Ha/IAFFThk6A5+AlosLHSFN5IqA+E2o41aSnyFgSoakARBraqvjwnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387802; c=relaxed/simple;
	bh=55L6vhzG2jgOJEl7I4X26HAgyvryCAmxeBWCwr51Hvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZkX2Jq8kb73w0CORii3x+HWUi35bhwahdeM+XTjtXiup6oXiXspDgc4SeMrMxdHf7Iejc6+j/tcEBm2YJn4qYxK7rqcQ0t8trRbBzUR4vM/zA8Ky3IB+oLGu+SBu4U/z1jD0DZwcjubDncXWwh/02EDbVN72oVDXtWD9MlXehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A55075pb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A55075pb"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-327705d0a9bso883260a91.0;
        Thu, 28 Aug 2025 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756387800; x=1756992600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n0tum4VDah4U2bv7Oe7CW2rYIFPwcyA0fu9h3EYKtA=;
        b=A55075pb5fPMVLF0lj7E7OxXE9Tl/D7D1b4uK5Le4it/ek0ZWvNoXY1Bwru9E78FYm
         4E6vUmvIXalD7oFqQNC1P7hs71edEFhXm5c6SyVN1Pckg+eG5mgot/fb2MOT38CwXapW
         upwVwEtaaaiS2oru8/JfeIteTOVzggtGmAtPzgLCeQeahtOTEcLcnGW7OAq1fpxY4A5v
         wbG6qWoSDhVgz6eLu14qzndwDZWlMb3FlLoErULZnnGa1xRV6PAfIjYxwX+nu54vWuam
         wwm+yk/xKLGaPbYY1i7pigr90z7RzjOJHScT2i0W3yeQORkXM1B0F6OlVxBURCbZuu1z
         7wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387800; x=1756992600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4n0tum4VDah4U2bv7Oe7CW2rYIFPwcyA0fu9h3EYKtA=;
        b=jKpFk2YHdYlm6llmRcKIoYsRsWO/DEWWmWinS7t3MEn/Ykv0DpwiJDj3KOLckmTB08
         aUyY0tYjJNkvzyj57Wed56kHB8R2DMbaR5L7VNE6i2K8efs+WwDM864sEnTCENz+usA2
         0D+hDaKMXgkF63BuMajmbbzDBLaPxvziMJGzK3RNVFDU6yBZYUigQ2VqjPo/8JPZOp5e
         blB9Z9i+8qQzJwBLOfU/O6TXAKaX9cmIqLEi2YgeUg0J+hvsbP7UVbidsIcGJ9Z5XgJ4
         6u72Y1M3KBjZTrur4lHAoaX6LylR2gngERNnlBiRW2IcQrVghCDzi2xgNX+SrogOKFVW
         8FsA==
X-Forwarded-Encrypted: i=1; AJvYcCVVlDt+Nv9vnXWlioLTOeOK1RRPopgQSvXo4cJd3rjFW3H9vBwn2E+m2LZm1+sHtTiDTFFAyRcyebcQpbo58xoyTlviCP3h@vger.kernel.org, AJvYcCWI2T3B37NlDpNtSfJ4cQP570pt45p8I38yPKAeV9NjrALu5L0bT588K80L4x8XOWJogrzx6bZ/mw==@vger.kernel.org, AJvYcCWxD7EhQXLqPZP0IIdW3eLOrRpvakEkZkdr0ZRORry1+mkhtv0aC1lSzy52Jo63vhzkJ3dMZqII7tMyQuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHWXVZc25li8ia+WnaGf5Aj4Y1RFP9WVMw9l5Iku9P9zDWQ7rv
	9j91pt/dVvnk1Kl3NAdHF5KYdwpwAy5nDOJwyn0j9yY4gp9vuYZ6/Cn/MgRm+IvLkE/6AcO+YZq
	TBWlCVU4gzNkJzqg3VHw6b9mY5yXX7yM=
X-Gm-Gg: ASbGnctNJDt62OjphFsmvRYb8QfCDXRiEbA23Ai6lMqcazsR45vQgrt9tIaEq2i1vNT
	GOFRSJ9jOZqrpK1Rq8f7xdsaCVxVrLlN5QCZ0Pl3N7fBWafhEU2oOGtxll2kLg9FCf+wi6PPZ7g
	hQ3ExlQMZSL2A52oZqBpbyQyRR8cIoCffQV4IC37fGdG4UpTI9wCImt43GGAh+xQnMRpGv8ckuI
	0Hnzio=
X-Google-Smtp-Source: AGHT+IF9fxo38tdSY1lXKPcvTKCu7yLbvImIstAsgUDP9cqGG5UHtxAtT+n8efcbSbsUybFZ0Kmprvh8bhLl5dF+eSA=
X-Received: by 2002:a17:90b:1fce:b0:327:ceb0:6f6a with SMTP id
 98e67ed59e1d1-327ceb07148mr783409a91.4.1756387799474; Thu, 28 Aug 2025
 06:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826031824.1227551-1-tweek@google.com> <CAEjxPJ6G2iK9Yp8eCwbwHQfF1J3WBEVU42kAMQHNuuC_H5QHNw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6G2iK9Yp8eCwbwHQfF1J3WBEVU42kAMQHNuuC_H5QHNw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 28 Aug 2025 09:29:48 -0400
X-Gm-Features: Ac12FXwihC1jaP0Hmcu35QtchrNt5_UC4cuegSSxvaLhssrES19Bc258iqePTuk
Message-ID: <CAEjxPJ70O5SY=XYJKrQDLkHOO3spD4VSjYCv0LkhYKCvK=GP7Q@mail.gmail.com>
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 9:23=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 25, 2025 at 11:18=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> >
> > Prior to this change, no security hooks were called at the creation of =
a
> > memfd file. It means that, for SELinux as an example, it will receive
> > the default type of the filesystem that backs the in-memory inode. In
> > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> > be hugetlbfs. Both can be considered implementation details of memfd.
> >
> > It also means that it is not possible to differentiate between a file
> > coming from memfd_create and a file coming from a standard tmpfs mount
> > point.
> >
> > Additionally, no permission is validated at creation, which differs fro=
m
> > the similar memfd_secret syscall.
> >
> > Call security_inode_init_security_anon during creation. This ensures
> > that the file is setup similarly to other anonymous inodes. On SELinux,
> > it means that the file will receive the security context of its task.
> >
> > The ability to limit fexecve on memfd has been of interest to avoid
> > potential pitfalls where /proc/self/exe or similar would be executed
> > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > similarly to the file class. These access vectors may not make sense fo=
r
> > the existing "anon_inode" class. Therefore, define and assign a new
> > class "memfd_file" to support such access vectors.
> >
> > Guard these changes behind a new policy capability named "memfd_class".
> >
> > [1] https://crbug.com/1305267
> > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.c=
om/
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> This looks good to me, but do you have a test for it, preferably via
> patch for the selinux-testsuite?
> See https://github.com/SELinuxProject/selinux-testsuite/commit/023b79b831=
9e5fe222fb5af892c579593e1cbc50
> for an example.
>
> Otherwise, you can add my:
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Also, we'll need a corresponding patch to define the new policy
capability in libsepol, and will need to de-conflict with the other
pending patches that are also trying to claim the next available
policy capability bit (so you may end up with a different one
upstream).

>
> > ---
> > Changes since RFC:
> > - Remove enum argument, simply compare the anon inode name
> > - Introduce a policy capability for compatility
> > - Add validation of class in selinux_bprm_creds_for_exec
> >
> >  include/linux/memfd.h                      |  2 ++
> >  mm/memfd.c                                 | 14 +++++++++--
> >  security/selinux/hooks.c                   | 27 ++++++++++++++++++----
> >  security/selinux/include/classmap.h        |  2 ++
> >  security/selinux/include/policycap.h       |  1 +
> >  security/selinux/include/policycap_names.h |  1 +
> >  security/selinux/include/security.h        |  5 ++++
> >  7 files changed, 46 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> > index 6f606d9573c3..cc74de3dbcfe 100644
> > --- a/include/linux/memfd.h
> > +++ b/include/linux/memfd.h
> > @@ -4,6 +4,8 @@
> >
> >  #include <linux/file.h>
> >
> > +#define MEMFD_ANON_NAME "[memfd]"
> > +
> >  #ifdef CONFIG_MEMFD_CREATE
> >  extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned =
int arg);
> >  struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index bbe679895ef6..63b439eb402a 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -433,6 +433,8 @@ static struct file *alloc_file(const char *name, un=
signed int flags)
> >  {
> >         unsigned int *file_seals;
> >         struct file *file;
> > +       struct inode *inode;
> > +       int err =3D 0;
> >
> >         if (flags & MFD_HUGETLB) {
> >                 file =3D hugetlb_file_setup(name, 0, VM_NORESERVE,
> > @@ -444,12 +446,20 @@ static struct file *alloc_file(const char *name, =
unsigned int flags)
> >         }
> >         if (IS_ERR(file))
> >                 return file;
> > +
> > +       inode =3D file_inode(file);
> > +       err =3D security_inode_init_security_anon(inode,
> > +                       &QSTR(MEMFD_ANON_NAME), NULL);
> > +       if (err) {
> > +               fput(file);
> > +               file =3D ERR_PTR(err);
> > +               return file;
> > +       }
> > +
> >         file->f_mode |=3D FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> >         file->f_flags |=3D O_LARGEFILE;
> >
> >         if (flags & MFD_NOEXEC_SEAL) {
> > -               struct inode *inode =3D file_inode(file);
> > -
> >                 inode->i_mode &=3D ~0111;
> >                 file_seals =3D memfd_file_seals_ptr(file);
> >                 if (file_seals) {
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index c95a5874bf7d..429b2269b35a 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -93,6 +93,7 @@
> >  #include <linux/fanotify.h>
> >  #include <linux/io_uring/cmd.h>
> >  #include <uapi/linux/lsm.h>
> > +#include <linux/memfd.h>
> >
> >  #include "avc.h"
> >  #include "objsec.h"
> > @@ -2366,9 +2367,12 @@ static int selinux_bprm_creds_for_exec(struct li=
nux_binprm *bprm)
> >         ad.type =3D LSM_AUDIT_DATA_FILE;
> >         ad.u.file =3D bprm->file;
> >
> > +       if (isec->sclass !=3D SECCLASS_FILE && isec->sclass !=3D SECCLA=
SS_MEMFD_FILE)
> > +               return -EPERM;
> > +
> >         if (new_tsec->sid =3D=3D old_tsec->sid) {
> > -               rc =3D avc_has_perm(old_tsec->sid, isec->sid,
> > -                                 SECCLASS_FILE, FILE__EXECUTE_NO_TRANS=
, &ad);
> > +               rc =3D avc_has_perm(old_tsec->sid, isec->sid, isec->scl=
ass,
> > +                                 FILE__EXECUTE_NO_TRANS, &ad);
> >                 if (rc)
> >                         return rc;
> >         } else {
> > @@ -2378,8 +2382,8 @@ static int selinux_bprm_creds_for_exec(struct lin=
ux_binprm *bprm)
> >                 if (rc)
> >                         return rc;
> >
> > -               rc =3D avc_has_perm(new_tsec->sid, isec->sid,
> > -                                 SECCLASS_FILE, FILE__ENTRYPOINT, &ad)=
;
> > +               rc =3D avc_has_perm(new_tsec->sid, isec->sid, isec->scl=
ass,
> > +                                 FILE__ENTRYPOINT, &ad);
> >                 if (rc)
> >                         return rc;
> >
> > @@ -2974,10 +2978,18 @@ static int selinux_inode_init_security_anon(str=
uct inode *inode,
> >         struct common_audit_data ad;
> >         struct inode_security_struct *isec;
> >         int rc;
> > +       bool is_memfd =3D false;
> >
> >         if (unlikely(!selinux_initialized()))
> >                 return 0;
> >
> > +       if (name !=3D NULL && name->name !=3D NULL &&
> > +           !strcmp(name->name, MEMFD_ANON_NAME)) {
> > +               if (!selinux_policycap_memfd_class())
> > +                       return 0;
> > +               is_memfd =3D true;
> > +       }
> > +
> >         isec =3D selinux_inode(inode);
> >
> >         /*
> > @@ -2996,6 +3008,13 @@ static int selinux_inode_init_security_anon(stru=
ct inode *inode,
> >
> >                 isec->sclass =3D context_isec->sclass;
> >                 isec->sid =3D context_isec->sid;
> > +       } else if (is_memfd) {
> > +               isec->sclass =3D SECCLASS_MEMFD_FILE;
> > +               rc =3D security_transition_sid(
> > +                       sid, sid,
> > +                       isec->sclass, name, &isec->sid);
> > +               if (rc)
> > +                       return rc;
> >         } else {
> >                 isec->sclass =3D SECCLASS_ANON_INODE;
> >                 rc =3D security_transition_sid(
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index 5665aa5e7853..3ec85142771f 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -179,6 +179,8 @@ const struct security_class_mapping secclass_map[] =
=3D {
> >         { "anon_inode", { COMMON_FILE_PERMS, NULL } },
> >         { "io_uring", { "override_creds", "sqpoll", "cmd", "allowed", N=
ULL } },
> >         { "user_namespace", { "create", NULL } },
> > +       { "memfd_file",
> > +         { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL }=
 },
> >         /* last one */ { NULL, {} }
> >  };
> >
> > diff --git a/security/selinux/include/policycap.h b/security/selinux/in=
clude/policycap.h
> > index 7405154e6c42..dabcc9f14dde 100644
> > --- a/security/selinux/include/policycap.h
> > +++ b/security/selinux/include/policycap.h
> > @@ -17,6 +17,7 @@ enum {
> >         POLICYDB_CAP_NETLINK_XPERM,
> >         POLICYDB_CAP_NETIF_WILDCARD,
> >         POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> > +       POLICYDB_CAP_MEMFD_CLASS,
> >         __POLICYDB_CAP_MAX
> >  };
> >  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> > diff --git a/security/selinux/include/policycap_names.h b/security/seli=
nux/include/policycap_names.h
> > index d8962fcf2ff9..8e96f2a816b6 100644
> > --- a/security/selinux/include/policycap_names.h
> > +++ b/security/selinux/include/policycap_names.h
> > @@ -20,6 +20,7 @@ const char *const selinux_policycap_names[__POLICYDB_=
CAP_MAX] =3D {
> >         "netlink_xperm",
> >         "netif_wildcard",
> >         "genfs_seclabel_wildcard",
> > +       "memfd_class",
> >  };
> >  /* clang-format on */
> >
> > diff --git a/security/selinux/include/security.h b/security/selinux/inc=
lude/security.h
> > index 8201e6a3ac0f..72c963f54148 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -209,6 +209,11 @@ static inline bool selinux_policycap_netif_wildcar=
d(void)
> >                 selinux_state.policycap[POLICYDB_CAP_NETIF_WILDCARD]);
> >  }
> >
> > +static inline bool selinux_policycap_memfd_class(void)
> > +{
> > +       return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_MEMFD_CLA=
SS]);
> > +}
> > +
> >  struct selinux_policy_convert_data;
> >
> >  struct selinux_load_state {
> > --
> > 2.51.0.261.g7ce5a0a67e-goog
> >
