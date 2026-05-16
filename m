Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E2380FEA
	for <selinux@vger.kernel.org>; Sat, 16 May 2026 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778923194; cv=none; b=kgZ4geXh6e9L0tykrtr9xK1Fc/aHWGHwr3xPqXvaiLBUH9wB7/36jo93xNeknx13cXU9MdY3rr5lMtPmPeL1gI+euUqHV8wEnudlZn5cNMAuVqTeGhPJLvsETIUr2YXhAOkRbjAQDGmupAQ2xhVYLOIe8qnwLls4Y7bYXR/pzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778923194; c=relaxed/simple;
	bh=G1PUbCxyJOX//Tw7UPj9+qUEfRYerN3gCn9IPzsOw7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgkvPxW/Xz9/EEoP7Jj/E9V6EjERTf/dXR7m+J8TRD3j94AQdKaWvNA+HgstF3XKuQHat9q2m/mBRHLBkkQzJwYDo0PZBmgNM11V1J7O5ibIewhHRgyzYWnIFVSjmVsB3b8sr4pe0P3WT7BWWkqZFWPPDvR621kHuzwf6+7kt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9SwKdvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9SwKdvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC317C2BCFC
	for <selinux@vger.kernel.org>; Sat, 16 May 2026 09:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778923193;
	bh=G1PUbCxyJOX//Tw7UPj9+qUEfRYerN3gCn9IPzsOw7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C9SwKdvfUekKBUyiyNk6WQJZPr8IlNmEy29D8qKqD1ZtNIaDBvkSgCtgX/ipXvvrm
	 HAwFc2fmOJf6Jh2DPU2YDf5ZqlF1guEmkiaDRB6r5mmlsjxYt/oiTXpd1EFxyUUgex
	 ZF9Cf76Fr2rwUo6cybbmnjG4c1haUcp5U0muHbAhlKw4Mg4ogi5R8O0NA08IWDXWhk
	 GpxX01BzUE3qsuvQjWfhQJgCRImt+Lve5ENnkadT78zjSbQuftbKJAvVaNEyFmrUOY
	 U5GqaII0kibA4XCBXSyheMeEfFEq3WKk8nTOn8YeT1gdHRPvxB2p1yL+tmat79vrgk
	 a0/SO6ldpXmzQ==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-90d042fa745so163394885a.1
        for <selinux@vger.kernel.org>; Sat, 16 May 2026 02:19:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8KZPDHcy9Q33u6YNlSP33K0nGDTlZG4DbUnqgjrXPnX1Bv4YbvRRyDEP/vcqDVJaUc5x+dbGJ7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/pBsLujp6HgGuNDGfzwcvt87eXZmf9A2CHEIq+fm69sFqtWk
	X1+owiBfIu6nClC5DX7R1UusfEUXlfDpnlLHZmTNgN2ZJS5E07RzYSM58drS0J0nUC/25aRHxj6
	8COksdIdC2MmTWaXISziWUslROyekIkg=
X-Received: by 2002:a05:620a:4487:b0:912:c631:d797 with SMTP id
 af79cd13be357-912c631d977mr618156185a.60.1778923192922; Sat, 16 May 2026
 02:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CADSE00Jq_uvNgvxgPze0mEdUd+hF4-DPZkHy0KroWHZzygf4WA@mail.gmail.com> <CABdmKX3DhejYBis9htLDnzPrG7vuF3R3URLVNEbnyd61SSsx=g@mail.gmail.com>
In-Reply-To: <CABdmKX3DhejYBis9htLDnzPrG7vuF3R3URLVNEbnyd61SSsx=g@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Sat, 16 May 2026 17:19:41 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zyecY6E-=Tm4_couT7uoM9LMcFdTMUPkZAjj4zUKE-dQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lfp6d8-xrGLNMN2A36VEAHbeTkf6FHYhVfd3tCidoD4YpDVmS9DpWsPFQ
Message-ID: <CAGsJ_4zyecY6E-=Tm4_couT7uoM9LMcFdTMUPkZAjj4zUKE-dQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH RFC 2/5] dma-heap: charge dma-buf
 memory via explicit memcg
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Albert Esteve <aesteve@redhat.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri- <devel@lists.freedesktop.org>, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mripard@kernel.org, echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 12:35=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
[...]
> > > I have a question about this part. Albert I guess you are interested
> > > only in accounting dmabuf-heap allocations, or do you expect to add
> > > __GFP_ACCOUNT or mem_cgroup_charge_dmabuf calls to other
> > > non-dmabuf-heap exporters?
> >
> > We're scoping this to dma-buf heaps for now. CMA heaps and the dmem
> > controller are on the radar for follow-up/parallel work (there will be
> > dragons and will surely need discussion). For DRM and V4L2 the
> > long-term intent is migration to heaps, which would make direct
> > accounting on those paths unnecessary.
>
> Ah I see. GEM buffers exported to dmabufs are what I had in mind. I
> guess this would only leave the odd non-DRM driver with the need to
> add their own accounting calls, which I don't expect would be a big
> problem.
>

sounds like we still have a long way to go to correctly account for
various v4l2, drm, GEM, CMA, etc. In patch 1, the charging is done in
dma_buf_export(), so I guess it covers all dma-buf types except
dma_heap, but the problem is that it has no remote charging support at
all?

> > udmabufs are already
> > memcg-charged, so adding a separate MEMCG_DMABUF would double count.
> > Are there any other exporters you had in mind that would benefit from
> > this approach?
> >

Thanks
Barry
