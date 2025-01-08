Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA1201001;
	Wed,  8 Jan 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351386; cv=none; b=lsFwHMxhpONTtDr9CnajVTGzFoyeWWqct9XCCaTI0rYN9MIoPG527xVCTlkKeIswAC3NAyn9kDHtMoBUr1dgGXAXWNYjcMok3CodIIcDY/wWB7zYofVoonZQpJul6zBRwTp5cAMiwyGxUF5fEk/FFucWp32P6e54NXImhdbFj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351386; c=relaxed/simple;
	bh=HnhD7qLoF2xw9DuWcbGxiSpLsuyqXXj5iz9UAsTjxdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+GDnZEji5xBdHe8dISUGtlYkxDAUaoBaH+SybvbDw4Pg/ulueOIQlSYnC8dRLjotVFNF7Mvy9b39tEfexrqzFm5Apc5KOzc5ZqPAtJiSLPZ9gkX8PmZuN6VhYjHRU4HdgZlhernsgIUhvFo2ip/Dqdw5NTush0pfqImls/vjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=efRjOiVt; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="efRjOiVt"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e39f43344c5so22494366276.1;
        Wed, 08 Jan 2025 07:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736351384; x=1736956184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDW/Ako6zjMiCuxIC7DipSyinlux1XQkA/YVTKRT8+0=;
        b=efRjOiVtsl5a+uuI8oVKQF0qpToP89P2RP3RjFoz3eeG7s5CDvMqZGBket9f5lodtP
         WKcWJ6IOnFwGy0ltgrTsZMqqN19aQrNQjZyJRr+ldOCWCh7soiTwN1KR1yw3Rpvh+MUG
         lzHA3/7wfHNFG0rZyt1YPGqQpv/LmCeV/eumqjFcOcLyKROULUhO+aRtg2riLGOiRHmz
         M3U+NRGPFI1TcjDVX++AJaBh7kN2ILdn/keC4bW1RoP6Nugke7E7U2GKzoOjq8yhQ3Ko
         /DclN06ORJy0X7owMRfW7fybR3BTC8EFbJrDAfWioKSJvvgrDCFrNp5y7bAPJ+y6I/xF
         3rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736351384; x=1736956184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDW/Ako6zjMiCuxIC7DipSyinlux1XQkA/YVTKRT8+0=;
        b=O8hSp5ClcBTnk3i89NhvOqbd94+53zv4D5KitoKZx7ojhskTMgaQK3e4TWZ6ji+w/A
         BpY7D4ahi01pz7QYl0vuvjUntlZpuBirQG84Vf42IViPBxwD3l99OtsiExArbwNnWhGz
         hLtZhC/cMunBEP3OMRm34nyhPxWhEhj7VrIM8q8OPNuv2QCV6+uvMDqlYa3vUju8Xf6j
         wmS7PMjjx2SW7gHafLBYfwSyUHg6OS+cybwVbfnrBnLz3C0Qi8A0icVsO6IpW0OSLmqj
         VESgvO0bbr6r8HkjI0IHp5x1u64Zzc4yM/ZFO/PerCRkE0bUHdENThdoO6uoTm8t6wHh
         dAxw==
X-Forwarded-Encrypted: i=1; AJvYcCV2vaSNOIxNjd7zIEK8o2qJ6qJ+3iTqxvUeSZZv9J3fKJlHh/s4Ve5mBAXgT6f2M2aZpagN0sS5VSyZmb8=@vger.kernel.org, AJvYcCWCOk5ly/+HlA+trLlB34DUQGgq6PCYxDM72fDj6NDLfB58ZEz4TRuJ9k96zUQ9hfoxHd7NkJSqUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJ4HBBhqsQ0BMC3UFyfcvfFBD7md96K6aK2pUscVYrOzbtvvw
	BdUYaMn5kcbjhvoCXhNzfazyDsbZLRHyzrW+4gEzvUjCeMCj15mXsK8DDOM7UAO6LqUKAdSPOpP
	j9R56BtIRLxquUkI02fOaFUIO7Nk=
X-Gm-Gg: ASbGnctNxFEfgBJP79u135yyyOOMi4+oaYVlZ3v9BaHN+Vpnv/HCYyFYY56EFDC9/f/
	kohuA6/1Rj81sHYE879oDjgwogT3iT1uq6EtQ
