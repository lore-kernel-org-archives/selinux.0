Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5023EA94;
	Thu,  2 Jul 2026 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990785; cv=fail; b=eginzoQcdIYnOR1iOpannAUdqM5O9C8ebEIFxrgO4q1UTxY0YBzWGRHSPUrIPIEc7PyxVYC3tq82Ucs6/MBZknSfHAAWBXW35BKRMPfG8Y47EBO74KQDb4kVDMBCk9AXUmasdOdJilhWLOZUTg8HBUwc9JsDyQq8DrEgJ0fXJ4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990785; c=relaxed/simple;
	bh=o17hsrG7f1xJa6zp82mvAYpPwFHfvx8RuItyTr6x+GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l7xPZZK+wQbIKmCQwv+IOGcNWu019lB7dosI8FBaMj0TkoIr9spddB/ryW6tqHSULyvFy04hv4bDQDXsBlYTVUgzjhI3tgBVazge0dUoFAvCK7rFiVugu77yUh3F6d3D4oyTfiHhGo7kpaR11Nq8YsVRoLpC275uGmcjR2dFkoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x8scRf/6; arc=fail smtp.client-ip=52.101.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x8scRf/6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahXoqIfhVwv/ImsFpYTvc2dWnn3ybY4TENKMPkRwIM5TkkhEv3Qowvq2Wzr1qq9TlVmqlGglZx8wr9ugAolshIHTWLujl+pW2N9JWPOQLDqD0ii9g/WglNeGI9jgeM1dZjBXyE+G0s5E6+1ckZgi4TJ5r0Igm3yKD+yDneOz7CBnsWGZ5RLyyADJwT44mIKxR8izFV+BuqMuAbmOdzAD6QSZVnt31L9N40x9x9ACeQkQk/6PFgh0eQDEr5V6+ejdRm/zr3/bIx+U4yS2Xti+p9snGLTE+MELRwzySTxSMMMvG+pdxgiNc7tEUx1P7ZYw23cs133sLsaD/aVjPqnnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A4oDGaOryJKRUeiWpOhhI7JlsWUoKx8toKtY+k8kok=;
 b=TadQGf+i+bajPdZGrbdMjtd0etiu/Bcf8att8oCBBeLNBf9QaR8SadaHn3Br2xkkfifLyAoZAFv77zByi7Eg5I70PB3WLh7Nb3fQZAxqmXNpv/tMWbPdNXCQUJClELORagZT7fSF+OAnSDiUShPEhX3lsqgb5YKDQSgezDNl51/gwdFUTCvqLlRRm/hs2nzCs9IGhnht2swnsdZ1ZIPPW9OjUxq7by+TG1Banmi7PnKpNyC//sNMjiU8OBrE4ZUp7gTURP8CbSI+RbZ7erHMHmNB1o70RNBBU/QFYDcoAKMI/mh7q6Zg38E9e2d7uAkMDhqOHAsYmyLBo2mwYolOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A4oDGaOryJKRUeiWpOhhI7JlsWUoKx8toKtY+k8kok=;
 b=x8scRf/6hHLMuxyzDEygc2SNmNkUJ154BdX/1NCk6tvs3pTHrVoWBL87b+OX6fniPfSbmlAoXvrym5yJCLvgcgQ/tdY48mAHL6cPr1l+Hqz2sRDt8AEsHOKZaVaYZdg4abT+epoIxyc03jZHDjxu7AISVBqUQ0K7nk+n5iAGia4=
