Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC315099D
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145726; cv=none; b=Kmy+zBN6qqQWEUNhj9YWBAFE0bfzNX7Z22HfAk7Gqw6Wy4z7Peyy+1MxzLkf0ND2LMNshoeuNmZVlLpZCs9jRJLUERMyeb6eQoi1M03YulfKNrfGJpcaQO+HSFDcxegdImu1LkAU3DDRWi/TBugPJSvUqLDbOJY8y1j2X6XpHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145726; c=relaxed/simple;
	bh=KcaKNREyvkSXiPixKel333/MHqhQ3MaTjXDFgwGrdVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlVjIvQjjwLIdVKGGRrLSUWw/ZwupbyKC9v5lowS9xpwbt4/1beCEXMQRsLcp4dcZ2bPGjQYAjjtcxDKGWvYrsUFxxmC0r3nRUzMO5TFoGQQdc7a4arDDYXg6ppKkPcoEIJH5a4t9Ir1y9mPRM6SrDFk+Z3jzJL5axzHab/TwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNfBoDaH; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNfBoDaH"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4928fa870a9so443860137.2
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2024 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723145723; x=1723750523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQekIWHI6IFQnSn3jUyNegWYXItY/ajwXC9dX2BOjZc=;
        b=mNfBoDaHym0CaG/Vqj0LNmDD0EeXBKXZr6noigMyOzM3CxCAT4YvM0EbiwsdFx/CdQ
         uXyVMtYLyKIGVnR/VgoNF1/H+iXuot+N0YlH/NKYnSy0K54f07B3wowOSQaQXi7XM3zc
         HBRF+IgfuC20mtGuImSS7l9FCTGovEarQjQiv+H3gvaYIVDFBQrfxfAnAJrV12CQCtQQ
         vsr/jrcHOFmhVq7O4pNPmeUmjJmohlIJZUHJzTViAgRz5MBhVv8+po1lZ90/5qapdiWG
         FROdehtLCVFuFzretwKamGxvZHzi26VUkSAtvbaG3OF8jzo72o47tUntOxEXzHQcZwOe
         hfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145723; x=1723750523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQekIWHI6IFQnSn3jUyNegWYXItY/ajwXC9dX2BOjZc=;
        b=oB1vuw5D2NkACWYzimb9VDrcs8zThYdjegAOGeqSQCfbQpdE+rRXlzifz5BWjIu+2x
         A23cFJwKbkqM+Qz4UaDCgVzp0ZXZlEwXxdf5MLir4Pm9+Dvp/3iTCywWLNS4WB/CdwmW
         AAVKZsHnX369OdtLvxY/DDUMSBiX6NBNeFmzt6s1AKmCdO66to0V32PC0M00Nls7hWP6
         nRFq0WP2Uw6Nga2zc6prKxO2jxC7ELUIaLB0OdG4E2/dGRc63fA1M6MVjw9/15osOHVA
         41u9ZQtvC0tnyRDP0ocb9qPJtsG3KO16Fa+OYRNl5MAl1NUGnqzxcI64dUEj76uTozPt
         Z8pg==
X-Forwarded-Encrypted: i=1; AJvYcCVREUAHGgl6pAg+QGL1GRt3MXMfxmep7O46wcLpJmyRA8chDdkPEoA4+CYC4mR1o9/AehBa3e37X05+TWC+1KMrgYKMFwpsgA==
X-Gm-Message-State: AOJu0Yw8ZhUwco9NtD6vlMYZQRzcnW17yfx8ErrrZ7ogpDnpauUa+smW
	bXjfllRnC1YRzz6jDIZN0MY1ySRFf0mK5+TAW86Jp7oy8lKL8kYU
X-Google-Smtp-Source: AGHT+IEJWjXpKI6YimZlHdKbCCXQPze4wgwHVx02pLRY9GD97dpM+Wy69H7xaMd2QmLin+UF1hubCw==
X-Received: by 2002:a05:6102:f0c:b0:48f:40c1:3cd0 with SMTP id ada2fe7eead31-495c5b1f8ecmr3768368137.12.1723145723526;
        Thu, 08 Aug 2024 12:35:23 -0700 (PDT)
