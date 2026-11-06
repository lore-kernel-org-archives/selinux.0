Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926871;
	b=kvnB/h6MW68vsadN1BzQ6jVMna73utNOkCfAZ0fI4QsCCLVgix1ZE2uGz/HIl/0eRLX6
	 HlHjsfCS8n+Jy9Q++Rb9kvhwa7NJk3MQbmwtn2XLmw5I9OL6C2NCUPWfrxR2KoCV4Fo4A
	 MwMc0ZjqVeNCMC6ikDa2NimdpYUtkVIDLPXPqowuHFs6YLPHm8Zb/Kx7bTLaLGufQT6tx
	 ZEDXrF4FIQP0HI17rd8LjjLBsi5B/JwVZEEoaXraUzit4MAwR/wtT1GKtKbhyCr5CsBxM
	 tqlPzowwZgTXXuCUYjeFDXu6A5PnDGiDZp94hgX3LEi8Cz6HNREf9ApELwQpLjuQH/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926871;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Fy6mIR6EGyX3GNnS9djVNVrLOtUG60iOXxWGxnZZW30=;
	b=BpadSkoFAjPbiAncENEbZM9ZhHsLc5Aa2tpRTLqNt98ya1Ng6w8lyDI8QRF58rM70p/D
	 uoPRlFu8t2F48CeUQPDXBqwLOIC88iBpcG72wab9A4TLjeqVdGeM5TvGQRGNzaVgzBWIz
	 JFMBkKkQLlvYL4sNOe0Ke5RGIG7o3+d74TMdlIbjNHpHjasdoU1G5tRbV7JrbkMNBhchP
	 qH3mI558055IklDMfO61vbv8CQdP9WQ6K5D88fH2hPBKMgouNrA/nSuBTPy32MEL9A9sj
	 4NuHk86/wWEi/gZPSkMOpLkl9wveaCLMZYRf1qRmRN+/3BirA9wTK02GRm5iZF/jZ7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMed2u12;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334D606A31B;
	Fri,  6 Nov 2026 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMed2u12
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8841F0089F;
	Fri,  6 Nov 2026 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926871;
	bh=Fy6mIR6EGyX3GNnS9djVNVrLOtUG60iOXxWGxnZZW30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aMed2u127+wL/B/NdfIXyeoxB6u5xmOokzrftZzRxfrzI6qQeKPWKSpVsgX0qJ51K
	 hx2TLIa43xHxqsfLVPrxRVay6PdfrX7mVbGwOXR+GprD2T0ugi0eemDwVQYtftIEAO
	 AqnH5rLl+mfNwIoidLDPL9fz9NteNzXOPqZFmF/+nB0H5OL81nSlzxUQlOqsF6xT+0
	 5QY5GeM2meFlG1UUnXQC/vfBg4rzbC7YhVChXxU6K5rZJtXN1G4Idsj+btrhdV4YuU
	 XQ1ILjd6bCfk2EaJ5OXQ4ZcSqefqhddDJ2l/ZedoICv4cZPOsUrxDdXC7gYP8ju6iJ
	 4EZOWwEnjp8wA==
From: SJ Park <sj@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Leon Romanovsky <leon@kernel.org>,
	Rakie Kim <rakie.kim@sk.com>,
	David Rientjes <rientjes@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Fan Wu <wufan@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	=?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH 08/13] mm: convert miscellaneous VMA flag tests to use vma_flags_t
Date: Thu,  5 Nov 2026 17:01:00 -0800
Message-ID: <20261106010101.95918-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
References: 
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 05 Nov 2026 21:30:59 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> remaining straightforward VMA flag tests scattered throughout core mm, HMM
> (and its test module), DAMON and the OOM reaper.
> 
> No functional change intended.

Thank you for this nice cleanup!

> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[...]
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -240,7 +240,7 @@ static void damon_va_walk_page_range(struct mm_struct *mm, unsigned long start,
>  		goto lock_mmap;
>  	}
>  
> -	if (!(vma->vm_flags & VM_PFNMAP)) {
> +	if (!vma_test(vma, VMA_PFNMAP_BIT)) {
>  		ops->walk_lock = PGWALK_VMA_RDLOCK_VERIFY;
>  		walk_page_range_vma(vma, start, end, ops, private);
>  	}

For DAMON part,

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
