Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B692F4A0C;
	Sun, 22 Mar 2026 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774173244; cv=fail; b=AsBIbUl7r97kiuw5Yk5YoNIHCL0SuAySzIMGUzBizxZ2rSfTnUkMkrj5InAtRLbFOuJFUa+IWSPcp3kHvsO5hiz3Kc+20mGHzgvxlWqz0asdioF/1vuh5F0RuqHtL/JrWA3FZveK5t9sUevtkgh019C+aqmBD0Qw+5VSSuFvDqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774173244; c=relaxed/simple;
	bh=1XupPCPaR3cuEdY8z0JaWskjHd4RMzyYwGVav96sw7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B9MdruLKAeCmN4I95WDv2q4lgT+c1BtST3Wm6ByctpcMGXWZjdSGlN7Pz0uSxmrWrYdKGPfxQ9y78+wa1q5InuoB5rPB53K5m0yfFfPcMZ9s3ovU80Jnj0YiY/Ef/Kmwa1KHB9rUBRnwVl1AxYcpgFpz9OMoub/3hvP4Ea2wdyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CHSVzNCl; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CHSVzNCl"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62M8uqHi3760893;
	Sun, 22 Mar 2026 02:54:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=1XupPCPaR3cuEdY8z0JaWskjHd4RMzyYwGVav96sw7I=; b=
	CHSVzNClvI+QctRYRL0VPsokSzbAKUS1KiI/Gp/PiSE8LCBK3gYab+u/d2dBAZvO
	IuHzNbRGcxIx7UxTZDZ3xFnGsHWwt5Dg2rtrVlU8zw19ufMHO10ikI9yYhXIxTVv
	qkfO88GAxw+E2C1vKxZk1/tSYhGKifmW/0iOqZfk9SE8Y15W03qm1UqKWrFT/tio
	Xvo4wMSoW5oa4ZolmusLRVvQLYdQS875EbqRnnrIOMrgOjGhOkHn86h4sd9u5TvY
	cA7dzpu+c3hNJz0Qa1US+5g7sGXEM+D74lP+QF8dp1dSYdJB+wKVU4A/Fjq/qb+w
	3TqvDw8NOLzGqp3CxvL+VQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d2cycsdfb-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Mar 2026 02:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wS1alxmYpbWGUbnEkEIlWNISzlCdhhn2hxJgUZ+ihPpu1ZLmPVYmkB5d+wlebgCKNEKlmofscENZN37m/LXh+KU3ZoVrQRw3voILYgVXGHaYKEtt+R4YhjfJuxolSM4RVfmsX6/B19Dr6rOetbp3Uq9qGJ2y6Pw/b0yZSOAJS1nLq3xn4LXc3I5JtWTD082+PT3NBHwG9UZ8ejyfmFS7kK39CwBh62p8TT+gB4Vj4OSPFNc95dLepebawKLLKk8k8LUUPm3ciONRPLx33nuZa85Atm0WHHuaPfQCvcYBEyjmf544IsSC2IZfbky8S/CHd/uayAXcymTgfPhVmZGnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XupPCPaR3cuEdY8z0JaWskjHd4RMzyYwGVav96sw7I=;
 b=qXohTA5YCsCUJjPtCZ1qjqBYJ5oVLlikey4aoUbqqzD5ihX//LYnhisM603zNyfnshNheQ/g/I2g88A1mkpjy4q4CgMAVgSq1cmYHN9CGLbWGu0/9MZ4kAdXOj8QXx06DrMrc2K09RdqwJYu+3gmFM0CbyDFljP/AFJTKIjl6ix0L9ksp9El/+tT3ANykaG7lqX/cetR2rAE36cO3XyapiheunxS+tfBC4x3J2+Ss0yk1IIojjcv3OObPLEkDRjLXAxgPgKWpArTsmXM6dxPlxSejQC+1UN75DfAZ1Ko9IkK/W0vaUJK7nF73dF6V10pdMuZfYY2tDzB4dp+a6mtcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA3PR15MB5751.namprd15.prod.outlook.com (2603:10b6:806:313::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 01:06:36 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::87b6:de64:203e:7434]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::87b6:de64:203e:7434%3]) with mapi id 15.20.9745.012; Sun, 22 Mar 2026
 01:06:36 +0000
