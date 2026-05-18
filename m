Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A829D337BB0
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147564; cv=pass; b=qCJVw1BVLWtcmnKYp2kyBKNa1H/kjzV5bnFSZ/5HqVLT5SaWOaYGhpIej76P5MnxG8bT1YJ/OqMGKzVtwvdlG21na1mLJhdmEFVqZgYhJdRKSSbcH4dyTT0giOuHBEsApYBXv0aSjLcC6Y/wN7PVmG2YusEFrzqlNMYTIM7Ondk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147564; c=relaxed/simple;
	bh=RlgWSbw/qDy0FEEgyFzO7eBFoHyyLd7vQDOSYcU9a5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpmVM6Rj7IiYGkDm+Z2KM8rZjsSz04yiJ+/0GVv+1SO3DG/VA7rYedQcQfalX1ILLmOKEa5/EB0GnzGXM4pjnTvRNnjGdfVcwkJRskywYPti45elgcdToEBYGxCvuqVYU51PeNdJyxB66bRWefpW3XoG4yGLAinhCZSMj5lPq7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aX+kKzUs; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aX+kKzUs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so705e9.1
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 16:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779147561; cv=none;
        d=google.com; s=arc-20240605;
        b=ERBzAVJh5WfKeqNRzWmpDnqEemZBeCgjii9EQQxcXFbQqdLfdUj1nBxtwtSYfY2nM/
         7kw8iQqTEaEzV27AOqTkadUIPqGOZMVcJyc+Styh2FFj21wVzC64mRvR0uAoHgoOHQy5
         vRYALJ1kSubTdtfxjYPOVs5c5+j3wd9r9Yyup4wTrydFmqy05xKDu75dcG59qY+jVCAL
         dgYoOqlXfwCTSOYYI/dOw7G5VCn+8rZFEgXWfbejEI42meUqnBi6YmBit0rR56+FUHby
         ENboGyyyB0IFvslDD0RydacEM6ZbBIIVH07tbBMAk63wnk8lmnGZNJiDpAVHUg3oKiOx
         sEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RlgWSbw/qDy0FEEgyFzO7eBFoHyyLd7vQDOSYcU9a5s=;
        fh=b+oExTKaoPLGesOxMmh4bUjh4sK9z7mfTs/FkW8uTtE=;
        b=SIzZjMGncqJnPPLv6Ir/SIHzEYAfd0QgJjknIh1yquCvzIZdoEam6NDM2vbP2Db6E/
         e0fHmM4KcXcQMtNxv0bZ+OAabWJ7UT+THriEWEK817lNQB+tcWypwhorwSv9swwFXXod
         vpav1pSK8Ky9W9MWdgWso/NTWsndEXR8kht43W5Ess9RfXyY0lZUPLIOllbj31B2eXiw
         ulyaC3SyjHTaC84OPqr+adr2yujMZVw3r1IAPmtSgdFx7aRFL9LSP136LTgqmgHjAqug
         NfkRcmWJY0nw3a1rrEifOD7JJTZeAk1d2QO/HPnRDF14w/FweBNVbdYQLBU20Ah8FNhZ
         OG9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779147561; x=1779752361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlgWSbw/qDy0FEEgyFzO7eBFoHyyLd7vQDOSYcU9a5s=;
        b=aX+kKzUsboVSf1MSKClDtOA3TnfKk+2f/C6h/5nyVGbD9QLjyaIW08h8weErzxQ8CV
         K05jrB3VojE83yb+c2TIiJHZ53CzjtK3vhBDEYgkBJbzrecfWi1eqaiES6OCvMAdd70f
         6VUC1A6T4JCWF/UBzVx7hx02iiKtejtlhO9uaTDWQJMQaUDhf+7nzaNcVT+3s0e2QUgS
         GSnujKQ3COePTRHcxTBo16Pc/2bGiAVoDMzg7hza8br6DAfoYb+m6y62mfnRfGopFZgu
         1hCCXb9CCP+V63QbmI6ny3ZzWqx7jKpPC9Uc/dskvKKvJmtPSyszZdVulhdG92zpq2eO
         11Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779147561; x=1779752361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RlgWSbw/qDy0FEEgyFzO7eBFoHyyLd7vQDOSYcU9a5s=;
        b=dr6GABkUtq+icGPuqQvuE888U53TFjzY3YsSU1w5FJ+t1yYeuaDmgYKPpemwFo9pEt
         CAMXh7zITLgVW3dwko6SJ3AeHkCaPjK4NBnHVWeMa4qnkl7lFAS1bspn4Wb7+4sevIuv
         tFq0yas8VYmcO/B+dK4OGKnsaX2PAwouON6vXkiwlluxSmkzsFKBkf8a80OrAlhhGKjF
         sRLJvtjkoytwcy+cW01uLQjfyEkb6emQ+vY3t61WJwvjta0DWgqvhFmRxfNDuo5eyyXQ
         NErZ0otfDyOtWFoeLLxLt0+A72jlSONQa+8aiYZffohmr9UcBtZWIwwSRHaO1xg3tis9
         12eA==
