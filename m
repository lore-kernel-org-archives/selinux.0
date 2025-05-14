Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2815278E;
	Wed, 14 May 2025 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251647; cv=none; b=pKIcXcRcZp0pz3Nfl5yov2a+K7sGu+RHjM3vBHbYsNAvf9Wg59sOvrgWzhOCCYhawa20hi4W1egsmdxQn/QqeIWIF3ZPvk/qT0H7nzSsf9gyw/2hmJVRF1dTFonzrlqCHxqIdnO/mj5f30klMC3/puSkJJjXYyP0RXNvFjHiSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251647; c=relaxed/simple;
	bh=0LSFEiBVicpTGKfKhTXVeP1f6NNg9Pt7ZLzw1Y3ChvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQmya+v6z5CkJks4p27n7cs1wijpxe5EYBnzoNXWwNgkxMFwc8bADNm85lSOeBQxYppY7drg8fIyUnq4AVy4dQZCWs3tVLk5A88sZmVZgelDDZeYfGeWS6UNIp4g7Yq3GYsApZL4bNjRbgem4msaO2H07DTr/uikgTdlTbTZbY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcDDZo5X; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcDDZo5X"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30c54b40112so188447a91.2;
        Wed, 14 May 2025 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747251642; x=1747856442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jov0NzE83tU2+TpN1MGZpdxxagVZ2ggyga7FPdDYaE=;
        b=TcDDZo5X2vNt/XmZF6PNBwS3b+ntoL2ibRC4DzVXIQixon5hDZfiUMfPZY4n58XdyK
         WStBbxKnbvjfwZHsnTkHJCJJYFxP6HciQfEhA9q17TKxvTeEwm/SqcyS1fcrttYby/g6
         bSD+GFGVmhA6EEFcFQTX1sBXYybLXXdmYwX9AtwQXz0qycsygBjGPqXCJZ/qNj7skRyN
         FX7S060O55jRxOAzPYoe3cGjHrKSsJqhYPHxV5wg2kReCS1IqwnduWu0uYuhnJhkdeeB
         +iGM1rRagOK50BQvuXRE5DY7/FyZPP2hr0r288uQ3BKgWEcWu7GDOUOAHV8o8YpM1Qfx
         JGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747251642; x=1747856442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jov0NzE83tU2+TpN1MGZpdxxagVZ2ggyga7FPdDYaE=;
        b=OHq3RxuzbCbcnFAq985zpUn2Wo+5fzm7NKVFrmNlq7hPA92f+MH6CwWryTr9HTsP5m
         Y1qnBS2wYuumdNxhYVwFGsfe+nu3JBUu3zudIkCpyv8+nrb90EJ5DnEjLa2QZl2FUTJp
         Zep2IeFdMCieri8+sn6Q1jxi5Oas134na8exxe/sYCVOSLzrrtvOnD/7W0AINJzeufOy
         GglZwUfKBHRkiyYfnsOA8dHsUeTOgnZOy69/1LMlw0hIXxh2PBDnKu836lwSRloSQjcZ
         5Ft7zHi98KV/CR4jmxa4YBh6FdayQueWDlr6c9xgirmA1UkMBQM7vXEQ6t5MvORnJEpI
         Ermg==
X-Forwarded-Encrypted: i=1; AJvYcCUaIJygswdLjV3AWoM35krfd55LQiEppNMF+ESNtPqSLBHlY5bRuCEOh86hKrOsJWdZfRvjq8rL9VmH6GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyuTsF29mdRzMmTuJTnBuuwjyGb2uuk28ogrvapwNm0rvMmhye
	hTWLYdwvC0Lxkahm5bzvi/dKUZlNzpbQR1bvFxzE7ELssAPX7DI0Nty/kFRnWYs8WfvjKPuQ1uj
	Xnzqfdj02xYRpnz9OetpxiGkHK6A=
X-Gm-Gg: ASbGnctaDYY810jvDve0KH98gizyrIU8sQeJFiPbwLFueoZJ39S0fVl2fnq4KIE3YZG
	IRWW2kENlD3djRZMD+jzh9JQHLeSd9o46VBZFBgppVsP+FEv8xMyzR0ine9WyHJlKbgIisFDEc0
	pNClpwAI5OBU8GLGD0iMpY/gk1ppLhDBvs
