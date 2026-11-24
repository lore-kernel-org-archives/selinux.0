Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540100;
	b=FsocQdSgYBIhkNgfhQSFsLAJlmvM4CmIz7YytcUorNTV7bmmTGemOnUmqe3tvSei0NHb
	 IGiZXofQ8lkEELFxWAYkCWC1M9pCfK0HpdPM+7t2uDjOsgYaabUzt39Q7vL59netablsq
	 Smu5j/MB9aEuyZtdpCXZRArY2WMqvsC2mYguILF1STYdLrs25n3HCfquAX1o4CO6+5TMx
	 H/5oL55pDq5NFJd1e/xPia0Wo6rm5AmJmbSWNFaG1WswyGvAqj4wnMRom/1eF6wjzBgEx
	 MJtsSrpuNErFiXbbouf9uLzzQDUlZiTCWjxxDcAYtNb9eHTAkhPF0Fd/H+HJZqyfTlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540100;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=aqZtH0oPe0w0iyR81y6Fx2M9m70KmY8puMtxeRbq+2o=;
	b=eN3mvG51YrPXYxCwEsUdFDQhRvKF5RUCAPwz3xUajZT9AlaSP7ytZR7LeVe03XrAHqNB
	 JCL3TXPq2NuQEz2/iuVdVq3q83+202AnXLpZI10E5BRjaaO1iGFUQhE2irB65D1DDP0rD
	 PMD8Cplg2lc6yLeWg9GIvV+8GcDA6oqio3v3sTt37iYIYiaGFSxuFxa9ebHS07kKwU1Ph
	 yHoknUI3+8CCbMqdUjain/Z9LcMP2GZ1LrEG1kRhLLnfL6TMmtSWr4m44SZ4HuJe8qmbe
	 yk/zX0Q6OFjcgyXx0ze7yUD/11+lIh0WmCeokTuJWWajOxQWMtPs6G6SykJWG8jLD+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCuJxO6J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7F606A69D;
	Tue, 24 Nov 2026 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCuJxO6J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B29B1F000D1;
	Tue, 24 Nov 2026 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540099;
	bh=aqZtH0oPe0w0iyR81y6Fx2M9m70KmY8puMtxeRbq+2o=;
	h=From:Subject:Date:To:Cc;
	b=VCuJxO6Jjypj5DbUmhoytQziZJ5vLJGTNMNo3cqRxIUYh8Jzq3skhseCD0u5fRyjP
	 C/2WEanKtLteavWso/oU3UJ6UtR3j3y9fK26/Wq6ytkGMpgt3chyo6ZXZEhXOKNaw5
	 OJMyuJjnDYiBEsWgq3CJ337r7u+4G0BQSS+X4PEGurGZ29cGJXvYGBp2B0mKK810FW
	 ftHg7joprB1aheUbxHOLTyL6VRQThAY1CflxS92AdC+zCo1MDGX49CRqEYciw8D45w
	 OC/jVpT6VeMvEyweIbi7je9qiB2n4OB0NEcoB8q+V0O4UJwKh+CmIRZljhTIuC+2Js
	 dix6TOTy+6I+w==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v2 00/11] mm: continue vma_flags_t conversion
Date: Tue, 24 Nov 2026 17:07:52 +0000
Message-Id: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/23NQQqDMBCF4auEWTslY2oEV71HcZHqGEPTRBIJL
 eLdi0J3Xb5/8b0NMifHGTqxQeLisosBOlFXAobZBMvoRugE1LLWRJLQm5XxWFheBidvbMarpla
 R0UoPCioBS+LJvU/13lcCZpfXmD7nSaGj/rzmr1cIJcpRDSM15tE20+3JKbC/xGSh3/f9CwLCI
 fm3AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3964; i=ljs@kernel.org;
 h=from:subject:message-id; bh=AxeX6Zqxak7Ff0FGtjI8UQufUYyumqYNiaGRAt4jiII=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZj+RGMUybXCrDUp937eOZY1FXjoUfd2jjdDu7MHppi
 7fD9B0hHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZiI6VSGf6by2nvdT2svNv3G
 a5Ie3p2yXP+50sy7123nv02taTp4R4yRoVPqlDxHDnfXbUEO7UKVGzOvXZxuWuvsdc7h0sMltT1
 /uAE=
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
v2:
* Dropped what were 1/13, 3/13, 4/13, 5/13 and 6/13, as David has taken
  these through mm/core.git.
