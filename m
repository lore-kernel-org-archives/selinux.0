Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658862E7BBE
	for <selinux@vger.kernel.org>; Thu,  3 Jul 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553361; cv=none; b=MdrWuBQQ9H6yVCXKOii9NuhJbPbkFZ8UbqzB+g5qX7v6/wLSjZs4AOZQ7AjHVblTXlsqS406+ELiP6q/1TcIUKku081xpg5gHhL0BLSg7yR9iXOlJOZ6A/liyG/ZkfoS+vR63NYQ6iFWZk3xgLnGyJGXZp2QhbzjHY3YgRP6gow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553361; c=relaxed/simple;
	bh=EpLuuakZ8l/T8DilPuITsFryqEd57MFOu9vbGX1LxMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eAY0Pse3cQukHcLwQ71sUKCKf42UeoW8WXyme2FMPgtx5XWdhRI2nEUSvCxAi0/WXE1ZwAo4PY5aFEMnXInMQdyEbQjptTkL3OCB8DLo0o1VDHDeDXf+UfFem/JMtYBja6gUirFiGwn6QHQRHyEzD1tJDp/q2RAf6Acwy0hT+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W25ntPiK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W25ntPiK"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ecf99dd567so78431366d6.0
        for <selinux@vger.kernel.org>; Thu, 03 Jul 2025 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751553359; x=1752158159; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtUcqUqlMxdRFmCIwA0SYFvvOLYalLhDKFAoHv85RgY=;
        b=W25ntPiKeAvPUsrJaUOxq/Ev/hjlBKrPFZtZveiFkUYt87Ola9l5mzIVZnyVjv3kvC
         DVdvczuBK8dr5lIoVDC9vPzIRbpeLcmMFqslnTgt3mfAV11G5tc0CDjMdLM+nk3oSNu5
         lzDH3dIgTE3PLKHkKQfmHl3xtLRcshQejaOYXiYT7oOamcVD2Kn6egzOLAXnjEKhz3yz
         K+i3KgFaYg1jdkBDHoizjSIlhmcn926Q5NEMJXiBA4AuQqILMzxRzivvHDhXjRLBiEN4
         FGgxnYw3k2ByzGdh78G8RQIgsPpiFBC9V3NAb0GG6nAn0bcuY95xvZAV/0u8pbpaz+qF
         EfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751553359; x=1752158159;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtUcqUqlMxdRFmCIwA0SYFvvOLYalLhDKFAoHv85RgY=;
        b=SZs7ychhG2U1Yqs7XQu91rmOANhDEkIr0KmMXUzFY2eQadPkB+aHLrMBi6LfjSKsGv
         tlFjfhKIkgcp4//XBfL0G3QAlgjTtpPM4Xa9frJ00JJYcRaG6mYN/1c3DL2/AbnaqasX
         RJVvNMFwueP1Zwi/ZqYh5E6Jin6LAp5PYM9576mQKwV5mdTNgFX6NXgPEn2FyvYh6HCs
         Vss/CrJWYlNwwpPv+tr6cBwQcXkNt66cTRE6Z/jrR2Xqx76ahi5O82S7fPuNmGQASkBh
         pnLniPMBPUhowX7nu2bR1GcJud/R+cwWsImawBEn5NzhNAyCd1/xkTvfo3AKBEJfDrbI
         VQ0Q==
X-Gm-Message-State: AOJu0Yza6w3P9x8suIbloAPOkHyvgKY3cmcO7Jnk88guTPGEvnWAa+iM
	9TlbK7iaW71QvJGBNoH0oTHp6SWXKG3LHDIHvIjp1ycEJ2UNkUM7Z/JauBCpyz6cozdW9hfqHuM
	IXyCTN4ozRCukRim0FJMdJCWeETslbJIfmA==
X-Gm-Gg: ASbGncuOR24q+9MwIC7fLN5iAK3IHU3v+6evF4ksCpiA1VJgoC6YQcIF6mNdZo+EXfO
	C1U5PAstu6lDebNtxcUAqm5+PU+9ZDj1dXOjRd8MZuXRgUdKVDVuZgMH2GPo6Oovtoyk+wBPIRu
	MNTc58k7Je0A5t9LFDOWV4m7WBxNpYKIxziiNzLFHN
X-Google-Smtp-Source: AGHT+IH3WQXoaVoL+kkwz2+aOhSVBNXjw8175k6NkXMCFMUBWRe8VW6j5ld7Mw4v5AUnk9p0v3Y0licTFA/y7b1opwk=
X-Received: by 2002:a05:620a:1d0a:b0:7d4:3bb4:3335 with SMTP id
 af79cd13be357-7d5c470f99amr843343985a.11.1751553359136; Thu, 03 Jul 2025
 07:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701121353.259016-1-jwcart2@gmail.com>
In-Reply-To: <20250701121353.259016-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 3 Jul 2025 10:35:48 -0400
X-Gm-Features: Ac12FXxo2tTSvgsESkC6fBMbUHQpa5Q56JZ-n0MXzGdaFX4yMW8P0qdFHeeXCfI
Message-ID: <CAP+JOzS-2CCwzm8WLB6S4ZOot_xnpCuw31E_qDz=P5E6vrYG5g@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Expand class-permissions in deny rules
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 10:20=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The classperms list of deny rules is not being expanded. This causes
> an invalid read if "all" is used in the permissions.
>
> Evaluate the classperms list of deny rules.
>
> Reported-by: oss-fuzz (issue 398075935)
> Signed-off-by: James Carter <jwcart2@gmail.com>

Seeing no objections, I have merged this.
Jim

> ---
>  libsepol/cil/src/cil_post.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 70e5b734..2b6dad73 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -2265,6 +2265,14 @@ static int __cil_post_db_classperms_helper(struct =
cil_tree_node *node, uint32_t
>                 }
>                 break;
>         }
> +       case CIL_DENY_RULE: {
> +               struct cil_deny_rule *deny =3D node->data;
> +               rc =3D __evaluate_classperms_list(deny->classperms, db);
> +               if (rc !=3D SEPOL_OK) {
> +                       goto exit;
> +               }
> +               break;
> +       }
>         case CIL_CONSTRAIN:
>         case CIL_MLSCONSTRAIN: {
>                 struct cil_constrain *constrain =3D node->data;
> --
> 2.50.0
>
