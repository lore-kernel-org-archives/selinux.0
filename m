Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581419D09C;
	Wed, 14 May 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747252966; cv=none; b=Ctd5Ry3vU0Apwph8WLQeWEYXLy6+H8RNESM/t4NeW9d6HCiNjoSSn7bcxGBG+FlSpP48smMqk9OCO36cqEdKh/MYCzWubAFU6xoqw6mTPh6rJ1o2HPWNDa4PRjdWAEveiR8u2A8OfDYnNzktbd2FwSy8hMnPUIJcjib0PbyX7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747252966; c=relaxed/simple;
	bh=fXHcUp09W84b6ceO80Yhp9okuehpvbmdscf/TJrB1OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODldYzOlXZFjYHHY+zUMa70p4zMTpWoz8RBZyyOPa955+fCckHTOHQDbV9PF4aoCqZSAGGzzWT90UM1Di72LCS2agHQbAmxKK19shlnH9kVqinYfN3+TF0BheoNf6r2uvHW8LKI2jIZPxeSz3UJEXWBzgx5GRkqI9So3+BwI3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhtGJ9gW; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhtGJ9gW"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7ab544d798so193151276.3;
        Wed, 14 May 2025 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747252962; x=1747857762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkePA2YsWyCSvYxW13lqhUBuetBEVgart/4PozXQs7A=;
        b=fhtGJ9gWZ+8eH2mHfSl05pZTtaMtrXdJkTAxmGFtc5folI1bVE6+UJIXpZ3n1nxOz6
         SCsYuyNHWDuiLs7Zkr8oa6cstRUOYOm7YhgZkNIF5+w0lhcjOh7AyyaZ8hUPiujG0gA0
         6vmRtb+NIm0aaa1ks7TFVz46BgUGEj2eva8AaZIc7Y3DQHDQ1kuU248UQUGYKOhsRqfc
         5RQ2kSJ+ZgZ+V1RJhlY2YRURkJW+OEaofeFFMBCphInGklj3oCr9uioW6eF/Q4MBrrP5
         vpwDOUJmMZn8t2a+ZDwsqgP4GWLJsR84TW+vEALtezowyO1YXaeWfjUOGsyPqfL1N4IK
         FzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747252962; x=1747857762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkePA2YsWyCSvYxW13lqhUBuetBEVgart/4PozXQs7A=;
        b=EaZ2oque9Fi/XvSlnsq6HtqV6m6cRUVK/MpMKvYRgaCXIq/dhEXHsWdf8Vmu0hQ3X9
         dK8wLrHLBeMLEks8Doow3kqcY493BRmZnyK0zabf1TSilzBMjjv/4FQBa/lYpbbDgxqU
         Fjds8XsmK9FQlvvJQGuTkiutduZMTE0b3zdiLqVwBQdMa9RKeV1hon0VkCEXYd20BGmq
         TxrIx1gHhW6J+MS9ULvssZ3++/4zFxlb1CYcSZNMZbykJiWGgk3LsTb9dbJwFYQklkzg
         tWuC3Th9D0pRk+oWf3Y3mC3vAPVRmr/9UdOIyvvSbOwe5aINoB59Gu2SUWOlxmst6yqQ
         89Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUPkBx5/j4uuDwcP0XSVg4gNCq6fXJAh52lrYMA6w8l8dngPlES88aS2Xt5x+5H6W1z+6jR9aY3mg==@vger.kernel.org, AJvYcCVJvWdnPUvqbLvuhvUf8AwLIHriDbmvS0ur1Qn6HD9odYNTHXqchXvXW9nmOGTu07mLDSkb0dyG6VPMd4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqglAoGt5lxH/8kcyOfWNgX0t9qoD2X+KoO6GpAk7Mpyh64iNP
	Bm099u+SBi367vdrnBIW6xNwdlu/iJW3ywhOUczoOAcGccJ8EFUZ97tnUwzyLF+186MALYfi7P8
	S+lepxh++tX5IOHUKX6zlUxubVvZ5Iw==
