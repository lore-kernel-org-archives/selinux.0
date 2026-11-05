Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914899;
	b=bqwjbgY1HkwrNCzEhQnUrFPeZT/IWyCILQIdUqZCeQtkuslFUyZNCyFqunr5XzTnAtsr
	 XqMspzrzh5lFY1UbYEBiU90nd5uzpXmEri9ix6fx/pfrWOOlbZNaWsYXE5rVG8TxsDmtB
	 S+C+jyyaMCElWl3nNIZNLMMO5nL9Q0R1SduyP7feIZrWyw8frOjEZv5rZgNite8Wd8XuH
	 P6c3RXGs3Sdc3UEOV1iqXetN0TLDwzO//sd9RlLiqps6agXe0tg9Yz89//Z8ERK8KnSvZ
	 NmpQ3zk0sa4BqoiKtEyhWT0wlTEepa2J8PBi5Cu8VXsLaHihOS2RBg7dgQHZy5gMS7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914899;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OC6xPJuoLtag/UNVUOAoSaQZwd0BWlf5yd9F9l2dg+8=;
	b=yjM/FLVkfEbOaJB/kS01H1hKB049rjjpKUaVFW/A84Nlzryu0vtRgHDw3MjHNINlZNpy
	 9a2B7FjZyd1wnR8D/3GRu/ixCoF5yqd3IRPLUuXjFdzmVup1mj5FPhkjWpF3ZkELHggvv
	 ofxraMHlM0X8h/tCrARdgkJVNAGjzWE6geHIAb9eN9LUhIzu+s+lYZQKbtGWFsOM0JzBV
	 smAekyJ2mDL1sra2X/w+EvZXA7lT+aKiZVpcDpoWn3WEVmi/HHRhhanMPS2KnNt+wkHPc
	 bUhK++smEWeaOWBFMjtOLsh9pLnRR+VQY2ypg19g8V43LAwozSgn23DPSM1pWEboYpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftjSanR5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A05606A329;
	Thu,  5 Nov 2026 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftjSanR5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05BF1F0089F;
	Thu,  5 Nov 2026 21:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914898;
	bh=OC6xPJuoLtag/UNVUOAoSaQZwd0BWlf5yd9F9l2dg+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ftjSanR5NYRVoTeBKZ9GKKb5Ejk1Wo1LW5KsXglEAcnlyjjvxN2a+oB7TS+tqIO48
	 mLWMUruChKgreDIeGVIBYX7RKGlsxtvnxnVOabXGjobAB/fVlZBcpRSb4QcmM+aPey
	 H1GN8tWl7V0jJslBLXgjRHT2fPyQBR4w0/b8W6NY2gw07MVWVDA9NQN/Y11ulVuQIA
	 85VS68u9z1a4tjmBgnUKmKpo/fWULan3ie+4z30hlSVqrPQol/nhiJzLckViEBmmge
	 zkrugiLnzvT9AifyLkUuMzOvKx+kKGulAQEqHn+yOT6n1ONFUVd0hOc+ZZVtqSd1Kf
	 1pcTL4VXazLdw==
Message-ID: <sashiko-outbox-200257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] mm/filemap: convert fault and readahead logic to
 use vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "John Hubbard" <jhubbard@nvidia.com>, "Peter Xu" <peterx@redhat.com>,
 =?utf-8?b?TWF0dGhldyBXaWxjb3ggKE9yYWNsZSk=?= <willy@infradead.org>, "Jan
 Kara" <jack@suse.cz>, "Rik van Riel" <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Harry Yoo" <harry@kernel.org>, "Jann Horn" <jannh@google.com>, "Lance
 Yang" <lance.yang@linux.dev>, "Zi Yan" <ziy@nvidia.com>, "Matthew Brost" <matthew.brost@intel.com>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "Byungchul Park" <byungchul@sk.com>, "Gregory
 Price" <gourry@gourry.net>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Nico
 Pache" <nico.pache@linux.dev>, "Ryan Roberts" <ryan.roberts@arm.com>, "Dev
 Jain" <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Xu Xin" <xu.xin@linux.dev>, "Chengming Zhou" <chengming.zhou@linux.dev>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Nicholas Piggin" <npiggin@gmail.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, =?utf-8?b?Q2hyaXN0b3BoZSBMZXJveSAoQ1Mg?=
 =?utf-8?b?R1JPVVAp?= <chleroy@kernel.org>, =?utf-8?b?Uml0ZXNoIEhhcmph?=
 =?utf-8?b?bmkgKElCTSk=?= <ritesh.list@gmail.com>, "Shrikanth Hegde" <sshegde@linux.ibm.com>, "Pedro
 Falcato" <pfalcato@suse.de>, "Kairui Song" <kasong@tencent.com>, "Qi Zheng" <qi.zheng@linux.dev>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Axel Rasmussen" <axelrasmussen@google.com>, "Yuanchu
 Xie" <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Leon Romanovsky" <leon@kernel.org>, "SJ Park" <sj@kernel.org>, "Rakie
 Kim" <rakie.kim@sk.com>, "David Rientjes" <rientjes@google.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, "Namhyung Kim" <namhyung@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Alexander Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri
 Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Oleg
 Nesterov" <oleg@redhat.com>, "John Johansen" <john.johansen@canonical.com>, "Georgia
 Garcia" <georgia.garcia@canonical.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>, "Dmitry
 Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric Snowberg" <eric.snowberg@oracle.com>, "Fan
 Wu" <wufan@kernel.org>, "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 =?utf-8?b?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: linux-mm@kvack.org, kvm@vger.kernel.org, damon@lists.linux.dev, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-2-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-2-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:41:34 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm/filemap: use-after-free on vma in do_sync_mmap_readahead()
- [Low] mm/filemap: inner vma declaration shadows outer vma in do_sync_mmap=
_readahead()
--

commit f5f0f8e634a6a2e2b76ad818de67e83f30cb7dea
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm/filemap: convert fault and readahead logic to use vma_flags_t

This commit replaces direct checks of vm_flags_t values with vma_flags_t
helpers in the filemap fault and mmap readahead paths.

> diff --git a/mm/filemap.c b/mm/filemap.c
> index b74bc1e5015c6..d8b538bd14043 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3351,13 +3351,14 @@ static struct file *do_sync_mmap_readahead(struct=
 vm_fault *vmf)
>  	struct address_space *mapping =3D file->f_mapping;
>  	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
>  	struct file *fpin =3D NULL;
> -	vm_flags_t vm_flags =3D vmf->vma->vm_flags;
> +	struct vm_area_struct *vma =3D vmf->vma;
>  	bool force_thp_readahead =3D false;
>  	unsigned int thp_order =3D 0;
>  	unsigned short mmap_miss;

[ ... ]

> @@ -3414,7 +3416,7 @@ static struct file *do_sync_mmap_readahead(struct v=
m_fault *vmf)
>  		 * Fetch two folios so we get the chance to actually
>  		 * readahead, unless we've been told not to.
>  		 */
> -		if (!(vm_flags & VM_RAND_READ))
> +		if (!vma_test(vma, VMA_RAND_READ_BIT))
>  			ra->size *=3D 2;
>  		ra->async_size =3D folio_nr_pages;
>  		ra->order =3D thp_order;

[Severity: High]
Can this trigger a use-after-free on vma?

Previously, do_sync_mmap_readahead() cached vmf->vma->vm_flags by value in a
local variable at entry while the fault lock was held, as introduced by
commit dcfa24ba6899 ("filemap: Cache the value of vm_flags").

In the force_thp_readahead block, maybe_unlock_mmap_for_io() is called befo=
re
this check:

	if (force_thp_readahead) {
		unsigned long folio_nr_pages =3D 1UL << thp_order;

		fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
		ractl._index &=3D ~(folio_nr_pages - 1);
		ra->size =3D folio_nr_pages;
		/*
		 * Fetch two folios so we get the chance to actually
		 * readahead, unless we've been told not to.
		 */
		if (!vma_test(vma, VMA_RAND_READ_BIT))
			ra->size *=3D 2;

Since maybe_unlock_mmap_for_io() only pins vmf->vma->vm_file and calls
release_fault_lock(vmf) to drop mmap_lock or the per-VMA lock, isn't vma
unprotected against concurrent modification or freeing when vma_test(vma,
VMA_RAND_READ_BIT) dereferences vma->flags?

> @@ -3422,7 +3424,7 @@ static struct file *do_sync_mmap_readahead(struct v=
m_fault *vmf)
>  		return fpin;
>  	}
> =20
> -	if (vm_flags & VM_EXEC) {
> +	if (vma_test(vma, VMA_EXEC_BIT)) {
>  		/*
>  		 * Allow arch to request a preferred minimum folio order for
>  		 * executable memory. This can often be beneficial to

[Severity: Low]
Does the newly added outer vma declaration in do_sync_mmap_readahead() cause
the existing inner declaration in this VMA_EXEC_BIT block to shadow it?

	if (vma_test(vma, VMA_EXEC_BIT)) {
		...
		struct vm_area_struct *vma =3D vmf->vma;
		const unsigned long start =3D vma_start_pgoff(vma);
		const unsigned long end =3D vma_end_pgoff(vma);

Should the inner vma variable be removed now that vma is declared at functi=
on
scope?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D2
