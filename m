Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794716871;
	b=V1gQ7xaWWta5TIw5Pxp/iwRThJa4COT0b8W0G+lEbzkO+fKuH1RAggYGqoal4Vvu0K5E
	 fQoNy016Xc86FDYs9rFDhDuBW+iKKiPEmBto6+LdJificW7v7ALNSZ78QoQoHZnF3iBjT
	 u5Uuu0xSguwWlLuoxDNJiVbxkgIUvNCi6Hx7L6JIe3SYsLtiQIa4YGJmfEzC8Hd3PAUrS
	 zoCyC0QonkTvrauKUxzT3a6MVrg7flMs+FvFnq2Zze1p2gDy6j8iuH3Y4M7WXrq7fmnxt
	 8Uk1vUYCK72kJUZFI9fTfArO0mnbzASunDLonMjRk08iXWloZlxnJw3nPu50nV3ENug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794716871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
	b=V+xTHb1qBGfkTgq9W2mMHI0Y0KMsp1vTWv+s3RCqd5uumXgByCjqz/xPRZNkAT87I+8G
	 djrOhtiAujl2S04SGtH+b6/DuLeJvaDG0loi7Jrn5J07HD4JEk1aiEsTltKsrnkHFlIC4
	 wVvEHexNo2vm9ecdrrz5RPR170bXR8qrZUj3DD+mTSRCJx5QMuBZHu62+XF4v523E7HV4
	 WJYqlxyoMMpF1zZXeebF/PAi9mQUi9FBmfv1tlgiPb2dl6Xz00fWyy5PiuUTgukctvn6M
	 g27yI5Qqz/WQA/UaIjQ1b1LQGrf17lMXkdQfB2m1WwtDnzTlujOYpuTyYnW+uTxv1kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rrlCOM14;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B9606A331
	for <selinux@vger.kernel.org>; Sun, 15 Nov 2026 04:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 671B9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rrlCOM14
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2907610eec.0
        for <selinux@vger.kernel.org>; Sat, 14 Nov 2026 20:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794716870; x=1795321670; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
        b=rrlCOM14U7o+M+TZUPRKm/0B5X33KfTWozBYOwW7G1T5mICv5uiTGRDZ8N/E/WkgPs
         Slt3WdfVhPxLW/Dfkkb7/xGjvq8CIoTpYPwhvbdCG6Yvw1BgA2N1EVe8mN0kEHKHXyef
         8tQmPjoZ87TzHMHH5DbiUhIVkAX/fu7oGi34+wAuHuH/TAi5YSfzTR1lg6qENJCTh/vf
         bWlX56f+34OBBzkIC9iYt9wgmDyB8Cq+Fbc85HrZX5UgurcmY8nnkwgd3auzrRPvQadc
         V+9t/jgoM5TmoX0d5ZETJARldRFhGcH0iXCu8yq6U0k0i+/1+kk//+frMRudpsSSkh05
         Ua9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794716870; x=1795321670;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
        b=LPoTNVtWyWYq7QB2f0XLgi5miammFlY2lqNp3ChHXIIQZEJJgie5fQnZrfefbh98AG
         GFfpYHqE1/NqmPq/DAmnlk/TElCmM+xTB9VdtJY6E0kujPVIWgHY2wslE4ITWipb/ktL
         V1aXBMhMHd0sJAqcvML85ygQZXHdU+XPzQ9cYkot157pY53fo28gA6FoVblzhFlVrqbE
         PI9jDDWZYqUt6fAD9q1nCTATC4zyWdPr6pZGekQXRJOzwCTe4GQHJAFAcsGgadmEot97
         P/XCA/bq7SXEWWj6t2za+d45XKtOqegVURex1JgbWJAkWfBlDsYHQiKmiy9NCL8IWKd4
         hoLA==
