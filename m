Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951500;
	b=Yxplk3Vv5wjRRPvn0KNm7EvcN8FkgGDRCGKo4PvWX7rvK3WsUCEMPnvMl4UX8oYtpPdQ
	 3SXb7fuJYrXD4Yk9CfzpiF+vfkJuMUBwcLFhimGpAmIzuX0LjhsXnzm0JGwLhg8XLz4zS
	 3izPYDfVGa9YAJZUL74fGh81ssmkHxWA7zKCWnQkI+veQE7XdB8T1LbtIAh8itGOjCtSW
	 6QZb/h3SJCTEyI5HE2TTd4e97atIH1Dv182gMMIJPJTkorzr7gGwmCF1K5Non9w2GXWmw
	 ajdRcujTA+iR14rL75g8BFoblwX9hmjskLLpzweHc1/YkGmKSMepwZKWgWBtdazAMjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951500;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=A8L/HnUYVSEblkQSsd0Qj26nxFzNN+cxfs3MphjQg/M=;
	b=Zh11dHJjAjBCcXMO/rVp7jYsuiF1noEu1qX30J8vFGAo7RMLrLYptEJyTQlVMfwA1u67
	 LGP9myu7No83IjIoMhZTDzASZ5sLHUz1cYK4yneNc5uAaTouNzrcnykJoZ8eyzgVG/52R
	 lCvFO6cWebxJ0Bb4AuylTbyVB+MYuk53FDK+4GAzBD3oatxRgOf14KKC77CYMM4WJ/kix
	 VKvsXR8+DuqGYRU6uAnnLBFmHL4ZgvlWPrDeOSiM1L+f72JdzilTB/BlOZw+ZbotBo8US
	 84zXeQ5s483g3nGyTNi7bY0nBy7g+GLqIL6rl8XJUUrvyKyGYP65VLxZTEus3bpPYhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UPIJP6Q0;
	arc=none smtp.remote-ip=91.218.175.59
Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD06606A337
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 07:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACD06606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UPIJP6Q0
X-Envelope-To: selinux@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A8L/HnUYVSEblkQSsd0Qj26nxFzNN+cxfs3MphjQg/M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793951497; v=1; x=1794556297;
 b=UPIJP6Q0nfXlvvfpln4wX/UfZkaGFDuF9gkUkIPdmlKEkN/imHhQCz3ox4XK08+ctE4izmGf
 DHMetZz49duJzYzwzdygnE2PamAUcsl1T1fAJvv3Fb1FBZ7jr9ga5OWjU4lI/o1eRpS4xNVVWOu
 khNo4qEaARHzv1qqESBWv7Y8=
X-Envelope-To: selinux@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2a97fd523a3d8c6c;
	Fri, 06 Nov 2026 07:51:35 +0000
X-Mizu-Trace-ID: 2a97fd523a3d8c6c
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
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 15:51:30 +0800
Message-ID: <20261106075130.55333-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
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


On Thu, Nov 05, 2026 at 09:31:04PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
>mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
