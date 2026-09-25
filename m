Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC2416851
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321866; cv=pass; b=K0Gxo+rrtKVxkcDSwJQdsoasXxjRNNhLgKbaMvBCruDDm/REyniUA8nkcvnlDG4gqqfocYW1GrwpThO97xIiGjiipGjfN4VCpYJMD4JockJL1C7PtSL/gzwsSEcWJBPCS1LeytnF7paQJ4rIsMFG2ekxXmeH+tnwdhncT9wIeJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321866; c=relaxed/simple;
	bh=4HRCApcqOCblV/nRa/gIhH9hhLpyjFWAyS7KPdKAl2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCi3A4rtLUNWFhASk0mqCovRyLOouVzxlu6Qfkl7xA2vs5bBYylQfMjb8klKFpR8EFe7mumKw5vw53CiV3FoG0wxksQ5GZRpxAuJy6PsXBKD6j22pETaeQ14pVjmM2fbjpSdaripnyrL7czdo+TwM9AsKZiBXVeMOVoz2h1NV3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQ9vFxFo; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQ9vFxFo"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a5f9b036f9so5551a12.1
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 00:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790321862; cv=none;
        d=google.com; s=arc-20260327;
        b=QYM9+GoZyV20c1/AZ+bg4wM+/nPt1SnEih4NeCsNFKhQT5KgEGh9N5l8ONWJJYBwOL
         By2k/QP/a0mccicyQO6Yul7zEz+Vxh6H/OkmwLFai3cS6fQAYz7MjHOzIEWlPugKzimx
         dEmBuvGBmCn5JibqFeMCpioAImVezQWnZaxNDImWpqOnkfyZXkVVFBCcgC/LpTsQVBzE
         AKog2RWewp7RYTOfpYrTAGTM1tzHC1cD+u6/87/zhWI3UgQKhdqbDInhVDiBmY6LQzNg
         IfolTEVMkJq1tvtnvelhodWFnyWZo30n7RVJsiLBlk0cKXJ60GIIuYi3EEyYzcQsr9tm
         vBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
        fh=ObpKHx24NXv+iFJSgpPEsk20gjRmfchRmj35/ncbSGc=;
        b=MLo717H18J8sW1dTBfvCWN18x6/mbUraWQNKSHbjKr7djr1iOWQ2t1vSZnunSFFyg2
         OQ/BOtWMA4Firlw+C5fVhNUr77iU6xJAwoKuRSzFBb2ppq/2bhKEJXlHvBuAg9UGCrBJ
         S65HzCS9xadhnbpSf1DjOVQcmdd/jVhbt0XjiDCTuAQpVa8k5ezD9510F1K1lB00/YQ7
         a9488hlIPCZJY9f/dCMd0ksw9pG3LvW2NBY+xpsrPTNZx7/JnEQ2DY6lOtgx8T9UvFoy
         KKTtEzS0Vc5StVoiYpj7AWCRZWw75XFthaBuOWvu33Uvktg7hlgSQwhJeEQexJt/0qfu
         zNDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790321862; x=1790926662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
        b=mQ9vFxFoabYALJuAnnXHoi1jXZaav9RmInZt43IwRm/fzvwjOopZ3o7VIc+dy42EPi
         9HROBxO8UV5pJ3vyakmz2OrfmdMJ5l3k2QVu7h7aN2S0ymf58OD7LXQehwoCCooGWSlJ
         MvGdJLno+5jm9IW1BGyaIVzD6rp/VRh1mI6TzCU97v5KFsxHRp89wyD14t2ZDP1tEBeD
         A91+ZQG6N6rJ0BcW3pG13YSmw/G2ukmHBfEkN3uE08LggWf2y9iU8nW5r7knfUMWHZRm
         YPH0c7LQUfotrpUgKUi9Amtde8tnp230k0vXLvU1SeSceyFG1gck3ElBqcrZJ09QAjWJ
         kRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321862; x=1790926662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
        b=A9Kn56r1fpZ9V4tDRDLDkhtCp71743bMTmuo+tfupSvgb+84VcrSiBXEcY0IDySYJl
         wgvnx5mZ0PHLrPCtCstt09R16BIycuCWavLgZTYAY1dPHsm6rtEGMm+Ee0l5Ldomfppc
         9VOQfKuDJmJOTiUdmn79FHYE4ToDtkP8E/zA5+7iKKzZDQ4reTexn89ugq06iTVlWanV
         4zINbSrOPwNsssYC77EN+7JUpTxSwmSDbCAU7ySECYwr+++tiQnj24HmOwMRoMnJBiKa
         Qgo2RndE4MxIwJS4dscxpwObi+oGD/WYhh5AFF5TLRDVuHRII54UYiRzKW6d/D2m+5Z6
         ihvQ==
