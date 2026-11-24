Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540291;
	b=KnCywj08WO8sLMNbFWGOaiNj1p3ASSkGkD/Dklj/9VFEptAkOZaSWqGkVwjHzGLWeeGt
	 CWeOeWN5hAo+AooP8gDP1dNoonJq2djb8XhKYzvcbQKxRt76Kw61C0SfUROjXbBkjyeIi
	 IWGVX5jWSLGIxKNc8NKtIP7gC2QwRVkAMFqiQsVHADvtx4OvP2oG50vmQZDszYGoj1gSA
	 Zah6OzsQ9WTo6mAd/GnTgv3BcT0eahdotWv9V8fVZDeQgKAx5y5LAAHF8OWUifUFDFTIO
	 GT6q+ZM5tbysE64MNCCQgCYtnW/XHCbU91Kf0dUkwk1Z1CZxsKIDRcZFJt/JyTddDjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540291;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QldWE4w0TVdbt2gDvBD2hdwiIfOJOYra+WZwlAsjtw8=;
	b=QydzaNmJi6HVoGCnVtNCmwx0o8k3vLDa69R/x3zNnaB+r6MhqGj5mysyvMdqXMGHBink
	 bp0lOP1wOvpRxQOP1yrl2tuIlGkVeNLZByUA0S/ezgRbSyKuDxqFIVswWain0QuyzBrbx
	 nTIW7IhmUynW6CRY2tk/VWEn92XciBzlpiQsUyCpe8boNRhXtynlz5cBHKil2vk8fzZTY
	 rJnzayjLRsP9qMLJXy2aUtqIFqKPGeZX9CavWkUEnweOw/ebh/Fh7iFMqBgQ3AmgNV/1Y
	 vSdwTZsoznrOeO4eWXZt4ZUcYpB6zzwu+xA3BuHykiJXE5wDIU75Q1NsujLhDrg6DfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAWDg5Vd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EDD606A6B9;
	Tue, 24 Nov 2026 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAWDg5Vd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0571F00A01;
	Tue, 24 Nov 2026 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540290;
	bh=QldWE4w0TVdbt2gDvBD2hdwiIfOJOYra+WZwlAsjtw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FAWDg5VdpmSx8rQ4lXebaV7SUMn+/W07Xst8eBB+3X2tL8rSRKmUXHCIMftwFSPK1
	 goeF2p68x4zrFVqN7xqOVkVerTS4zXG+4wTxWabsWpEHq49685dHDsGi1uixY9oNEF
	 yw1zPDt3FpEF4KEpItK8x54ojy5MOVI2n3NR48J8lK+HvY3W2yz5ioRrupk/rL/gsw
	 JnWTskNHr9Jv8Q4/CtMgZye6VMx5Qdrm165YtlCl9x7rSsx1acUmvoIxrlN3N+Jtxs
	 QVVD0egk+QCVnvxAMlVDhkBS8CqDmQHE2ldeU1c9PlzXCKOKpXgrqszLMrksKwsM2j
	 jQ/sEhDIaDEQA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 17:08:01 +0000
Subject: [PATCH v2 09/11] apparmor: convert VMA flag tests to use
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
Message-Id: <20261124-late-2026-vma-flags-v2-9-bf3fade93064@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=852; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Fq9T8hwtRsQLwO0WpGmIyYpdIofCGHG7KaF/EUohnCo=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZj+SVzZ+tY/pliVFg7/PJFXOrpYolpPnfcfUpLJ9Xq
 Hrm/5JjHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZjIlT2MDH/Ubjy1mjJp2/eW
 Zf+bX7xfEBQ0kWFv7ptlrTMschv3y6YxMtyfM+G4ub3U1Evcyzr+7Ar/vXfCg2O9KeJfXsm9Cjp
 dw8EKAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
AppArmor mprotect LSM hook.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index eaebc3c60c5a..9ff9096b6199 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -591,7 +591,7 @@ static int apparmor_file_mprotect(struct vm_area_struct *vma,
 				  unsigned long reqprot, unsigned long prot)
 {
 	return common_mmap(OP_FMPROT, vma->vm_file, prot,
-			   !(vma->vm_flags & VM_SHARED) ? MAP_PRIVATE : 0);
+			   !vma_test(vma, VMA_SHARED_BIT) ? MAP_PRIVATE : 0);
 }
 
 #ifdef CONFIG_IO_URING

-- 
2.56.1

