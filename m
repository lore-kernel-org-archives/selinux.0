Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513E426FDB3
	for <selinux@vger.kernel.org>; Wed,  5 Nov 2025 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369149; cv=none; b=kOx0VQWSDfflDQa8d+F9WDOJXzwsTjGkvMqRRFfNnlahMRg1SdzUasvldJuhL2NzJxZtIS7SiS+/B6tR8R42MBzkDoFeo24oWo/Ps4knKpQaK5S/iMFoP6tSXj1q3565c557bmlvLtuCXgbWHKgb6XwBdwKBDEUfwLKZr+oSFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369149; c=relaxed/simple;
	bh=CETaHu0gvvquyMZE+3Nope4nyPb86xxPqbV5RtIfMAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qp7DhgfuiX3novPdboZBryNaiYeDCbRq9RZ8H+G2p9GUZCXwdnB9gjeahMrNI3KrGZV1q8av5rO4j6rlvQfLhzW+NeKfnMBty8zrVUGIxu9uMecPSTFiLYyamNlkvqaXWVR1RAetNJ/Z3RlQWiPWR06ftOXzlG6Lg5cHzxiNh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0yWU8cP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0yWU8cP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2955805b7acso10953835ad.1
        for <selinux@vger.kernel.org>; Wed, 05 Nov 2025 10:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369144; x=1762973944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To5N11ppR80QBGbRBN8uR5qkinBIUmuzo1a/StaRtJI=;
        b=a0yWU8cPst78OlrUiHN1iyT0Kao0KwKYSl99YkDY61F8lgzWJ+G3elZ3l7TTfC0ioe
         wbxyK9d9RS+yQ8XKVyZxEjVc5kKsO83uQ7npZq+Bp1Cc0IZ8it2b6CJ/ww9rqGUR4pf/
         e7UnvIAbgh3QcOrryh0DDZjA0hR7yKBdtKgyk7BuyTOXczAloC6alrjmEsXnKQyDvOx4
         CqI4BwBTdproicOjCOQxPllIDRV9kS92c3KjKbIdSAMJT7UuCZHk7UIUHcX4msSYfUKJ
         X28Xds5ULD84W7wWyayLrp+kl3uJZAVPIPBcgPeNpOR+6YQFpRe0qyAdqqdCtd0nA8m/
         zegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369144; x=1762973944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To5N11ppR80QBGbRBN8uR5qkinBIUmuzo1a/StaRtJI=;
        b=N+yi9Qk4liTli+5vXTNG7daMsrtw0iL6qQa9TE1lFBrgDoeA6i/tgjkHEr/Cl2akwd
         qjJ/duh29R8eioYrSyrOhydgmPfvHZseOJjvHZ35tObJ8+YsyhbUW9Kj95/Hqf5B6/YX
         wCHbJp1SwiDyZYCRsyoiZ44R6o6GSUlYjk27T7XRj9Ok8EZWWTETW4h5g8I/q8CW5EHX
         K92oimZ6NWoloULHZRbcfddgr+KyHhOPtlLm3D+ufFiIiupOBdQoouuYfDzyI6Y3pBIY
         dMPFqEpegDq46vJqWPgf7xV4MIhjFW568sfEqgO2i6hpWZLwgRVN3Zcko125OzVgwTjU
         47xA==
X-Gm-Message-State: AOJu0YzdVTL2Gd5p+LA9ArdEAsJ5ojJHSTwRAdsA9WLieErUJKaALeEd
	xnAoDxPlsUwa++ZBF7kSEZoPyol9znQ3D/xca/1jIgLX7FogZm69H6JbpAbJlA+ewmDGOta5JO6
	ktikQvZR/VCYbeIbX+4LO5rhZ23NLz58=
X-Gm-Gg: ASbGncvJz2Nt3kxdbbXrnuy9c/BLLZnLnIQ3qhxwtEtLffgP/1MX2PO7z7mwN4wLMMx
	DndDTVx/ING5qjS7wpIzDEDVX3sCmC/VzIr3I58eEfRB2NzD/eD847DgQ9gBEfsQXnZpQc/7/q3
	Hxx22QAhZ13eV/J+w9QzmANricz2JpUYOofJ7yivzx0mIXYAgjONfjqd0d7bD6dPsyrh60dZxE0
	kzHCYe0KlvfWZmCFkZhaJkCC5zm3BYpQkTxISpiq3Uoyh8kb5hDru5z2Nl4bOxk3EtkXzM=
X-Google-Smtp-Source: AGHT+IGPI7Zt8LGd6gnaRDQCtg8ok6npk0JC3t37vmcneUcwA5t5EbJndbu2i0+kXQYr86StvsVTa0LhFIelY1baztA=
X-Received: by 2002:a17:903:2347:b0:295:134:9ae5 with SMTP id
 d9443c01a7336-29651430c5cmr4932065ad.24.1762369144283; Wed, 05 Nov 2025
 10:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104205236.60931-1-jwcart2@gmail.com>
