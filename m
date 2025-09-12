Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1522F60A2
	for <selinux@vger.kernel.org>; Fri, 12 Sep 2025 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680539; cv=none; b=abJQmvxxTXpzm1PSpuZ5rj5PhSTavBEoDJW5ydTXRgLKmydWSxcR61sjxmqFBkpYJ2gRcCEf7G3+NTxSPSGjV8P30NtwFsmp9ygh+qXQNxd8RIMleo8qrEOgJlKpmkaXQ5zXQceXYEI3HBltEOg8XatF5ENGdtBOIi7jwql4gGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680539; c=relaxed/simple;
	bh=Tj2+e83du4vC4DcQ+WEChWjKDbfxZ6nCt/evqIC5u40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctLr3AGpplDSMSOJORqoO4iKtddUMgaz5rRN0CrbyUTlccyLSxDgDruZOLzeb8tvzKMnzm8ambGOeCwzQ8vBBjqUspVFdRc/0/7iPXIQOnEx6I9FGCfiQpmMVlAX4MXrUf6cG0fOWBxHFE/25sEM5n86+vmMYrMysvgPoGi61Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CW6D4zKl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW6D4zKl"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso1905220b3a.1
        for <selinux@vger.kernel.org>; Fri, 12 Sep 2025 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757680537; x=1758285337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9JiQChWbox7CofESJhE4xi9hVI02nwJJqT2Ui2FNY0=;
        b=CW6D4zKlKd1R2CERax75KozKtOYEiZaN8ATGM3mXR3Yxq84ER2FpzYXNZGcOVsY5eN
         7uy0b8fAgj7ZPepqIm6+LTCHUz2cbgXvuRk5U6HRebTELAksQTatkjP8kIvnNQVxOUbk
         ISSqSa0KBQNY9Oh0Nls8PjbxXVaE/Ru8jZFNgmorjn09/XKnDksocn5T2OWeqwg82J5t
         24Vo5vjhFMdz4hKfa+5uqecSBF7N+9WgwjFABj1ZqjbYhQrvN0rtdgIZ3QRPAnLzWCQy
         fBekNT0+Ddn4FGBN4KepizBHqae8Jb1shTgVH7pMRHphn9lnwmLKwARzcfHxE817KvAd
         Tc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680537; x=1758285337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9JiQChWbox7CofESJhE4xi9hVI02nwJJqT2Ui2FNY0=;
        b=bLpTAtXlC2PF6BO92AA/y/Yeu8DD+BgUDsMAET1bahvZnLB8mcWgL/dlB8pRhHQpvI
         GU7fYwdgB5OZ8G2PBNJ7iqP5sL7YmT4/MBgwhzq8+i5dqXBBPwbtE2S7KvVp0PvoftGJ
         2Srqw/6l/z/yZrAmUIcfhOd4jD0JJSaiq4JAaLr3v6x7RER2OlhVjyb5X+OzpPySrHPb
         Vc9K72TaehDwC+q2HArDJqiQx52yy6qusEhIevGIbRPLMudW0Bi9XGbJdtANzvXx6VaT
         Ke+ENyuwqXQFyujds5LooOIj4juIUIiPAvxzclr9qtzfv1yq4ZoJxJJLdPTsp8lDit8m
         WHPg==
X-Forwarded-Encrypted: i=1; AJvYcCV3u0hUpYL3AU8a80zbKjmKdfW0u+pxmtSGWupyDrnz/kTqrMZaiHZoNr9NmJXt2dY+cKn3Xt4j@vger.kernel.org
X-Gm-Message-State: AOJu0YzgtmfJNhQpd6Nv29BshXJ5cW6wtrMRC3BBJl8JHp2IUsXD3ya4
	PND0oXfWi3llCKp33EsnT2D6Co77BgyRSJKvIqa3HJG6LnFeZdLhSO6JNJ14L8ABmxtBfspLFzH
	h852hTGtCBdOvXS1XOISjdC4KhGZ6ZJM=
X-Gm-Gg: ASbGncs3gDdGenmBfps6/SeJuFAuKorMqe6kZZZX3wzYQ0Ga55twwtgy25RouoBXOAr
	kTDexN1mywpNFrCl0qRIFDtoTZtpjeEBKjXBtIo3hsOjlYjhUHw+P3VHJpxfkPgq7VrTW7aukKG
	NFTXdC9b7IUzVjDgy7AmHR4fvaftw94CXa2A4RpEyrjilbcL99YKJYPeZXyNJhOdEBog5d4EieL
	V57O+E=