X-Google-Smtp-Source: AGHT+IHOsUdl20Vn8APEMawYUBEFyeYi7/RbP+yoN0I9+eYmWaKxd5jhuOs4pqoLc/S2RW9zbrJTYpR4GnrzmZsqepc=
X-Received: by 2002:a05:690c:e1f:b0:6ef:5fee:1ca6 with SMTP id
 00721157ae682-6f531233b36mr24445507b3.18.1736351383819; Wed, 08 Jan 2025
 07:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216164055.96267-11-cgoettsche@seltendoof.de> <ef5f7c20f5a3a485cdf2603ea4a4cde9@paul-moore.com>
In-Reply-To: <ef5f7c20f5a3a485cdf2603ea4a4cde9@paul-moore.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 8 Jan 2025 16:49:33 +0100
X-Gm-Features: AbW1kvaCC9pclqT_gbVW4g6FIPabHxHJRgccp1c8FcVaewnMkcg_3Myvkhc7t-c
Message-ID: <CAJ2a_De+XFMA=VZr7AEXydozLyO0E0ggggb-Gq-h2TVWgYZsqw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 11/22] selinux: more strict policy parsing
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Eric Suen <ericsu@linux.microsoft.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Canfeng Guo <guocanfeng@uniontech.com>, 
	GUO Zihua <guozihua@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2025 at 04:00, Paul Moore <paul@paul-moore.com> wrote:
