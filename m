Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF532222D6
	for <selinux@vger.kernel.org>; Fri, 30 May 2025 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573622; cv=none; b=Rg7vPIBHQOVeo6Dtq9SNEiawhDZDEaFxVdLn+/3ogt1Y2lXKJjcGYFLYFWOoqx9KqEDFfuQEJo+C/+eShivo8o6e2g91nOcUaMwMdMLaycMdTHN3aEUbP4v+uHEbEzuQRvoSg12IRCnWhMP3Ud4uEyEzlwMBnKW/Sr9VBFC5R7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573622; c=relaxed/simple;
	bh=uWc1pPO47L4gDAM/hkb61EHu/8/JESppwVIbx2yzmeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmnMyNnNj5KAlAceKACa+p/cVZ15n8L9Ksj/iVCxDHULVkxv5UaOxtiSXw5NdhKvM23/NlOYhiLw+hxoQHq+4Ng61CqnszNn61nOkqa6uAwiLFvVmo7As9wPzIssUB0oe3WSUjmGkB5cKBnpyUjSbdhTkST/pFHayBnoLI8+tOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8ONlqO4; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8ONlqO4"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so1526591a12.0
        for <selinux@vger.kernel.org>; Thu, 29 May 2025 19:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748573620; x=1749178420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtFEwD6UvF5N50tuNyDvnRen588BA+IAUgXi04LbkXw=;
        b=s8ONlqO4VnU8fNNtkteGThGfFXGn8JLvtAzAoHPkS2uhrVeMr9ti21In1cucwdzU8Y
         sN5sJ5lDxzsJlOrj7MpQ3V6yQYBxA+aReaWpEAyPmeL8UdySV8gq/uG7oaCDNM/MD8Dc
         fGgqpi5Q7jvfD52eDHYv4LTkI5g0cuOLwaFMcBJySh3ZhaIyPKKoFtV8mLCw5mqOp+W6
         hm1RGen8kXJ4s3QtcpVEgTQnTNTCzNyaGSw8NMO07f41gqqdhUEarGgj/LHQHETRYJSQ
         Kx6IeF1e87VE+TGyuUX1BpK0U5fvHX+ee7zwmFVuh8+1GRrNpOYNaVG9CxYrVbFdl0jF
         Dn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748573620; x=1749178420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtFEwD6UvF5N50tuNyDvnRen588BA+IAUgXi04LbkXw=;
        b=Pv24rh0cc8oltPn4K9FUXrEm1DBqvILH1POV+T3AvdS3ppQHa9hsZkHkvjdw17srhs
         ItoRw7ejyyO0FuRzD+MtbgoPeNX4FjJEB/IitY1BO11kZSiND65djPT2+bwQnK7P9Onn
         Gw6D5PYQ68/kFZ+QXA/PEFh7nme+Cd+lORVH86vydNOYATx2S7K1irqzwjw+oo6z0S2a
         5MHJ7FIq3RD2o6CAojQQzbbut0YPqFRoWUOuXtNKE1EsDbaDs/yNuzO7k8tXk0jWcyld
         ua5y0KM7mXjRfUphyr5vbiqMrUX0oqCCrYw+y7fCF7OGxsENtx4kPbi9hbcYKMGDaBgR
         QHRA==
X-Forwarded-Encrypted: i=1; AJvYcCV/kvCvA7HFoel1HPTQSX9wdYmU2qERvI95Qja3j2q7LfKH6d9CfjVRi7Qw3Hky23T/DgVKDdpJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxWALV3w29uX9BAXbP7dcGB1Hj/mc/Y799poa6dZMzClXH5RY/B
	TUXofkHFcRd/D3fWJ4zWwrK7zf4mFjwiyPw6lZp8ijWtMUHFq0afBH1PSKoLf8f3NhnvBYTCP+p
	lNkzdNazoISieN7oqOY5BJE17ZfxYvasPCV3Uwes9
