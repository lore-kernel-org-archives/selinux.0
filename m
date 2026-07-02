Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA73D813A;
	Thu,  2 Jul 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990697; cv=fail; b=DbVs4MBqKpBESn+BJVMrqT9oXPHw4SgwI9hp6dtgHQuHd2K+vx6LSZZpKcp4QUIpBtzWzUYE7Jt+NDJfGXVsYmKTYdTroSo1KIsq78Qtyfn2ze9C/Xh8NckOd81MNyuOk8DZAeWD85Ypg3R7sV8lU8wb8AEoMtJ+CJ5JN62QKgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990697; c=relaxed/simple;
	bh=UZLRhafVMne+HODvjJrGkuf91msXnPD14pVoLuRCgLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h6qP0orHXJcr/ziuShwhfGUMt1wxTKLi3jl7cZr3bRbuAEP9Be/4XgwrAVNGIpNUyOkuQ7VtQyTC/iluJJ3L6kDPQMDktllfd6+0Fbz5Qz2HKsGwzFCYlKZ1Olngzzqhmgd04m49LRi4iZL0sB9lDAshGrgLZYk9mEl+pLZw5vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bSojw8g/; arc=fail smtp.client-ip=52.101.85.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bSojw8g/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZpoINoFTv3NYqH48O5G90JAHOaG8qmp1deygxI+0Qm8W4NoLj/2xiDbnHPltjysUZmrIuFEAmCRgZHQ8mLXZrsSlCrAlMtI44nsdTz6Zt3PjGYOrUzekXUTlRs6UtI7CLGVlvlG6Vfx1C9XzN+QkkjcykPxgWP+6Wcf4gzg6BPHsf5zupWSG/9+I2InDBcyXEQgxH1TXZiNypX1APgMW0H3bxmjsxrJNIDBIA5USoiM+JBZ03BL0TNAYFdnp84w480zT5qG5oV/ZT4FtuQSMUxPFBhV6SqV0hiSyW78Qa1OFFbrUofV+LCjAs72T7qz82W3ppWc+18iRs/U0RqTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns3SYMkZRVRuPa3Cedw7KYHNu7ZcugChQA6zF3FiWE0=;
 b=t9xIvfF7UgkzTN+6C6C8cYrLCGe/xzEL1tbLfsokHJlHB2sUF3uz8NS4wcMge5GvkAP2AwEZVUPRL4mWYx75qFRqgsjrkf5Q1symzjbYHwhSIRUkEZzyQbdToirPynhcXfUBR4PpVX3PMxuownZrUOefwLSJboFHT0SsxdjRhGL0pDopURfuqh/y2ZCGIE42k9fqi4oqs3ZmXPIEOYooLjFvDszz4z5rD2tavKUKV0xnLfD11dizDJn5hhKGWV+J0oL8cod45XhF8JZWp8+oXYQbV16UmAyeurM2Az8U6QGN/nRGd2tGbNMVwhyHl0r84pSggrUYtG2WyDLM0JvDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns3SYMkZRVRuPa3Cedw7KYHNu7ZcugChQA6zF3FiWE0=;
 b=bSojw8g/r+a8ubSyD8mhopERw6VNGvAZJ+Cjr1zRm26kVPiCMEcc4fU7iX2UWBT3/2Yi/etcajG/be48itZirB6kUtLUxK7GyllUBi0zOVH6SQMD55pYl6Ee9K14o0xnrU1oaKj5M83W3pCn6IMYLORoEmIdUezeB6GaJjitegY=
