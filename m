Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964120;
	b=G3348mn3e/6qX4XHstLORqtXde9ynMzS1SPXaFLknwLmopmKKpg7a7/0lhYzMpAKlLr3
	 HMipZbASpz9PFGbmJhjQ5ylRMH5wbhLrSB6cWtfezCq0hhUP7bmiamNIhJs0S4/SdxC6c
	 1uITpEktXK6vUBlOIq2Ade1OVzQB58YMtIfLUHzMFoxQSn1B2TG4VY/RksERLRTF2C/wQ
	 85VRmCHbZQOWxUXZ/ztkjr2aPOvJ7uu6lOOVX7fJlmxHNTSe93secXilEsRjxutwBUVxw
	 6TNuHXzChejlJM8sNc86/m4VJdjeS6zaRcpGOK0FDVTPmM8B7333J7BfURqpvsrdRxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964120;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=p+Ok2jd0IVx31NW+VHJJuf+Q+PVcuhS6OrBHlNc0X1Y=;
	b=ytue30Mko8PcVj8n6z3W2CMEEYWN49LNpERPk2jQ5ealzk5wi9PF2m9zyZMtLnzp0+j/
	 cBJ53ZCK4iUYWhF5WHzqtyKtbauwa6elVNpynSiK3xtXY4NPUIXtds7uTsuP+IpxLIZaJ
	 BPV6B1K//fa/OPDbnQLknMsmMZxM8RfAPNJ4A/8sXeLyeSaAMPTIkISrC9zhfI8Dn0g/a
	 pqiUlvRBUcL4x79F+r2JmMqOoubFsrtA2FyVlA3lI435DEHuFC+AekxHj2LK3w5MngjX6
	 V+UiY7mLhFwQS/O3v+tAKXGepvpXfR3XCcl7pM9rFdQYXccTlaUOFP4BzvyVMJYpbmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bK0a9SGW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B84606A331;
	Fri,  6 Nov 2026 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bK0a9SGW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F931F0089F;
	Fri,  6 Nov 2026 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793964120;
	bh=p+Ok2jd0IVx31NW+VHJJuf+Q+PVcuhS6OrBHlNc0X1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bK0a9SGWX+VyZD0kFIiK4yNIK9A9v+An7WfGjPiMiNKuUGcrfRy/CwNqTxljrBpV0
	 U7m1a/COhNVgako5ExzfFpup8zroemN8PZasns74e+wzdmXNGp9HfFsumePkfHpqUz
	 B54avhJDK4RV1zIBmim6BKz7o7ZgZ9/g1a3ek0DWtoergphiLCDdHz5glMnik8SvAi
	 sjlHg1ttAqkP8985sWOQHptTvB9E/+p4pzQXWHiAvU6YBAJ26cTB4FDz0XEBtsF1a0
	 bgh+paL3EuS+CEi5iRnn4vYJCUV3oXHmFOJ7h5ygJmRsCVDkmI4xEURGnOh8gud8UK
	 jwyBg4yTS3zRQ==
Date: Fri, 6 Nov 2026 11:21:40 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
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
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 03/13] mm/rmap: convert remaining VMA flag tests to use
 vma_flags_t
Message-ID: <au2yhvzWy6HID8jM@gremlin>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
 <CAGsJ_4wCd_j5or0uHwPLq0PUixcXgiFim=_d7uUhUhAuQf0nTQ@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4wCd_j5or0uHwPLq0PUixcXgiFim=_d7uUhUhAuQf0nTQ@mail.gmail.com>

On Fri, Nov 06, 2026 at 11:57:08AM +0800, Barry Song wrote:
> On Fri, Nov 6, 2026 at 5:32 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > Replace the remaining uses of the legacy vm_flags_t flags in the rmap logic
> > with vma_flags_t values.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
>
> LGTM,
>
> Reviewed-by: Barry Song <baohua@kernel.org>
>
> >  mm/rmap.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 1131b76bbbc2..cdc97fec8586 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1196,7 +1196,7 @@ static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
> >
> >  static bool invalid_mkclean_vma(struct vm_area_struct *vma, void *arg)
> >  {
> > -       if (vma->vm_flags & VM_SHARED)
> > +       if (vma_test(vma, VMA_SHARED_BIT))
> >                 return false;
> >
> >         return true;
> > @@ -1660,7 +1660,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
> >          * VM_DROPPABLE mappings don't swap; instead they're just dropped when
> >          * under memory pressure.
> >          */
> > -       if (!folio_test_swapbacked(folio) && !(vma->vm_flags & VM_DROPPABLE))
> > +       if (!folio_test_swapbacked(folio) &&
> > +           !vma_test_single_mask(vma, VMA_DROPPABLE))
>
> Right, VMA_DROPPABLE_BIT is not available on
> 32-bit architectures, so vma_test() cannot be
> used here.

Yeah, it's an annoying wrinkle having to differentiate, but is necessary.

Eventually we will have 32-bit kernels move to the same size vma_flags_t as
64-bit, e.g. something like:

- #define NUM_VMA_FLAG_BITS BITS_PER_LONG
+ #define NUM_VMA_FLAG_BITS 8

But that's down the road :)

Which will solve the 'not in 32-bit-kernels' stuff.

But also this form is also used for stuff that's not defined under certain
configurations, in which case you get something like:

#ifdef CONFIG_FOOBAR
#define VMA_BLAH	mk_vma_flags(VMA_BLAH_BIT)
#else
#define VMA_BLAH	EMPTY_VMA_FLAGS
#endif

And then vma_test_single_mask() is necessary too.

An unfortunate outcome of defining per-bit (so no bit value means
'nothing'), and any kind of invalid bit value solution has worse drawbacks.

In the end all this stuff will be useful as it allows us to no longer be
constrained by either 32-bit vs 64-bit or in only having 64 possible
flags. :)

--
Cheers, Lorenzo