X-Forwarded-Encrypted: i=1; AL+hErHi9D9HIL5VnxQIA8Iis2C0w83VkCvG5EBMx0jtgm7zk1iTqSxq1g7YnZRWXo1vdOhpB1lkd2Fy@vger.kernel.org
X-Gm-Message-State: APuU4Z/lLayexie38WoA7XlmkcV72EAwL30vPDkrUcZ38YMLAWWiEf8l
	LYRS9U8/lWaaqN1yQ/Pa6woxrOA2ITCCOQyv7OirvZOdgR2AWdWCikMPMYuETMG/fQU=
X-Gm-Gg: AYBFou0dGND36y/xzNAw5JLyJkZiSEHa6DirnwBqr0wqvBogrWtjMFVjJGsmGGJ7ZFa
	qaeztOSn+evmGriduRQ5OQkz6zdv7lLGwg97Kzksl1cjq5XryFKCil7LI1R/fwatBznBpZ3sv0I
	9ld5WbnhU2FAv5zGfLDKE/KugZA+rD3RxFL0eZECHDBF0SAKOUpB0faDxeTaPezw6NWTB4l6wRR
	xyr4aNQCXXEEaO5nsMz9g3dcQnuJNZS+pZl+4hO/F+6ctPViGVP3ei54DCRf4Knnut4v7XMIuGp
	g4faWAc3G29BC9X/V3o+5WIk75Y6Ot7Yt8bNpiUwJFWG5A791uj0CjmtexjNga7PRm8yuj7OlB2
	bSXijBXTbvJm3s70y+08HefJK+a1Wf6zBtMAuVwIkaNE3I5QWYqYmBgl2tT7n9ldw4vTEg0CloD
	eNZUmrk1s77/wZomQyFNNhO0z5LI7jDfcqmaIjwWUrx9r+8rHC73zDB21dNivypveKaMmR66a2j
	b9SntO1F6PAjxRk7d3CqoDkx+MyByf4437cWxU4QhPOTZrR8xoaEpeFqtjeYAzzeJMQ0vUaaEET
	7Eymys27gGBzI/2G3011y0yCcyY=
X-Received: by 2002:a05:7300:ff46:b0:37b:c89d:1d56 with SMTP id 5a478bee46e88-37bc89d354bmr1627673eec.12.1794716870280;
        Sat, 14 Nov 2026 20:27:50 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3797f98b9b2sm20640706eec.6.2026.11.14.20.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 20:27:49 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo
 <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang
 <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying
 Huang <ying.huang@linux.alibaba.com>, Alistair Popple
 <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico
 Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin
 <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro
 Falcato <pfalcato@suse.de>, Kairui Song <kasong@tencent.com>, Qi Zheng
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, SJ Park
 <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes
 <rientjes@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, John
 Johansen <john.johansen@canonical.com>, Georgia Garcia
 <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?=
 <omosnacek@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, damon@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 00/13] mm: continue vma_flags_t conversion
In-Reply-To: <au-DXpEi4wHwsz0r@gremlin>
Date: Sun, 15 Nov 2026 09:50:28 +0530
Message-ID: <7bie914j.ritesh.list@gmail.com>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org> <au3r0-geuwtRYPiC@gremlin> <1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org> <au-DXpEi4wHwsz0r@gremlin>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Lorenzo Stoakes (ARM)" <ljs@kernel.org> writes:


>> > It's not really all over the place, it's converting vm_flags_t to
>> > vma_flags_t across madvise.c, which involves changing a few function
>> > signatures, whose callers must be updated.
>>
>> Ah, yeah. What on earth does arch/powerpc/kvm/book3s_hv_uvmem.c do with madvise :(
>
> Yeah it's quite worrying that... :)
>

Thanks David & Lorenzo, for pointing this out. I have changed this to
use ksm_disable() instead [1], which then also removes vm_flags_t usage
from there.

Please take a look at it whenever you can. Since it also removes the
EXPORT of ksm_madvise(), I think we will anyways need an Acked-by there.
(note that: looking at those changes, it seems like it should go via
powerpc tree)

[1]: https://lore.kernel.org/linuxppc-dev/0500fbfbb98776091c89584155368610095b4dd5.1794537345.git.ritesh.list@gmail.com/

-ritesh
