Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231508;
	b=gx3wD9Iwvllyioakz1S+6jy/RuXUVeO3EQHsIFoWZPReMlcA7SAOH8NuecDJgkz184bH
	 C3qHfozUlKcfBQh2iVC+1YPjaFURLs+I6zYuAJb9USee+f8wiYUtkBMRBzjfbuZ+YdwEz
	 ddh6nk8hgolnEChKkyJPAGR+tDu1Bd4TS8QAOq4YgxMvImx/VW2Ohgd/EzE3qrZAkHhB5
	 jdFG7vz39Rj2qNGS1xHRwUYNB3k5n0mqSiTaO6RYhvdbFpTgrHQcDNXdcG/nDykaEfdFF
	 CScJ0/Hf2XjPuXEWh8cRkR7PWqhhWsIyJXoRLVIeOUKZUI+4t0eZ2/zqHTA5biWnaUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231508;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=/aS8gvtJwYJ7Jliq5wp81vVfiAvrLQxAzcweXbt+N94=;
	b=0fZ+tyKPu7o9/lHX7Y+XVeOsre5tkxhD9lJxShjpz7j2wmSWFl8R7X0BnV4+Zj2dyLAE
	 ThhmgcMpo4Dmdy0kLP5PRELuoTh61PEDukTfjE8JarET6avOeUcMFpOxo+WjEmMusYsqd
	 oQJKgIpnirFwYSJAHi1/i1A7MW0N1yCsfuOZLFJsnLRl4lkYUJC2nS0XEix8SEcLKs9T5
	 eAjD5RdGOJvi+AI3ZM6vx5BGOc7MgRu6CXbqNJM1GgqSgeG2ycsRHOySjbMsHLjuURbyb
	 XeXaESkl8XFtbgS8QVQvFdycY7+efmHyzxa11MLOlX1+lbG5Glgzj2FWE93w+JNBbwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZ3uelB7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A4C606D81E;
	Mon,  9 Nov 2026 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZ3uelB7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3661F008A2;
	Mon,  9 Nov 2026 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231508;
	bh=/aS8gvtJwYJ7Jliq5wp81vVfiAvrLQxAzcweXbt+N94=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WZ3uelB7V+qK0/f1tZpZEt/+AhrXEVHNH/IgUZx+TRm7n3MQLHQLPQ9N9uPgezm+G
	 6CR78PhrpB7B7HTmcD58yh1KaFEEueIkKWp9lzg9L3qrn3/3A/JSf5tvTU33RB1T2p
	 9BJEtW+i0m95oWnqOfsuKz6oFH79+LBujn7wf25fouWcHQIuRjubqvVqpD2brV0QkZ
	 1O0RoWddr6aQgIZGm48Qbc9XX6dT87bDYsjGFKKjw1Hzjvt28SGiREqgWH8w1y643c
	 YEWvd0IgVQsOXBeC1oswZB907JFoJm5zYlsDd0cs1Lw4p/rjxdjPnrkUADHnvnOWbo
	 ujKPGy4Xfn9zA==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
Subject: Re: [PATCH 05/13] mm: convert THP VMA flag tests to use
 vma_flags_t
Message-Id: <179423148899.14386.17835309596553043809.b4-ty@b4>
Date: Mon, 09 Nov 2026 14:38:08 +0100
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Thu, 05 Nov 2026 21:30:56 +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values where
> VMA flags are tested directly in the THP and khugepaged logic.
> 
> The thp_vma_allowable_orders() family of functions, hugepage_madvise() and
> khugepaged_enter_vma() continue to take legacy flags for the time being.
> 
> Also update BUG_ON()'s to VM_WARN_ON_ONCE() while here.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: thp-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[05/13] mm: convert THP VMA flag tests to use vma_flags_t
        https://git.kernel.org/mm/core/c/cb15e2fc

-- 
Cheers,

David

