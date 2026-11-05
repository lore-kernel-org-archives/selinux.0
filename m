Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920680;
	b=Vav0LkK0HCAquNkIDGuCVlDPbcd+YYFa3qd5cRC1mmviHlJyyisf30Als7lIO5s8JivJ
	 nu3n4Ois+lTNaZzAzBOSehUnc7/DL09t97e+obKd+bxHoPDp5w7H/xuRlZqYo66HJ6twe
	 J5lwDmPH2S45gtQapzWEjmyI5njaC0kYTjapsBOMQSQUwk+URqBH9N2NZ27onzuxMspgL
	 CukH2F+GyGNtOoiYtDSzYyp148RHm7s7HbvGp43uFczLyAy9mnvTHhzcT3JV1f7r/EgNY
	 iPIT2FLaXXQ7Mq/mfzCzgopVS7cp78vf2gJvGq5NBpKll8THS4xBIXvWHvNmrCowP1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
	b=vGLOpAcnr+il8u77cWrqoZCvK1mGNCP7d/A5SsqCU3pZRiXVN/FRIL/LcRHjXxRexUyn
	 G0qG7dM9CkQiYWeXPezQ4zPUV4JxjLjE4rau4xVy1mwIiKfQ2rGsR5xEwfqZDf82OQMGR
	 xqFGEUfpbxRT0Q4QEy4YmZ3Yz8TSxDqkJRXU2v2Pq/mJJAgLJrQHqHTDf6+Y3es3+X0/m
	 Qrc/5kFNdSv4HiJltsKwycZuZ5/SnWQslqMo2IjuKNwtVaSoHH+brj33Dmo+a7gpUNRuW
	 XQBb2VqCUnhepqgzfaAaWMa+hkWV5+R3+DcGaTA4f7KnujvzPThG5NeD8lcdcUhVuyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=F936vzKm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E3606A326
	for <selinux@vger.kernel.org>; Thu,  5 Nov 2026 23:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 048E3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=F936vzKm
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so45650a91.0
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2026 15:17:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920679; cv=none;
        d=google.com; s=arc-20260327;
        b=WBR8hJaykfgd8+Hj/GKbzY7jUjSggopwFWb2rzQ5tlClRiQbgfDhrlxzpHJo0rb2EG
         ECN8A1zsaF9cJkoGF0YBI55tNmixjx3TaX+rzKkeOkKLqREOkwyOokd/YUdW9AafCeDH
         WzA531UE/0RZ/VncTRUXWDl+k5MPUtGYz7YQz59VoT+75vaFwFBwWs/qFxWgqhOIwvnE
         1IEUbI+fRsETsgigGvTn/hJbh4zh9TB2TxSWVgu9J4dg9MzR5XaI8zhFxrSsoSf7YZD5
         ggythillaNBXZHJnDZ0SBlNQom5z9fusbCWcb5hL40pGLeF/XegbUOKoOp71ZAUU7vaO
         xNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        fh=HKv+qnvzQ+Fo5yuL7quU8eUNRhGYyimjDqLsKoHqzQo=;
        b=k89FjBp3fOHzGse6mL2rWrCKPTFz82qNcEPafd6iGJv8IJ0POBXRsBTLtl0GhH8x+H
         hDnUYS88K4zd5MaKzGZtPVIFCjLTQYUofGmbg9mp9JuDmIcHiLBQKvgf3Jl35wiUdFtQ
         iGX9luRQlNQYkiMbx0DxPAQkSfGVNeF5gJUfbNwVQxQkqHuLNAl2A1EHAUuBesvMrSFy
         WuWdldHM9UB5FaGMUNIfslgaW2Yb/ZTs8WeXaNW+ko9j22N5ndf2MpSXkHstQ0y+KVot
         1QImEwg0auWsg/sSYEBxoU1hyJ0oCQJNQ2LR9tAwOHbSnjFeHEy1i711ZD8dcFvazGfd
         ssYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920679; x=1794525479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=F936vzKmZco1Rg9qiS2Cf7yXwnXt8dn1LQ3YxCN5SMsKSJRTlu37FG2JQnmiZ4tO3q
         ZY7C/eCqTECYbf79gAR8gp3oow9+Ykdrk78RZdAOFLnN4sIU8x8jDIiI/j4+tmIgfhgQ
         Kfc7/iulz45+20nMepsyi2DVKsca2I7vu/IOFa2DSNB+5NoNB+X3xZL+TnSEr5nUJW/0
         t+eWupnUof2Q+Z07m3XUdhgKdmPOk5SNXh4+R1i03zuB5eyYkN5hGGMTpwfL4P3jF/oi
         qjoVjwxKWuHtQbutc+EbzPaNTI2YVJHBnHBIs9egvV2qx2jXIUZICkPleteOCZKku3cJ
         ZAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920679; x=1794525479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=1BFS9bciFCZ+9jv1FDS/CPMsztLutr9oSDkd2fAZWNAh4Yq9IdG6YPOwGaKpKGlyNI
         9yMoazCyww3ZbdB03+99Bf6goG4LmcE5E/0VUXmbGcPSV8BZ6J5s2bXhdBrHlgmDYepH
         g6e3ROj3WC5EnbaafUnsfnwDydS2o7bThhTCyCnBwFYBzyVni/TKvcgc59QF0WYUpn3B
         teO+L6iVBASA6MIRG7BHqKLNbTOIayWKDFYUFVBVDfAQTdc3zWYT6XHug3kBLw1pIxSm
         I1THJwIZwauOQeKdDfoB6ukNBR6XSbC/pDlYNxCWLsGwsK1jktGg4xf0ERKSTo9BPq7S
         muOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPsExmfiWIRFuYA6+jGECfhdHaxqR43EfOHeEJE/89OY3xJX0AfGg2+4qoxLeq8b9SIIIydYD+@vger.kernel.org
