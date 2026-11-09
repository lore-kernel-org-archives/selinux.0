Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227183;
	b=NrIrE9yApcsqVd5SU3ZiyjqhfbZBh5i9xqCllwy+/hpyEwnCiS9SINaoa6Nt+fUm03/o
	 fSO+N6hU2uCUpIlnNgaOXaadMOlPMsC0NbaZzZNjjDV8PC/xItR0ckRcVlGT9kxIFFixY
	 VUf+T1NyZCkRZcPK7JdMhmUUFxBOjZVGNELacL30Wk8gmNM6dTX685/qV+C5OD9OmUqUb
	 Ok1ugviyAv9D9QiIIn34Pw2u2P2+5TZYwomOD28zXQCQ4npqdbrc7HGXcX3E4SE0pfRZs
	 a99t9hcKkDfF4UhcVQfzZVLN6+IvL511H/gq5aIBZiSzAsJ5tFBnycme0oiHzRvPguA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227183;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6+EKYQdPiDyWXkzzfV/UN8vBxInBjW4N6ZELhlBfhOI=;
	b=FravJIZPmJWItFVVMLMskbgWqU7crZr5vlViguxVfCH3UAh8W/8KcprpC5sqA27dNA6I
	 XfQfEuYpWdg10AGdYVERwxyvnJTUiRbAtpxtRdMnRBKrQfCMFQsYR6la6ycqBr5L+cbF/
	 CCbl8pXhNakEck3IKSCctFEHMMlJCfRDWgGqSd0sTvU0F/UU1Gl9Q44SM7pZ2reCzL6G7
	 S5F3OJANODDPdlcak96qiA+K+bKGmxy7eqE0fMlif8fmo552dmgDtzyPPyyfH0yYLfS4h
	 R3KWz87o4PQqkpirYcU3rc+cEthaL0341PymLTfKsM8Ova9CwXG1AeVGR9mIkY44iEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhodTs+A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9811606A321;
	Mon,  9 Nov 2026 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhodTs+A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937971F0089F;
	Mon,  9 Nov 2026 12:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794227182;
	bh=6+EKYQdPiDyWXkzzfV/UN8vBxInBjW4N6ZELhlBfhOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VhodTs+AWpB6b78audXhz1hdToGnTfiqsIeh7C9iS51ypshI9FNnayYXFucaMgeLZ
	 xeEIungcy0zjIPzwmpAqArp8eRXgn6aLR4nNmqHiWaRHWsbsQ7Qxh3+PgSaQmGodli
	 iH97FzOVZfiuF5Da5WjkLmXe3XJknzf7SbtxrzdHDZZM2QKqqAHZOHOY4doionvKHw
	 4h930muPKhPQSSHI+AAJgxUYDe3aTAGC8NAItOXceOH2dwmRr1lJ1teB6f1iCQBu+D
	 7GUCaRQliXvLQza+jV5DiZhXeIr64nvzKuidlvAiLong4iDN+nDILPyMHrAS7gpG/t
	 Sxhmv2E4eHoMw==
Date: Mon, 9 Nov 2026 12:26:00 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
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
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 02/13] mm/filemap: convert fault and readahead logic to
 use vma_flags_t
Message-ID: <avG7mvt0okaFGUT7@gremlin>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-2-0d3cd15ab75f@kernel.org>
 <sashiko-outbox-200257@kernel.org>
 <au2_PPpdAMgRJZtX@gremlin>
 <CAGsJ_4yWQom=cG5vw2B-FR8+7wNU+rwZkvghjAxusym+3OH96A@mail.gmail.com>
 <CAGsJ_4zvRSUSspBe_hNwTYDjK3-TLuq6Mhi5gDyOPZGDXN8gDw@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4zvRSUSspBe_hNwTYDjK3-TLuq6Mhi5gDyOPZGDXN8gDw@mail.gmail.com>

On Sun, Nov 08, 2026 at 03:42:36PM +0800, Barry Song wrote:
> On Sun, Nov 8, 2026 at 3:20 PM Barry Song <baohua@kernel.org> wrote:
> >
> > On Fri, Nov 6, 2026 at 7:53 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > [...]
> > > > --
> > > > Sashiko AI review · https://sashiko.dev/#/patchset/20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=2
> > >
> > > It seems these are valid, oops!
> > >
> > > Andrew suggested a fix off-list, and I agreed to this as an in-place fixup to
> > > avoid respin.
> > >
> > > I have also updated the series locally to reflect this change:
> >
> > Seems like a reasonable fix. maybe_unlock_mmap_for_io()
> > could have released mmap_lock, leaving the VMA
> > unprotected. but  ra->size *= 2 is still going there no matter
> > if the vma has disappeared
> >
> > For the original patch combined with the fix,
> >
> > Reviewed-by: Barry Song <baohua@kernel.org>
> >
>
> BTW, one question is whether mmap-based readahead is
> still worthwhile if the VMA is actually gone after we
> release mmap_lock (or the VMA lock). Perhaps we don't
> need to continue readahead in that case.
>
> However, we don't have a reliable way to know whether
> the VMA is really gone until the page fault is retried.
> We release the lock to perform readahead, so in this
> racy case, readahead might be happening for a VMA that
> is being removed.
>
> I'm not challenging this patch, just leaving a note
> to think about later :-)

I suspect it's one of those 'not worth checking' situations, VMAs can come
and go at will at any time and theoretically you can do useless work, as
long as that's mostly not the case I think we're OK.

And in general I think these code paths need significant rework before we
revisit stuff like this, we always pay a tax for code complexity!

--
Cheers, Lorenzo
