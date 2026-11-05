Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914405;
	b=3I+5Khtq8mC3/YkJhKFLCjiP4zEZ8wW57o+R7aalVMF+Uqi3SZju+oRcsHBSyx7ejiw8
	 9RgRSDJ3/up/cpljamQuwKsldV123u6VJoLbpp1z8YwKhxGWAGoprPdjUJ4SGS2VfjQPE
	 OCw/mxOoQe5yPWnJ3PwRSYhJQgCYR0Ip09FaM7g+kdWtKnwrYddXDwZcaHXpUE/6OL+3R
	 vXZAkp1lLh88a6yPDCX+a9bVnTgRYgbB2NM5swMSF7u2zzCX8MxyPJhBeEO6gnorJY3X5
	 t82940B+/Ls2lxYDIewNQaAR6e/OPmzyMt8eVJSZg5NJ1D5FFjFW1y8KzbZEHuSAuNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914405;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=M0pYf4wz8leHRtACWiiE+5QjHFuiPzSaPBJ/BygPIB8=;
	b=c3dRxK74kbTEv0pYFzANVuHY/o3tT5iHZlquA+E51FRl63dDbxafOgFVvVyHKrEsQw6C
	 Ox/HxEiRb3A7RtzdD01az4Ain7Khpslg9zspIshgo+EaqS1LQ9xjCdOp+hL2OSBWi4MoW
	 1lYyJLXXpC2vcJ7D0I5ZmkWDfxPTxLJqTMmdqaLawE7C/UIMFfzv8ijwWXKrw0kFLfE74
	 O9tgaw47N0WXaOW+aF0OSLzzqOYwuSzyXa3nn3NvUMoEdJooUACX6GBUdbmwyeziOqffT
	 NBLJSARbAuf0C++zaKEzohhovADADjqKR1orLxjzHFvRL1v0XXKUVWHz3kdFxPkDKdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5vNiziv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D2606A326;
	Thu,  5 Nov 2026 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5vNiziv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308621F0089F;
	Thu,  5 Nov 2026 21:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914404;
	bh=M0pYf4wz8leHRtACWiiE+5QjHFuiPzSaPBJ/BygPIB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=B5vNizivHZEU1KoNI86QKGoZ078bEirUQPKmYN2ZC5I+UovaOMaR7kxE0je9fMD31
	 HaYi8+to8sOuLxjaZxifCqDxztBTi51kFe9a98XyXbRD7OtyoPxM0JS8X3xP1WR9GP
	 DTsGwu3IST4+RHoKgTvjk6pz1hf6DxiPyCgRkccebG1AFbChb4l83vlGjhM/clWVl8
	 RhZq/VTVtO9Df23SXK/dkkWy4uCF3qQAnYkttXvsPSoI/cqoIUuoj98/ILanad4VRj
	 NDdELiEC2TR27LnCIdX2sXR0YgorK/Nd1hWUOmKo1MF5O1lcbC/mKHbYP+rOVPk8li
	 2fYJIyFAm9KDA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:30:57 +0000
Subject: [PATCH 06/13] mm/ksm: convert VMA flag tests to use vma_flags_t
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
Message-Id: <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2315; i=ljs@kernel.org;
 h=from:subject:message-id; bh=xZlktZwJsOHuvEUJpFUKz3hiGmT/MeLFJ/LiKv6KqSo=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF0WIiXRO6NsUtnEorKsaV4B8YsNutOPhpzRcjw46
 8z2Q9vZO0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjAR4R5GhlO/r1jOXb2bl9X0
 /dHAF6kHI3p/3VSO9VAy1ryzcNKLZlOGfwpr7cIrqwPev3nt5SQX++zQYwdj5rQ3NdZbn1fZ/tw
 oyAgA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace use of the legacy vm_flags_t flags with vma_flags_t values where
KSM tests VMA flags directly.

The ksm_madvise() interface continues to take legacy flags for the time
being.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/ksm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index d6f736a1aa2f..61b772bba229 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -779,7 +779,7 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 	if (ksm_test_exit(mm))
 		return NULL;
 	vma = vma_lookup(mm, addr);
-	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma_has_anon_rmap(vma))
+	if (!vma || !vma_test(vma, VMA_MERGEABLE_BIT) || !vma_has_anon_rmap(vma))
 		return NULL;
 	return vma;
 }
@@ -1243,7 +1243,8 @@ static int unmerge_and_remove_all_rmap_items(void)
 			goto mm_exiting;
 
 		for_each_vma(vmi, vma) {
-			if (!(vma->vm_flags & VM_MERGEABLE) || !vma_has_anon_rmap(vma))
+			if (!vma_test(vma, VMA_MERGEABLE_BIT) ||
+			    !vma_has_anon_rmap(vma))
 				continue;
 			err = break_ksm(vma, vma->vm_start, vma->vm_end, false);
 			if (err)
@@ -2698,7 +2699,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		goto no_vmas;
 
 	for_each_vma(vmi, vma) {
-		if (!(vma->vm_flags & VM_MERGEABLE))
+		if (!vma_test(vma, VMA_MERGEABLE_BIT))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
 			ksm_scan.address = vma->vm_start;
@@ -2890,7 +2891,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 {
 	int err;
 
-	if (!(vma->vm_flags & VM_MERGEABLE))
+	if (!vma_test(vma, VMA_MERGEABLE_BIT))
 		return 0;
 
 	if (vma_has_anon_rmap(vma)) {
@@ -3027,7 +3028,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 
 	switch (advice) {
 	case MADV_MERGEABLE:
-		if (vma->vm_flags & VM_MERGEABLE)
+		if (vma_test(vma, VMA_MERGEABLE_BIT))
 			return 0;
 		if (!vma_ksm_compatible(vma))
 			return 0;
@@ -3484,7 +3485,7 @@ bool ksm_process_mergeable(struct mm_struct *mm)
 	mmap_assert_locked(mm);
 	VMA_ITERATOR(vmi, mm, 0);
 	for_each_vma(vmi, vma)
-		if (vma->vm_flags & VM_MERGEABLE)
+		if (vma_test(vma, VMA_MERGEABLE_BIT))
 			return true;
 
 	return false;

-- 
2.56.0

