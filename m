Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560351;
	b=bLuuliCOoElgYkO5yWhMh+p/Dmt7hAuOOot84RYbhmBq5XEmX0NtXxJv8p8d0G3PYc/x
	 cK/uvsUwS7Y/mQpt3T5cTr4JIY6AJ3fhSOlRDBSNVVh62H5u53D8c9ldYYiuf7vOolVK3
	 uLiKHckPlDZACt4/V9fzpHritlQnn5zKholKHncuHNVGpdkiTgVVoZF4Q+sNhzuuo5tov
	 +1ZNANJBLRnqvm/K2DdQvYT5dzTdfarkJKQ1T9Inb99OuQleBIraqlwHVDGkgXNz89WFl
	 nuROW6dEKnpSlGYXZ1dEdAMlEHztLVBGpTcxpUjS1vWLRKG5Nlvc3ZFa7hekOCOhc+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560351;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZGiGop5d+F8Rtl4gJM+e51darej3tvaxLWXElW4mntw=;
	b=WTmCkFA9uBWlOnaJqJGM8YlwMiV9gg6kHMAsZkktwzouEhWW4ETMUFfQivtzUBden8Sl
	 oQ7bzd9qd29qFaidO2ExDO6wM1gtOYjXDeg5QGtl08UVANyYjoUFuqZ2B8e8FXcJnOf4d
	 AkkOcpkcOhTiBkT4s407SQ0f5sv2oc8gXNIiK7gDKAzecREINtGVOiumGeBab6aq6vr93
	 3c1BZSrhhV4vr4JuWKNCO/ECfuAmrF2Au/iOcgJ+l3rpHI0cto540g0QbXAZDvPqYn3oq
	 EGAkm2svUjGn6IxR9VsMhMg8xyZQ2chDW9KJhU4ugp86zlegVryNmbSpDmccNKJmnbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nTvh+C8v;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEE5606A32D;
	Tue, 24 Nov 2026 22:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BEE5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nTvh+C8v
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOMZaJD3653444;
	Tue, 24 Nov 2026 22:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZGiGop
	5d+F8Rtl4gJM+e51darej3tvaxLWXElW4mntw=; b=nTvh+C8vIj7OYYIXDe5d2R
	kjD5qV3PLuWeVi06lfK7L2UJEji/0Y0NTNorE2sOm+OZV0abykWH0eDGNBghYJ0X
	rq2iLVPK+mHk5L80j6FsTx3l+8sZ//o+V5DQlP8WI3upQAwt3HFFUd/psna68+YU
	1f0SS6s2B0uwnUx5Fbet+kOp1fhhomrUiRev86n5oFeFHEaCz89bG2qaXYanxHkt
	72GhPgk0UkvUIrOg6jofFdrKRCxRn1TnFQHCx3alMAUuJk8ditj+psJO5dju10fP
	ZVp+oTdmh2KXNvrOZYqQt4KSurp9qFLtHQQTRoz7RDiHEaL6YTVCV5sjlgTsfu+A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv9hk6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 22:43:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOMZNrm2939889;
	Tue, 24 Nov 2026 22:43:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa00u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 22:43:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOMhiTQ17891842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 22:43:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BF575805C;
	Tue, 24 Nov 2026 22:43:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5736D58051;
	Tue, 24 Nov 2026 22:43:39 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.243])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 22:43:39 +0000 (GMT)
