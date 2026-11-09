Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231172;
	b=yTs+3P2yf9vyX7Un87DHYe34pBNpNzeeo3HD1esYZZaq+qoyoOROSmSumJ4e1VK/oHB7
	 fPt0TpVVYByxMYiWkv6JZsq8dGcwfNJH4tX+iNsYMRRFEGe1R4gC97wpfOPqii3n4YIgE
	 rK9VsiSSq9HG7oEmxuYpfel7LLqlXiCC3hxi5p6CoDJNn4KnJYxDoYw/4RoxjT9PnUic2
	 1KceYKE03IhzCHFJx6rUEGxL1/7KJc3ZHrkVEcRGIs+ztK/3cwHH+PhBUk88gv7EA8oIW
	 NfQvO7ktmHWcC8Di8E0aDTFGaVF7qlM5RPEDx2RzL1Fv2iUfSzDTVj7qpdBiSoXT4og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231172;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=3kO+9xP9gHYxqDwN0M/HD3ySNAPtZoVrTYpd1QO/0hs=;
	b=qw+WcFelwcLz3XiDViFXOGyxL3e0QKb+s0DNZOT1F7ZkOxq+BELQ3ipJ/Ti6RWbyRgTK
	 TdTOL8crUiQq5r+XQNqeiv6J4u0PESqhI2uEq49P8gM7K4uWtaVSQLWDDfFZo2zRgDnPP
	 Qnp3WEsjZQs3ffbU+NP+8iZ6dU3+H05Cl+pb3knfiLdj7NddmFzQBrSTeD7wVvkAlrF6N
	 74nHoyIugUjMK8os7oTpyc6kczVjLCDld0d6i8nIFjENJT4tbRL7zcmVVtLQaE+//VUf6
	 /1voPhKfAQGp1k9EsHFqSy0LmGZkkLSvpF5WjMaIfS2Z5FjT1KDc+4TTy2XULHXySmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzZzxUcO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A255606A322;
	Mon,  9 Nov 2026 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzZzxUcO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8BE1F008A1;
	Mon,  9 Nov 2026 13:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231171;
	bh=3kO+9xP9gHYxqDwN0M/HD3ySNAPtZoVrTYpd1QO/0hs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KzZzxUcOxN+LUkJJbvaaWtgAg0Lr5n0Lq5msXujrfpHexbax+Q7MphMNrKT297nty
	 Lgqf43fqFL3IaxYW4qsLltL1rfN+n7EKzp+quYJhHXOJf9EdP3tkJIZ/07lfxJ6QR5
	 yMVW+5CfIRJchjav43ecF7/gIb/nUAMMMClY+lUKqmcbumcULnahrlJ2fMGe2TfNut
	 CHcmFQaVPR97bHK/+Cf5PmZH+zHZWDepmd9kLxjjIuwDPYFFh46dEB0JJjZoWaLWmp
	 3wVNxLys3qIdpG7dFxhjM07JWa3keQ6UCUpgwUbcazbFW8Qlf/49Zl3gWA1Y5pPR7k
	 iNtqEsvwq1ZEg==
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
In-Reply-To: <20261105-late-2026-vma-flags-v1-1-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-1-0d3cd15ab75f@kernel.org>
Subject: Re: [PATCH 01/13] mm/gup: convert GUP code to use vma_flags_t
Message-Id: <179423115134.12726.17304494910149332848.b4-ty@b4>
Date: Mon, 09 Nov 2026 14:32:31 +0100
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

On Thu, 05 Nov 2026 21:30:52 +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values
> throughout the GUP logic, both for the MMU and nommu variants.
> 
> No functional change intended.

Applied, thanks!

tree: mm/core.git
branch: gup-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[01/13] mm/gup: convert GUP code to use vma_flags_t
        https://git.kernel.org/mm/core/c/87127ea3

-- 
Cheers,

David