X-Gm-Gg: ASbGncvnoFsr8UR4JnCGyycJK68eAdxEF76L+dGaF9FkdLfH8ffzaVOkZX/qo739PC1
	vJEPOaYwQVK6DEyuiue08HztyA0dg/Ei/d3DGsBQ3hg5Ba3SZK9or6eIOgYX1TbOdaa6Bo2/5jx
	Y4yfcx6AIxP2z6QFtsJHTPE13mmgVa+f41Vye/pj24wNloMF6U9zp9rdHTKfa9ltoExutzQ/ZKN
	YU=
X-Google-Smtp-Source: AGHT+IFP1xUKm/yViexLWvEalYNrggpTTe8KgtOFuPz0gVaGrP6q6a6+3cBcaVo/r+iCU7g3T+rmvSSJU0Nev+WNaIQ=
X-Received: by 2002:a17:90a:da87:b0:311:9e59:7aba with SMTP id
 98e67ed59e1d1-31250344814mr722687a91.2.1748573619529; Thu, 29 May 2025
 19:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529092633.1057963-1-inseob@google.com> <20250529092633.1057963-2-inseob@google.com>
 <CAP+JOzRb1=9N6rAxA6tRsW=_QEiWXgpR1EefkgqNLypWQfMv0g@mail.gmail.com>
 <CA+QFDKmq7cqpVxua8cUPwLLyOyC6nzyLdc2-7X5UX7dZif=HqA@mail.gmail.com> <CAP+JOzSegDcA2opJ_sF6wYgdeu7Wmzgq_qwR+y5DmKMpBD4RiA@mail.gmail.com>
In-Reply-To: <CAP+JOzSegDcA2opJ_sF6wYgdeu7Wmzgq_qwR+y5DmKMpBD4RiA@mail.gmail.com>
From: Takaya Saeki <takayas@google.com>
Date: Fri, 30 May 2025 11:53:28 +0900
X-Gm-Features: AX0GCFs0Oxe3GqiKVdouDrmxV7FU5AFfNqKuLw81EOFuJffsymupdEFzKNU78eE
Message-ID: <CAKc0u47AeL2uJ=dLjV1yHmfyLyCd3T4WFpYUuC8Kf7BO3O_Mow@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Support genfs_seclabel_wildcard
To: James Carter <jwcart2@gmail.com>, cgzones@googlemail.com
Cc: Inseob Kim <inseob@google.com>, selinux@vger.kernel.org, tweek@google.com, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Christian (cgzones@googlemail.com) for your awareness

On Fri, May 30, 2025 at 2:07=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, May 29, 2025 at 11:45=E2=80=AFAM Inseob Kim <inseob@google.com> w=
rote:
> >
> > On Fri, May 30, 2025 at 12:16=E2=80=AFAM James Carter <jwcart2@gmail.co=
m> wrote:
> > >
> > > On Thu, May 29, 2025 at 5:26=E2=80=AFAM Inseob Kim <inseob@google.com=
> wrote:
> > > >
> > > > This adds genfs_seclabel_wildcard support to libsepol, which makes =
genfs
> > > > paths wildcard-matched. To support backward compatibility and to ke=
ep
> > > > semantics of genfscon statements, an asterisk '*' is added to paths=
 of
