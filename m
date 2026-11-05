Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914535;
	b=Fm2TC233qgydgvKbnHCNpxzBtFJT45uLNb0d8dEXsS/v7ti91NA7707YodbTY3j757hq
	 RE2rc71jfvqfdD6pz/UQbgNlBdTOab/E3tS0B6puIacoCzTiENXcFc5CX0JgksxrgyYcL
	 P/efIIre8ZFdv7zndllli4jNXXHtMPWSpA9KZZLq+ptar6cm6f+mMwA71idL3/e8wYG0y
	 HY4hwPsV+GQZ5w4a4LO8kkjcdXeqUnCd82z5ykiKJz5ezar8DdqLURKb5olM5mbFE+Hg4
	 wp7EVTzEzis1aypT4iz/srrR6TJtN9g2BvX9noOVyMHWp23Vt8ehrx7J577n/CuwESw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914535;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=y5JuvNnNeOh9oIZYUQiD2mrwwH6GN2Nh0rxsj2kJwUo=;
	b=l6frx3hnJLDSXtybGQ7uZ3eM386xXaMIyIS6iqS2JZhbuxE+/y86sbkDSpw3jvdZiArQ
	 r9awEb/saDBZ87GlX7VaAwhL3qCdQ3qIRvubKZ+iZP4muVdcRJljQSq8zv1nWsBroJ7yk
	 Y63e2VaR6qcc1EuN3SsAmO05DZ7mnsexrrsqhcgnbW+/S0iZS2UBFnvOGlHTtoffWJVI3
	 xaVNVykzX3NdOxy5WIK/or/NyeDzwKK8bgOLWjwrM/qcPXJPN0GMLFNbFGtGKboJmJ/j1
	 Tldt+k6UbEdEIp9niyvMVyIEeZplQK58O9UWCuD6EG9jRnu2XN7kSCXxtSU5J1SoA3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7WzdCq4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F482606EEB4;
	Thu,  5 Nov 2026 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7WzdCq4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89E21F008A1;
	Thu,  5 Nov 2026 21:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914534;
	bh=y5JuvNnNeOh9oIZYUQiD2mrwwH6GN2Nh0rxsj2kJwUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=R7WzdCq4szIDwvRrpAHhITrD0LMGL2Ayr/ooKvmMdyGasXQKDcBboripakmO01VxQ
	 YV6gWg3WzYXJGaP9RBXms9q1o/TSZwVLLaVEZfqLw0xiVgCNumabu3VK3l05YjGAQ2
	 46aaByM/B5ZaXGXlsVEhPqLim2HZXmKUrYtuwr1dNrHF5yB482YZP9OW2Jtvu422ao
	 6Tt1yTUQ1HqeI4mlyuzXFRXgFr1sp/lZYoZRhG5yDHjZjw0XlC4zm1FOELcAb2B6lS
	 fn9rEaS0KIp/p1dGwSwtWV76kVBTvwe1On76u9GWkFrWldtHLna5zrVfRdVYH5SYVu
	 GuO5/2y1sU0NA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:31:04 +0000
Subject: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
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
Message-Id: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3517; i=ljs@kernel.org;
 h=from:subject:message-id; bh=mMkVa3Aus9iq3GDDk7CXNqU7B+d35DdB8d1OJciXJ/o=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF0x/4mS2NVe3nd/9p3ZfnzOaYGJvjo5O8+kJ13ud
 1ZPNlAr7ChlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBE5Ccz/PeSFiq94GRiJT4r
 cM9y7UAJQ5np05894OaeezEhc0k9mwIjw9qZtm6zPV99FD/eVGBjuExiZXPoVpMpufynsmSe/N6
 dxwEA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 security/apparmor/lsm.c           |  2 +-
 security/integrity/ima/ima_main.c |  2 +-
 security/ipe/hooks.c              |  2 +-
 security/selinux/hooks.c          | 14 +++++++-------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c73681d820a0..00099a32b3f6 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -590,7 +590,7 @@ static int apparmor_file_mprotect(struct vm_area_struct *vma,
 				  unsigned long reqprot, unsigned long prot)
 {
 	return common_mmap(OP_FMPROT, vma->vm_file, prot,
-			   !(vma->vm_flags & VM_SHARED) ? MAP_PRIVATE : 0);
+			   !vma_test(vma, VMA_SHARED_BIT) ? MAP_PRIVATE : 0);
 }
 
 #ifdef CONFIG_IO_URING
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index fed80da3ee09..92032afe4cd1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -556,7 +556,7 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 
 	/* Is mprotect making an mmap'ed file executable? */
 	if (!(ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
-	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
+	    !(prot & PROT_EXEC) || vma_test(vma, VMA_EXEC_BIT))
 		return 0;
 
 	security_current_getlsmprop_subj(&prop);
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index d878b52ceec8..247b07748b1d 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -112,7 +112,7 @@ int ipe_file_mprotect(struct vm_area_struct *vma,
 	struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
 
 	/* Already Executable */
-	if (vma->vm_flags & VM_EXEC)
+	if (vma_test(vma, VMA_EXEC_BIT))
 		return 0;
 
 	if (prot & PROT_EXEC) {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6168dd5f91c2..1bf78c2a6aba 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4206,16 +4206,16 @@ static int selinux_mmap_backing_file(struct vm_area_struct *vma,
 {
 	unsigned long prot = 0;
 
-	/* translate vma->vm_flags perms into PROT perms */
-	if (vma->vm_flags & VM_READ)
+	/* translate VMA flag perms into PROT perms */
+	if (vma_test(vma, VMA_READ_BIT))
 		prot |= PROT_READ;
-	if (vma->vm_flags & VM_WRITE)
+	if (vma_test(vma, VMA_WRITE_BIT))
 		prot |= PROT_WRITE;
-	if (vma->vm_flags & VM_EXEC)
+	if (vma_test(vma, VMA_EXEC_BIT))
 		prot |= PROT_EXEC;
 
 	return selinux_mmap_file_common(backing_file, prot,
-					vma->vm_flags & VM_SHARED,
+					vma_test(vma, VMA_SHARED_BIT),
 					true);
 }
 
@@ -4229,13 +4229,13 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 	u32 av;
 	const struct file *file = vma->vm_file;
 	bool backing_file;
-	bool shared = vma->vm_flags & VM_SHARED;
+	bool shared = vma_test(vma, VMA_SHARED_BIT);
 
 	/* check if we need to trigger the "backing files are awful" mode */
 	backing_file = file && (file->f_mode & FMODE_BACKING);
 
 	if (default_noexec &&
-	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
+	    (prot & PROT_EXEC) && !vma_test(vma, VMA_EXEC_BIT)) {
 		/*
 		 * We don't use the vma_is_initial_heap() helper as it has
 		 * a history of problems and is currently broken on systems

-- 
2.56.0

