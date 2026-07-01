Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA5379C2E;
	Wed,  1 Jul 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925158; cv=fail; b=Yb6+XRnTz+lDUJqzPqIrn8ywmkhH3CyO39t17bSIQN0vWh2zEzoDmyvcgdg+lFkQOaIm4Ad0tQbAWT32WC21GvkVhGXG+ndUE23C8SzMsyUI9uMSNptT5Sy1eqDM8LcFSNGmOYhrsZ3C6uZ192zXOWP+CXnlBi2FuPq2Tho6rHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925158; c=relaxed/simple;
	bh=8sI+APVMF6IkCBIKAJtTI1y/OIYns32fAgRggJADvbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HpIlJwu7M3lptS8LB6ji77EjS5exNRBMrmZ2zeQyQKyTe6PJZnLBlIvCbPjNGWf38D1scdaeSC4+ibg8fwA7hfwfl7YVFGm6uKI9dCr0L6qK0HGlI3Q9TjxkzPF1HscGSyKyxIJ0/XmMDk69esSJ8loQXrJC3vHQX4Pn8Q4i8AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aoT+uP+S; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aoT+uP+S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mfy4Fl4dqh96r9qhwOfBj/IAXooQ6k8Cp93PYiWfVwJqRSt0fAwNLND+Z5ZAMZ/qzYLU6kXI1rZ9zIY2CRMRAKf/QUxU4uYuDZuHrITDAJlvtIDxyRsZDxr1sB0UvnnsyHIiygmSJ82SSYQSji5t8iMxwthG8SxTPvceSF/mEPOjYvO3vF9OnXSTtl6qmLCJAuqTp6rrcoFM5yHW/mR2o+dAZAnT23aUKOlNfTJEV5S7Q1u7kahZyvBcK2aDjkhbtZg8IEjzDIfIchWnRLUOAztMhwbgze4/Vgy00zOcrOGue2JrPV+MtlrT6Omg50gRxUCZs23Vt4myGJO9zWNpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCw3i/wpMBZD7i9YAHgSt5kXtctC6cEOXlnzK90iMTw=;
 b=IYyHJtsW3dsOhwUmdwUGLjRS2/M/sR191kc8gdFz8n5gvJLtNO+0+28X8FkPvsoCkEzEaooNZS9eun1a5RV6j9AKn+QUKLcMOXTL0P267zzC1/ihS0RSzVAcG/4w8b173zmroZZB2buHzYIaTHkLxYNflRFuwGnKr2KEDVTcq6CHdfD6pRjRHhujlTTigBdRxskEFXUjglCheC4sgIP55izYC6UdXewNrVQsMmSMyVg+OSQDA33+U2xMIrkWOJryqqFm9Oqy/gAVCbux0+9vC51YroM6vQQvYCzixsi2gHSICdLpgPSdh/vkBWWhoTXo6t6v2nZ538bLNDvDQeklbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCw3i/wpMBZD7i9YAHgSt5kXtctC6cEOXlnzK90iMTw=;
 b=aoT+uP+Syi8855xpL5eGchIXnXU0YswZt6ix4qFye/1i28X1icAG404uGrYJg8HEkvSg98LinTmZkYOVZ6mAHyFQNNrv/Edx+D7iDHZnVve0gjTMV6cDThmzDKpLtNPqmuM9G3X8w7aZB9BS6W16A/LQn06cNRrTOj0jdFHTdRE=
Received: from CH0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:610:e6::12)
 by BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 1 Jul
 2026 16:59:11 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::8c) by CH0PR03CA0277.outlook.office365.com
 (2603:10b6:610:e6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 16:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 16:59:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 11:59:10 -0500
Received: from [172.31.177.127] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 1 Jul 2026 11:59:05 -0500
Message-ID: <43dd9d9f-2348-43c0-8af5-77ef260c64a3@amd.com>
Date: Wed, 1 Jul 2026 22:29:04 +0530
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test amd ibs: avoid using executable heap
To: Peter Zijlstra <peterz@infradead.org>, Ondrej Mosnacek
	<omosnace@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, <linux-perf-users@vger.kernel.org>,
	<selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ravi Bangoria
	<ravi.bangoria@amd.com>
References: <20260701062321.517351-1-omosnace@redhat.com>
 <20260701064301.GH48970@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20260701064301.GH48970@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|BL3PR12MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c425a7b-c73e-4d69-c429-08ded792127c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|7416014|36860700016|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	/qc2dV9LMkXX56jTUK86AzpjzVu6i1oO9F9C2OCAVMRJv0Kfb8XGBY2ZUwE+y+HDOp/c6jbS8BMXG6VQQ3MLp6zWWF2fXkHJp5HZcZd6pQk6DErf47MwYRiZyR5eEQS7wWH49wATADmrQ3jy4j5f1vBlApUvzHDLrs+Cm+P8IOeekf+zpkHfiwxaGY0gU0LDHqGOl0Dlc4UHS8RhgX0rC0odc5l87W3JKWGnPZtxv0g7JZm7rAvrkXNr15ZyqyNIbIuUrg+iYDY80cOgU7YRYp0DEeZatSMP8NQ11Q+gvCu1Mj3sGlzyMDyMI5cxeYSH9fs8h06758h/kaWm4OoMVS37uHGVDcx9ThIgahV9FqfGMftuT4dxihMje6S17HVzxpj1jdIghc/4SCBSjcAbY3b0JLC6SCbj64pYOD1Mqx3y9tKjWNldzArNoNkbV8xrlWV8I7sFkw+qRCZamF3Fk6dPML7Qf6OJ3DmtzWTQQV8GH4dEG2HMcHIc6PQoCyNnbW/iqm+N06/vgP7iPojdmps8c4IPkpDJSHPJYa8DYZGYgSDF/026Sude9ihgHRRxtVjKA7s2EdPLWiceUjkfyTJMgbASJXwSazXi9QfvwYWl5ikg07VBNKZy+DWuNOqMSTbisjpWKpidjxIXgLZk/oHLeLRbuR3aws99KVEKe4mGor8Kcv4NQrsCw4WxYTEFyKNr6etbK/hqLr4lmTWPaA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(7416014)(36860700016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pBLvlroYuPxy7nYOa6C0MXE2k6LzRV+A5CARXY6OVMDQbZHXyTk7p18P2ynyY/KZAbznEm0c3/+Un+YHR3AZo8aAeBiz62u6wsbQFaHgt3ZBpniBoSOgNgE1YZReHwwblDk2EIm1og9kn0cIuq/z/eDII1NNJQYcWRcY3k3ZDy1tKrGeFWeGbC1y/iFtyO8MO8sCkvgvEfsyiYO6z8KAF/CGeI1n0G9GznwzSVfHuRFAEED61b0AOy45wk+6N7SRQqLLMC6DALOSd8xB8t0ZCAeo8xWMSKehRdiFBCZIxR2LDRlLmozU3UHCfSncKSS/S/gj816FUfaj3Hw+cOrQcyDH1VamcLD0UgjNaWw7J31yih+urM0LMZDqQH8s9rdzhEdWOlwdNKXBLFtOzVN2jCfkIE2AaZ+Y11PlqcoSvC2b5I8WKf4FuB2gAP1qhDfT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 16:59:10.8010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c425a7b-c73e-4d69-c429-08ded792127c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051

Hi Peter, Ondrej,

>> permission under SELinux (things like JIT or regex compilation need it
>> as well). mmap() with MAP_ANONYMOUS will give us a zeroed mapping that
>> begins on a page boundary, so the result is equivalent to the original
>> code even without a memset() or the page-alignment dance.
> 
> I would argue that having RWX is a problem, you really want RW->RO->RX
> transitions, so even with mmap() you want to combine with mprotect().

My original intent for using RWX was to generate sufficient Icache miss
samples for the IBS Fetch unit by overwriting the code prior to execution.
I am wondering whether it would be possible to achieve the same result
by using CLFLUSH with RX permissions. Something like below (build tested
only).

--- a/tools/perf/arch/x86/tests/amd-ibs-period.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -25,6 +25,7 @@ static int page_size;
 #define PERF_MMAP_TOTAL_PAGES   (PERF_MMAP_DATA_PAGES + 1)
 #define PERF_MMAP_TOTAL_SIZE    (PERF_MMAP_TOTAL_PAGES * page_size)
 
+#define mb()			asm volatile("mfence":::"memory")
 #define rmb()                   asm volatile("lfence":::"memory")
 
 enum {
@@ -41,10 +42,16 @@ struct perf_pmu *fetch_pmu;
 struct perf_pmu *op_pmu;
 unsigned int perf_event_max_sample_rate;
 
+static inline void clflush(const volatile void *p)
+{
+	asm volatile("clflush (%0)" :: "r"(p) : "memory");
+}
+
 /* Dummy workload to generate IBS samples. */
 static int dummy_workload_1(unsigned long count)
 {
-	int (*func)(void);
+	int (*func1)(void);
+	int (*func2)(void);
 	int ret = 0;
 	char *p;
 	char insn1[] = {
@@ -59,33 +66,42 @@ static int dummy_workload_1(unsigned long count)
 		0xcc, /* int 3 */
 	};
 
-	p = calloc(2, page_size);
-	if (!p) {
-		printf("malloc() failed. %m");
+
+	p = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (p == MAP_FAILED) {
+		printf("mmap() failed. %m");
 		return 1;
 	}
 
-	func = (void *)((unsigned long)(p + page_size - 1) & ~(page_size - 1));
+	memcpy(p, insn1, sizeof(insn1));
+	memcpy(p + 128, insn2, sizeof(insn2));
 
-	ret = mprotect(func, page_size, PROT_READ | PROT_WRITE | PROT_EXEC);
+	ret = mprotect(p, page_size, PROT_READ | PROT_EXEC);
 	if (ret) {
 		printf("mprotect() failed. %m");
 		goto out;
 	}
 
+	func1 = (void *)(p);
+	func2 = (void *)(p + 128);
+
 	if (count < 100000)
 		count = 100000;
 	else if (count > 10000000)
 		count = 10000000;
 	while (count--) {
-		memcpy((void *)func, insn1, sizeof(insn1));
-		if (func() != 1) {
+		clflush(func1);
+		mb();
+		if (func1() != 1) {
 			pr_debug("ERROR insn1\n");
 			ret = -1;
 			goto out;
 		}
-		memcpy((void *)func, insn2, sizeof(insn2));
-		if (func() != 2) {
+
+		clflush(func2);
+		mb();
+		if (func2() != 2) {
 			pr_debug("ERROR insn2\n");
 			ret = -1;
 			goto out;
@@ -93,7 +109,7 @@ static int dummy_workload_1(unsigned long count)
 	}
 
 out:
-	free(p);
+	munmap(p, page_size);
 	return ret;
 }
 
---

Thanks,
Ravi
