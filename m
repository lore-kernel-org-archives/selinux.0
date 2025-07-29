Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D057944E;
	Tue, 29 Jul 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797672; cv=none; b=I5LJmRAm0Lt7FfkUE9wDiKNq6R2Gy0l9EYbpBgo/ZzUQa7eGnf0dHsxgLnd0QIKQio5Wu0SgpI3aMR8bwVFIJx5EQy3WS7G04FK9k92pgPF78RaDGe4JyoCKyyShQbNYUMFvcVeAiqCDTngwR1iYxOuvr9i3kEbIR5YnCGJpqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797672; c=relaxed/simple;
	bh=r3HIC7Boxoc8WBzaUCJ1hQaQWM78N1Woz+Lqyxl0MTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7Nv8P43YULM2L1fkMyJ/CR9Dw5p4VM23oZ01rDGCIuvPjg4njw1Gric7EJuA/kSOJ1GOk9bB8vHEmzI64KhtiwKJ8IFndyI8cUeqBjlnyh+mwS75H2yJ4AQtPptiogW6fAOYBPUpDZOIkTMpZGrZvKcBhu7WqIKnH9uFN4NuPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8R0hUQz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8R0hUQz"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31f3b54da19so332231a91.1;
        Tue, 29 Jul 2025 07:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753797670; x=1754402470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5L+zwK3WhJ2pLBcL0OsL1prz9X5dOPsX+0ffaqpEcI=;
        b=V8R0hUQz0LNC1stDr8D0N0TlKML1s6HoGZ8r27jMnS2hClkzKwNAPBvNI7w0W8tKN1
         kbRkjYnRa6Pfuwz+1HUZYM89NjmoX6oIm0tb2tYWVHIQFWkP+LjFrzaIcWUg4SM5ytyP
         esftwR/8e39YFc1jQzrUjnimsr41Q+v/oCpdyrdkJmvVI5ExwWh4QG/5IXEhpf8QehBN
         f5/EZbh7ps0wj0Mlbp7XxEGRSl5cBPaGCHXVvQ7E7M3ib8CqmTqcckgn4qd8UIVv8QhW
         RAd6fUAtU8nKVZdncDXbj+/27EIQhYz15IygBS1o0YlhwpCyHow2InGCnvMhdYf8Z870
         omyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753797670; x=1754402470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5L+zwK3WhJ2pLBcL0OsL1prz9X5dOPsX+0ffaqpEcI=;
        b=T5jdgmOxxLOC6sKhCrSio161Xcle3PPRfVCAunYxj0dhIJHKI/7MxYIZejBVlHIH2m
         DQzNwhen6AeGuhh+FE6TNkKW/iOBh0ItQ65XBE4Q668eiyNd4dr9+X/+tOlUd16WwVcR
         /SaDJunAh/0C6JQE7OjN6ha/4ctMSMAZt+S1TZHgb11Jxo/wdnVg7ZGd37q1zWeeazXJ
         mcN5lVd4Cub2DbLwsCd0wI8gIv1aIzk46kuNjAxw3Hm3MuNyCd9Ad+J/Xh4UU9DV/+/n
         IMu0/MhPIhCgDE9jbNpMtTAIqr81cHFasWBf4OPoFU8527fxTeeSWy/2x85Ky+BeZ5Lx
         nS/w==
X-Forwarded-Encrypted: i=1; AJvYcCUZlEBensAx/0x2s265SutHZtq5X9k6cMQashLTjfkjV/G/47SNmj/6JSc0BIaAm/tFz9Wh9TbWMA==@vger.kernel.org, AJvYcCUmQY0LlRWd2LR2f+O38zkFp6syKkCSkH75iaVH4AQaiRSssIu53w97PxBm0lspfhkdF9iWjnEE+3xFvoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUS1mcgPqbCAPKolMQkVzrKmZTm28OhavdJ6A4qLeCXzyoBSop
	1A6/bqsdGhEYrkZVfrFQrP8S1mO2EDIIFqKFqrd2BDnWJzkQSWlSigo0Nep1HAAktRtdAAk4tiC
	VvBvuN60Hm0Xw9BCQrW+jtGpUiGzhRrU=
X-Gm-Gg: ASbGncs3tprryzyhS9FkUpXP3cWmjI3zSHtS2F/YWyOQJUOCt6OxsXwy5NGxF5KnbGa
	E3KJpAn4KRttltqB8OLfcr9mPGb+J/bRYa9RLgfxB3W9XTFmw4uB5+trWPf/ODsYaw9e1F3SifU
	Wy7B1C7RTdR8mmXvjUQk89lVhwsj7jO9puXjyr3b2/X2+6O+eoslQkv44Q7SzeQmE2YYphyA+qh
	g5iBvA=
X-Google-Smtp-Source: AGHT+IFW67L0lIMnI0+TrOex8d1GtwXQs7A9sNYwHJSYPTF2kRQ+LFfk0BstVUYBAFrEzrDIf7dvCFONgIbz05Um7uc=
X-Received: by 2002:a17:90b:3906:b0:312:e76f:5213 with SMTP id
 98e67ed59e1d1-31e77b0ede5mr21684773a91.28.1753797661341; Tue, 29 Jul 2025
 07:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729091044.95411-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20250729091044.95411-1-tianjia.zhang@linux.alibaba.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Jul 2025 10:00:50 -0400
X-Gm-Features: Ac12FXzD51pX5c-mQ16et67ewj8uzEI4xq6_UENn8a3U_oH5rQu6qNt1ntOGbYI
Message-ID: <CAEjxPJ6bPApxKRYt8KTcPcKez=2=mDV+f8xNF_UfO_jHawi8KQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: use a consistent method to get full socket from skb
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 5:10=E2=80=AFAM Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> In order to maintain code consistency and readability,
> skb_to_full_sk() is used to get full socket from skb.
>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 595ceb314aeb..362f92b2fafb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5861,7 +5861,7 @@ static unsigned int selinux_ip_output(void *priv, s=
truct sk_buff *skb,
>         /* we do this in the LOCAL_OUT path and not the POST_ROUTING path
>          * because we want to make sure we apply the necessary labeling
>          * before IPsec is applied so we can leverage AH protection */
> -       sk =3D sk_to_full_sk(skb->sk);
> +       sk =3D skb_to_full_sk(skb);
>         if (sk) {
>                 struct sk_security_struct *sksec;
>
> --
> 2.39.5 (Apple Git-154)
>
