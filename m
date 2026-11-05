Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914298;
	b=1z5EjoMhqy0EdmuPMyj21tASlYZUd3cKtYg/ZiKHeAB1XrdE4VcigFopzpU7IHIfmdcM
	 msJyhuSwiF+6Hde49rxUgJKL64qUIrPT34osxYfzNG7EHF+Kf+VuZmBaKBbv3BFfk06bA
	 /xOFMAJyHE9IshoAWURzmlCN/q5WYm0YtId9T3oaxCymKpa2iMduGwl0keoIIlW6TZErq
	 bh6zg6xQoIqe9V9MmaPpfS3CtXcwcrBdCkD65ecLqBmCVaCS+dKMdBsFzx4U8NVbAqw+n
	 Ejg0ZjA2VcD31qRKUFowODJsAxIcunx4oM9iF29OZp/HD26LKc+8dGlRqG7u7+fWcdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914298;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=l/XBPzIruKyaT68fHsJTL6/0Y1whGy5OpPSy6WgTELw=;
	b=nm++eguCki+POq6S1UrLZlZXxBBRbWTIZ33gj3TSSAI8zd6+2I+3kK1aVNcxmkjeA3eP
	 jqPlScq3yWDvgZIzzeiqhr1kRwOt6fUc82TN+iAiMDdH00Qeh8aymdSuSdogkz4KA7jta
	 6cwk6BARb37bSPhT1TSXum5KYXb9+yMfhDmVy9Ig8ryImZBws6Miqb8vSh7GtcG2wFagu
	 95IFM2+YTUeTwmEy+k1sv6bSLnNqT9UwbSX23WHhWnJMYAEgtrnp2c8D40Kki5d9iipT3
	 zgWcnYzC0j2iMMhvRf7xnaXnr/5aRqR6nlTAGNmA6DPzvYvP9ZIdP9U6NVMzc0v4bbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE+anxcK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880A606A31B;
	Thu,  5 Nov 2026 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE+anxcK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747CB1F0089F;
	Thu,  5 Nov 2026 21:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914298;
	bh=l/XBPzIruKyaT68fHsJTL6/0Y1whGy5OpPSy6WgTELw=;
	h=From:Subject:Date:To:Cc;
	b=aE+anxcK5DVd4PxfaPeug+8Go7oXIkkyd0cr7QF/UCjgq9jQl+bNK0q+4BhKrFU6l
	 nH9TpbM/0AmUyIRXZfMR7+ZGUYkgq1BDmA0gMwCZlN+dq+z3ta162TfttOjx4fBrgt
	 5jqDEBSY60zS13wAtaGgurmcThNfq1GYkCiTlr6kkqTQkdSz/nP1SkszH09Zyo8Vxs
	 gkd/MAkUnyzsOIfsT4YNgixR1lw3gB/K4VRz5l4xVnYXGhfODUOU8wO+APAcsQd4VM
	 pobOy+eE76XoFeivYZrQgxoRdn9FhNGDUTwlg2/ulGNDaKNWkzGWtu8Q8T+PXTf1Xg
	 PFYf3vnSp0ZNg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 00/13] mm: continue vma_flags_t conversion
Date: Thu, 05 Nov 2026 21:30:51 +0000
Message-Id: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1gaMlQpeRVyEmtaAP1oRQby71
 eVbzNyQJKok6IobopyadFszqCzATbwGQR2zoa5qS1QRznwIfsJzYfQzh4SNpdYQW2OdgVzuUbx
 e/7UfnucF8MbcSGUAAAA=
X-Change-ID: 20261101-late-2026-vma-flags-461731a636c3
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
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442; i=ljs@kernel.org;
 h=from:subject:message-id; bh=dw144I8hKInR8Qv8iKnjrU9/3cK4949dnMwWVIcVGbg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF0a6K1vw5BxVPUqn46M6rZ32+yPLM/K3OK58Z/1t
 UlJ376qdZSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiQn8Y/scXBihtmHE7PkF4
 5fTvjHX5lf8yagzLot8b3ry68ZZUJgcjw8Jnxy6ELVt+JnMKc9vFq+wXXtq4lq3/3aB8muuMQpi
 TOR8A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Continue the conversion of legacy vm_flags_t flags to the new vma_flags_t
bitmap type.

Do some more core mm conversion (we really should be the first to
completely move to the new scheme :), but also update some mm-adjacent and
otherwise straightforward cases - /proc/$pid/maps and friends, the coredump
VMA dump size logic, uprobes, perf and LSM mmap/mprotect hooks.

This series only makes strictly mechanical changes to keep things gentle
during this very busy cycle.

No functional change intended.

Build tested on x86-64 (allmodconfig, each patch individually), i386,
arm64, riscv nommu and ppc64le.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (13):
      mm/gup: convert GUP code to use vma_flags_t
      mm/filemap: convert fault and readahead logic to use vma_flags_t
      mm/rmap: convert remaining VMA flag tests to use vma_flags_t
      mm/migrate: convert VMA flag tests to use vma_flags_t
      mm: convert THP VMA flag tests to use vma_flags_t
      mm/ksm: convert VMA flag tests to use vma_flags_t
      mm/madvise: convert madvise_vma_behavior() to use vma_flags_t
      mm: convert miscellaneous VMA flag tests to use vma_flags_t
      fs/proc/task_mmu: convert VMA flag tests to use vma_flags_t
      fs/coredump: convert vma_dump_size() to use vma_flags_t
      uprobes: convert VMA flag tests to use vma_flags_t
      perf: convert VMA flag tests to use vma_flags_t
      security: convert VMA flag tests to use vma_flags_t

 arch/powerpc/kvm/book3s_hv_uvmem.c | 10 ++++----
 fs/coredump.c                      | 16 ++++++-------
 fs/proc/task_mmu.c                 | 43 +++++++++++++++++-----------------
 include/linux/huge_mm.h            |  4 ++--
 include/linux/ksm.h                |  4 ++--
 include/linux/mm_inline.h          |  2 +-
 kernel/events/core.c               | 26 +++++++++++----------
 kernel/events/uprobes.c            | 12 ++++++----
 lib/test_hmm.c                     |  4 ++--
 mm/damon/vaddr.c                   |  2 +-
 mm/filemap.c                       | 24 ++++++++++---------
 mm/gup.c                           | 45 +++++++++++++++++++-----------------
 mm/hmm.c                           |  6 ++---
 mm/huge_memory.c                   | 32 +++++++++++++-------------
 mm/internal.h                      |  2 +-
 mm/khugepaged.c                    | 18 ++++++++-------
 mm/ksm.c                           | 22 ++++++++++--------
 mm/madvise.c                       | 47 ++++++++++++++++++++------------------
 mm/mempolicy.c                     |  4 ++--
 mm/migrate.c                       |  5 ++--
 mm/migrate_device.c                |  8 +++----
 mm/mmap_lock.c                     |  4 ++--
 mm/mremap.c                        |  2 +-
 mm/msync.c                         |  4 ++--
 mm/oom_kill.c                      |  4 ++--
 mm/pagewalk.c                      |  2 +-
 mm/rmap.c                          |  8 ++++---
 mm/vma.h                           |  4 ++--
 security/apparmor/lsm.c            |  2 +-
 security/integrity/ima/ima_main.c  |  2 +-
 security/ipe/hooks.c               |  2 +-
 security/selinux/hooks.c           | 14 ++++++------
 32 files changed, 202 insertions(+), 182 deletions(-)
---
base-commit: b61fa14ce6bcbba2cb9a96feea31b760226d6b43
change-id: 20261101-late-2026-vma-flags-461731a636c3

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

