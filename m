Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960026;
	b=BkR6aj5ZeCtWMDu6vul64vOLd0tBl/2ZgO8tCEh+bL9lf/llv8ECdpMt9k1qL+Egjnkn
	 snXrQ27AVHQ5Ee8HpNLmovJ1p+Z+X9AcTvwDGWGhBPKcy2T43tlX+XxlVggAB65lte1QC
	 +zcuvUfkXAx4aQ4kbCyIcz1AcH1UckWxAyWGg/Z9iISeCbMe09anvcPYwSI6oZyifiLo8
	 eaQBhX5b//Q1n4ztnEgIl7TKzVlltqB8brUKU5yGTxAAT6gxDtMrcLOz8p0ZpJrI7p85e
	 zEgnfeCOT7WY/kYgOi8yzP2IWAhtq46TKLx4/HXwNb3iSGF0lPzUgQuu1riRcNIJIJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960026;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=cFVMR87EGNpkNOCnSwEX2b70j/gGYf8Jkc9yEvS8W5Y=;
	b=2lOMFaOb8G+xAUauT1HWRGCCaoECIzcqs3NKGAQc4lNAgLpV++2wRVE2xD0b520lfDYZ
	 OQCkNkf2NadnHPvizY7Cn6tHOYZkjcsFWvT3QOCIxJvPZ5x4f6OX1ZmLdoFJRwh0qlt7H
	 HcPg/CnvYCpqM6Ncf+9qAk8enXpD17LvtQwT0/if+24P5MX+dKSQ+SyQYEVIYjwYdHsuk
	 1/XkK9fZ3uYV/HYjEdSmqBbjxITJ8+dUxCXEafElhRdu+nyF6Hi4RmTYKPW3H2aejhY9n
	 eH4ZeMP6iDYDgU6Wi0BVMuitDxGh8MFRVcwH0GFcTY1+h+s7HMqXBeH9G4oBYk0EPSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwYtVdd3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A68606A335;
	Fri,  6 Nov 2026 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwYtVdd3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE401F008A6;
	Fri,  6 Nov 2026 10:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793960025;
	bh=cFVMR87EGNpkNOCnSwEX2b70j/gGYf8Jkc9yEvS8W5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YwYtVdd3f+9r0rGtBh8d1tRPhVBL4qmvxhKCMZkV8lomBwDWV76lkDV2ZPvzrsUcy
	 trEyAB1TCppduadMVhftHMFVxgeYolc/EMPmtth1hXWiwFgz1kQ0EKU4byddd4Ylof
	 Kw8NW48Kkjzx+SlpAufJOnfBvexabI3n6q9ar/Hme/DA7MCCquYR1YVU8yI3FmAIG8
	 1O4CYPlx4m2ZTD5HMwTNZOFUugRf4D3Ab0jOV8qahLlzSisYMSFxFIYqDA/1U31men
	 TNFTuhw5aLNcrLSy3wXMfK9DUwkHBXM2MWRhS62JTGof+13zFAAyi0DL6QeEKCjKfL
	 pWOWcHUvqbeJQ==
Date: Fri, 6 Nov 2026 10:13:27 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, SJ Park <sj@kernel.org>, 
	Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	John Johansen <john.johansen@canonical.com>, Georgia Garcia <georgia.garcia@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Fan Wu <wufan@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	damon@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
Message-ID: <au2ny_goOYa9TJ4u@gremlin>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
 <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>

On Thu, Nov 05, 2026 at 06:17:47PM -0500, Paul Moore wrote:
> On Thu, Nov 5, 2026 at 4:35 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> > mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  security/apparmor/lsm.c           |  2 +-
> >  security/integrity/ima/ima_main.c |  2 +-
> >  security/ipe/hooks.c              |  2 +-
> >  security/selinux/hooks.c          | 14 +++++++-------
> >  4 files changed, 10 insertions(+), 10 deletions(-)
>
> Similar to the other patchset you just posted, is there any reason why
> individual subsystem maintainers can't pick these patches up, or is
> there some reason I'm missing and they need to go through a single
> tree?
>
> If they can go through multiple trees, can you split this patch up?
> AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
> different groups/people.

Sure, they're all independent so you can take the security bits through your
tree, I guess fairly easy for Andrew/David to figure out which went where?

Intentionally made these easy ones given how busy the cycle is, just keeping the
conversion rolling forward :)

--
Cheers, Lorenzo
