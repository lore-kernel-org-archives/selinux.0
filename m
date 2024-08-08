Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F4143726
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124403; cv=none; b=syKI3/nfZzehg6CsqH2dL2Rc7fxiKdUMpeoo8HLT1Sq8XWkkcdRwRYRLDqm6KXZgyzq8fCo0LrOEk27V3m1XdaiNtOslgPRqZplQ3VfAzwB+KFCSs6KIfg4gTpXEyVjUQJdGPejtpquXn3lUEeHF6sCuKAKfz8nka+zmO9i83XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124403; c=relaxed/simple;
	bh=azqn8TdZtcaZjzXhQEk1VT+GK+2cz7Oi/HnehE88OmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfXKjfb3KNbJQKv5iqqvS9sBN0HMvfZ3a+qUNZyfojR6EpjZukQYqEoB0Zh5EEGI+POvthNraKt8YwdpdOgjYfjuN4tJC0j1Y0ZXseZwJaCo+sVpDhLKpW8dVfXInpR+O0jyQc3PktiqiOi7ZH3ID/RB9kxqoTbVxEBWyNZ0v5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1Zd/9py; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Zd/9py"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cdadce1a57so805189a91.2
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2024 06:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723124402; x=1723729202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO9wyaEt1ObwurYcO8qjDCHpJnCttrBVOOoEKj5N3wY=;
        b=U1Zd/9pyjxh9sJEoc4LimejwULYWim0U1qwigYGdIQphaSe8RABU6115+HFhSnxt8X
         Foh2/arx9saPtfN/RjY1adRirJ9VvEY0wtq33OwE9iX3gmMyqMDiqbpUOPUrbSeSqUzB
         VAYAvIzs2uZlkuFjQNN1p7lrsMSpzN0vOULWisbEqoHRElKGvVNoGxYoaXnjw9PAZK//
         BFkJN3KXmq2qKldwsM+TshGsXz00o0Fvj8LCu/TOf6l9oCYBvIhQGPFsSjU28KJxIHk7
         R3uNDcutaLhuJwow57mWeoCIWx5KpjEaKCeBVf9M0VatFb9Xj/Hi7mTjYUzSkME6KiGj
         Cdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723124402; x=1723729202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CO9wyaEt1ObwurYcO8qjDCHpJnCttrBVOOoEKj5N3wY=;
        b=T015jRAW8xb+avEbp/ueeMy22tuE8qrP/Sk3t1KmwwmqShmyKV4nbeT0hhICiGL9i8
         u9KVZFRdwBFkmvx3318bmeiIpxuvq88JMids//EU6OJNXyXASOiI2+fng9R+gT+hSk4r
         RMQKSVl/Y+I91bzAjFFpNOGQkuhStrz5OMU4KcI4yGg14K2KHLsne7DRhXtqZoJtLk9G
         WMhJ0V/z2BpBA3uS236MNrYXFUztZB2He+BuWMoFg4jaNPVxjY4GxKBB6l2cFrVaY8g0
         UCdE8MIjK+3KOoFqDB6NAxP606PLHpOjj3PuI0U+RRzO4S8mkfN6/z1gsekN3Qi1vBRk
         rB+A==
X-Forwarded-Encrypted: i=1; AJvYcCW/HWbjpwuQwPN59sTpNSfyaptGZa93GHU6um0SD3YAS6GYVWRKTcluou/M4GHhFQf3y2Lk4Twua+z82yJVpVHzTpVlgjRo0g==
X-Gm-Message-State: AOJu0YzK5lLjeYbsQFVQBRyqVNvBtIdJpNzVkV9uJTjVPTkqZTJXVoMK
	/E4/iTky0d+c/aMGEOfChEdijY4dlRRRbmPbytwK39hzODpYxZuh5jZ1CU8RqGz4ZgKb/8rzHMC
	M0ObkGaiMFWjcgcU9E929Zm/lN1Z0Vg==
X-Google-Smtp-Source: AGHT+IFQ4yohki3yL5TEm1Ey1QNioj2p4aFD7Dvhp1sG29vXFdfHztH+C2uv+JVfmhhgLbSFSnThEmRLaMK34nHAttA=
X-Received: by 2002:a17:90a:9ca:b0:2c9:6f91:fc43 with SMTP id
 98e67ed59e1d1-2d1c336ef84mr2164056a91.3.1723124401421; Thu, 08 Aug 2024
 06:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808130909.1027860-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20240808130909.1027860-1-wangkefeng.wang@huawei.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 8 Aug 2024 09:39:50 -0400
Message-ID: <CAEjxPJ4b2Xcptmi2cJNyh=N=1ky=yfg_wVB1yDLwr8uuhujxew@mail.gmail.com>
Subject: Re: [PATCH] Revert "selinux: use vma_is_initial_stack() and vma_is_initial_heap()"
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Marc Reisner <reisner.marc@gmail.com>, david@redhat.com, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 9:09=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawei.=
com> wrote:
>
> This reverts commit 68df1baf158fddc07b6f0333e4c81fe1ccecd6ff.
>
> The selinux only want to check whether the VMA range is within the heap
> range or not, but vma_is_initial_heap() helper will check the intersectio=
n
> between the two ranges, which leads to some issue, let's turn back to the
> original validation.
>
> Reported-by: Marc Reisner <reisner.marc@gmail.com>
> Closes: https://lore.kernel.org/all/ZrPmoLKJEf1wiFmM@marcreisner.com/
> Fixes: 68df1baf158f ("selinux: use vma_is_initial_stack() and vma_is_init=
ial_heap()")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

I was only going to recommend reverting the change to the heap check
but in case Paul is fine with a straight revert,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/hooks.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 81fbfa5b80d4..f5805d4b0aec 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3845,10 +3845,13 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
>         if (default_noexec &&
>             (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
>                 int rc =3D 0;
> -               if (vma_is_initial_heap(vma)) {
> +               if (vma->vm_start >=3D vma->vm_mm->start_brk &&
> +                   vma->vm_end <=3D vma->vm_mm->brk) {
>                         rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>                                           PROCESS__EXECHEAP, NULL);
> -               } else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
> +               } else if (!vma->vm_file &&
> +                          ((vma->vm_start <=3D vma->vm_mm->start_stack &=
&
> +                            vma->vm_end >=3D vma->vm_mm->start_stack) ||
>                             vma_is_stack_for_current(vma))) {
>                         rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>                                           PROCESS__EXECSTACK, NULL);
> --
> 2.41.0
>
