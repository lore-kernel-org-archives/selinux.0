Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246636;
	b=wjXiDl1GrWZDvZdgKpsNBRSpBU21bdwGSOk/+4p+IosNBaHkj0AbQdsZS5j+f1UyqbEE
	 MAkLLhI6uAjctEnqJqTndJMbx929x2uTJkOewQ/noZHpLKa+ZbT7HUHkJP+2R14P6XYcR
	 T0NmLNVUDyKVm3dc0uLZxR6lbx+GmFyLXO8tL0tEVu4GmorOwcNJN3C+DzY6B+USqU62f
	 DfGFXxlURxnSVNtA5ItPRdfT0QC1gKZaIGaj7gNK8722AfshTODJpDWL657QHXOCCAIVg
	 imx874Pt3WCnhrpybbrvae2gxmUKws1VGeTvos9PDtR9Lg/MAxCTdNEKWnLZ5GnCX1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246636;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4Y+apbv0moZAbIC2JZwKUuLxptoIhomU3mV95VqD+l4=;
	b=alw7wVpnrLdRiQSkBAeTekFUEfM/Dw2tkZGVqpx/i3zLsEK7N1YPWCklRK5mBY0LWSMx
	 9tZ637L/GQ3EZkkQ5Z5JAE8Ux2suFpN9tbIK6EDWQcG1BMzpL9lnMn3+niISwt2PLTAZa
	 T4AwYfxwLKMDI7kVgvXNIKoEj1wVVkPiRC+XrtIrhp7Z+vpgKSZmIl8fZccbFVeJbQATg
	 myUGBTQ8Fma9BwnSsRserOFhtslIpbaXUloYLKt8tff4FOgWj/PgdoSoO2w8V1AFneFIX
	 OjSoYcurOKD4V270egJtXYNZDghJi0Un8heVmy7dbFS8ZrAHmIihHzrO+LsYXzDzSDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b="alzL5p/E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376BE606A31C;
	Mon,  9 Nov 2026 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=alzL5p/E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BE51F0089F;
	Mon,  9 Nov 2026 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794246636;
	bh=4Y+apbv0moZAbIC2JZwKUuLxptoIhomU3mV95VqD+l4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=alzL5p/E5TFjU0f4S3NCoMGJBvZNjLceDHvjdf7oUnrtQutT9d/lual9TYbQaYsV8
	 BIDjLsHSLUcOK6q2LAzWt3YlvV/WiGiPoNNU3sNfH3m3TbLCyeOWWakP21fgtRFZY7
	 MuUKvUaoZ86WAElRGG65TDNBtS7Dp15/zVMHHz1w=
Date: Mon, 9 Nov 2026 09:50:33 -0800
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
Message-Id: <20261109095033.ed2b0334c862ca832389ea7d@linux-foundation.org>
In-Reply-To: <ab4be2bc-8959-4c09-a120-37e216279dae@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
	<d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org>
	<au3r0-geuwtRYPiC@gremlin>
	<1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org>
	<au-DXpEi4wHwsz0r@gremlin>
	<93fef824-9f60-4940-9ee6-80c9c8e3f945@kernel.org>
	<20261109094434.d23a227a869e76455ddff3b1@linux-foundation.org>
	<ab4be2bc-8959-4c09-a120-37e216279dae@kernel.org>
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

On Mon, 9 Nov 2026 18:48:07 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 11/9/26 18:44, Andrew Morton wrote:
> > On Mon, 9 Nov 2026 14:40:48 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> > 
> >> On 11/7/26 21:09, Lorenzo Stoakes (ARM) wrote:
> >>> I think we're slightly talking across purposes, so to be clear - I am totally
> >>> fine with you taking any of this through your tree or whatever works for you and
> >>> Andrew to avoid merge pain :)
> >>>
> >>> I was just talking more generally about how to merge series that touch a lot of
> >>> subsystems and maintainers-who-may-never-reply, etc.
> >>>
> >>> These are the edge cases that make things... fun :)
> >>>
> >>> Anyway, I guess easiest resolution here is for you to take the bits that belong
> >>> to your trees and Andrew takes the bits that belong elsewhere?
> >>
> >> Yes, that's what I did now, applying #1,#3,#4,#5,#6
> > 
> > Cool.
> > 
> > I'll remove the whole series from mm.git immediately for
> > collision-avoidance reasons - let's sort things out later.
> 
> The mm-next merge today still worked (minor conflict on #7 due to one
> unnecessary ksm.c hunk I commented on), so you could have likely just kept all
> but the above patches.

OK, I'll take a look at re-adding things...

> > 
> > I'll get better/more accurate about this soon - I need to set up
> > infrastructure to fetch everyone else's trees, do test merges and
> > figure out what should be removed/fixed in mm.git.  I might just base
> > mm.git on everyone-else and always route its stuff ->david.  I need to
> > spend a bit of time on this and discuss with the mm-next peeps.
> 
> Ack!

...once this is in place!
