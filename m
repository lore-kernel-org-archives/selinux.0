Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E6194A44;
	Wed, 14 May 2025 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245339; cv=none; b=VTa0NuzcXQ+PaO1VrjmmoceErgjJ2TTIryNyUviuCTBz4lIrI1B0nKBjnOMfrHlWi5SJIgPPRY8jShz3VrXrOzoQKIjT6kzbxEOTXBLm3BqwXSMUfo3VNqq2YkYRdSvpJL2YmWCkbO5EzglEmW7kaZJZPdmtF36yZ8tYOUv19NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245339; c=relaxed/simple;
	bh=Nb9soRPWW/Bkmf9bNl5lKFfsL7TR7HDW08E3O55Lx1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENSymUpmdtHfqAAottTwc8EueLYH4QN5bUnmUjNnMyYXNWGRDdJAMRcR9FlcEjduTg4d3DcLjUlYxGtCprjgRH6Ga9k93TC63JQZxKuNIko73bDFyl8LbIQtN4KpxNa+YS6U0WFhtXFaZu5mppx8ahLBT8T8w4S1GNimHTLhOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHVjI9O0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHVjI9O0"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30dfd9e7fa8so193390a91.2;
        Wed, 14 May 2025 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747245337; x=1747850137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HinAnEqnVncicm1J5/rWSAfFai4NtUO8ZqhXp4ch57g=;
        b=bHVjI9O0QBp7CjJg8Hm9sNHBjCXDjRlj05A1CNT3YKZj5ibkXkFT2lq6jBKyAwl5MV
         r437cBb4v/97/QtJjibUrvH1puSPPfz+HkTtBpk60sLMCetBNNRbumMIaYy4fIyK938c
         6WsYv4OhBOtATo7RZoUtsO4DdXCvNY7nZBcNSHXJoUtiXnKnQSchs1/ewtvEaF/B9ded
         q1gDTnQ3ZhLkYA/a5tmz8F+6tihbRKaX+21Lu32SvS6QqAD8GEMJY0Z9VONFs7sMp4xH
         bSaWvEKkvsZFbCqHzGq3iLBE0Yo/9v2AKo14JOpaOpT78/Xjzd6ixnl61NXyPWw66VOI
         iKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747245337; x=1747850137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HinAnEqnVncicm1J5/rWSAfFai4NtUO8ZqhXp4ch57g=;
        b=QtEea/ckRfkVwd35objpnxPjAm4F7pXRU5qzGO89V6Ctl9NgKjSBvoJN6j1EsNgcZ5
         YcK6G+isEOGQ+9uC+26nECq9eWLPLC/ICIdPu3A0muqgbsdH7WdyW2S4icJe3XIDGiuf
         bgPxnFjZBSustc7haPNCxJBKOcy6KuWKyQG07ncN1W1uKdzu+zy/H0MEP4uE+lyV/l+/
         29l2m2joOmqbrM1iSQYHJB46S2eILirXzgOpC/Q931LASXdu4DmLKX868NzfNGYu8bCd
         cIgyfGn0t2aIq4CIfjsdt8HDcVkluy5+dmBB19uahgPkSgZzVJpHJ8U8WYVfrajiwrOr
         tSmA==
X-Forwarded-Encrypted: i=1; AJvYcCWqJOjA4PP42EbQo40d4FfD/WDYY2o46z/X9h2c5Wux9IRJtv8H29Q3lnQ7OeX7emG8y5OIETRkz7kdq68=@vger.kernel.org
X-Gm-Message-State: AOJu0YweO0KTsC256rh9UC28hxxEGMDq2uXPPb44Tei0apQeqriRs5t6
	E7aGMIrsWfve6M3MUETLelgJZLft64WiPGGKeyd6wIfqExno38MAGRnKrwdsXxU2tP0VW8Xe/OJ
	V613kqKz5UyBrI2XfYf21sPUNZPk=
X-Gm-Gg: ASbGncuJlWz94JyDCb+j5uB+Ismuhlwak5eDWqHnaPumux5xnmtcNmjztNVYFKp2HmU
	BgKfI85G1nV4Oys2OFp2GwwCvsHE8/FtJ1a6DStlZYynT+DB+dUfs44Uy5WfHslyZDmCRPkrrqr
	ISGOdyqDSFVVn7dz/j7CVxs3u3wq5l5WUw8z8vCVa9NsM=
