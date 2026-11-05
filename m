Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914499;
	b=KfandFLcFqiLDq1rZ5QlS5T2XYzyKvj60nOYKr+bSxeumNV7s6PJcPXPT8mkKJz6s2q9
	 2F/7oFljJBUkOqdY87pEXcVGC1VaGjoTdQs5PODxLwzH9LBdsiAtnf/TB0Hz1oL83A80M
	 eyrwaI0Rlalv5Ccu/y9v0A/gK87oVKag+bCalnvlO5218zzP99vzLVR2n5+PyNX7X//U6
	 d1gQmBSDHOKUNC4K9izL73Dvlurp9XBDrnQp7tQ7NLwGhxgTKdFbJTAO7hDv0jC0HDep9
	 WORARTjCNEnjoAfwHrhHWn9n5Exz3FmUB0KEGIvrSYH8m05gRoE7E7wFLIQppl+6SRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914499;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qqj13y74wygWSmayTPQ4iPMQc3qMQDiKbXhB7QOG+mA=;
	b=B7ndyBCcT4g2a/39RffxbcxPmqot+3Q9PPfzdWjUICgS4LmBWlpazXvpekMKLos8MCPa
	 uGvc6q+8Le1m5ac3t/VkRAPExN1EkZM2WAGFoMYtE8frn5DE4ZVp3O/YuIPk+zXyLpzbt
	 1H7JjO4/F+DJtsyTt8yjBho0+NIpVlWuAgSnBo3rczIvPzvukVcVFDlH32FpcwB+F6q/f
	 9851lmddshqtmoGMZMDSGHHuKsUebZfSeIXuHUjQfesXnGyfYsnANolDg7foPdLOsCaZu
	 O/s3qVwtW3z6NmCIjcI/vYqELWYMUaNb5jbpsuiGf53YJ7WZq793kLADawereBvntMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOZXMwFI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CB0606D826;
	Thu,  5 Nov 2026 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOZXMwFI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9141F008A1;
	Thu,  5 Nov 2026 21:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914498;
	bh=qqj13y74wygWSmayTPQ4iPMQc3qMQDiKbXhB7QOG+mA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VOZXMwFIw55C/gyPpTFMi958v5mx5VT01snh2SA64awr2LbAScNTljXqXSrQYbiaj
	 RV7VVW31Dx8nplzx5bLpirryInTRUpJmwDuUPaNOi6NwGChrxsBejRvOPhE5vzrmJ2
	 ibB0WxGC99Icwc9mBMBIppQkz1ran+hYIvyuZ4PTP3ux4GpCm65RxCnOqccO9/vgpG
	 eRfxWbVn1No9ze31mWcWL6lZD7fySHk5wdGW1jeOrPye/O/Pj3QoJ1UW5d9HjYbgmj
	 2HgBTfIoWS+TgTiWFCZVz1fU08DAIAnlltZ+zA7aS+qglKIsghb0mEocg3yKJD+pla
	 d9oPt5DuR8UWw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:31:02 +0000
Subject: [PATCH 11/13] uprobes: convert VMA flag tests to use vma_flags_t
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
Message-Id: <20261105-late-2026-vma-flags-v1-11-0d3cd15ab75f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835; i=ljs@kernel.org;
 h=from:subject:message-id; bh=sx5WtkIScURFA/l2IshQG5M9gB0ax8rL7dz98vBV9Zo=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF3eVuN07XEeXyib4EmPkM7Sa2Z/rntYCu7v4hb7V
 5x45sWBjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAExE7hwjw6WJvcWcrAdvuDPP
 e6O7Imh6UszvHqsA8T/ftk6Jmpx715nhn+Em9YjI13G6KxckMRb13g42Wvfv2zy17kdn4jfarqq
 RZQMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
uprobes VMA validity checks.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 kernel/events/uprobes.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index caf444762a27..853fc952331c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -134,12 +134,14 @@ static void uprobe_warn(struct task_struct *t, const char *msg)
  */
 static bool valid_vma(struct vm_area_struct *vma, bool is_register)
 {
-	vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
+	vma_flags_t forbidden = mk_vma_flags(VMA_HUGETLB_BIT,
+					     VMA_MAYSHARE_BIT);
 
 	if (is_register)
-		flags |= VM_WRITE;
+		vma_flags_set(&forbidden, VMA_WRITE_BIT);
 
-	return vma->vm_file && (vma->vm_flags & flags) == VM_MAYEXEC;
+	return vma->vm_file && vma_test(vma, VMA_MAYEXEC_BIT) &&
+		!vma_test_any_mask(vma, forbidden);
 }
 
 static unsigned long offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
@@ -286,7 +288,7 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 	return uprobe->ref_ctr_offset &&
 		vma->vm_file &&
 		file_inode(vma->vm_file) == uprobe->inode &&
-		(vma->vm_flags & (VM_WRITE|VM_SHARED)) == VM_WRITE &&
+		vma_test(vma, VMA_WRITE_BIT) && !vma_test(vma, VMA_SHARED_BIT) &&
 		vma->vm_start <= vaddr &&
 		vma->vm_end > vaddr;
 }
@@ -1607,7 +1609,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 		return 0;
 
 	if (vma->vm_file &&
-	    (vma->vm_flags & (VM_WRITE|VM_SHARED)) == VM_WRITE &&
+	    vma_test(vma, VMA_WRITE_BIT) && !vma_test(vma, VMA_SHARED_BIT) &&
 	    mm_flags_test(MMF_HAS_UPROBES, vma->vm_mm))
 		delayed_ref_ctr_inc(vma);
 

-- 
2.56.0