X-Forwarded-Encrypted: i=1; AKwUvByYkKIvnwiV9NsBPNpF+Mp70nm6gPwSmKC9mzWOMiWQsQD8wihAlOpSg8L8xXZX39AsF2AFVGmF@vger.kernel.org
X-Gm-Message-State: AFuF++nf19Iq7cHQzQnIabbKt+uNRbANy7gCeA3JHo18K+YedJ+N4mWM
	xtrCpA2RoQx5C6eEUuIdDSJkUzfxNYBG4CQVtvRDhzzl6FuAnu82oIEOtMmshoW8QLqw7LKWubT
	2ea04ya/vxskBCRjC81ovbeAAOileHF27lILgHSYe
X-Gm-Gg: AYBFou2+2FKlhFagS6EiTO4xzam3vfWJfIOWQDnNByynFzD6uvngU9wZPQh8sfqH2YM
	4B+QW5bm6660A92uYtjZ6rfBwKVAMpkyBos10VqICBUfAwnj2fGaq14saar3B8EJ1chVbb/RBts
	4YG12zibhpf14HoeGb33An67CxIuFoX9eLIWfT/0a3TB5xaUUAv+fL48nkRYWIpHNoSX9Iz0zH1
	tGJ8CmO9GebcxBKAx67l/zS8VlJ7icyQQ8mDeSkHfVHqVxbJgMWNnD9PlQDPntMO0s8Md8+iD6Y
	a05sQYihgtkGv2eU4EHJIsgk7hU8AqHcLvDYSDe9VpGZxCKVOaCNHg==
X-Received: by 2002:a05:6402:2714:b0:6a6:f2a5:1b4f with SMTP id
 4fb4d7f45d1cf-6aae4729638mr36915a12.4.1790321859803; Fri, 25 Sep 2026
 00:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org> <DLNSOBMBHIVC.22QI9YBL1U72E@nvidia.com>
In-Reply-To: <DLNSOBMBHIVC.22QI9YBL1U72E@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 25 Sep 2026 00:37:26 -0700
X-Gm-Features: AclHuK_RUT9CXNFLpx8ZY_roLEZNzp5S3oNdpNL4cW25fJBFg9wRGnSWohuMdYA
Message-ID: <CAJuCfpH6AF-hOo4jU6OeNVpd+fgpqLpmcfAGs11J=nPCgAqG_w@mail.gmail.com>
Subject: Re: [PATCH v3 07/40] mm/vma: tidy up map kernel pages enum values
To: Zi Yan <ziy@nvidia.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Doug Gilbert <dgilbert@interlog.com>, 
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

On Thu, Sep 24, 2026 at 12:31=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On Thu Sep 17, 2026 at 12:22 PM EDT, Lorenzo Stoakes (ARM) wrote:
> > MMAP_MAP_KERNEL_PAGES is a mouthful, discard the MAP_ as that's implied=
 by
> > MMAP.
> >
> > Also while we're here delete useless comments for mmap actions whose na=
mes
> > clearly indicate what they are for.
> >
> > Also update the userland VMA tests to reflect this change.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h              | 2 +-
> >  include/linux/mm_types.h        | 8 ++++----
> >  mm/util.c                       | 8 ++++----
> >  tools/testing/vma/include/dup.h | 8 ++++----
> >  4 files changed, 13 insertions(+), 13 deletions(-)
> >
> LGTM.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Best Regards,
> Yan, Zi
>
