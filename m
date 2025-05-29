Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157631362
	for <selinux@vger.kernel.org>; Thu, 29 May 2025 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533540; cv=none; b=CPo6Qzcw+wD7ja5cOTeBM8oebEl9mj1jY9+3q1NBMXpdv8G2GlOcsUlQP+F6WFwoaUcUMStlWSMHlU3bBR19G2jpwHu4O5B42HJ5E0pVISaLHsULPuYj3kEh2a3mzSslIMQeowbAEeLAi4zm9uYrzXKGpGvZI+grjLkA1NhkN/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533540; c=relaxed/simple;
	bh=SqMka91gRBzz+nkdjGQlL5bmC74ROtdKXvFwksxFKbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqNVizGFIZce8RtZ4vpLMrj6G8EXdZAcaJ/HVXVX6JNdp+UrUXoZ17hujFSkPY0ZE5itpuk2g+Y03yZ+zvn7mUjH6oloIx+OP800Oa+zNlvuqK5sfcKfqh+WgCfj//nN7TN47evgszyC7XIwDEIFvw2U+oyXrbt7xMY/3qncbAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8Cumfg4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8Cumfg4"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-601a67c6e61so11995a12.0
        for <selinux@vger.kernel.org>; Thu, 29 May 2025 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748533536; x=1749138336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sTenLW+U+q4DyhR5kBvFzQYcACQEA/Wx4an4RKgwek=;
        b=b8Cumfg4+36ShBvpwB2BEezoBLPEhnjYR5rplDVPOhWov9A8TlLHF4on4d6XXW+22X
         RAKDQ+6GTiY9OOQydh2MxIfwO7ywu5GREdsDJhGMb9RRhudvHCWwjE4RxRk5lbiaiEWl
         iQ/rV7UuTXnbNu3fAM5DRx3E212/D/Co3QUHCNy8rx7NGmapdkS8c6WyKKFMHiLN935X
         jVHUZKTnjIPaBILliJgWPI8NO5PVL8LJ4fXtcx7NGU7IrwcU/wlz+GA/8PH8iNU/fSA1
         FBOeLikr67IpfINLFtQ+qUvwI25VqM+FVT5+kJ4lEY7aEW8Vi4bBujwaRhnYPfm0ajE5
         ACNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748533536; x=1749138336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sTenLW+U+q4DyhR5kBvFzQYcACQEA/Wx4an4RKgwek=;
        b=S+AzXfLRziJJweKhkw7/Ksi4YZpjSRDbREFHVj9IcduDKWYxiF3epFWi0SikuCwJuB
         fWkjQemrT8PZyX9YkhsW1Gz95ltfJ3PD706AVRcomMGiXOyx0VRPL2ITQ67HPC2PUFhk
         r/NWtx1dPoT019Syu9gVA1rTxeMVT6U8/YPdFcYbm67AG7cQW+eTin2zCrQ3IiutiEtW
         Qb9vkmRauysgKQzntd/7S30gWpXQ3yW/ZzfiGKKwDuaxLOKf1IvNYoTX2fTPP10MXhXh
         dhnTAznOQAgt4er9oix/SoUgVi65rgdPzad/XQdaSEi6HyC976+Oa1QGv9VRzS6uHfqa
         501A==
X-Gm-Message-State: AOJu0YyteAHnKVcB3UWVJrxS1KaXLkoGFh9rZhgZLbpwMSLbRweNuHly
	x7N95cwQP62MOu3IpNyQgepRMwY4qfL1OhLZp4MwNEmLDtQCISVzkbt/FHx8Vrl1j9sWCPZRUXI
	Y0iBc6STFTxY8qCcKrOX5LZxDy30EJ19xvXID/+O9
X-Gm-Gg: ASbGncsGhWT3tOfVn5dEj2/cYgOjqPjBNrAS3eBGByXZwzhgk3RR42QJsB+Mx7porje
	4SNPgNwolU6vTDlFT4QkjCJOZc9GQqP0S0J7h6BALfJZ3RbNaEhW+WoikBuRiHKGf4g0QBFHSRA
	Fxkwj5qiPf51dSLUmlUOKiFThlNBSQghz5lZxPi9yl9bc=
