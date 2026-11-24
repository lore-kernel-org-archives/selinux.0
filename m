Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540206;
	b=k+QChindhXrMW3G6nLkzgyyslFNyAWpMa6zipk92r/pOQpDaUxuboqhwmDYBAfQY6UlU
	 uwTlV5qqmbllwwAupXkFebYXIBYsSLQPTdnYkd5gIeGgT1kOiK3HX+7fL3e6bHy+Uo6k0
	 3rfBdx6ME79AMqMm09jx7gR9tLC7T+x28M55lal7o5H4nv/jwKW6nW632P5XgHpd7e3jX
	 CvX1F79kAP6ODevJHsVa8Qv7U1V8Arg48Hl9Gpw3rkqEBzhFgRjUQvwPpB/NRzb5oILO9
	 F8TXzracB9chGnG0E4aP3pJIIzKARTNM/uv0s4DMMLiuoW5XoUs6xKk9/6lWkWIqLpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540206;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7BfAuLs5fYXyjLRJaP4J35OcPZOVShOsa819UoKcWjs=;
	b=iQTIf637+dzM5VG2mt2ORSfTfa9AhnUWW1j9gYvX22Obmocciqcbdz1ao+MdL/8Br3iy
	 R4faqWRi1jr2jqDQ1+1vuhh6FPXSLahJYpnCw9laj/sfIm/DckqWUcaFiwD1d/h0hGjUm
	 L+zoUDhCeaKXzqjvN68f5ZfkIqdvTSScnr842QMLwAcH5gt+oeQG5rQo0reTgFbQfcdvo
	 fLwb7rNToPfZrAg4c+edbisJCKf/+e6uUdd4la2w8TLx5nhHGUB+QiWcWFpxqrqqLJUlc
	 KqceFTA2uVy97PSdGNKKE6NLilnXsfdIthoXKffv/xfHC8OogYtgnrdE3OBPRb3Advw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ooj2ovVT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078D606A334;
	Tue, 24 Nov 2026 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ooj2ovVT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E901F000C4;
	Tue, 24 Nov 2026 17:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540205;
	bh=7BfAuLs5fYXyjLRJaP4J35OcPZOVShOsa819UoKcWjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ooj2ovVTmndPb21WMMkefT7zJJ296GKzaQQwA7OSz+P9P5NsjXGtMoQOp6MXLWAw2
	 iSb9ECRw4cHiATf6umuVL/Qlk1Fg1BU8cHDGtgeiSU2ji2uJHeazMZ7GWcoScx2fdu
	 +saz+nxNuR/KSeEnIPWzDGn5NqbIhdjC+EOPF3itD/iSVWi29ZU9UBxX9DWODDiZ+I
	 FT1GLy8eStMdGwjkTTzc/sidjfzdReEJy+l+Xrcb5MSbygV41OLtcDwBOUKlnosu69
	 wcHKUxMVAKjIiaWQ9415xaWrs3p2jdFR52jweWGzWRSvFhU/GIeUdGj6PLKkbIoK3o
	 42SeSi0fVH/ww==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 17:07:57 +0000
Subject: [PATCH v2 05/11] fs/coredump: convert vma_dump_size() to use
 vma_flags_t
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
Message-Id: <20261124-late-2026-vma-flags-v2-5-bf3fade93064@kernel.org>
References: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
In-Reply-To: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2643; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Dq3Cj8/uILUj0bBwtTXEJX6gkCMVPmmLF1KGw4GhyTc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZj+SdndrQfqTp0l/v6eJV21q33dr8+NoDw5jpkpMdt
 081mSfN0VHKwiDGxSArpsjy/Iv4/iCRsHmdF/zdYOawMoEMYeDiFICJiNczMny+kui0+8w2/VXh
 HQfEqxqrpmrM5pnFJ1i3975yg9ALlsuMDA1TH65earIpKXnRVu+ycOVGTgejhWt5vd/ffBT+KWx
 uKBsA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace use of the legacy vm_flags_t flags with vma_flags_t values when
determining how much of a VMA to dump.

The flags copied into struct core_vma_metadata remain legacy flags as they
are consumed by the binfmt handlers.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
---
 fs/coredump.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 82ef9d115999..d842cf6a30df 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1837,15 +1837,15 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 	if (always_dump_vma(vma))
 		goto whole;
 
-	if (vma->vm_flags & VM_DONTDUMP)
+	if (vma_test(vma, VMA_DONTDUMP_BIT))
 		return 0;
 
 	/* support for DAX */
 	if (vma_is_dax(vma)) {
-		if ((vma->vm_flags & VM_SHARED) &&
+		if (vma_test(vma, VMA_SHARED_BIT) &&
 		    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, DAX_SHARED))
 			goto whole;
-		if (!(vma->vm_flags & VM_SHARED) &&
+		if (!vma_test(vma, VMA_SHARED_BIT) &&
 		    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, DAX_PRIVATE))
 			goto whole;
 		return 0;
@@ -1853,21 +1853,21 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 
 	/* Hugetlb memory check */
 	if (vma_is_hugetlb(vma)) {
-		if ((vma->vm_flags & VM_SHARED) &&
+		if (vma_test(vma, VMA_SHARED_BIT) &&
 		    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, HUGETLB_SHARED))
 			goto whole;
-		if (!(vma->vm_flags & VM_SHARED) &&
+		if (!vma_test(vma, VMA_SHARED_BIT) &&
 		    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, HUGETLB_PRIVATE))
 			goto whole;
 		return 0;
 	}
 
 	/* Do not dump I/O mapped devices or special mappings */
-	if (vma->vm_flags & VM_IO)
+	if (vma_test(vma, VMA_IO_BIT))
 		return 0;
 
 	/* By default, dump shared memory if mapped from an anonymous file. */
-	if (vma->vm_flags & VM_SHARED) {
+	if (vma_test(vma, VMA_SHARED_BIT)) {
 		if (file_inode(vma->vm_file)->i_nlink == 0 ?
 			    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, ANON_SHARED) :
 			    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, FILE_SHARED))
@@ -1890,7 +1890,7 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 	 * dump the first page to aid in determining what was mapped here.
 	 */
 	if (COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, ELF_HEADERS) &&
-	    vma->vm_pgoff == 0 && (vma->vm_flags & VM_READ)) {
+	    vma->vm_pgoff == 0 && vma_test(vma, VMA_READ_BIT)) {
 		if ((READ_ONCE(file_inode(vma->vm_file)->i_mode) & 0111) != 0)
 			return PAGE_SIZE;
 

-- 
2.56.1