>
> On Dec 16, 2024 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgoettsc=
he@seltendoof.de> wrote:
> >
> > Be more strict during parsing of policies and reject invalid values.
> >
> > Add some error messages in the case of policy parse failures, to
> > enhance debugging, either on a malformed policy or a too strict check.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v2:
> >   accept unknown xperm specifiers to support backwards compatibility fo=
r
> >   future ones, suggested by Thi=C3=A9baud
> > ---
> >  security/selinux/ss/avtab.c       |  37 +++++--
> >  security/selinux/ss/conditional.c |  18 ++--
> >  security/selinux/ss/constraint.h  |   2 +-
> >  security/selinux/ss/policydb.c    | 157 ++++++++++++++++++++++++------
> >  security/selinux/ss/policydb.h    |  19 +++-
> >  security/selinux/ss/services.c    |   2 -
> >  6 files changed, 182 insertions(+), 53 deletions(-)
> >
> > diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> > index c2c31521cace..3bd949a200ef 100644
> > --- a/security/selinux/ss/avtab.c
> > +++ b/security/selinux/ss/avtab.c
> > @@ -349,7 +349,7 @@ int avtab_read_item(struct avtab *a, struct policy_=
file *fp, struct policydb *po
> >       struct avtab_extended_perms xperms;
> >       __le32 buf32[ARRAY_SIZE(xperms.perms.p)];
> >       int rc;
> > -     unsigned int set, vers =3D pol->policyvers;
> > +     unsigned int vers =3D pol->policyvers;
> >
> >       memset(&key, 0, sizeof(struct avtab_key));
> >       memset(&datum, 0, sizeof(struct avtab_datum));
> > @@ -361,8 +361,8 @@ int avtab_read_item(struct avtab *a, struct policy_=
file *fp, struct policydb *po
> >                       return rc;
> >               }
> >               items2 =3D le32_to_cpu(buf32[0]);
> > -             if (items2 > ARRAY_SIZE(buf32)) {
> > -                     pr_err("SELinux: avtab: entry overflow\n");
> > +             if (items2 < 5 || items2 > ARRAY_SIZE(buf32)) {
> > +                     pr_err("SELinux: avtab: invalid item count\n");
> >                       return -EINVAL;
> >               }
>
> A reminder that magic numbers are a bad thing, if we can't make it clear
> what the '5' in the conditional above represents by using a computed
> value, let's either use a #define with a helpful name or a comment to
> make this a bit more understandable.
>
> > @@ -444,9 +456,13 @@ int avtab_read_item(struct avtab *a, struct policy=
_file *fp, struct policydb *po
> >               return -EINVAL;
> >       }
> >
> > -     set =3D hweight16(key.specified & (AVTAB_XPERMS | AVTAB_TYPE | AV=
TAB_AV));
> > -     if (!set || set > 1) {
> > -             pr_err("SELinux:  avtab:  more than one specifier\n");
> > +     if (hweight16(key.specified & ~AVTAB_ENABLED) !=3D 1) {
> > +             pr_err("SELinux:  avtab:  not exactly one specifier\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (key.specified & ~(AVTAB_AV | AVTAB_TYPE | AVTAB_XPERMS | AVTA=
B_ENABLED)) {
> > +             pr_err("SELinux:  avtab:  invalid specifier\n");
> >               return -EINVAL;
> >       }
>
> Let's define a macro in avtab.h with all of the allowed avtab key
> values, otherwise I think people are going to forget about this check
> when adding a new flag and they are going to get frustrated :)
>
> > @@ -471,6 +487,15 @@ int avtab_read_item(struct avtab *a, struct policy=
_file *fp, struct policydb *po
> >                       pr_err("SELinux: avtab: truncated entry\n");
> >                       return rc;
> >               }
> > +             switch (xperms.specified) {
> > +             case AVTAB_XPERMS_IOCTLFUNCTION:
> > +             case AVTAB_XPERMS_IOCTLDRIVER:
> > +             case AVTAB_XPERMS_NLMSG:
> > +                     break;
> > +             default:
> > +                     pr_warn_once_policyload(pol, "SELinux: avtab: uns=
upported xperm specifier %#x\n",
> > +                                             xperms.specified);
> > +             }
>
> Similar to the avtab flags discussion above, can we create a small
> inline function in avtab.h that checks to see if an xperm is valid?
>
>   /* feel free to come up with a better name */
>   static inline bool avtab_xpermspec_valid(u8 specified)
>   {
>     if (specified =3D=3D AVTAB_XPERMS_IOCTLFUNCTION)
>       return true;
>     elif (...)
>       return true;
>
>     return false;
>   }
>
> > diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/con=
straint.h
> > index 203033cfad67..26ffdb8c1c29 100644
> > --- a/security/selinux/ss/constraint.h
> > +++ b/security/selinux/ss/constraint.h
> > @@ -50,7 +50,7 @@ struct constraint_expr {
> >       u32 op; /* operator */
> >
> >       struct ebitmap names; /* names */
> > -     struct type_set *type_names;
> > +     struct type_set *type_names; /* (unused) */
>
> If we're not using this field, let's remove it.  If for some odd reason
> we need to keep it here for size reasons, or something similar, let's
> turn it into a 'void *unused;' field.

This member (and the one later down this patch) is not used
internally, but forwarded to userspace via policydb_write() to
/sys/fs/selinux/policy.

>
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/polic=
ydb.c
> > index eeca470cc90c..1275fd7d9148 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -634,13 +634,11 @@ static int sens_index(void *key, void *datum, voi=
d *datap)
> >       levdatum =3D datum;
> >       p =3D datap;
> >
> > -     if (!levdatum->isalias) {
> > -             if (!levdatum->level.sens ||
> > -                 levdatum->level.sens > p->p_levels.nprim)
> > -                     return -EINVAL;
> > +     if (!levdatum->level.sens || levdatum->level.sens > p->p_levels.n=
prim)
> > +             return -EINVAL;
> >
> > +     if (!levdatum->isalias)
> >               p->sym_val_to_name[SYM_LEVELS][levdatum->level.sens - 1] =
=3D key;
> > -     }
> >
> >       return 0;
> >  }
>
> Hmm, I don't think the code above does the error checking in the same
> way, [...]

That is the point of this change: to also validate the sensitivities aliase=
s.

>
>   int sens_index(...)
>   {
>     if (isalias)
>       return 0;
>     if (!level->sens || level->send > levels.nprim)
>       return -EINVAL;
>     p =3D ...;
>     return 0;
>   }
>
> > @@ -653,12 +651,11 @@ static int cat_index(void *key, void *datum, void=
 *datap)
> >       catdatum =3D datum;
> >       p =3D datap;
> >
> > -     if (!catdatum->isalias) {
> > -             if (!catdatum->value || catdatum->value > p->p_cats.nprim=
)
> > -                     return -EINVAL;
> > +     if (!catdatum->value || catdatum->value > p->p_cats.nprim)
> > +             return -EINVAL;
> >
> > +     if (!catdatum->isalias)
> >               p->sym_val_to_name[SYM_CATS][catdatum->value - 1] =3D key=
;
> > -     }
> >
> >       return 0;
> >  }
>
> Similar to the sensitivity level comment above.
>
> > @@ -1136,6 +1133,9 @@ static int perm_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >
> >       len =3D le32_to_cpu(buf[0]);
> >       perdatum->value =3D le32_to_cpu(buf[1]);
> > +     rc =3D -EINVAL;
> > +     if (perdatum->value < 1 || perdatum->value > 32)
> > +             goto bad;
>
> More magic number problems.
>
> >       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> >       if (rc)
> > @@ -1170,6 +1170,9 @@ static int common_read(struct policydb *p, struct=
 symtab *s, struct policy_file
> >       len =3D le32_to_cpu(buf[0]);
> >       comdatum->value =3D le32_to_cpu(buf[1]);
> >       nel =3D le32_to_cpu(buf[3]);
> > +     rc =3D -EINVAL;
> > +     if (nel > 32)
> > +             goto bad;
>
> Magic number.
>
> >       rc =3D symtab_init(&comdatum->permissions, nel);
> >       if (rc)
> > @@ -1335,6 +1338,9 @@ static int class_read(struct policydb *p, struct =
symtab *s, struct policy_file *
> >       len =3D le32_to_cpu(buf[0]);
> >       len2 =3D le32_to_cpu(buf[1]);
> >       nel =3D le32_to_cpu(buf[4]);
> > +     rc =3D -EINVAL;
> > +     if (nel > 32)
> > +             goto bad;
>
> Again.
>
> > @@ -1527,7 +1578,7 @@ static int type_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >   * Read a MLS level structure from a policydb binary
> >   * representation file.
> >   */
> > -static int mls_read_level(struct mls_level *lp, struct policy_file *fp=
)
> > +static int mls_read_level(const struct policydb *p, struct mls_level *=
lp, struct policy_file *fp)
> >  {
> >       __le32 buf[1];
> >       int rc;
>
> Why is this here?  You don't use the @p parameter anywhere in this
> patch and it add some code churn in all of the callers.
>
> > @@ -1606,7 +1657,7 @@ static int sens_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >       struct level_datum *levdatum;
> >       int rc;
> >       __le32 buf[2];
> > -     u32 len;
> > +     u32 len, val;
> >
> >       levdatum =3D kzalloc(sizeof(*levdatum), GFP_KERNEL);
> >       if (!levdatum)
> > @@ -1617,13 +1668,17 @@ static int sens_read(struct policydb *p, struct=
 symtab *s, struct policy_file *f
> >               goto bad;
> >
> >       len =3D le32_to_cpu(buf[0]);
> > -     levdatum->isalias =3D le32_to_cpu(buf[1]);
> > +     val =3D le32_to_cpu(buf[1]);
> > +     rc =3D -EINVAL;
> > +     if (val !=3D 0 && val !=3D 1)
> > +             goto bad;
> > +     levdatum->isalias =3D val;
>
> Should we have a simple inline function to do the integer boolean check?
>
> Considering all the places we check for 0 and 1, it seems like it might
> be a bit cleaner, and would help with self-documenting.
>
> > @@ -2221,7 +2303,7 @@ static int genfs_read(struct policydb *p, struct =
policy_file *fp)
> >
> >                       rc =3D -EINVAL;
> >                       val =3D le32_to_cpu(buf[0]);
> > -                     if (val >=3D U16_MAX)
> > +                     if (val >=3D U16_MAX || (val !=3D 0 && !policydb_=
class_isvalid(p, val)))
> >                               goto out;
> >                       newc->v.sclass =3D val;
> >                       rc =3D context_read_and_validate(&newc->context[0=
], p,
>
> This should probably be in patch 10/22, yes?
>
> > @@ -110,15 +110,15 @@ struct role_allow {
> >  /* Type attributes */
> >  struct type_datum {
> >       u32 value; /* internal type value */
> > -     u32 bounds; /* boundary of type */
> > -     unsigned char primary; /* primary name? */
> > +     u32 bounds; /* boundary of type, 0 for none */
> > +     unsigned char primary; /* primary name? (unused) */
>
> See my previous comment about unused fields.
>
> >  #endif /* _SS_POLICYDB_H_ */
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 28c0bdf9fc9d..d5725c768d59 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -445,8 +445,6 @@ static int dump_masked_av_helper(void *k, void *d, =
void *args)
> >       struct perm_datum *pdatum =3D d;
> >       char **permission_names =3D args;
> >
> > -     BUG_ON(pdatum->value < 1 || pdatum->value > 32);
>
> Do we need to convert this to a if-then check that does the proper error
> handling, or is it already handled in the other changes in this patch?

perm_read() now performs this check at policyload time.

>
> --
> paul-moore.com
