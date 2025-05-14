Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A31DED6F;
	Wed, 14 May 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249178; cv=none; b=gjy2jrZiZS0B/1RMxRzecsqW0vo2MYw87Iemnmg5YUfHwsKLij91OFm7am6gdswXX4vjbWbVXt9cjfgjxGC+9ySh4T/d7dXYYnRqxZbfCNzvo6rTB3QamfYQax5G8E8kWoncDc8uo/SLAwxAJY2Sk8dRouwx1QuJBnNxYBkqa+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249178; c=relaxed/simple;
	bh=HXx1eCl8xZNA1+Z0jZ649FoSSxumZ7ayffO1EaHox0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSxkWW/zOSumW739yUe2f56cveeMa1JLlgYpo0qsxUvgRgK2/nULmDJCUg6/ojlj8/AZkLR78OmGDHznNf7nhSgnoEvH1o7i22Do6dVOKmtEo0Zr39k/9Qctu6o1hhGbY2qsV4hTfylCFHrEm8o35+jVdOPRV+uY+PXlFKUziY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATQAXdmX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATQAXdmX"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso167266a91.3;
        Wed, 14 May 2025 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747249174; x=1747853974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB/fBrSOiGmKgir1N1aKyUJGw8tNr0qalJakQgrxaKc=;
        b=ATQAXdmXAEr3BQTKURAGGTDR68Bu2Wz8ROCwbHgMIzOe7cg5DE2KEoyt7P4qkfDVhp
         WXVB7kbxqucTUZlHFy8pX8iYe+tn6bbEVjABbYHP20Do/NrvAsX/8cc5JiNCk8TBJAAE
         Rqt7taNNQOoOVbCUoS/FCveAL536oBZe2UmQW+WBhjQEMupqmqpHNIYxqREftqmlgj1v
         t2gktPPnsCqi6xfjo4rXWV6waJCtlsskV3ubd0p5NWEFQ0iPkMvdx2bVI6m+bU+PFJE3
         Ck+UdcChGcb/HfsWU1Nywgoski8a/3jfKkWC+MjL890ls5oLqEeovKGBeKHBEuNASQF1
         2mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747249174; x=1747853974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB/fBrSOiGmKgir1N1aKyUJGw8tNr0qalJakQgrxaKc=;
        b=RvONQdvLW/k9NxAcJ+SyTPSeB/bE5m80ELzSaDqiBQHMzqENPRfcgjV+ZJEdOx3rOs
         8ApswLeN978yhGvtYhroVqvMaa51T7v1rXNr/qtxZ/7me39AlQB6QZQaHQwJ9lcLHn+i
         ZREbc3x+0ax+nfPJhshrz9E61U7wDmVoazFj8Itb/nNwwQYf01Zy7O2Q+JbK7dWrIuHT
         VI/UY963ONjyKNrONiZLHJzuZaFCQaBjrTEchLler0bFQEjPaJ/QKrLDbslvwpXV5oUh
         AmZDldTrE7L0qUAAQHVdDtCzRMfKGQPzRjhgxNB3cT81fJsYWV6W6n9gpHq3/ZDL0rIJ
         rM6g==
X-Forwarded-Encrypted: i=1; AJvYcCWKipYHhxYKZZ/Eym0EALXcHtEMX4QdXs21mo/YVWwjOq7+qdqadvpZAbmf6ZoO/fpYMkEmTutfnESJjg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV32Th8+0tB4/s1DqFqAhHZiRGOfLY/oRy+uFuzwzpz6G0++L7
	Ir0fFeV0wFD797N1GUhq47MP0G2bhz6958/TDJaT1t7Iht6fhuhjJ/6pDPTcLh9uqAIIOcvtwDV
	QZzYGkf/4C2CdIph03hc884KAdqs=
