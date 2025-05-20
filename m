Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09126218EA2
	for <selinux@vger.kernel.org>; Tue, 20 May 2025 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784819; cv=none; b=EennsxYkuEjMGGm0ihsbWyc8W3LMey8OP4N7l3Fgi/Biejd/kYnIql7i7lh9vjBQ3kRwauB9KTFABVJ+z+12y6SyYaFGFasuKBRaqI92cGEHBxgh1fNVDxjeFAcEEsrea/5LCqoPhbQ31OCVBY5Km99/7Z4xwGTFNOIAqOrkpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784819; c=relaxed/simple;
	bh=Yq4HYpfhUCfzoOsCPE1QdzGf4m2iO+EWr/iRDSqOabo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3lxa9DyVpclqA62kn/WUw9PjP13HnszmDfLG6KzAG1jPsU4wifpsC2vDSZj1kka38vbyLR34l8JOypO7GNCrX3HLsLugqF9/Xm3oRFptpt23XKIl9YsQf5ETl4iNX3WzRSVEnjierX1KlZKFUGYh/7X8DhTl3Ix1isl7ppc1/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WFNxh4uI; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WFNxh4uI"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70cca430085so32026867b3.3
        for <selinux@vger.kernel.org>; Tue, 20 May 2025 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747784817; x=1748389617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yq4HYpfhUCfzoOsCPE1QdzGf4m2iO+EWr/iRDSqOabo=;
        b=WFNxh4uI2Q5dz31eMYwI1czAbR33ceSO0mlUn10O0LdFYfy3F8IXPaTAUI+hG6lRp8
         TJDJQJOWGIRxBBb26lik8zLphNz3MWvTKEFtkhCVwoTYZq0Y21q0YjdLxP1VnDpdHwJf
         Ti94nHdgFOO8GbzSeWhq2JQCJcAxzezB3ZF5u0qPcHoiv9ywm0NbW3CCajvE83sQUNt2
         5eivyhlIolmFhPg7bwFsQySnUjApeBCA+K2iug1EnL2KaQBRSqkSl1Gqek8eGI7XObyt
         7kqOg07iFcIMdc/GmJVMA+q+IOLlhFn6FDeNLRflcVE+Bxrbf2BEfdNUzurS83Lh5T3S
         65XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747784817; x=1748389617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yq4HYpfhUCfzoOsCPE1QdzGf4m2iO+EWr/iRDSqOabo=;
        b=rbWCABiiLBDAZHqD9r+J2BOs5EMBpw+q3kVajy6xM4xCShFxOsLc6sYAp20nDjGhh/
         3F34JVP6VNBK2SZTpa1vEbu/jpf4X2Mbu+zd6G5ZFRiR3UOIBFo8XYYn4IN/UXOdyIRk
         QbORpIcYItqCwRbVkOQUOhZOkkYiiF8kVENApcjYg1+st5Mx9AMszzUermP4SRkBW1un
         3vKQ34vlOxRJDp3b1GmBCp8weG1igEjiebWNrn2VsDmCgpll7ph1V9Qcx5WIHGUmT0UQ
         hVnFdVbIBmJ4bXbJIfjqZNwx6VDM6AN2bK91yL45d1r8ABB7NCRA5YiLS5+PGI/8dQg3
         G0yg==
X-Forwarded-Encrypted: i=1; AJvYcCXvpQbZ3XgPR/JSgn8xKdrfuzf/GvN3tZk8fV6C9tOi4UjBE8CPYEtkwTOd6h0TFnNvcyZvXsKZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwpR2FZunheGaIfNTgBmvlwXfeL9fYlX4cSLmIW0LxWD5m+Tc0o
	slIf+HsXwYiSpyMlDZZkGNAhyhJ7Py3IhrdCsupXG2smXoQN+JNNU6ncYPnZXvpq1Vw4xTXzCY2
	Klw5caHwmM3UZPXqvjt1YfRWO383ly4XkiRvVL/wt
X-Gm-Gg: ASbGncthkK7w1tQ1Zcf/1qP/HTisaa9AlR+eMhLSRsRhbriFM0DtWfzeGKHTb2xTsMc
	cy7zuUcCHMvJJmxZmm7WD4+YMSNhEZA/N719ogtxkFxxsP2sKLoTh4ztJrfG7SourOvb1T9PqFE
	fOcl7ARW4s+hTF5PR6c7gYwUfdzh8iOggL
X-Google-Smtp-Source: AGHT+IHJcBO4BYxHzd54ZMIX+sDvUsrmRaER0cU5tHMU5i88RsMg+/6LGiRjXzPUqsqqWVXR2LteJoE7pgou+j+U3wg=
X-Received: by 2002:a05:690c:6e10:b0:708:ca91:d583 with SMTP id
 00721157ae682-70cab0b8e9amr251259677b3.25.1747784816903; Tue, 20 May 2025
 16:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506031833.6107-1-caixinchen1@huawei.com> <6f9de6c4-a2e0-4423-b581-dc15822fc641@googlemail.com>
In-Reply-To: <6f9de6c4-a2e0-4423-b581-dc15822fc641@googlemail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 May 2025 19:46:46 -0400
X-Gm-Features: AX0GCFvoL84BT-dY8Jn-b03a1sTYavgsX95-fSUXRtRCJcGmdSnei1aQcwknin0
Message-ID: <CAHC9VhR5a8Wuj9hkgj2AgCGzk-3dmSHDoMr7AY1qOtLaPbj01Q@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Add check for the user data passed to kcalloc in hashtab_init
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Cai Xinchen <caixinchen1@huawei.com>, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	ericsu@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 4:14=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> May 6, 2025 09:20:51 Cai Xinchen <caixinchen1@huawei.com>:
>
> > When the user writes some data to the file /sys/fs/selinux/policy,
> > there is no check for the user buf passed to kcalloc. Syzkaller shows
> > this warning:
> > WARNING: CPU: 1 PID: 6642 at mm/page_alloc.c
> >
> > __alloc_pages_noprof
> > ___kmalloc_large_node
> > __kmalloc_large_node_noprof
> > __kmalloc_noprof
> > hashtab_init
> > common_read
> > policydb_read
> > security_load_policy
> > sel_write_load
> > vfs_write
> > ksys_write
> > do_syscall_64
> >
> > This warning can be reproduced by writing this content to
> > /sys/fs/selinux/policy
> > 8cff7cf9 08000000 5345204c 696e7578 15000000 e0ff962a 08000000 07000000
> > 4cf523cd 7eec2688 6d70a6b7 c78b496f 1a0a192c ea34ff41 70581a74 3ff0cfb9
> > 7ea0f0d1 70d1fe14 41c2f7c8 ea1c78dd 17a19249 35210081 a83c30ec 4171450b
> > fc1de12c fe1ff342 a887
> >
> > Add check to prevent the size passed to kcalloc larger than MAX_PAGE_OR=
DER
> > after get_order.
>
> This might be similar to https://lore.kernel.org/selinux/20241216164055.9=
6267-12-cgoettsche@seltendoof.de/
>
> I'll try to respin that patch set in time.

Or we just use _GFP_NOWARN which I believe should quiet the warning
without having to do a lot of extra work.

If someone wanted to track down all of the different allocations that
can be triggered from a policy load and mark them all as NOWARN, I
think that would be time well spent.

--=20
paul-moore.com
