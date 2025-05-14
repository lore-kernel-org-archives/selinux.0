Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C052868A4;
	Wed, 14 May 2025 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249581; cv=none; b=M1UQYd1tuUIyY8MsmFPXSTREF3BOcbqaOs50Yeys7jiEmhVBpBuQUbyzNHoghLkEwXoQnUH+oSV3szGmTet3GoX4em8Vz+yXv4RzQqUWhzhFLSHheVoUoZCAkuQZBb5lZ1n0fOION+zm+XcX4lCe3u47LSM7umiR81lGc8wYMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249581; c=relaxed/simple;
	bh=pkPGLWmnxyL2lTg/4/v2SuPNj8kowqjrvrA9NC7P7yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUIbzStTvf5xUXB8Om53WUtxt5MeCaWoJ6/bzFyWXdPI3zuVhp6uSt/BIxeVIPjgE6DyF0TI9AEy39ykq8cRrTSfLrXepqLXtt/rTP2VI6SufKauzOojBav+xDsE8TkVW234L3b4euXX4chLcmNEvmtbQkHiNSee2nRxdDRaNsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqxFTff0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqxFTff0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30a8c9906e5so223502a91.1;
        Wed, 14 May 2025 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747249579; x=1747854379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1pMypX06ZzS76nW/kI23orBa+jzmujGeNficFMCZFk=;
        b=jqxFTff0IB2FdM5Me89pj16hnpVBYqBhyvoz2SkP3vhot/BECG988VyUG765+uCSdK
         yvIMwhCHwb/qSIitN3gFEtQsMUZeNNv4WEQNnw1EFjO7Gvpmy3rT1DyFPDluV1i8aN7f
         uAcmJqkoL7lNKJ+FRMBSCI1QDjlsobMLUGqBNGYBiz7t4Ebmpat7E/Iqx97QVHrlYqrX
         qsHcTVvEs1sZ7katONhV+IcQmRWRLCT+9jh8d1gEsUZq5+tEiFTGKTD/5W1MLeSdYUU/
         6m8bA0vWCjzvcajcm/RXZ1Nqge+ol180sCMskqqxgDFGCTTj0Rdx+jQl9lQ71gKK2Y0o
         af5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747249579; x=1747854379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1pMypX06ZzS76nW/kI23orBa+jzmujGeNficFMCZFk=;
        b=LvjunBFByNInXwYrDTBxmgIGmXacgm2mEZzgIfcca5LjVvt+laaSdDcduOCJyNhFmB
         21U6f4EVdcJ6iuiLR7XChFwFG2te24zdMKr/cNXrLWX+0/N6cOn+6oIHUrG/vefYBuHb
         WVAXw1YqxM7Vi2Qc9XcpKKyDLzyJmb/TVZPS+JlY5AdLRsM+kX0P1Gkw0IlVzG1McBVS
         6IOKekcO3XWr8M3KtqS7Ex5oRLqJafhe0iYOZMbq5GkL2mKCb0DnyAP/dJmxR5mTcInC
         wT3MIi2EBkd6G4/fxhdwIpajLOZq/POfCudJIzSS05DflJH2cBuRsxOR6jLJ0QGAMtgG
         SCVg==
X-Forwarded-Encrypted: i=1; AJvYcCXKPenp1Ovhe80iaMJgaresMCzsPMSYHJfy5MKwkIBK+wvPz6WVKegn4lv95dusq9Yf9nbhtyimfbYI+FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUWH4bgP9EoVP7JHAs1KhvzXZse5QN16+0FvTDZg9KxPg3tsAp
	3hw4ErrzdhJtaT9wXPIunjhtlYUcHWg4YSIdqvYQigkIb3gcB6LtDn3MjKS/PvcEQP19MOBF06U
	ZMSCBYWQZsSawF5sQepyVhVa+PiU=
X-Gm-Gg: ASbGnctn23h6exofXOxTNjxA5pQ6RxBWcHTkdeEuW7ii1LaOtL3+f93Jsz+JMJv6RkT
	yV82JYRyPjiaZaqHy41cIsgbl5aEeGntCyagQeVIlaKijCBMFJsPA41ZF+tzkWixeLqbvK1gnR5
	JFEb4C115Tlk8MIsjP7K1JlUcLsAKOkOgo
X-Google-Smtp-Source: AGHT+IH8NXPz6aovZauT3wvH+Rgd/TCbj/Lng8D8ng36OU4Fiej4pyWd4kw8wz7C3NDdXUq/AopoZdFg+12wLyaC3sU=
X-Received: by 2002:a17:90a:e188:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-30e2e620774mr7584187a91.28.1747249578867; Wed, 14 May 2025
 12:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-10-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-10-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 May 2025 15:06:07 -0400
