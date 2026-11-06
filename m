Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948385;
	b=OZsACaXoKU2MzSnzdwOXGYNlgx3mrmLimQIk9ZnHvplbjzeIBpuKqNspogoSwS6AcTNX
	 onYanKBQ+MKgctqHY8Kg49G89VPZYvvtpb8k3umuGLCJEORap14qMr/KBFxyganlhSr/Q
	 CvNtMtMl16zix1pR11FtWNsw7MSjq5wnaGitIk+d42TrXeUCoqzWQpXHzyWNA/+aX6Ban
	 fVN4IGLqcc4t9rAAdrOqkDpmk0jjNpN9oZ+5by7TyfA6wcmna0PaDIFfq193/7/gWW0y4
	 qCSg5V/9cJjFVDcB9cQi1xn6zTC34jlFLzRZ7yH/Kl1ZW6n5qAPLQNBRiAUwD/GniTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948385;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OcOt4PX0tQHzNhn0VTU6sv5KTaqGga1IVFO+qQedORk=;
	b=Y7QBziPtSkSvUnyzhODqCZu/m+WPfMwrYjGD2fF9r1n6Lx8tMQ3H7I0okNlqojJ6du8p
	 HN8qGT2e3HqTAdVVoIyA4QWWbjLW48YywH/EezUxqPK0FmK5Er+jorJWCgdEzEXnQIlm2
	 1uUP4eof6iD8LjlaBHHnY3r53jCiDckO/JNK8TcqKtaEupNssXSSEcTRMJMO6Qe1N1aUX
	 kDfzm/pTnr8K+5WR5dhE4rLK6DMGCTK/brbi/lWgfL6B/yIK5daYqcEL6+Nm18gf0y5Bv
	 7MmSqeiFyf3U7/IwjFZ1PcIk3ddi8IyOd1JbpXnTbsr34nfi/bd5QG3dmIdb6viHm0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OQ135yXp;
	arc=none smtp.remote-ip=91.218.175.189
Received: from mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95452606A32D
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 06:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95452606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OQ135yXp
X-Envelope-To: selinux@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3ZBSNl6NQMmaNPPXZuPSoh3zWTH6z/X2ys0Il7SoJQY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793948377; v=1; x=1794553177;
 b=OQ135yXpIr2On9kCLVcHKB66wbY/9XnE9jgMuylMZcxWnBg5ejs0kivZuG+F9TF6SeHGvSey
 C4aZPBJ4rDvrdNQCQPzJX5Tic26erGhCz+6ro6sEZmxIwShxbUh3TDBgl2iAKb4OaPRne0rHMDF
 iyvVr3VG6p1Pa9Ztn1FmynAk=
X-Envelope-To: selinux@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fab8f084cc4903d4;
	Fri, 06 Nov 2026 06:59:35 +0000
X-Mizu-Trace-ID: fab8f084cc4903d4
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	willy@infradead.org,
	jack@suse.cz,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	pfalcato@suse.de,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	leon@kernel.org,
	sj@kernel.org,
	rakie.kim@sk.com,
	rientjes@google.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	wufan@kernel.org,
	stephen.smalley.work@gmail.com,
	omosnacek@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH 09/13] fs/proc/task_mmu: convert VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 14:59:25 +0800
