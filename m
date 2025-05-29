Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F541E2858
	for <selinux@vger.kernel.org>; Thu, 29 May 2025 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538451; cv=none; b=igyMusamGPdbqwnpkBeG/szm+nvQynbFWzQ9umuZTwmJk/WdArpRrSn1GCE6+U3nsEqKf4Ml4PnKmubyRjLNtDwzXCIxDSo6fJRlH8QfSS7tqbncUR/BfXC75j4lBZrAGMZNqx5uiSddQbNRSg4r7k644TLiICZzDaTZT8CuNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538451; c=relaxed/simple;
	bh=LXrQFcxGF9TG/tTveHGt7VPbdcGbKlufh+yS/sQiEUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxDcxt3LatNLevRcU99l6GlntpI7PDPtYzzjlnlhaOTnhCa4qjXmgDMvhY2INJmYGcqlGK6ozJs1AS0Ql9OG4r2vlUWzPu07v+QnlQptWAF3l+dx+XmLIH1aT76ULtS7qaF25qlqKM7kj2yKw8wiRMFUss2WfR+cHxE5AGFqXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5hHHGEb; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5hHHGEb"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4772f48f516so22556371cf.1
        for <selinux@vger.kernel.org>; Thu, 29 May 2025 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748538448; x=1749143248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kt1ZncIZ4XU7v04thIeg3TUwfehylRDjhqdz4ZTMtUA=;
        b=N5hHHGEbKDunk7NdKZABRrEJx6PwLRManFPewypE9td5/PAFLVmXLZ2WfY4sRMGnK5
         ZbX24HKEumz4mlOlSwzjeHMklz1ip26XQyWQTS1rjlRV3iYu1grNAlYtru74PcPjNvuk
         X88mEcdJLYrBUftQX9oKErHqbUij3/kHE5vHVRj2bfiJPccyh2FGd+qEVaAp+Mq5I4eE
         UQaYPwgE0DYJb59qnqQ3NPDzj/xCOULWSLvy3cXncJTLsGa0c5XGfNT1OuHZVU+AQ43v
         JGqQrkhvUIhrLgj1KqIEN748t6+9cZq0I9NLnoZf1uXnRp10hpF9r5aT8Rld5eRRNWxv
         C6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748538448; x=1749143248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kt1ZncIZ4XU7v04thIeg3TUwfehylRDjhqdz4ZTMtUA=;
        b=GiQfa2qewc/B5/h1UZ9KVViUYzkadQ5pRmN3Z8vdWiGZ8KfIM/n1ZPe3vx5UMdCS24
         amGPTmYA+rIRV4sRNJBs4/jH0PNlN1TEBgAwy5RP/WQq/Bax/rzKpcKbzt4JNoAHAREn
         xXqSorXtAsuLCWk0PMx2XqqrAoyDend6haYrPyY9MNWr/G5FEG2+BtgWeIyHeqtC6PGq
         GUriS4AQCbMYJ3yHgQIIDtrM3cktYqogyGXyEpdW17cvoXoznsMfcfQWV6Cwz3RhJz1i
         GfhRcHoyh9qyZR+iaHGWt5BFS3jkvRtovWbZRWhhFu46enHRreO9yEXkLVJfatOaagTH
         rpHw==
X-Gm-Message-State: AOJu0YydhzqoHAxIz0xIhdRK7HL8O/Kl2nXoVKBZ5yxqjWH4G+o3/yjB
	XJKvtx66fUqYnhQKOoGKnhceDzlyKIH+Wj53+d4vFksYl3EwA+3IANUyNlVUvMeNt6I50b6Zum2
	uYZJFMRlt7qLD0Kh8YcywGXY1UA0C3zrSOg==
X-Gm-Gg: ASbGncvRF0MEaUohkmHrPywWUAVwOk5knevFhHMDfON59K9QQKIhrrw87j+Mq6q/y1Y
	+TtNHJ5PGj9JQQ4R2xCBRGmEMhZx3JZnqbjFxN9Xptuw5lfo9/tZTJ9Qor8OgpenCEm6YGwSZW5
	fJswVaAeM8h3q37Qs4qu4PiVK0wo6tu2jy