X-Gm-Gg: ASbGnct51d9kEQzBSGzq1w0LsRb/X6eUBg0ci6pBGICjJ/jFtVp/2VArY3G3wsDzp3N
	DwfZsDCFfuw8ZyjwF1B5WH4TjZcKwIHak8SqNsXn7vo8ZDhFoJehXaLbcKxbvNdqQInjRnCSOMf
	3n+nRDpTjoXAWJCImgXq519UE0GRNy0B4V
X-Google-Smtp-Source: AGHT+IFQN2Rr2Entm7FhQ8KLKw4t9yyCAyfxbmePA6VyEPH1amYXj1dJbieW064c+QhbKjRkMZWR8lwR36wYG78QMLs=
X-Received: by 2002:a05:6102:8082:b0:4c1:93df:e838 with SMTP id
 ada2fe7eead31-4df7ddef336mr4725124137.23.1747252951175; Wed, 14 May 2025
 13:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de>
 <20250511173055.406906-13-cgoettsche@seltendoof.de> <CAEjxPJ6PbCy6u1+3fnqXkxmEPtY3XadAT-csk-+eTmjLnfNFVg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6PbCy6u1+3fnqXkxmEPtY3XadAT-csk-+eTmjLnfNFVg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 14 May 2025 16:02:19 -0400
X-Gm-Features: AX0GCFuT2_-Fc1ONsaXgNq0rSBhNCBwozgnvQOJOsJd_3h7gZTVWyOZsivCru2Y
Message-ID: <CAP+JOzQpWav+a-DmA3Sh22JAPHmX0U9HMvNqpW-LU9sGj-9dbA@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] selinux: restrict policy strings
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 3:40=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Validate the characters and the lengths of strings parsed from binary
> > policies.
> >
> >   * Disallow control characters
> >   * Limit characters of identifiers to alphanumeric, underscore, dash,
> >     and dot
> >   * Limit identifiers in length to 64, expect types to 1024,
> >     sensitivities to 32 and categories to 16, characters
> >     (excluding NUL-terminator)
>
> (added James Carter to explicit cc for comparison with any
> userspace-imposed restrictions)
>
> I think we could easily go lower than 1024 characters for type names.
>

CIL has a limit of 2,048 for identifiers. Checkpolicy has a limit of 8,192.
We definitely could have lower limits. I think that I would rather
have one limit rather than a bunch of different limits, but it
wouldn't be too hard to do different limits if there is a good reason
to do that.
Even a limit of 256 would seem to be sufficient (at least until AI takes ov=
er).
Jim

> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v3:
> >   - introduce a central limits.h header
> >   - add limits for all kinds of string: filesystem names, filetrans
> >     keys, genfs paths, infiniband device names
> > v2:
> >   - add wrappers for str_read() to minimize the usage of magic numbers
> >   - limit sensitivities to a length of 32, to match categories,
> >     suggested by Daniel
> > ---
> >  security/selinux/include/limits.h | 90 +++++++++++++++++++++++++++++++
> >  security/selinux/ss/conditional.c |  5 +-
> >  security/selinux/ss/conditional.h |  2 -
> >  security/selinux/ss/constraint.h  |  2 -
> >  security/selinux/ss/policydb.c    | 78 ++++++++++++++++++---------
> >  security/selinux/ss/policydb.h    | 51 +++++++++++++++++-
> >  6 files changed, 196 insertions(+), 32 deletions(-)
> >  create mode 100644 security/selinux/include/limits.h
> >
> > diff --git a/security/selinux/include/limits.h b/security/selinux/inclu=
de/limits.h
> > new file mode 100644
> > index 000000000000..d267c0c64f49
> > --- /dev/null
> > +++ b/security/selinux/include/limits.h
> > @@ -0,0 +1,90 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Limits for various policy database elements.
> > + */
> > +
> > +/*
> > + * Maximum supported depth of conditional expressions.
> > + */
> > +#define COND_EXPR_MAXDEPTH 10
> > +
> > +/*
> > + * Maximum supported depth for constraint expressions.
> > + */
> > +#define CEXPR_MAXDEPTH 5
> > +
> > +/*
> > + * Maximum supported identifier value.
> > + *
> > + * Reasoning: The most used symbols are types and they need to fit int=
o
> > + *            an u16 for the avtab entries. Keep U16_MAX as special va=
lue
> > + *            and U16_MAX-1 to avoid accidental overflows into U16_MAX=
.
>
> This seems rather arbitrary and unnecessary to me? Unless userspace
> does the same?
>
> > + */
> > +#define IDENTIFIER_MAXVALUE (U16_MAX - 2)
> > +
> > +/*
> > + * Maximum supported length of security context strings.
> > + *
> > + * Reasoning: The string must fir into a PAGE_SIZE.
>
> s/fir/fit/
> s/into a/under/
>
> > + */
> > +#define CONTEXT_MAXLENGTH 4000
>
> Any particular reason to not just make it PAGE_SIZE then?
>
> > +
> > +/*
> > + * Maximum supported boolean name length.
> > + */
> > +#define BOOLEAN_NAME_MAXLENGTH 64
> > +
> > +/*
> > + * Maximum supported security class and common class name length.
> > + */
> > +#define CLASS_NAME_MAXLENGTH 64
> > +
> > +/*
> > + * Maximum supported permission name length.
> > + */
> > +#define PERMISSION_NAME_MAXLENGTH 64
> > +
> > +/*
> > + * Maximum supported user name length.
> > + */
> > +#define USER_NAME_MAXLENGTH 64
> > +
> > +/*
> > + * Maximum supported role name length.
> > + */
> > +#define ROLE_NAME_MAXLENGTH 64
> > +
> > +/*
> > + * Maximum supported type name length.
> > + */
> > +#define TYPE_NAME_MAXLENGTH 1024
>
> Would advocate for a lower limit unless we know of a policy that would
> exceed it.
>
> > +
> > +/*
> > + * Maximum supported sensitivity name length.
> > + */
> > +#define SENSITIVITY_NAME_MAXLENGTH 32
> > +
> > +/*
> > + * Maximum supported category name length.
> > + */
> > +#define CATEGORY_NAME_MAXLENGTH 16
> > +
> > +/*
> > + * Maximum supported path name length for keys in filename transitions=
.
> > + */
> > +#define FILETRANSKEY_NAME_MAXLENGTH 1024
>
> These are component names only, right, not multi-component pathnames?
> In that case open to lower limit or using something defined by fs layer.
>
> > +
> > +/*
> > + * Maximum supported filesystem name length.
>
> s/filesystem/filesystem type/
>
> > + */
> > +#define FILESYSTEM_NAME_MAXLENGTH 128
>
> If we can find a limit imposed by the kernel elsewhere for fstype
> names, we should just reuse that.
>
> > +
> > +/*
> > + * Maximum supported path prefix length for genfs statements.
> > + */
> > +#define GENFS_PATH_MAXLENGTH 1024
>
> Should just use PATH_MAX or similar definition from elsewhere.
>
> > +
> > +/*
> > + * Maximum supported Infiniband device name length.
> > + */
> > +#define INFINIBAND_DEVNAME_MAXLENGTH 256
>
> Would use a limit from infiniband subsystem if one exists.
>
> > diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/co=
nditional.c
> > index ce0281cce739..c0a2814dafdb 100644
> > --- a/security/selinux/ss/conditional.c
> > +++ b/security/selinux/ss/conditional.c
> > @@ -245,7 +245,8 @@ int cond_index_bool(void *key, void *datum, void *d=
atap)
> >         booldatum =3D datum;
> >         p =3D datap;
> >
> > -       if (!booldatum->value || booldatum->value > p->p_bools.nprim)
> > +       if (!booldatum->value || booldatum->value > p->p_bools.nprim ||
> > +           booldatum->value > IDENTIFIER_MAXVALUE)
> >                 return -EINVAL;
> >
> >         p->sym_val_to_name[SYM_BOOLS][booldatum->value - 1] =3D key;
> > @@ -280,7 +281,7 @@ int cond_read_bool(struct policydb *p, struct symta=
b *s, struct policy_file *fp)
> >
> >         len =3D le32_to_cpu(buf[2]);
> >
> > -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +       rc =3D str_read_bool(&key, GFP_KERNEL, fp, len);
> >         if (rc)
> >                 goto err;
> >
> > diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/co=
nditional.h
> > index 468e98ad3ea1..d5aefcbaa1eb 100644
> > --- a/security/selinux/ss/conditional.h
> > +++ b/security/selinux/ss/conditional.h
> > @@ -12,8 +12,6 @@
> >  #include "policydb.h"
> >  #include "../include/conditional.h"
> >
> > -#define COND_EXPR_MAXDEPTH 10
> > -
> >  /*
> >   * A conditional expression is a list of operators and operands
> >   * in reverse polish notation.
> > diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/con=
straint.h
> > index 1d75a8a044df..f986156de856 100644
> > --- a/security/selinux/ss/constraint.h
> > +++ b/security/selinux/ss/constraint.h
> > @@ -19,8 +19,6 @@
> >
> >  #include "ebitmap.h"
> >
> > -#define CEXPR_MAXDEPTH 5
> > -
> >  struct constraint_expr {
> >  #define CEXPR_NOT   1 /* not expr */
> >  #define CEXPR_AND   2 /* expr and expr */
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/polic=
ydb.c
> > index 2b098d9abf17..e64254985762 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -552,7 +552,8 @@ static int common_index(void *key, void *datum, voi=
d *datap)
> >
> >         comdatum =3D datum;
> >         p =3D datap;
> > -       if (!comdatum->value || comdatum->value > p->p_commons.nprim)
> > +       if (!comdatum->value || comdatum->value > p->p_commons.nprim ||
> > +           comdatum->value > IDENTIFIER_MAXVALUE)
> >                 return -EINVAL;
> >
> >         p->sym_val_to_name[SYM_COMMONS][comdatum->value - 1] =3D key;
> > @@ -567,7 +568,8 @@ static int class_index(void *key, void *datum, void=
 *datap)