> > > > genfscon statements when compiling CIL/conf files having policycap
> > > > genfs_seclabel_wildcard.
> > > >
> > > > Signed-off-by: Inseob Kim <inseob@google.com>
> > > > ---
> > > >  checkpolicy/policy_define.c               | 14 ++++++++++++++
> > > >  libsepol/cil/src/cil_binary.c             | 15 ++++++++++++++-
> > > >  libsepol/include/sepol/policydb/polcaps.h |  1 +
> > > >  libsepol/src/kernel_to_cil.c              | 20 ++++++++++++++++---=
-
> > > >  libsepol/src/kernel_to_conf.c             | 20 ++++++++++++++++---=
-
> > > >  libsepol/src/polcaps.c                    |  1 +
> > > >  6 files changed, 62 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_defin=
e.c
> > > > index 78adbec0..868b8214 100644
> > > > --- a/checkpolicy/policy_define.c
> > > > +++ b/checkpolicy/policy_define.c
> > > > @@ -5967,6 +5967,7 @@ static int define_genfs_context_helper(char *=
fstype, int has_type)
> > > >         char *type =3D NULL;
> > > >         const char *sclass;
> > > >         size_t len, len2;
> > > > +       int wildcard =3D ebitmap_get_bit(&policydbp->policycaps, PO=
LICYDB_CAP_GENFS_SECLABEL_WILDCARD);
> > > >
> > > >         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
> > > >                 yyerror("genfs not supported for target");
> > > > @@ -6017,6 +6018,19 @@ static int define_genfs_context_helper(char =
*fstype, int has_type)
> > > >         newc->u.name =3D (char *)queue_remove(id_queue);
> > > >         if (!newc->u.name)
> > > >                 goto fail;
> > > > +
> > > > +       if (wildcard) {
> > > > +               size_t name_len =3D strlen(newc->u.name);
> > > > +               newc->u.name =3D realloc(newc->u.name, name_len + 2=
);
> > > > +               if (newc->u.name =3D=3D NULL) {
> > > > +                       yyerror("out of memory");
> > > > +                       return -1;
> > > > +               }
> > > > +
> > > > +               newc->u.name[name_len] =3D '*';
> > > > +               newc->u.name[name_len + 1] =3D '\0';
> > > > +       }
> > > > +
> > > >         if (has_type) {
> > > >                 type =3D (char *)queue_remove(id_queue);
> > > >                 if (!type)
> > > > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_b=
inary.c
> > > > index b0befda3..b2c940f9 100644
> > > > --- a/libsepol/cil/src/cil_binary.c
> > > > +++ b/libsepol/cil/src/cil_binary.c
> > > > @@ -3749,6 +3749,7 @@ int cil_genfscon_to_policydb(policydb_t *pdb,=
 struct cil_sort *genfscons)
> > > >         uint32_t i =3D 0;
> > > >         genfs_t *genfs_tail =3D NULL;
> > > >         ocontext_t *ocon_tail =3D NULL;
> > > > +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB=
_CAP_GENFS_SECLABEL_WILDCARD);
> > > >
> > > >         for (i =3D 0; i < genfscons->count; i++) {
> > > >                 struct cil_genfscon *cil_genfscon =3D genfscons->ar=
ray[i];
> > > > @@ -3773,7 +3774,19 @@ int cil_genfscon_to_policydb(policydb_t *pdb=
, struct cil_sort *genfscons)
> > > >
> > > >                 ocon_tail =3D new_ocon;
> > > >
> > > > -               new_ocon->u.name =3D cil_strdup(cil_genfscon->path_=
str);
> > > > +               if (wildcard) {
> > > > +                       size_t name_len =3D strlen(cil_genfscon->pa=
th_str);
> > > > +                       new_ocon->u.name =3D malloc(name_len + 2);
> > > > +                       if (new_ocon->u.name =3D=3D NULL) {
> > > > +                               cil_log(CIL_ERR, "Failed to allocat=
e memory\n");
> > > > +                               exit(1);
> > > > +                       }
> > > > +                       memcpy(new_ocon->u.name, cil_genfscon->path=
_str, name_len);
> > > > +                       new_ocon->u.name[name_len] =3D '*';
> > > > +                       new_ocon->u.name[name_len + 1] =3D '\0';
> > > > +               } else {
> > > > +                       new_ocon->u.name =3D cil_strdup(cil_genfsco=
n->path_str);
> > > > +               }
> > > >
> > > >                 if (cil_genfscon->file_type !=3D CIL_FILECON_ANY) {
> > > >                         class_datum_t *class_datum;
> > > > diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/i=
nclude/sepol/policydb/polcaps.h
> > > > index 1aa9b30a..9f3495f5 100644
> > > > --- a/libsepol/include/sepol/policydb/polcaps.h
> > > > +++ b/libsepol/include/sepol/policydb/polcaps.h
> > > > @@ -16,6 +16,7 @@ enum {
> > > >         POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
> > > >         POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> > > >         POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> > > > +       POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> > > >         POLICYDB_CAP_NETLINK_XPERM,
> > > >         __POLICYDB_CAP_MAX
> > > >  };
> > >
> > > The order has to be the same as in the kernel. The number, rather tha=
n
> > > the name, is stored in the binary policy file.
> > > Thanks,
> > > Jim
> >
> > ok, I checked https://github.com/torvalds/linux/blob/master/security/se=
linux/include/policycap.h
> > and currently it is
> >
> > enum {
> > POLICYDB_CAP_NETPEER,
> > POLICYDB_CAP_OPENPERM,
> > POLICYDB_CAP_EXTSOCKCLASS,
> > POLICYDB_CAP_ALWAYSNETWORK,
> > POLICYDB_CAP_CGROUPSECLABEL,
> > POLICYDB_CAP_NNP_NOSUID_TRANSITION,
> > POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
> > POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> > POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> > POLICYDB_CAP_NETLINK_XPERM,
> > POLICYDB_CAP_NETIF_WILDCARD,
> > POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> > __POLICYDB_CAP_MAX
> > };
> >
> > It seems like POLICYDB_CAP_NETIF_WILDCARD is missing in libsepol. So I
> > need another commit adding POLICYDB_CAP_NETIF_WILDCARD to libsepol,
> > right?
> >
>
> Yes, I was reacting to the fact that you were not adding it to the end
> of the list, but you are right that one needs to be added as well. The
> order in libsepol has to match the kernel.
> Thanks,
> Jim
>


We will expose POLICYDB_CAP_NETIF_WILDCARD to the userspace which you
implemented in the kernel. For genfs, we are keeping backward compatibility=
 by
the userspace. You might want to try the same thing for the network interfa=
ce.
In that case, we might want to replace POLICYDB_CAP_NETIF_WILDCARD with som=
e
RESERVED name or something


> > >
> > > > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_=
cil.c
> > > > index ddca2b62..33ee59fb 100644
> > > > --- a/libsepol/src/kernel_to_cil.c
> > > > +++ b/libsepol/src/kernel_to_cil.c
> > > > @@ -2708,6 +2708,8 @@ static int write_genfscon_rules_to_cil(FILE *=
out, struct policydb *pdb)
> > > >         uint32_t sclass;
> > > >         const char *file_type;
> > > >         int rc;
> > > > +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB=
_CAP_GENFS_SECLABEL_WILDCARD);
> > > > +       size_t name_len;
> > > >
> > > >         rc =3D strs_init(&strs, 32);
> > > >         if (rc !=3D 0) {
> > > > @@ -2749,12 +2751,22 @@ static int write_genfscon_rules_to_cil(FILE=
 *out, struct policydb *pdb)
> > > >                                 goto exit;
> > > >                         }
> > > >
> > > > +                       name_len =3D strlen(name);
> > > > +                       if (wildcard) {
> > > > +                               if (name_len =3D=3D 0 || name[name_=
len - 1] !=3D '*') {
> > > > +                                       ERR(NULL, "genfscon path mu=
st end with '*' when genfs_seclabel_wildcard");
> > > > +                                       rc =3D -1;
> > > > +                                       goto exit;
> > > > +                               }
> > > > +                               --name_len;
> > > > +                       }
> > > > +
> > > >                         if (file_type) {
> > > > -                               rc =3D strs_create_and_add(strs, "(=
genfscon %s \"%s\" %s %s)",
> > > > -                                                                  =
              fstype, name, file_type, ctx);
> > > > +                               rc =3D strs_create_and_add(strs, "(=
genfscon %s \"%.*s\" %s %s)",
> > > > +                                                        fstype, na=
me_len, name, file_type, ctx);
> > > >                         } else {
> > > > -                               rc =3D strs_create_and_add(strs, "(=
genfscon %s \"%s\" %s)",
> > > > -                                                                  =
              fstype, name, ctx);
> > > > +                               rc =3D strs_create_and_add(strs, "(=
genfscon %s \"%.*s\" %s)",
> > > > +                                                        fstype, na=
me_len, name, ctx);
> > > >                         }
> > > >                         free(ctx);
> > > >                         if (rc !=3D 0) {
> > > > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to=
_conf.c
> > > > index 661546af..dac6fce9 100644
> > > > --- a/libsepol/src/kernel_to_conf.c
> > > > +++ b/libsepol/src/kernel_to_conf.c
> > > > @@ -2556,6 +2556,8 @@ static int write_genfscon_rules_to_conf(FILE =
*out, struct policydb *pdb)
> > > >         uint32_t sclass;
> > > >         const char *file_type;
> > > >         int rc;
> > > > +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB=
_CAP_GENFS_SECLABEL_WILDCARD);
> > > > +       size_t name_len;
> > > >
> > > >         rc =3D strs_init(&strs, 32);
> > > >         if (rc !=3D 0) {
> > > > @@ -2597,12 +2599,22 @@ static int write_genfscon_rules_to_conf(FIL=
E *out, struct policydb *pdb)
> > > >                                 goto exit;
> > > >                         }
> > > >
> > > > +                       name_len =3D strlen(name);
> > > > +                       if (wildcard) {
> > > > +                               if (name_len =3D=3D 0 || name[name_=
len - 1] !=3D '*') {
> > > > +                                       ERR(NULL, "genfscon path mu=
st end with '*' when genfs_seclabel_wildcard");
> > > > +                                       rc =3D -1;
> > > > +                                       goto exit;
> > > > +                               }
> > > > +                               --name_len;
> > > > +                       }
> > > > +
> > > >                         if (file_type) {
> > > > -                               rc =3D strs_create_and_add(strs, "g=
enfscon %s \"%s\" %s %s",
> > > > -                                                                  =
              fstype, name, file_type, ctx);
> > > > +                               rc =3D strs_create_and_add(strs, "g=
enfscon %s \"%.*s\" %s %s",
> > > > +                                                        fstype, na=
me_len, name, file_type, ctx);
> > > >                         } else {
> > > > -                               rc =3D strs_create_and_add(strs, "g=
enfscon %s \"%s\" %s",
> > > > -                                                                  =
              fstype, name, ctx);
> > > > +                               rc =3D strs_create_and_add(strs, "g=
enfscon %s \"%.*s\" %s",
> > > > +                                                        fstype, na=
me_len, name, ctx);
> > > >                         }
> > > >                         free(ctx);
> > > >                         if (rc !=3D 0) {
> > > > diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> > > > index 6b28c84e..a6fad2a9 100644
> > > > --- a/libsepol/src/polcaps.c
> > > > +++ b/libsepol/src/polcaps.c
> > > > @@ -15,6 +15,7 @@ static const char * const polcap_names[POLICYDB_C=
AP_MAX + 1] =3D {
> > > >         [POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]          =3D "genfs_=
seclabel_symlinks",
> > > >         [POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]               =3D "ioctl_=
skip_cloexec",
> > > >         [POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]        =3D "usersp=
ace_initial_context",
> > > > +       [POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]          =3D "genfs_=
seclabel_wildcard",
> > > >         [POLICYDB_CAP_NETLINK_XPERM]                    =3D "netlin=
k_xperm",
> > > >  };
> > > >
> > > > --
> > > > 2.49.0.1238.gf8c92423fb-goog
> > > >
> > > >
> >
> >
> >
> > --
> > Inseob Kim | Software Engineer | inseob@google.com
