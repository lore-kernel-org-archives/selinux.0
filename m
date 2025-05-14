Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB2211A16;
	Wed, 14 May 2025 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747252420; cv=none; b=Re89Lpm+eCa/0LaDD3PcpOjxMJpl2XTkEfIrcVoyfcx3bV5C7/IEexkNKNiSIYe2Wu8ijCSum4Gstw2eDB9MYU88rQgdANW6rC8Wvux4JYOlcDAZk+UpQ46GXVtDc/Qvz254vo5ZDsz2/QGi6ZapZBxL/QEhpfDO7JX7tXOPEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747252420; c=relaxed/simple;
	bh=o5tDTGaiHLshY8OjJq/NGSYaAhRRUPZLjeGgRea7MvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2r6/J0epZfWHGYT684fVleC5DQKQBeRqlRHwuV+UGn3v8QlH/j4U3WuKw2k657iwS3RBL6kAOpEFFSC+nAfu8bAIRvpSGey8QVkyfj0EGXNg/pLERkDNrjWJnW+cd8N/Hrwf4uTz49cnDHLLaOzd/Rx8voJgr0voDC7mXpQBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+aRdVKe; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+aRdVKe"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b1396171fb1so52110a12.2;
        Wed, 14 May 2025 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747252418; x=1747857218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRIf9FO0hwoJQSudwVQSivI2zAyJ6bf8L2XajTcHFwA=;
        b=a+aRdVKe92TJFTI7P0/p4s9+cvLs1sTj9d2EhS3ToTFzB8i0yHMGu5G+XD7Muqzayg
         BCA8bDLGNRq6I9qCrmGo1BHsIDhdJ5X2loFc69NeZCTkwUaUqlZiiiBwHOkVZzEKsM1d
         3/uqPvtTwKvehDdazFyHgI8HmoQAnyBUTd6tJ+8RFEVg0HcMw8pbexoiMAHVbdPzpcUH
         5bIoo1+P8h5ss1AnmBgi+XjN0amojKjZIAev3EYDvJMrtqmPg1v+MmVrIpOyKj+cDwNM
         KD8NOFlR2O5OXSSXLXNtMQj877ALyALjPXvWxqgqXMyFcAUyvwvPtT0UnP0y9DCMq/os
         RstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747252418; x=1747857218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRIf9FO0hwoJQSudwVQSivI2zAyJ6bf8L2XajTcHFwA=;
        b=RK4YkHtD+bf5PIQl5jrWCYl8VLguou7mlemUANvjzPgI/e0EbKt0QaHXm8NbUJnYiI
         Tepwe0gDhah3ykjV3Mc/FpyCzQxh+j52yAywchgZd89T37ZvT29400TpeJ8dQZsitwYq
         qQ2DkYdIDCvOVQenqT0zXa3uDURH5pbPvp2Yd564gmIuGQnrtTJSEOA/g/YcvpG0uURA
         6N7zLMvebHCaGyUbZKU/d+zdjcP1Zdm5s2Sosnma+k20qJinyCEV2QGs21t6ADhxs+3/
         FRXQXtPnyeueN3yxsn3iGMQwfSDVQFC0eRm+50BGiV0OWcc+dbAhlQtCoTvV1LZnORfJ
         u05Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbUyK4/Z/Tl59RRXLLil0YMuwjzHvC9zaEag5/IC9dhSrGodiiSIcgqbBbtXwJ+6pye8KN9IRxD2thGx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVoeZh85cUDTC6jK1EQFjLPBId+w2/KaKTKWN1OpN0Ybe4l1q
	vMNjN6k3ho87iYAvFKk3Yoa7bPMDxTagp1ItpzK7BtP8xX9Kr9K8Pfm3G6rWPq8bADmrJAVuHfa
	tfcvKrcq+zmlSYe5676skn1Taeoc=
