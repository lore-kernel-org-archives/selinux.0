Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC91F4606;
	Wed, 14 May 2025 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245097; cv=none; b=jDE/K3OiYXM/V4vO2UXdri5QfRrhc9OMSCNuhTNqUt0/QK6HhqoItCHsKMvCxPPFpYGlevHRf3jjXFKiVMggh91j4gt5oYCqo40A42HfvcBxWV0nYPRsUKURiWs4ldLOR0zkcRn4CVRPaBbQ3oN5gUXaZFiU/5RJ+zTcbg5ksb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245097; c=relaxed/simple;
	bh=adm//kuNrvGtPQxSm79vxqykA4sQsdq+MVRrOaF0a8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jxm5Ju39sGqQxsLSqvCgsGNbScx85hmNHXis9RrRFnqjtZ32zrSKqO8y7Ezsert1lI6Be3EzyIImU0xGgvL5ZQxYq8lai1b5giKb6TONIl2k0uNfeXJHjpbG2DlxfSdyT8IJnJssCX44sngO1zlyJ3qDsb9QJvTm1he9M2dKJDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZOAGIq7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZOAGIq7"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3081f72c271so151153a91.0;
        Wed, 14 May 2025 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747245095; x=1747849895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kt3M1VYDdsNbb9ezAmACuJ3OVyjLd4EiO1N2CSX51Q=;
        b=OZOAGIq7SmaC1JOboM7jNzQKZ3lN1o9971Tumd+ra3VqzH60VxqP2LzVESO55gjo8s
         DcG+H+unT+q9Zs9fMKCuUtneYGuuO5CSG6zS1hbQcuBNcCkMkmVRVd/V0F0VdVUD3qvu
         MFAFxfwh01YaZjMQItO5lZJN6i1Zo96UcZNayZXG/3RtTu8yne5xKmOZHucVjsnmP1Nq
         AdqgeOjGWoGUaEqTOBFDs3ky2k91d+vI5qHBgQCFXOlWVBSMDEY6VorWKikyc9/4mMdf
         GI8GGORZPjkpojllRegkPSWyg7v8ug9or6pgj8bnTTZe1EUihHsNub9U3btLyJyLqXFo
         aduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747245095; x=1747849895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kt3M1VYDdsNbb9ezAmACuJ3OVyjLd4EiO1N2CSX51Q=;
        b=AdwO/eB5PP/y7NC/zlbRn/hYnKnxD0WOlMQ1flmKQDJQgyOpxNrMGzB2U4KQq31Tgy
         KiC+5AxOUR5j9msud+8dLfJUMMXpPod+3mqzT8dAGel2eKKP0Z8/KvHCSebH5Ff3mcU6
         hOz89DcgQCh6+GbelGyiB0NCSp+Fz30dl4yexfQHNoXbBfE/I6cBQCdE2YuE8kgt0Dng
         kV9dvW2+5oXDSuqNS7PYnJFa44n823Scki1JHs9JExziSRAL7auG+ZxWeOynOZ2sTzXP
         tU0yR5epsH9JWLYgvgkehBFFZeWlMshZmsa/0xHgtr2fHXk4KQBaRDjmhK6pkW8z8WMt
         CAWw==
X-Forwarded-Encrypted: i=1; AJvYcCUsVS9DTOgU2Gw7f5e8tlWoYORX60A6QaTsGfu4Q87EW11r/UAwknXcaK2zUJ+LaRUjeBJNJyO8e1JtA9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1zd3CUN1+0obIlHc9ojnKojsrK/muUMAJ14GLReNqKmuRYhRk
	6RlwqCU1+RPwuhv8A2BolzQhb53JGPsb4RNSbalPg2YsQ1QMdghjO3xZ17XnaDzo0uYPvmafejd
	E8QDzmpn8XjvCK37luyzuq4ErkpE=
X-Gm-Gg: ASbGnctJF634pK/4vV60nvulwkxd5U8Y/nO9ZtfRojU9rqaD3U07D/ATz7Lzq79Ef7w
	4ShtJTs48DXuRnTCDuAc+MK6bB3O40y+tLViaTeVOpaVW1I9ikVUikQUYYCDa+dIo25D1gnuhSi
	U7qK6S84Px9Wu7XCbSST/k120z6TM9yYFS
