Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42C481235
	for <selinux@vger.kernel.org>; Sun,  4 Oct 2026 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139164; cv=pass; b=eoBqvemz+5R/2pVYFAkh8FqfM9fRBR0bRJCJ44Ore5UWdiYgIGJ9lCbtMWak5ZJmsYSQbYEkOU4POqduUhTtH6gMPSnuSKo2ZyIy4KERLK/7DFGuIFqKjecFo0SzSXHQEurqDHGOfPvDYFqd9IzImvJInT8O7zOf7lzI45XsrQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139164; c=relaxed/simple;
	bh=Q5SKncuQynV4x7Bps+RIZqUEFmiH2TTHOAAQrnnR074=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlIUVY+yYVdM05z73rHAF+Vzx5HYKr4bp+6DcBC+nVVaOdBiyCBPS0r4Sr/uRLYfmnMBWPWYb+PfFCpA9ecgxf968JtFpqJl3jbSZgo0LfP0UA4gES5XgsaOgQghbPYbFYB8vsNAp4F5zIpp7u1tKf9yXm6Ske6q5QTqHHTvAIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0iHyxjb; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0iHyxjb"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5337c7b9937so265671cf.0
        for <selinux@vger.kernel.org>; Sun, 04 Oct 2026 11:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791139161; cv=none;
        d=google.com; s=arc-20260327;
        b=W+R+UuIubWAlBCx+N/d+OZswPT473JJu6Kp6axkZQJ1Oe0y4YTFl6vv+Maokzv9avN
         qval83ZizX8QP55yODIrU0W3FFsovE96efppILIwg4RBoaZQqgxo9WJuCylDMMvrV1/7
         14zW2ydO7/NjSLf18JQHmIF+MUry2/f1I3f3/bXU+0kbNTWJz+fSQBD57YJKdbOKc1GC
         jeRz5Bfl/iH68QGWNnQcGVsF+6YyqPRGzI0QX85Ztp2VmOxauP8GjBRhsHcqOIXDcZqh
         5n5yu5d8eWlfY/5CDooSJgn6rkjfte+aaNbSBQ5BJOBO9DdsnKLd9UEUce0wDuwoY8GT
         ljxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
        fh=HgN9r3oXjzQtNgOqPbimWhVMq6twADbpG+udIAaOdxE=;
        b=sgLhPHGMkTcfgWWzrLKes8ZxyyrXn+EFEbhvbKXWPTTO1zqe43u7toIErr6vLJJfmN
         0cAhOczaZff7Da9tFV68byyF/4XHbpEGk76KwmkDi0v4E4zXUEck2+lgyfHh6U7si0XO
         rsYuFBI5u78elU3ViADo0qIRQ7IiyFVB8AV+kOxpAYqoMcQ6pEtjV194xEHvOdHpqqMI
         GfJtciB3NLSLaFtFfm0PqfjDhujtVUpGHPj/w5Gl+ky+Uu/L0kKbaJd7WYBuzSNTdFOd
         7f3UzDh/uNCBL2yr5yQvoDnciUmW2qrqCpSs+IxWd+IvEEkFp1S2t+3QwNyi95DaafzZ
         aL+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791139161; x=1791743961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
        b=l0iHyxjbrFA0mj0qSWG3UEuOwCfeu39THooR7JdjvlpS5iPbcpbOGXWgFlwrHqiq17
         g6OREDzEJg1B4R9e3NlLt/FQGfnUhJDJq9ugUkIwHD8Ouc6I0KCAE+AjFJ5im2Q3teHM
         xpabytF01LqRy3edoNlhxz/KOOwY/glawDCIRDkU1ItyqnPxe60feD3VqcauD0MIeU4s
         Cvv/OfjgN/b+SrE6g8xki0vgbqOIO/2Zkxe+N05IzJfOVKCkkH4F7eFCLA6UNgq7uegJ
         Iz6k97ECHJF0Ws6uFXO0NrKMD645vu6jOd91RLmcYxQ0T3ig64z73JKnKEdXvgZ6oM2B
         rqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139161; x=1791743961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
        b=t84xFyAH/PZqgLk8uP2pDllNAyzHR/kdflqJ+W7L05zUKTPSDQeu9KcAQSYLnSqnO8
         TuMqR55buigCkxsOOdTchYqmaENAbesKDI1RVCM+HKsfXLvVABZLdIvEGML9+REXtlZa
         lTGY3EEMXeKBh4hLqFE/r1o5glnrAPxE9+LT0iBnX4r4iQyDOYMqQxg5rcDOa67el87U
         ErJEaL9m5Jt9bsmfm6ejp3Q6GQK82YCUKQNVMXItWPn6/k4a5E70k4oDhKsFUOQm/zv6
         +RhR9bDKec9/DselN942GDUG6H1LFUENu4+mZlq8jnSpq/D7nNCNOKpr6rDBqjZPTPCN
         ui3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxDfvdpHlxxegGWwO+3Yr8Rg7PL8Sb6tckUdBzx0jPi8qhRnQU4hmlYbggqXxr6j37abFThHosJ@vger.kernel.org