* Rebased on mm-new.
* Updated 1/11 (was 2/13) to read VMA_RAND_READ_BIT before
  maybe_unlock_mmap_for_io() can release the fault lock, avoiding a
  use-after-free of the VMA, and to remove the now-shadowing inner VMA
  declaration, as per Sashiko and Andrew.
* Updated 2/11 (was 7/13) to drop an unrelated whitespace change in
  mm/ksm.c and to fix up the indentation of touched lines, as per David.
* Updated 3/11 (was 8/13) to retain the shadow stack check since added to
  hmm_vma_walk_test().
* Updated 4/11 (was 9/13) commit message to note that the soft-dirty
  assert in vm_flags_clear() is intentionally dropped, as per Lance.
* Split what was 13/13 into per-LSM patches 8/11 to 11/11, as per Paul.
* Propagated tags, thanks everyone!

v1:
https://lore.kernel.org/r/20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org

---
Lorenzo Stoakes (ARM) (11):
      mm/filemap: convert fault and readahead logic to use vma_flags_t
      mm/madvise: convert madvise_vma_behavior() to use vma_flags_t
      mm: convert miscellaneous VMA flag tests to use vma_flags_t
      fs/proc/task_mmu: convert VMA flag tests to use vma_flags_t
      fs/coredump: convert vma_dump_size() to use vma_flags_t
      uprobes: convert VMA flag tests to use vma_flags_t
      perf: convert VMA flag tests to use vma_flags_t
      selinux: convert VMA flag tests to use vma_flags_t
      apparmor: convert VMA flag tests to use vma_flags_t
      ima: convert VMA flag tests to use vma_flags_t
      ipe: convert VMA flag tests to use vma_flags_t

 arch/powerpc/kvm/book3s_hv_uvmem.c | 10 ++++----
 fs/coredump.c                      | 16 ++++++-------
 fs/proc/task_mmu.c                 | 43 +++++++++++++++++----------------
 include/linux/huge_mm.h            |  4 ++--
 include/linux/ksm.h                |  4 ++--
 include/linux/mm_inline.h          |  2 +-
 kernel/events/core.c               | 26 ++++++++++----------
 kernel/events/uprobes.c            | 12 ++++++----
 lib/test_hmm.c                     |  4 ++--
 mm/damon/vaddr.c                   |  2 +-
 mm/filemap.c                       | 26 ++++++++++----------
 mm/hmm.c                           |  6 ++---
 mm/internal.h                      |  2 +-
 mm/khugepaged.c                    | 10 ++++----
 mm/ksm.c                           |  8 +++----
 mm/madvise.c                       | 49 ++++++++++++++++++++------------------
 mm/mempolicy.c                     |  4 ++--
 mm/mmap_lock.c                     |  4 ++--
 mm/mremap.c                        |  2 +-
 mm/msync.c                         |  4 ++--
 mm/oom_kill.c                      |  4 ++--
 mm/pagewalk.c                      |  2 +-
 mm/vma.h                           |  4 ++--
 security/apparmor/lsm.c            |  2 +-
 security/integrity/ima/ima_main.c  |  2 +-
 security/ipe/hooks.c               |  2 +-
 security/selinux/hooks.c           | 14 +++++------
 27 files changed, 139 insertions(+), 129 deletions(-)
---
base-commit: 5bd93e4b0b357e9d0a13199887aacbf04d1ce216
change-id: 20261101-late-2026-vma-flags-461731a636c3

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