X-Gm-Gg: ASbGncvOdW2urFL7us2SZ863zcPAluIK3seCdqmkpZHJlvjtTm6U6s+a0d12ttuvdaM
	Jvf23UhKNi1xgmdXREX2pEpzhvk+uwk7TWFwiAHYPfSO4/nX3ijKj4LjuMVtFtK3qZpaJ+jRM69
	N8lLAt7TgwU68pZcy+vWkju8030hYzgLcq
X-Google-Smtp-Source: AGHT+IFOC0DDoT9GlWD8T1q+isjp9mb/BojgYP2KxE58FD1VAYDQ4POHjr1Pvowm24hdS8Yg0FeBjay1oiOmx+8YF7Q=
X-Received: by 2002:a17:90b:560b:b0:2fe:d766:ad8e with SMTP id
 98e67ed59e1d1-30e2e59bccamr7460665a91.4.1747252417564; Wed, 14 May 2025
 12:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-14-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-14-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 May 2025 15:53:16 -0400
X-Gm-Features: AX0GCFt6tOS69tJSh3Ewsfsjru8ywew2zWR-WDHav3k3dPgw9g0D__mhxsv6AB4
Message-ID: <CAEjxPJ4Q8_PjvvXR9JAs307A0n-9xxS8LkLWE5NmeLgiF-NrdA@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] selinux: harden MLS context string generation
 against overflows
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
> Check the length accumulator for the MLS component of security contexts
> does not overflow in mls_compute_context_len() resulting in
> out-of-buffer writes in mls_sid_to_context().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v3: add patch
> ---
>  security/selinux/ss/mls.c      | 18 +++++++++-----
>  security/selinux/ss/services.c | 43 +++++++++++++++++++++++++++++-----
>  2 files changed, 49 insertions(+), 12 deletions(-)
>
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 3cd36e2015fa..aa25724f0b0f 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -42,7 +42,8 @@ int mls_compute_context_len(struct policydb *p, struct =
context *context)
>         len =3D 1; /* for the beginning ":" */
>         for (l =3D 0; l < 2; l++) {
>                 u32 index_sens =3D context->range.level[l].sens;
> -               len +=3D strlen(sym_name(p, SYM_LEVELS, index_sens - 1));
> +               if (check_add_overflow(len, strlen(sym_name(p, SYM_LEVELS=
, index_sens - 1)), &len))
> +                       return -EOVERFLOW;

I don't believe these checks are necessary, especially once the other
limits on identifier lengths land.
The same applies throughout.

>
>                 /* categories */
>                 head =3D -2;
> @@ -54,24 +55,29 @@ int mls_compute_context_len(struct policydb *p, struc=
t context *context)
>                                 /* one or more negative bits are skipped =
*/
>                                 if (head !=3D prev) {
>                                         nm =3D sym_name(p, SYM_CATS, prev=
);
> -                                       len +=3D strlen(nm) + 1;
> +                                       if (check_add_overflow(len, strle=
n(nm) + 1, &len))
> +                                               return -EOVERFLOW;
>                                 }
>                                 nm =3D sym_name(p, SYM_CATS, i);
> -                               len +=3D strlen(nm) + 1;
> +                               if (check_add_overflow(len, strlen(nm) + =
1, &len))
> +                                       return -EOVERFLOW;
>                                 head =3D i;
>                         }
>                         prev =3D i;
>                 }
>                 if (prev !=3D head) {
>                         nm =3D sym_name(p, SYM_CATS, prev);
> -                       len +=3D strlen(nm) + 1;
> +                       if (check_add_overflow(len, strlen(nm) + 1, &len)=
)
> +                               return -EOVERFLOW;
>                 }
>                 if (l =3D=3D 0) {
>                         if (mls_level_eq(&context->range.level[0],
>                                          &context->range.level[1]))
>                                 break;
> -                       else
> -                               len++;
> +                       else {
> +                               if (check_add_overflow(len, 1, &len))
> +                                       return -EOVERFLOW;
> +                       }
>                 }
>         }
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 464a4663c993..dc6dce2eb7d2 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1247,10 +1247,12 @@ static int context_struct_to_string(struct policy=
db *p,
>                                     char **scontext, u32 *scontext_len)
>  {
>         char *scontextp;
> +       size_t len;
> +       int mls_len;
>
>         if (scontext)
>                 *scontext =3D NULL;
> -       *scontext_len =3D 0;
> +       len =3D 0;
>
>         if (context->len) {
>                 *scontext_len =3D context->len;
> @@ -1263,16 +1265,45 @@ static int context_struct_to_string(struct policy=
db *p,
>         }
>
>         /* Compute the size of the context. */
> -       *scontext_len +=3D strlen(sym_name(p, SYM_USERS, context->user - =
1)) + 1;
> -       *scontext_len +=3D strlen(sym_name(p, SYM_ROLES, context->role - =
1)) + 1;
> -       *scontext_len +=3D strlen(sym_name(p, SYM_TYPES, context->type - =
1)) + 1;
> -       *scontext_len +=3D mls_compute_context_len(p, context);
> +       len +=3D strlen(sym_name(p, SYM_USERS, context->user - 1)) + 1;
> +       len +=3D strlen(sym_name(p, SYM_ROLES, context->role - 1)) + 1;
> +       len +=3D strlen(sym_name(p, SYM_TYPES, context->type - 1)) + 1;
> +
> +       mls_len =3D mls_compute_context_len(p, context);
> +       if (unlikely(mls_len < 0)) {
> +               pr_warn_ratelimited("SELinux: %s:  MLS security context c=
omponent too large [%s:%s:%s[:[%s:%d]-[%s:%d]]]\n",
> +                                   __func__,
> +                                   sym_name(p, SYM_USERS, context->user =
- 1),
> +                                   sym_name(p, SYM_ROLES, context->role =
- 1),
> +                                   sym_name(p, SYM_TYPES, context->type =
- 1),
> +                                   sym_name(p, SYM_LEVELS, context->rang=
e.level[0].sens - 1),
> +                                   ebitmap_length(&context->range.level[=
0].cat),
> +                                   sym_name(p, SYM_LEVELS, context->rang=
e.level[1].sens - 1),
> +                                   ebitmap_length(&context->range.level[=
1].cat));
> +               return -EOVERFLOW;
> +       }
> +
> +       if (unlikely(check_add_overflow(len, mls_len, &len) || len > CONT=
EXT_MAXLENGTH)) {
> +               pr_warn_ratelimited("SELinux: %s:  security context strin=
g of length %zu too large [%s:%s:%s[:[%s:%d]-[%s:%d]]]\n",
> +                                   __func__,
> +                                   len,
> +                                   sym_name(p, SYM_USERS, context->user =
- 1),
> +                                   sym_name(p, SYM_ROLES, context->role =
- 1),
> +                                   sym_name(p, SYM_TYPES, context->type =
- 1),
> +                                   sym_name(p, SYM_LEVELS, context->rang=
e.level[0].sens - 1),
> +                                   ebitmap_length(&context->range.level[=
0].cat),
> +                                   sym_name(p, SYM_LEVELS, context->rang=
e.level[1].sens - 1),
> +                                   ebitmap_length(&context->range.level[=
1].cat));
> +               return -EOVERFLOW;
> +       }
> +
> +       *scontext_len =3D len;
>
>         if (!scontext)
>                 return 0;
>
>         /* Allocate space for the context; caller must free this space. *=
/
> -       scontextp =3D kmalloc(*scontext_len, GFP_ATOMIC);
> +       scontextp =3D kmalloc(len, GFP_ATOMIC);
>         if (!scontextp)
>                 return -ENOMEM;
>         *scontext =3D scontextp;
> --
> 2.49.0
>