X-Google-Smtp-Source: AGHT+IEcC6Vsa1jKSDHC6I/fIro1CvVdkUbIgJDOEmmW1hl3FY0ZhNVXjy17ukD2Clt7bnF/StlxlaM0oyKA+xkoz3c=
X-Received: by 2002:aa7:d619:0:b0:601:7b94:b80e with SMTP id
 4fb4d7f45d1cf-60540c85706mr91071a12.3.1748533536021; Thu, 29 May 2025
 08:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529092633.1057963-1-inseob@google.com> <20250529092633.1057963-2-inseob@google.com>
 <CAP+JOzRb1=9N6rAxA6tRsW=_QEiWXgpR1EefkgqNLypWQfMv0g@mail.gmail.com>
In-Reply-To: <CAP+JOzRb1=9N6rAxA6tRsW=_QEiWXgpR1EefkgqNLypWQfMv0g@mail.gmail.com>
From: Inseob Kim <inseob@google.com>
Date: Fri, 30 May 2025 00:45:24 +0900
X-Gm-Features: AX0GCFuyEeoCLqHfb5QqX5YwTWVcWUWSUs8rQvtdiZdZ2AjfkoVDV-9GGlC1lk8
Message-ID: <CA+QFDKmq7cqpVxua8cUPwLLyOyC6nzyLdc2-7X5UX7dZif=HqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Support genfs_seclabel_wildcard
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, takayas@google.com, tweek@google.com, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:16=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Thu, May 29, 2025 at 5:26=E2=80=AFAM Inseob Kim <inseob@google.com> wr=
ote:
> >
> > This adds genfs_seclabel_wildcard support to libsepol, which makes genf=
s
> > paths wildcard-matched. To support backward compatibility and to keep
> > semantics of genfscon statements, an asterisk '*' is added to paths of
> > genfscon statements when compiling CIL/conf files having policycap
> > genfs_seclabel_wildcard.
> >
> > Signed-off-by: Inseob Kim <inseob@google.com>
> > ---
> >  checkpolicy/policy_define.c               | 14 ++++++++++++++
> >  libsepol/cil/src/cil_binary.c             | 15 ++++++++++++++-
> >  libsepol/include/sepol/policydb/polcaps.h |  1 +
> >  libsepol/src/kernel_to_cil.c              | 20 ++++++++++++++++----
> >  libsepol/src/kernel_to_conf.c             | 20 ++++++++++++++++----
> >  libsepol/src/polcaps.c                    |  1 +
> >  6 files changed, 62 insertions(+), 9 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 78adbec0..868b8214 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -5967,6 +5967,7 @@ static int define_genfs_context_helper(char *fsty=
pe, int has_type)
> >         char *type =3D NULL;
> >         const char *sclass;
> >         size_t len, len2;
> > +       int wildcard =3D ebitmap_get_bit(&policydbp->policycaps, POLICY=
DB_CAP_GENFS_SECLABEL_WILDCARD);
> >
> >         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
> >                 yyerror("genfs not supported for target");
> > @@ -6017,6 +6018,19 @@ static int define_genfs_context_helper(char *fst=
ype, int has_type)
> >         newc->u.name =3D (char *)queue_remove(id_queue);
> >         if (!newc->u.name)
> >                 goto fail;
> > +
> > +       if (wildcard) {
> > +               size_t name_len =3D strlen(newc->u.name);
> > +               newc->u.name =3D realloc(newc->u.name, name_len + 2);
> > +               if (newc->u.name =3D=3D NULL) {
> > +                       yyerror("out of memory");
> > +                       return -1;
> > +               }
> > +
> > +               newc->u.name[name_len] =3D '*';
> > +               newc->u.name[name_len + 1] =3D '\0';
> > +       }
> > +
> >         if (has_type) {
> >                 type =3D (char *)queue_remove(id_queue);
> >                 if (!type)
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index b0befda3..b2c940f9 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -3749,6 +3749,7 @@ int cil_genfscon_to_policydb(policydb_t *pdb, str=
uct cil_sort *genfscons)
> >         uint32_t i =3D 0;
> >         genfs_t *genfs_tail =3D NULL;
> >         ocontext_t *ocon_tail =3D NULL;
> > +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP=
_GENFS_SECLABEL_WILDCARD);
> >
> >         for (i =3D 0; i < genfscons->count; i++) {
> >                 struct cil_genfscon *cil_genfscon =3D genfscons->array[=
i];
> > @@ -3773,7 +3774,19 @@ int cil_genfscon_to_policydb(policydb_t *pdb, st=
ruct cil_sort *genfscons)
> >
> >                 ocon_tail =3D new_ocon;
> >
> > -               new_ocon->u.name =3D cil_strdup(cil_genfscon->path_str)=
;
> > +               if (wildcard) {
> > +                       size_t name_len =3D strlen(cil_genfscon->path_s=
tr);
> > +                       new_ocon->u.name =3D malloc(name_len + 2);
> > +                       if (new_ocon->u.name =3D=3D NULL) {
> > +                               cil_log(CIL_ERR, "Failed to allocate me=
mory\n");
> > +                               exit(1);
> > +                       }
> > +                       memcpy(new_ocon->u.name, cil_genfscon->path_str=
, name_len);
> > +                       new_ocon->u.name[name_len] =3D '*';
> > +                       new_ocon->u.name[name_len + 1] =3D '\0';
> > +               } else {
> > +                       new_ocon->u.name =3D cil_strdup(cil_genfscon->p=
ath_str);
> > +               }
> >
> >                 if (cil_genfscon->file_type !=3D CIL_FILECON_ANY) {
> >                         class_datum_t *class_datum;
> > diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/inclu=
de/sepol/policydb/polcaps.h
> > index 1aa9b30a..9f3495f5 100644
> > --- a/libsepol/include/sepol/policydb/polcaps.h
> > +++ b/libsepol/include/sepol/policydb/polcaps.h
> > @@ -16,6 +16,7 @@ enum {
> >         POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
> >         POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> >         POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> > +       POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> >         POLICYDB_CAP_NETLINK_XPERM,
> >         __POLICYDB_CAP_MAX
> >  };
>
> The order has to be the same as in the kernel. The number, rather than
> the name, is stored in the binary policy file.
> Thanks,
> Jim

ok, I checked https://github.com/torvalds/linux/blob/master/security/selinu=
x/include/policycap.h
and currently it is

enum {
POLICYDB_CAP_NETPEER,
POLICYDB_CAP_OPENPERM,
POLICYDB_CAP_EXTSOCKCLASS,
POLICYDB_CAP_ALWAYSNETWORK,
POLICYDB_CAP_CGROUPSECLABEL,
POLICYDB_CAP_NNP_NOSUID_TRANSITION,
POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
POLICYDB_CAP_NETLINK_XPERM,
POLICYDB_CAP_NETIF_WILDCARD,
POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
__POLICYDB_CAP_MAX
};

It seems like POLICYDB_CAP_NETIF_WILDCARD is missing in libsepol. So I
need another commit adding POLICYDB_CAP_NETIF_WILDCARD to libsepol,
right?

>
> > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.=
c
> > index ddca2b62..33ee59fb 100644
> > --- a/libsepol/src/kernel_to_cil.c
> > +++ b/libsepol/src/kernel_to_cil.c
> > @@ -2708,6 +2708,8 @@ static int write_genfscon_rules_to_cil(FILE *out,=
 struct policydb *pdb)
> >         uint32_t sclass;
> >         const char *file_type;
> >         int rc;
> > +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP=
_GENFS_SECLABEL_WILDCARD);
> > +       size_t name_len;
> >
> >         rc =3D strs_init(&strs, 32);
> >         if (rc !=3D 0) {
> > @@ -2749,12 +2751,22 @@ static int write_genfscon_rules_to_cil(FILE *ou=
t, struct policydb *pdb)
> >                                 goto exit;
> >                         }
> >
> > +                       name_len =3D strlen(name);
> > +                       if (wildcard) {
> > +                               if (name_len =3D=3D 0 || name[name_len =
- 1] !=3D '*') {
> > +                                       ERR(NULL, "genfscon path must e=
nd with '*' when genfs_seclabel_wildcard");
> > +                                       rc =3D -1;
> > +                                       goto exit;
> > +                               }
> > +                               --name_len;
> > +                       }
> > +
> >                         if (file_type) {
> > -                               rc =3D strs_create_and_add(strs, "(genf=
scon %s \"%s\" %s %s)",
> > -                                                                      =
          fstype, name, file_type, ctx);
> > +                               rc =3D strs_create_and_add(strs, "(genf=
scon %s \"%.*s\" %s %s)",
> > +                                                        fstype, name_l=
en, name, file_type, ctx);
> >                         } else {
> > -                               rc =3D strs_create_and_add(strs, "(genf=
scon %s \"%s\" %s)",
> > -                                                                      =
          fstype, name, ctx);
> > +                               rc =3D strs_create_and_add(strs, "(genf=
scon %s \"%.*s\" %s)",
> > +                                                        fstype, name_l=
en, name, ctx);
> >                         }
> >                         free(ctx);
> >                         if (rc !=3D 0) {
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_con=
f.c
> > index 661546af..dac6fce9 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -2556,6 +2556,8 @@ static int write_genfscon_rules_to_conf(FILE *out=
, struct policydb *pdb)
> >         uint32_t sclass;
> >         const char *file_type;
> >         int rc;
> > +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP=
_GENFS_SECLABEL_WILDCARD);
> > +       size_t name_len;
> >
> >         rc =3D strs_init(&strs, 32);
> >         if (rc !=3D 0) {
> > @@ -2597,12 +2599,22 @@ static int write_genfscon_rules_to_conf(FILE *o=
ut, struct policydb *pdb)
> >                                 goto exit;
> >                         }
> >
> > +                       name_len =3D strlen(name);
> > +                       if (wildcard) {
> > +                               if (name_len =3D=3D 0 || name[name_len =
- 1] !=3D '*') {
> > +                                       ERR(NULL, "genfscon path must e=
nd with '*' when genfs_seclabel_wildcard");
> > +                                       rc =3D -1;
> > +                                       goto exit;
> > +                               }
> > +                               --name_len;
> > +                       }
> > +
> >                         if (file_type) {
> > -                               rc =3D strs_create_and_add(strs, "genfs=
con %s \"%s\" %s %s",
> > -                                                                      =
          fstype, name, file_type, ctx);
> > +                               rc =3D strs_create_and_add(strs, "genfs=
con %s \"%.*s\" %s %s",
> > +                                                        fstype, name_l=
en, name, file_type, ctx);
> >                         } else {
> > -                               rc =3D strs_create_and_add(strs, "genfs=
con %s \"%s\" %s",
> > -                                                                      =
          fstype, name, ctx);
> > +                               rc =3D strs_create_and_add(strs, "genfs=
con %s \"%.*s\" %s",
> > +                                                        fstype, name_l=
en, name, ctx);
> >                         }
> >                         free(ctx);
> >                         if (rc !=3D 0) {
> > diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> > index 6b28c84e..a6fad2a9 100644
> > --- a/libsepol/src/polcaps.c
> > +++ b/libsepol/src/polcaps.c
> > @@ -15,6 +15,7 @@ static const char * const polcap_names[POLICYDB_CAP_M=
AX + 1] =3D {
> >         [POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]          =3D "genfs_secl=
abel_symlinks",
> >         [POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]               =3D "ioctl_skip=
_cloexec",
> >         [POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]        =3D "userspace_=
initial_context",
> > +       [POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]          =3D "genfs_secl=
abel_wildcard",
> >         [POLICYDB_CAP_NETLINK_XPERM]                    =3D "netlink_xp=
erm",
> >  };
> >
> > --
> > 2.49.0.1238.gf8c92423fb-goog
> >
> >



--=20
Inseob Kim | Software Engineer | inseob@google.com
