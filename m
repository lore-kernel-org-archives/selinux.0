Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891773B0AD7
	for <selinux@vger.kernel.org>; Tue,  8 Sep 2026 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898982; cv=pass; b=T3ebAM2vDEJ/cRh+lQQvPi08cvDOYP5docGhP0Syoz6G2I+j4rEox8DMIzf7zOazSHKDrsoN+750NWbyM2w+t/BjEity0JUTMUQtJnxyDaIKgh32RsZ5HhrEKt21uCHxtHRvlyeUi97+uN+LJUDQrhftkcSx1xZL8m/2MvOkZOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898982; c=relaxed/simple;
	bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hk4Ac8fpdIZCSreIvL5a0Q99rrD72qqc8goo2wmJ5u79a5l6a9RP4UgvZxfWwtser7TFGNDRDy5/iohmHBAkOXWMWO30uhwJE8LN+w6GSLo1WLAquxhZMWuheq/TD3VEaqitHL9mDNEtbthQJyBD8PeRkwHRWlvAziArvot+9u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IcPkLzE/; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcPkLzE/"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so1945ad.1
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2026 13:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788898979; cv=none;
        d=google.com; s=arc-20260327;
        b=sA7LvhzWk1B5iH6BWU8f835+rNT0p3C/4anWAS+HgMOQeT1ANDqBM62o8dTh/oj6z9
         qPzL7zECrC7NZiJTTMnK89K4dFNRmZ9ZBkidu3dARpy7/H/sj+VLNeiFb71qQaw+Js55
         eiOl67FhMLjYTM24AeMiNyE9v++ueupANe2QekULa1Pb3JcWJuYvyhi/Uk7KMeNIg41Q
         qoEDuVBp/plmDrtGRJ8iCeAqJ/1aOAZD6k3VMeP0hCSbforuKXZMw3hL24qn5mSlGO5V
         wbjSTgaoRfz5yoeyi2l9j0wt0lLa6A77l8p2s5GTgiry5cqVSrGpKlV+nElJX7ZExVDu
         wlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        fh=hExmWD3bAmNB+Q0X2N/wG3gVHGG9IJFrDlJ1WUBXc+A=;
        b=mQANMHhLZUaWjFbUa+myTObWBISwPMXAzUu0jD4JHbDhfBLyQwJQWQnu8JlP6T2Qmn
         RHWx4fxuG8H0gNPPYCngaSzOeVmb8C7VK/XH0jLybk9NhHvSkXsH20JAqnqOA3WMIlml
         2Uq/UBrJmq2C0fmvCsJM0nj+XIIr7VSrKIqbf+PIzCfuklYrTBjLN+mQgRBPh38xP0w/
         Lun8h/RXQEiHEiMj5yaSgqXWX+MGqRzq1IsMp9NFSrGAOxsRQdv076uTkrPyFhvjX9Vx
         VYD2t+KqOcucaY9wJK9syHg9nio/mh7jZysQ6SYiRZZ3jFwRsXZ78i+Zs2kVz/wf6kpU
         FRhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788898979; x=1789503779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        b=IcPkLzE/GWJgGQFgFjq3/BPu5Aholp3UD6OdBhJ355j7ahhQeEmYsZPEkfMh2aEMl5
         kHUyWUF+7Gsx3qUraZvXNlJnLnJQiF0g9Ms56lLpww/Qy1lXVKnPHtG77r2emwHYzjgR
         29ats7zhEVuqr/LN+0lRI5mQ7VWdrJWjQgAlCiR2iAQR35K53EjDk/rXhFfh40uzR4Jy
         RRI+QZWDqRc4KQgY+OCWmcvnTOnP8NhhpvoTwWYJ2q5xpq67mWPEnUw4qNJN1Bm0SzLi
         Qv7BYZ4pLiZwDkSBChbQ8ajWrWqXo9sO0KR94zXOkfUC2TZVByd27wmQIX6YkWcdIFtv
         GfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788898979; x=1789503779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        b=QHGjWsxM/pU/KtXF3HC0TKlNJaxkBV6fC1HFLhpzPiirCB+6I+oydEqNqS/MiIXw6+
         zgwo4fTRUX51RD4neyfFWc/atCbmDO+8l734LJRBDTpgA804JMOyQXXhqZWc9AHccuec
         9uKh+CoWHiyMFHJsO/y08LKa+MSv8vHweV+AL1pjZkPalFkKj2hlvK9n7Dj098RdOXf1
         rfLbzWrt+F79Pm3Vl0nlOg1c1VXvKZ7Hmw0sA9J33z78mAt2BLZFY/bef+v9jpnp0hZs
         rtCH95I9mK7Y7EwqaoAoIYbsxA4QeWgxPHDNRApt+HvhaOfulrDFxQdwykTP0DcFcjkB
         oMrQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9oR5zK4HvdRsQMydX/pf/uSrIIRzKtVSFmARL/h+SNwqBK5Bc7ntmfbwsgWW+5fJEO5l6LWDd@vger.kernel.org
