Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540333;
	b=DajZP8BsXfgLbDr7y3UC3StLJFyJFgR3o5vJdZ3aF2WR6G1SldWnHdcooZwfZNXOKlmP
	 aZ9J1j3KVaLl0bMiuCQG5+yTpR5MWsK3X8dG/Jzl0su1Q7q3SCNnYLkZxgbFK0rSCoU1P
	 ku2rq4732CMdpkaT8crb1kpmS0bwvgqmMBBqPgA2JFVXNQPknchbfjpAmcxnOCWfzC7AA
	 sGbqjYpL66EeFqtF8XX7w/D1KGX/n+Oq+3WhA++csnwi/IxiIiY77OhOITrQZhTLXJUHb
	 EL9+s6Wbhzt+bnCqBFeZBEJM6R2nGIwIqCEl4o8W2nL5Ih+a36Vq0J7hrQLShZoN7dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540333;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0+HphfNU3P4NBBhVQLGMxkibHciZuclM2bCzuhUVplc=;
	b=Ma4emwmY//Qu5N4gP6ppldUF1SL7STcGSZPMQY63D2MC7SYennXEXAWFNG6n683XLo0n
	 VjwWZgd8jYfk320HzM+kL3ynxC1MRYkmYh81ka76SlvfzzaATpf/Iz1iIbExhGpH3BfSR
	 a+fWC07UwpfFXAxRow2CMVJQNr+AAHhKxRv7lRCYVe5RHnXCoq6mu4HBa95oHo5JKxe6Z
	 b1Wdj3XnGYdqwZfXmRMtHu0uyBGoSGvqj8M0O/SqDtilJqvQxHYGEoE2Fkus9yU/FjQ1i
	 m7sFh7p/1SzMd3FmMdzykzwNJS68iD1OMsvEGndLhV7M7rrytJrNB28lH6c3i+J4bzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWagNd19;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334E9606A31E;
	Tue, 24 Nov 2026 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWagNd19
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3071F000CF;
	Tue, 24 Nov 2026 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540332;
	bh=0+HphfNU3P4NBBhVQLGMxkibHciZuclM2bCzuhUVplc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZWagNd19/8Mk44HmITE+UK2Cz9B7twpXQYvnU5XoBwiZn9SNSuxJ6H2KXuIyFiBbD
	 mUu2MBXhBsaf4FVIxVAk5uiY+bd1NKXG4FySE+eM4ORkYgEvn+OX5kW21KOo0i15bH
	 dxr4ALMuUNmufjoW8WCp75e49zHcTaSAc8XzGpSjO9ibxBcSBC5jbmDUN3VWGcTqUG
	 nP+HfGZxER611yILD2Dvagn7Nol68wczlg0rQon2NI5u3CN74liWodnNc7glhVXdeG
	 qDj578np3LllXgDa6fPEyjrdcs2yQpdj+8wq9m3ffUeqxAMjsitxxJuPlnJ0ZDNkog
	 O7BrCNGKYhPCg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 17:08:03 +0000
Subject: [PATCH v2 11/11] ipe: convert VMA flag tests to use vma_flags_t
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
Message-Id: <20261124-late-2026-vma-flags-v2-11-bf3fade93064@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=792; i=ljs@kernel.org;
 h=from:subject:message-id; bh=rH0wf7aPN+m4DmrJH+N9jL6VIPzo603o+4XYYEWHbSg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZj+R/2dj58xw7X5Og//KWFIMU+4jwM2fUJ4Qcy+LZN
 qXWvFW4o5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABN5w8jwT+0pX9CaXievXrOO
 oD5dM+fKPUdm/wlT27d5VmVMUAC7HMM/1UvBYTJ1D16aumfMrjA9HskncsZ9Cnuar/vDX3+0/p/
 nBAA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
IPE mprotect LSM hook.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Fan Wu <wufan@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
---
 security/ipe/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

-- 
2.56.1

