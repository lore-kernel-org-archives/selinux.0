Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246278;
	b=lpKdW/HL0ovCcLeX7Engrr6a6mmA+CJOK/6gaSEtOkvtUEskJKZsfhjWftoE0mD+UvIl
	 LpXFidORSfMUSpyg+dIrYIwKxuok7qx7jlSvPDJJqQePwWycjQF9kwjss37UJdIognzyf
	 k/Qg6ts10aXBNhIF0Bw+VP/ZVfz39r5BjsQ9ex0+l/cPXtZ2QEh36r1DfmX4OKR67W0jO
	 5x6o6PoVxBaPf+4+acAO5KWdtNdRZBFz3x2tbqYrT/+RRXV0jxkACnwNRVuUxqIgBonYS
	 ulQRYaQP5qh2To8jN0nvv7dvvDcI8iwBMffdyB+KDfiWX1RI/XtVu0J6XfWfPXtRQug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246278;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+EpjN/DsBpVyfyR8n/gQ0lrO4LV9kbgQU5k49WPSPeE=;
	b=gI0vXvZWQsMtHFwcHnhFN+boumpvFQb2l1QvBzu7si8jY6r58KFzl/ES7AAIPPL91I+V
	 yrR+Ftt48zm1Or5k4dVfqnzBKvqfS1bD+YEUhIb9oNVqgCHqQQUZZ8yD9G95+1hm+zdIy
	 HMBHW7BqagF+76eihdYNfLCcQjZbcNfB76Y/obXVJk8HJER9M3f4l9BvC/HuYTS3h3J/L
	 5zkgnaJ8HjWu0fOCoP8CsQbhXCCXx6qtDg5IgfiZRkrAqFbh74GBRdh6WkSepgvKM3Vww
	 7EPxKCA0s9yg/4SGiTz9UBFKyXA1SuMcRzPWSlMByvA3LoARZNhMblDbRAHdNVJcIZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=gzaCyMM1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9F606A31C;
	Mon,  9 Nov 2026 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=gzaCyMM1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2301F0089F;
	Mon,  9 Nov 2026 17:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794246277;
	bh=+EpjN/DsBpVyfyR8n/gQ0lrO4LV9kbgQU5k49WPSPeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gzaCyMM1cJrjP8mVfAdfm9Tk0MNbUwWsCzu5aBYFwIXvHqXzHyjNWYvmsk0qAwsED
	 GA9iUPuLXd53UNdhLXbucDDSJCBnpyT4AdCqpMXhvrVqGpYP2eidMHAWz42rUr0Xzx
	 9ZMkq6R2Q8unfhnRO7BxhFf1Z4gUeAYDiBZoVcbY=
Date: Mon, 9 Nov 2026 09:44:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo
 <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang
 <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul
 Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache
 <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin
 <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel
 Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He
 <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky
 <leon@kernel.org>, SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>,
 David Rientjes <rientjes@google.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, John Johansen
 <john.johansen@canonical.com>, Georgia Garcia
 <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej =?UTF-8?Q?Mosn=C3=A1=C4=8Dek?=
 <omosnacek@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, damon@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 00/13] mm: continue vma_flags_t conversion
Message-Id: <20261109094434.d23a227a869e76455ddff3b1@linux-foundation.org>
In-Reply-To: <93fef824-9f60-4940-9ee6-80c9c8e3f945@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
	<d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org>
	<au3r0-geuwtRYPiC@gremlin>
	<1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org>
	<au-DXpEi4wHwsz0r@gremlin>
	<93fef824-9f60-4940-9ee6-80c9c8e3f945@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Nov 2026 14:40:48 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 11/7/26 21:09, Lorenzo Stoakes (ARM) wrote:
> > I think we're slightly talking across purposes, so to be clear - I am totally
> > fine with you taking any of this through your tree or whatever works for you and
> > Andrew to avoid merge pain :)
> > 
> > I was just talking more generally about how to merge series that touch a lot of
> > subsystems and maintainers-who-may-never-reply, etc.
> > 
> > These are the edge cases that make things... fun :)
> > 
> > Anyway, I guess easiest resolution here is for you to take the bits that belong
> > to your trees and Andrew takes the bits that belong elsewhere?
> 
> Yes, that's what I did now, applying #1,#3,#4,#5,#6

Cool.

I'll remove the whole series from mm.git immediately for
collision-avoidance reasons - let's sort things out later.

I'll get better/more accurate about this soon - I need to set up
infrastructure to fetch everyone else's trees, do test merges and
figure out what should be removed/fixed in mm.git.  I might just base
mm.git on everyone-else and always route its stuff ->david.  I need to
spend a bit of time on this and discuss with the mm-next peeps.