In-Reply-To: <20251104205236.60931-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 5 Nov 2025 13:58:53 -0500
X-Gm-Features: AWmQ_blif-28-HUJCisfHMBqTTb_cIzE5BJaAn4MAP2Cu1tegXB2aKrHmnb0ikc
Message-ID: <CAEjxPJ4N9DEAWPLEWc5k1VYkSwfinycZN5OgJeG=4-Pep0+zaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: Fix sid handling when writing out policy
 from binary
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, russell@coker.com.au, 
	Chris PeBenito <pebenito@ieee.org>, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:52=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> Initial sids are stored only as unsigned 32-bit numbers in a
> binary policy. When a binary kernel policy is converted to CIL
> or a policy.conf or a binary base module is converted to CIL, a
> mapping in kernel_to_common.h is used to determine the name of
> the initial sid.
>
> A problem can occur when policy converted from binary to text is
> once again compiled. The initial sids will not be the correct
> number if there are gaps in the list of initial sids. This will
> cause the effected initial sids to be interpreted by the kernel
> as a different initial sid.
>
> When writing out sid and sidorder statements in CIL, write out
> all the initial sids from kernel (which is initial sid #1) to the
> initial sid with the highest number associated with it. In the
> same way, when writing out sid statements for a policy.conf, all
> the initial sids from the first to the highest numbered must be
> written out with no gaps.
>
> No changes are needed when writing out statements associating
> an initial sid with a security context. There can be gaps in
> these statements. The numbering is taken from the declarations.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

With this applied, I confirmed that building refpolicy with the patch
in [1] did not disturb the initial SID index values.
I also saw no regressions wrt existing policy.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

[1] https://lore.kernel.org/selinux-refpolicy/20251030200720.18719-2-stephe=
n.smalley.work@gmail.com/

> ---
>  libsepol/src/kernel_to_cil.c    |  47 +++-----------
>  libsepol/src/kernel_to_common.c |  48 +++++++++++++++
>  libsepol/src/kernel_to_common.h |   1 +
>  libsepol/src/kernel_to_conf.c   |  41 +++---------
>  libsepol/src/module_to_cil.c    | 106 ++++++++++++++++----------------
>  5 files changed, 121 insertions(+), 122 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 4da63ba5..06cf4498 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -565,54 +565,31 @@ exit:
>  static int write_sids_to_cil(FILE *out, const char *const *sid_to_str,
>                              unsigned num_sids, struct ocontext *isids)
>  {
> -       struct ocontext *isid;
>         struct strs *strs;
>         char *sid;
>         char *prev;
> -       char unknown[18];
>         unsigned i;
> -       int rc;
>
> -       rc =3D strs_init(&strs, num_sids+1);
> -       if (rc !=3D 0) {
> -               goto exit;
> +       strs =3D isids_to_strs(sid_to_str, num_sids, isids);
> +       if (!strs) {
> +               ERR(NULL, "Error writing sid rules to CIL");
> +               return -1;
>         }
>
> -       for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
> -               i =3D isid->sid[0];
> -               if (i < num_sids && sid_to_str[i]) {
> -                       sid =3D strdup(sid_to_str[i]);
> -               } else {
> -                       snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> -                       sid =3D strdup(unknown);
> -               }
> -               if (!sid) {
> -                       ERR(NULL, "Out of memory");
> -                       rc =3D -1;
> -                       goto exit;
> -               }
> -               rc =3D strs_add_at_index(strs, sid, i);
> -               if (rc !=3D 0) {
> -                       free(sid);
> -                       goto exit;
> -               }
> +       if (strs_num_items(strs) =3D=3D 0) {
> +               strs_destroy(&strs);
> +               return 0;
>         }
>
> -       for (i=3D0; i<strs_num_items(strs); i++) {
> +       for (i=3D1; i < strs_num_items(strs); i++) {
>                 sid =3D strs_read_at_index(strs, i);
> -               if (!sid) {
> -                       continue;
> -               }
>                 sepol_printf(out, "(sid %s)\n", sid);
>         }
>
>         sepol_printf(out, "(sidorder (");
>         prev =3D NULL;
> -       for (i=3D0; i<strs_num_items(strs); i++) {
> +       for (i=3D1; i < strs_num_items(strs); i++) {
>                 sid =3D strs_read_at_index(strs, i);
> -               if (!sid) {
> -                       continue;
> -               }
>                 if (prev) {
>                         sepol_printf(out, "%s ", prev);
>                 }
> @@ -623,14 +600,10 @@ static int write_sids_to_cil(FILE *out, const char =
*const *sid_to_str,
>         }
>         sepol_printf(out, "))\n");
>
> -exit:
>         strs_free_all(strs);
>         strs_destroy(&strs);
> -       if (rc !=3D 0) {
> -               ERR(NULL, "Error writing sid rules to CIL");
> -       }
>
> -       return rc;
> +       return 0;
>  }
>
>  static int write_sid_decl_rules_to_cil(FILE *out, struct policydb *pdb)
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index e4338ec6..99e46865 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -382,6 +382,54 @@ int strs_stack_empty(const struct strs *stack)
>         return strs_num_items(stack) =3D=3D 0;
>  }
>
> +struct strs *isids_to_strs(const char *const *sid_to_str, unsigned num_s=
ids, struct ocontext *isids)
> +{
> +       struct ocontext *isid;
> +       struct strs *strs;
> +       char *sid;
> +       char unknown[18];
> +       unsigned i, max;
> +       int rc;
> +
> +       rc =3D strs_init(&strs, num_sids+1);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       max =3D 0;
> +       for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
> +               i =3D isid->sid[0];
> +               if (i > max) {
> +                       max =3D i;
> +               }
> +       }
> +
> +       for (i=3D1; i <=3D max; i++) {
> +               if (i < num_sids && sid_to_str[i]) {
> +                       sid =3D strdup(sid_to_str[i]);
> +               } else {
> +                       snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> +                       sid =3D strdup(unknown);
> +               }
> +               if (!sid) {
> +                       ERR(NULL, "Out of memory");
> +                       goto exit;
> +               }
> +               rc =3D strs_add_at_index(strs, sid, i);
> +               if (rc !=3D 0) {
> +                       free(sid);
> +                       goto exit;
> +               }
> +       }
> +
> +       return strs;
> +
> +exit:
> +       strs_free_all(strs);
> +       strs_destroy(&strs);
> +       return NULL;
> +}
> +
>  static int compare_ranges(uint64_t l1, uint64_t h1, uint64_t l2, uint64_=
t h2)
>  {
>         uint64_t d1, d2;
> diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_com=
mon.h
> index 3ba97dfc..d3283658 100644
> --- a/libsepol/src/kernel_to_common.h
> +++ b/libsepol/src/kernel_to_common.h
> @@ -115,4 +115,5 @@ int strs_stack_push(struct strs *stack, char *s);
>  char *strs_stack_pop(struct strs *stack);
>  int strs_stack_empty(const struct strs *stack);
>
> +struct strs *isids_to_strs(const char *const *sid_to_str, unsigned num_s=
ids, struct ocontext *isids);
>  int sort_ocontexts(struct policydb *pdb);
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 6d608443..a8126d58 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -463,53 +463,30 @@ static int write_class_decl_rules_to_conf(FILE *out=
, struct policydb *pdb)
>  static int write_sids_to_conf(FILE *out, const char *const *sid_to_str,
>                               unsigned num_sids, struct ocontext *isids)
>  {
> -       struct ocontext *isid;
>         struct strs *strs;
>         char *sid;
> -       char unknown[18];
>         unsigned i;
> -       int rc;
>
> -       rc =3D strs_init(&strs, num_sids+1);
> -       if (rc !=3D 0) {
> -               goto exit;
> +       strs =3D isids_to_strs(sid_to_str, num_sids, isids);
> +       if (!strs) {
> +               ERR(NULL, "Error writing sid rules to policy.conf");
> +               return -1;
>         }
>
> -       for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
> -               i =3D isid->sid[0];
> -               if (i < num_sids && sid_to_str[i]) {
> -                       sid =3D strdup(sid_to_str[i]);
> -               } else {
> -                       snprintf(unknown, sizeof(unknown), "%s%u", "UNKNO=
WN", i);
> -                       sid =3D strdup(unknown);
> -               }
> -               if (!sid) {
> -                       rc =3D -1;
> -                       goto exit;
> -               }
> -               rc =3D strs_add_at_index(strs, sid, i);
> -               if (rc !=3D 0) {
> -                       free(sid);
> -                       goto exit;
> -               }
> +       if (strs_num_items(strs) =3D=3D 0) {
> +               strs_destroy(&strs);
> +               return 0;
>         }
>
> -       for (i=3D0; i<strs_num_items(strs); i++) {
> +       for (i=3D1; i < strs_num_items(strs); i++) {
>                 sid =3D strs_read_at_index(strs, i);
> -               if (!sid) {
> -                       continue;
> -               }
>                 sepol_printf(out, "sid %s\n", sid);
>         }
>
> -exit:
>         strs_free_all(strs);
>         strs_destroy(&strs);
> -       if (rc !=3D 0) {
> -               ERR(NULL, "Error writing sid rules to policy.conf");
> -       }
>
> -       return rc;
> +       return 0;
>  }
>
>  static int write_sid_decl_rules_to_conf(FILE *out, struct policydb *pdb)
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 8647d928..1c4e80d1 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2544,71 +2544,71 @@ static int context_to_cil(struct policydb *pdb, s=
truct context_struct *con)
>  static int ocontext_isid_to_cil(struct policydb *pdb, const char *const =
*sid_to_string,
>                                 unsigned num_sids, struct ocontext *isids=
)
>  {
> -       int rc =3D -1;
> -
>         struct ocontext *isid;
> -
> -       struct sid_item {
> -               char *sid_key;
> -               struct sid_item *next;
> -       };
> -
> -       struct sid_item *head =3D NULL;
> -       struct sid_item *item =3D NULL;
> +       struct ocontext **isid_array;
> +       struct strs *strs;
>         char *sid;
> -       char unknown[18];
> +       char *prev;
>         unsigned i;
>
> -       for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
> -               i =3D isid->sid[0];
> -               if (i < num_sids && sid_to_string[i]) {
> -                       sid =3D (char*)sid_to_string[i];
> -               } else {
> -                       snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> -                       sid =3D unknown;
> -               }
> -               cil_println(0, "(sid %s)", sid);
> -               cil_printf("(sidcontext %s ", sid);
> -               context_to_cil(pdb, &isid->context[0]);
> -               cil_printf(")\n");
> +       strs =3D isids_to_strs(sid_to_string, num_sids, isids);
> +       if (!strs) {
> +               ERR(NULL, "Error writing sid rules to CIL");
> +               return -1;
> +       }
>
> -               // get the sid names in the correct order (reverse from t=
he isids
> -               // ocontext) for sidorder statement
> -               item =3D malloc(sizeof(*item));
> -               if (item =3D=3D NULL) {
> -                       ERR(NULL, "Out of memory");
> -                       rc =3D -1;
> -                       goto exit;
> -               }
> -               item->sid_key =3D strdup(sid);
> -               if (!item->sid_key) {
> -                       ERR(NULL, "Out of memory");
> -                       free(item);
> -                       rc =3D -1;
> -                       goto exit;
> +       if (strs_num_items(strs) =3D=3D 0) {
> +               strs_destroy(&strs);
> +               return 0;
> +       }
> +
> +       for (i=3D1; i < strs_num_items(strs); i++) {
> +               sid =3D strs_read_at_index(strs, i);
> +               cil_printf("(sid %s)\n", sid);
> +       }
> +
> +       cil_printf("(sidorder (");
> +       prev =3D NULL;
> +       for (i=3D1; i < strs_num_items(strs); i++) {
> +               sid =3D strs_read_at_index(strs, i);
> +               if (prev) {
> +                       cil_printf("%s ", prev);
>                 }
> -               item->next =3D head;
> -               head =3D item;
> +               prev =3D sid;
> +       }
> +       if (prev) {
> +               cil_printf("%s", prev);
>         }
> +       cil_printf("))\n");
>
> -       if (head !=3D NULL) {
> -               cil_printf("(sidorder (");
> -               for (item =3D head; item !=3D NULL; item =3D item->next) =
{
> -                       cil_printf("%s ", item->sid_key);
> +       isid_array =3D calloc(strs_num_items(strs), sizeof(struct ocontex=
t *));
> +       if (!isid_array) {
> +               ERR(NULL, "Out of memory");
> +               strs_free_all(strs);
> +               strs_destroy(&strs);
> +               return -1;
> +       }
> +       for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
> +               i =3D isid->sid[0];
> +               if (i < strs_num_items(strs)) {
> +                       isid_array[i] =3D isid;
> +               }
> +       }
> +       for (i=3D1; i < strs_num_items(strs); i++) {
> +               if (isid_array[i]) {
> +                       sid =3D strs_read_at_index(strs, i);
> +                       cil_printf("(sidcontext %s ", sid);
> +                       isid =3D isid_array[i];
> +                       context_to_cil(pdb, &isid->context[0]);
> +                       cil_printf(")\n");
>                 }
> -               cil_printf("))\n");
>         }
> +       free(isid_array);
>
> -       rc =3D 0;
> +       strs_free_all(strs);
> +       strs_destroy(&strs);
>
> -exit:
> -       while(head) {
> -               item =3D head;
> -               head =3D item->next;
> -               free(item->sid_key);
> -               free(item);
> -       }
> -       return rc;
> +       return 0;
>  }
>
>  static int ocontext_selinux_isid_to_cil(struct policydb *pdb, struct oco=
ntext *isids)
> --
> 2.50.0
>