X-Google-Smtp-Source: AGHT+IFfKXnDMG167efnn7uspsFJXow32kMeNYgLNSBSl4xo0UFrvl+FPK6B9CNVcOeIOfWSExXKk7t/Dv0amZQzHxM=
X-Received: by 2002:a17:90b:2e8e:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-30e2e5c322dmr6722075a91.11.1747245336642; Wed, 14 May 2025
 10:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-6-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-6-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 May 2025 13:55:25 -0400
X-Gm-Features: AX0GCFvnnjhU6Cuj2FW8Ym85eUsePyT2qlqzPuNPB8ZTlgVlRyyWgy6K-lhKJ5A
Message-ID: <CAEjxPJ7kg1xB2xy0uhzgpyN+0cpqoTyXSy_FYFx3Ases79FTXQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] selinux: pre-validate conditional expressions
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Validate conditional expressions while reading the policy, to avoid
> unexpected access decisions on malformed policies.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/conditional.c | 116 ++++++++++++++++++++----------
>  security/selinux/ss/policydb.c    |   7 ++
>  security/selinux/ss/policydb.h    |   1 +
>  3 files changed, 88 insertions(+), 36 deletions(-)
>
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/cond=
itional.c
> index 92ed4f23a217..ce0281cce739 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -21,65 +21,119 @@
>   * or undefined (-1). Undefined occurs when the expression
>   * exceeds the stack depth of COND_EXPR_MAXDEPTH.
>   */
> -static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr=
)
> +static int cond_evaluate_expr(const struct policydb *p, const struct con=
d_expr *expr)
>  {
>         u32 i;
>         int s[COND_EXPR_MAXDEPTH];
>         int sp =3D -1;
>
> -       if (expr->len =3D=3D 0)
> -               return -1;
> +       if (unlikely(expr->len =3D=3D 0))
> +               goto invalid;

If this is not possible at runtime due to load-time checking, drop it
please. Same applies later. Split the evaluator checking between
load-time and runtime so we don't do it twice.

>
>         for (i =3D 0; i < expr->len; i++) {
> -               struct cond_expr_node *node =3D &expr->nodes[i];
> +               const struct cond_expr_node *node =3D &expr->nodes[i];
>
>                 switch (node->expr_type) {
>                 case COND_BOOL:
> -                       if (sp =3D=3D (COND_EXPR_MAXDEPTH - 1))
> -                               return -1;
> +                       if (unlikely(sp >=3D (COND_EXPR_MAXDEPTH - 1)))
> +                               goto invalid;
>                         sp++;
>                         s[sp] =3D p->bool_val_to_struct[node->boolean - 1=
]->state;
>                         break;
>                 case COND_NOT:
> -                       if (sp < 0)
> -                               return -1;
> +                       if (unlikely(sp < 0))
> +                               goto invalid;
>                         s[sp] =3D !s[sp];
>                         break;
>                 case COND_OR:
> -                       if (sp < 1)
> -                               return -1;
> +                       if (unlikely(sp < 1))
> +                               goto invalid;
>                         sp--;
>                         s[sp] |=3D s[sp + 1];
>                         break;
>                 case COND_AND:
> -                       if (sp < 1)
> -                               return -1;
> +                       if (unlikely(sp < 1))
> +                               goto invalid;
>                         sp--;
>                         s[sp] &=3D s[sp + 1];
>                         break;
>                 case COND_XOR:
> -                       if (sp < 1)
> -                               return -1;
> +                       if (unlikely(sp < 1))
> +                               goto invalid;
>                         sp--;
>                         s[sp] ^=3D s[sp + 1];
>                         break;
>                 case COND_EQ:
> -                       if (sp < 1)
> -                               return -1;
> +                       if (unlikely(sp < 1))
> +                               goto invalid;
>                         sp--;
>                         s[sp] =3D (s[sp] =3D=3D s[sp + 1]);
>                         break;
>                 case COND_NEQ:
> -                       if (sp < 1)
> -                               return -1;
> +                       if (unlikely(sp < 1))
> +                               goto invalid;
>                         sp--;
>                         s[sp] =3D (s[sp] !=3D s[sp + 1]);
>                         break;
>                 default:
> -                       return -1;
> +                       goto invalid;
>                 }
>         }
> +
> +       if (unlikely(sp !=3D 0))
> +               goto invalid;
> +
>         return s[0];
> +
> +invalid:
> +       /* Should *never* be reached, cause malformed expressions should
> +        * have been filtered by cond_validate_expr().
> +        */
> +       WARN_ONCE(true, "SELinux: invalid conditional expression passed v=
alidation\n");
> +       return -1;
> +}
> +
> +static int cond_validate_expr(const struct policydb *p, const struct con=
d_expr *expr)
> +{
> +       u32 i;
> +       int depth =3D -1;
> +
> +       if (expr->len =3D=3D 0)
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < expr->len; i++) {
> +               const struct cond_expr_node *node =3D &expr->nodes[i];
> +
> +               switch (node->expr_type) {
> +               case COND_BOOL:
> +                       if (depth >=3D (COND_EXPR_MAXDEPTH - 1))
> +                               return -EINVAL;
> +                       depth++;
> +                       if (!policydb_boolean_isvalid(p, node->boolean))
> +                               return -EINVAL;
> +                       break;
> +               case COND_NOT:
> +                       if (depth < 0)
> +                               return -EINVAL;
> +                       break;
> +               case COND_OR:
> +               case COND_AND:
> +               case COND_XOR:
> +               case COND_EQ:
> +               case COND_NEQ:
> +                       if (depth < 1)
> +                               return -EINVAL;
> +                       depth--;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       if (depth !=3D 0)
> +               return -EINVAL;
> +
> +       return 0;
>  }
>
>  /*
> @@ -356,21 +410,6 @@ static int cond_read_av_list(struct policydb *p, str=
uct policy_file *fp,
>         return 0;
>  }
>
> -static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *=
expr)
> -{
> -       if (expr->expr_type <=3D 0 || expr->expr_type > COND_LAST) {
> -               pr_err("SELinux: conditional expressions uses unknown ope=
rator.\n");
> -               return 0;
> -       }
> -
> -       if (expr->expr_type =3D=3D COND_BOOL &&
> -           (expr->boolean =3D=3D 0 || expr->boolean > p->p_bools.nprim))=
 {
> -               pr_err("SELinux: conditional expressions uses unknown boo=
l.\n");
> -               return 0;
> -       }
> -       return 1;
> -}
> -
>  static int cond_read_node(struct policydb *p, struct cond_node *node, st=
ruct policy_file *fp)
>  {
>         __le32 buf[2];
> @@ -385,6 +424,8 @@ static int cond_read_node(struct policydb *p, struct =
cond_node *node, struct pol
>
>         /* expr */
>         len =3D le32_to_cpu(buf[1]);
> +       if (len =3D=3D 0)
> +               return -EINVAL;
>
>         /* we will read 64 bytes per node */
>         rc =3D size_check(2 * sizeof(u32), len, fp);
> @@ -406,9 +447,12 @@ static int cond_read_node(struct policydb *p, struct=
 cond_node *node, struct pol
>
>                 expr->expr_type =3D le32_to_cpu(buf[0]);
>                 expr->boolean =3D le32_to_cpu(buf[1]);
> +       }
>
> -               if (!expr_node_isvalid(p, expr))
> -                       return -EINVAL;
> +       rc =3D cond_validate_expr(p, &node->expr);
> +       if (rc) {
> +               pr_err("SELinux: invalid conditional expression\n");
> +               return rc;
>         }
>
>         rc =3D cond_read_av_list(p, fp, &node->true_list, NULL);
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index a8397ed66109..8969f7c8637c 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -945,6 +945,13 @@ int policydb_type_isvalid(struct policydb *p, unsign=
ed int type)
>         return 1;
>  }
>
> +int policydb_boolean_isvalid(const struct policydb *p, u32 boolean)
> +{
> +       if (!boolean || boolean > p->p_bools.nprim)
> +               return 0;
> +       return 1;
> +}
> +
>  /*
>   * Return 1 if the fields in the security context
>   * structure `c' are valid.  Return 0 otherwise.
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policyd=
b.h
> index bb96a6cb6101..42117adb2ca0 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -324,6 +324,7 @@ extern int policydb_context_isvalid(struct policydb *=
p, struct context *c);
>  extern int policydb_class_isvalid(struct policydb *p, u16 class);
>  extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
>  extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
> +extern int policydb_boolean_isvalid(const struct policydb *p, u32 boolea=
n);
>  extern int policydb_read(struct policydb *p, struct policy_file *fp);
>  extern int policydb_write(struct policydb *p, struct policy_file *fp);
>
> --
> 2.49.0
>
