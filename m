Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D7618EFC8
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129428; cv=none; b=n+7OunQxXrZkhDuGJc8J/gHCw0J6ALqrGS+onvxfNihLZ2zdihT6Kr4cKwsCugeh4Re2a8javiGOntO8hH42tBCd5m30hYvF2r0rnlD3nKflw82xabkdvge63qzSx2bd9+2ktfdX3irl2VTU6ShQ3H9UpxE2y64RUrGbwI6z6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129428; c=relaxed/simple;
	bh=Hqw7mpxPm0M+B/1PU2lIhoI252y/4h+6m5nIfUJir/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7scsST1bIhWPbuVxKBE8KQLGwoG18j5dMaO0pJoU7fGvUqA9Krtq3lipssFmIOiCHcUuqTttfex1K4MlFez88Xq6jRhV/b/ySVvaN0kga0sptQnljChw/zAVlQ+HJzflae/3MuVp6ci19KQ+jEqYnODQ/sW5q3Y3u7V1GZXh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moU6ZAO2; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moU6ZAO2"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44ff9281e93so5475341cf.2
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2024 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723129426; x=1723734226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aM/Jr6STikMKNmShKMS5c1tcJe7z6KN+78rOE4nS7Go=;
        b=moU6ZAO2YKpN+7yqwnxXPqHuuH7wqE+2vgDlz4MJVnwcSpiAGVNBYWCpaZN7JXusun
         ogS9x2WDA1/L7qUy5T5ZoaFz5gKGvxn+8nrdvZoavM3HEyuE3tjVJAu/mb/b0K2xmp6b
         b5EU91a9klbOQP8wwRpZHOZ8GnXAqumi9SETPfqIt4IfZZebXeg8egBLt1th4T6WRssC
         6K9s/xaRewB1F0q4xz/Mq1+yA1EX0UrPX6R+4tw2fYmUs+mH80d7RamgWEfplils84Xo
         eIHf/rAq+6sd2lDF5hkwGIio0UMFgfGGFsTohQCHq3mL/eDW0AzSLvh9fdpDGKIB6AaM
         Q/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129426; x=1723734226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aM/Jr6STikMKNmShKMS5c1tcJe7z6KN+78rOE4nS7Go=;
        b=EBchOSZiGOUPO6e9cp3LqV4PgcWBO1a5mT10tOZZUcpLlrDpX5ZZQerONwzHPF95tr
         HeEI/w+H6KBy+5YcLigPGf46jLt3sxdr66Pc6p9wAz395gOd0hHJsQSRt7NyUxgOs0Y/
         wg7sHd2BC0HQ4CAAbMxPW4tLUIV90zsZji35R6+onuHPK3YDaqpnqGMzKrnFFwAcLsmi
         fjBbPL7a6FMLMGZg8pJuCYakyByIkYxFga0mvYGnijgq3N0EDMGFety5aPQsi0S4h5b7
         VlrBI1o1LjybkplJG+sdOY9Yyz+LsbSDPwS8Vl7uvDDHyieIlzWiWx3SHjtyhOlgdFgM
         HrRA==
X-Forwarded-Encrypted: i=1; AJvYcCXwk95BGpOtE2u4uMQ4/QkWRwe/O/YqzBSssMWCwlb37VSyHVn7sKdmbxUiqGT3dfLHASvltanpM5n4E8Qnc/+xxs4R59BcGA==
X-Gm-Message-State: AOJu0Yw2EL8LLhn+Lj8G1Si2U+DuPsacPhWOsLHiOfQn8sisdRIl6q1e
	mMfWUiCDBDAg2ly5WEasJ8ZT3pPS3BuKAuRwAggUNjVsj6JRihzt
X-Google-Smtp-Source: AGHT+IGtU19iZ4iiknKm7NQQJfINUSRfrDegzrL0Cg75vjHIYUC9icGMQtcWILBYEA0E9UsoiQ9qiw==
X-Received: by 2002:ac8:6f0a:0:b0:440:6345:257f with SMTP id d75a77b69052e-451d42ff7c2mr30240701cf.60.1723129425599;
        Thu, 08 Aug 2024 08:03:45 -0700 (PDT)
Received: from marcreisner.com (marcreisner.com. [104.248.50.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87da933sm13769911cf.66.2024.08.08.08.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:03:44 -0700 (PDT)
Date: Thu, 8 Aug 2024 15:03:43 +0000
From: Marc Reisner <reisner.marc@gmail.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>, Marc Reisner <reisner.marc@gmail.com>,
	akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
	omosnace@redhat.com, peterz@infradead.org, selinux@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and
 vma_is_initial_heap()
Message-ID: <ZrTeT8_pzD8fH-_P@marcreisner.com>
References: <ba8477ed-b7a1-4833-a01a-b7d43ddb47b8@huawei.com>
 <ZrPmoLKJEf1wiFmM@marcreisner.com>
 <CAHC9VhSWVdiuK+VtbjV6yJiCp=2+6Bji_86mSkj1eeRL4g_Jfg@mail.gmail.com>
 <7fb19e0a-118d-46a1-8d1b-ab71c545d7ed@huawei.com>
 <0806d149-905c-49b2-930f-5d6d0f8890c9@huawei.com>
 <CAEjxPJ5S9sz4PaRMVLyP6PWdLCG_bBxj7nw53EhU5+L1TM7kFg@mail.gmail.com>
 <4d2e1d4f-659a-428f-a167-faaaa4eca18a@huawei.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d2e1d4f-659a-428f-a167-faaaa4eca18a@huawei.com>

On Thu, Aug 08, 2024 at 09:12:59PM +0800, Kefeng Wang wrote:
>
> OK，revert patch is sent, but I am also curious about it.
>
> https://lore.kernel.org/all/20240808130909.1027860-1-wangkefeng.wang@huawei.com/

I am also curious. It seems like the "real" fix would be in mmap - my
understanding is that it should not intersect with heap, even when heap
is empty (start_brk == brk).

It looks like start_brk is fixed in place when the ELF is
loaded in fs/binfmt_elf.c:load_elf_binary (line 1288).

        if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
                /*
                 * For architectures with ELF randomization, when executing
                 * a loader directly (i.e. no interpreter listed in ELF
                 * headers), move the brk area out of the mmap region
                 * (since it grows up, and may collide early with the stack
                 * growing down), and into the unused ELF_ET_DYN_BASE region.
                 */
                if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
                    elf_ex->e_type == ET_DYN && !interpreter) {
                        mm->brk = mm->start_brk = ELF_ET_DYN_BASE;
                } else {
                        /* Otherwise leave a gap between .bss and brk. */
                        mm->brk = mm->start_brk = mm->brk + PAGE_SIZE;
                }

                mm->brk = mm->start_brk = arch_randomize_brk(mm);
#ifdef compat_brk_randomized
                current->brk_randomized = 1;
#endif
        }
