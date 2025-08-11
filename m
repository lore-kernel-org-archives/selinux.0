Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B049122B8A1;
	Mon, 11 Aug 2025 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921511; cv=none; b=P5k1OyAxaKhfAdawYrS/LwxV9UXZ1dY93CoBNciMKsfbh5rvdq2cE+kCNqjMpQPD7TjMEae/w317cKZWieT3pgDoIpL9iHOZ0BvYQwREcLPKnyYrj0JUvxpjGQoMFh9T93XTMIc8CBkWxk0qScwSIi2dFzkZaj/CWHW6sdmevSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921511; c=relaxed/simple;
	bh=52zIl4g4wS8N0P4SanQ/XGwLGw2MUMPvXujSd05uaOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxDpd5jRAZnDdCO3TdDiWBAN8eTtpsj+b6XYnC7p6mmCjqjhheWLILnRgMi+Uz4zKbR37o4mZbTxUHrXTKc8tu76NkZLF2FD7M3BBTM83J5fqIPVOxvC/RKsNGDsaE9nh75iSa7OcAKQA47nJEpHvICwN9VhnMRHMUEBjaLTlYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd9n10Pe; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd9n10Pe"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31f3b54da19so3004154a91.1;
        Mon, 11 Aug 2025 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754921509; x=1755526309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqkO1hm1UmINOevs5zFUc44645SxzdI5Kvuf9lrylRU=;
        b=Qd9n10PekTpc9QactjQPFvOxfLb2cQx/uslZiemGnxM8eBlvhTmPTIEeGggThFB3Fi
         uP6UjxkCTxJ845ZcbMIYhEF8smUru9ZmI7ntzzmWIopJr9As22MVwhsWmehp8TvwSKWD
         LYusNNsACwGiJKtrEz5L07Hec0rT6sGdQj7NTHpK92BRjNh/GNe33yT+Q6p7f9Md/ik7
         LsYLV85iDX8ar02sD2SMbqY/PwF5WzI1KZ5T8VU6GfKGl5+Lk1Ak2gx+ZMFJK+jPW+rx
         ZFjnqod1kJBcvleqwey1jEvmAoveoHCuZwkEpuUdeF6C4golA7nQ84Rh1hZxiJkTCRPk
         vv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921509; x=1755526309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqkO1hm1UmINOevs5zFUc44645SxzdI5Kvuf9lrylRU=;
        b=D8tzYPScXRPaDW9LXKwZOSGPHAAR2qzn/8GPRn9DoSMwm2IpY16gU1Trqvq14DwBl8
         GXM+emX8r+QZJ/ONOJC+wJncawLlVhtkDgNBXOiRxi60SFuKOp9xXkKZzzU9viM5hIq6
         cYl+E6wdvqlzl7sg7FpPyY0LYfKp8kJxfdWBaf5/fQpSnLhz5qvz/13VJODKtmJ/NSPP
         C+cXEd53U+DIhztgYl2Ckm6IZmgcbFeYrALMYARseSeLUnrQa1p+jM7OY+MelINAOadH
         5ab31Stnkq+AQxh1yp1HFd/xqZvFhXvZmn4TFJoC/OdIzCCxAHmEmZrofo3Kcdf8faBp
         1qAw==
X-Forwarded-Encrypted: i=1; AJvYcCWSnCXZOkYkcCNs+N2M4gdW3sa2ISgEkF2dZJkJczm+iDvAzTf0MtBZd4Xx9W/JtKF5WjuCwDwtMg==@vger.kernel.org, AJvYcCWkqkObOB0K1sxVUvlQ7j+Bx8uNi5aOmhkLXfPFtGfbmHOrV6gvWMmEHEsZYUah4udBHtcVm4HS195Fmr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+FtycWwLtSgC+ZuOJB7Hf99bcIeKUBk5IhgPuvqwBl4cE6Gt
	3+NhR9zgjVP2swwoQMAOrkXsgsN9kkVK6WTh6QYqID33vCRzaPdeNwcAb6MXWo3RYw/doQGL9cp
	Y0E7r88DBmKWPwkX2jl2bRUT1d3wRVn4=
X-Gm-Gg: ASbGncuLtUjjbUEkDoCnvNQzknsZOD93VtE9lvZ9Q4PSWlSBNJpe4HfmfZaINs5Wbm4
	woeJA0Dn+0WyYCLsBWVVpLiWNw41v0mEzR1V2DQvQ4NdHOn2z0WBtnCy/enMxaMwXX1QMIlw5/T
	b8aCwZvuvFAfUqcWYgq9UbogQL0xxQXFqrLICHEdtVknbvyo9kPW3zY79DBJb/l4IeNRS1zwgFZ
	J38mU4=
X-Google-Smtp-Source: AGHT+IGBFTBUcWsEdEgyrkmhp2Bvgnup8SZT/3+JifAJM4YdWsB8S+wBmiiXvrDIpRrNTsYCO0lAlAdndeB4lTAmnb4=
X-Received: by 2002:a17:90b:314b:b0:312:e76f:5213 with SMTP id
 98e67ed59e1d1-32183c48f51mr16535466a91.28.1754921508739; Mon, 11 Aug 2025
 07:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807140545.566615-1-rongqianfeng@vivo.com>
In-Reply-To: <20250807140545.566615-1-rongqianfeng@vivo.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 11 Aug 2025 10:11:37 -0400
X-Gm-Features: Ac12FXyVyuw8Vpq0VyuJBUsGzOFQ-Gc0j-wBxDgNMv1MPzPyhkMSbJ_dOogGPDI
Message-ID: <CAEjxPJ7j_cKGygKBbiEzAruFXEiUyToSHWopjLEKgJFq6UrYEA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Remove redundant __GFP_NOWARN
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 10:06=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.co=
m> wrote:
>
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
>
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
>
> No functional changes.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/avc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 4b4837a20225..c70053f2806e 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -293,26 +293,26 @@ static struct avc_xperms_decision_node
>         struct extended_perms_decision *xpd;
>
>         xpd_node =3D kmem_cache_zalloc(avc_xperms_decision_cachep,
> -                                    GFP_NOWAIT | __GFP_NOWARN);
> +                                    GFP_NOWAIT);
>         if (!xpd_node)
>                 return NULL;
>
>         xpd =3D &xpd_node->xpd;
>         if (which & XPERMS_ALLOWED) {
>                 xpd->allowed =3D kmem_cache_zalloc(avc_xperms_data_cachep=
,
> -                                               GFP_NOWAIT | __GFP_NOWARN=
);
> +                                               GFP_NOWAIT);
>                 if (!xpd->allowed)
>                         goto error;
>         }
>         if (which & XPERMS_AUDITALLOW) {
>                 xpd->auditallow =3D kmem_cache_zalloc(avc_xperms_data_cac=
hep,
> -                                               GFP_NOWAIT | __GFP_NOWARN=
);
> +                                               GFP_NOWAIT);
>                 if (!xpd->auditallow)
>                         goto error;
>         }
>         if (which & XPERMS_DONTAUDIT) {
>                 xpd->dontaudit =3D kmem_cache_zalloc(avc_xperms_data_cach=
ep,
> -                                               GFP_NOWAIT | __GFP_NOWARN=
);
> +                                               GFP_NOWAIT);
>                 if (!xpd->dontaudit)
>                         goto error;
>         }
> @@ -340,7 +340,7 @@ static struct avc_xperms_node *avc_xperms_alloc(void)
>  {
>         struct avc_xperms_node *xp_node;
>
> -       xp_node =3D kmem_cache_zalloc(avc_xperms_cachep, GFP_NOWAIT | __G=
FP_NOWARN);
> +       xp_node =3D kmem_cache_zalloc(avc_xperms_cachep, GFP_NOWAIT);
>         if (!xp_node)
>                 return xp_node;
>         INIT_LIST_HEAD(&xp_node->xpd_head);
> @@ -495,7 +495,7 @@ static struct avc_node *avc_alloc_node(void)
>  {
>         struct avc_node *node;
>
> -       node =3D kmem_cache_zalloc(avc_node_cachep, GFP_NOWAIT | __GFP_NO=
WARN);
> +       node =3D kmem_cache_zalloc(avc_node_cachep, GFP_NOWAIT);
>         if (!node)
>                 goto out;
>
> --
> 2.34.1
>
