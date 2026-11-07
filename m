Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082215;
	b=uHXW3fAvQtUp7AwtObeDMEY2z5xz2SuP20HBG6V+k8SvStKuexo39nTUdBe/7ZWaoWpI
	 LD9qLi8kYqeizve7W5eR/GZIdZijURWkV1Ob8mRTQWduXYljpMX6dHWHjnPOrcFP14lF5
	 sMS7c4eOwLqe3dL8NCLdc7ZfdmCFyqSFP71FUYAp8aA+9QqSBKdEX50t1PyuL9qvdDuZX
	 TsqrRA31M8HFahZ37v08GKHuC8LdcGNG51utO8/8/0CIlaoXLPPHUUCTTPDfOagwLcFRL
	 YMJn2PhLqPOtBJIsOt8GGlTIsXWOc06fFrOzdapk+ebBgATmGs5qPG+qZ7FyzhikI1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082215;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CMFxkbGnr/NpLAXZXk8rbwy5EGs+66IVJk9lKIVoNp8=;
	b=uX1djr4KrJAMZKxMVMBGYBEm/Gr7wt1qgnOzrDxZK9R1iSBgprGdLPyP6K/Kq5ISNBIN
	 wMVrjJPxY+WYgwM6OzCuCxosnXy6wpI7W2HCMKsmd4geOY/3EXgMLxeQzoTZZKzIr/H56
	 N3barsESmMZbnsBeKFP/sE+lvJdpfnVBVYh6KtGrA6YPQCjDC5vbFEdrF/uGb8eu08gGQ
	 IIiYpTSbihqegc9CVuAUJXC/ca/2FRym+yV5s/6JKpiCAr5bxDzblan4+s6Pnbta5N+DB
	 y+rKReozhIyNO+exF3zibImrmrZ/WANB3SHiefsi5qtkY52sPd3I9px3QHhTq1zuMRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLeOYJRj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D7606A331;
	Sat,  7 Nov 2026 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLeOYJRj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D661F008A3;
	Sat,  7 Nov 2026 20:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082215;
	bh=CMFxkbGnr/NpLAXZXk8rbwy5EGs+66IVJk9lKIVoNp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iLeOYJRjjnhZl3LWMSGaUd1S27vEBJh9NrDzelAqlZmg4R2RciRfWoeIsojODwzqH
	 AmV3EGrrSvx70iXnLVmV7/bs2dBDE1x/r3nyPcxADmxBtch4xZP+oTaqLUfx+eYAuG
	 SGRWdAxli2sYIZwe/Tbuw0udh+c0QNfiwmJOXLSfQKYp1etxVNRgoDq0IPlAd0lt9t
	 yDMA0BPoIWju9BFMAW7mO+dutMm2GHuzj6pjWBP8PMNdT9kLO2lCpBJij+NhIf7LIF
	 N/2SXcwPj4meyprPc8KlcX/gZ5yZ2cdhj422kyiEPIrnEjIKnHoNmFfhk++nuATcLn
	 UZoP1hyr/4Jww==
Date: Sat, 7 Nov 2026 20:09:55 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
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
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 00/13] mm: continue vma_flags_t conversion
Message-ID: <au-DXpEi4wHwsz0r@gremlin>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org>
 <au3r0-geuwtRYPiC@gremlin>
 <1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org>

I think we're slightly talking across purposes, so to be clear - I am totally
fine with you taking any of this through your tree or whatever works for you and
Andrew to avoid merge pain :)

I was just talking more generally about how to merge series that touch a lot of
subsystems and maintainers-who-may-never-reply, etc.

These are the edge cases that make things... fun :)

Anyway, I guess easiest resolution here is for you to take the bits that belong
to your trees and Andrew takes the bits that belong elsewhere?

I don't think anything here has an inter-dependency.


On Sat, Nov 07, 2026 at 08:26:29PM +0100, David Hildenbrand (Arm) wrote:
[ ... ]
>
> Because of [PATCH 05/13] mm: convert THP VMA flag tests to use vma_flags_t which
> is THP-only, and feels like it could go straight through one of my trees,
> avoiding conflicts with Andrew's tree. But maybe there is more to it that I am
> missing.

Sorry about that! Please take that through your tree.

>
> I assume stable topic branches would fix that, but they are currently
> unfortunately not on the table ... :)

I guess we need everybody-on-git for this!

I guess when Liam and & I have the VMA tree we can do that at least for stuff
that goes there :)

>
> >
> >>
> >> Ideally, patches really only touch one component.
> >
> > Right, but sometimes functions are declared in one place and called in
> > others. It is impossible to change the signature of one without also touching
> > the others.
>
> Yes. Something like that is unavoidable. Or if you need new APIs/

Yes.

>
> >
> >>
> >> [PATCH 07/13] mm/madvise: convert madvise_vma_behavior() to use vma_flags_t
> >>
> >> is all over the place :)
> >
> > It's not really all over the place, it's converting vm_flags_t to
> > vma_flags_t across madvise.c, which involves changing a few function
> > signatures, whose callers must be updated.
>
> Ah, yeah. What on earth does arch/powerpc/kvm/book3s_hv_uvmem.c do with madvise :(

Yeah it's quite worrying that... :)

>
> >
> > I could split it up into 3 patches where 1 does internal-only, one changes 1
> > function, and the next changes another, if that works?
>
> No, these things really have to go in as one unit, no need to split that up.

Thanks, yeah, it's a pain I know but eventually 'one fine day' (probably in
2028) everything will be converted to vma_flags_t/mmap_prepare and we won't have
to think about this :P

--
Cheers, Lorenzo