X-Google-Smtp-Source: AGHT+IFu+DUDNEEfs3sD8J/mfyJbt0MjY/GqrLI+KyDEk6Cngsa98Ig1KB6JrvggZFtU1Omg/YQze1JSYmeUvmaJB7g=
X-Received: by 2002:a17:90a:d64f:b0:30a:4ce4:5287 with SMTP id
 98e67ed59e1d1-30e2e42b186mr9060946a91.0.1747245094712; Wed, 14 May 2025
 10:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-5-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-5-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 May 2025 13:51:23 -0400
X-Gm-Features: AX0GCFvgtrr2ig6hr2O21HeS8ktnNxOdmvFnNBtm-BvHQR9e9Z6HgOdJLHTyFFo
Message-ID: <CAEjxPJ6OWqjhyMS47cwRUT3OphknTdmc1FXRMA130njxajjsKQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] selinux: validate constraints
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Canfeng Guo <guocanfeng@uniontech.com>, 
	Takaya Saeki <takayas@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Validate constraint expressions during reading the policy.
> Avoid the usage of BUG() on constraint evaluation, to mitigate malformed
> policies halting the system.
>
> Closes: https://github.com/SELinuxProject/selinux-testsuite/issues/76
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 61 ++++++++++++++++++++++++++++++++--
>  security/selinux/ss/services.c | 55 +++++++++++++++---------------
>  2 files changed, 88 insertions(+), 28 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 46c010afd44f..a8397ed66109 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1288,15 +1290,70 @@ static int read_cons_helper(struct policydb *p, s=
truct constraint_node **nodep,
>                                 depth--;
>                                 break;
>                         case CEXPR_ATTR:
> -                               if (depth =3D=3D (CEXPR_MAXDEPTH - 1))
> +                               if (depth >=3D (CEXPR_MAXDEPTH - 1))

How would the > case be possible? If it isn't something that can be
done by a malformed policy, drop it. Same applies later too.

>                                         return -EINVAL;
>                                 depth++;
>                                 break;
> +
> +                               switch (e->op) {

Something went wrong here, probably a merge failure. Statement after a brea=
k?

> +                               case CEXPR_EQ:
> +                               case CEXPR_NEQ:
> +                                       break;
> +                               case CEXPR_DOM:
> +                               case CEXPR_DOMBY:
> +                               case CEXPR_INCOMP:
> +                                       if ((e->attr & CEXPR_USER) || (e-=
>attr & CEXPR_TYPE))
> +                                               return -EINVAL;
> +                                       break;
> +                               default:
> +                                       return -EINVAL;
> +                               }
> +
> +                               switch (e->attr) {
> +                               case CEXPR_USER:
> +                               case CEXPR_ROLE:
> +                               case CEXPR_TYPE:
> +                               case CEXPR_L1L2:
> +                               case CEXPR_L1H2:
> +                               case CEXPR_H1L2:
> +                               case CEXPR_H1H2:
> +                               case CEXPR_L1H1:
> +                               case CEXPR_L2H2:
> +                                       break;
> +                               default:
> +                                       return -EINVAL;
> +                               }
> +
> +                               break;
>                         case CEXPR_NAMES:
>                                 if (!allowxtarget && (e->attr & CEXPR_XTA=
RGET))
>                                         return -EINVAL;
> -                               if (depth =3D=3D (CEXPR_MAXDEPTH - 1))
> +                               if (depth >=3D (CEXPR_MAXDEPTH - 1))
> +                                       return -EINVAL;
> +
> +                               switch (e->op) {
> +                               case CEXPR_EQ:
> +                               case CEXPR_NEQ:
> +                                       break;
> +                               default:
> +                                       return -EINVAL;
> +                               }
> +
> +                               switch (e->attr) {
> +                               case CEXPR_USER:
> +                               case CEXPR_USER | CEXPR_TARGET:
> +                               case CEXPR_USER | CEXPR_XTARGET:
> +                               case CEXPR_ROLE:
> +                               case CEXPR_ROLE | CEXPR_TARGET:
> +                               case CEXPR_ROLE | CEXPR_XTARGET:
> +                               case CEXPR_TYPE:
> +                               case CEXPR_TYPE | CEXPR_TARGET:
> +                               case CEXPR_TYPE | CEXPR_XTARGET:
> +                                       break;
> +                               default:
>                                         return -EINVAL;
> +                               }
> +
>                                 depth++;
>                                 rc =3D ebitmap_read(&e->names, fp);
>                                 if (rc)
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 0f67a030b49b..3fb971fe4fd9 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -279,22 +279,25 @@ static int constraint_expr_eval(struct policydb *po=
licydb,
>         for (e =3D cexpr; e; e =3D e->next) {
>                 switch (e->expr_type) {
>                 case CEXPR_NOT:
> -                       BUG_ON(sp < 0);
> +                       if (unlikely(sp < 0))
> +                               goto invalid;

If you have ensured that this is not possible at policy load time,
then we don't need to recheck it at runtime. Same applies later.

>                         s[sp] =3D !s[sp];
>                         break;
>                 case CEXPR_AND:
> -                       BUG_ON(sp < 1);
> +                       if (unlikely(sp < 1))
> +                               goto invalid;
>                         sp--;
>                         s[sp] &=3D s[sp + 1];
>                         break;
>                 case CEXPR_OR:
> -                       BUG_ON(sp < 1);
> +                       if (unlikely(sp < 1))
> +                               goto invalid;
>                         sp--;
>                         s[sp] |=3D s[sp + 1];
>                         break;
>                 case CEXPR_ATTR:
> -                       if (sp =3D=3D (CEXPR_MAXDEPTH - 1))
> -                               return 0;
> +                       if (unlikely(sp >=3D (CEXPR_MAXDEPTH - 1)))
> +                               goto invalid;
>                         switch (e->attr) {
>                         case CEXPR_USER:
>                                 val1 =3D scontext->user;
> @@ -370,13 +373,11 @@ static int constraint_expr_eval(struct policydb *po=
licydb,
>                                         s[++sp] =3D mls_level_incomp(l2, =
l1);
>                                         continue;
>                                 default:
> -                                       BUG();
> -                                       return 0;
> +                                       goto invalid;
>                                 }
>                                 break;
>                         default:
> -                               BUG();
> -                               return 0;
> +                               goto invalid;
>                         }
>
>                         switch (e->op) {
> @@ -387,22 +388,19 @@ static int constraint_expr_eval(struct policydb *po=
licydb,
>                                 s[++sp] =3D (val1 !=3D val2);
>                                 break;
>                         default:
> -                               BUG();
> -                               return 0;
> +                               goto invalid;
>                         }
>                         break;
>                 case CEXPR_NAMES:
> -                       if (sp =3D=3D (CEXPR_MAXDEPTH-1))
> -                               return 0;
> +                       if (unlikely(sp >=3D (CEXPR_MAXDEPTH-1)))
> +                               goto invalid;
>                         c =3D scontext;
>                         if (e->attr & CEXPR_TARGET)
>                                 c =3D tcontext;
>                         else if (e->attr & CEXPR_XTARGET) {
>                                 c =3D xcontext;
> -                               if (!c) {
> -                                       BUG();
> -                                       return 0;
> -                               }
> +                               if (unlikely(!c))
> +                                       goto invalid;
>                         }
>                         if (e->attr & CEXPR_USER)
>                                 val1 =3D c->user;
> @@ -410,10 +408,8 @@ static int constraint_expr_eval(struct policydb *pol=
icydb,
>                                 val1 =3D c->role;
>                         else if (e->attr & CEXPR_TYPE)
>                                 val1 =3D c->type;
> -                       else {
> -                               BUG();
> -                               return 0;
> -                       }
> +                       else
> +                               goto invalid;
>
>                         switch (e->op) {
>                         case CEXPR_EQ:
> @@ -423,18 +419,25 @@ static int constraint_expr_eval(struct policydb *po=
licydb,
>                                 s[++sp] =3D !ebitmap_get_bit(&e->names, v=
al1 - 1);
>                                 break;
>                         default:
> -                               BUG();
> -                               return 0;
> +                               goto invalid;
>                         }
>                         break;
>                 default:
> -                       BUG();
> -                       return 0;
> +                       goto invalid;
>                 }
>         }
>
> -       BUG_ON(sp !=3D 0);
> +       if (unlikely(sp !=3D 0))
> +               goto invalid;
> +
>         return s[0];
> +
> +invalid:
> +       /* Should *never* be reached, cause malformed constraints should
> +        * have been filtered by read_cons_helper().
> +        */
> +       WARN_ONCE(true, "SELinux: invalid constraint passed validation\n"=
);
> +       return 0;
>  }
>
>  /*
> --
> 2.49.0
>
