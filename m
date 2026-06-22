Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE10076025
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159356; cv=pass; b=i/VHxaf7YeYh8eQtzwe330KKbXTkkIQ20ur4gQUb4zxicX2ZqFvcJROP1RNT7R6nrjrumj5MTm4i4AgNo2f0E9J8YVx7inuiPh8VLbJQ3B97uD0CJFkcheNN9F83/maY8jIqyaLJ+wyck4bObZtypVH2t7SRrD4l1/HadJxBI/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159356; c=relaxed/simple;
	bh=CQ0Is4w02YW51MX27JiRT80JOQiQ5vKewEqB3FXBVCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLJ7vU16eQAMegidf2DDovY5FkbKf7mdrvZEQJBixFpuliT8LSmB1pEt9nGsI/FkDgp6uzKPTgqIKSRPy7mqCogHXKyofB3QJqvqN7v9Fs5Rk1oEZ72FrLufZPp4IBU7Q9TMJuPcXI4ed8dKOPi4xUllohBIgGk7T2o1mq01QD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2gen39x; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2gen39x"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so2409417a91.0
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 13:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782159354; cv=none;
        d=google.com; s=arc-20240605;
        b=Bd+zSIAD+KnL9uiSgJ2Cy97l2n6MkpeVmHlf9PNPaNJg/1sm8QcmK71GVAVyd9mlcA
         h1bbbLGkLkYUS9+KMQ+v+BB0m1QePWkP4H0OoI2Ev1j1HoSFm/6X0xFp9wMpkrFNrRTx
         jffRjYn/AqT73mheEgbJuYz40Rm+RBUh3tBBsnG9MAF7SqbY5EK4d5rbxB7Su1hoESYl
         hJobdp+K5697s/gTc1WZFApsbD/ZI09xvvi6b2FRqDumhMFAQMkSWFnQyEHZFcI7aRGw
         F8jDAlZGW4hMHU9ydZjPRnqA/OPz5puqLKjb51Kgqvi+4PVtthbZROm6sTB5SCZwvpX7
         g3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SkrvZOAUzRQLYzsoDymhWaYyGXpBSO+WRVnEFYwu4k4=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=BaCmzYAC//rTXgeopX8LNk5VlNync1rUFYxvKuoQphhL5PoVKPOQsTmFA+A0ZfXdeh
         hxZvWj1XnL2Ss9fnHj33/cst+wlZYsTcDljf/pO+9gB73xPDTJH/s0ZDdVB11LC37OWu
         HiF2MF2cnL1GdAqKkcZMuCvVGvM7YgiGjmd8VrFABaN+YRJ9HWG2iKegBTifkiJrzeBc
         UHizygIZNFZlmYm/dszhnX9wCuj3Aq9PMDhuH0zj8SnFwGFXR/C6R+BjUKGd55ziSnOP
         n41JUyUXpDAIi8gjTsJxQ6ctpqI8E/5Ir0apgyYfsVE+PZIm6NKLDvDWRQ2CzrwRgcuE
         lK/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159354; x=1782764154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkrvZOAUzRQLYzsoDymhWaYyGXpBSO+WRVnEFYwu4k4=;
        b=N2gen39x1EjGRY3HZDIHsLDwIhs7MdazyA2YAxXH8Ku4RgdwsDbfm/Uf5AIBm7xHyO
         RFWSJtQ8sNHOxLXE7+4ByxpNfozr89MyS5gTCisr7+ANuh8Ayc34FwiFuoPBr2vVVGxq
         0oEQkFGZUs3vQLCoIfw9hXmEFs0DoYL3EDDY0h9QB5tljsB8FLmOFHxDZIXkiWTC7UST
         PIGsAzDVSVnYMWuD37BxPmT4tRayHy+BRg2aI2oZlVYs8o8MgSl1T0qkFnteVCAOJvRq
         bmRZ3R7ETzgAqE6ki6fOHvZ6GL4Y7QB5+FiXKungPuzGqiM0fFAfuz0AK190jk38pNmh
         xsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159354; x=1782764154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SkrvZOAUzRQLYzsoDymhWaYyGXpBSO+WRVnEFYwu4k4=;
        b=fui1DVv20VatW12Mq3uC2oyCE5znv9cNVgU9JKg3SAmQ+4GHIrcLBUWMZ2aOo90+cp
         +sLdfiptmbrYtHVPq92fjyUo/CAhX37N5ViXrSNOeAadZQtUzgZfy3e/klrUX76EyTTb
         9M53aknxfCidkuUFFwNlYdXRNm0Es43gb6KicuhOa0F7H/dUwTerVcE5iRgnWG8CEG+o
         icWnvSqGH4Vb498pQUEtgtDrPHelVz2Ppa7ta8qHGsJ0/lCEbD9KqDUd2E+8Z1lqpT3r
         Z5ZYyjbl2apck8MruTVvzRHTFqw4Y9U0xwXEie9l6QLun2X6ECcjRQ6JeaKt7wihfy7g
         XxLQ==
