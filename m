Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9C149DE4
	for <selinux@vger.kernel.org>; Wed,  7 Aug 2024 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066024; cv=none; b=rC1wuKK88is3uo1zA8SH4KPZoQer7GI9nVgZ8dV9p4tqs7ckEBqeqe132/lmimmMrpYOASTpf8UOxiacqvFbGEeUYD9m9ZQDSsz89DEwal0yGl6D3i0y2ntvN2XeKYnwg3EHAEBru1zvzWTLw7fwxPlxFQ5ItyC0Ufz9HE7U9Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066024; c=relaxed/simple;
	bh=uD21Tafteyzzqae5u3ENSEeLapbiTVliheDUhJM53QY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uX4WBUfQ9SoLCxqEhljpdEs3o97X49CikUc1sTpTfTUWbfG0QzqUhR2heCMJqtJ89jlDCE6fmisdLqSijTRna1Dy08HZ0rwZOi3tv1X4RBy6g2A1jAAYF4YCWHMVgfhoRMMELdu2W2RciRhqvNfnyzxUqZlSjphL942fPHQ/mwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyCJrnSl; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyCJrnSl"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d9e13ef9aaso246964b6e.1
        for <selinux@vger.kernel.org>; Wed, 07 Aug 2024 14:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723066019; x=1723670819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjyZ9OnrFn1nf0ysQXHQAU+Sf3yl9Va6emSmsH69UeI=;
        b=FyCJrnSltZ4LVqgwozBbtJsEo18yO3I79eCKNWj9S3a4RwndsNjq8D2sI19XdqrjQh
         zh7j0kDEg4kiyPKBIRdUBEF72UT1r5xVKYqQe6CD8hOlkyjkwZ4sBcredxz1MJEPzBzp
         ER452rzD7uCea/drmYMvbxvdpgwIniGGpeeswYmNClg1ynM/oH1OC4LZBHlhOe951dhV
         E3BuLCSx88WY2Y6WwdjVTkg/TxMn/ZfZZ7oIFaWuCZ1UVpST/5JFympM9fRTuUSFdu2d
         UCUCCp7DioMzFtL2coykmkfrDcwF2WMb4aWojJvBmScV0zptu/7WrcEap7w4tShmcTbd
         gTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066019; x=1723670819;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjyZ9OnrFn1nf0ysQXHQAU+Sf3yl9Va6emSmsH69UeI=;
        b=Dwd8f4xs57ymS2/ySOH6lc5E3WjRWdPSKLuJBPqhZoR3vmzzuB7RjT9VKEHBWunsPT
         WQSqoUnZy4B7g7gI1dkC3g/b7uFE49vKF0llfySOpgfv+yYINlYVxfuiL3wR0Ma/363/
         0Ml0cPyqUvumybW+pgcIsUe3Jtzgg7aic2/apGYIJ71UFlM3S3iHr6MgX8MoPBX8tiZc
         yccmXtE8As2R+bhE6C35dbtDAk0KQjoKjxk5NsiiqN9iIDObrsOWyL3DJ5+y7ya4ukiT
         4bV0F65dyzszQwi17hWoaIEdARXDrEe9nLVQ9Uxi10cywqBSTjs2l9E9iiyOzG5n4+J+
         ocag==
X-Forwarded-Encrypted: i=1; AJvYcCVnWjkVTOBR6ML8SUhPNE1hIrR8ODBI8jbteeCgBKQoCy9XgOzGzpmlPuvxqd18V2TmshDAXC3uRACL1Sq64jAZ1OLFFuFaeA==
X-Gm-Message-State: AOJu0YyuMCyCX2N8qR+8mgKWqkLii+S69CFbcAQrXSqa5NamuqEY5aFf
	RTN6kBzr3jyKsYPLkP0X3nh8vZBX5iARv3wl5qpUE8L5pi4MHitS
X-Google-Smtp-Source: AGHT+IFXyKbdy1e6ZJKKOdF37x4gjVudepjfOM6ci4E6VEOKZDkjgtR3/WPfLULFUjqn3bIC7ohN3g==
X-Received: by 2002:a05:6808:3008:b0:3db:3535:7ffa with SMTP id 5614622812f47-3db5583d8e9mr24478028b6e.44.1723066018662;
        Wed, 07 Aug 2024 14:26:58 -0700 (PDT)
Received: from marcreisner.com (marcreisner.com. [104.248.50.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c8715d4esm7706761cf.23.2024.08.07.14.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:26:57 -0700 (PDT)
Date: Wed, 7 Aug 2024 21:26:56 +0000
From: Marc Reisner <reisner.marc@gmail.com>
To: wangkefeng.wang@huawei.com
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
	omosnace@redhat.com, paul@paul-moore.com, peterz@infradead.org,
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com
Subject: Re: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and
 vma_is_initial_heap()
Message-ID: <ZrPmoLKJEf1wiFmM@marcreisner.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba8477ed-b7a1-4833-a01a-b7d43ddb47b8@huawei.com>

It looks like this issue is still not fixed. There has been some
investigation on going in this Bugzilla for Fedora:

https://bugzilla.redhat.com/show_bug.cgi?id=2254434

The behavior we are seeing is that when a process has no heap and
mmap(2) is called with MAP_PRIVATE | MAP_ANONYMOUS, it allocates memory
on the heap.

If the address space returned by mmap(2) is later on made executable
with mprotect(2), that triggers an execheap avc.

We have a fairly simple reproducer. We widdled it down from picking an
address to pass to mmap(2) using getrandom(2) to using the same address
every time. Sometimes it triggers the behavior, sometimes it does not.

We also observe that disabling ASLR via sysctl
kernel.randomize_va_space=0 works around the issue, with obvious
caveats.

Here is a reproducer, which raises SIGSTOP so that you can analyze
/proc/<pid>/maps. It allocates a 512 MB address space and then attempts
to give it execute permissions. Running it multiple times will
eventually trigger the behavior.

#include <stdint.h>
#include <unistd.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/random.h>
#include <signal.h>

int main(void)
{
    uintptr_t raw_addr = 0x25085000;

    int length = 512 * 1024 * 1024;
    void* pointer = mmap((void *)raw_addr, length, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

    if (!pointer)
    {
        raise(SIGSTOP);
        return 1;
    }

    if (mprotect(pointer, length, PROT_READ | PROT_WRITE | PROT_EXEC) == -1)
    {
        raise(SIGSTOP);
        return 1;
    }

    return 0;
}

As far as impact goes, this is mostly causing Chromium/Electron based
applications to fail randomly, but I believe other applications such as
wine-preloader (which I do not think is based on Chromium) are also
affected.

This has been reproduced on kernels >= 6.6.

In reviewing the code, my best guess is that this is caused by the
scenario where brk == start_brk not being handled, though I am not
expert enough in kernel code to know. If the start address allocated
by mmap is before the starting program break, and the end address is
after the starting program break, then the avc will trigger. However,
I don't know how mmap deals with determining an address and if it takes
into account the program break, or if calling brk(2) later on will just
pick a new location.
