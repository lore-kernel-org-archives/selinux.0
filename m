Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67006246344
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940181; cv=none; b=Td1F9mLH197cLiagDhFRXN/hQ8TL6oowX+hythk2bQqK7ElqaoDLVLhDHeeOIJ8eiPy2fX1zDDeIF/OOHHGd+xmnChA05PRflOGIEJPCoQWrgH4UVHAGt7Hq9r/EgEpfFTLPaTRQPNp7ge1nz80EIQqFnYcaTr6qejzcbLMMFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940181; c=relaxed/simple;
	bh=nS7HyS4ozxW9sPRYjPUD/a5phvFyGZFlPgAOVWKF+uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hm5hjXv2BNJSfvQ3x9LLnXtXwcgmDl6LApt2Ty7YMr/JWQsjJDGSzYyZEb8XS2HeepYpIn6aMuawTvVqpulZod4EWFG5RvO+R2HOaDELyvKtf2OASg2lq6JRJQXIP2iZvMIqfEREYnXyYasD4x71GiaEIvOq0yie0HuZPXRvD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N1lfyNT1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N1lfyNT1"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f006748fd1so36917097b3.3
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 10:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733940178; x=1734544978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqtcPeGztb2EjLpFwZkziN/sq/KtEWy6S2Bxg643PTU=;
        b=N1lfyNT1s5uitXj87cF5ZCuNw0OzDiNymqof689Q+Aw8u3HB2OA9kqN5N2+mxpuYHO
         3fIPYYz2nglWHGegls3mKnRQUvqv/Zj2Ua7MA/3KlnJf19wXW+zvDgGR/G9M8yC4+dc7
         UWpcsbCwDzD2sLAV2z3TJdncyEZlHaJfASes/H3FfZ7PDshdHcPBaKoaVJ4RIObxq+XN
         ogbP3lXT+f91uC6p9GUCFTElBd4Cd8YhoSQ5Kqt9vwn9H6vU/FCoBucBqEcIdAfZrEdm
         8a/wWHgdAmcrJRwko+x8PI+BYT9nEuyWqS+Oda2XJicxfxMOapx0EhPbpB3ht8TMHjnw
         ISig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733940178; x=1734544978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqtcPeGztb2EjLpFwZkziN/sq/KtEWy6S2Bxg643PTU=;
        b=D/Q132YDThYmNiLlomjnJjTeNmARyUFM5Kxo3BhirD7JRwYlA9u3S+HnVo674VhWHn
         l5FKsE+wx5XaA91uMXLy92PP1JY81m6bAax9gSaStAKV9mJd9w/iakfJmbQTSH1tEZLL
         t5HlkAXZpCXn9EDQCwb1NjoBV4hw/G9qCVZ68QhXYIEUaRQLXzWDetywtNammYfPtXNf
         vqdhLqxQnOD0dswM7LdTe7vmO0QpY06WtFftsWtNGmdvd6Q7LUGk0Nq8kC0dMOSXoZ1o
         g6OBM6u8EsbYxlzQGR9X0YDnQkimSjXy3GAxEo3UV7hWvDq7esnNqQTDPamo6tGO2dUZ
         gZiw==
X-Forwarded-Encrypted: i=1; AJvYcCWsGD0jEKSF04gKlhBt8INs/FhgmsR5x537Q01nMWLaZbp5LyaVpzv+P/vrsPMa4/ccf/SBrRTT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9L6KhmAesy679g8G6wn37AN+6o9NIvq36gXlgonDcjmY6vujT
	vc7KoH4hp5+SnJwjNaXGcKkrdg7uLJam8hReH+Oba6zN0ghK0Q+Zy6O5jpMTfXDeAfCzlFJ73xh
	NeDMvaAfzz0taQcKvbOKEenhFnR6h6HS2DGlD
X-Gm-Gg: ASbGncvATSnQtLmuiulLGly9+wFSmNb/YnjvT7g1QwRYM0IZ2OZ3AH4MR3mQ4c/QmYj
	nhMwLoKhnFzRKNZ3izo3vj8iTKzjoiaoknw==