X-Gm-Gg: ASbGnctbINy/aWAf6GZD+d5w7VGHTcFAFclCFMrm47C6LGfcizwQgVxeS+NWqOflsCN
	cYaqyvSGmzk/+g9EoZCfJMpkptrqkrvrwxCFWgiMd7vul9OUvI2uvWg1ekz0vgUnduFoHI6H40n
	eOdMl5Ri+wfg8B0itlUiqCVlTS1jOVIlbQ5YpCLxMFnqY=
X-Google-Smtp-Source: AGHT+IEEvh/Sq6oe9hlV6nUaIxHbp3qlNCX47pYW1mxmnWpB/jQKAPUCcHv2ljt8W/nOcqrZVbn49x9cmteG0iDe+/s=
X-Received: by 2002:a17:90b:17d2:b0:2f7:4cce:ae37 with SMTP id
 98e67ed59e1d1-30e2e5d1a22mr8150961a91.18.1747249174257; Wed, 14 May 2025
 11:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-9-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-9-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 May 2025 14:59:22 -0400
X-Gm-Features: AX0GCFuq9e0CYCn2G54VVEdXNhGqc3P9Des91xzc5owXRPCxqO8TC5-hC1YLF1k
Message-ID: <CAEjxPJ6ikjKZWxztGFjM_4ZjRB9RWjMcZ4ocGZRHb_pjC+DCUg@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] selinux: beef up isvalid checks
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, Takaya Saeki <takayas@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Check that an ID does not refer to a gap in the global array of
> definitions.
>
> Constify parameters of isvalid() function and change return type to
> bool.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/ss/hashtab.h  |  4 +--
>  security/selinux/ss/mls.c      | 66 +++++++++++++++++++++-------------
>  security/selinux/ss/mls.h      |  6 ++--
>  security/selinux/ss/policydb.c | 56 ++++++++++++++++-------------
>  security/selinux/ss/policydb.h | 12 +++----
>  security/selinux/ss/services.c |  2 +-
>  security/selinux/ss/symtab.c   |  2 +-
>  security/selinux/ss/symtab.h   |  2 +-
>  8 files changed, 88 insertions(+), 62 deletions(-)
>
> diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.=
h
> index deba82d78c3a..c641fb12916b 100644
> --- a/security/selinux/ss/hashtab.h
> +++ b/security/selinux/ss/hashtab.h
> @@ -94,11 +94,11 @@ static inline int hashtab_insert(struct hashtab *h, v=
oid *key, void *datum,
>   * Returns NULL if no entry has the specified key or
>   * the datum of the entry otherwise.
>   */
> -static inline void *hashtab_search(struct hashtab *h, const void *key,
> +static inline void *hashtab_search(const struct hashtab *h, const void *=
key,
>                                    struct hashtab_key_params key_params)
>  {
>         u32 hvalue;
> -       struct hashtab_node *cur;
> +       const struct hashtab_node *cur;
>
>         if (!h->size)
>                 return NULL;
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index a6e49269f535..3cd36e2015fa 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -32,7 +32,7 @@
>  int mls_compute_context_len(struct policydb *p, struct context *context)
>  {
>         int i, l, len, head, prev;
> -       char *nm;
> +       const char *nm;
>         struct ebitmap *e;
>         struct ebitmap_node *node;
>
> @@ -86,7 +86,8 @@ int mls_compute_context_len(struct policydb *p, struct =
context *context)
>  void mls_sid_to_context(struct policydb *p, struct context *context,
>                         char **scontext)
>  {
> -       char *scontextp, *nm;
> +       const char *nm;
> +       char *scontextp;
>         int i, l, head, prev;
>         struct ebitmap *e;
>         struct ebitmap_node *node;
> @@ -155,27 +156,44 @@ void mls_sid_to_context(struct policydb *p, struct =
context *context,
>         *scontext =3D scontextp;
>  }
>
> -int mls_level_isvalid(struct policydb *p, struct mls_level *l)
> +bool mls_level_isvalid(const struct policydb *p, const struct mls_level =
*l)
>  {
> -       struct level_datum *levdatum;
> +       const char *name;
> +       const struct level_datum *levdatum;
> +       struct ebitmap_node *node;
> +       u32 bit;
> +       int rc;
>
>         if (!l->sens || l->sens > p->p_levels.nprim)
> -               return 0;
> -       levdatum =3D symtab_search(&p->p_levels,
> -                                sym_name(p, SYM_LEVELS, l->sens - 1));
> +               return false;
> +
> +       name =3D sym_name(p, SYM_LEVELS, l->sens - 1);
> +       if (!name)
> +               return false;
> +
> +       levdatum =3D symtab_search(&p->p_levels, name);
>         if (!levdatum)
> -               return 0;
> +               return false;
>
>         /*
> -        * Return 1 iff all the bits set in l->cat are also be set in
> +        * Validate that all bits set in l->cat are also be set in
>          * levdatum->level->cat and no bit in l->cat is larger than
>          * p->p_cats.nprim.
>          */
> -       return ebitmap_contains(&levdatum->level.cat, &l->cat,
> -                               p->p_cats.nprim);
> +       rc =3D ebitmap_contains(&levdatum->level.cat, &l->cat,
> +                             p->p_cats.nprim);
> +       if (!rc)
> +               return false;
> +
> +       ebitmap_for_each_positive_bit(&levdatum->level.cat, node, bit) {
> +               if (!sym_name(p, SYM_CATS, bit))
> +                       return false;
> +       }
> +
> +       return true;
>  }
>
> -int mls_range_isvalid(struct policydb *p, struct mls_range *r)
> +bool mls_range_isvalid(const struct policydb *p, const struct mls_range =
*r)
>  {
>         return (mls_level_isvalid(p, &r->level[0]) &&
>                 mls_level_isvalid(p, &r->level[1]) &&
> @@ -183,32 +201,32 @@ int mls_range_isvalid(struct policydb *p, struct ml=
s_range *r)
>  }
>
>  /*
> - * Return 1 if the MLS fields in the security context
> + * Return true if the MLS fields in the security context
>   * structure `c' are valid.  Return 0 otherwise.
>   */
> -int mls_context_isvalid(struct policydb *p, struct context *c)
> +bool mls_context_isvalid(const struct policydb *p, const struct context =
*c)
>  {
> -       struct user_datum *usrdatum;
> +       const struct user_datum *usrdatum;
>
>         if (!p->mls_enabled)
> -               return 1;
> +               return true;
>
>         if (!mls_range_isvalid(p, &c->range))
> -               return 0;
> +               return false;
>
>         if (c->role =3D=3D OBJECT_R_VAL)
> -               return 1;
> +               return true;
>
>         /*
>          * User must be authorized for the MLS range.
>          */
>         if (!c->user || c->user > p->p_users.nprim)
> -               return 0;
> +               return false;
>         usrdatum =3D p->user_val_to_struct[c->user - 1];
> -       if (!mls_range_contains(usrdatum->range, c->range))
> -               return 0; /* user may not be associated with range */
> +       if (!usrdatum || !mls_range_contains(usrdatum->range, c->range))
> +               return false; /* user may not be associated with range */
>
> -       return 1;
> +       return true;
>  }
>
>  /*
> @@ -449,8 +467,8 @@ int mls_convert_context(struct policydb *oldp, struct=
 policydb *newp,
>                 return 0;
>
>         for (l =3D 0; l < 2; l++) {
> -               char *name =3D sym_name(oldp, SYM_LEVELS,
> -                                     oldc->range.level[l].sens - 1);
> +               const char *name =3D sym_name(oldp, SYM_LEVELS,
> +                                           oldc->range.level[l].sens - 1=
);
>
>                 levdatum =3D symtab_search(&newp->p_levels, name);
>
> diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> index 07980636751f..93cde1b22992 100644
> --- a/security/selinux/ss/mls.h
> +++ b/security/selinux/ss/mls.h
> @@ -27,9 +27,9 @@
>  int mls_compute_context_len(struct policydb *p, struct context *context)=
;
>  void mls_sid_to_context(struct policydb *p, struct context *context,
>                         char **scontext);
> -int mls_context_isvalid(struct policydb *p, struct context *c);
> -int mls_range_isvalid(struct policydb *p, struct mls_range *r);
> -int mls_level_isvalid(struct policydb *p, struct mls_level *l);
> +bool mls_context_isvalid(const struct policydb *p, const struct context =
*c);
> +bool mls_range_isvalid(const struct policydb *p, const struct mls_range =
*r);
> +bool mls_level_isvalid(const struct policydb *p, const struct mls_level =
*l);
>
>  int mls_context_to_sid(struct policydb *p, char oldc, char *scontext,
>                        struct context *context, struct sidtab *s, u32 def=
_sid);
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 326d82f8db8c..f8d6e993ce89 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -923,51 +923,59 @@ int policydb_load_isids(struct policydb *p, struct =
sidtab *s)
>         return 0;
>  }
>
> -int policydb_class_isvalid(struct policydb *p, u16 class)
> +bool policydb_class_isvalid(const struct policydb *p, u16 class)
>  {
>         if (!class || class > p->p_classes.nprim)
> -               return 0;
> -       return 1;
> +               return false;
> +       if (!p->sym_val_to_name[SYM_CLASSES][class - 1])
> +               return false;
> +       return true;
>  }
>
> -int policydb_role_isvalid(struct policydb *p, unsigned int role)
> +bool policydb_role_isvalid(const struct policydb *p, u32 role)
>  {
>         if (!role || role > p->p_roles.nprim)
> -               return 0;
> -       return 1;
> +               return false;
> +       if (!p->sym_val_to_name[SYM_ROLES][role - 1])
> +               return false;
> +       return true;
>  }
>
> -int policydb_type_isvalid(struct policydb *p, unsigned int type)
> +bool policydb_type_isvalid(const struct policydb *p, u32 type)
>  {
>         if (!type || type > p->p_types.nprim)
> -               return 0;
> -       return 1;
> +               return false;
> +       if (!p->sym_val_to_name[SYM_TYPES][type - 1])
> +               return false;
> +       return true;
>  }
>
> -int policydb_boolean_isvalid(const struct policydb *p, u32 boolean)
> +bool policydb_boolean_isvalid(const struct policydb *p, u32 boolean)
>  {
>         if (!boolean || boolean > p->p_bools.nprim)
> -               return 0;
> -       return 1;
> +               return false;
> +       if (!p->sym_val_to_name[SYM_BOOLS][boolean - 1])
> +               return false;
> +       return true;
>  }
>
>  /*
> - * Return 1 if the fields in the security context
> + * Return true if the fields in the security context
>   * structure `c' are valid.  Return 0 otherwise.
>   */
> -int policydb_context_isvalid(struct policydb *p, struct context *c)
> +bool policydb_context_isvalid(const struct policydb *p, const struct con=
text *c)
>  {
> -       struct role_datum *role;
> -       struct user_datum *usrdatum;
> +       const struct role_datum *role;
> +       const struct user_datum *usrdatum;
>
>         if (!c->role || c->role > p->p_roles.nprim)
> -               return 0;
> +               return false;
>
>         if (!c->user || c->user > p->p_users.nprim)
> -               return 0;
> +               return false;
>
>         if (!c->type || c->type > p->p_types.nprim)
> -               return 0;
> +               return false;
>
>         if (c->role !=3D OBJECT_R_VAL) {
>                 /*
> @@ -976,24 +984,24 @@ int policydb_context_isvalid(struct policydb *p, st=
ruct context *c)
>                 role =3D p->role_val_to_struct[c->role - 1];
>                 if (!role || !ebitmap_get_bit(&role->types, c->type - 1))
>                         /* role may not be associated with type */
> -                       return 0;
> +                       return false;
>
>                 /*
>                  * User must be authorized for the role.
>                  */
>                 usrdatum =3D p->user_val_to_struct[c->user - 1];
>                 if (!usrdatum)
> -                       return 0;
> +                       return false;
>
>                 if (!ebitmap_get_bit(&usrdatum->roles, c->role - 1))
>                         /* user may not be associated with role */
> -                       return 0;
> +                       return false;
>         }
>
>         if (!mls_context_isvalid(p, c))
> -               return 0;
> +               return false;
>
> -       return 1;
> +       return true;
>  }
>
>  /*
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policyd=
b.h
> index 42117adb2ca0..1367387beaa7 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -320,11 +320,11 @@ struct policy_file {
>
>  extern void policydb_destroy(struct policydb *p);
>  extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
> -extern int policydb_context_isvalid(struct policydb *p, struct context *=
c);
> -extern int policydb_class_isvalid(struct policydb *p, u16 class);
> -extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
> -extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
> -extern int policydb_boolean_isvalid(const struct policydb *p, u32 boolea=
n);
> +extern bool policydb_context_isvalid(const struct policydb *p, const str=
uct context *c);
> +extern bool policydb_class_isvalid(const struct policydb *p, u16 class);
> +extern bool policydb_type_isvalid(const struct policydb *p, u32 type);
> +extern bool policydb_role_isvalid(const struct policydb *p, u32 role);
> +extern bool policydb_boolean_isvalid(const struct policydb *p, u32 boole=
an);
>  extern int policydb_read(struct policydb *p, struct policy_file *fp);
>  extern int policydb_write(struct policydb *p, struct policy_file *fp);
>
> @@ -395,7 +395,7 @@ static inline int put_entry(const void *buf, size_t b=
ytes, size_t num,
>         return 0;
>  }
>
> -static inline char *sym_name(struct policydb *p, unsigned int sym_num,
> +static inline const char *sym_name(const struct policydb *p, unsigned in=
t sym_num,
>                              unsigned int element_nr)
>  {
>         return p->sym_val_to_name[sym_num][element_nr];
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 3fb971fe4fd9..5b1d0e80d975 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -464,7 +464,7 @@ static void security_dump_masked_av(struct policydb *=
policydb,
>         struct common_datum *common_dat;
>         struct class_datum *tclass_dat;
>         struct audit_buffer *ab;
> -       char *tclass_name;
> +       const char *tclass_name;
>         char *scontext_name =3D NULL;
>         char *tcontext_name =3D NULL;
>         char *permission_names[SEL_VEC_MAX];
> diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
> index 832660fd84a9..a756554e7f1d 100644
> --- a/security/selinux/ss/symtab.c
> +++ b/security/selinux/ss/symtab.c
> @@ -50,7 +50,7 @@ int symtab_insert(struct symtab *s, char *name, void *d=
atum)
>         return hashtab_insert(&s->table, name, datum, symtab_key_params);
>  }
>
> -void *symtab_search(struct symtab *s, const char *name)
> +void *symtab_search(const struct symtab *s, const char *name)
>  {
>         return hashtab_search(&s->table, name, symtab_key_params);
>  }
> diff --git a/security/selinux/ss/symtab.h b/security/selinux/ss/symtab.h
> index 8e667cdbf38f..7cfa3b44953a 100644
> --- a/security/selinux/ss/symtab.h
> +++ b/security/selinux/ss/symtab.h
> @@ -21,6 +21,6 @@ struct symtab {
>  int symtab_init(struct symtab *s, u32 size);
>
>  int symtab_insert(struct symtab *s, char *name, void *datum);
> -void *symtab_search(struct symtab *s, const char *name);
> +void *symtab_search(const struct symtab *s, const char *name);
>
>  #endif /* _SS_SYMTAB_H_ */
> --
> 2.49.0
>
