Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392230100D;
	Fri, 29 May 2026 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061859; cv=none; b=XHlxU0oD9lKX61qQSFkiA3FtfqzWkVLyFjt/IjJBH01di9XkxAxW3L2pvVbUC93PIOxmTjlQF6dZl/CRy3ZXNq6Khr93ZxwJjwW875Kr6wR7kGtEenEahMPfUpG5txD2J4sODVGinMUE4ma0VGbDxeOF6nc8uT5j41hWch5ItIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061859; c=relaxed/simple;
	bh=9pkwjNZKQmHcAyr08WIKHNcmPC8Ofszxfh851M5B1DM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=S/a49bwFCQui7mz23PPt+6NpgCkLKA95pCbgLomBUOOXmaryXZjQirkKDGfEnhJ/nsrVPraLL76Cr5O7dci8arPaS7WxWuxsLjzh0PNnb+Uhg4dxpQIiYUHiWrhlzePRxy5mRLqiz/QrVDQ+xr40Buf5Q60IzVLKP+xzlGe9jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kDmTSot8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kDmTSot8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TA43lo2133371;
	Fri, 29 May 2026 13:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LBDpyH
	es44rErVBWAO3aaBlvTWbMQTrdUMe3T1rsGiM=; b=kDmTSot88FOeOKO6qVl4f1
	KXNhqewHUEPlBbs6s5DgkjU/Zb3vsj5pyRckczjTn+lUI6wycyBRagfQjH7iZqQ+
	ZXjZ4UNwpgfmmrAPuDGM7xqgPp8HMN7g2/Y0kpT4E9zM58IwJYOvtEa7jMQ2c7Wk
	foogL07UxxiVIN+K/ArjxRWZ7TVHMS2vHmMvBX+Khprt+sMvc1gjCGhVjarJpS3w
	7l8VU8LCpYv9NqbT57gPA0kC949yM4Mty6H3yU+G9cZ2eyn2PwS3e6ujGOhpc5gU
	B55LpERZhlsm9yMnilfOuxBXKpWUnQYEyosbPKvXBb0MA6yoevX1335IZu/VRUgg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee887rhts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:37:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TDO6rP005047;
	Fri, 29 May 2026 13:37:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbdspe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:37:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TDbScX918426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 13:37:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB96558050;
	Fri, 29 May 2026 13:37:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29BBB58045;
	Fri, 29 May 2026 13:37:25 +0000 (GMT)
Received: from [9.61.247.63] (unknown [9.61.247.63])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 13:37:24 +0000 (GMT)
Message-ID: <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com>
Date: Fri, 29 May 2026 19:07:22 +0530
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PowerPC: Random memory corruption causing kernel oops on Power11
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, selinux@vger.kernel.org,
        rppt@kernel.org, paul@paul-moore.com
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QLJYgALL c=1 sm=1 tr=0 ts=6a19969a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=Es5cYSP9gH2uTasRBFEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-GUID: X95Oq2XxFmbTvXpUZFekBxqU1m9zmlsM
X-Proofpoint-ORIG-GUID: X95Oq2XxFmbTvXpUZFekBxqU1m9zmlsM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEzNiBTYWx0ZWRfX98yBgGkQ+DoP
 1+Aieu2z0FjWtV39VZaf1OkZjVESqSCHIQeUA/47uQ9OJ3sA6ItyhGM4WiEFFt+yqtDMMyX+wBK
 3fDpicUza8k49ZRnCdhRIScJqeyDgEq4EfCiUOeIHdm4TEzvLVw7bFjZEbzb/yNKCiMYzTq37GL
 xbQcYhWTGhGKCiMh1tHZfkhA6sMw4Z3vaPBbFeCpC/r0jcRMT0Q04Ng7cI6liZUQDzBwZV/NJGj
 r49z5aTSHdLznUPP20yPdJgngvkRkeAGzI82616bRoZnwm6Sp5jZQYHYnu/n/ISqnFi5WKtJ08n
 +Q5gkDTRFwRb7DotcEfDrtkmzNS75JFOR75Derbk3hdzxMqi87Z9KvOTx7Ae+SIJYV74DnUl2j9
 w/KJBh/JmJa6hmhxeGkakfRUbq3SVuXxlSPbL1261VJ6JT/2uNgXSUrO0jjBvMX4vicRsE8+EHb
 Y16/mLkhPjrheX6BQXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290136


On 29/05/26 12:20 pm, Venkat Rao Bagalkote wrote:
> Greetings!!!
>
> Kernel 7.1.0-rc5-next-20260528 crashes randomly on IBM Power11 
> hardware. Attached is the config file.
>
> **System:**
> - Hardware: IBM 9080-HEX Power11, pSeries
> - Broken: 7.1.0-rc5-next-20260528
> - Config: 64K pages, Radix MMU
>
>
> **Problem:**
> Different crash at each reboot.
>
>
> **Example Crash 1:**
>
> [    4.678016] BUG: Unable to handle kernel data access at 
> 0xbffffffefec10628
> [    4.678112] NIP [c008000004e3c74c] 
> xfs_dir2_block_lookup_int+0xd4/0x300 [xfs]
> [    4.678281] [c000000005eaf7d0] [c008000004e3c6d4] 
> xfs_dir2_block_lookup_int+0x5c/0x300 [xfs]
> [    4.678363] [c000000005eaf850] [c008000004e3d56c] 
> xfs_dir2_block_lookup+0x44/0x1e0 [xfs]
>
>
> **Example Crash 2:**
>
> [    6.327116] BUG: Unable to handle kernel data access at 
> 0x762f736563697695
> [    6.327242] NIP [c00000000073cf34] __refill_obj_stock+0x74/0x2c0
> [    6.327261] [c0000013ffdbfd10] [c0000000007418b8] 
> obj_cgroup_uncharge+0x48/0x70
> [    6.327271] [c0000013ffdbfd50] [c00000000062fffc] 
> free_percpu.part.0+0x12c/0x630
>
>