Received: from marcreisner.com (marcreisner.com. [104.248.50.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c87c487sm69505566d6.131.2024.08.08.12.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:35:22 -0700 (PDT)
Date: Thu, 8 Aug 2024 19:35:21 +0000
From: Marc Reisner <reisner.marc@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Paul Moore <paul@paul-moore.com>, akpm@linux-foundation.org,
	david@redhat.com, linux-mm@kvack.org, omosnace@redhat.com,
	peterz@infradead.org, selinux@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and
 vma_is_initial_heap()
Message-ID: <ZrUd-ZUe12FahKIc@marcreisner.com>
References: <ba8477ed-b7a1-4833-a01a-b7d43ddb47b8@huawei.com>
 <ZrPmoLKJEf1wiFmM@marcreisner.com>
 <CAHC9VhSWVdiuK+VtbjV6yJiCp=2+6Bji_86mSkj1eeRL4g_Jfg@mail.gmail.com>
 <7fb19e0a-118d-46a1-8d1b-ab71c545d7ed@huawei.com>
 <0806d149-905c-49b2-930f-5d6d0f8890c9@huawei.com>
 <CAEjxPJ5S9sz4PaRMVLyP6PWdLCG_bBxj7nw53EhU5+L1TM7kFg@mail.gmail.com>
 <4d2e1d4f-659a-428f-a167-faaaa4eca18a@huawei.com>
 <ZrTeT8_pzD8fH-_P@marcreisner.com>
 <zk5ffj6otbixbnppw4shxgz4tjulagm7du457gzi4qg7zrtdkk@e7mbwyzhdtrx>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zk5ffj6otbixbnppw4shxgz4tjulagm7du457gzi4qg7zrtdkk@e7mbwyzhdtrx>

On Thu, Aug 08, 2024 at 02:00:09PM -0400, Liam R. Howlett wrote:
> Have a look at the mmapstress 3 test in ltp [1].  The tests pokes holes
> and mmaps into those holes throughout the brk range.
> 
> [1]. https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/mmapstress/mmapstress03.c

In investigating this further, with additional reproducers, I believe
that the whole bug is in vma_is_initial_heap(). Here is what I have
tested so far:

1. Use only sbrk to allocate heap memory - sbrk(0) returns the start_brk
before calling sbrk(increment). Afterwards, sbrk(0) returns start_brk +
increment.
2. Use sbrk(0) to obtain start_brk, then request 512 MB of address space
from mmap starting at start_brk. mmap allocates 512 MB of address space
starting at start_brk and ending at start_brk + 0x20000000. sbrk(0)
still returns start_brk. However, /proc/PID/maps flags the mmapped
address space with "[heap]"
3. Use sbrk(0) to obtain start_brk, then request 512 MB of address space
from mmap starting at start_brk + _SC_PAGESIZE. mmap allocates 512 MB of
address space starting at start_brk + _SC_PAGESIZE and ending at
start_brk + _SC_PAGESIZE + 0x20000000. sbrk(0) still returns start_brk,
and /proc/PID/maps does NOT flag the mmapped address space with
"[heap]".

I believe that the entire bug may reside in vma_is_initial_heap because
/proc/PID/maps also uses vma_is_initial_heap to flag entries with
"[heap]" [1]. Also, sbrk(0) is not actually getting updated after a call
to mmap, so mmap is not actually allocating heap memory.

What do you all think about this patch? If it doesn't have any obvious
flaws I can submit it (along with a revert for the revert).

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..1dd588833af8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -918,7 +918,8 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
  */
 static inline bool vma_is_initial_heap(const struct vm_area_struct *vma)
 {
-       return vma->vm_start < vma->vm_mm->brk &&
+       return vma->vm_mm->brk != vma->vm_mm->start_brk &&
+               vma->vm_start < vma->vm_mm->brk &&
                vma->vm_end > vma->vm_mm->start_brk;
 }

--


[1]. https://github.com/torvalds/linux/blob/6a0e38264012809afa24113ee2162dc07f4ed22b/fs/proc/task_mmu.c#L287
