Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914369;
	b=cjoMqkVu1POB9RRamfz0LkUdN1cTjb16TisnYVLvWzjZm0RO5+ryg4g3rQN+kOiZsykU
	 X/xxYGta36tQfsqIrzp85MTgI9NwlaJ8wfMk28twpCy8ublqd87t7Me5t59V84nyTDIFv
	 eAObe30lGKDeHFR/psoxNQvFlJ29NaBrZ5nna3wgi8LH27cIifCLorWUTV3VIeEzNLHYY
	 Mb7nYZ9w1QT9ZUEifqAJH5XPKhl/9aLvYt+IO2MiU2DsZ8lVRX1poherbo0KF7/sbUk03
	 IipeulzGEuI1Syk77NCHEh3UatD1MyhmSMShcmfhpxKLpxdMM0jf1hDutnETZRZXOyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914369;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yc+BOM9zISLu8R7CpRSVrLcnosv916on5x7GIVL+p5Q=;
	b=Y8Iy83XgH6vPSDe3dU67/4doClI5JUGI13ACC8glfLDDOHoHdYz8QnU3omQm/0r98P0J
	 quIikXJWcpsiiSNTc1j23ngL8gYq5G1tGrgK6gXSugfMOnJ00fFV/3D8UfoSVH+UBUtD8
	 b6akqtqNj0QBV2uhr5nb7Oo/+rz3zlxvMj6AzpxMrlhdBcejSgSOi5lUwGZpqAMJAWPNk
	 ztJKF5Zt/BpKNEQaMqNsSPpCK+CmWvIl2DQmpMfbaDVntGEyT8Evb66R2Ertsz/0h9qb1
	 LX3ILAlkMJgNlk5UzUYI3l0N4S1kDLqzQuLrZRNK8nNbh0PW2LPhfKBmT8FYTvUWRnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgRHR6qi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81885606A326;
	Thu,  5 Nov 2026 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgRHR6qi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DDB1F008A2;
	Thu,  5 Nov 2026 21:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914369;
	bh=yc+BOM9zISLu8R7CpRSVrLcnosv916on5x7GIVL+p5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cgRHR6qiWJTrG30pEeN7dxFVPc+dTV1adcqdwTD1LQxIFf5q0zcztQOCCuE0x3GV/
	 ZHgtlgNGSJS5GC6W3KxZ7f9IElfYH0FZjXVvUUKyz/AwCDgYx7heVhhqCSWhadN6KY
	 NEe92t8q/M/dK08zY/mQ1oV/ARSsEUIjFqVUPdsV2ROGQwui5lY7ZDcsJKHtaSdJ3d
	 +WiQAkG2/onWikpfbIj0XH1v/D+Qu5Q6DAMBppohnCrh2RINbMagM+nu5758asG2nt
	 zz8cJNisRYFgTY2Km3b1fascO6J0EfwRQOYbwweJYORpFsW+8e1RDtMk/fPELHEOvT
	 7xHp1SPTL/kLw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:30:55 +0000
Subject: [PATCH 04/13] mm/migrate: convert VMA flag tests to use
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
Message-Id: <20261105-late-2026-vma-flags-v1-4-0d3cd15ab75f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2848; i=ljs@kernel.org;
 h=from:subject:message-id; bh=0EzQPbq92vrt8Ov6q38P67V1mQozPkbuYDmCmE/yfh8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF32c9syHc3fJkcF57xf8CR5xnp+l7jg2seq6ywdJ
 bY++ef0v6OUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATmT6HkeF/3qE3W0Um7RYt
 /JsZ9l9HPWDqM8NnLeyiKcvM8087tlcyMlyYHn1t31Zdi9mvF8qt4pe4Z3x1tcCqoI47r8te8AV
 ks/IAAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
migration logic.

We retain the READ_ONCE() of vma->vm_flags in remove_migration_pte(), as
there is no vma_flags_t equivalent, and arch_make_huge_pte() continues to
take legacy flags for the time being.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/migrate.c        | 5 +++--
 mm/migrate_device.c | 8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 28a8d7734735..94033c222e04 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -310,7 +310,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 	VM_BUG_ON_PAGE(pte_present(old_pte), page);
 	VM_WARN_ON_ONCE_FOLIO(folio_is_device_private(folio), folio);
 
-	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
+	if (folio_test_mlocked(folio) || vma_test(pvmw->vma, VMA_LOCKED_BIT) ||
 	    mm_forbids_zeropage(pvmw->vma->vm_mm))
 		return false;
 
@@ -2711,7 +2711,8 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		 * See folio_maybe_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
+		if (vma_test(vma, VMA_EXEC_BIT) &&
+		    folio_maybe_mapped_shared(folio))
 			return -EACCES;
 
 		/*
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9e19fadfa65c..c26acbbd2e31 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -842,7 +842,7 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 	if (folio_is_device_private(folio)) {
 		swp_entry_t swp_entry;
 
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			swp_entry = make_writable_device_private_entry(
 						page_to_pfn(page));
 		else
@@ -855,7 +855,7 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 			goto free_abort;
 		}
 		entry = folio_mk_pmd(folio, vma->vm_page_prot);
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			entry = pmd_mkwrite(pmd_mkdirty(entry), vma);
 	}
 
@@ -1043,7 +1043,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	if (folio_is_device_private(folio)) {
 		swp_entry_t swp_entry;
 
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			swp_entry = make_writable_device_private_entry(
 						page_to_pfn(page));
 		else
@@ -1057,7 +1057,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 			goto abort;
 		}
 		entry = mk_pte(page, vma->vm_page_prot);
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			entry = pte_mkwrite(pte_mkdirty(entry), vma);
 	}
 

-- 
2.56.0