X-Forwarded-Encrypted: i=1; AFNElJ9l+zgAArkkHLN+7f69uUUsZ+1iCViNmTaWFLrSXMFnEuzHMycVoFroD0snHMrigmnXqtHJkWjZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrz8S1sfDXFBnVd+1+CwU+z5V0PAF2Zu/USggHW+dSVV7ro7qr
	xZLVuXvmROqZYNWiKPrTLrvHz/mEzPgcfrpSuJZBs0QXo3FiH9HRIxBEbwDS2PucHHvN4tkla8D
	b5xg1KN6IMIjQgJP6SPPtmtfIr7QP9isLin4UVHt8
X-Gm-Gg: Acq92OEBW7oy9w8r+dcDpmHsZ7AV4B0zliuLLNu6HI0Zc6YTlEGZ+wIm/JFjWpd0Ra4
	gVA25O6uD/zKYRQ3OIaKiA73995nOVT+yBjSfCsdw47nAp1VwIj+J1tpifoR7KHT+i30mJKSLaw
	e4mSpYtGIrlWeclvrBv1TVRz0Kb55nI5Zxa5dQ1jgbyoqzYbR6NWwoQHes+rPyMCK847Eyi0dWD
	1/heSkaOKWPbRinkb52raG9ioBNh6bLtPbTX8RUiJ5qGMftg66s3lbCu10ws2xGke9gHdBMWdIG
	NMp6MwCCbuX3YZ9j8vN1kkJa406V3/ZLROo5IrLhaXKGBsr8
X-Received: by 2002:a05:600c:534b:b0:48f:d634:b18d with SMTP id
 5b1f17b1804b1-48ffa5e1260mr1775015e9.8.1779147560622; Mon, 18 May 2026
 16:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CAGsJ_4zjrFJYQQsLThTGXR6g+2PXzeAhjyDpLHfDFqVViWvyBQ@mail.gmail.com>
 <CABdmKX0gqg309hcXcOHSj_yTg0h1zwDL34GDk8mX3wp4YoyfDg@mail.gmail.com>
 <CABdmKX3wwgovwS-V8rVC3=+EZcTvPs_cttpQb1w6WemwLAVhsw@mail.gmail.com> <CAGsJ_4y=Gsv=FSUjJ5+99Gg6ULUnv0LRexCGOGetzChR3YA44Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4y=Gsv=FSUjJ5+99Gg6ULUnv0LRexCGOGetzChR3YA44Q@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 16:39:07 -0700
