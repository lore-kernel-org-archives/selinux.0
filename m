Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FAF556BB4
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182070; cv=pass; b=kU5bKoEz6bvLhn5YZfVBeJzr8SgPgAU0Omt17RFM0ajBWs9u9WXHmS20YyQ+ONJTAwSl0FAGNN1Tzck8Fx8GucN28v91pz173vSmjpQjjn6liQ+H4s89sJQFBEnIcmtb1X+tl78Mkb0Ei5z7T+OKpuYTyCCr65ZzYWqhf/EK6EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182070; c=relaxed/simple;
	bh=BS1pN1lf2NXiKiQrtVD+Gg5ZPa8iWxon1HWZu0sw6Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VI6kZTPPM5VaiAUNmLyx1MwG/L7kpt6rLPYXdJjHCQUPT0EH85ZkTUrF28EvnmQd5T/jBY5J9U7WAp9WNZYM5E43cphdt2aEXwUJVwO2OTW6D6cxQXqWogAVkMJvQuTDcDg/u/9JdoxMK3Zg4vKS5YS91ZXwjpa8SPG15P7eaaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVPr+0ur; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVPr+0ur"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-530e8c6fb80so284421cf.1
        for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 09:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790182053; cv=none;
        d=google.com; s=arc-20260327;
        b=EQXcV6OFwTynFS5DKG3gPzNNgNDAAf+HcLTnnCi1z6n/6Manknb9wAD4dVk3Rxx0xX
         r+W3xLPrRJj6yOt0zKY8tfypCD17vo5FrQIgdwPhp8DXkBxiB//o+bZr8VRrdrssD2dj
         XRk4JINgWZBR7Uo5+w05+/M0ewVtjkKPM5d2syZZC0vMU5vyiFeTpBEFoCYKKaYiD5yF
         F/JdDvDFcThhkHKGq1ECrCr1b6mq7b05fkra0br3U1jmPQ3ZEeGPp9DBWWcXJ3MebQtl
         GG2tBAesSyat6LZtq0mLO94LUouLn9vRDYb6nriGCU3KfdrbKYwkHiAy6x4Egq99p1qZ
         v81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CmfZqOIcZMi+n6JYS11k53fRFKi7v2MDj9yxHBvJbZg=;
        fh=y4K6hpupmCkUeVoz6WQGhdYDpk3OBm3YVYZqLQfmZjc=;
        b=HH+f1enrDDMlVGQCgngx2rd+4vbBxk2cEBJ8WujIMYo5aO8fSvQr3HYeFzG4Eewt6g
         jFiIyXs6Fc5O8Ifs3ReEo5N2ie0048Ew/DmqRlh4/6JMCMBmggWp9hbD3wS9d3ks5nSZ
         UYbgriwHULNVHjloh5QnSv3nd8VtoJkcDrYrxmQS9Gj2yS6lRyR4koxc6Exxm5npD71v
         PYuR4xlbqmmdNXt2L7Cn7ILsMT8i0kzA2Zniq++GEvqJAPLaFLLmaMPberKR+CLSD3NK
         qIjV5Cn6h3iEKcVyznbL/bpvuyAiZwK6oGKKB66V2mf39rs2cvefx1vzz/GxGeSuxUB5
         uRNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790182053; x=1790786853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CmfZqOIcZMi+n6JYS11k53fRFKi7v2MDj9yxHBvJbZg=;
        b=XVPr+0urBfnmk++Lo6wc7ymdDqhWWIucsymBdx/ExXtWLlDt1lcXrL272jevqPIi20
         Hd4UxnMxchipH8EenBV/drUCn66rv32tiqHjg/nZ61pV3VdxwT60e/W7HoHT74s2Kb/x
         sNK/tby/g42z3zsBYXWaFw4KQIqnF5Ty80m3XrHgNP43ugkM8EFieTZBPMRt/v049iWd
         MYTxoyw+2utBc0NfZVuzI/ZA7UrqMRw6Qg19H+zAgyxZxmfM2mG+GffOFxg8fE7qiaSe
         oRj3tkZgvsZ9mPuJUSLlEn8yYkSGMeusc1o+EON3zvpCDPONLLXgNyYpry6oOyiwWysF
         MUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182053; x=1790786853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CmfZqOIcZMi+n6JYS11k53fRFKi7v2MDj9yxHBvJbZg=;
        b=QNxuYGwbcom2uR8wQxMr5JAAn9eiJtswYeBd5ICB66RYMBnfgkWZoTRsGT3/k6MxkA
         YdG26TI7k5r4jwPHpzR3qAGMzhVPVXSLVXUT3VCqs6Sbq2sBAlMGnXEbMBwhTXmHzYOD
         oy8R/FGqY6lvpUWK9KdpG8BGvIQg6QvzTIqXP3ISGyS2ZcWPE70vj0uJf7tniLnHuGJ0
         1KFu7ef4J+Y7RQUomkhQPnlVhcbhfCyS8X+I45Old0PC6dCN5awGh2oe60F9R227Z99M
         MjH5GabWMyyqdoSvTNKEkVNI7Rc1K62O52gK7Hwv4wQP3ch+2Lp/UzISUe8yJ69WA1HC
         ao1Q==