Git bisect is pointing to 54067bacb49c selinux: hooks: use __getname() 
to allocate path buffer as the first bad commit.


# git bisect good
54067bacb49caeada82b20b6bd706dca0cb99ffc is the first bad commit
commit 54067bacb49caeada82b20b6bd706dca0cb99ffc
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
Date:   Wed May 20 11:18:56 2026 +0300

     selinux: hooks: use __getname() to allocate path buffer

     selinux_genfs_get_sid() allocates memory for a path with 
__get_free_page()
     although there is a dedicated helper for allocation of file paths:
     __getname().

     Replace __get_free_page() for allocation of a path buffer with 
__getname().

     Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
     Signed-off-by: Paul Moore <paul@paul-moore.com>

  security/selinux/hooks.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

# git bisect log
git bisect start
# status: waiting for both good and bad commits
# good: [e7ae89a0c97ce2b68b0983cd01eda67cf373517d] Linux 7.1-rc5
git bisect good e7ae89a0c97ce2b68b0983cd01eda67cf373517d
# status: waiting for bad commit, 1 good commit known
# bad: [f7af91adc230aa99e23330ecf85bc9badd9780ad] Add linux-next 
specific files for 20260528
git bisect bad f7af91adc230aa99e23330ecf85bc9badd9780ad
# good: [7189ebc81d5e4cb4e03dc4040b07c582b95b09d5] Merge branch 
'nand/next' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
git bisect good 7189ebc81d5e4cb4e03dc4040b07c582b95b09d5
# skip: [d22aa6f023f3fc275e1f994045a6b347288b2e5a] Merge branch 
'watchdog-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
git bisect skip d22aa6f023f3fc275e1f994045a6b347288b2e5a
# good: [40d5349aaaae55ec62451bfacc6189cf44ce02cb] iio: adc: ti-ads1298: 
Add parentheses around macro parameter
git bisect good 40d5349aaaae55ec62451bfacc6189cf44ce02cb
# good: [6665ab5cf8e74edba571d3d2f31e575f89373dfd] Merge branch 
'next-integrity' of 
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity
git bisect good 6665ab5cf8e74edba571d3d2f31e575f89373dfd
# bad: [4cc60db652df7ae5d659ec23325c341a52d065e0] Merge branch 
'driver-core-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
git bisect bad 4cc60db652df7ae5d659ec23325c341a52d065e0
# bad: [e1d469c38defe7fcb8c6f62a2b7dbf4a103da300] Merge branch 'master' 
of https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad e1d469c38defe7fcb8c6f62a2b7dbf4a103da300
# good: [4678d11f294de0fd295a265e02955b5d1a4a2684] Merge branch into 
tip/master: 'x86/tdx'
git bisect good 4678d11f294de0fd295a265e02955b5d1a4a2684
# bad: [9397e02d718fc52703d753f489042293cd807dd3] Merge branch 'next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
git bisect bad 9397e02d718fc52703d753f489042293cd807dd3
# good: [c574bdb524095d24169e229b2e3b9318c72e733a] watchdog: 
ziirave_wdt: Use named initializers for struct i2c_device_id
git bisect good c574bdb524095d24169e229b2e3b9318c72e733a
# bad: [5568ff6b5e30c7736c24e2096e968c8785c2c245] Merge branch 
'for-next-tpm' of 
https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
git bisect bad 5568ff6b5e30c7736c24e2096e968c8785c2c245
# bad: [23f6b2756d28e76464c7e87850d3d4f6d8c8b365] Merge branch 'next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
git bisect bad 23f6b2756d28e76464c7e87850d3d4f6d8c8b365
# good: [ecf41f6218b58c72f1511e395e480f70a9f44889] selinux: reorder 
policydb_index()
git bisect good ecf41f6218b58c72f1511e395e480f70a9f44889
# bad: [54067bacb49caeada82b20b6bd706dca0cb99ffc] selinux: hooks: use 
__getname() to allocate path buffer
git bisect bad 54067bacb49caeada82b20b6bd706dca0cb99ffc
# good: [2f0af91353cb64b54cfee5423820d2149039338d] selinux: check for 
simple types
git bisect good 2f0af91353cb64b54cfee5423820d2149039338d
# good: [bc3f08d1ef15ebbd32faf0b10cd9699b90b9d30c] selinux: use 
k[mz]alloc() to allocate temporary buffers
git bisect good bc3f08d1ef15ebbd32faf0b10cd9699b90b9d30c
# first bad commit: [54067bacb49caeada82b20b6bd706dca0cb99ffc] selinux: 
hooks: use __getname() to allocate path buffer


> If you happen to fix this, please add below tag.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
>
> Regards,
>
> Venkat.
>