Received: from MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20) by
 DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Thu, 2 Jul 2026 11:12:59 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::a0) by MN2PR01CA0051.outlook.office365.com
 (2603:10b6:208:23f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 11:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 11:12:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 06:12:58 -0500
Received: from [172.31.177.127] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 06:12:53 -0500
Message-ID: <201f9da1-46dc-4366-915b-c956ac5994d3@amd.com>
Date: Thu, 2 Jul 2026 16:42:52 +0530
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test amd ibs: avoid using executable heap
To: Ondrej Mosnacek <omosnace@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, <linux-perf-users@vger.kernel.org>,
	<selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ravi Bangoria
	<ravi.bangoria@amd.com>
References: <20260701062321.517351-1-omosnace@redhat.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20260701062321.517351-1-omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 323d6b1c-93ba-424e-1819-08ded82adfda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wKd6D1SQrYS8GX5GSi3SsqVlcoO7dfFfUoiPKaevtgrDNbRyt9RdeH9NEpzmDQ7Yn/yR63JonFkpMvM3fIVq+jeuxRGPNPuMDlNT9rRMS0IwgrfdT/00Y4J4z+mSltLT+VpRUDtUO9bk6R2SYD8clQ9A0vm4G9rS2W2+o/ew9jFukWcrpO+LCE+HDQmXj30vt6EM2N4YrmaG/k17l2oRpgDce47MylGm6u9Mm4ao6GTzw86oyHXTfjrK7vllegWYUG8umGKSSaFpfUw+3Mdwh6GQHBBYAZBhItn0MNbVI0f0T78G1SuRzaX4qcgDn9fZHiYzrZe0GIlXitbVGslxr2Wp2gjY6xkXJtjkEy8VYwSvE8MdmILTGwG3gcKYtWns+b6nBU2R8sxt+Uc5GXdLFmRPMSDgTpzxZ6HaqFUU8Kc+7UG93y2TJwTttflD0MpPX43bxeGKSJ9o5S+tC+vecf13IX916+q7LnjdCUcvmj0MW+fydQcCwhxJpIfhLjWCm0AQd9uuh9K8TIoQbHq2XD65sR5M3ln1sctA1O2NczjIalirNd1bq4bEUu7xcas2mgIrD7Nu/qxtEVSrMboCawSctTTXy3jXywxdBycvhHRYKPPAlFi3/LsVLDQS8svCotKF67hTwRRXfxgl5W5llIsW47rzGtv0eNhsXF5vGMuZnQsMzLj3ffeQHzs7ruBs5JNc0x8V/q6fuf7t8OO+IA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wkj/sUwItU6x8OlEZrD7PxZ156ybC6wLmMo6JXJN4dAhhgOezfJIyrIeDkO4DNTHhjPnvRgQ0J7Bnjg+rtfSopXE/xd4mSAbgDqUyaE44+SyXgqHojPYkizw0SwRqFBza2tvmlnXEe32jDvQ3qjKuw8AcycUxtif3plnA1GqSgEZl7lQfwKjYMENm2HYkHBZTIzcTkUgIWNIRDAuMS+BKr42JQvMz6HwKJzHZfq0VB9ACGSg3PrVNPkEX8DzJT9R4scnDh/1OMKYDjczRImutt4pZ6tZMKIqVd9uNwxAKK7frm6zyfiisAB/kylQMhsRWQV4WiyIWgM50SLYaNDpknBYeXycl2m6RJ4FWxGqyS0/79OBJXMoW702EzR3EYQAdYhGDVI20i69mqC5kuRszLGdW4+uJwy/Pd2U9PQm9FnYAGGWXErquf2TsFDq4rNi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 11:12:58.8675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 323d6b1c-93ba-424e-1819-08ded82adfda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275

> Making [parts of] the heap executable is dangerous and is blocked by
> SELinux on Fedora/RHEL even for an unconfined user. Replace the malloc()
> + mprotect() combo with just mmap(), creating a private anonymous rwx
> mapping, which only requires the more commonly allowed "execmem"
> permission under SELinux (things like JIT or regex compilation need it
> as well). mmap() with MAP_ANONYMOUS will give us a zeroed mapping that
> begins on a page boundary, so the result is equivalent to the original
> code even without a memset() or the page-alignment dance.
> 
> Verified that the test still passes on a machine with an AMD CPU that
> has the "ibs" CPU flag.
> 
> Fixes: 35db59fa8ea2 ("perf test amd ibs: Add sample period unit test")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi
