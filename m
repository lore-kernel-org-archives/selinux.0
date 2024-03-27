Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325B14D444
	for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558587; cv=none; b=XZYkMdxtoQP0CPg6/l8QbDkPvaRSHK8nTutmHu5FoGAhhBshI1q/DdrT2ukOIbAG3xv9ngPkvhF8238VpMgIe5obITkEjMXX4P52oIgymOGKFgBlRoYmF1jL8wtsjFvEt7c5103PopaYn/aVlrsjDPREiL/1vl0LYHdeQskMBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558587; c=relaxed/simple;
	bh=4a5q5dgIFfgFSbTuqq5J6bB/FieeXf1/IEeoLjPXFYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsBJPZeIeWWOYpl8SeSUvHz7I4wgD9YyCPgnOgGIdHHmrCNEyNLomAC9e7RWGPZm75A2Fp5HVgAfk1xo6PG/Tjn0TnnbncGNLRrfupXqWc5qxJcIE96TpithZiYlQ+z6LmiBjkJh4z48X/QfG9M90AvR8O3wY66Glp5pai2aDhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YvTR/yer; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YvTR/yer"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso6809803276.1
        for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1711558584; x=1712163384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qLUTDYSXasZ3zz7pI1IjOBJvAqeSImkwCNvEMNN/S1E=;
        b=YvTR/yerzSytSjjJxVceUhxdEfDQrhAZXXi5K6ljiSu7ktKv48qmt4lPAFFbD63G0l
         9+hzuHbvWu6b7OHS0dYZ2onek46VsSU8rVlQ4jeIApkBZ8POZiiejkWbHDlxDnciAW/U
         whq3XqOL6UJChaKy7Iaft1r6A/Bz+p2l4CtAhi/vVJN6el9mr6GNoh7WySOW6NLfOVCh
         5PIlqAOpTkLAashobcAhSAj9rfwwW5hA6rSLl4AmOHGG9wtiPmfRh5ylp+NsKzEhxfQC
         jcpBhZBTnp+p/4DG4lTOyxw3e0+TWkhdrw2xy8X/V5NOSy7YPZ9LbG9o+rhOlisY+Mek
         9b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558584; x=1712163384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLUTDYSXasZ3zz7pI1IjOBJvAqeSImkwCNvEMNN/S1E=;
        b=lTDkFW1SiOp/TBxieFttcngKJh4iNx2DEv4g4h/LI1xEztrOvh4p5bKHXQpVByfm0z
         clsHsPkm2OushZX+5T3apOWBp++0M6nbBuxQUruz3Ne8vaGGtGpswEU8iJ4rz4+B7Pzl
         829id5Gh+HScGpnF0VumHpvdImXzLdFE54qb6fFlxicu2sG1vBZhKP/Xl0bq0qA+md9m
         YG2zK1zVbq2rS+RQMNm1gUVhoZNLSk/8lUvcUur1g2sCVdwy3eJXibrNyq4esm4yoOzi
         ZzMVoRm4ReD3larKdienGzloR1BWSf/eLOm+entHWu3u2wRzuM/nG37wjAmE+2F5934Y
         iTrQ==
X-Gm-Message-State: AOJu0YyURg1RpMB029V1b1+esQCVid4owVyqYNxv+bMqzEjVAwy7b4Ao
	QixfkkUrG5pPBsQ0YEjTZjT7tsTikzB+py0GL22faDGKe/fkxqzW8h3WQt96R7UuCU0lBpRZiqj
	NYeJ0T4jkJSgO2TtdiYfWUbmQU/U=
X-Google-Smtp-Source: AGHT+IESZekPFMdnEm9pNgaGmH/nxgzaEcuHIRHKb6C56huHRoCUeCSM8ov9ygSFZKQ85BorFXdrCDDDe+7nsREpLiY=
X-Received: by 2002:a25:804a:0:b0:dcd:5635:5c11 with SMTP id
 a10-20020a25804a000000b00dcd56355c11mr410636ybn.45.1711558583959; Wed, 27 Mar
 2024 09:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327155201.117066-2-paul@paul-moore.com>
In-Reply-To: <20240327155201.117066-2-paul@paul-moore.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 27 Mar 2024 17:56:13 +0100
Message-ID: <CAJ2a_De6-AfBZ6fAwe-3hzT-r4v=RfaxQ8YyQ4v-MWNei0j_Pw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix pr_err() format specifier in ebitmap_read()
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 16:52, Paul Moore <paul@paul-moore.com> wrote:
>
> Correct the use of integer specifiers when printing ebitmap and
> ebitmap_node information.
>
> Fixes: 0142c56682fb ("selinux: reject invalid ebitmaps")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ss/ebitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index f1ba333f127d..13d5fb47a2bb 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -461,7 +461,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>         }
>
>         if (n && n->startbit + EBITMAP_SIZE != e->highbit) {
> -               pr_err("SELinux: ebitmap: high bit %d is not equal to the expected value %ld\n",
> +               pr_err("SELinux: ebitmap: high bit %u is not equal to the expected value %lu\n",
>                        e->highbit, n->startbit + EBITMAP_SIZE);

Maybe %zu is more appropriate for the second argument?
`n->startbit + EBITMAP_SIZE` should be of type size_t since
EBITMAP_SIZE is computed via sizeof().

See https://www.kernel.org/doc/html/v6.8/core-api/printk-formats.html

>                 goto bad;
>         }
> --
> 2.44.0
>
>
