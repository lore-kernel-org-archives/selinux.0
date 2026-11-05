Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914352;
	b=LsqtQ/ISC9BgZKVhUtfn6h3l1nvcu2iFDxC57SfyXAIh98Jp+fxs0Qy+H19npmXhMORd
	 prW2DfP7k5naT9C24/pidyBI4+ENEO8byeiKCbTS/Z+OVD2vlXMBsK2Ml9r206LemudHt
	 G0xfBuDN3r88HkZzkdfwUTAsgRZ+u9UPf/TiNQmHHhc5CqRurGzMiUUTXwsqHHksnEqps
	 gKahjtvzq7GXkMV3Mf8Cx78Go5xYiQs2zSx6QO7b18iu9uAdVRX8O9COxWdGFFolgRZQQ
	 wARrDO+/KoAxsguog3rRHtRv232qzd8oMPsQeeJBf6Uq68XBBG2T8OrdzLzqnKvuxZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914352;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=R9gbDgDsUJAtxTTttS67Zy6QBKff1k+BGmZ9q8ms4as=;
	b=Co39tcOffLJ1luXR2dzQtR9yFmDd36deoNxbxlqV+TaR2iBHAZ1M6k1wQMXg64uny3fn
	 FccmzNQsy6P4eKOw59wVu52pI8idCCARueBsyqneq4ctTnK6QwRuFLW9w6OOOrHYKqcD8
	 YidEVFjR0b3WrXJoyhqiHP7ETcFMakwyltblFtFiyXZvdk7EakCfcQmA+90F7z7DiCh1C
	 +O/4Ik77PAcsXYwJw7EQmGecquuR0AwnwJhB9xmcOj1YJeHBZ+lgRhg/u881of37iUwfA
	 AHc2d5nO4uDbtEEqJJm7dE0fD+sTxxSrTDKSbF0RD+JwUEIA+sj6DXGLZWKfAAKLDqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkIx7WqT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE920606A32C;
	Thu,  5 Nov 2026 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkIx7WqT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CD71F008A1;
	Thu,  5 Nov 2026 21:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914351;
	bh=R9gbDgDsUJAtxTTttS67Zy6QBKff1k+BGmZ9q8ms4as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZkIx7WqTlWLTCBt9NpIoUSUzWdaGj1sZTB/NJl369icVHSJO1jDaGZYx9ZI0V3ngf
	 NS/Z25C5Vs19d6ihk3w8C7/oUqqe7K1X+FB3u7R9B4uFGPgsZ4o0NBNDpRc2THUVb3
	 YkarJXljffQrrFjkCSeJk3R7eEWO27dzmcz7apYY0Nmwm6IP1anOsY1CUhI73l3eJ4
	 CRpGJYjjhMGN2rrNn3vNOs2zqyDLTDI5G6ndMz8NUUszR2XbiFwVcW4PxtfSNJPcO7
	 RIKm77NsGvQDigbGTMtdIKn8KwNNkqm7Sk4pc7DPIzfEkdFiNAbLMI/R2RkXQqgwh8
	 3vRlOOITx0Kiw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:30:54 +0000
Subject: [PATCH 03/13] mm/rmap: convert remaining VMA flag tests to use
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
Message-Id: <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=ljs@kernel.org;
 h=from:subject:message-id; bh=eZl8Nv0dTN3HlhfbDsqgjylQKfweYHLkfOK2djhDL8M=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF1mJfT2QdPRhoV88qcu77rHLbdvR7JH9HZHWcvUt
 Zb/rtkxdpSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAin+8wMvSLM4R/t0nQTnVV
 f612NLDw5tS57Hc6+SZ6ftJWcE8sW8rwT2vzspehQh9PXindsm3+zgqliazNBicUtrCbn1vpy7J
 0OgsA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace the remaining uses of the legacy vm_flags_t flags in the rmap logic
with vma_flags_t values.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/rmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1131b76bbbc2..cdc97fec8586 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1196,7 +1196,7 @@ static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
 
 static bool invalid_mkclean_vma(struct vm_area_struct *vma, void *arg)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_test(vma, VMA_SHARED_BIT))
 		return false;
 
 	return true;
@@ -1660,7 +1660,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	 * VM_DROPPABLE mappings don't swap; instead they're just dropped when
 	 * under memory pressure.
 	 */
-	if (!folio_test_swapbacked(folio) && !(vma->vm_flags & VM_DROPPABLE))
+	if (!folio_test_swapbacked(folio) &&
+	    !vma_test_single_mask(vma, VMA_DROPPABLE))
 		__folio_set_swapbacked(folio);
 	__folio_set_anon(folio, vma, address, exclusive);
 
@@ -2094,7 +2095,8 @@ static bool ttu_anon_lazyfree_folio(struct vm_area_struct *vma,
 	 */
 	smp_rmb();
 
-	if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
+	if (folio_test_dirty(folio) &&
+	    !vma_test_single_mask(vma, VMA_DROPPABLE)) {
 		/*
 		 * redirtied either using the page table or a previously
 		 * obtained GUP reference.

-- 
2.56.0

