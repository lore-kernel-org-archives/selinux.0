Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937680;
	b=gjCHvnsns86SrrZyIY/COtepzViPmdaJ6vEE5Kv6YENnvnROxiEUM8SiTSCil27X48xp
	 IuV47J9MZ1hvyA2X68PSFtTYj1tftTl+7nzpbxH6voIIG316FA6PeZpPCAenat1lYHofy
	 WGtIrOmBMfdGx+/IsYxx36yiatJEKd06EfXd455dVOkIikX3aoWpR8DHeXJBG3byUe51A
	 GLskX8TgvLH9WaNl3ucLzwoovsO8e5VGGhUZIjx2gcAOTJVRXF1UsKsOVwQFS017o+/Gb
	 OtwOYG0auKbQF2UaW9RPANjgs5PSwyLSGYSO1m3LQ1KvhJ9KFBb/a266ltFBAQUG1cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937680;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EKI7PGZaHzRnKhw9+Gxl7Ck/B2CGZVJrrWzNjxtIAHE=;
	b=lywaxAl1TO+9KVbPv460FZuMB8BzW0RG6/Cj/Z2PlnO5ftjUdEjCTjfnGIYrLFz008aB
	 SwsR5dH+Yw3mmZrg0jUUwBBLjdiRWVTDJ9xfrUcQLqYCyqV5HomfuSToSmmOyX1YVsTsK
	 cIt2xGiIUwfKNEzzrw1gW26k//vMzRD3gMYVj17mdKHiwezHCqrN/7oC4Ew1Y4/F8uhg4
	 a9xNv1uHjpKHFv1VwSlEWAlBE4YkBW+8C1z2Qpd2q5belChEB93Vb+EK1tCwvP5ueJKym
	 nXiBvBBGZcVaFv3MHF8KGwQjc06aebn2TF/nG7bSMkycDmOXOZWh4khRk2ccUXr1nrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNdgrU5z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91223606A328
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 04:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNdgrU5z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1051F00921
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 04:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793937679;
	bh=EKI7PGZaHzRnKhw9+Gxl7Ck/B2CGZVJrrWzNjxtIAHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LNdgrU5zM2nugBvZVCR02iYgDIFmlQHM3kqBcyp/SVdk7mtCDyZg91KEZW9QGqiq4
	 pTrdL/v5+Sridp9dwQOz13aeDVsJ3H2YdUTQ2WgTqzAN3jOXnwlTOnh17e7nKmSJJS
	 cBGQ2Hysr/0o2u+C0HNxL4jSArWNZCkAWoE4VqHwdeCR6AmOWsinVXhs4XeD3AnnYL
	 NyyqQbfWqKaONffmcdGvCd7zgPIyaaZdh/1bZChmRJVWt9bEoba8Mj9VPdtvLQJHSL
	 LtcLpkBtQervU2s3YqAwlJwk+9qPdvnWWnyivKaN8yf3MXd/mXhVPuD1TG2CyQRZXk
	 koUxpIOcYqO3g==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f259cdc86so15092585a.3
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2026 20:01:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy2XitDrGPpMfuiViw05NnW6rNaHUVThcPkjYFlj9rwoYgAW6vDoF8RMg80ECVcoACnYVqdgkR0@vger.kernel.org
X-Gm-Message-State: APuU4Z99aT/gJp9/enEltiYUJ7in5O0kv4FCgGUXHXeHZYfLo868D/XP
	+ExZqtOA4Wn6PFD7biUSPNSEd6ftANARy93NnseCDqWRV/GoqrnlpLmeG9DqXf3kpy8WtjIamjb
	+Od9Pg/WuspqBkr2ihTUvUDqk67MZRBM=
X-Received: by 2002:a05:620a:688f:b0:93f:5f83:2cbb with SMTP id
 af79cd13be357-945f33a9aa3mr181925685a.7.1793937678322; Thu, 05 Nov 2026
 20:01:18 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 6 Nov 2026 12:01:06 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zKtBarGn2gMEH7ckKtLLgugoyPb040Z2KtXX5Feye1Mg@mail.gmail.com>
X-Gm-Features: AclHuK-043SJnHCawrQog3yw2g1v7cvWQi1ZSPtdBLorMSdL4MZoNdMju91VkJk
Message-ID: <CAGsJ_4zKtBarGn2gMEH7ckKtLLgugoyPb040Z2KtXX5Feye1Mg@mail.gmail.com>
Subject: Re: [PATCH 05/13] mm: convert THP VMA flag tests to use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:33=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values where
> VMA flags are tested directly in the THP and khugepaged logic.
>
> The thp_vma_allowable_orders() family of functions, hugepage_madvise() an=
d
> khugepaged_enter_vma() continue to take legacy flags for the time being.
>
> Also update BUG_ON()'s to VM_WARN_ON_ONCE() while here.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

LGTM,
Reviewed-by: Barry Song <baohua@kernel.org>