X-Gm-Features: AX0GCFu-o75HyZ3-ihQ9FQt_qlf08mGXT9ZKkWOIPPXXR0HMdCtsCTXkz4QkX5w
Message-ID: <CAEjxPJ5NVZ4HzSm4doEpTG5pLFD-F7A3MZnrM_noxHh4b-mJAQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] selinux: validate symbols
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Some symbol tables need to be validated after indexing, since during
> indexing their referenced entries might not yet have been indexed.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

NB role dominance is already gone in checkpolicy and never supported by sec=
ilc.
At some point likely should drop corresponding kernel and libsepol support =
too.

> ---
>  security/selinux/ss/policydb.c | 94 ++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index f8d6e993ce89..4559c8918134 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -673,6 +673,84 @@ static int (*const index_f[SYM_NUM])(void *key, void=
 *datum, void *datap) =3D {
>  };
>  /* clang-format on */
>
> +static int role_validate(void *key, void *datum, void *datap)
> +{
> +       const struct policydb *p =3D datap;
> +       const struct role_datum *role =3D datum;
> +       struct ebitmap_node *node;
> +       u32 i;
> +
> +       ebitmap_for_each_positive_bit(&role->dominates, node, i) {
> +               if (!policydb_role_isvalid(p, i))
> +                       goto bad;
> +       }
> +
> +       ebitmap_for_each_positive_bit(&role->types, node, i) {
> +               if (!policydb_type_isvalid(p, i + 1))
> +                       goto bad;
> +       }
> +
> +       return 0;
> +
> +bad:
> +       pr_err("SELinux:  invalid role %s\n", sym_name(p, SYM_ROLES, role=
->value - 1));
> +       return -EINVAL;
> +}
> +
> +static int user_validate(void *key, void *datum, void *datap)
> +{
> +       const struct policydb *p =3D datap;
> +       const struct user_datum *usrdatum =3D datum;
> +       struct ebitmap_node *node;
> +       u32 i;
> +
> +       ebitmap_for_each_positive_bit(&usrdatum->roles, node, i) {
> +               if (!policydb_role_isvalid(p, i))
> +                       goto bad;
> +       }
> +
> +       if (!mls_range_isvalid(p, &usrdatum->range))
> +               goto bad;
> +
> +       if (!mls_level_isvalid(p, &usrdatum->dfltlevel))
> +               goto bad;
> +
> +       return 0;
> +
> +bad:
> +       pr_err("SELinux:  invalid user %s\n", sym_name(p, SYM_USERS, usrd=
atum->value - 1));
> +       return -EINVAL;
> +}
> +
> +static int sens_validate(void *key, void *datum, void *datap)
> +{
> +       const struct policydb *p =3D datap;
> +       const struct level_datum *levdatum =3D datum;
> +
> +       if (!mls_level_isvalid(p, &levdatum->level))
> +               goto bad;
> +
> +       return 0;
> +
> +bad:
> +       pr_err("SELinux:  invalid sensitivity\n");
> +       return -EINVAL;
> +}
> +
> +
> +/* clang-format off */
> +static int (*const validate_f[SYM_NUM])(void *key, void *datum, void *da=
tap) =3D {
> +       NULL, /* Everything validated in common_read() and common_index()=
 */
> +       NULL, /* Everything validated in class_read() and class_index() *=
/
> +       role_validate,
> +       NULL, /* Everything validated in type_read(), type_index() and ty=
pe_bounds_sanity_check() */
> +       user_validate,
> +       NULL, /* Everything validated in cond_read_bool() and cond_index_=
bool() */
> +       sens_validate,
> +       NULL, /* Everything validated in cat_read() and cat_index() */
> +};
> +/* clang-format on */
> +
>  #ifdef CONFIG_SECURITY_SELINUX_DEBUG
>  static void hash_eval(struct hashtab *h, const char *hash_name,
>                       const char *hash_details)
> @@ -765,6 +843,16 @@ static int policydb_index(struct policydb *p)
>                 if (rc)
>                         goto out;
>         }
> +
> +       for (i =3D 0; i < SYM_NUM; i++) {
> +               if (!validate_f[i])
> +                       continue;
> +
> +               rc =3D hashtab_map(&p->symtab[i].table, validate_f[i], p)=
;
> +               if (rc)
> +                       goto out;
> +       }
> +
>         rc =3D 0;
>  out:
>         return rc;
> @@ -1087,6 +1175,12 @@ static int context_read_and_validate(struct contex=
t *c, struct policydb *p,
>                         pr_err("SELinux: error reading MLS range of conte=
xt\n");
>                         goto out;
>                 }
> +
> +               rc =3D -EINVAL;
> +               if (!mls_range_isvalid(p, &c->range)) {
> +                       pr_warn("SELinux: invalid range in security conte=
xt\n");
> +                       goto out;
> +               }
>         }
>
>         rc =3D -EINVAL;
> --
> 2.49.0
>