> >
> >         cladatum =3D datum;
> >         p =3D datap;
> > -       if (!cladatum->value || cladatum->value > p->p_classes.nprim)
> > +       if (!cladatum->value || cladatum->value > p->p_classes.nprim ||
> > +           cladatum->value > IDENTIFIER_MAXVALUE)
> >                 return -EINVAL;
> >
> >         p->sym_val_to_name[SYM_CLASSES][cladatum->value - 1] =3D key;
> > @@ -583,6 +585,7 @@ static int role_index(void *key, void *datum, void =
*datap)
> >         role =3D datum;
> >         p =3D datap;
> >         if (!role->value || role->value > p->p_roles.nprim ||
> > +           role->value > IDENTIFIER_MAXVALUE ||
> >             role->bounds > p->p_roles.nprim)
> >                 return -EINVAL;
> >
> > @@ -601,6 +604,7 @@ static int type_index(void *key, void *datum, void =
*datap)
> >
> >         if (typdatum->primary) {
> >                 if (!typdatum->value || typdatum->value > p->p_types.np=
rim ||
> > +                   typdatum->value > IDENTIFIER_MAXVALUE ||
> >                     typdatum->bounds > p->p_types.nprim)
> >                         return -EINVAL;
> >                 p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] =3D =
key;
> > @@ -618,6 +622,7 @@ static int user_index(void *key, void *datum, void =
*datap)
> >         usrdatum =3D datum;
> >         p =3D datap;
> >         if (!usrdatum->value || usrdatum->value > p->p_users.nprim ||
> > +           usrdatum->value > IDENTIFIER_MAXVALUE ||
> >             usrdatum->bounds > p->p_users.nprim)
> >                 return -EINVAL;
> >
> > @@ -634,7 +639,8 @@ static int sens_index(void *key, void *datum, void =
*datap)
> >         levdatum =3D datum;
> >         p =3D datap;
> >
> > -       if (!levdatum->level.sens || levdatum->level.sens > p->p_levels=
.nprim)
> > +       if (!levdatum->level.sens || levdatum->level.sens > p->p_levels=
.nprim ||
> > +           levdatum->level.sens > IDENTIFIER_MAXVALUE)
> >                 return -EINVAL;
> >
> >         if (!levdatum->isalias)
> > @@ -651,7 +657,8 @@ static int cat_index(void *key, void *datum, void *=
datap)
> >         catdatum =3D datum;
> >         p =3D datap;
> >
> > -       if (!catdatum->value || catdatum->value > p->p_cats.nprim)
> > +       if (!catdatum->value || catdatum->value > p->p_cats.nprim ||
> > +           catdatum->value > IDENTIFIER_MAXVALUE)
> >                 return -EINVAL;
> >
> >         if (!catdatum->isalias)
> > @@ -1226,8 +1233,9 @@ static int context_read_and_validate(struct conte=
xt *c, struct policydb *p,
> >   * binary representation file.
> >   */
> >
> > -int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len=
)
> > +int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len=
, int kind, u32 max_len)
> >  {
> > +       u32 i;
> >         int rc;
> >         char *str;
> >
> > @@ -1237,19 +1245,35 @@ int str_read(char **strp, gfp_t flags, struct p=
olicy_file *fp, u32 len)
> >         if (size_check(sizeof(char), len, fp))
> >                 return -EINVAL;
> >
> > +       if (len > max_len)
> > +               return -EINVAL;
> > +
> >         str =3D kmalloc(len + 1, flags | __GFP_NOWARN);
> >         if (!str)
> >                 return -ENOMEM;
> >
> >         rc =3D next_entry(str, fp, len);
> > -       if (rc) {
> > -               kfree(str);
> > -               return rc;
> > +       if (rc)
> > +               goto bad_str;
> > +
> > +       rc =3D -EINVAL;
> > +       for (i =3D 0; i < len; i++) {
> > +               if (iscntrl(str[i]))
> > +                       goto bad_str;
> > +
> > +               if (kind =3D=3D STR_IDENTIFIER &&
> > +                   !(isalnum(str[i]) || str[i] =3D=3D '_' || str[i] =
=3D=3D '-' || str[i] =3D=3D '.'))
> > +                       goto bad_str;
> > +
> >         }
> >
> >         str[len] =3D '\0';
> >         *strp =3D str;
> >         return 0;
> > +
> > +bad_str:
> > +       kfree(str);
> > +       return rc;
> >  }
> >
> >  static int perm_read(struct policydb *p, struct symtab *s, struct poli=
cy_file *fp)
> > @@ -1274,7 +1298,7 @@ static int perm_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >         if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
> >                 goto bad;
> >
> > -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +       rc =3D str_read_perm(&key, GFP_KERNEL, fp, len);
> >         if (rc)
> >                 goto bad;
> >
> > @@ -1321,7 +1345,7 @@ static int common_read(struct policydb *p, struct=
 symtab *s, struct policy_file
> >                 goto bad;
> >         comdatum->permissions.nprim =3D le32_to_cpu(buf[2]);
> >
> > -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +       rc =3D str_read_class(&key, GFP_KERNEL, fp, len);
> >         if (rc)
> >                 goto bad;
> >
> > @@ -1559,12 +1583,12 @@ static int class_read(struct policydb *p, struc=
t symtab *s, struct policy_file *
> >
> >         ncons =3D le32_to_cpu(buf[5]);
> >
> > -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +       rc =3D str_read_class(&key, GFP_KERNEL, fp, len);
> >         if (rc)
> >                 goto bad;
> >
> >         if (len2) {
> > -               rc =3D str_read(&cladatum->comkey, GFP_KERNEL, fp, len2=
);
> > +               rc =3D str_read_class(&cladatum->comkey, GFP_KERNEL, fp=
, len2);
> >                 if (rc)
> >                         goto bad;
> >
> > @@ -1698,7 +1722,7 @@ static int role_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >         if (p->policyvers >=3D POLICYDB_VERSION_BOUNDARY)
> >                 role->bounds =3D le32_to_cpu(buf[2]);
> >
> > -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +       rc =3D str_read_role(&key, GFP_KERNEL, fp, len);
> >         if (rc)
> >                 goto bad;
> >
> > @@ -1765,7 +1789,7 @@ static int type_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >                 typdatum->primary =3D le32_to_cpu(buf[2]);
> >         }
> >
> > -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +       rc =3D str_read_type(&key, GFP_KERNEL, fp, len);
> >         if (rc)
> >                 goto bad;
> >
> > @@ -1829,7 +1853,7 @@ static int user_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >         if (p->policyvers >=3D POLICYDB_VERSION_BOUNDARY)
> >                 usrdatum->bounds =3D le32_to_cpu(buf[2]);
> >
> > -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +       rc =3D str_read_user(&key, GFP_KERNEL, fp, len);
> >         if (rc)
> >                 goto bad;
> >
> > @@ -1878,7 +1902,7 @@ static int sens_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *f
> >                 goto bad;
> >         levdatum->isalias =3D val;
> >
> > -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +       rc =3D str_read_sens(&key, GFP_KERNEL, fp, len);
> >         if (rc)
> >                 goto bad;
> >
> > @@ -1921,7 +1945,7 @@ static int cat_read(struct policydb *p, struct sy=
mtab *s, struct policy_file *fp
> >                 goto bad;
> >         catdatum->isalias =3D val;
> >
> > -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> > +       rc =3D str_read_cat(&key, GFP_KERNEL, fp, len);
> >         if (rc)
> >                 goto bad;
> >
> > @@ -2230,7 +2254,7 @@ static int filename_trans_read_helper_compat(stru=
ct policydb *p, struct policy_f
> >         len =3D le32_to_cpu(buf[0]);
> >
> >         /* path component string */
> > -       rc =3D str_read(&name, GFP_KERNEL, fp, len);
> > +       rc =3D str_read(&name, GFP_KERNEL, fp, len, STR_UNCONSTRAINT, F=
ILETRANSKEY_NAME_MAXLENGTH);
> >         if (rc)
> >                 return rc;
> >
> > @@ -2329,7 +2353,7 @@ static int filename_trans_read_helper(struct poli=
cydb *p, struct policy_file *fp
> >         len =3D le32_to_cpu(buf[0]);
> >
> >         /* path component string */
> > -       rc =3D str_read(&name, GFP_KERNEL, fp, len);
> > +       rc =3D str_read(&name, GFP_KERNEL, fp, len, STR_UNCONSTRAINT, F=
ILETRANSKEY_NAME_MAXLENGTH);
> >         if (rc)
> >                 return rc;
> >
> > @@ -2483,7 +2507,7 @@ static int genfs_read(struct policydb *p, struct =
policy_file *fp)
> >                 if (!newgenfs)
> >                         goto out;
> >
> > -               rc =3D str_read(&newgenfs->fstype, GFP_KERNEL, fp, len)=
;
> > +               rc =3D str_read_fsname(&newgenfs->fstype, GFP_KERNEL, f=
p, len);
> >                 if (rc)
> >                         goto out;
> >
> > @@ -2522,7 +2546,8 @@ static int genfs_read(struct policydb *p, struct =
policy_file *fp)
> >                         if (!newc)
> >                                 goto out;
> >
> > -                       rc =3D str_read(&newc->u.name, GFP_KERNEL, fp, =
len);
> > +                       rc =3D str_read(&newc->u.name, GFP_KERNEL, fp, =
len,
> > +                                     STR_UNCONSTRAINT, GENFS_PATH_MAXL=
ENGTH);
> >                         if (rc)
> >                                 goto out;
> >
> > @@ -2625,7 +2650,7 @@ static int ocontext_read(struct policydb *p,
> >                                         goto out;
> >                                 len =3D le32_to_cpu(buf[0]);
> >
> > -                               rc =3D str_read(&c->u.name, GFP_KERNEL,=
 fp, len);
> > +                               rc =3D str_read_fsname(&c->u.name, GFP_=
KERNEL, fp, len);
> >                                 if (rc)
> >                                         goto out;
> >
> > @@ -2693,7 +2718,7 @@ static int ocontext_read(struct policydb *p,
> >                                         goto out;
> >
> >                                 len =3D le32_to_cpu(buf[1]);
> > -                               rc =3D str_read(&c->u.name, GFP_KERNEL,=
 fp, len);
> > +                               rc =3D str_read_fsname(&c->u.name, GFP_=
KERNEL, fp, len);
> >                                 if (rc)
> >                                         goto out;
> >
> > @@ -2759,7 +2784,9 @@ static int ocontext_read(struct policydb *p,
> >                                 len =3D le32_to_cpu(buf[0]);
> >
> >                                 rc =3D str_read(&c->u.ibendport.dev_nam=
e,
> > -                                             GFP_KERNEL, fp, len);
> > +                                             GFP_KERNEL, fp, len,
> > +                                             STR_UNCONSTRAINT,
> > +                                             INFINIBAND_DEVNAME_MAXLEN=
GTH);
> >                                 if (rc)
> >                                         goto out;
> >
> > @@ -2827,7 +2854,8 @@ int policydb_read(struct policydb *p, struct poli=
cy_file *fp)
> >                 goto bad;
> >         }
> >
> > -       rc =3D str_read(&policydb_str, GFP_KERNEL, fp, len);
> > +       rc =3D str_read(&policydb_str, GFP_KERNEL, fp, len,
> > +                     STR_UNCONSTRAINT, strlen(POLICYDB_STRING));
> >         if (rc) {
> >                 if (rc =3D=3D -ENOMEM) {
> >                         pr_err("SELinux:  unable to allocate memory for=
 policydb string of length %d\n",
> > diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/polic=
ydb.h
> > index b4f0c1a754cf..e901ec648cbf 100644
> > --- a/security/selinux/ss/policydb.h
> > +++ b/security/selinux/ss/policydb.h
> > @@ -27,6 +27,7 @@
> >  #include "mls_types.h"
> >  #include "context.h"
> >  #include "constraint.h"
> > +#include "limits.h"
> >
> >  /*
> >   * A datum type is defined for each kind of symbol
> > @@ -408,7 +409,55 @@ static inline bool val_is_boolean(u32 value)
> >         return value =3D=3D 0 || value =3D=3D 1;
> >  }
> >
> > -extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, =
u32 len);
> > +#define STR_UNCONSTRAINT 0
> > +#define STR_IDENTIFIER 1
> > +extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, =
u32 len,
> > +                   int kind, u32 max_len);
> > +
> > +static inline int str_read_bool(char **strp, gfp_t flags, struct polic=
y_file *fp, u32 len)
> > +{
> > +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, BOOLEAN_N=
AME_MAXLENGTH);
> > +}
> > +
> > +static inline int str_read_cat(char **strp, gfp_t flags, struct policy=
_file *fp, u32 len)
> > +{
> > +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, CATEGORY_=
NAME_MAXLENGTH);
> > +}
> > +
> > +static inline int str_read_class(char **strp, gfp_t flags, struct poli=
cy_file *fp, u32 len)
> > +{
> > +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, CLASS_NAM=
E_MAXLENGTH);
> > +}
> > +
> > +static inline int str_read_perm(char **strp, gfp_t flags, struct polic=
y_file *fp, u32 len)
> > +{
> > +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, PERMISSIO=
N_NAME_MAXLENGTH);
> > +}
> > +
> > +static inline int str_read_role(char **strp, gfp_t flags, struct polic=
y_file *fp, u32 len)
> > +{
> > +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, ROLE_NAME=
_MAXLENGTH);
> > +}
> > +
> > +static inline int str_read_sens(char **strp, gfp_t flags, struct polic=
y_file *fp, u32 len)
> > +{
> > +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, SENSITIVI=
TY_NAME_MAXLENGTH);
> > +}
> > +
> > +static inline int str_read_type(char **strp, gfp_t flags, struct polic=
y_file *fp, u32 len)
> > +{
> > +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, TYPE_NAME=
_MAXLENGTH);
> > +}
> > +
> > +static inline int str_read_user(char **strp, gfp_t flags, struct polic=
y_file *fp, u32 len)
> > +{
> > +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, USER_NAME=
_MAXLENGTH);
> > +}
> > +
> > +static inline int str_read_fsname(char **strp, gfp_t flags, struct pol=
icy_file *fp, u32 len)
> > +{
> > +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, FILESYSTE=
M_NAME_MAXLENGTH);
> > +}
> >
> >  extern u16 string_to_security_class(struct policydb *p, const char *na=
me);
> >  extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const cha=
r *name);
> > --
> > 2.49.0
> >
