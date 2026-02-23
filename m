Received: from mx08-0015a003.pphosted.com (mx08-0015a003.pphosted.com [185.183.30.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45332ABCA
	for <selinux@vger.kernel.org>; Mon, 23 Feb 2026 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867061; cv=fail; b=e3FQ5BLKLRSjHG2Jp9lIbWP0rZM+Ubog+LbT8E8Ti4Z8VPn6uuGCFh2xmsDYUk0GfeP1I+i4TrfIrZvJ7mKdXZhaD5GqdY+C018p0IjTnzZ5tMHtYsRjqEx1FD97x9TqQU8BeHs6J4QVGQoSDyk/V8moFnCs3P/9qte39HKTWZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867061; c=relaxed/simple;
	bh=lfnDUa3WK2vwW6O8hASMwlrRwyBhdsaKj7javzlpRC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YHHzczfWR5ZZITr6J4ksqM/DOWCJIR9IqeT/rRfmTrrQILBtP0hw5OE4DGqozMuh1+k0kkQuc+d0Wbtgt5zkzBmZKylGGep9BsSAmrqKe48s0rgtu7i3Wa6/jonZKUJMzYSHUf96p3S6pYjCG7mlWR7uBF4rIjg9q56xE2yVVVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=entrust.com; spf=pass smtp.mailfrom=entrust.com; dkim=pass (2048-bit key) header.d=entrust.com header.i=@entrust.com header.b=m1zGla2m; arc=fail smtp.client-ip=185.183.30.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=entrust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=entrust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=entrust.com header.i=@entrust.com header.b="m1zGla2m"
Received: from pps.filterd (m0242863.ppops.net [127.0.0.1])
	by mx08-0015a003.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NDO0RF3934045;
	Mon, 23 Feb 2026 10:47:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=entrust.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=mail1; bh=lfnD
	Ua3WK2vwW6O8hASMwlrRwyBhdsaKj7javzlpRC8=; b=m1zGla2mlnn5d0ytu/pr
	/0mKPbpVO7FSO2fY+Eh/8O2LYMC2UyqB1mEURFuoYKk1JnSuZyJK+LO6tmmvfaxr
	0LiS3V/V6Ah75yo7c+g6GjST/ylRc2X5Ug2st6pnFLq5cD4ipI+xi493DOHrPYoQ
	9/JUwPcKE1A5Z6BvovOQnQw+GBwM8dmMDKLryNMXaGKK2f/88YO9BZLheIJ9UhI2
	xKfb82Jd9DDPeiWVT0oHB/NzdzWwk1yMAIdiE6fx6ZqZ0SD1EQui+tWo7hAYH8p4
	2NgicxOKe4fK4EE9OKtgYbKKSVP7//m9MMKr5XAWxicsbNn6DQaA29SlrYUBRC1p
	6A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020129.outbound.protection.outlook.com [52.101.56.129])
	by mx08-0015a003.pphosted.com (PPS) with ESMTPS id 4cf8jpkx3g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 10:47:54 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXVIDSyXyZKMRamaUKFhDCUL7AP/rq371ylU3tui15tQKGfgtpplUIOL0taHexhPXD6Cu6T3BbpdzEcpIxdpAEkA/wYFLHnQ8/K1IHWBUJmt4IcG/qDYpIn5aSpbIRjcR52VkotgMmvqL4t7D8oaShM4H68R+J+iuSqVDJUJCY64SyvqmEAwvdEn5iCgISuB7VNjsffUPc94ssY9x0oldI/t5DQCSgrSKTV/mB2eVUjyn1wSDTh0gZiNQMZAWDHDH1Vr7SZDhX9d6nmcA7+UXVUlqG9eiZL1qsmEzaqdhs36PdqJa8FhQipzV+6IhDlKkUTbIqmhwOphsh9yP5DeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfnDUa3WK2vwW6O8hASMwlrRwyBhdsaKj7javzlpRC8=;
 b=eMmKAi/Vu20fF3SczMzmgZTdZSO8Qem4ufg82k0bDX4Q7brZkVurBA4bq/DxpWMTCgwYdmvUhvmwdkodQqxZMUW+0nfdv0aPjM3jkcbmYItPQglJNvnMXuYN1cDe1MscxvHx2SsoGjVwmKRjSsabH0aWgSxQ+tJAyjbvt3oTpO28D2zTeu+m3eImHUok20LB7rlqbA7vkMAx9CZOxepEOlcQpL8tP0v9L0tco+fg0sPvnCpzJZsZWqL2hyyXVsD3rn5czadyT8nqF+b/TGmi7sT8iiTQI0Dg8akmeRY5KSRIykhyORS/qHAD6z+r8NOmASD5D3UscK9Fo5SG6f9CyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=entrust.com; dmarc=pass action=none header.from=entrust.com;
 dkim=pass header.d=entrust.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by IA1PR11MB7197.namprd11.prod.outlook.com
 (2603:10b6:208:41a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 16:47:49 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::5b66:a716:98b5:3316]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::5b66:a716:98b5:3316%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 16:47:48 +0000
From: Martin Bonner <Martin.Bonner@entrust.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
CC: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Missing audits
Thread-Topic: [EXTERNAL] Re: Missing audits
Thread-Index: AdyU98MVl2YjIjwCQCOJLsJiRiO9TAAUp5qAABq6pAA=
Date: Mon, 23 Feb 2026 16:47:48 +0000
Message-ID:
 <PH3PPF7A88A980A2ECF46C2CF01AF290FEBF377A@PH3PPF7A88A980A.namprd11.prod.outlook.com>
References:
 <PH3PPF7A88A980A236C1D23F1FDB87FAA2CF39BA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
 <CAEjxPJ4BP1isHT2T0sL1K58bLycwocG8FGFK2OSrkA6Qc3Pxag@mail.gmail.com>
In-Reply-To:
 <CAEjxPJ4BP1isHT2T0sL1K58bLycwocG8FGFK2OSrkA6Qc3Pxag@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|IA1PR11MB7197:EE_
x-ms-office365-filtering-correlation-id: 3485eef8-61f8-478f-ddf1-08de72fb4716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7142099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFhHTXlVa1BDSkh1WjQ5NjhyRkE0UHYvdkdsYnBUN3Z0SGNvY0V5RTN4bUZa?=
 =?utf-8?B?SThHNlY3T0doVTFGeFZoLzM4aGhNOEQ3NWFEMXREbnlmY3c2L0hXWXF6ZUFK?=
 =?utf-8?B?RXhaLzhrYTFyWlFrL0hLdHJiTzRjbndCVGc5bEFJYnVwL1Z0Qit6Nmc5dklh?=
 =?utf-8?B?VWMzU0Jpa2FqM0NUSEdYdE5GejhNNDQ4Z1c5bmRwOTVJZjdTS3NEclZ6Y04x?=
 =?utf-8?B?aktxbEVIbnJ5emQ4bzVwSmZZMkdablBjdEZvUG15dWlaVGo4Z1d5TUFRSHBi?=
 =?utf-8?B?VTF0ZkQ5Nk9OVjZwUWZHV3Eybk1xTyt4N21IQnhzYXFJUFh5aU40N2FYcWhQ?=
 =?utf-8?B?RFdzSEQrOTk0aTRKZCthUTdOTXhHNUc5MEgvT1ZQcHJvTGZEMTNPOVVLRGxR?=
 =?utf-8?B?V2hrckMxOGlpUjBkdGJsTG5XUFlVUW1Kd1Byc3FYTGlJNllMMlRjVTdKdkUz?=
 =?utf-8?B?TUtXRjF6ckNRdU9QcFhjZzcrckhsblhYY2tpL2p5OE9nbTFYRGUrY3cyT1Mz?=
 =?utf-8?B?K2U1bnJVR0VKL1VYZEFCZS96alFCamVYaGEzY0VZb25va0lNQ1RNRHJsWjRa?=
 =?utf-8?B?ZjllczBwNXk1YS82Z3ZRWEIrNFFQWkRLZmsxRmtPRlkxUUhzMWpsZm8yNjBt?=
 =?utf-8?B?VTA2Qm1QaklWK3VheEFMUDVZcGFvRnhlVURGYW14a2NwOVN4VDZUbmorM2F0?=
 =?utf-8?B?bHhGd1VtWmduNmRhdDZ6dUJZUlQ1czFEN3FRZVZpS3dBa2sycGxyU3Y4azdN?=
 =?utf-8?B?SS8rMGtaNGtFRzhkQ05pM0wwZ1VYajdOUnhBVjJQV3pKYTR5elhKbVFTTmNo?=
 =?utf-8?B?QS9yaGd1NlNidEVlNnlZdElNSnRyZGJlNTFmN01EbnVlMUxsWTZxbGVlT1BF?=
 =?utf-8?B?VDV0Uk5ySFdWdWZMeWRtcy9UcEJYZWpXRmlLb2RMYVR3ZUQ0UnFtck1BdkZR?=
 =?utf-8?B?czVzQm41VEEvZWFVeCtZd0xZcDhNVVBpamt0Z29Bc3JkdzZJa2ZEcW9Jb2Q2?=
 =?utf-8?B?SWNlVzVYOXY2enRpblVqWGlDM3pUL2J2dU5QNmlnbk1yQjJ3bW5hNTRJWHRp?=
 =?utf-8?B?enh1bThnd2JPbGY2VmlqTVZzajd3SE5QcVFodGs5SVR0RzZWSHVJaHV6NTgx?=
 =?utf-8?B?NHJQbE54WllKS1FUanBEKzNMZGtZUzA1c2l0Y1RGL2dHZW1OdUhteDVaM2k2?=
 =?utf-8?B?ZjN3V0gvRkk4R2NNQnliT0xzQkNqSkJJRFN5cSt6M3o4bDkzYlJxdk1UVHg4?=
 =?utf-8?B?eERRUTlSaUkrS0ZrblBkbGVaTitXT1NCYzFITlZBM3dkZ0gxOFZxZTBKMDUy?=
 =?utf-8?B?TG11bEVUZ1QrZlZJL1U4VFptL2NQVzNxS2R0bGxpRVpTN1lQeUlvNVd6OStD?=
 =?utf-8?B?UzhldUlMMjFkeFd1L1RYUnV6TTU5Qk85OGJMclppTTdUY1FnRXBEcVRCZ0Vj?=
 =?utf-8?B?TW90ZFJxUVI1MlhaZjQ3SU4wOWJ1TmNmY0xsMDZFRjNhcFdoRUR4SGhFc0s0?=
 =?utf-8?B?QkpmR3JWVWwzYnc3WGxMeE80RW5tRURXekxzNmFNdUE5M1VkbjFOOEkwUkRn?=
 =?utf-8?B?VW4yZzUvR2ZBeHlRaU5vbksyV0oyb1VaM05zemFyd0NrZWE4RENzSzZITWlK?=
 =?utf-8?B?WlM4VGJBcDVjWWVqdnhIM0RhUjUzbU9kL0c1YXlvWng2ZUREYXpJMkYwdS9F?=
 =?utf-8?B?Y1ZFcTNwdVI2MmFvbWxXa2RlbHJqcmFSOTVVQjlSYitBOCtxOS8xblRNNG5r?=
 =?utf-8?B?dFA2NWhDM0NxenRjMVp0ODlpQ1JlSG1iYUk1bjZZQnRrT1A4VnRsbzZrNzVt?=
 =?utf-8?B?MnNoUE52R3MzaGZ6UzN1TmpadzVBYVY2c3haSW8rNFc0RFlaYU5PVlJLSksy?=
 =?utf-8?B?S1R1dk5jNmtkODRLSWNvSUE5VkFrZkt5YVA2OG5CUVZXR3o4a0ZJVk5DQ3Z1?=
 =?utf-8?B?Q1FxRHVTcGFLSklMUm9XN0JPMDNRQUV6VzV1MzM3S3FFTy9PYjRXNWJFY1lw?=
 =?utf-8?B?NFlqUXZFWnR5NGZjRmFndVE2ZXJoSHYraC9QZWFST3pVRE1kQW1COVRCNjY3?=
 =?utf-8?B?ME9xUVhWUUxSakNYRytrTEViRDd6U0h3MWJTOXFnZWw4cGhHYkl5QkE4TnZ1?=
 =?utf-8?B?T25GMmJJQWxpV0k5bXRtS2o0dDZYejU1U1ZsQlBLb1RTTmF2N2d3MDN3V1Rk?=
 =?utf-8?Q?+t7JJxA4f6lxfZ4nwszZ17k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF7A88A980A.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7142099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0JPMElRc3g4REkxeWkzbWFnZ3hKSzF0Z2VOUjBJQytGRm8xUWFWT2dTWEFU?=
 =?utf-8?B?aGU3N0lXQ3pDRjBBSDlPaXo2UW1kT2lZYzVBdzZsV08rOVdSUGc3Q0pwcDJ4?=
 =?utf-8?B?RW9Pb0p2RlRPTG9nMXNpK1hMbHZIajkvR2ZNdmhrNVUxeEpvSW9mZ2tuQnc4?=
 =?utf-8?B?WDJMeWRLakJyaHNsQTRSWG1xWkJQSDNMWGdkNEd6WDJISlA2cHhSazVNRzh1?=
 =?utf-8?B?MXcvQkFaYUYzZDI1L0JHakNUTGNxUWdWeFl4NGpuT2ZKbStLVXZYK2JNd1Fn?=
 =?utf-8?B?cWFiN2Nwdmg1Mm14MWFjQjlhaTZYK09YNytlRDAwdDEzcXdmUXBONFpRREE1?=
 =?utf-8?B?K2F6Um9sRkNQKy9OQWp3YURLQzg3Zk8xMm1NRWxXOGdHeTZtaWFXVUFGSFh3?=
 =?utf-8?B?N2kwUjVGL3czb1J2Yk1SZWFwSk5CU0orTEpiR0sxZVlLb21Rd3RiZ2ZucmR4?=
 =?utf-8?B?azFVQ0VTNnI1eEx2OGw5eVBPU2FXVkxIdFpSR3hseUxjSnBId1BzSitXUzBL?=
 =?utf-8?B?QUtaK0EyVndvKzVyVERISTRBMVJBb0EwVlQ3T2xiUVhubzlsdmd0WGQraUVu?=
 =?utf-8?B?cElCL2FaUlMzTnZaY0xjS0JDYlJTUEdkazFrZmxMdVFLbjNzdTFpTnBCSllx?=
 =?utf-8?B?YWhGekt0dWk1QTgyOWtUS1BQL3V6bTlhcjRBT0ZkY0VUU05BL2FsUE50Mzdt?=
 =?utf-8?B?YlQrdVpscDJaY0lnTy8zR05GK05WOTdyUHdDZGpUcnlVNmIwY202RlgzL0Vr?=
 =?utf-8?B?emRuSTk3b2lPRERNS2dSdi9SSHJQSkpUdVhIeXhEM1dCWjkyUjNZalI3ZDBX?=
 =?utf-8?B?L2QxNXBraDBtYW02Vy9uWGdvMHlxYlBIVmFIMHkzbnB3WVJsRG1qQzh3NWJh?=
 =?utf-8?B?TjBPb0x2WkNNK0tSczFaSmp3ejZML0haeGNtSTFNOWk3c2NocTVIajBaVzZS?=
 =?utf-8?B?c1dLajJLdkQvc2xOZTRtS2hCREdvWm9zSEMzdy9tV1gyWm5VU1FmWGJtKzRO?=
 =?utf-8?B?VjZQaFNteGZyT1g4MTZLcGgyS1Jrc2VUS0dHRFlhd2gzRWhmQktNMGtaT2Vx?=
 =?utf-8?B?UU5BQk5SQXE2VlUvQWdwTnR4dXBqd2JkSXVaV0VHMWx1LzZ4K05qUnlxS1E0?=
 =?utf-8?B?enV1Y0xHRlVvZ3NLdXg3YUZCY2RPR2hON3ROR3UyYUVXYmEvVXIzUkI2SkY5?=
 =?utf-8?B?R3h0d2tUVmtTczZoVVlmQVRrZTM3a2I3UndlbVYzaTcyRUpoeitYZ1hDa0R0?=
 =?utf-8?B?dm1KOTF3UnhnUU9WOEtxYlRJOE1PREpUYllpaU8wb3hJMXVaTVdORHo0SVVt?=
 =?utf-8?B?TjFWNnBkakVwNU1HYzFuQS9ReTdSY2JxdGpDd2dDUXRnUmF2UW43c2g1Wmxx?=
 =?utf-8?B?YlZTd3kwOVhoT2Q1dGYxRE1XZDl0ckVkaW9ocTltbFcrSmw0aENXTlVOMHox?=
 =?utf-8?B?ai8rRndxQVhTUjNhUEY3WDZkbFg2MGp2dnpTSG0rY0QyaXlEd20vY01qNmt5?=
 =?utf-8?B?b1NQYUVpVmxubFM2Y0dRNFBDdklwQ2FJVXVQWFMwanpEd1VKd1ZJY1luTmEr?=
 =?utf-8?B?Z1A3cEVYYzFNaUQwTFFPWUh5WW9oZ1I2N0UwK2k2SmRmVzFFRk5sRURvSUw5?=
 =?utf-8?B?WUZXYlREWjJ2b1FEMy9FdmJqUElsUGV2ZElzV0o5K2t5clZ1OVQ0MERCOExH?=
 =?utf-8?B?SzlWTExHdG42L0x2YVlHR2dmaWlSbnlFREw5N0tPc0duYnBwQVhYOVJCZUVM?=
 =?utf-8?B?NU5KL2w0RTZFUUJXUXZtOUxvSTBHc2FxeVNpQlljeGRkTTNtQytOb05kNmhi?=
 =?utf-8?B?MVpDMnhIUG1vSkVyMGdjeEU4NDljQm96S2xlR1N3cFU1bVBvNnNqSERObWdi?=
 =?utf-8?B?ZmVCNEc2bUU4RFBUSTNUL29PTjNGUGxQbVdXcEJ3VmlFb0VTYjkxZnptYVor?=
 =?utf-8?B?aEp5Z1VVcWRUbE10ajI0cjdCaGJYK0RKTnpUc0FjVHp2cGlNY1U4S2EzQ0JN?=
 =?utf-8?B?YXNZaXlNVjB0Z1FUcmNYWGIxOFlkc0E4SEVtQnI3R2txUFdaTHRqUm52Z2w1?=
 =?utf-8?B?K3NwSlptS2NCL1pFQVZ6aEdJNE8veHMwYkNGZ0Nid2dUWDZ5YzR3aEh4UjdF?=
 =?utf-8?B?L1ZBT3d0VGowYmdMa3pwbVh6bklmWEpJNzBTQU5BZGdnMUV5S0FMYktLVHN0?=
 =?utf-8?B?OFgrUnNaQ2syc1hERFN6a2pGd2oyaFRNR0V6RTBDY0s5MC9MRU90VUg5VHNV?=
 =?utf-8?B?UGUxZUsxQzdiWUtEc1JoVVpQZzlZWms0RUJTYWVzZjBRZ3JsWmZrWm1uT0Nk?=
 =?utf-8?B?cWZSQ3pXS2dvS0RmMHRZMzZEU3ptWFpzTXFBbVYwb1BaaU5TUzFzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: entrust.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF7A88A980A.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3485eef8-61f8-478f-ddf1-08de72fb4716
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 16:47:48.7602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f46cf439-27ef-4acf-a800-15072bb7ddc1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZsYJz8E/5zeqO4Zq8Gd0W3Fbsn7vZJueQHG1vHiLUhOBYbQw7TR+YgpBPFbFItgD/ZpTKkpNCidvFTexWZp5XkllLxSUOZTeO7J6bFU1nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7197
X-Proofpoint-GUID: n-7z1Di7eqUEAAnC2vEhFpjXdbOA1-Zx
X-Authority-Analysis: v=2.4 cv=eqfSD4pX c=1 sm=1 tr=0 ts=699c84ba cx=c_pps
 a=68tMKWLL5ro13Q+0o2tD5A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=FEbzDYiKvWYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=h-oifH6qfStUR2Cxvazp:22 a=9TuF_iD66gKG-sCljbaR:22 a=XUe_gMu_AAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=02gni7CWAKRM2Wn5PNQA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10 a=Hyxxk7IO8alR8e2HbrPC:22
X-Proofpoint-ORIG-GUID: n-7z1Di7eqUEAAnC2vEhFpjXdbOA1-Zx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0NCBTYWx0ZWRfX0eEEBLFrDdOH
 BXaXZ5qF8tjQFnq6TKHLDndbg0R2XpkhNhGVwjU/oqKjBZLxi8/s5DECdHDC25SNx26aViEJbYe
 5t2yt/36hJeFQgOHQTABKPvmZba27ngXGEvxOp4dahiRvVvTylSzwlwVv4152uwKg6vqv0MUSbS
 b8l198gEpuRo+O9NmQSf9exlEdlpHDIfLH+cXu5UEkfVrP2thEwsSpy0UAkS+MqqoIYFum6LWSQ
 9fwUX8PJToHZ2weNFdkdPP53C7x+GVQRphRw2UtfJ/UcPWONE859ZoKarNL/Np3/03CsHZdG8Qo
 o6w5loLhC/49v6AsAvesgjY0//YQO9Ubl41BHcQV6VyqyK0gbSdx7DbNhBUOVP/rtex8HBgx0As
 YWpO9u63w/lcMs+B15J4/6v7qlB6+eUaxoZuEGVRLg+lKP/63uSJMkbI1hYkQrMBA0lx/a4DGK5
 dMXZ5rQzRuGVtBJevvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230144

SSdkIGxpa2UgdG8gc3RhcnQgYnkgYXBvbG9naXppbmcgZm9yIGhvdyBsb25nIGl0IGhhcyB0YWtl
biBtZSB0byBnZXQgYmFjayB0bw0KeW91LiAgSSBnb3QgZGlzdHJhY3RlZCBvbnRvIG90aGVyLCBo
aWdoZXIgcHJpb3JpdHksIHRhc2tzLCBhbmQgdGhlbiBpdCB0b29rDQphZ2VzIHRvIGdldCBiYWNr
IHRvIGJlaW5nIGFibGUgdG8gcmVwcm9kdWNlIHRoZSBwcm9ibGVtLg0KDQpBbnN3ZXJzIGlubGlu
ZSBiZWxvdzoNCg0KPiBGcm9tOiBTdGVwaGVuIFNtYWxsZXkgPHN0ZXBoZW4uc21hbGxleS53b3Jr
QGdtYWlsLmNvbT4NCj4gU2VudDogMDMgRmVicnVhcnkgMjAyNiAyMDoxOQ0KPiBUbzogTWFydGlu
IEJvbm5lciA8TWFydGluLkJvbm5lckBlbnRydXN0LmNvbT4NCj4gQ2M6IHNlbGludXhAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IE1pc3NpbmcgYXVkaXRzDQo+DQo+
IE9uIFR1ZSwgRmViIDMsIDIwMjYgYXQgNToyOeKAr0FNIE1hcnRpbiBCb25uZXIgPG1haWx0bzpN
YXJ0aW4uQm9ubmVyQGVudHJ1c3QuY29tPiB3cm90ZToNCj4+DQo+PiBDb21wbGV0ZSBTRUxpbnV4
IG5ld2JpZSBoZXJlLiAgSWYgSSB1c2UgYSB3b3JkIHRoYXQgaGFzIGEgc3BlY2lmaWMgdGVjaG5p
Y2FsDQo+PiBtZWFuaW5nIGluIHRoZSBjb250ZXh0IG9mIFNFTGludXgsIHBsZWFzZSBkb24ndCBh
c3N1bWUgSSB1bmRlcnN0YW5kIHdoYXQgaXQNCj4+IG1lYW5zLg0KPj4NCj4+IEkgYW0gd29ya2lu
ZyBvbiBhbiBlbWJlZGRlZCBzeXN0ZW0gdXNpbmcgYnVpbGRyb290IHdpdGggU0VMaW51eC4gIEkg
aGF2ZQ0KPj4gY2hhbmdlZCBhIGRpcmVjdG9yeSBwZXJtaXNzaW9uIGZyb20gd29ybGQtcmVhZC1z
ZWFyY2ggdG8gd29ybGQtbm8tYWNjZXNzLA0KPj4gYW5kIG15IGRldmljZSBub3cgZmFpbHMgdG8g
c3RhcnQgdXAgY29ycmVjdGx5IGlmIFNFTGludXggaXMgc2V0IHRvIGVuZm9yY2luZy4NCj4+IEkg
a25vdyBpdCBpcyBTRUxpbnV4IGJlY2F1c2UgaWYgSSBkb24ndCBzZXQgZW5mb3JjaW5nLCBldmVy
eXRoaW5nIGlzDQo+PiBwZXJmZWN0bHkgaGFwcHkuDQo+Pg0KPj4gV2VsbCwgdGhpcyBpcyBlYXN5
IHRvIGRpYWdub3NlIHlvdSBzYXkgLSBqdXN0IGxvb2sgYXQgdGhlIGF1ZGl0IGxvZ3MuICBUaGUN
Cj4+IHRyb3VibGUgaXMsIHRoYXQgdGhlIG9ubHkgdGhpbmcgaW4gdGhlIGF1ZGl0IGxvZ3MgaXMg
YSBidW5jaCBvZiBhdWRpdHMgZnJvbQ0KPj4gYWxsIHRoZSAibHMgLWxhUiIgY29tbWFuZHMgSSB3
YXMgaW52b2tpbmcsIHRyeWluZyB0byBkZWJ1ZyB3aGF0IHdhcyBnb2luZw0KPj4gd3Jvbmcgd2l0
aCB0aGUgcGVybWlzc2lvbnMuDQo+Pg0KPj4gTmV4dCB0cnk6ICBjb21tZW50IG91dCBhbGwgdGhl
ICJkb250YXVkaXQiIHJ1bGVzIHdlIGhhZCBhZGRlZCAoSSBsZWZ0IHRoZQ0KPj4gb25lcyBpbiB0
aGUgYmFzZSBydWxlIHNldCBhbG9uZSkuICBUaGVzZSB3ZXJlIG1vc3RseSBydWxlcyBjb25jZXJu
aW5nIGZpZm8NCj4+IGFjY2VzcyAtcHJvY2Vzc2VzIGFyZSBpbnZva2luZyBzdWItcHJvY2Vzc2Vz
LCBzd2l0Y2hpbmcgZG9tYWlucyAoaXMgdGhhdCB0aGUNCj4+IHJpZ2h0IHdvcmQ/KSwgYW5kIHRo
ZW4gdGhleSBubyBsb25nZXIgaGF2ZSBhY2Nlc3MgdG8gc3RkaW4vc3Rkb3V0L3N0ZGVyciBvZg0K
Pj4gdGhlIGNhbGxpbmcgcHJvY2VzcyAodGhleSBkb24ndCBhY3R1YWxseSBuZWVkIHN1Y2ggYWNj
ZXNzKS4gIFRoZSBmcmVha3kNCj4+IHRoaW5nIGhlcmUgd2FzIHRoYXQgYWx0aG91Z2ggSSBnb3Qg
bG90cyBvZiBhdWRpdHMgYWJvdXQgZmlmbyBhY2Nlc3NlcywgX2FsbA0KPj4gdGhlIGF1ZGl0cyBh
Ym91dCB0aGUgZGVidWdnaW5nIGhhZCBkaXNhcHBlYXJlZF8hDQo+Pg0KPj4gV2hhdCBpcyBnb2lu
ZyBvbiBoZXJlPyAgSXMgdGhlcmUgc29tZSBzb3J0IG9mIGNvbmZpZ3VyYXRpb24gdGhhdCB3aWxs
DQo+PiBzdXBwcmVzcyBhbiBhdWRpdCBpZiBhbm90aGVyIGF1ZGl0IGhhcyBiZWVuIHNlbnQgInRv
byByZWNlbnRseSI/ICBBbnkNCj4+IHN1Z2dlc3Rpb25zIHRvIGRlYnVnIHRoaXM/DQo+Pg0KPj4g
T25lIGFkZGl0aW9uYWwgY29tcGxleGl0eTogIHRoZSBhY2Nlc3MgdG8gdGhlIGRpcmVjdG9yeSBp
cyAob3Igc2hvdWxkIGJlKQ0KPj4gaGFwcGVuaW5nIGluc2lkZSBhbiBseGMgY29udGFpbmVyICh3
aXRoIGx1Y2sgdGhpcyBpcyBpcnJlbGV2YW50KS4NCj4NCj4gYXVkaXQgbWVzc2FnZXMgY2FuIGJl
IGxvc3Qgb24gT09NIG9yIGhpdHRpbmcgdGhlIHJhdGUgbGltaXQgb3IgYmFja2xvZyBsaW1pdC4N
Cg0KSSBkb24ndCBfdGhpbmtfIEkgYW0gb3V0IG9mIG1lbW9yeS4gIChJdCdzIGVtYmVkZGVkLCBi
dXQgSSd2ZSBnb3QgYWJvdXQNCjhHQnl0ZXMuKSAgV2hhdCdzIHRoZSByYXRlIGxpbWl0LCB3aGF0
J3MgdGhlIGJhY2tsb2cgbGltaXQ/ICBDYW4gSSBjaGFuZ2UNCmVpdGhlcj8NCg0KPiBXaGVuIHlv
dSBzYXkgeW91IGxvb2tlZCBhdCB0aGUgYXVkaXQgbG9ncywgYXJlIHlvdSBvbmx5IGxvb2tpbmcg
YXQNCj4gd2hhdCBhdWRpdGQgaGFzIHdyaXR0ZW4gb3V0IHVuZGVyIC92YXIvbG9nL2F1ZGl0IG9y
IGFsc28gY2hlY2tpbmcNCj4gam91cm5hbGN0bCwgZG1lc2csIG9yIGNhdCAvcHJvYy9rbXNnIGZv
ciBhbnkgbWVzc2FnZXMuDQoNCkkgd2FzIG9ubHkgbG9va2luZyBhdCAvdmFyL2xvZy9hdWRpdCAo
d2VsbCwgdGhlIGxvY2F0aW9uIHdlIHNoaWZ0ZWQgdGhhdCB0bykuDQoNCkkgZG9uJ3QgaGF2ZSBq
b3VybmFsY3RsICh0aGF0J3MgYSBzeXN0ZW1kIHRoaW5nIGlzbid0IGl0IC0gSSdtIG5vdCBydW5u
aW5nDQpzeXN0ZW1kKS4NCg0KZG1lc2csIGFuZCAvdmFyL2xvZy9tZXNzYWdlcywgYW5kIHRoZSBj
b25zb2xlIG91dHB1dCwgYWxsIHNob3cgdGhlIHNhbWUgZmV3DQphdWRpdDogbWVzc2FnZXMgLSBi
dXQgbm9uZSBvZiB0aGVtIHNlZW0gdG8gYmUgcmVsZXZhbnQsIGFuZCB0aGV5IGFyZSBhbGwNCnBy
ZXNlbnQgcmVnYXJkbGVzcyBvZiB0aGUgZGlyZWN0b3J5IG1vZGUNCg0KPiBXYXMgdGhlIHN5c3Rl
bSB3b3JraW5nIHdpdGggU0VMaW51eCBpbiBlbmZvcmNpbmcgbW9kZSBiZWZvcmUgeW91IG1hZGUN
Cj4gdGhlIGNoYW5nZSB0byB0aGUgZGlyZWN0b3J5IG1vZGUsIG9yIHlvdSBoYWRuJ3QgdHJpZWQg
aXQgeWV0Pw0KWWVzIGl0IHdhcy4gIChHb29kIHF1ZXN0aW9uIHRob3VnaC4pDQoNCj4NCj4gRG9l
cyB5b3VyIHN5c3RlbSBsb29rIGJhc2ljYWxseSBzYW5lIGluIHRlcm1zIG9mIHByb2Nlc3MgYW5k
IGZpbGUNCj4gbGFiZWxzPyBJZiB5b3UgaGF2ZSBzZXN0YXR1cyBpbnN0YWxsZWQsIHdoYXQgZG9l
cyBzZXN0YXR1cyAtdiByZXBvcnQ/DQoNClllcywgdGhlIGxhYmVscyBsb29rIHJlYXNvbmFibGUu
DQoNCkl0IHJlcG9ydHMgYXMgZm9sbG93czogIE5vdGUsIEkgYW0gcnVubmluZyBpbiBwZXJtaXNz
aXZlIG1vZGUgaGVyZSBiZWNhdXNlDQp0aGF0IG1ha2VzIGRlYnVnZ2luZyBtdWNoIHNpbXBsZXIs
IGFuZCBJIGN1cnJlbnRseSBqdXN0IHdhbnQgdG8gZmluZCB0aGUNCnRleHQgb2YgdGhlICoqKioq
IGF1ZGl0Lg0KDQojIHNlc3RhdHVzIC12DQpTRUxpbnV4IHN0YXR1czogICAgICAgICAgICAgICAg
IGVuYWJsZWQNClNFTGludXhmcyBtb3VudDogICAgICAgICAgICAgICAgL3N5cy9mcy9zZWxpbnV4
DQpTRUxpbnV4IHJvb3QgZGlyZWN0b3J5OiAgICAgICAgIC9ldGMvc2VsaW51eA0KTG9hZGVkIHBv
bGljeSBuYW1lOiAgICAgICAgICAgICB0YXJnZXRlZA0KQ3VycmVudCBtb2RlOiAgICAgICAgICAg
ICAgICAgICBwZXJtaXNzaXZlDQpNb2RlIGZyb20gY29uZmlnIGZpbGU6ICAgICAgICAgIHBlcm1p
c3NpdmUNClBvbGljeSBNTFMgc3RhdHVzOiAgICAgICAgICAgICAgZW5hYmxlZA0KUG9saWN5IGRl
bnlfdW5rbm93biBzdGF0dXM6ICAgICBkZW5pZWQNCk1lbW9yeSBwcm90ZWN0aW9uIGNoZWNraW5n
OiAgICAgYWN0dWFsIChzZWN1cmUpDQpNYXgga2VybmVsIHBvbGljeSB2ZXJzaW9uOiAgICAgIDMz
DQoNClByb2Nlc3MgY29udGV4dHM6DQpDdXJyZW50IGNvbnRleHQ6ICAgICAgICAgICAgICAgIHJv
b3Q6c3lzYWRtX3I6c3lzYWRtX3Q6czANCkluaXQgY29udGV4dDogICAgICAgICAgICAgICAgICAg
c3lzdGVtX3U6c3lzdGVtX3I6a2VybmVsX3Q6czANCi91c3Ivc2Jpbi9zc2hkICAgICAgICAgICAg
ICAgICAgc3lzdGVtX3U6c3lzdGVtX3I6c3NoZF90OnMwDQoNCkZpbGUgY29udGV4dHM6DQpDb250
cm9sbGluZyB0ZXJtaW5hbDogICAgICAgICAgIHJvb3Q6b2JqZWN0X3I6dXNlcl90dHlfZGV2aWNl
X3Q6czANCi9ldGMvcGFzc3dkICAgICAgICAgICAgICAgICAgICAgc3lzdGVtX3U6b2JqZWN0X3I6
ZXRjX3Q6czANCi9ldGMvc2hhZG93ICAgICAgICAgICAgICAgICAgICAgc3lzdGVtX3U6b2JqZWN0
X3I6c2hhZG93X3Q6czANCi9iaW4vbG9naW4gICAgICAgICAgICAgICAgICAgICAgc3lzdGVtX3U6
b2JqZWN0X3I6bG9naW5fZXhlY190OnMwDQovYmluL3NoICAgICAgICAgICAgICAgICAgICAgICAg
IHN5c3RlbV91Om9iamVjdF9yOnNoZWxsX2V4ZWNfdDpzMA0KL3NiaW4vaW5pdCAgICAgICAgICAg
ICAgICAgICAgICBzeXN0ZW1fdTpvYmplY3Rfcjppbml0X2V4ZWNfdDpzMA0KL3Vzci9zYmluL3Nz
aGQgICAgICAgICAgICAgICAgICBzeXN0ZW1fdTpvYmplY3Rfcjpzc2hkX2V4ZWNfdDpzMA0KDQot
LQ0KTWFydGluIEJvbm5lcg0KQW55IGVtYWlsIGFuZCBmaWxlcy9hdHRhY2htZW50cyB0cmFuc21p
dHRlZCB3aXRoIGl0IGFyZSBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2
aWR1YWwgb3IgZW50aXR5IHRvIHdob20gdGhleSBhcmUgYWRkcmVzc2VkLiBJZiB0aGlzIG1lc3Nh
Z2UgaGFzIGJlZW4gc2VudCB0byB5b3UgaW4gZXJyb3IsIHlvdSBtdXN0IG5vdCBjb3B5LCBkaXN0
cmlidXRlIG9yIGRpc2Nsb3NlIG9mIHRoZSBpbmZvcm1hdGlvbiBpdCBjb250YWlucy4gUGxlYXNl
IG5vdGlmeSBFbnRydXN0IGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgdGhlIG1lc3NhZ2UgZnJvbSB5
b3VyIHN5c3RlbS4NCg0K
