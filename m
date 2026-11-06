Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793928167;
	b=ruJv1bg+F4SVN/6cB/GL/9unITcXk8ysxIa4tNTTx69Y3LE4hx3opFIdHrqkZo7aFEAc
	 NeWz7x3UD6oryjxi0wrV3Xw5Dhj16wyIg/oweQRalmIY7stohxcus0X/zNwF3umJqbt9A
	 GK7qfpmZAdLGOlWhL/IS8/mEKORPmFqtqteILaFAK6yqyopw4fUWGciqFC4qbZt8vcMmC
	 M+dnMn9Cq7ViEUssTqbvFjLFu4Z4aObln+hwTEPdkp81vNo4KXiOhopZNMwuVXNtgkRNf
	 yGHrVYFLa/oX0ixOuF558tvuysn8fVjJn0yAVUCGNBL7bQSpw0HU2mpj9tr+vJzkHWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
	b=s74QzLCUmAsVLB2Tgm0myQ51RN1YhyX+YG5UEaybr6kY4pHwXT6LHzp6W4Or2GMWxOHb
	 xmuxZn+w7cerTJ1NtliafOVR8Ax7QIeMCgK3ninX85nmKZQG/X5NUnX8rT3+9gySGwzpI
	 bqevFBLo18ryLgWPuKjH+u1+ZumfJ2WZR/i6KabPaLXNMQ9/woNdu/0y4H8GsYVpoS898
	 UwyRYkmSCZjQ0DPRhvBDcV6U3u1hp5onpH3HeKEylM4zJt6gl+Dx+Rzvy/3nBOxczWmyG
	 B/c+iFEMzKlYlV86h/iJ01zAhMa9zVDV1OvmdVSkp1Z9Fe4kNCT1J8qVHMgP1ZTTWbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BXgsLCA5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A25606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 01:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A25606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BXgsLCA5
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b2382bf051so33747b3a.3
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2026 17:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793928166; cv=none;
        d=google.com; s=arc-20260327;
        b=sqWJokBCfijeJz2FgiKPtSjinO3HYE9CWW4zZA40AIBGFT9bUStMex6QmSwm+2PKPq
         fXE3y7ErX89mKSx+GJZH8saPyRrr4W5ri8utSork7tCf7g3dX/C4lIDTDa/dNExOh3Ai
         fjvo/hAlw+DKifYzuXlKuUPeQEIjfgaKQ3ztA0fvk4aLisefWEat4LOa19tO0+Qm2aJP
         4KZBaN+mdVqbdfm1lvddeQ8kHs0jAwtX4YenqQMgnZFO+YxsF3t+/KrLjJ+TO6dwrvMs
         fnW2CiROr9eStgVwP3LsJi6PQJgH4rcGQJOeNrrlyZJ5KxyKSmNPe/+MF59Bz8TQ1ZDZ
         g3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        fh=9p88DF12Dq8YJSbsH/VjiiBeWSqfjLLV0puGgewHUs0=;
        b=gZaBIQnAQESZvspSpLQ9tbCexOeFEwI4P0hdKTSUS/TTv65/J9FLanjq3NJik1KGkE
         Wj3jxHyC44EsYTghnQ68Cp1BmLESss5d9OINF7LTweUk2JUYuQtX526w7xCaRTuGX0IG
         8a42IIPFwJh6yphRFJbCm/asJB/HKHo1ThVNXHEnBLUpNjqC6CuXihrDZuEjaQTAbe7h
         pEDi6boQoIdfah2qEKZY4tK39XzB8V1buTviWT1oVTjX5VMmRso+wdgdtDWMEwGdS/qd
         21Q/KTRy/qGwTvbC8/iZT58QoHkAfzGvSATe1OgIGXdi+qY0FNhlHr05YTkSUasVqIbk
         waKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793928166; x=1794532966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=BXgsLCA51X5/W48GvZrpBezpY+stGa03fvEbUi2MV56MnNmF4a2PjDTUVnBg0Dwtqe
         Pc0pFbbkVSP0pF2lMOwQEWZuhIoVpWFLaZww3T/CDXUanEMozEFBbg5xukYGZHM3dK7Z
         /fQ7M+BmNkKN//ilq5bRiwTE5y+M3XE5NT96+Mb4FuQk23KwrKKCtl+UAKDpUXGzEGJV
         USSryhSewq0S2ePnFYtulTY16RPJSyBaU+5La6UtGtX/D/3Czi9oUOP9+hhoTJe/0ETl
         gYSYGkR59nTYA3bP+5Nf3SMG0P++deg+hHNjH+z7C7raNaTFT7WIIduRah7XGk96iqIB
         wcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793928166; x=1794532966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=AfQKuDAABmaYErDZz/jMI4oQubw7zwKFS9hf72qsWW8Z4qD9XKbYmgPfb6zW6Y7qUH
         6rf6CnRo8ZAjWr4vBW/OHLUGVtGoJz5mEKZv4aCBxJ2iYfdA94+wxE+4jhguruasHARo
         bO9SjkxNw46drt0jMwN0YgFi+IFfEOhON3EPmnOsNNEOZ+LTOZNuBZdxq8Q0WkA4ZFey
         N0R4rgoD0d1D8J3kYqVVni2uxxfNRbYke3EfgHlkw7ISEMp82loliqgSJg7jftjVlTO7
         +2m9vv5iC8SK1u/n9BFfKO8M8ubYwRwPNL1rFLDH4FFNVE+eHRBtIepS5SyQasSMx7BA
         GozQ==