Message-ID: <dfc8eada26ec70fdb802d71d4ade50e52917af26.camel@linux.ibm.com>
Subject: Re: [PATCH v2 10/11] ima: convert VMA flag tests to use vma_flags_t
From: Mimi Zohar <zohar@linux.ibm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
        Andrew Morton	
 <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Jason
 Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan
 Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>,
        "Liam R. Howlett"	
 <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Harry Yoo	
 <harry@kernel.org>,
        Jann Horn <jannh@google.com>, Lance Yang	
 <lance.yang@linux.dev>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost	
 <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul
 Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang	
 <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache
 <nico.pache@linux.dev>,
        Ryan Roberts	 <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>,
        Barry Song	 <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>,
        Kiryl Shutsemau	 <kas@kernel.org>, Xu Xin
 <xu.xin@linux.dev>,
        Chengming Zhou	 <chengming.zhou@linux.dev>,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)"	
 <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Pedro Falcato <pfalcato@suse.de>, Kairui Song <kasong@tencent.com>,
        Qi Zheng <qi.zheng@linux.dev>, Shakeel
 Butt <shakeel.butt@linux.dev>,
        Axel Rasmussen	 <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu	 <weixugc@google.com>,
        Baoquan He
 <baoquan.he@linux.dev>, Mike Rapoport	 <rppt@kernel.org>,
        Suren
 Baghdasaryan <surenb@google.com>,
        Michal Hocko	 <mhocko@suse.com>, Leon
 Romanovsky <leon@kernel.org>,
        SJ Park <sj@kernel.org>, Rakie Kim
 <rakie.kim@sk.com>,
        David Rientjes <rientjes@google.com>,
        Alexander Viro	
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo
 Carvalho de Melo	 <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland	 <mark.rutland@arm.com>,
        Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Oleg Nesterov	 <oleg@redhat.com>,
        John Johansen
 <john.johansen@canonical.com>,
        Georgia Garcia	
 <georgia.garcia@canonical.com>,
        Paul Moore <paul@paul-moore.com>, James
 Morris	 <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Roberto
 Sassu	 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>, Fan
 Wu <wufan@kernel.org>,
        Stephen Smalley	 <stephen.smalley.work@gmail.com>,
        Ondrej =?UTF-8?Q?Mosn=C3=A1=C4=8Dek?=	 <omosnacek@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, damon@lists.linux.dev,
        linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261124-late-2026-vma-flags-v2-10-bf3fade93064@kernel.org>
References: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
	 <20261124-late-2026-vma-flags-v2-10-bf3fade93064@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 17:43:38 -0500
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b061323 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=TGgUVIJ8l62jgltsAYIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4OSBTYWx0ZWRfXwDA9Nt+nzQXw
 9KrWXP5B8HLKCLWjlN02XC/5HPXZXxZsTDWoRUxxxW6lQ3FZ8mC11QweKx47A+E9TdWAwk1cOug
 sFMAIkU09NA25vt8l/0xpra1E7Xg8fo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4OSBTYWx0ZWRfX4lLDXZnSTgup
 AU6qwfIygRxvBGLVJ3VZuQ2vQEBroYM2OKsmMQ6snD+HV9RnWCzLaKuCqDXutrOsby4RCqqg8UJ
 SsfKlMMH8F6LVUCaD8RR7BbuIv+XPhpBSBnxZCeknTuXXJDVTvAR7Bw2DoNd6JzHNA2XjuKWSrp
 iL316AsRfmGY6o+l/cAaLYZIXE7x6iJkdIeU9Xa9YYSKxK4wx5aTChW46MaOuudWvgAZYAVQihK
 hcYBFyGorat/+d6x133HD2fjjxCW3NKbBTBFkPlIA6ogQ5ppIKZJ8DQQSBJSbHsjOktIZZ+Cj7X
 mzfjG7/063RQmfm4E4SrHYYm3CQqMMeMfyQ5SdtF17YNLbsI9YFOWCzWTVlt2R0isDZVBVmjkpQ
 UMBNWVaSYOQFsWxeiCTAouBAmMoQAuODDconbgEa0DcV6dCu4ZFfBblcKeOY2QAAEdZQXJKIinC
 3AkZuP9U1m6cGZIvVNw==
X-Proofpoint-ORIG-GUID: TZok2wQxCK2m2X0K2LNljqKg3jP9hqoK
X-Proofpoint-GUID: JKZjqjFSjC84u0cIzqrZZyhq1-jp0JkF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240089

On Tue, 2026-11-24 at 17:08 +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> IMA mprotect LSM hook.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