X-Gm-Message-State: AFuF++m3j4XfO/4A2PFNmbE/BSLi2NODandaZjz0de2VR9SFacJwWBDU
	Jg6Uzeg7ZaPdk490jQqINv/MN7C5cv77e8eM1LbMrDelT6S+6C6IoNNa64H5Rf570zd5XxsBJTl
	huW7/ORSVprbt3Y5zBLj66VNCuE4iSXVevoKq6j2E
X-Gm-Gg: AYBFou1MaVWihZPibWLdQ1yhr/KB/BHwSH4GaOwZ08/CmpCVQ39SpiFFKh9VAHUaFNV
	ySswgtEWinF7LJrDhSiMkl3CimkHqpd0FvAttwbqG0PSICmmMWPbCHdp5uhwIbQ/zIl5hh69Nx3
	VcVZXZyDKB8lotPbstDg1nuSh1S75Cr2RuUibcUEdTSGJ9j1MqiTjjrMOurM+a7YU9woNYt5Uuk
	9d565b//VRK5rXp2limWRYYEBciI3zOAmi0zu9Vk7niDmFI6OnPaZgYHaDRNwdMBImiWA0Sdx7D
	qWybiT1Q4j3glQcN2W/GejiyZDEcppZ/C/WlJj82TeImxVNgOdUTzySLVbaRPGJ91rYSrMsQiI8
	11T1TSMNj/Rms8CkZj7KShGr7fO8C/7tx
X-Received: by 2002:a17:903:fa4:b0:2d1:1d3d:97c3 with SMTP id
 d9443c01a7336-2dbfeccdf9bmr1436185ad.13.1788898978067; Tue, 08 Sep 2026
 13:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 8 Sep 2026 22:22:20 +0200
X-Gm-Features: AcwNN1W16jAho4HwK_fzY15wUA-qa4DGJ92-DrEx1Ojg_VFhiHj2JxDdZTxOKSI
Message-ID: <CAG48ez3Ucb8HyhjC1-fijFiYJsnWcTLYHvJjzMyU710mgegxnA@mail.gmail.com>
Subject: Re: [PATCH 11/39] selinux: reject writable opens of policy file, drop
 mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
	linux-sound@vger.kernel.org, bpf@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> The policy file has no write method and is exposed read-only (S_IRUGO in
> selinux_files[]), yet sel_open_policy() performs no open mode check, so a
> CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at open, a=
s
> kernfs does.
>
> The file can then never be mapped with FMODE_WRITE, so do_mmap() always
> clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_SHARE=
D
> check in sel_mmap_policy() cannot be reached. Remove it.

You should also be able to remove the sel_mmap_policy_ops.page_mkwrite
handler, which is only for shared-writable faults, right?

> This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that =
is
> neither a PFN map nor a mixed map, ahead of the core enforcing that only
> such mappings may do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