X-Google-Smtp-Source: AGHT+IHl0gaItrxM/99mteLL7vBbCWn2Y0ybn8GHEF8Eonk2MsljjAlxWf4H7wK2d+CUDDAssP/aeaeElQCvFPIX1kQ=
X-Received: by 2002:a17:90b:4e87:b0:303:75a7:26a4 with SMTP id
 98e67ed59e1d1-30e2e5d6105mr7597234a91.7.1747251642270; Wed, 14 May 2025
 12:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-13-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-13-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 May 2025 15:40:31 -0400
X-Gm-Features: AX0GCFt8Gh_LqDAuW9dimznklV68czDJFn7Yeh2v9J64V89mxmXwRWUk5ZxNns0
Message-ID: <CAEjxPJ6PbCy6u1+3fnqXkxmEPtY3XadAT-csk-+eTmjLnfNFVg@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] selinux: restrict policy strings
To: cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Validate the characters and the lengths of strings parsed from binary
> policies.
>
>   * Disallow control characters
>   * Limit characters of identifiers to alphanumeric, underscore, dash,
>     and dot
>   * Limit identifiers in length to 64, expect types to 1024,
>     sensitivities to 32 and categories to 16, characters
>     (excluding NUL-terminator)

(added James Carter to explicit cc for comparison with any
userspace-imposed restrictions)

I think we could easily go lower than 1024 characters for type names.

>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v3:
>   - introduce a central limits.h header
>   - add limits for all kinds of string: filesystem names, filetrans
>     keys, genfs paths, infiniband device names
> v2:
>   - add wrappers for str_read() to minimize the usage of magic numbers
>   - limit sensitivities to a length of 32, to match categories,
>     suggested by Daniel
> ---
>  security/selinux/include/limits.h | 90 +++++++++++++++++++++++++++++++
>  security/selinux/ss/conditional.c |  5 +-
>  security/selinux/ss/conditional.h |  2 -
>  security/selinux/ss/constraint.h  |  2 -
>  security/selinux/ss/policydb.c    | 78 ++++++++++++++++++---------
>  security/selinux/ss/policydb.h    | 51 +++++++++++++++++-
>  6 files changed, 196 insertions(+), 32 deletions(-)
>  create mode 100644 security/selinux/include/limits.h
>
> diff --git a/security/selinux/include/limits.h b/security/selinux/include=
/limits.h
> new file mode 100644
> index 000000000000..d267c0c64f49
> --- /dev/null
> +++ b/security/selinux/include/limits.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Limits for various policy database elements.
> + */
> +
> +/*
> + * Maximum supported depth of conditional expressions.
> + */
> +#define COND_EXPR_MAXDEPTH 10
> +
> +/*
> + * Maximum supported depth for constraint expressions.
> + */
> +#define CEXPR_MAXDEPTH 5
> +
> +/*
> + * Maximum supported identifier value.
> + *
> + * Reasoning: The most used symbols are types and they need to fit into
> + *            an u16 for the avtab entries. Keep U16_MAX as special valu=
e
> + *            and U16_MAX-1 to avoid accidental overflows into U16_MAX.

This seems rather arbitrary and unnecessary to me? Unless userspace
does the same?

> + */
> +#define IDENTIFIER_MAXVALUE (U16_MAX - 2)
> +
> +/*
> + * Maximum supported length of security context strings.
> + *
> + * Reasoning: The string must fir into a PAGE_SIZE.

s/fir/fit/
s/into a/under/

> + */
> +#define CONTEXT_MAXLENGTH 4000

Any particular reason to not just make it PAGE_SIZE then?

> +
> +/*
> + * Maximum supported boolean name length.
> + */
> +#define BOOLEAN_NAME_MAXLENGTH 64
> +
> +/*
> + * Maximum supported security class and common class name length.
> + */
> +#define CLASS_NAME_MAXLENGTH 64
> +
> +/*
> + * Maximum supported permission name length.
> + */
> +#define PERMISSION_NAME_MAXLENGTH 64
> +
> +/*
> + * Maximum supported user name length.
> + */
> +#define USER_NAME_MAXLENGTH 64
> +
> +/*
> + * Maximum supported role name length.
> + */
> +#define ROLE_NAME_MAXLENGTH 64
> +
> +/*
> + * Maximum supported type name length.
> + */
> +#define TYPE_NAME_MAXLENGTH 1024

Would advocate for a lower limit unless we know of a policy that would
exceed it.

> +
> +/*
> + * Maximum supported sensitivity name length.
> + */
> +#define SENSITIVITY_NAME_MAXLENGTH 32
> +
> +/*
> + * Maximum supported category name length.
> + */
> +#define CATEGORY_NAME_MAXLENGTH 16
> +
> +/*
> + * Maximum supported path name length for keys in filename transitions.
> + */
> +#define FILETRANSKEY_NAME_MAXLENGTH 1024