X-Forwarded-Encrypted: i=1; AKwUvBwodK/3vBYJ/YcfHnyNk4lbOgxZwPx3A/MO2yHVMSehkImaxGq1nQ9C34q1LIOidMaZXPl7YLW+@vger.kernel.org
X-Gm-Message-State: APuU4Z/rRKLotB9WhzATQPVuxJJxhaotyWuavOSYP88lkExlLiV/t6MH
	CUVoLfNOCvYp1WePVQUiBgBgvKBzyUWouPUBobmdejiWnnJrRiL/T/vSEDKA07SmFZYl7SYhBRs
	1B+GhQ48Cj6tqTlup5CJ9JLvnX6H49sDtH7FeBHP4
X-Gm-Gg: AYBFou0BCgnqZ9ZZXQnic7DVs4LlmrQ80rkPSMbRDRrWzFgA1EWrvpVwxPGDvf3uH5+
	8ScusiGMRRZOJ0CDDLDXlPG9yvBKXixla1VK8amYzOkiyTzNo9gKbNZJiUqWuNM4vX0ceq2fbcX
	mYButSGLm5CMsmOC3A6yhHBOcILQFbevCn4cSMiIzo4y7BkFTu0SO5F+m7EgCvfLvstkzAI93SO
	XgiT3zOMZv5RKcrLNHpHBp4SVtHQHRmf6HLCAl08g0aJ3QxC7L6IheqI/SwONYU57DRmNEFvs3Z
	B14EQ5afDH6n6ukdH+zzayGQZP3an6DFwEetyauZ4v19xq7NV7nYiGws8jG2cjo6TS2G+G1cP4L
	+5znJaW1eQ3VI/OwumkPL4/ip/1MH9IrKSsw6NIoOXBrYW8bX0nwDq7WnTrTzp/vMZK2x
X-Received: by 2002:a05:6a00:4f82:b0:87d:e8a0:2389 with SMTP id
 d2e1a72fcca58-8b37b37d233mr903874b3a.21.1793928166471; Thu, 05 Nov 2026
 17:22:46 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org> <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 20:22:34 -0500
X-Gm-Features: AclHuK_C6UmASiuiBuBvumlcrlzJEUCTa0-vZyEfxhlZIjAFaCskKj-ONE1360g
Message-ID: <CAHC9VhRDVz4M-m_4UZZDKMgs4uc+j-+-jwYEdBDfSD0rtd-1Og@mail.gmail.com>
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

On Thu, Nov 5, 2026 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
> >
> > Replace use of the legacy vm_flags_t flags with vma_flags_t values in t=
he
> > mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  security/apparmor/lsm.c           |  2 +-
> >  security/integrity/ima/ima_main.c |  2 +-
> >  security/ipe/hooks.c              |  2 +-
> >  security/selinux/hooks.c          | 14 +++++++-------
> >  4 files changed, 10 insertions(+), 10 deletions(-)
>
> Similar to the other patchset you just posted, is there any reason why
> individual subsystem maintainers can't pick these patches up, or is
> there some reason I'm missing and they need to go through a single
> tree?
>
> If they can go through multiple trees, can you split this patch up?
> AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
> different groups/people.

Since there seems to be a desire to bypass normal procedure in favor
of speed (surely that will never backfire), the SELinux changes look
fine to me, but please do wait to hear from the AppArmor, IMA, and IPE
maintainers before merging this patch.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