X-Gm-Features: AVHnY4LTFYlENC6xQVXK8AijxUAKUMiH_YZR8cEYxhyMaKCwg0sVArYGdEg8UAo
Message-ID: <CABdmKX3GgCogr9pQFybnV1p_zuo1V9fqJLCXvk-HAnk1gwLoDw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
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
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mripard@kernel.org, echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 3:19=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Tue, May 19, 2026 at 5:17=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> [...]
> > > > > Yeah I think this might work. I know of 3 cases, and it trivially
> > > > > solves the first two. The third requires some work on our end to
> > > > > extend our userspace interfaces to include the pidfd but it seems
> > > > > doable. I'm checking with our graphics folks.
> > > > >
> > > > > 1) Direct allocation from user (e.g. app -> allocation ioctl on
> > > > > /dev/dma_heap/foo)
> > > > > No changes required to userspace. mem_accounting=3D1 charges the =
app.
> > > > >
> > > > > 2) Single hop remote allocation (e.g. app -> AHardwareBuffer_allo=
cate
> > > > > -> gralloc)
> > > > > gralloc has the caller's pid as described in the commit message. =
Open
> > > > > a pidfd and pass it in the dma_heap_allocation_data.
> > > > >
> > > > > 3) Double hop remote allocation (e.g. app -> dequeueBuffer ->
> > > > > SurfaceFlinger -> gralloc)
> > > > > In this case gralloc knows SurfaceFlinger's pid, but not the app'=
s. So
> > > > > we need to add the app's pidfd to the SurfaceFlinger -> gralloc
> > > > > interface, or transfer the memcg charge from SurfaceFlinger to th=
e app
> > > > > after the allocation.
> > > > > It'd be nice to avoid the charge transfer option entirely, but if=
 we
> > > > > need it that doesn't seem so bad in this case because it's a bulk
> > > > > charge for the entire dmabuf rather than per-page. So the exporte=
r
> > > > > doesn't need to get involved (we wouldn't need a new dma_buf_op) =
and
> > > > > we wouldn't have to worry about looping and locking for each page=
.
> > > > >
> > > >
> > > > Hi T.J.,
> > > >
> > > > Your description of the three different cases sounds very interesti=
ng.
> > > > It helps me understand how difficult it can be to correctly charge
> > > > dma-buf in the current user scenarios.
> > > >
> > > > I=E2=80=99m wondering where I can find Android userspace code that =
transfers
> > > > the PID of RPC callers. Do we have any existing sample code in Andr=
oid
> > > > for this?
> > >
> > > Hi Barry,
> > >
> > > In Java android.os.Binder.getCallingPid() will provide it. Here
> >
> > ... let me try again
> >
> > Here are some examples from the framework code:
> >
> > https://cs.android.com/search?q=3DgetCallingPid%20f:ActivityManager&sq=
=3D&ss=3Dandroid%2Fplatform%2Fsuperproject
> >
> > In native code we have AIBinder_getCallingPid and
> > android::IPCThreadState::self()->getCallingPid() (or
> > android::hardware::IPCThreadState::self()->getCallingPid() for HIDL)
> >
> > https://cs.android.com/search?q=3DgetCallingPid%20l:cpp%20-f:prebuilt&s=
s=3Dandroid%2Fplatform%2Fsuperproject
>
> Thanks very much, T.J. That is very helpful. I guess
> that would require user space to understand the RPC
> procedure, including single-hop and two-hop cases, and
> make the corresponding changes.

Yes, this is solvable by having a policy in allocator services where
the caller is implicitly charged, while also supporting cases where
the RPC includes additional explicit information about who to charge.
This needs security checks to prevent arbitrary remote charges at both
the ioctl() level (selinux charge_to from patch 4), and at the RPC
level (not sure yet but maybe a private interface between system
components and gralloc), so that only privileged components can
initiate remote charges.

> You pointed out the SurfaceFlinger cases, which are
> two hops. It seems that AI models are also using
> dma_heap, at least from what I have observed on MTK
> and Qualcomm phones. Likely, we need to understand
> those RPC relationships in userspace and make the
> corresponding changes.
> I assume AI models are a single-hop case?

It's currently a mix because AI model loading is largely controlled by
vendor code right now. Some implementations use
AHardwareBuffer_allocate, but that comes with unnecessary RPC overhead
for the AI use case. So I think we should be trending towards direct
allocations from dma-buf heaps because model loading time is
important.