X-Google-Smtp-Source: AGHT+IGhaiFjX/L099aGUNCtwGLyut2XxdA9jeU0mNzlqVQ9FVK9XIMu333rd8wujZZNnZZmrQ7W8WIJ6CN1dUDcaf4=
X-Received: by 2002:a05:690c:314:b0:6ef:61b9:dfd4 with SMTP id
 00721157ae682-6f1a50fa362mr3546537b3.30.1733940176912; Wed, 11 Dec 2024
 10:02:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210010030.2854024-1-quic_jiangenj@quicinc.com>
In-Reply-To: <20241210010030.2854024-1-quic_jiangenj@quicinc.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Dec 2024 13:02:46 -0500
Message-ID: <CAHC9VhSNc5AeVDh69SV9-pSLgsC1T0Fip=Y3nepYCdc8FBFijg@mail.gmail.com>
Subject: Re: [PATCH] selinux: KASAN; slab-out-of-bounds in avc_lookup
To: Joey Jiao <quic_jiangenj@quicinc.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:00=E2=80=AFPM Joey Jiao <quic_jiangenj@quicinc.com=
> wrote:
> From: "Jiao, Joey" <quic_jiangenj@quicinc.com>
>
> BUG: KASAN: slab-out-of-bounds in avc_lookup+0x174/0x298
> Read of size 8 at addr ffffff8846ef70b1 by task spdaemon/1037
>
> Call trace:
>  dump_backtrace+0xf0/0x13c
>  show_stack+0x18/0x28
>  dump_stack_lvl+0xd0/0x128
>  print_report+0x13c/0x6f8
>  kasan_report+0xe8/0x148
>  __asan_load8+0x98/0xa0
>  avc_lookup+0x174/0x298
>  avc_has_perm_noaudit+0x60/0x12c
>  selinux_inode_permission+0x278/0x3cc
>  security_inode_permission+0x84/0xc8
>  inode_permission+0xb8/0x2b8
>  link_path_walk+0x178/0x7c0
>  path_lookupat+0x6c/0x298
>  filename_lookup+0x11c/0x2e4
>  vfs_statx+0xb4/0x3f0
>  vfs_fstatat+0xfc/0x3e4
>  __arm64_sys_newfstatat+0x88/0x340
>  invoke_syscall+0x6c/0x17c
>  el0_svc_common+0xf8/0x138
>  do_el0_svc+0x30/0x40
>  el0_svc+0x3c/0x70
>  el0t_64_sync_handler+0x68/0xbc
>  el0t_64_sync+0x19c/0x1a0
>
> To fix this, protect the rcu read access
>
> Signed-off-by: Jiao, Joey <quic_jiangenj@quicinc.com>
> ---
>  security/selinux/avc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 32eb67fb3e42..ded3823d4451 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -528,6 +528,7 @@ static inline struct avc_node *avc_search_node(u32 ss=
id, u32 tsid, u16 tclass)
>
>         hvalue =3D avc_hash(ssid, tsid, tclass);
>         head =3D &selinux_avc.avc_cache.slots[hvalue];
> +       rcu_read_lock();
>         hlist_for_each_entry_rcu(node, head, list) {
>                 if (ssid =3D=3D node->ae.ssid &&
>                     tclass =3D=3D node->ae.tclass &&
> @@ -536,6 +537,7 @@ static inline struct avc_node *avc_search_node(u32 ss=
id, u32 tsid, u16 tclass)
>                         break;
>                 }
>         }
> +       rcu_read_unlock();
>
>         return ret;
>  }
> --
> 2.47.1

Thanks for the bug report, do you have any more information about the
kernel that demonstrated this problem?

I'm asking because when I look at the kernel sources, all callers of
avc_search_node() should already be holding the RCU read lock:

  avc_has_extended_perms() or avc_has_perm_noaudit()
    avc_lookup()
      avc_search_node()

--=20
paul-moore.com