X-Google-Smtp-Source: AGHT+IEQx1PETSfMB/6QLGHuYxCf5yh/1hM526+nvA7AYVYQddNTgpSwAE2ETgu3zPA51ZIJcXY8WaU5282fceEbiAg=
X-Received: by 2002:a05:6a20:939d:b0:243:78a:82b3 with SMTP id
 adf61e73a8af0-2602c71d516mr3395424637.59.1757680536658; Fri, 12 Sep 2025
 05:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4naa66Aum5YO0jntY5-reXxF5Z-=JYTcmb7WFCBODAHg@mail.gmail.com>
 <20250912105939.1079014-1-zhanghongru@xiaomi.com>
In-Reply-To: <20250912105939.1079014-1-zhanghongru@xiaomi.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 12 Sep 2025 08:35:25 -0400
X-Gm-Features: Ac12FXx0D1xfyO9B8MbVlqQnGLXE8gX4XRYLx_eQw493PStSRkAcgif0AwZ25zQ
Message-ID: <CAEjxPJ72UfNaPC0QXW61ENzCYLRUuYQCXeVxir4UFj4eP4PROg@mail.gmail.com>
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 7:00=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
>
> > > > Baseline: 512 nodes, 512 buckets
> > > > Comparison: 8192 nodes, 8192 buckets
> > > >
> > > > Metrics (Average value over 1800 samples):
> > > > * Bucket utilization rate (higher -> better, same chain length assu=
med)
> > > >         * Baseline: 52.5%
> > > >         * Comparison: 49.5%
> > > > * Max chain length (lower -> better, positive correlation with wors=
t-case latency)
> > > >         * Baseline: 7.5
> > > >         * Comparison: 11.4
> > > >
> > > > Experimental results show that scaling buckets and nodes from 512 t=
o 8192:
> > > > 1. The distribution uniformity under the current hash algorithm doe=
s not
> > > > degrade significantly;
> > > > 2. The maximum chain length rise significantly, potentially degradi=
ng
> > > > worst-case performance (ignoring other code in avc_search_node func=
tion).
> > > >
> > > > Details:
> > > > url: https://gist.github.com/zhr250/cb7ebca61ff5455098082677d75b179=
5
> > > >
> > > > I will modify the hash algorithm in the avc_hash function and colle=
ct data
> > > > again to see if we can achieve performance improvements.
> > >
> > > If you look elsewhere in the SELinux code, you'll see that others hav=
e
> > > been converting other hash tables to using the jhash functions, so ma=
y
> > > want to try those here too.
> >
> > Or you could follow the example of ss/avtab.c which was converted to
> > MurmurHash3.
>
> I read the code of jhash and avtab_hash, it seems these algorithms are
> more complex, with higher overhead compared to avc_hash. For cases with
> a large number of nodes and limited number of buckets, the benefits can
> be significant. However, for scenarios with a small number of nodes, the
> overhead may already outweigh the gains. In my case, 8192 nodes are
> sufficient, and I'm not sure if there are other cases with higher
> requirements.
>
> Based on the 'Max chain length' data I presented earlier, if we want the
> hash operation and table lookup to yield an overall performance gain, the
> overhead of the hash operation should not exceed the cost of traversing
> 4 additional nodes (11.4 - 7.5 ~=3D 4). If measured by
> 'Bucket utilization rate' (~50%, means average 2 nodes per chain), this
> overhead should not exceed the cost of traversing 1 extra node. Otherwise=
,
> even if uniform distribution improves lookup performance, the hash
> computation overhead could still degrade overall performance.
>
> In scenarios requiring a large number of nodes, it seems necessary to
> optimize the hash algorithm to avoid excessive bucket allocation for
> maintaining performance, which would otherwise increase memory overhead.
>
> I will first refer to the avtab_hash code to improve the avc_hash
> function, and then show you the data. I will collect the following
> information based on several different configuration using the same test
> model:
>
> Baseline: 512 nodes, 512 buckets, original avc_hash
> A: 512 nodes, 512 buckets
> B: 8192 nodes, 8192 buckets
> C: 8192 nodes, 8192 buckets, original avc_hash
> D: 8192 nodes, 4096 buckets ("large number" of nodes in limited buckets)
>
> 1. /sys/fs/selinux/avc/hash_stats
>         a. assess the effectiveness of the optimized algorithm based on A=
, B
>                 and Baseline. Expect bucket utilization rate: A ~=3D B > =
Baseline.
> 2. total latency of hash operation and table lookup
>         a. A vs Baseline: expect A is no obvious latency increasing
>         b. B vs A: expect B is close to A
>         c. C vs B: expect B is no worse than C
>         c. D vs C: see if we can save some memory with no obvious latency=
 increasing

Thank you, looking forward to the results. Fun fact: the current
avc_hash() function logic hasn't been changed since SELinux was first
merged into Linux 2.6.0-test3.
