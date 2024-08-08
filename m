Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF833F7
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140039; cv=fail; b=dKyyQGrx1iVFLh6i8DqL63xqL0io21dCs4TIbVjyZyIiMnisjEwKFaOQUwzzSIfuAiwH18hnvAuby21AjL+qzRWpxribeS7gRkq2DB2SpO5HThILhV+srBvVpiV9OUQXFIApYm7HUWwpAf2NUGzQE+wXt6DUq5BKo7hl5A1UY8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140039; c=relaxed/simple;
	bh=bbJVqoaqrzuGU/IbNaIK/wmv4PZ1nsyT0phAGKbenec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WNXs2VRc9kQsbWT7/GzMpgosxuA61Q7stWNdSd+Rm+JW/MRL0MFcME8IrJbLtrl+JXP/NZbaVAxwR7rvQ5zJzSFULNw96XoGJ284cVo636yhzC9TdHAGRKo6NeJUCmP+6hTR9HFVJ1DqvYsGXniOdcKuYiyAPvRYcDe7QQ91Q3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bJY6bU8e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M8fGfKyv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bJY6bU8e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M8fGfKyv"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478HfW1u012284;
	Thu, 8 Aug 2024 18:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=4RM7flJ/fNy/5O2iRJ8A1tyhmDhqXAOicQAroQL8uL0=; b=
	bJY6bU8eRIIBpI7SnxQ0G0Mums1vwjv8G7Aq4RDML9ErQwYQvIfOOMwfdlI4RAXV
	rqwQRfsah6s0HTwaUBQbyG0kAIGSut+cFX+ulA9RmG0MVhFSaS4f8RUSDkz5KxH8
	wBi3tCaQ/sjOqCoGFYGbXi5fpIH1ona7UKDQbNSi4fun4gtAFK5eaa7/BuaTe0yT
	Gx1dFmbv/sMAq9chmEmwJ4YZgmoy9PICIqAQCeVgwJQ3CVwM2t1jaLD3VWuLnq9j
	jTiAkIUCo2G49j0Sss37OnckNec9+gV0BmVNz8nS4KAtgmBUKBVlnM/zl0bEY+CS
	9uoRVh2mWozRVog0Dz9VxQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sc5tjcrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 18:00:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478HTxk4040664;
	Thu, 8 Aug 2024 18:00:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0c1v4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 18:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf8wbQb5+5LgfRDPaZ3CeNKGNMVhHlg0pGe9AUyfk4FDzXMoLJXTXj4iAn13VoeWzfsC2BCjeUsKxMY8OAjLWr4iZKP6AOeSU56Gh3G/VGyfTGnc3OmE0Fcm0uWo+3nLY3vafEcFiq7bk+XlfRi3jDMYfgguEIco41iY0ci4BJi0x3BMkbA/+KFPJQgIxf22nW4rKr4QXsJBHhr8N+EQpvIqwrel1nBonDmsEZ+m7B1dmyU7KopTuK3lCL6iKT6Ke9bO48x2Ju8uJkUULz+3V4/Gu45kxnlVXnAWx8S8HqPjW7NGWUYFDTPvNXRlSjSH4T2tO26mrUHOPTW782Hbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RM7flJ/fNy/5O2iRJ8A1tyhmDhqXAOicQAroQL8uL0=;
 b=kqMexriL2eBRlyS9zB2OOa4pFdgv5gCsJgU868vIqL3V6gJixsGH+F2gKS2DXueoKMOjua8nX4gD5tAwgfc8XUPmGXiQ6dgUaOJY4TAoPVX5oNeSMXyc2jnLMsRTNeawB+/hE5RtB4pkL7hvZY8UYO2HWN0lD+Nufd/hl6f8l4e/o47Xje6HqY3Y9kgGu4atWkAx8lDC504SZMsDqsh2B6vqZg4/0dnQvHYAhYMom7877iKKy5tlb/eztJ3aKs/WE8eX5MVF5xIFAhRlbmgvLsFNAtgRHMuTH+Fpp2tKCPHeQ3i0w95iuhHgTA/qcSu+QepQPoQ/TwtOhl2mLOYZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RM7flJ/fNy/5O2iRJ8A1tyhmDhqXAOicQAroQL8uL0=;
 b=M8fGfKyv3G4uYc1u7yUR7qJ2WQJ1iaCMs0M1bANO+cW+4NypHOcvqtj8k3VwvH0J6aig7gb7RDb0CaXEwvaw4RZ4jviBdenOZanjKqlCJdhvy1gJNT1napEA+pPtz8Ism4k+gTah316ONHqrT63m5jQv7oloTCT1E0ikv9fXoC0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5660.namprd10.prod.outlook.com (2603:10b6:510:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8; Thu, 8 Aug
 2024 18:00:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 18:00:12 +0000
Date: Thu, 8 Aug 2024 14:00:09 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Marc Reisner <reisner.marc@gmail.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Paul Moore <paul@paul-moore.com>,
        akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        omosnace@redhat.com, peterz@infradead.org, selinux@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and
 vma_is_initial_heap()
Message-ID: <zk5ffj6otbixbnppw4shxgz4tjulagm7du457gzi4qg7zrtdkk@e7mbwyzhdtrx>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Marc Reisner <reisner.marc@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Paul Moore <paul@paul-moore.com>, akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	omosnace@redhat.com, peterz@infradead.org, selinux@vger.kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <ba8477ed-b7a1-4833-a01a-b7d43ddb47b8@huawei.com>
 <ZrPmoLKJEf1wiFmM@marcreisner.com>
 <CAHC9VhSWVdiuK+VtbjV6yJiCp=2+6Bji_86mSkj1eeRL4g_Jfg@mail.gmail.com>
 <7fb19e0a-118d-46a1-8d1b-ab71c545d7ed@huawei.com>
 <0806d149-905c-49b2-930f-5d6d0f8890c9@huawei.com>
 <CAEjxPJ5S9sz4PaRMVLyP6PWdLCG_bBxj7nw53EhU5+L1TM7kFg@mail.gmail.com>
 <4d2e1d4f-659a-428f-a167-faaaa4eca18a@huawei.com>
 <ZrTeT8_pzD8fH-_P@marcreisner.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZrTeT8_pzD8fH-_P@marcreisner.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 05674c57-f957-4c46-0326-08dcb7d3f2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elROTDZFbllsSVdDaXVNbXljaEZUNlNMRU5iNkdNaFpwWTUxZHlkeFVwd3dX?=
 =?utf-8?B?d3lvY1hWeW1wcWJSWFhMQ3BsYWdpNEhpNngwaVdtbGxnbjRrVTJWNHRvUlkv?=
 =?utf-8?B?VTBzREJBN0FaR1psWWV2aGdxaDF2bWNKT0VBcTFocWxzL2Q1MEl5dkE5YjlJ?=
 =?utf-8?B?MjAxcDdrMWlTdHdVYjdWVjlhYlgzU2lmSlRMTGpLRGJ0bUxPc2hhcmU5M0pw?=
 =?utf-8?B?NkQwa0hyUnJSVGZmbTh4YnN5Q28xYlEwV2xoOUl0TzhCazdEY1dueVJKaDRT?=
 =?utf-8?B?YU1GenZDN0VMNEc0R1BKODMxRUVhaTIvSzFwQkV5Zmd2dnBLbGFIYTFsak5Y?=
 =?utf-8?B?eUdXS2Z5N3VUTTZMeXh5Q2hLWHIwaHlFTlNEenE3S2d5VnZKMzArVklXZzd4?=
 =?utf-8?B?SVRwRkRJRDRoQ0xEMzRvMTlmaHBlTTY2ZFlrTjdJTEhURG9VMnkrYk5XdGVB?=
 =?utf-8?B?alZYVDkyZFAyYjJpWDNFdWxPb1ZIeUdBWnNvSDU5NEJ6UHFhNE1sa1duaCt6?=
 =?utf-8?B?WFp1MlF1L3p3VnYwTC81ekI0RTBYWHh1Y1lLNS9qbXB3bnFLS3lPQytZckRh?=
 =?utf-8?B?aitwdmxOcWtDSXlkYTdGMW94RjRnR3hkMHg0RzdiVXEyVXJBOG5TTzZjT2NG?=
 =?utf-8?B?UzlwdkF3Y25NRzdvUEJ4SnpjWmtEWCs0ZlJ5Y1lIbXZwSXA2ZHkzUUk5SlVK?=
 =?utf-8?B?dm5NYVdqSTlyRzhCL0hrT0IxVFcyWTRDZzIrNjczRXJ2SGI4QmpUaTUxL3I0?=
 =?utf-8?B?Slk0aE9hRGx1SUhXVm1QOGVjcDNwNXA5K3plZ2dsZ2YzSE4rUzdOeTlTSE1a?=
 =?utf-8?B?Rm9tbnpPUkdoZTVUa2UrQm4rUVlXYzFtalFRbVYvK0QvQ2I0WHNLY2lEenBE?=
 =?utf-8?B?UkNWSWJVQkwxNFlLLzVrQnhOdUI5R1pQTHpwNFp6UEdSazkwQTJQb0p2TnFh?=
 =?utf-8?B?Nkk5RVJLK1VxaGFYT3pRUXlQZ1JDajB3YSs3ek4yZ1pVQzkxZTFqdktiWTRR?=
 =?utf-8?B?cmNyQWxxRjlxNnpkNEZUdTI0M3NvZ05veHZNQU9KNTJxU1g4VXBmQUMyZHhC?=
 =?utf-8?B?Z3ZncVFhTElMS1lUWEJPd2hyekI4bnhxOUNtRE40V1NoMHBkbnJaekFxYUdH?=
 =?utf-8?B?eVNNeG5pMDFPRXNLOWtoTTlsdXA3S2E3bkhyeGE3M2tOcUp1dmowWEYrRzBP?=
 =?utf-8?B?Wmo5djFFcUFNeUwwUGhnMDl6QTFITzBZa2pEOTNld0tuK2ZIMHgwMU9mWVNq?=
 =?utf-8?B?NTVhTEhDMjlLRjB4cm9tUmNVRUplbDlnc21TYW4ySEVjdlNydFpHMzRzQ2tJ?=
 =?utf-8?B?aDg3T2RjbStXUHNZTENUdmZ4Z2Ixak1Pd1hQZ1g5UTRuNHFtaldLNm5uZ0Zh?=
 =?utf-8?B?UGtUN28wMklmbUxBb1BySFlZdDR3VklCSXhIMWNqMHhNVkRndGJnM0thd3Zs?=
 =?utf-8?B?ZFVpK05ZYVNQcmRVQkdGaEsxQWd5VnJYcFJyWFBuUEFJc2U0QURkd3JkcjQx?=
 =?utf-8?B?QzRWTTBvU1lvUFNLbXE3WnpBWVR2MTY2TW9QOE9TWE5zc09jTDdDTjIzSWN0?=
 =?utf-8?B?UlVIQittbzBYYXNTbmhwT2IvV3lCUjUrcWFDS3Z6R3BTYUxwcHFRbkFwTnlL?=
 =?utf-8?B?Uy8vbmJ3K2VCako2Tk1yUE45THZsY3k2a0FGRWd2SkVES3lKK2ppazlxWndN?=
 =?utf-8?B?UDNvSnh6cHlVNlhXZUxzeVRLdE9kdkQ0MFllRUxMbUxrcFlqSUlER3pTenhx?=
 =?utf-8?Q?MLkd63wwiWG78bRWtumDbdJ88burRS7xQ3iOOsy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0M3ME80dlFwOHZuNFgvNzNMNVpYSndOQlJwNjRLS0lPa2cwR2ozQXpZdGdU?=
 =?utf-8?B?aWJNQ2ZOT1I1OVVqQzB5eWUrYmdtNi85K0xvVzNBaHMxVDhtR2wwMENnUmlp?=
 =?utf-8?B?Y0ovMXFvc1JsRG9odS9xYkV6SVQrQ2ZHa0t6Y2tnTFNabjNxdk0yU2crdEJj?=
 =?utf-8?B?NFZlTTUxdmZMN20zdXA1N0F5MzZFTEpzcFAybUhNNDZ0alovRXpyUUJQekRI?=
 =?utf-8?B?Q21aWWpHbk9lWVlOeHJEQTA4UEErYmZVRXJLZU9XVUd4TlFmaG5sdXJzZ29s?=
 =?utf-8?B?UC91M3VWb0hkZXRBemsxYjlNMVBvdTIyS21jdFhOTDNlU0c5NjJsdnFIQzVt?=
 =?utf-8?B?Q2VGY2ZNMmE1UktjV1p0M3Q3cklOWEJzd3lXU1kyM284dC9CZFlKd1ZvcTlO?=
 =?utf-8?B?c3pvU1RoWFBkRysyVml4TXcyeUwvWko3Qk9xNEM2M1pSVEVzZFhBUlZlbTNy?=
 =?utf-8?B?VDRjMWJLYU9uS0U5c2g4dklSdDRhbjRGVE00NVJ6c0tCejF2ZkdmODNqT0Z4?=
 =?utf-8?B?NVpoTFpqMmhiWUNWTkplRmRhdXA3YksxcFF4Z2NRTSsraUl2YmhuUHN3ekhk?=
 =?utf-8?B?QVlJbXRrbXUrcVg5bXlFbjVEOWVJeENQWDhsL1RDQmpQUC85K2FsWDBjZDl1?=
 =?utf-8?B?bWxyc3BoSnBIOG5KS3BiTi9HQnJTbmxZdUl0eGpxUThSRktVem1tWWxFZlFC?=
 =?utf-8?B?b2xxUVlQeE42NTE2b3FXTUFMekwrMnJJdE1qVWFWQktpVmEyRmFsSlUzRzZz?=
 =?utf-8?B?VE5iSXh4ZjYvc3E5ZlBpNVY1OHVJdXJtcm5adXByT21ac2VTSXVGazVBZHI5?=
 =?utf-8?B?OG1TUG5PQ0N5K3Q4UWYxTXlCRVYxN0s4M0NZaUptN2JsczV1dENTNWpwN01v?=
 =?utf-8?B?YUM0NXN2RUZWVDk5aVcxSTdzcVFvZ3greXFPM04vVmxqWTNTZjZndzhPeWpo?=
 =?utf-8?B?cTJXbGQrMkphYmhHUGdsY0ZqRkNpbjRJOE1tSkpVTDNuYm4rRi9pWk1uR0xT?=
 =?utf-8?B?VTNSdUlRbUREU3BoaXdhZ1lFdnViYkRwK2JWb05nSm0vYnJyM0FJaXk3NkQ4?=
 =?utf-8?B?bVNvdEE0SVB4U1k0dVQ5Q3lGTld3dnBKd3ZPQnFOb0RGVklJTy9YKzhBMm0z?=
 =?utf-8?B?TTFReVZCN3VoazlqV0Zqb1RHYkVsQ0VydE85NTY0OE5tVXlUc0JSbUdhcFBM?=
 =?utf-8?B?eTkrSDJlNm1YS0JuUERTS1FVLzZRemNPdFFUTUJ0M085dTdqdmpvQ1lrOEtO?=
 =?utf-8?B?RWpWWEJnL2IwTW5uYnE3aEErMExRRXcra1ozQ1VSaEY2VHVLZTRKU0pvcUdJ?=
 =?utf-8?B?d25nRU5keWpEbjA4Qk4ySHJIM2RDbFpyZnNkVlBoWGM5L0tpS3ZzQ0wybzRq?=
 =?utf-8?B?UFdjeC9RODZ3MlAzb0RTY3I3UUJLdU1Ld09kUGZtcXM5V1dOK2V5eEsvNWN2?=
 =?utf-8?B?VjFQd1hqWWdDZkhvYXNxOTRLNklCeXMxK0hWUkd0WXRjU2JpcFBLR1BqcCtT?=
 =?utf-8?B?a3F3dzFESTRNUjF5VEJuMDFWVmJRYlV3YnhpanI3Um56OFJyYUNCL2QrZU96?=
 =?utf-8?B?RWlvNjhRSU1CNk9rQlUzU1NEbXNWVi9SaWVranVySHA2WURScEhqcVUwcHRR?=
 =?utf-8?B?RUpPOXpsaGREVEhEclYyZ1poOXhXa3pCaFRTckVRZHBkSy9CTWdGTGF5OEdw?=
 =?utf-8?B?dTcwN0tnMEI1a2IzcFY2d1laaXRVRnY1V25OY1dLaU9wVjZQSTBkVDIrUXc3?=
 =?utf-8?B?dVlNY3ptdDdHZ2RhUTJnU3Z3Y0d4NURGZlQ5L0dPTHRmSnhIaFZrcUJ2d3do?=
 =?utf-8?B?cHBOYyszdjBlRExBNXlpUFIvZGhFQWxrRzJTaVB5N0xVZVNpY2k0alJQTmhq?=
 =?utf-8?B?NUd3N2ZyV29YbGlRYTcvcVZGQjVOWjUwbEo4TUFjN2E2RFlxUHFLRUZnYUNw?=
 =?utf-8?B?dHNTTXFVcmlUMzdqbEZqTktGT3R6dmNBMmNGNmI5cnF3ZS9ySVozTWtGai9N?=
 =?utf-8?B?bnZudERyc3JDMUtjRFV4UVBhYVlreEltSjFKd3hhYXlMNFEwRUNiUDN2cm5i?=
 =?utf-8?B?U3lzY01qOEdQaTNNblNPUGk3NUZHSWxFUjJiM3RGSDdLWnBEQlRjT25qbVR6?=
 =?utf-8?Q?7EnpaiHSQbTj4K07MiuNHBrjk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vHCmlFttPf8sKvr25GRo4l6AuGc1mt7qsNcXDEPVdYTxEo9eQKa9b81uxmZPVTGgQMbo/bIgmr54MkduOetqkEIBU5eF8pBNvpytLEK02NqzbTjBht7AEAtB+0qhUe0gCJ8aR3m2LgYF5y9k4g0rAhFkxrwxBx2DGmzBgk9rT44JYP70v/7NCoXRCBr9YDikxg5VaaGKxoe4s/Do4fMrM7NKkADrrO+fcop+cPypPAwNYEgniiEciiRySL/xE3sxVEPm40/8c8XzCeglqWJS8VePAtLGKltJczUXm+qS0h0Nx/Vaos/2RnMUCg9w8c0YEsgOWS5HusCg2y99isJsrMFfAtl84m0QpOD6r5zKfFsd+KAqLPuxlxZvGHvVKNFgdJu1iUxgNkiigzACbROHHTx7A3ab2KkFcOfyHxzAp9S5815gRwY2nl4Ylg8941JeUMPMxTgqmRTryyZRCuIYRHbPF8D8kN+aMn+Dj9sKMGFSWempeY/bZ+JIeAtlzrJtLxHKi4RgdfVHvATN5YfOq6xTvaSbB7SkgLSg+co3qzUuoxgmcxLCb1xt2TpsCNd1mnpHrgUld7WinlzxOxnigRcLCrQJk1PGlebOrJfES9w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05674c57-f957-4c46-0326-08dcb7d3f2a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 18:00:11.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krPWOa4n6CRmFo9QA2nrj5WBjtWjN+B0iMQe2cEg/9pqeDMl43QiV1j6bJNNxj8AbbWfnWhh42JVhBCi4nOGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_18,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=994 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080128
X-Proofpoint-ORIG-GUID: 0ReFOCkRDPwVKjHj3ONEBTzyWXYq33WW
X-Proofpoint-GUID: 0ReFOCkRDPwVKjHj3ONEBTzyWXYq33WW

* Marc Reisner <reisner.marc@gmail.com> [240808 11:03]:
> On Thu, Aug 08, 2024 at 09:12:59PM +0800, Kefeng Wang wrote:
> >
> > OK=EF=BC=8Crevert patch is sent, but I am also curious about it.
> >
> > https://lore.kernel.org/all/20240808130909.1027860-1-wangkefeng.wang@hu=
awei.com/
>=20
> I am also curious. It seems like the "real" fix would be in mmap - my
> understanding is that it should not intersect with heap, even when heap
> is empty (start_brk =3D=3D brk).
>=20
> It looks like start_brk is fixed in place when the ELF is
> loaded in fs/binfmt_elf.c:load_elf_binary (line 1288).
>=20
>         if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_spa=
ce > 1)) {
>                 /*
>                  * For architectures with ELF randomization, when executi=
ng
>                  * a loader directly (i.e. no interpreter listed in ELF
>                  * headers), move the brk area out of the mmap region
>                  * (since it grows up, and may collide early with the sta=
ck
>                  * growing down), and into the unused ELF_ET_DYN_BASE reg=
ion.
>                  */
>                 if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
>                     elf_ex->e_type =3D=3D ET_DYN && !interpreter) {
>                         mm->brk =3D mm->start_brk =3D ELF_ET_DYN_BASE;
>                 } else {
>                         /* Otherwise leave a gap between .bss and brk. */
>                         mm->brk =3D mm->start_brk =3D mm->brk + PAGE_SIZE=
;
>                 }
>=20
>                 mm->brk =3D mm->start_brk =3D arch_randomize_brk(mm);
> #ifdef compat_brk_randomized
>                 current->brk_randomized =3D 1;
> #endif
>         }


Have a look at the mmapstress 3 test in ltp [1].  The tests pokes holes
and mmaps into those holes throughout the brk range.

[1]. https://github.com/linux-test-project/ltp/blob/master/testcases/kernel=
/mem/mmapstress/mmapstress03.c