X-Gm-Message-State: AFuF++nBPHZkyXi3QWtgh+2TZ9LtwAxuP9/D6SJKgqF/Ulv+MTloE9Bv
	G9pc4a5uAryXUxEyHpCOKGKL/sBisOpSrWzDd3Ygz2VfNTcjpJIs0/7Qf4mSO7NKPKxqaKpaoVK
	W4fjBKf/ur+5/FSM3qrEiMkEhUyB+iD/KEGRD2xKy
X-Gm-Gg: AYBFou2p3bqAAkd1KTXDE2YibIKDF+zRVrt4mOZmRAx26NYPglB/js98nAHNgV37Oe/
	YIiC7Vp4x1AJRs1tL/4qLY8SluQtkgMshETTH4o6in4u7+1TlZLuZ0O2Etf66slQrFIyIM4hIT1
	JV7qgzq6Xstykifo9E6RVc9URFObTb7fxccx3uOybdc1QYSmxSk8vaEBgEAUHPZSH7Y4QfuDQyi
	ljDNbfcwStBcJAflZtOxXEuGvH1/mVNSKF8+VwK6SRxqQpeA3eIIArK9ONTLw/wdf6kDQogKxhG
	qMhRbp3XrxW2qLWUQ3BQYCls8HM/KV+JZcS/OpSOYIaeoZ/RTOOlf49a
X-Received: by 2002:a05:622a:a16:b0:531:282:6560 with SMTP id
 d75a77b69052e-5351322e1b3mr19806961cf.15.1791139160071; Sun, 04 Oct 2026
 11:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-21-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-21-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 20:39:04 +0200
X-Gm-Features: AclHuK-BFFMO7RL_23L1uoIyefqTPzoxo4liaojYggefG4PLZrnFo0OrrSwhSqQ
Message-ID: <CAJuCfpGtyaqwi__OXcB=iy2+LUVzFnLo-Q=Rdxz728_EHdTaWA@mail.gmail.com>
Subject: Re: [PATCH v4 21/38] uprobes: remove VM_IO, set VM_MIXEDMAP for
 mapped kernel pages
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:40=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> These are not MMIO pages so VMA_IO_BIT is an inappropriate flag to set.
>
> Instead, set them VMA_MIXEDMAP_BIT as they are kernel mappings and this i=
s
> the appropriate flag to set for those.
>
> This provides the semantics required - no VMA merging is permitted, but
> does not prevent GUP.
>
> However this has no meaningful impact as these are refcounted and thus ca=
n
> be GUPed.
>
> A previous commit already prevented __mm_populate() from being invoked on
> XOL areas, which VMA_IO_BIT was previously relied upon to do, so that is =
no
> longer required.
>
> Both VMAs set a VMA name, so always_dump_vma() returns true before
> vma_dump_size() reaches its VMA_IO_BIT check, and thus there is no change
> in core dump behaviour.
>
> Change this for both the core xol_add_vma() function and the x86-specific
> get_uprobe_trampoline() function.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  arch/x86/kernel/uprobes.c | 2 +-
>  kernel/events/uprobes.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 65a2de82ecd2..0f60c0d076b6 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -715,7 +715,7 @@ static struct vm_area_struct *get_uprobe_trampoline(s=
truct mm_struct *mm, unsign
>
>         *new_mapping =3D true;
>         return _install_special_mapping(mm, vaddr, PAGE_SIZE,
> -                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
IO,
> +                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
MIXEDMAP,
>                                 &tramp_mapping);
>  }
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 7709ea882477..b89cc5cee002 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1726,8 +1726,8 @@ static int xol_add_vma(struct mm_struct *mm, struct=
 xol_area *area)
>         }
>
>         vma =3D _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|
> -                               VM_SEALED_SYSMAP,
> +                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|
> +                               VM_MIXEDMAP|VM_SEALED_SYSMAP,
>                                 &xol_mapping);
>         if (IS_ERR(vma)) {
>                 ret =3D PTR_ERR(vma);
>
> --
> 2.55.0
>