These are component names only, right, not multi-component pathnames?
In that case open to lower limit or using something defined by fs layer.

> +
> +/*
> + * Maximum supported filesystem name length.

s/filesystem/filesystem type/

> + */
> +#define FILESYSTEM_NAME_MAXLENGTH 128

If we can find a limit imposed by the kernel elsewhere for fstype
names, we should just reuse that.

> +
> +/*
> + * Maximum supported path prefix length for genfs statements.
> + */
> +#define GENFS_PATH_MAXLENGTH 1024

Should just use PATH_MAX or similar definition from elsewhere.

> +
> +/*
> + * Maximum supported Infiniband device name length.
> + */
> +#define INFINIBAND_DEVNAME_MAXLENGTH 256

Would use a limit from infiniband subsystem if one exists.

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/cond=
itional.c
> index ce0281cce739..c0a2814dafdb 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -245,7 +245,8 @@ int cond_index_bool(void *key, void *datum, void *dat=
ap)
>         booldatum =3D datum;
>         p =3D datap;
>
> -       if (!booldatum->value || booldatum->value > p->p_bools.nprim)
> +       if (!booldatum->value || booldatum->value > p->p_bools.nprim ||
> +           booldatum->value > IDENTIFIER_MAXVALUE)
>                 return -EINVAL;
>
>         p->sym_val_to_name[SYM_BOOLS][booldatum->value - 1] =3D key;
> @@ -280,7 +281,7 @@ int cond_read_bool(struct policydb *p, struct symtab =
*s, struct policy_file *fp)
>
>         len =3D le32_to_cpu(buf[2]);
>
> -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> +       rc =3D str_read_bool(&key, GFP_KERNEL, fp, len);
>         if (rc)
>                 goto err;
>
> diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/cond=
itional.h
> index 468e98ad3ea1..d5aefcbaa1eb 100644
> --- a/security/selinux/ss/conditional.h
> +++ b/security/selinux/ss/conditional.h
> @@ -12,8 +12,6 @@
>  #include "policydb.h"
>  #include "../include/conditional.h"
>
> -#define COND_EXPR_MAXDEPTH 10
> -
>  /*
>   * A conditional expression is a list of operators and operands
>   * in reverse polish notation.
> diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/const=
raint.h
> index 1d75a8a044df..f986156de856 100644
> --- a/security/selinux/ss/constraint.h
> +++ b/security/selinux/ss/constraint.h
> @@ -19,8 +19,6 @@
>
>  #include "ebitmap.h"
>
> -#define CEXPR_MAXDEPTH 5
> -
>  struct constraint_expr {
>  #define CEXPR_NOT   1 /* not expr */
>  #define CEXPR_AND   2 /* expr and expr */
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 2b098d9abf17..e64254985762 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -552,7 +552,8 @@ static int common_index(void *key, void *datum, void =
*datap)
>
>         comdatum =3D datum;
>         p =3D datap;
> -       if (!comdatum->value || comdatum->value > p->p_commons.nprim)
> +       if (!comdatum->value || comdatum->value > p->p_commons.nprim ||
> +           comdatum->value > IDENTIFIER_MAXVALUE)
>                 return -EINVAL;
>
>         p->sym_val_to_name[SYM_COMMONS][comdatum->value - 1] =3D key;
> @@ -567,7 +568,8 @@ static int class_index(void *key, void *datum, void *=
datap)
>
>         cladatum =3D datum;
>         p =3D datap;
> -       if (!cladatum->value || cladatum->value > p->p_classes.nprim)
> +       if (!cladatum->value || cladatum->value > p->p_classes.nprim ||
> +           cladatum->value > IDENTIFIER_MAXVALUE)
>                 return -EINVAL;
>
>         p->sym_val_to_name[SYM_CLASSES][cladatum->value - 1] =3D key;
> @@ -583,6 +585,7 @@ static int role_index(void *key, void *datum, void *d=
atap)
>         role =3D datum;
>         p =3D datap;
>         if (!role->value || role->value > p->p_roles.nprim ||
> +           role->value > IDENTIFIER_MAXVALUE ||
>             role->bounds > p->p_roles.nprim)
>                 return -EINVAL;
>
> @@ -601,6 +604,7 @@ static int type_index(void *key, void *datum, void *d=
atap)
>
>         if (typdatum->primary) {
>                 if (!typdatum->value || typdatum->value > p->p_types.npri=
m ||
> +                   typdatum->value > IDENTIFIER_MAXVALUE ||
>                     typdatum->bounds > p->p_types.nprim)
>                         return -EINVAL;
>                 p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] =3D ke=
y;
> @@ -618,6 +622,7 @@ static int user_index(void *key, void *datum, void *d=
atap)
>         usrdatum =3D datum;
>         p =3D datap;
>         if (!usrdatum->value || usrdatum->value > p->p_users.nprim ||
> +           usrdatum->value > IDENTIFIER_MAXVALUE ||
>             usrdatum->bounds > p->p_users.nprim)
>                 return -EINVAL;
>
> @@ -634,7 +639,8 @@ static int sens_index(void *key, void *datum, void *d=
atap)
>         levdatum =3D datum;
>         p =3D datap;
>
> -       if (!levdatum->level.sens || levdatum->level.sens > p->p_levels.n=
prim)
> +       if (!levdatum->level.sens || levdatum->level.sens > p->p_levels.n=
prim ||
> +           levdatum->level.sens > IDENTIFIER_MAXVALUE)
>                 return -EINVAL;
>
>         if (!levdatum->isalias)
> @@ -651,7 +657,8 @@ static int cat_index(void *key, void *datum, void *da=
tap)
>         catdatum =3D datum;
>         p =3D datap;
>
> -       if (!catdatum->value || catdatum->value > p->p_cats.nprim)
> +       if (!catdatum->value || catdatum->value > p->p_cats.nprim ||
> +           catdatum->value > IDENTIFIER_MAXVALUE)
>                 return -EINVAL;
>
>         if (!catdatum->isalias)
> @@ -1226,8 +1233,9 @@ static int context_read_and_validate(struct context=
 *c, struct policydb *p,
>   * binary representation file.
>   */
>
> -int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
> +int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len, =
int kind, u32 max_len)
>  {
> +       u32 i;
>         int rc;
>         char *str;
>
> @@ -1237,19 +1245,35 @@ int str_read(char **strp, gfp_t flags, struct pol=
icy_file *fp, u32 len)
>         if (size_check(sizeof(char), len, fp))
>                 return -EINVAL;
>
> +       if (len > max_len)
> +               return -EINVAL;
> +
>         str =3D kmalloc(len + 1, flags | __GFP_NOWARN);
>         if (!str)
>                 return -ENOMEM;
>
>         rc =3D next_entry(str, fp, len);
> -       if (rc) {
> -               kfree(str);
> -               return rc;
> +       if (rc)
> +               goto bad_str;
> +
> +       rc =3D -EINVAL;
> +       for (i =3D 0; i < len; i++) {
> +               if (iscntrl(str[i]))
> +                       goto bad_str;
> +
> +               if (kind =3D=3D STR_IDENTIFIER &&
> +                   !(isalnum(str[i]) || str[i] =3D=3D '_' || str[i] =3D=
=3D '-' || str[i] =3D=3D '.'))
> +                       goto bad_str;
> +
>         }
>
>         str[len] =3D '\0';
>         *strp =3D str;
>         return 0;
> +
> +bad_str:
> +       kfree(str);
> +       return rc;
>  }
>
>  static int perm_read(struct policydb *p, struct symtab *s, struct policy=
_file *fp)
> @@ -1274,7 +1298,7 @@ static int perm_read(struct policydb *p, struct sym=
tab *s, struct policy_file *f
>         if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
>                 goto bad;
>
> -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> +       rc =3D str_read_perm(&key, GFP_KERNEL, fp, len);
>         if (rc)
>                 goto bad;
>
> @@ -1321,7 +1345,7 @@ static int common_read(struct policydb *p, struct s=
ymtab *s, struct policy_file
>                 goto bad;
>         comdatum->permissions.nprim =3D le32_to_cpu(buf[2]);
>
> -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> +       rc =3D str_read_class(&key, GFP_KERNEL, fp, len);
>         if (rc)
>                 goto bad;
>
> @@ -1559,12 +1583,12 @@ static int class_read(struct policydb *p, struct =
symtab *s, struct policy_file *
>
>         ncons =3D le32_to_cpu(buf[5]);
>
> -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> +       rc =3D str_read_class(&key, GFP_KERNEL, fp, len);
>         if (rc)
>                 goto bad;
>
>         if (len2) {
> -               rc =3D str_read(&cladatum->comkey, GFP_KERNEL, fp, len2);
> +               rc =3D str_read_class(&cladatum->comkey, GFP_KERNEL, fp, =
len2);
>                 if (rc)
>                         goto bad;
>
> @@ -1698,7 +1722,7 @@ static int role_read(struct policydb *p, struct sym=
tab *s, struct policy_file *f
>         if (p->policyvers >=3D POLICYDB_VERSION_BOUNDARY)
>                 role->bounds =3D le32_to_cpu(buf[2]);
>
> -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> +       rc =3D str_read_role(&key, GFP_KERNEL, fp, len);
>         if (rc)
>                 goto bad;
>
> @@ -1765,7 +1789,7 @@ static int type_read(struct policydb *p, struct sym=
tab *s, struct policy_file *f
>                 typdatum->primary =3D le32_to_cpu(buf[2]);
>         }
>
> -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> +       rc =3D str_read_type(&key, GFP_KERNEL, fp, len);
>         if (rc)
>                 goto bad;
>
> @@ -1829,7 +1853,7 @@ static int user_read(struct policydb *p, struct sym=
tab *s, struct policy_file *f
>         if (p->policyvers >=3D POLICYDB_VERSION_BOUNDARY)
>                 usrdatum->bounds =3D le32_to_cpu(buf[2]);
>
> -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> +       rc =3D str_read_user(&key, GFP_KERNEL, fp, len);
>         if (rc)
>                 goto bad;
>
> @@ -1878,7 +1902,7 @@ static int sens_read(struct policydb *p, struct sym=
tab *s, struct policy_file *f
>                 goto bad;
>         levdatum->isalias =3D val;
>
> -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> +       rc =3D str_read_sens(&key, GFP_KERNEL, fp, len);
>         if (rc)
>                 goto bad;
>
> @@ -1921,7 +1945,7 @@ static int cat_read(struct policydb *p, struct symt=
ab *s, struct policy_file *fp
>                 goto bad;
>         catdatum->isalias =3D val;
>
> -       rc =3D str_read(&key, GFP_KERNEL, fp, len);
> +       rc =3D str_read_cat(&key, GFP_KERNEL, fp, len);
>         if (rc)
>                 goto bad;
>
> @@ -2230,7 +2254,7 @@ static int filename_trans_read_helper_compat(struct=
 policydb *p, struct policy_f
>         len =3D le32_to_cpu(buf[0]);
>
>         /* path component string */
> -       rc =3D str_read(&name, GFP_KERNEL, fp, len);
> +       rc =3D str_read(&name, GFP_KERNEL, fp, len, STR_UNCONSTRAINT, FIL=
ETRANSKEY_NAME_MAXLENGTH);
>         if (rc)
>                 return rc;
>
> @@ -2329,7 +2353,7 @@ static int filename_trans_read_helper(struct policy=
db *p, struct policy_file *fp
>         len =3D le32_to_cpu(buf[0]);
>
>         /* path component string */
> -       rc =3D str_read(&name, GFP_KERNEL, fp, len);
> +       rc =3D str_read(&name, GFP_KERNEL, fp, len, STR_UNCONSTRAINT, FIL=
ETRANSKEY_NAME_MAXLENGTH);
>         if (rc)
>                 return rc;
>
> @@ -2483,7 +2507,7 @@ static int genfs_read(struct policydb *p, struct po=
licy_file *fp)
>                 if (!newgenfs)
>                         goto out;
>
> -               rc =3D str_read(&newgenfs->fstype, GFP_KERNEL, fp, len);
> +               rc =3D str_read_fsname(&newgenfs->fstype, GFP_KERNEL, fp,=
 len);
>                 if (rc)
>                         goto out;
>
> @@ -2522,7 +2546,8 @@ static int genfs_read(struct policydb *p, struct po=
licy_file *fp)
>                         if (!newc)
>                                 goto out;
>
> -                       rc =3D str_read(&newc->u.name, GFP_KERNEL, fp, le=
n);
> +                       rc =3D str_read(&newc->u.name, GFP_KERNEL, fp, le=
n,
> +                                     STR_UNCONSTRAINT, GENFS_PATH_MAXLEN=
GTH);
>                         if (rc)
>                                 goto out;
>
> @@ -2625,7 +2650,7 @@ static int ocontext_read(struct policydb *p,
>                                         goto out;
>                                 len =3D le32_to_cpu(buf[0]);
>
> -                               rc =3D str_read(&c->u.name, GFP_KERNEL, f=
p, len);
> +                               rc =3D str_read_fsname(&c->u.name, GFP_KE=
RNEL, fp, len);
>                                 if (rc)
>                                         goto out;
>
> @@ -2693,7 +2718,7 @@ static int ocontext_read(struct policydb *p,
>                                         goto out;
>
>                                 len =3D le32_to_cpu(buf[1]);
> -                               rc =3D str_read(&c->u.name, GFP_KERNEL, f=
p, len);
> +                               rc =3D str_read_fsname(&c->u.name, GFP_KE=
RNEL, fp, len);
>                                 if (rc)
>                                         goto out;
>
> @@ -2759,7 +2784,9 @@ static int ocontext_read(struct policydb *p,
>                                 len =3D le32_to_cpu(buf[0]);
>
>                                 rc =3D str_read(&c->u.ibendport.dev_name,
> -                                             GFP_KERNEL, fp, len);
> +                                             GFP_KERNEL, fp, len,
> +                                             STR_UNCONSTRAINT,
> +                                             INFINIBAND_DEVNAME_MAXLENGT=
H);
>                                 if (rc)
>                                         goto out;
>
> @@ -2827,7 +2854,8 @@ int policydb_read(struct policydb *p, struct policy=
_file *fp)
>                 goto bad;
>         }
>
> -       rc =3D str_read(&policydb_str, GFP_KERNEL, fp, len);
> +       rc =3D str_read(&policydb_str, GFP_KERNEL, fp, len,
> +                     STR_UNCONSTRAINT, strlen(POLICYDB_STRING));
>         if (rc) {
>                 if (rc =3D=3D -ENOMEM) {
>                         pr_err("SELinux:  unable to allocate memory for p=
olicydb string of length %d\n",
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policyd=
b.h
> index b4f0c1a754cf..e901ec648cbf 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -27,6 +27,7 @@
>  #include "mls_types.h"
>  #include "context.h"
>  #include "constraint.h"
> +#include "limits.h"
>
>  /*
>   * A datum type is defined for each kind of symbol
> @@ -408,7 +409,55 @@ static inline bool val_is_boolean(u32 value)
>         return value =3D=3D 0 || value =3D=3D 1;
>  }
>
> -extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u3=
2 len);
> +#define STR_UNCONSTRAINT 0
> +#define STR_IDENTIFIER 1
> +extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u3=
2 len,
> +                   int kind, u32 max_len);
> +
> +static inline int str_read_bool(char **strp, gfp_t flags, struct policy_=
file *fp, u32 len)
> +{
> +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, BOOLEAN_NAM=
E_MAXLENGTH);
> +}
> +
> +static inline int str_read_cat(char **strp, gfp_t flags, struct policy_f=
ile *fp, u32 len)
> +{
> +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, CATEGORY_NA=
ME_MAXLENGTH);
> +}
> +
> +static inline int str_read_class(char **strp, gfp_t flags, struct policy=
_file *fp, u32 len)
> +{
> +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, CLASS_NAME_=
MAXLENGTH);
> +}
> +
> +static inline int str_read_perm(char **strp, gfp_t flags, struct policy_=
file *fp, u32 len)
> +{
> +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, PERMISSION_=
NAME_MAXLENGTH);
> +}
> +
> +static inline int str_read_role(char **strp, gfp_t flags, struct policy_=
file *fp, u32 len)
> +{
> +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, ROLE_NAME_M=
AXLENGTH);
> +}
> +
> +static inline int str_read_sens(char **strp, gfp_t flags, struct policy_=
file *fp, u32 len)
> +{
> +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, SENSITIVITY=
_NAME_MAXLENGTH);
> +}
> +
> +static inline int str_read_type(char **strp, gfp_t flags, struct policy_=
file *fp, u32 len)
> +{
> +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, TYPE_NAME_M=
AXLENGTH);
> +}
> +
> +static inline int str_read_user(char **strp, gfp_t flags, struct policy_=
file *fp, u32 len)
> +{
> +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, USER_NAME_M=
AXLENGTH);
> +}
> +
> +static inline int str_read_fsname(char **strp, gfp_t flags, struct polic=
y_file *fp, u32 len)
> +{
> +       return str_read(strp, flags, fp, len, STR_IDENTIFIER, FILESYSTEM_=
NAME_MAXLENGTH);
> +}
>
>  extern u16 string_to_security_class(struct policydb *p, const char *name=
);
>  extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char =
*name);
> --
> 2.49.0
>