Message-ID: <20261106065925.50906-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-9-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-9-0d3cd15ab75f@kernel.org>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Nov 05, 2026 at 09:31:00PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values where
>VMA flags are tested directly in /proc/$pid/[s]maps, pagemap, clear_refs
>and PROCMAP_QUERY.
>
>In replacing vm_flags_clear() (which takes the VMA write lock) with
>vma_clear_flags() (which does not) in clear_refs_write(), we explicitly
>write lock the VMA. The mmap write lock is already held at this point.
>
>The show_vma_header_prefix() and show_smap_vma_flags() output functions and
>the thp_vma_allowable_orders() call continue to use legacy flags for the
>time being.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---
> fs/proc/task_mmu.c | 43 ++++++++++++++++++++++---------------------
> 1 file changed, 22 insertions(+), 21 deletions(-)
>
>diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>index 22361607020d..b6e8ef15e40e 100644
>--- a/fs/proc/task_mmu.c
>+++ b/fs/proc/task_mmu.c
>@@ -569,18 +569,18 @@ static struct vm_area_struct *query_matching_vma(struct proc_maps_locking_ctx *l
> 
> 	/* VMA permissions should satisfy query flags */
> 	if (flags & PROCMAP_QUERY_VMA_FLAGS) {
>-		u32 perm = 0;
>+		vma_flags_t perm = EMPTY_VMA_FLAGS;
> 
> 		if (flags & PROCMAP_QUERY_VMA_READABLE)
>-			perm |= VM_READ;
>+			vma_flags_set(&perm, VMA_READ_BIT);
> 		if (flags & PROCMAP_QUERY_VMA_WRITABLE)
>-			perm |= VM_WRITE;
>+			vma_flags_set(&perm, VMA_WRITE_BIT);
> 		if (flags & PROCMAP_QUERY_VMA_EXECUTABLE)
>-			perm |= VM_EXEC;
>+			vma_flags_set(&perm, VMA_EXEC_BIT);
> 		if (flags & PROCMAP_QUERY_VMA_SHARED)
>-			perm |= VM_MAYSHARE;
>+			vma_flags_set(&perm, VMA_MAYSHARE_BIT);
> 
>-		if ((vma->vm_flags & perm) != perm)
>+		if (!vma_test_all_mask(vma, perm))
> 			goto skip_vma;
> 	}
> 
>@@ -647,13 +647,13 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
> 	karg.vma_end = vma->vm_end;
> 
> 	karg.vma_flags = 0;
>-	if (vma->vm_flags & VM_READ)
>+	if (vma_test(vma, VMA_READ_BIT))
> 		karg.vma_flags |= PROCMAP_QUERY_VMA_READABLE;
>-	if (vma->vm_flags & VM_WRITE)
>+	if (vma_test(vma, VMA_WRITE_BIT))
> 		karg.vma_flags |= PROCMAP_QUERY_VMA_WRITABLE;
>-	if (vma->vm_flags & VM_EXEC)
>+	if (vma_test(vma, VMA_EXEC_BIT))
> 		karg.vma_flags |= PROCMAP_QUERY_VMA_EXECUTABLE;
>-	if (vma->vm_flags & VM_MAYSHARE)
>+	if (vma_test(vma, VMA_MAYSHARE_BIT))
> 		karg.vma_flags |= PROCMAP_QUERY_VMA_SHARED;
> 
> 	karg.vma_page_size = vma_kernel_pagesize(vma);
>@@ -970,7 +970,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
> {
> 	struct mem_size_stats *mss = walk->private;
> 	struct vm_area_struct *vma = walk->vma;
>-	bool locked = !!(vma->vm_flags & VM_LOCKED);
>+	bool locked = vma_test(vma, VMA_LOCKED_BIT);
> 	struct page *page = NULL;
> 	bool present = false, young = false, dirty = false;
> 	pte_t ptent = ptep_get(pte);
>@@ -1017,7 +1017,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
> {
> 	struct mem_size_stats *mss = walk->private;
> 	struct vm_area_struct *vma = walk->vma;
>-	bool locked = !!(vma->vm_flags & VM_LOCKED);
>+	bool locked = vma_test(vma, VMA_LOCKED_BIT);
> 	struct page *page = NULL;
> 	bool present = false;
> 	struct folio *folio;
>@@ -1728,7 +1728,7 @@ static int clear_refs_test_walk(unsigned long start, unsigned long end,
> 	struct clear_refs_private *cp = walk->private;
> 	struct vm_area_struct *vma = walk->vma;
> 
>-	if (vma->vm_flags & VM_PFNMAP)
>+	if (vma_test(vma, VMA_PFNMAP_BIT))
> 		return 1;
> 
> 	/*
>@@ -1798,9 +1798,10 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
> 
> 		if (type == CLEAR_REFS_SOFT_DIRTY) {
> 			for_each_vma(vmi, vma) {
>-				if (!(vma->vm_flags & VM_SOFTDIRTY))
>+				if (!vma_test(vma, VMA_SOFTDIRTY_BIT))
> 					continue;
>-				vm_flags_clear(vma, VM_SOFTDIRTY);

vm_flags_clear() still warns on VM_SOFTDIRTY when pgtable_supports_soft_dirty()
is false. Did you mean to drop that?

(Vaguely recall you weren't too keen on that warn, though I could be wrong.)

Otherwise, LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