X-Forwarded-Encrypted: i=1; AKwUvBze/O8V5kKZV/cw/o7PTPyKPq/VwQy0QUTNraKbvgPGb/v8oY2wrKnfTn0kZT8Zfd//jcBvz2GN@vger.kernel.org
X-Gm-Message-State: AFuF++lWi845GKlLGvUq3Z/tYubAPTU138RbpZ+NlpvCK+3Xg81SKeSW
	uDjyYbAFUXReEJD9NckTD5P6JYJMsI2E6e9OMYhpM9fKt9J5X6Kag8RSxcKS6Js9UZvJtEfwwG7
	xtt5vNhzATLM/OjNl1SaP728+ZIwi3+MPD0Y+uEV4
X-Gm-Gg: AYBFou1IPbT0T3Cte0B0EIWX3smeXgs2qa7qXll2eD4e6ZCA5vsyBkvffbduzVFDj7J
	HaYLydCgRissi5POnepEqtJtmUocEt9hPyFIou7RioYctYqaqPFVWVXQ9NfSTAxTqu5SY0dKgo6
	xjgbxqQzPx4+n8KfuEJ5OBbX5luQZ1sILZKVRTLujkEs0ixbKYFxrb3YNA3fH0GRR+WTjgsbBH3
	cofoBFFTBmACNZZOkupJ6YITgHUlIyeKe3we2sP54bEw6COe/n4+oMBZaQZg8mZgrBRn/NRdb11
	kXQ+jSuNJ5KIStLYxJxegnsFjnrQzx1RqUydHryoex/sBhTyiCzLkcLL8QTVJBsSAp57mOvTfRq
	VvpV1zGP9zCg=
X-Received: by 2002:ac8:7c43:0:b0:531:475:4ce6 with SMTP id
 d75a77b69052e-532f9c8446amr855061cf.9.1790182051765; Wed, 23 Sep 2026
 09:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-4-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-4-4583d8a23bca@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 09:47:20 -0700
X-Gm-Features: AclHuK83Kla3imZgJxwcVqaZrjkW9LZwYBjsyBrh5q6aKIVAyiuE6uaku1WwNaI
Message-ID: <CAJuCfpELP9Ups5XeS3PNbF=VtrfkYbkwRj-LuEHd7bLsTw4LUw@mail.gmail.com>
Subject: Re: [PATCH v3 04/40] mm: consistently validate VMA state after
 mmap[_prepare] hooks
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
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
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

On Thu, Sep 17, 2026 at 9:25=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> When the f_op->mmap_prepare or deprecated f_op->mmap hooks are invoked, t=
he
> driver might have done something crazy that is not permitted by the kerne=
l.
>
> Currently we check for three such cases in __mmap_new_file_vma(), but onl=
y
> if the legacy f_op->mmap hook is used:
>
> * Did sparc ADI result in invalid flags?
>
> * Did the driver alter vma->vm_start?
>
> * Did the driver make a file-backed mapping on a read-only file writable?
>
> Generalise these checks for both mmap_prepare and mmap and apply to all
> invocations of mmap_file(), the f_op->mmap and f_op->mmap_prepare handlin=
g
> in the core VMA code and the mmap_prepare compatibility layer.
>
> Also extend the vm_start check to vm_end also - drivers must not change t=
he
> VMA range at all.
>
> We also WARN_ON_ONCE() on these conditions as they are things that should
> simply not occur in the kernel and it's important to call it out when it
> does.
>
> We invoke mmap_prepare_validate() after mmap_action_prepare(), as mmap
> actions often manipulate state in the descriptor thus providing the final
> state the VMA will be derived from.
>
> Also call mmap_validate_vma_flags() in insert_vm_struct() to ensure that
> special regions which are inserted (such as a VDSO or VVAR) also satisfy
> the sanity checks.
>
> This way every VMA established through an mmap hook, whether via mmap() o=
r
> the compatibility layer, or inserted via insert_vm_struct(), has been
> validated. brk() VMAs never pass through a driver hook and so need no suc=
h
> check.
>
> While we're here, also fixup a couple disjoint blocks of #ifdef CONFIG_MM=
U.
>
> Finally, update the VMA userland tests to reflect the change.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/internal.h                   |  51 ++++++++++++--------
>  mm/util.c                       |  19 ++++++--
>  mm/vma.c                        | 100 ++++++++++++++++++++++++++++++++++=
------
>  mm/vma.h                        |  25 ++++++++--
>  tools/testing/vma/include/dup.h |  10 ++++
>  5 files changed, 163 insertions(+), 42 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index fe576d468af4..970fb34898b2 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -213,6 +213,24 @@ static inline void *folio_raw_mapping(const struct f=
olio *folio)
>         return (void *)(mapping & ~FOLIO_MAPPING_FLAGS);
>  }
>
> +/*
> + * If the VMA has a close hook then close it, and since closing it might=
 leave
> + * it in an inconsistent state which makes the use of any hooks suspect,=
 clear
> + * them down by installing dummy empty hooks.
> + */
> +static inline void vma_close(struct vm_area_struct *vma)
> +{
> +       if (vma->vm_ops && vma->vm_ops->close) {
> +               vma->vm_ops->close(vma);
> +
> +               /*
> +                * The mapping is in an inconsistent state, and no furthe=
r hooks
> +                * may be invoked upon it.
> +                */
> +               vma->vm_ops =3D &vma_dummy_vm_ops;
> +       }
> +}
> +
>  /*
>   * This is a file-backed mapping, and is about to be memory mapped - inv=
oke its
>   * mmap hook and safely handle error conditions. On error, VMA hooks wil=
l be
> @@ -225,8 +243,12 @@ static inline void *folio_raw_mapping(const struct f=
olio *folio)
>   */
>  static inline int mmap_file(struct file *file, struct vm_area_struct *vm=
a)
>  {
> -       int err =3D vfs_mmap(file, vma);
> +       const unsigned long prev_start =3D vma->vm_start;
> +       const unsigned long prev_end =3D vma->vm_end;
> +       const vma_flags_t prev_flags =3D vma->flags;

nit: Might be just me but when I see prev_XXX in VMA-related code I
picture previous VMA in the address space. Maybe call these orig_XXX?

> +       int err;
>
> +       err =3D vfs_mmap(file, vma);
>         /*
>          * Either we tried to call the file hook for mmap() and an error =
arose
>          * or a driver set vma->vm_ops =3D NULL intending there to be no =
VMA
> @@ -239,26 +261,17 @@ static inline int mmap_file(struct file *file, stru=
ct vm_area_struct *vma)
>          */
>         if (unlikely(err || !vma->vm_ops))
>                 vma->vm_ops =3D &vma_dummy_vm_ops;
> +       if (unlikely(err))
> +               return err;
>
> -       return err;
> -}
> -
> -/*
> - * If the VMA has a close hook then close it, and since closing it might=
 leave
> - * it in an inconsistent state which makes the use of any hooks suspect,=
 clear
> - * them down by installing dummy empty hooks.
> - */
> -static inline void vma_close(struct vm_area_struct *vma)
> -{
> -       if (vma->vm_ops && vma->vm_ops->close) {
> -               vma->vm_ops->close(vma);
> -
> -               /*
> -                * The mapping is in an inconsistent state, and no furthe=
r hooks
> -                * may be invoked upon it.
> -                */
> -               vma->vm_ops =3D &vma_dummy_vm_ops;
> +       err =3D mmap_hook_validate(prev_start, prev_end, &prev_flags, vma=
);
> +       if (unlikely(err)) {
> +               vma->vm_start =3D prev_start;
> +               vma->vm_end =3D prev_end;
> +               vma_close(vma);
>         }
> +
> +       return err;
>  }
>
>  /* unmap_vmas is in mm/memory.c */
> diff --git a/mm/util.c b/mm/util.c
> index 016932780925..bdd5923eebc7 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1224,19 +1224,28 @@ EXPORT_SYMBOL(compat_set_desc_from_vma);
>  int __compat_vma_mmap(struct vm_area_desc *desc,
>                       struct vm_area_struct *vma)
>  {
> +       struct vm_area_desc prev_desc;
>         int err;
>
> +       /* Derive state prior to mmap_prepare hook. */
> +       compat_set_desc_from_vma(&prev_desc, desc->file, vma);
>         /* Perform any preparatory tasks for mmap action. */
>         err =3D mmap_action_prepare(desc);
> -       if (err) {
> -               if (desc->vm_file !=3D vma->vm_file)
> -                       fput(desc->vm_file);
> -               return err;
> -       }
> +       if (err)
> +               goto err_put;
> +       /* Check the caller did nothing crazy. */
> +       err =3D mmap_prepare_validate(&prev_desc, desc);
> +       if (err)
> +               goto err_put;
>         /* Update the VMA from the descriptor. */
>         compat_set_vma_from_desc(vma, desc);
>         /* Complete any specified mmap actions. */
>         return mmap_action_complete(vma, &desc->action, /*is_compat=3D*/t=
rue);
> +
> +err_put:
> +       if (desc->vm_file !=3D vma->vm_file)
> +               fput(desc->vm_file);
> +       return err;
>  }
>  EXPORT_SYMBOL(__compat_vma_mmap);
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 05d2c676672e..d6ed10cefc8f 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2623,16 +2623,6 @@ static int __mmap_new_file_vma(struct mmap_state *=
map,
>                 return error;
>         }
>
> -       /* Drivers cannot alter the address of the VMA. */
> -       WARN_ON_ONCE(map->addr !=3D vma->vm_start);
> -       /*
> -        * Drivers should not permit writability when previously it was
> -        * disallowed.
> -        */
> -       VM_WARN_ON_ONCE(!vma_flags_same_pair(&map->vma_flags, &vma->flags=
) &&
> -                       !vma_flags_test(&map->vma_flags, VMA_MAYWRITE_BIT=
) &&
> -                       vma_test(vma, VMA_MAYWRITE_BIT));
> -
>         map->vma_flags =3D vma->flags;
>
>         return 0;
> @@ -2710,11 +2700,6 @@ static int __mmap_new_vma(struct mmap_state *map, =
struct vm_area_struct **vmap,
>                 vma->flags =3D map->vma_flags;
>         }
>
> -#ifdef CONFIG_SPARC64
> -       /* TODO: Fix SPARC ADI! */
> -       WARN_ON_ONCE(!arch_validate_flags(map->vm_flags));
> -#endif
> -
>         /* Lock the VMA since it is modified after insertion into VMA tre=
e */
>         vma_start_write(vma);
>         vma_iter_store_new(vmi, vma);
> @@ -2777,6 +2762,80 @@ static void __mmap_complete(struct mmap_state *map=
, struct vm_area_struct *vma)
>         vma_set_page_prot(vma);
>  }
>
> +/* Check to ensure that the VMA flags of a newly mapped VMA are sane. */
> +static int mmap_validate_vma_flags(const vma_flags_t *flags)
> +{
> +#ifdef CONFIG_SPARC64
> +       const vm_flags_t legacy_flags =3D vma_flags_to_legacy(*flags);
> +
> +       /* TODO: Fix SPARC ADI! */
> +       if (WARN_ON_ONCE(!arch_validate_flags(legacy_flags)))
> +               return -EINVAL;
> +#endif
> +
> +       return 0;
> +}
> +
> +/* Check to ensure a driver hasn't done something crazy. */
> +static int mmap_validate(unsigned long prev_start, unsigned long prev_en=
d,
> +                        unsigned long curr_start, unsigned long curr_end=
,
> +                        const vma_flags_t *prev_flags,
> +                        const vma_flags_t *curr_flags)
> +{
> +       bool was_maywrite, is_maywrite;
> +
> +       /* Drivers cannot alter the range of the VMA. */
> +       if (WARN_ON_ONCE(prev_start !=3D curr_start || prev_end !=3D curr=
_end))
> +               return -EINVAL;
> +
> +       was_maywrite =3D vma_flags_test(prev_flags, VMA_MAYWRITE_BIT);
> +       is_maywrite =3D vma_flags_test(curr_flags, VMA_MAYWRITE_BIT);
> +
> +       /* A driver may not make a previously unwritable mapping writable=
. */
> +       if (WARN_ON_ONCE(!was_maywrite && is_maywrite))
> +               return -EINVAL;
> +
> +       return mmap_validate_vma_flags(curr_flags);
> +}
> +
> +/**
> + * mmap_prepare_validate() - Ensure the driver hasn't violated invariant=
s in its
> + * f_op->mmap_prepare hook.
> + * @prev_desc: The VMA descriptor prior to the mmap_prepare hook being c=
alled.
> + * @desc: The VMA descriptor after the mmap_prepare hook has been called=
.
> + *
> + * Returns: 0 on success, otherwise an error.
> + */
> +int mmap_prepare_validate(const struct vm_area_desc *prev_desc,
> +                         const struct vm_area_desc *desc)
> +{
> +       return mmap_validate(prev_desc->start, prev_desc->end,
> +                            desc->start, desc->end,
> +                            &prev_desc->vma_flags, &desc->vma_flags);
> +}
> +
> +/**
> + * mmap_hook_validate() - Ensure the driver hasn't violated invariants i=
n
> + * its f_op->mmap hook.
> + * @prev_start: The start of the mapping prior to the mmap hook.
> + * @prev_end: The end of the mapping prior to the mmap hook.
> + * @prev_flags: The VMA flags set for the VMA prior to the mmap hook.
> + * @vma: The VMA after the hook has been applied.
> + *
> + * Returns: 0 on success, otherwise an error.
> + */
> +int mmap_hook_validate(unsigned long prev_start, unsigned long prev_end,
> +                      const vma_flags_t *prev_flags,
> +                      const struct vm_area_struct *vma)
> +{
> +       const unsigned long start =3D vma->vm_start;
> +       const unsigned long end =3D vma->vm_end;
> +       const vma_flags_t *flags =3D &vma->flags;
> +
> +       return mmap_validate(prev_start, prev_end, start, end, prev_flags=
,
> +                            flags);
> +}
> +
>  static int call_action_prepare(struct mmap_state *map,
>                                struct vm_area_desc *desc)
>  {
> @@ -2803,6 +2862,7 @@ static int call_action_prepare(struct mmap_state *m=
ap,
>  static int call_mmap_prepare(struct mmap_state *map,
>                 struct vm_area_desc *desc)
>  {
> +       const struct vm_area_desc prev_desc =3D *desc;
>         int err;
>
>         /* Invoke the hook. */
> @@ -2822,6 +2882,11 @@ static int call_mmap_prepare(struct mmap_state *ma=
p,
>         if (err)
>                 return err;
>
> +       /* Check the caller did nothing crazy. */
> +       err =3D mmap_prepare_validate(&prev_desc, desc);
> +       if (err)
> +               return err;
> +
>         /* Update fields permitted to be changed. */
>         map->pgoff =3D desc->pgoff;
>         map->vma_flags =3D desc->vma_flags;
> @@ -3457,10 +3522,15 @@ int __vm_munmap(unsigned long start, size_t len, =
bool unlock)
>  int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
>  {
>         unsigned long charged =3D vma_pages(vma);
> +       int err;
>
>         if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
>                 return -ENOMEM;
>
> +       err =3D mmap_validate_vma_flags(&vma->flags);
> +       if (err)
> +               return err;
> +
>         if (vma_test(vma, VMA_ACCOUNT_BIT) &&
>              security_vm_enough_memory_mm(mm, charged))
>                 return -ENOMEM;
> diff --git a/mm/vma.h b/mm/vma.h
> index f15faa83f3d6..b2c3bc832a48 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -782,14 +782,19 @@ struct vm_area_struct *vm_area_alloc(struct mm_stru=
ct *mm);
>  struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig);
>  void vm_area_free(struct vm_area_struct *vma);
>
> -/* vma_exec.c */
>  #ifdef CONFIG_MMU
> +int mmap_prepare_validate(const struct vm_area_desc *prev_desc,
> +                         const struct vm_area_desc *desc);
> +
> +int mmap_hook_validate(unsigned long prev_start, unsigned long prev_end,
> +                      const vma_flags_t *prev_flags,
> +                      const struct vm_area_struct *vma);
> +
> +/* vma_exec.c */
>  int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **=
vmap,
>                           unsigned long *top_mem_p);
>  int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
> -#endif
>
> -#ifdef CONFIG_MMU
>  /*
>   * Denies creating a writable executable mapping or gaining executable p=
ermissions.
>   *
> @@ -838,6 +843,20 @@ static inline bool map_deny_write_exec(const vma_fla=
gs_t *old,
>
>         return false;
>  }
> +#else
> +static inline int mmap_prepare_validate(const struct vm_area_desc *prev_=
desc,
> +                                       const struct vm_area_desc *desc)
> +{
> +       return 0;
> +}
> +
> +static inline int mmap_hook_validate(unsigned long prev_start,
> +                                    unsigned long prev_end,
> +                                    const vma_flags_t *prev_flags,
> +                                    const struct vm_area_struct *vma)
> +{
> +       return 0;
> +}
>  #endif
>
>  struct vm_area_struct *__install_special_mapping(struct mm_struct *mm,
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 2fd422789717..2986ae6ca1e5 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1359,13 +1359,23 @@ static inline int vfs_mmap_prepare(struct file *f=
ile, struct vm_area_desc *desc)
>         return file->f_op->mmap_prepare(desc);
>  }
>
> +int mmap_prepare_validate(const struct vm_area_desc *prev_desc,
> +                         const struct vm_area_desc *desc);
> +
>  static inline int __compat_vma_mmap(struct vm_area_desc *desc,
>                 struct vm_area_struct *vma)
>  {
> +       struct vm_area_desc prev_desc;
>         int err;
>
> +       /* Derive state prior to mmap_prepare hook. */
> +       compat_set_desc_from_vma(&prev_desc, desc->file, vma);
>         /* Perform any preparatory tasks for mmap action. */
>         err =3D mmap_action_prepare(desc);
> +       if (err)
> +               return err;
> +       /* Check the caller did nothing crazy. */
> +       err =3D mmap_prepare_validate(&prev_desc, desc);
>         if (err)
>                 return err;
>         /* Update the VMA from the descriptor. */
>
> --
> 2.55.0
>