From: Song Liu <songliubraving@meta.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: Song Liu <song@kernel.org>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "omosnace@redhat.com" <omosnace@redhat.com>,
        "mic@digikod.net"
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>,
        "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>,
        "herton@canonical.com"
	<herton@canonical.com>,
        Kernel Team <kernel-team@meta.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 6/7] tomoyo: Convert from sb_mount to granular mount hooks
Thread-Topic: [PATCH 6/7] tomoyo: Convert from sb_mount to granular mount
 hooks
Thread-Index: AQHctwdNdQSRi0Q1xkmL3qjyFdgbKLW49bKAgADMdIA=
Date: Sun, 22 Mar 2026 01:06:36 +0000
Message-ID: <4DF5C4A8-7C92-4F76-9B34-2262089E7289@meta.com>
References: <20260318184400.3502908-1-song@kernel.org>
 <20260318184400.3502908-7-song@kernel.org>
 <b720f521-e930-4f35-9505-1bfdf9e2818c@I-love.SAKURA.ne.jp>
In-Reply-To: <b720f521-e930-4f35-9505-1bfdf9e2818c@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.400.21)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA3PR15MB5751:EE_
x-ms-office365-filtering-correlation-id: b7a99d48-958b-452b-8aaa-08de87af43f9
x-ld-processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtFwd
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 2QsippZto0a8WRI+kP6AIeHhj1K8JQ1xWlcET9J6WZv2sFvQO6WztYEOVOlFpaQPYyo5r/cO49qVx1UU0IGxN7Iud3C9cSnj5c848AzELxY5jVYFoU1BHAdhyT8HLIpoGTb24huiTnTYzgWn6dHSFNJodah38By/ko5Ylw8UU7g0UBWdFrBKsusDBUXp+/YeMW7exp/lIkwmIZJbPwLfEBxWFHW7Vy3c5hFZ7E4OyAEuV7eUrE8vPzTiAzm0GIgecmci+rievvtcDt4vQ9GrWLQM4lShqHXOGY3sTE2YtQ75Cjv1oOOY3DcIFnbn26ljAJe2GRO+efjAu5lGfgsC2i/xU0ebX0PBRen4AHOQUK5sI4XU/YB3q1lwqNjjb4flXxJNIc4CgeQqlpVjT5lYgOIjUEx7Vp5ULRO3KtKn6NrqLoKBO9lMVjfS2ZJsd7GsqiDj/lkP6Q50iLZX6d3V8C1P3nZXP8TYw+dl1CA8OEqTW0XpehmjxhCS8nylEVrMWP9JBcVxJXT7A/z+VinUotOMcWJyJXBuX1cVjcB40qoN+p1o0Xg+ZsEgSXz2hXPTIlWKwzRG4H+Zbk0sz+EzkiO/zBrj1b/aHuJOWzimTmYTKwCtJEyoso0iZrJw94a+AC3Je1ilk8GCIwu74akpT6zSP5I7JZKmu61Q+HEPlq8Jel5AbnbfrKLEgJu8eEohroPmMV24vjH8OCL1Gl0CPwrtb7oRJnF8vXr8NYRqerVYz8GkAnb5BDQBD926pfWNsVVfyh6PI911Igl8DgVKVZNt7Elpl6FyhAzU6ULY6jw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXBNc0xwbG1YYlBuQjdkU0NIaUJUcjBGcGNGK1RrRW5DWGd1bFRrNjVzRmhy?=
 =?utf-8?B?RnE2RXducmw1UHAvdENWQUlDZFZxQ3RqUlJCYWdsdzhFam9ZM3F2VUhvb0tN?=
 =?utf-8?B?cUFtT2ZjTXdCcnplSGNlSUlIZDd6cDNvTFMxbEozd2cyaXFpUEsyZHcxZU80?=
 =?utf-8?B?Nm9rWGp5Z1FuaXVEbEY1OFM2V3pLRzlWZ3dtdHNOb1FiQm5wb2MvUTlya2lm?=
 =?utf-8?B?RzlVdkRmVVFLdkJIT20zUkhrK29OU1JwQmVuYVc3YUZmdnpQNXk1UkI4ZUkx?=
 =?utf-8?B?NGlPMXI2ZWpNTitEeUM2Z0I4a1dkcUxZOFZnVGhCL08wNk5HQ2NCaHJhN2N3?=
 =?utf-8?B?R256MnNzc056UHVQOTM3aEIwbTdnZjloR0txbFNMYXpyZlVkWVVFZ1pCTkNZ?=
 =?utf-8?B?L2doakNFN3pHM3BZTTdYa09TUlpyWk1GSmJwSklSZ0N4M1BjSGorQVlpNSsx?=
 =?utf-8?B?SENGN3duSFBLZnRUSnhKbDZFMDN5K3JvMnJPL1V1eE5GS1dRZUV6b1VGWWVT?=
 =?utf-8?B?SkU1dHdUSTZiY3ZOODZuemZvRHlJd0VjTGV0YlZyb2RaMDJJOUFNMVdsOXl4?=
 =?utf-8?B?THZVN2FQUFBwYThyOE5Fb1VrcTBJMCt3R0ZjaEswZ3NPSkNXT2pOWkpxTWlE?=
 =?utf-8?B?dE1LdE9YV3E5RGw2QVFSNE51UDY4MUlDaE1uK1MyVU1rLzJqaW83RkNvQlNC?=
 =?utf-8?B?YzBlNVg0T1R4T3dEQXNYT3VEbFlmQmVDNDRJRTUweFVjVldCaThVUllhQW85?=
 =?utf-8?B?bUlmKzRBVVgwcmY3cnp6SXRDZjR6azZGOXBaQWtwd25MSzZSNFBuQmloeXow?=
 =?utf-8?B?emY3SW9hYTQya1k4bTgrWDIwcDBsU2RQcHpGSkFhVkxyZFBlWDNHNjJ0SU9T?=
 =?utf-8?B?K1BsK0pxelhlUGY1TXNJTXdxb3B0UUVSR3Q0ckRzdnBOeW9NK1VGTWVJcXBD?=
 =?utf-8?B?dnREa3JNbDdGWTROZ1dST0lUdHhzdm5oRll0NDdXMmV6amp0M0VDZkdjZTNR?=
 =?utf-8?B?Q1A5V29Ubkl1cXIyVGV0MGg1VVhQY3FWc1VXbm1UbFJlSzVMNXRMcEkrc2Fk?=
 =?utf-8?B?bVBZRndyNGQ3T0NsZitWMnFCNUkyMnZRem1QYjg2V0pqanljQ0ZLb2xUcTJM?=
 =?utf-8?B?OHBOVmlZeUNCUDFKTzVBMkZZU0FMOVhiWWY1U1A5OVdteHpvb1hYOUhYMm13?=
 =?utf-8?B?WUUyRGdqUlhGS2srRjAyTUhtY2hnV0l1UkppUVdzOUQ1aVBUOXlSSm14Qktm?=
 =?utf-8?B?MFhDaWQ4MWxaTDduTEV2Sjlod1Y1UmV3OEp3MVBhVEpicHA4YVc3a2pxZnRq?=
 =?utf-8?B?Q0tLWU9IbFBtbW8yK252S2JYbWlLS3lnQTRGcVFyR1NuaDN2SXE0N1ZtKzBF?=
 =?utf-8?B?QnFOblVZRzFLV2xYalJ4bm5qLzFCMldhMUZ5RjFnVUwxR2cwZmNrRmNDekZm?=
 =?utf-8?B?TXRvQ01JRHBTTVZDZytuVTBnenVVdHEwZU9ZbWZKREtYOU5xMXZCVGpaTzZK?=
 =?utf-8?B?VXhQTE56RUhUU2Q0eUFScHlIMGZoSWpMTVBuS1NJcWtRQ0ZtRW0zSjZLeGNk?=
 =?utf-8?B?ODNjNlMrbTViaW1oTjhWaWdqMnBWaDNtRGVyMmRRWWFNN2JnR3N6TUFXejJv?=
 =?utf-8?B?NGc0dVBmOXlhSHkyMkVockZlTy95VW90QVk0MVR4M080d1pnRjZsTnBOZ01q?=
 =?utf-8?B?WjJEV0xaSHVrc2VQU1Q1dzFIV0V2eXE4R29hME1ReHhNa2s3eC8wUGJIZHpI?=
 =?utf-8?B?NUhVSWxvY3RDWkVjUGUxZVZxcElPZUYrMHNuMUtXZkp5RHBpZ1hrQnZRZ1p1?=
 =?utf-8?B?U2JPaFRwZURBcmxMU2RiODUwblZYRm1wdmQ1S0hGM2E5MGFXVWJwdG9IblpK?=
 =?utf-8?B?YU9KRUhHOW9FbUl5SHZ5eTRPalNBVysrNVUrSXNqRWpGNEtUcDhXcW5HNTBz?=
 =?utf-8?B?VEpVbDRuUEdONG9BaE55c0pydDM3U0ZEVFQvaXVLd1VUOW5ya2FSRW94aVpy?=
 =?utf-8?B?c2lDR0pML1BpSzBwcUR2L1JsTzd5VkgzSGsyNEQzK1hHK2g3RmV6ZFEvbVRY?=
 =?utf-8?B?TFdRTXE3NnVTTmhrcXFqZUg0T2pFaFgyMzNtZW95aVhJOXZJUGJ4c05PcVFx?=
 =?utf-8?B?bVhVOWZ1a3lMSlMzSTMvSmN4bHdER0hoN2I2N0l2eS9ka2QxanZiZEducm54?=
 =?utf-8?B?YkQxWUppQWNDM2ZTTzVTUTdFYTE3OE42bTdjMEdNNENaRHhmZmFrRmRQZCt6?=
 =?utf-8?B?eWY0NnAxNjBzZDlzK3lpdnp2R1BGUjlQYklXTm5UQzZVNmhyRE5aTEJsdHdN?=
 =?utf-8?B?VTJXWnY4K0pVaG5Ya1lJQlU1SzYwN1F3SXpHN2xRcE9JZ3lueGdRR1NOYTFh?=
 =?utf-8?Q?jiI8jo3bHkC0QFqE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82375B9888BDB64B9F80DC60859AD417@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jFbVVZVJbcVFSO1fqoB+GGuvNmkcvqWNlVKbqTUaLpvPKODHM+7o+LGwJkTtlIREKZ764aJHQYD8P5k5CxXIMT5b3pNDH8/BaCrnR5tpqOZylHMZr+90csxAzX1jUrhVlWlUvHzfQuOR5BGZy58FMVrly7oozAUbVYlG+5SwlNlIkvwDAi9bMy04A+9zCBpI3uCiI4nZIn6k4BtVtFYgPXTSbmKUmbPRjPCEie87CzET4BmuZhjxNGNajDnsWnYR0Vt1OmzSBJtmPCOqmsoTedoXEq3MrRfUerzuq36hCJuucqibtdKKOWTsQn5Uv6BhOQ7ZbifVFFyIDcSenIfZgw==
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a99d48-958b-452b-8aaa-08de87af43f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2026 01:06:36.2050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjIGvo8tyYL4w02gV2k9RKgGFkITFQk6pgFhlIAhuXBrTfp+Va+86GUriddO43QX045O3WsehTKMZoY+CBgp2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5751
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIyMDA4MyBTYWx0ZWRfX1+PFpfMjW+LW
 H7Gaf62ozzUxekY7A9xb3FKawjENVpeo4rP0C4jGhuDCKMSwRfwSCDmEcx/opWt3j0tyUdWg8Fv
 5xld2mle96KX3xtUweJKeA9XGoCrwWvIH1PTUgSbRNPTmNmZd+XaLOUPBAJsJCwvCrV8DvdELOZ
 E7S8exztdkmQp6x2SyCoBwhPypO6qO017BBW/96vq+YH5gUJKs24nmRbPC0bB9nyTwHr5OfJzBm
 Ak33WEnV36l/9woXINnlu/Y7SyKkKYvRwVddZ8dJdSQ2/3Fp6YYUD8UdgXXHjHtANPftyWlMssl
 830HnkT9UPuG4UzbG+280oyaqDQ5Hhi8k++qZ3fSFXyn2rM6lT7ujptKP6quosolGLvm+75CmDF
 YYLdAZoGicckWYvq/EQqb8pwwVTi1N9ZxZd4xQr/C0eoPDJJx5R9y3yiyJOjYXdO033ylGJJdIe
 ltpDGs86OV9Ff8aFaRg==