X-Gm-Message-State: AOJu0YzD4a4bgDwCifimQ8FJtsZMZF/8DvL2DquZMAhsV4smmG04nyfG
	VvVgyzHb8MwtIP6/zMWjwj/K0L5HkSmiC/HESj7S+yzNqg2I7byekbVp4ENs0JueOEIYpZDJmlj
	JrI8OSe8s15MP86bABOYBkrZkJvdd0yJ4sw==
X-Gm-Gg: AfdE7ckNVCm7xQ0KH1Sbqn8Fx9CcGBrN3OzfRgipGlvypo1/5fICm/FMB14ygfa33wQ
	wRYVMPKkRde+4uKIVwavcJbc68R8v37+5CjGeYWYeyA7TIrFoIxZupwtbXFlZ1KgZHKogs4w+mU
	wzdfv5/oYps2OaqnKGfDtYyd66YOIF/4DuvT7KEZ9qhH4gijFNk+EEszXV4cwZGYw4ES1/EEfJB
	WW8rkvE9edEos6e8g2YT03HENu3gFSTb8PxIls7f/hVL7SfjWc/plQTNQNltYbyWTiLiQSI
X-Received: by 2002:a17:90b:4fc7:b0:36c:e254:4db with SMTP id
 98e67ed59e1d1-37d15de2dd5mr14651199a91.6.1782159354069; Mon, 22 Jun 2026
 13:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430232437.56079-1-kalevi@kolttonen.fi>
In-Reply-To: <20260430232437.56079-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 16:15:42 -0400
X-Gm-Features: AVVi8CdkA675_qYnrnOzozVAAqrifCrEgCq1BOw_9iRAMkQJBuc0yA3URdiiaPc
Message-ID: <CAEjxPJ4-AeZu+ShswxoCcmZ1685MT-4sUhFkJf=kfaM4gSyAaw@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove unneeded goto and its label
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 7:25=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

As with the other patch, it is typical to include some kind of
description in the body, and
the subject line could be improved, e.g.
selinux: drop unnecessary goto and label from avc_alloc_node()

Since avc_alloc_node() doesn't need to perform any cleanup on its exit
paths, there is no
benefit to keeping the out label and goto statement. Drop it.

> ---
>  security/selinux/avc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 813e82bcfc27..a9401d6c2e5f 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -497,7 +497,7 @@ static struct avc_node *avc_alloc_node(void)
>
>         node =3D kmem_cache_zalloc(avc_node_cachep, GFP_NOWAIT);
>         if (!node)
> -               goto out;
> +               return NULL;
>
>         INIT_HLIST_NODE(&node->list);
>         avc_cache_stats_incr(allocations);
> @@ -506,7 +506,6 @@ static struct avc_node *avc_alloc_node(void)
>             selinux_avc.avc_cache_threshold)
>                 avc_reclaim_node();
>
> -out:
>         return node;
>  }
>
> --
> 2.54.0
>
>