Received: from MN0P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::16)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 11:11:31 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::41) by MN0P221CA0028.outlook.office365.com
 (2603:10b6:208:52a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 11:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 11:11:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 06:11:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 06:11:30 -0500
Received: from [172.31.177.127] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 06:11:26 -0500
Message-ID: <8bac16f7-4296-42cf-9a1f-db0e4f9ee534@amd.com>
Date: Thu, 2 Jul 2026 16:41:25 +0530
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test amd ibs: avoid using executable heap
To: Peter Zijlstra <peterz@infradead.org>
CC: Ondrej Mosnacek <omosnace@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, <linux-perf-users@vger.kernel.org>,
	<selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ravi Bangoria
	<ravi.bangoria@amd.com>
References: <20260701062321.517351-1-omosnace@redhat.com>
 <20260701064301.GH48970@noisy.programming.kicks-ass.net>
 <43dd9d9f-2348-43c0-8af5-77ef260c64a3@amd.com>
 <20260702101704.GG751831@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20260702101704.GG751831@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8d3397-a4a0-4483-ef70-08ded82aab91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|23010399003|376014|82310400026|22082099003|18002099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	4uG7nO5SPP3+fPBJ2+Vy1paIoPJ7FbtCtJnd4SUVuWc8U0iPaVXsyqKV11vJaCheoMeTrSl6UjZ8HirMTMaemlfZ1ATFfR1NOydyRETYl3RwMeZ/iqj5BhyATsfs3zn1ca483RvIrseU6IahZhLA4mmRWXsNp0Sbp3vAtvcd8TS6OtKSoSiE2PhARLHMHpDbN5+fvs0/I1lP/+B6xOessROAcwIjGugfIr6hbfU9gge7l9xs1fXquu2O45Yavwmo1rDBWI28wxyd78LDfBETxO9IVyzqAf4Msxv8VTUsR/yfcKmHf53SJ1BW7AbD3nJ/wLiP3KOWx+tMORFMySs4ajQOxf0IcthrWjyaWRHGWkWLbM6S9BM0l4YwCUThQLswM4lTzhu+aIKDr3obBhMQ3gOl43hcnbmPOLvfgGePfVKoxex8xHeGiDUErU8TzkwFSzL3U7h/SKN2mUNk1t4NeRhwmWdqqK7bE1G82M0FavbHn9uCn+Dl7CG/DSvyZg1j3ZJ41ZrqDx3mSHzMYm10E/JGhRRc4TH09INeWcjDE592+iyFpso7maXwmuaEiOKQb1FQJQi8gN1WN6+tnxWMi6OPrsFitvwwi3p9DdvTqh75Stnl0rWQSkI6y5y1uJ7EmhEvsTFw3TsEfM++UOvd/E1ZeiZ3LFRMqygC9y592UppXsIZvDS17E0LhmReWrnBbkj6XbPmAALfroFOpeJLJQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(23010399003)(376014)(82310400026)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AigD6oTlmhnycoopB7RWJ9KWIu49ijACoS5FM1sgUu1zzAnOjlMnnCS0l+BjofA6htmIXl+wTafXEdskwGGxnoFnvm6yat3fp9EczOCTAREF5DMXL4XeqIo7plJ39AeFXuONLziNBZXueq75FoJsHGZIwjhdRPkgNxDKK4DVR9YJCdhYTZTF+EBOH5fXZRH+o4uL/lY+JqRO+VT9wnkUzTvSJT14JRWn6K47WAUjwRfuVeI7AV3Qi7t/mTugmvtGmWJzYRpbj8pwgBpAR4cNZCpJndkx1r1lnnSbXojdCiNYFziN254CgZ2ZIwrax1RJ8u/T+un/h8RNq1Sqxu1aajCUIc9UaV6fNwMm5UukGpV1QBBDz0mMDDgskO2GQOND5yzCdZhPw7ICKPnfbHn+UvlDrC0BdLG1YZ/4pdHvtqPEp9d2fV4QD8ayzmPK7Eao
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 11:11:31.1447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8d3397-a4a0-4483-ef70-08ded82aab91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193

>>>> permission under SELinux (things like JIT or regex compilation need it
>>>> as well). mmap() with MAP_ANONYMOUS will give us a zeroed mapping that
>>>> begins on a page boundary, so the result is equivalent to the original
>>>> code even without a memset() or the page-alignment dance.
>>>
>>> I would argue that having RWX is a problem, you really want RW->RO->RX
>>> transitions, so even with mmap() you want to combine with mprotect().
>>
>> My original intent for using RWX was to generate sufficient Icache miss
>> samples for the IBS Fetch unit by overwriting the code prior to execution.
>> I am wondering whether it would be possible to achieve the same result
>> by using CLFLUSH with RX permissions. Something like below (build tested
>> only).
> 
> So for a test it is fine to have RWX

Sure, makes sense.

Thanks,
Ravi