X-Proofpoint-GUID: kVGLHn25RMs0S5JKcDc1HDWEA3FxJfs7
X-Proofpoint-ORIG-GUID: kVGLHn25RMs0S5JKcDc1HDWEA3FxJfs7
X-Authority-Analysis: v=2.4 cv=WKhyn3sR c=1 sm=1 tr=0 ts=69bfbc38 cx=c_pps
 a=SEJ8dOKVafy+qjyLYqUPAQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=JO67u45Hr6Uav_sJJ68A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_03,2026-03-20_02,2025-10-01_01

DQoNCj4gT24gTWFyIDIxLCAyMDI2LCBhdCA1OjU04oCvQU0sIFRldHN1byBIYW5kYSA8cGVuZ3Vp
bi1rZXJuZWxASS1sb3ZlLlNBS1VSQS5uZS5qcD4gd3JvdGU6DQo+IA0KPiBPbiAyMDI2LzAzLzE5
IDM6NDMsIFNvbmcgTGl1IHdyb3RlOg0KPj4gUmVwbGFjZSB0b21veW9fc2JfbW91bnQoKSB3aXRo
IGdyYW51bGFyIG1vdW50IGhvb2tzLiBFYWNoIGhvb2sNCj4+IHJlY29uc3RydWN0cyB0aGUgTVNf
KiBmbGFncyBleHBlY3RlZCBieSB0b21veW9fbW91bnRfcGVybWlzc2lvbigpDQo+PiB1c2luZyB0
aGUgb3JpZ2luYWwgZmxhZ3MgcGFyYW1ldGVyIHdoZXJlIGF2YWlsYWJsZS4NCj4+IA0KPj4gS2V5
IGNoYW5nZXM6DQo+PiAtIG1vdW50X2JpbmQ6IHBhc3NlcyB0aGUgcHJlLXJlc29sdmVkIHNvdXJj
ZSBwYXRoIHRvDQo+PiAgdG9tb3lvX21vdW50X2FjbCgpIHZpYSBhIG5ldyBkZXZfcGF0aCBwYXJh
bWV0ZXIsIGluc3RlYWQgb2YNCj4+ICByZS1yZXNvbHZpbmcgZGV2X25hbWUgdmlhIGtlcm5fcGF0
aCgpLiBUaGlzIGVsaW1pbmF0ZXMgYSBUT0NUT1UNCj4+ICB2dWxuZXJhYmlsaXR5Lg0KPj4gLSBt
b3VudF9uZXcsIG1vdW50X3JlbW91bnQsIG1vdW50X3JlY29uZmlndXJlOiB1c2UgdGhlIG9yaWdp
bmFsDQo+PiAgbW91bnQoMikgZmxhZ3MgZm9yIHBvbGljeSBtYXRjaGluZy4NCj4+IC0gbW91bnRf
bW92ZTogcGFzc2VzIHByZS1yZXNvbHZlZCBwYXRocyBmb3IgYm90aCBzb3VyY2UgYW5kDQo+PiAg
ZGVzdGluYXRpb24uDQo+PiAtIG1vdW50X2NoYW5nZV90eXBlOiBwYXNzZXMgcmF3IG1zX2ZsYWdz
IGRpcmVjdGx5Lg0KPj4gDQo+PiBBbHNvIHJlbW92ZXMgdGhlIHVudXNlZCBkYXRhX3BhZ2UgcGFy
YW1ldGVyIGZyb20NCj4+IHRvbW95b19tb3VudF9wZXJtaXNzaW9uKCkuDQo+PiANCj4+IENvZGUg
Z2VuZXJhdGVkIHdpdGggdGhlIGFzc2lzdGFuY2Ugb2YgQ2xhdWRlLCByZXZpZXdlZCBieSBodW1h
bi4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4NCj4g
DQo+IEJhc2ljYWxseSBPSy4gT25lIHF1ZXN0aW9uIHRvIEFsIFZpcm8uDQo+IA0KPiBEbyB5b3Ug
c3RpbGwgcmVmdXNlIHRoZSBpZGVhIG9mIHJlc29sdmluZyBkZXZfcGF0aCBhcmd1bWVudCBiZWZv
cmUgY2FsbGluZyBMU00gaG9va3MNCj4gKHRoZSBwcm9wb3NhbCB5b3UgTkFLZWQgYXQgaHR0cHM6
Ly9sa21sLmtlcm5lbC5vcmcvci8yMDI1MDcwOTEwMjQxMC5HVTE4ODA4NDdAWmVuSVYgICkNCj4g
ZGVzcGl0ZSB0aGlzIHNlcmllcyByZW1vdmVzIHNlY3VyaXR5X3NiX21vdW50KCkgYW5kIHNlY3Vy
aXR5X21vdmVfbW91bnQoKSBob29rcz8NCj4gDQo+PiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvdG9t
b3lvL21vdW50LmMgYi9zZWN1cml0eS90b21veW8vbW91bnQuYw0KPj4gaW5kZXggMzIyZGZkMTg4
YWRhLi44MmZmZTdkMDI4MTQgMTAwNjQ0DQo+PiAtLS0gYS9zZWN1cml0eS90b21veW8vbW91bnQu
Yw0KPj4gKysrIGIvc2VjdXJpdHkvdG9tb3lvL21vdW50LmMNCj4+IEBAIC03MCw2ICs3MCw3IEBA
IHN0YXRpYyBib29sIHRvbW95b19jaGVja19tb3VudF9hY2woc3RydWN0IHRvbW95b19yZXF1ZXN0
X2luZm8gKnIsDQo+PiAgKiBAZGlyOiAgICAgIFBvaW50ZXIgdG8gInN0cnVjdCBwYXRoIi4NCj4+
ICAqIEB0eXBlOiAgICAgTmFtZSBvZiBmaWxlc3lzdGVtIHR5cGUuDQo+PiAgKiBAZmxhZ3M6ICAg
IE1vdW50IG9wdGlvbnMuDQo+PiArICogQGRldl9wYXRoOiBQcmUtcmVzb2x2ZWQgZGV2aWNlL3Nv
dXJjZSBwYXRoLiBNYXliZSBOVUxMLg0KPiANCj4gSSBndWVzcyB0aGF0IHdlIGNhbiBhdm9pZCBw
YXNzaW5nIG1heWJlLU5VTEwgZGV2X25hbWUgaWYgQWwgVmlybyBjYW4gYWNjZXB0DQo+IHJlc29s
dmluZyBtYXliZS1OVUxMIGRldl9wYXRoIGFyZ3VtZW50IGJlZm9yZSBjYWxsaW5nIExTTSBob29r
cy4NCg0KSWYgSSB1bmRlcnN0YW5kIHRoZSBjb2RlIGNvcnJlY3RseSwgdG9tb3lvIHJlY29yZHMg
cmVxdWVzdGVkX2Rldl9uYW1lIGZvcg0KbmV3IG1vdW50LiBuYW1lc3BhY2UuYywgT1RPSCwgZG9l
cyBOT1QgZG8ga2Vybl9wYXRoKCkgZm9yIG5ldyBtb3VudC4gVGhpcyANCmlzIHdoeSB3ZSBrZWVw
IHRoZSBtYXliZS1OVUxMIGRldl9uYW1lIGhlcmUuIEkgcGVyc29uYWxseSB0aGluayB0aGlzIGlz
IA0KdGhlIGJlc3QgYXBwcm9hY2ggd2l0aG91dCBjaGFuZ2luZyB0b21veW8gYmVoYXZpb3IuIA0K
DQpUaGFua3MsDQpTb25nDQoNCg0K
