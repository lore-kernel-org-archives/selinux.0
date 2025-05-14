Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76E27A112;
	Wed, 14 May 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747247076; cv=none; b=WJoNKUHGyy5idjVfRIpMtQST364WYT+fmxrlB18Xxc4vQbahaikkzvr2berGLwv+1pcAIsZsNHgK2A5e57IVXedMnsPypfIaWof0jUTi+Kz0s7eRkcZpi7p6BQxH7Q0LT6yzhrouCzsdqUm9rtg7ZkDbGtwYfSi84g5D5GlH0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747247076; c=relaxed/simple;
	bh=u4bE+JoGvRyXp7HmR31mNZgrsyQSv9Mu4pvHA0ya990=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIu8jF1AXQsa2b3MIowHqo4JLwkyHZ18Cbd/vEo6UqUYCCTscUB5mblkuC2tLKtqQdaVy8TwYldQ/BfyD4/dFotzpA92t5QEcgw76v8/9MO4auZHaBhgkYmqXlfEAPNViyIU3mG5DuPQD1blJODPXlAyURu+KGWKdpZuJr2CcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/hMP962; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/hMP962"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30a8c929220so193251a91.0;
        Wed, 14 May 2025 11:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747247074; x=1747851874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piSbfKJRJsFdYn1Tp0vDZEziAUCdMJcpPh7Bt+nrbzM=;
        b=f/hMP962eLtninCt8l9nxRCBw+XohGm9uTO0YZCeLbOugYS34/bFBUXqeiLExgeGU1
         tDt18DiacC3tRj90jUfKSkNo/UXMbXiemoaRJT+7raUoWs7oXMiasBrUNhqnm1+M7Mt6
         VxOYgOwu6E5xotiNkNPs2QQ3WllGJJVrAsyUAVzBG+OU+otsM4fSFu1xy7+FhYjtlSI4
         W8XSrUicElp3ALLkuPBx4vjSpQUCqzHXbr7R8CcWdyxHhKWYC6Sto+Z9irGxrGAhUyjz
         inDbl0WgyoYSkuJIt8ho+xqmZNRI4RlbQtJEHbTNYU23/MRmc4QwVQ/8wasLhnhEWc4/
         78jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747247074; x=1747851874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piSbfKJRJsFdYn1Tp0vDZEziAUCdMJcpPh7Bt+nrbzM=;
        b=vDjNPQJ8b/q6lKm9g6qTmvF/Cu0bkvtYwYWXgu+oFPXAyZZU0YobJBoHMnPhvjG6HD
         vfOv9nAmZs/Klc/KT6c0A2+KC9ts4b5UFHNuVFUxx19dwowZYObQiVyUk6WEptJdUc8U
         iaDh0Ewb869/Hkn7je3tftG+4hzv+bxjQHoFwRWuj2iSuHW1t6uq2AcjFefSl5MgKWD2
         ymZtc4zAfYssqp0U59eXudNEbyyMSIOUhdAPM9qWb2cBt+a7b1ENyUCPqSWo42QxVPVn
         DSaMsNr4q6dBPU2kss+sTJKeakgL3PRtjJEC4AnCoSYh/s3j+a9h2f8P8n2lojjs+IXL
         lbxA==
X-Forwarded-Encrypted: i=1; AJvYcCVaezTXeSpCw2hPAWsIPo7TBunT0LBLfatrBp/rDevnI5fb5+SLotn27qq6lTWPMH4VEYrqbpHXGVylcrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnpargNci7tP9hGyu1FP+Arb3NMNQaSZk1h+YlpDq8LdlmrV8
	qscuZ3u3y5gZ0Kl4MFmqI6ZDpd87yy183Z83J8mUR/syHemd7IztCTiB426fE+q3s6KFW+06cca
	pvqCnAX3Vd52BAHEHEKWXqOBZmPE=
X-Gm-Gg: ASbGnct7NhNvz8n+27Lhm2m3l61NNRrshOoSSFlknmlFvZ8g5TMF4BUPr/c9sED61Hg
	gzYoAjmWd6kiOt/IE0lxKdKJdYKyK/WBwlkvEMZGH31xzlc7oFpQx6WIQXZAOAsaj12N3bNvQKZ
	yu1wmcKEYHQIFsIKmsQesVXx8v67K4rovF
X-Google-Smtp-Source: AGHT+IERoYisQRYFJ/fdok/fO29isseqPw/s5Opd9yaIozNjBL9q8/QzL7npdwV9NLyVFHrNdrxCPJsKuOVi/dFcEBM=
X-Received: by 2002:a17:90b:560b:b0:2fe:d766:ad8e with SMTP id
 98e67ed59e1d1-30e2e59bccamr7095948a91.4.1747247073845; Wed, 14 May 2025
 11:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-8-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-8-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 May 2025 14:24:22 -0400
X-Gm-Features: AX0GCFvbxMkuY17oY-D8wAxWly6wk9bbXtCXdYIcMPpEHk-VWofrdV7i6ISJEzE
Message-ID: <CAEjxPJ7ZpsmbV3AiEdEOCvUQBDAojn9XUhC6pzeOapPSYc2-Cw@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] selinux: reorder policydb_index()
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
> Index as soon as possible to enable isvalid() checks to fail on gaps.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/ss/policydb.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 27f6809b562a..326d82f8db8c 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -728,7 +728,6 @@ static int policydb_index(struct policydb *p)
>         pr_debug("SELinux:  %d classes, %d rules\n", p->p_classes.nprim,
>                  p->te_avtab.nel);
>
> -       avtab_hash_eval(&p->te_avtab, "rules");
>         symtab_hash_eval(p->symtab);
>
>         p->class_val_to_struct =3D kcalloc(p->p_classes.nprim,
> @@ -2799,6 +2798,10 @@ int policydb_read(struct policydb *p, struct polic=
y_file *fp)
>                 p->symtab[i].nprim =3D nprim;
>         }
>
> +       rc =3D policydb_index(p);
> +       if (rc)
> +               goto bad;
> +
>         rc =3D -EINVAL;
>         p->process_class =3D string_to_security_class(p, "process");
>         if (!p->process_class) {
> @@ -2810,6 +2813,8 @@ int policydb_read(struct policydb *p, struct policy=
_file *fp)
>         if (rc)
>                 goto bad;
>
> +       avtab_hash_eval(&p->te_avtab, "rules");
> +
>         if (p->policyvers >=3D POLICYDB_VERSION_BOOL) {
>                 rc =3D cond_read_list(p, fp);
>                 if (rc)
> @@ -2907,10 +2912,6 @@ int policydb_read(struct policydb *p, struct polic=
y_file *fp)
>         if (rc)
>                 goto bad;
>
> -       rc =3D policydb_index(p);
> -       if (rc)
> -               goto bad;
> -
>         rc =3D -EINVAL;
>         perm =3D string_to_av_perm(p, p->process_class, "transition");
>         if (!perm) {
> --
> 2.49.0
>
