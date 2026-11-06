Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931232;
	b=HueFFd/ffY0An9PElJ4zWiJl7i/dBA1s7XV+sSv2wFd+LVwcBrlQqz+Q0YnIV4m9hiJc
	 94fy85atPt6r0I/qF/KBlLcN49e8HYG1F32c1+ZXMh3g5E6P3nXP9sc98TDEIs1H6+59T
	 buyiZ1HdSqRyMcNpS/CziymswLBzy7720v+/w+tPTHS6w13N45XqiGNJOowM+oGX4qO6Q
	 KtDxW87uZJImynLtQFV8+p8Pci99UjqoU99Z7vV2rigQyDs+pqAEmuvwI2v/CGyhqRGz0
	 SNXb6jKoBU310/kLspr/xg25xdyyD0AoqVHdEDOe6xTeg/pBToQGQDxi1N16kD2KxRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931232;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=SwgrBjqkdHVN89k2r7i2yZAHCG31Diqb92PenA1gCr8=;
	b=Pfzq5CkCRCFtjABDWNi1/moVmNzgRCFl7ceDHZDoexLxz/MSmtmqyoVq7Br+0/2nJL7t
	 BZ2uiLU8SUzEOe4xq2p7sBM49chbVG7CgGiZcX8rKEsqdqpAs7qISBhUVOrEKCk5os0LM
	 M9Vgu6E0RgEqkaiavRK9+wMXglMw/pGYcrSYBKkMB0JgQBP45Xaig1F/gJeubO/H6zH+t
	 77Jpt9oy2l1nF4IDNhXz0uNJUrWTMUrMMoY+TVWbxhLjpi0ua11qVuC2rdze0nxfa6/2r
	 XGVFcUSPxdnXPNZBPRhLq00UKk5dtqw404CXK2M6KcOgzVHZ2D+xoH/dQh7EVwHSj3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3Em9F4P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9B606A32D;
	Fri,  6 Nov 2026 02:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3Em9F4P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790111F0089F;
	Fri,  6 Nov 2026 02:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793931231;
	bh=SwgrBjqkdHVN89k2r7i2yZAHCG31Diqb92PenA1gCr8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=m3Em9F4PE9u33zUl2y6LstthDzhfyq4KiXR40nCfdoOgLbNJNF4jB/G4o35jsjeBd
	 Bu32m130jQCns+cycWPMsKi7uBYNzQibEz6nuQw5Jar9DAEVlYxBIc7uoxf0ZlC13S
	 zr7eWzKfM89ubx2jRQ2vMlCZNFZPnRvWGJ3xmXP//BA3yVW3HOUJobBxm6x4olJ/J3
	 Ozb9428qhMeZOhSbxEnFaVhM4m9je+vTe89kaeLXeoEGunJy+1wXuFIgQpPTBmVzko
	 ajpMRaFFDXnoEfOK+n3ExMWm0SO7U606rnluafcz/GcoQ7OdTOJN1xiSvdkxU4BWRU
	 y6P4hTT++7Lnw==
Message-ID: <bd783541-9ba8-46b9-b08b-0bd9d9ea6df8@kernel.org>
Date: Thu, 5 Nov 2026 18:13:49 -0800
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
To: Paul Moore <paul@paul-moore.com>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
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
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, John Johansen
 <john.johansen@canonical.com>, Georgia Garcia
 <georgia.garcia@canonical.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, damon@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
 <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
 <CAHC9VhRDVz4M-m_4UZZDKMgs4uc+j-+-jwYEdBDfSD0rtd-1Og@mail.gmail.com>
Content-Language: en-US
From: Fan Wu <wufan@kernel.org>
In-Reply-To: <CAHC9VhRDVz4M-m_4UZZDKMgs4uc+j-+-jwYEdBDfSD0rtd-1Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/5/2026 5:22 PM, Paul Moore wrote:
> On Thu, Nov 5, 2026 at 6:17 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Nov 5, 2026 at 4:35 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>> >
>> > Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
>> > mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
>> >
>> > No functional change intended.
>> >
>> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> > ---
>> >  security/apparmor/lsm.c           |  2 +-
>> >  security/integrity/ima/ima_main.c |  2 +-
>> >  security/ipe/hooks.c              |  2 +-
>> >  security/selinux/hooks.c          | 14 +++++++-------
>> >  4 files changed, 10 insertions(+), 10 deletions(-)
>>
>> Similar to the other patchset you just posted, is there any reason why
>> individual subsystem maintainers can't pick these patches up, or is
>> there some reason I'm missing and they need to go through a single
>> tree?
>>
>> If they can go through multiple trees, can you split this patch up?
>> AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
>> different groups/people.
> 
> Since there seems to be a desire to bypass normal procedure in favor
> of speed (surely that will never backfire), the SELinux changes look
> fine to me, but please do wait to hear from the AppArmor, IMA, and IPE
> maintainers before merging this patch.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> 

For the IPE part:

Acked-by: Fan Wu <wufan@kernel.org>