X-Gm-Message-State: APuU4Z9WHGU7vXBZuZeL0PC8elHsu5CDuEUnVKAl5d8LH/FP2QYzMQcT
	Lv/Panw6EeKzW8QYnJFKwYABU+tCPQQFeYJS+LKMivzVkjM3ZxzEDZ+I43M4irTLZ26clOnXYQv
	tAQF4ykIYCRoWr9dMaGI/ZUGlTxfdKD7Eca9B7oAB
X-Gm-Gg: AYBFou12qVFTKUuR4jNIgGOpjlCDVsfHraAi4wrGhJlikAj40KdLtFWo3KIrg2D0w2B
	j6izo88LvKpwONnAtcd3VY4pFZ+scM/jCLjFhonbcz1JosMCtdYo2Wf9bTy5zocZXbdV0TWYhdK
	w/yJe+dRSfHA8TJ4i8inDmWo9e4B9G+zCA4HY32ofX0nnHa0lkV6EhFlXwHx276fLdnq777LX2W
	4XcLi2QNfGOTiHNdWdaGD12OFKBm1xifwz+nMqwFnPlTdn41tX6luSjMwKlzI1tcr1IVJC2C935
	TJveZF9yQgHNXZYbcUX1r1W/Rs5QAk7fuoQ64osyVkvplDjqISpJgvLIriiaTHRMy3HvRvpbS/J
	aWBoxy5CYsFEt+F3yb2IKIXJsLb9nUSZdKeGOG8EGYi43ibb9YQtKhPWChB/d/1lNNhOJ
X-Received: by 2002:a17:90b:1dcd:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3b0db703e39mr535625a91.34.1793920679319; Thu, 05 Nov 2026
 15:17:59 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:17:47 -0500
X-Gm-Features: AclHuK_gkg-Hspii6U5_01_jGLQO23B7F4YXuvzvsb53ImE19wnChR3DgLruv6g
Message-ID: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/apparmor/lsm.c           |  2 +-
>  security/integrity/ima/ima_main.c |  2 +-
>  security/ipe/hooks.c              |  2 +-
>  security/selinux/hooks.c          | 14 +++++++-------
>  4 files changed, 10 insertions(+), 10 deletions(-)

Similar to the other patchset you just posted, is there any reason why
individual subsystem maintainers can't pick these patches up, or is
there some reason I'm missing and they need to go through a single
tree?

If they can go through multiple trees, can you split this patch up?
AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
different groups/people.

--=20
paul-moore.com
