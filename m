Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978548;
	b=ffkctUyVfLOQw9VQV8MEG3myIs9iNNNarii8gvgA/Nmtxy91XQAtW5dwkBNs1RKeG1oC
	 uUttN0b2MFF1wXaSRAUWy4gPbEm1TwhjBiKlUs3Of9U2HO0Y9aaSXsMIfFX92l0holULW
	 StcdTdvIy2dLDxZMQv6e3I8BbNqhEUJXX+6Aywj81BjnTfQJcoCkxKjzxbAUjZxWvx3bl
	 1HpaDAsUoD4eK+Iz8m3sgld0GuoP9XkVQXFXvxrDeDK16iEpoq9N4YAym79sIQR0TN4su
	 akrVUsXqEjOBXpNgEwMbvLPBB9lbIZPoztWUKSRywnKJGFCKRs8TUswaqlaqVlgc2Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978548;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=z3y+DELGAxT9V5PmpfgouMZn+gCc4O45ROBPQSi1BPo=;
	b=zvG/pFCnX+N7P6i/0L8qwFk3gaCDMZRqcH+u65PWyybcl0c3wqFXnuorIBNRP1hVhKeK
	 jlyONjui4CHYxLfeEEnsGzzLnB+AsOSmTMzl6a5MdGQ6iGDxiIvMkYbknBYkJOjpt2A79
	 Dz6RFjVa1ujDWoQHB3suVg3Js+XhFuOarcI0WRcYoGnAWcWmRJA3mlIwcYBhnHorG/c51
	 xZjj8mf3L8QnVuuaYZHMi8hYpPFwD6VmEaErkHX/8l87a9LLh8TpnUpDIKWq6R3AmO7oQ
	 7iu7flhqx22l8dE1RB5S8Roc0lKmwpTe0Ty259Vwqad+/nPnOiX8UI69o6SlRztdPKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0OBt12S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E95606A32D;
	Fri,  6 Nov 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0OBt12S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73F71F0089F;
	Fri,  6 Nov 2026 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978547;
	bh=z3y+DELGAxT9V5PmpfgouMZn+gCc4O45ROBPQSi1BPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D0OBt12S5A0/61ajOHRCOvVj9Y496CxzkIZ539OmP2Egd7lJ1ZTg+93+bz35MlhhQ
	 aEcmgJvs2K1rXKjoPty9afP418nmgDzNbNz3R49xM82YI+IZppcn7JPT2+rOR1oP3E
	 aXPgvNxlojcYTHikG/NcZ6k0ko8+NVlu5A2DjoEJYkhK0Y6iRimNr2X51btaRYAQe4
	 3oYkIoHH1FFpK2QL5UAfs5I6l1ULxHTF3yATZiallmsTHKUql1MDHJSRDkOp7LPZaS
	 WDiRcIhr4R/mT8uJ1TsaVWpbDwDHCB8mxh70Ac0iVGTP+nI77JgCBpwlXJfuSijYjQ
	 cOmEIk2xUD+nw==
Date: Fri, 6 Nov 2026 15:22:08 +0000
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
Message-ID: <au3r0-geuwtRYPiC@gremlin>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org>
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
In-Reply-To: <d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org>

On Fri, Nov 06, 2026 at 03:35:01PM +0100, David Hildenbrand (Arm) wrote:
> I agree that this should be picked separately. For example, I will pick
> everything that falls into my realm to reduce conflicts.

Hmm, generally tree-wide mechanical changes are the exception to that rule
no?

It's going to make the rest of the VMA flags/mmap_prepare conversion really
quite difficult if I have to chase every single driver maintainer in the
kernel (literally in both cases pretty much :).

And sometimes there are dependencies which mean you really can't split it
across trees unless you establish functionality in one cycle and callers in
another, but that seems a little silly.

I was thinking that once the VMA tree is separate I'd put mechanical
changes like this through it. Is that not the way to go?

>
> Ideally, patches really only touch one component.

Right, but sometimes functions are declared in one place and called in
others. It is impossible to change the signature of one without also touching
the others.

>
> [PATCH 07/13] mm/madvise: convert madvise_vma_behavior() to use vma_flags_t
>
> is all over the place :)

It's not really all over the place, it's converting vm_flags_t to
vma_flags_t across madvise.c, which involves changing a few function
signatures, whose callers must be updated.

I could split it up into 3 patches where 1 does internal-only, one changes 1
function, and the next changes another, if that works?

But there's no way for that change to only touch madvise() given the
function decl/callers.

--
Cheers, Lorenzo