X-Google-Smtp-Source: AGHT+IG/AylVX2CpaIIG1j22H2kRKijNsDurVMehAPD2A3LKDPmcyUquxfGn2l8j6j3f0nQ5xs7Gya5gljEJ5qN6lBA=
X-Received: by 2002:ac8:6390:0:b0:4a4:3ba1:3ad2 with SMTP id
 d75a77b69052e-4a43ba13bddmr26845871cf.15.1748538447618; Thu, 29 May 2025
 10:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529092633.1057963-1-inseob@google.com> <20250529092633.1057963-2-inseob@google.com>
 <CAP+JOzRb1=9N6rAxA6tRsW=_QEiWXgpR1EefkgqNLypWQfMv0g@mail.gmail.com> <CA+QFDKmq7cqpVxua8cUPwLLyOyC6nzyLdc2-7X5UX7dZif=HqA@mail.gmail.com>
In-Reply-To: <CA+QFDKmq7cqpVxua8cUPwLLyOyC6nzyLdc2-7X5UX7dZif=HqA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 29 May 2025 13:07:16 -0400
X-Gm-Features: AX0GCFvVBUfod7HVclQI-1pE9ZzDcelbWFBvYfjMyHSbmCvqcRGryF-YVJo5WB4
Message-ID: <CAP+JOzSegDcA2opJ_sF6wYgdeu7Wmzgq_qwR+y5DmKMpBD4RiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Support genfs_seclabel_wildcard
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, takayas@google.com, tweek@google.com, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 11:45=E2=80=AFAM Inseob Kim <inseob@google.com> wro=
te:
>
> On Fri, May 30, 2025 at 12:16=E2=80=AFAM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > On Thu, May 29, 2025 at 5:26=E2=80=AFAM Inseob Kim <inseob@google.com> =
wrote:
> > >
> > > This adds genfs_seclabel_wildcard support to libsepol, which makes ge=
nfs
> > > paths wildcard-matched. To support backward compatibility and to keep
> > > semantics of genfscon statements, an asterisk '*' is added to paths o=
f
> > > genfscon statements when compiling CIL/conf files having policycap
> > > genfs_seclabel_wildcard.
> > >
> > > Signed-off-by: Inseob Kim <inseob@google.com>
> > > ---
> > >  checkpolicy/policy_define.c               | 14 ++++++++++++++
> > >  libsepol/cil/src/cil_binary.c             | 15 ++++++++++++++-
> > >  libsepol/include/sepol/policydb/polcaps.h |  1 +
> > >  libsepol/src/kernel_to_cil.c              | 20 ++++++++++++++++----
> > >  libsepol/src/kernel_to_conf.c             | 20 ++++++++++++++++----
> > >  libsepol/src/polcaps.c                    |  1 +
> > >  6 files changed, 62 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.=
c
> > > index 78adbec0..868b8214 100644
> > > --- a/checkpolicy/policy_define.c
> > > +++ b/checkpolicy/policy_define.c
> > > @@ -5967,6 +5967,7 @@ static int define_genfs_context_helper(char *fs=
type, int has_type)
> > >         char *type =3D NULL;
> > >         const char *sclass;
> > >         size_t len, len2;
> > > +       int wildcard =3D ebitmap_get_bit(&policydbp->policycaps, POLI=
CYDB_CAP_GENFS_SECLABEL_WILDCARD);
> > >
> > >         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
> > >                 yyerror("genfs not supported for target");
> > > @@ -6017,6 +6018,19 @@ static int define_genfs_context_helper(char *f=
stype, int has_type)
> > >         newc->u.name =3D (char *)queue_remove(id_queue);
> > >         if (!newc->u.name)
> > >                 goto fail;
> > > +
> > > +       if (wildcard) {
> > > +               size_t name_len =3D strlen(newc->u.name);
> > > +               newc->u.name =3D realloc(newc->u.name, name_len + 2);
> > > +               if (newc->u.name =3D=3D NULL) {
> > > +                       yyerror("out of memory");
> > > +                       return -1;
> > > +               }
> > > +
> > > +               newc->u.name[name_len] =3D '*';
> > > +               newc->u.name[name_len + 1] =3D '\0';
> > > +       }
> > > +
> > >         if (has_type) {
> > >                 type =3D (char *)queue_remove(id_queue);
> > >                 if (!type)
> > > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_bin=
ary.c
> > > index b0befda3..b2c940f9 100644
> > > --- a/libsepol/cil/src/cil_binary.c
> > > +++ b/libsepol/cil/src/cil_binary.c
> > > @@ -3749,6 +3749,7 @@ int cil_genfscon_to_policydb(policydb_t *pdb, s=
truct cil_sort *genfscons)
> > >         uint32_t i =3D 0;
> > >         genfs_t *genfs_tail =3D NULL;
> > >         ocontext_t *ocon_tail =3D NULL;
> > > +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB_C=
AP_GENFS_SECLABEL_WILDCARD);
> > >
> > >         for (i =3D 0; i < genfscons->count; i++) {
> > >                 struct cil_genfscon *cil_genfscon =3D genfscons->arra=
y[i];
> > > @@ -3773,7 +3774,19 @@ int cil_genfscon_to_policydb(policydb_t *pdb, =
struct cil_sort *genfscons)
> > >
> > >                 ocon_tail =3D new_ocon;
> > >
> > > -               new_ocon->u.name =3D cil_strdup(cil_genfscon->path_st=
r);
> > > +               if (wildcard) {
> > > +                       size_t name_len =3D strlen(cil_genfscon->path=
_str);
> > > +                       new_ocon->u.name =3D malloc(name_len + 2);
> > > +                       if (new_ocon->u.name =3D=3D NULL) {
> > > +                               cil_log(CIL_ERR, "Failed to allocate =
memory\n");
> > > +                               exit(1);
> > > +                       }
> > > +                       memcpy(new_ocon->u.name, cil_genfscon->path_s=
tr, name_len);
> > > +                       new_ocon->u.name[name_len] =3D '*';
> > > +                       new_ocon->u.name[name_len + 1] =3D '\0';
> > > +               } else {
> > > +                       new_ocon->u.name =3D cil_strdup(cil_genfscon-=
>path_str);
> > > +               }
> > >
> > >                 if (cil_genfscon->file_type !=3D CIL_FILECON_ANY) {
> > >                         class_datum_t *class_datum;
> > > diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/inc=
lude/sepol/policydb/polcaps.h
> > > index 1aa9b30a..9f3495f5 100644
> > > --- a/libsepol/include/sepol/policydb/polcaps.h
> > > +++ b/libsepol/include/sepol/policydb/polcaps.h
> > > @@ -16,6 +16,7 @@ enum {
> > >         POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
> > >         POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> > >         POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> > > +       POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> > >         POLICYDB_CAP_NETLINK_XPERM,
> > >         __POLICYDB_CAP_MAX
> > >  };
> >
> > The order has to be the same as in the kernel. The number, rather than
> > the name, is stored in the binary policy file.
> > Thanks,
> > Jim
>
> ok, I checked https://github.com/torvalds/linux/blob/master/security/seli=
nux/include/policycap.h
> and currently it is
>
> enum {
> POLICYDB_CAP_NETPEER,
> POLICYDB_CAP_OPENPERM,
> POLICYDB_CAP_EXTSOCKCLASS,
> POLICYDB_CAP_ALWAYSNETWORK,
> POLICYDB_CAP_CGROUPSECLABEL,
> POLICYDB_CAP_NNP_NOSUID_TRANSITION,
> POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
> POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> POLICYDB_CAP_NETLINK_XPERM,
> POLICYDB_CAP_NETIF_WILDCARD,
> POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> __POLICYDB_CAP_MAX
> };
>
> It seems like POLICYDB_CAP_NETIF_WILDCARD is missing in libsepol. So I
> need another commit adding POLICYDB_CAP_NETIF_WILDCARD to libsepol,
> right?
>

Yes, I was reacting to the fact that you were not adding it to the end
of the list, but you are right that one needs to be added as well. The
order in libsepol has to match the kernel.
Thanks,
Jim

> >
> > > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_ci=
l.c
> > > index ddca2b62..33ee59fb 100644
> > > --- a/libsepol/src/kernel_to_cil.c
> > > +++ b/libsepol/src/kernel_to_cil.c
> > > @@ -2708,6 +2708,8 @@ static int write_genfscon_rules_to_cil(FILE *ou=
t, struct policydb *pdb)
> > >         uint32_t sclass;
> > >         const char *file_type;
> > >         int rc;
> > > +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB_C=
AP_GENFS_SECLABEL_WILDCARD);
> > > +       size_t name_len;
> > >
> > >         rc =3D strs_init(&strs, 32);
> > >         if (rc !=3D 0) {
> > > @@ -2749,12 +2751,22 @@ static int write_genfscon_rules_to_cil(FILE *=
out, struct policydb *pdb)
> > >                                 goto exit;
> > >                         }
> > >
> > > +                       name_len =3D strlen(name);
> > > +                       if (wildcard) {
> > > +                               if (name_len =3D=3D 0 || name[name_le=
n - 1] !=3D '*') {
> > > +                                       ERR(NULL, "genfscon path must=
 end with '*' when genfs_seclabel_wildcard");
> > > +                                       rc =3D -1;
> > > +                                       goto exit;
> > > +                               }
> > > +                               --name_len;
> > > +                       }
> > > +
> > >                         if (file_type) {
> > > -                               rc =3D strs_create_and_add(strs, "(ge=
nfscon %s \"%s\" %s %s)",
> > > -                                                                    =
            fstype, name, file_type, ctx);
> > > +                               rc =3D strs_create_and_add(strs, "(ge=
nfscon %s \"%.*s\" %s %s)",
> > > +                                                        fstype, name=
_len, name, file_type, ctx);
> > >                         } else {
> > > -                               rc =3D strs_create_and_add(strs, "(ge=
nfscon %s \"%s\" %s)",
> > > -                                                                    =
            fstype, name, ctx);
> > > +                               rc =3D strs_create_and_add(strs, "(ge=
nfscon %s \"%.*s\" %s)",
> > > +                                                        fstype, name=
_len, name, ctx);
> > >                         }
> > >                         free(ctx);
> > >                         if (rc !=3D 0) {
> > > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_c=
onf.c
> > > index 661546af..dac6fce9 100644
> > > --- a/libsepol/src/kernel_to_conf.c
> > > +++ b/libsepol/src/kernel_to_conf.c
> > > @@ -2556,6 +2556,8 @@ static int write_genfscon_rules_to_conf(FILE *o=
ut, struct policydb *pdb)
> > >         uint32_t sclass;
> > >         const char *file_type;
> > >         int rc;
> > > +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB_C=
AP_GENFS_SECLABEL_WILDCARD);
> > > +       size_t name_len;
> > >
> > >         rc =3D strs_init(&strs, 32);
> > >         if (rc !=3D 0) {
> > > @@ -2597,12 +2599,22 @@ static int write_genfscon_rules_to_conf(FILE =
*out, struct policydb *pdb)
> > >                                 goto exit;
> > >                         }
> > >
> > > +                       name_len =3D strlen(name);
> > > +                       if (wildcard) {
> > > +                               if (name_len =3D=3D 0 || name[name_le=
n - 1] !=3D '*') {
> > > +                                       ERR(NULL, "genfscon path must=
 end with '*' when genfs_seclabel_wildcard");
> > > +                                       rc =3D -1;
> > > +                                       goto exit;
> > > +                               }
> > > +                               --name_len;
> > > +                       }
> > > +
> > >                         if (file_type) {
> > > -                               rc =3D strs_create_and_add(strs, "gen=
fscon %s \"%s\" %s %s",
> > > -                                                                    =
            fstype, name, file_type, ctx);
> > > +                               rc =3D strs_create_and_add(strs, "gen=
fscon %s \"%.*s\" %s %s",
> > > +                                                        fstype, name=
_len, name, file_type, ctx);
> > >                         } else {
> > > -                               rc =3D strs_create_and_add(strs, "gen=
fscon %s \"%s\" %s",
> > > -                                                                    =
            fstype, name, ctx);
> > > +                               rc =3D strs_create_and_add(strs, "gen=
fscon %s \"%.*s\" %s",
> > > +                                                        fstype, name=
_len, name, ctx);
> > >                         }
> > >                         free(ctx);
> > >                         if (rc !=3D 0) {
> > > diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> > > index 6b28c84e..a6fad2a9 100644
> > > --- a/libsepol/src/polcaps.c
> > > +++ b/libsepol/src/polcaps.c
> > > @@ -15,6 +15,7 @@ static const char * const polcap_names[POLICYDB_CAP=
_MAX + 1] =3D {
> > >         [POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]          =3D "genfs_se=
clabel_symlinks",
> > >         [POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]               =3D "ioctl_sk=
ip_cloexec",
> > >         [POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]        =3D "userspac=
e_initial_context",
> > > +       [POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]          =3D "genfs_se=
clabel_wildcard",
> > >         [POLICYDB_CAP_NETLINK_XPERM]                    =3D "netlink_=
xperm",
> > >  };
> > >
> > > --
> > > 2.49.0.1238.gf8c92423fb-goog
> > >
> > >
>
>
>
> --
> Inseob Kim | Software Engineer | inseob@google.com
