Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113EBA3F
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079456; cv=none; b=ZyGSvkdhzQ0cuW2fbCAIcfLG9w54FtC+GoEPSXBPBBkNnRKWq4acDNwleMiOjPmAPXlTN6Tm4UkxP34/yOEO97CEMAucb1TnoXi1nI8E05XNIZ6tSlGOc8hUF1VTaDYDbIUMT8f4v8bIXaXr4u8emwucaZgTWga4S+g17Bbm05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079456; c=relaxed/simple;
	bh=U3LoQBCt90t7PeORatGq6usmOy7oZoMyjy4SEp7vn+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4f9j3OT6NtVCS/BjYsBIPlpNkEOVXIx//CjUGwTEgx7LQEsJ5+UR4f8VZtNGUmnrE6yKH25TPQZyzIi0O0V1swtYwEuTcgVqDfl2zIymvg8lpM28qwD0ZG2ZqntoD9gGr+CJvE/TokMmEvZaKlu6g88IsYug7ZWYIlgbJo48Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AsMVBiKG; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AsMVBiKG"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0bf9c7f4f2so423205276.0
        for <selinux@vger.kernel.org>; Wed, 07 Aug 2024 18:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723079454; x=1723684254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErDvXNukqzyNXIQ+DJyEKuSpBDtEhIpca3l1cgR52H0=;
        b=AsMVBiKGyNv3IE1f3lHCw8ZQ6PvG82Hm8t0teFzWbDuMnEY+Ceb1NI//0cO0IPki+t
         OelxVbl/9UXFCG5vqDu4KpJDLs6zvLlASORxWi0saBQQbYg2WO7ZxWYrCb4mfVbw+d4J
         IESrTlJpqyMxD4cfQZ1aFnf/yqGRsa3dfq0DnMvxxV0WYjkAksTCUhbE+kuga7G83etZ
         dCd/dvRlBNaMe/vIwMBYHKo7ZUjxCp2IBmgjT1oFc+hQ+pHqCYSZlvkNTc2wUS3voPRT
         +xyoH4DTIrW3WlfcM97GZJ+o1fth0SsGDzkIqx7+b1vHDkb2CuiWggkplCVeBnE+9yUM
         eHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723079454; x=1723684254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErDvXNukqzyNXIQ+DJyEKuSpBDtEhIpca3l1cgR52H0=;
        b=snO/sfelCCP1BgEZypIWfxefOz33heL0rVeCjgGZeFGbNUs5YAzNze68Bz47nJuUcx
         5grgwpXcSMAbTPJZobr3SY9UWuXTVV0zTZzT9ncH0DLOC4VaqHfLsbTxEd8VY/3GCn1Z
         GM18/2pATGDdjZWJS78ff3ioD6CTZVYT/qude/KmPXm7Tivb/EHhOMsnOgLVOa5/EmzB
         X5F4nLCU4httUa7YtLrbifQklzjrI26xPwxWgG6bT0StPmGq6D7tzQdQsd22VJencwxu
         69VNGdFA3OaAlVUHaTVNYzuOi7yZ643hvMaKSB+t3YvsHNayAQ+XAxrMIY93plqCTjHU
         c9hw==
X-Forwarded-Encrypted: i=1; AJvYcCWV2Kf6tZ4udzKlnYCJz8Ehz9a5e5bnWY2RhmU0zxqgYsA98IB2l5FEjQL8dZOChPUVur7mO59JkntPU7VFlbtWJwmpugf6cg==
X-Gm-Message-State: AOJu0Yx0weXgRjqubELv6NrrIgjSXKrQbyfMKVXTz9czrvbLPvX1iDXt
	Ffgv68uJnNsLMl0Z3lkb4BdpoVcKHyzeBqqWKMRbHyL3HQzWm5XuMdDILui7dxXrExjMmGotPZj
	Cb7KECEKrbSb/ngT2xBAZd/dnYf8EXUc0Gzbi
X-Google-Smtp-Source: AGHT+IG2o49jBMoCHs51og2LrKD5EIYIo3OTt890fv3onYDjaEYiMK5eiQu9leH8Tu7lCkluWr5oBlHW16GGxZpKidQ=
X-Received: by 2002:a05:6902:120d:b0:e0b:e893:f16c with SMTP id
 3f1490d57ef6-e0e9dc2c614mr499517276.53.1723079453768; Wed, 07 Aug 2024
 18:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ba8477ed-b7a1-4833-a01a-b7d43ddb47b8@huawei.com> <ZrPmoLKJEf1wiFmM@marcreisner.com>
In-Reply-To: <ZrPmoLKJEf1wiFmM@marcreisner.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Aug 2024 21:10:42 -0400
Message-ID: <CAHC9VhSWVdiuK+VtbjV6yJiCp=2+6Bji_86mSkj1eeRL4g_Jfg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and vma_is_initial_heap()
To: Marc Reisner <reisner.marc@gmail.com>
Cc: wangkefeng.wang@huawei.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-mm@kvack.org, omosnace@redhat.com, peterz@infradead.org, 
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 5:26=E2=80=AFPM Marc Reisner <reisner.marc@gmail.com=
> wrote:
>
> It looks like this issue is still not fixed. There has been some
> investigation on going in this Bugzilla for Fedora:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2254434

FWIW, I recently learned there was also a report in the kernel
bugzilla about the same issue:

https://bugzilla.kernel.org/show_bug.cgi?id=3D218258

> The behavior we are seeing is that when a process has no heap and
> mmap(2) is called with MAP_PRIVATE | MAP_ANONYMOUS, it allocates memory
> on the heap.
>
> If the address space returned by mmap(2) is later on made executable
> with mprotect(2), that triggers an execheap avc.

...

> This has been reproduced on kernels >=3D 6.6.
>
> In reviewing the code, my best guess is that this is caused by the
> scenario where brk =3D=3D start_brk not being handled, though I am not
> expert enough in kernel code to know. If the start address allocated
> by mmap is before the starting program break, and the end address is
> after the starting program break, then the avc will trigger. However,
> I don't know how mmap deals with determining an address and if it takes
> into account the program break, or if calling brk(2) later on will just
> pick a new location.

I'm not a mm expert, but thankfully we have some on the To/CC line so
I'm hopeful they will be able to take a look and provide some insight.

To bring the relevant code into this email, prior to using the
vma_is_initial_heap() helper the SELinux execheap logic looked like
this:

  /* WORKING */
  if (vma->vm_start >=3D vma->vm_mm->start_brk &&
      vma->vm_end <=3D vma->vm_mm->brk)
    /* execheap denial */

... while the current vma_is_initial_heap() helper has logic that
looks like this:

  /* BUGGY */
  if (vma->vm_start < vma->vm_mm->brk &&
      vma->vm_end > vma->vm_mm->start_brk)
    /* execheap denial */

--=20
paul-moore.com
