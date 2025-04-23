Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2024.outbound.protection.outlook.com [40.92.91.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D22918F5
	for <selinux@vger.kernel.org>; Wed, 23 Apr 2025 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421573; cv=fail; b=XM40Z7QJvX8Yytm3RBqNkTPr8agLdXQsKj/7BpBaeMyGMqbYkviY8mJ+i543jDBOs3GBJl2VTzGEYy3CSa8VDZ5honbeBy1/4Oaoh2LNTMCtbYlBfh0vjFIv7aRX8P5jF7umKRIg2dc7x69izP9OQ+wC3smzV9MrNr48aX7+gDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421573; c=relaxed/simple;
	bh=q6EX6njvcUn+KUSGIcMmau/0xUxe8VB9R14PZOzon5c=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QPLW8bzbsFf/ZHluBC0FSEIpnqfAEChIirvgW+iXeTBYglvWgeq/uv55pvrHqe4RLmeSxVU8Psh86+Yzf5U28V0S/soRE4vPm8BuIYMNuo/yh1xm/Gr0yn1VY9Or07NSTe0jH8Pm3pYhekvd0Y4AfoUXfqAUP+6JfhFTNs5MYVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hqsCGaq8; arc=fail smtp.client-ip=40.92.91.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hqsCGaq8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFx95r1j+pSkOOkCj47xK16glB/rtQMVoV2xd+GbP1bAJc9WqUdwR+f9EhxIjtvBgXieMYrYz7NRPinuCL7I87qNjUP/EvJlzzzDHTBRIGtYf6QWu3Cg/Y7govW6zv1BXEHLgpR5yBljXguZnqlf3TAwvy85NDtK1t2rpmFxrtGWJPlOrsf+MyupHd57Fb4+JwUdyUytKslvhL30r7IpkverHvUXcZN4qZsvu/2Bsgr0j/hlqBadoYjnfL3B+kTPYWF8Snrlr5ownn5uKALxdkPPu3FKRf2wHIcxgEvVtWnRHsXuf6NZ+/lhh+BlQE4sXZTHmivUl5v5KwWZTlvauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6EX6njvcUn+KUSGIcMmau/0xUxe8VB9R14PZOzon5c=;
 b=N6wqL4u8qnCLQdfSIhkTLNYZNx/1ZnutbWlyDIdckBkD+RYhgKCsGN9WLFK5r7BuzzkyW3gBpFv5Vfb31ss7eooth6HqSeFhJ9mdw7BS90B55dIzDGOmMAhLdNU/TtybbfvwMPu5IT8GghbxP2+x6EvrscyXGv2U7/foxdBOJKHQ6wiAyk9eWQLGLB4+7N1sk88fuc/R0CAZ8wfVVH/3X+A/dWcMZ0le8mmcA1UJMdMozusTt5tBSlE8l6QmfCjeBawpkA0BZNG35CB2QdtZGtjKZU2dzeQeJkPjdLaYdPjhXLqPG5l5sCFRr6Q+uz9is56GKfWUCi17cF5i5F8uCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6EX6njvcUn+KUSGIcMmau/0xUxe8VB9R14PZOzon5c=;
 b=hqsCGaq8MUTZreimk+8JCYfPdOHoQUtdeKNtl9426LVeIM7jnzpJtUJ2q/d8nEbb41rA6oIf+ryLz5ou6iAP5sjE+orYNe1RswbYoz+UCNESSl+tA76ZV8cr32p2ck2RADCqo/XskOiFiVS4F3SrRMaK3/w6dbIDcjkAmrbGdSOhL4SSry3T25FDVDD+/emLl8TrK3ViLUbFm0+6RjmKAh+VqsGaoCT3btL0h+tMQIRQeQOP8kHa3fKb7pJXynawNmQIVb3lkuDMCsaWjAqfAn/8umDtgdYLYmYURPCu36xJoIAY1cs4+/nmYbxPghRpEh8dmfZodfCTBbe13sjyRw==
Received: from AM9PR05MB7618.eurprd05.prod.outlook.com (2603:10a6:20b:2cd::18)
 by PA4PR05MB7661.eurprd05.prod.outlook.com (2603:10a6:102:d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 23 Apr
 2025 15:19:29 +0000
Received: from AM9PR05MB7618.eurprd05.prod.outlook.com
 ([fe80::dde4:6355:c013:6062]) by AM9PR05MB7618.eurprd05.prod.outlook.com
 ([fe80::dde4:6355:c013:6062%5]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 15:19:29 +0000
From: Debora Guerrero Ortega <difrada_2@outlook.com>
To: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: info
Thread-Topic: info
Thread-Index: AQHbtGMbLsiejA1eI0iC/eWhP1rfcQ==
Date: Wed, 23 Apr 2025 15:19:29 +0000
Message-ID: <88FD70AF-13C8-47E3-9225-59CFC4566B66@outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR05MB7618:EE_|PA4PR05MB7661:EE_
x-ms-office365-filtering-correlation-id: a49406da-9a0a-437e-a599-08dd827a3e27
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|7092599003|8022599003|8062599003|19110799003|8060799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?I7sGqIMQsgToxaG/N9lq7raFAt0XIdhtGl1OEP8yx1XrKj3AkBF7xaTk8deT?=
 =?us-ascii?Q?wfokJI+VeHC2G++p78lxG/5j1qHOBIuO/Zwm6QHRI5SzYT9xGCCArTITpyRQ?=
 =?us-ascii?Q?4scBwL0Xlalt67rpyRwncjmsHizgYhom8ANqiTz/e6myKVLaYXK3ORwAEiQf?=
 =?us-ascii?Q?sBsgZ48MtosfsFSE641qUCckgyBTa8FDP8jdBu6ylJocve5TI/46cJ7DsOz7?=
 =?us-ascii?Q?erNsGh+dywo46N8iHN6PBMz+p+q9lfFbhQ3SzWT1QV91nGqxz3i14EJmoOpW?=
 =?us-ascii?Q?zo9FQiqKiSoKL3SoBuQXyxTqEBZf5Ja6YuZAgPELqbV+NziBMRrJgmyMnrEm?=
 =?us-ascii?Q?JsgE4T8YhuMy1kcsP7yEpnFRMMEuMuXXUYRanu3fufCSr5WfzQoy38SFoAze?=
 =?us-ascii?Q?cYhkqfxJ+r+xQNOtdFDPnYbs8FT/jJg/U+MKbrg3/1QOINpXjhRrvTw2Q1+7?=
 =?us-ascii?Q?IlIJ4tpauDRNu9Aqr1+hLBDhdVG4/z3G+Ae2wCAL/kqMDS1gWKv0uAaJIWGP?=
 =?us-ascii?Q?FwKQYbVsl/n44FAyU4j12T3iWKET4yOhn1+mqBer10dOa6SM/GdwlW6hJFcw?=
 =?us-ascii?Q?efuujEUbGdS6JSQfcxPcgLBcMHcfgBEvunvEWdEjcvCb9wX2W/JWC5IR52CX?=
 =?us-ascii?Q?dH+iEFFIYPy1JY6meCA571syVq+9AHaMJhbxyDKY2r01p/JwWxRa5gtL7TzT?=
 =?us-ascii?Q?ic54toJTLLLNKb46qIiTeZjy0AjP0AfMJHmguZ8x/XDB129Eky/XEQmcz4zn?=
 =?us-ascii?Q?rPQx+pTho0jjbtH1/itlThhfAhBa9LJAqqOp7nubMKcpI0KL3gFF2/aABmBR?=
 =?us-ascii?Q?Th7JyQe3jjSUjjcxCkgRAeBuZ1frwUBBCYKRDfsUtMwc9L+QorXr/X9ONbh2?=
 =?us-ascii?Q?5ate4MlLjf9Pu8pXqjGTwn1XS4GYz7/RNcFIv0L0GgRcADkli4ISSMqjQAfj?=
 =?us-ascii?Q?C1Qyn+fykON+GqsLBs3wU27GRbGsV4XA4SdffppM9YKF+ckR0F6NmwkWxUGq?=
 =?us-ascii?Q?d64juN+ejNQPvVX/6AjPtT0wqvwdxNUcUffqUa6KyQdkDSpdrVipZwYDIJuz?=
 =?us-ascii?Q?8LRb2uTo+MuqIlJ8/2Hi1Sq2x6yp0j7OEVoFAYv45IGWX75qk7LNz1s/Drgo?=
 =?us-ascii?Q?DW/v4YdJa/LqCumB/Gp62LaBx7AdTyes4g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qV15HwHaEAVNQRDl6Jj1jS/4IvGMKxtiRUIIATR0t8hYLXkd4WcvE8pnnSYl?=
 =?us-ascii?Q?5BEbLhwKSAYo9fH0eoo9RJ40KovwehNpVBkR9sU0I4QGJbW3VnDY99zAQuAi?=
 =?us-ascii?Q?spgpJDmJoQHitzQslNuE39bSWEHIy62l6wDmVHdd0f4TyYuWBivdAu0jIE7Q?=
 =?us-ascii?Q?jgUxQEEbxC2n8Bkzi3lLfHCK53qeSiLilGwjICuRPlJUvQ25o2vnYhY05Peg?=
 =?us-ascii?Q?113R5QD6R3s/hAQtSusKfWYU2L6ieT4ObaEucD/S1tNir/6RZ6u7JlMVsikH?=
 =?us-ascii?Q?B2c0tg7W4SjTR1opTH+UfvDm1BSPYl8RstqJfiS+fT2uKS1wBkK5/EHdJNHT?=
 =?us-ascii?Q?r0M/DK5+R8OjSJLhSSDvbeupfr9G6vdp4bjvaYsPMegdcP154HL/Dj7Ug9Mj?=
 =?us-ascii?Q?qAbO3UZV4SbdywzEBl+wtN1uwCfpQUw44ophWmXOfYKo6PuI7X7KrZUxmVSs?=
 =?us-ascii?Q?qc2cmzxLfO2O8A/wNxC+GhWZGYN2C+zL83gmM6IzI5frlypfF5+jK9KISxYw?=
 =?us-ascii?Q?fFo8LNzPjFMHUnZ7yrTvoKrJLcwgHe06ll07pyprNOjXgJpID4s5BsmH5K0F?=
 =?us-ascii?Q?VuLkc1KMRtXcu+YPu2iWZ+816GS3FqcH8lze0YgkLSMq5zxD4gxDOiNmxFQ2?=
 =?us-ascii?Q?86xqGJB5j9gCkTc8aUeNIGJaaBmr3IZVEPdEU4yN8U09I5ZrYYkdmpIvd0Nj?=
 =?us-ascii?Q?BeqaQTkhI1DnE5Vvf0u/v9o5HmCOiFb0/MzJ71xkzo7nILvj85Mki0WJK/Y/?=
 =?us-ascii?Q?EeELWJXQTyTyEUPcWtmQO6DCrsm0ZpuVN0FPNM2njapaOcGx3+IzsqiR6Thc?=
 =?us-ascii?Q?S+PCUlE9k5DZUMEPGoApf6OgZiMYe0ztNkkName3M84OzAIT0m6Q+9LZwyF7?=
 =?us-ascii?Q?wowYjyzPxDT5Ohi7bbLby+ZAsWWQbCQksK0lU+7ni2dg4fPT64jA+Ur0kv+c?=
 =?us-ascii?Q?RBHLF7mHJ/cwxCtzpO7jZU44k+9oKD/Nc956e9/uOxpaKhsKRpAh+liGlx1+?=
 =?us-ascii?Q?xtpl/9NuGkgblE5zlfZGPERizD+U+yfwhEkomuW5JVOXKKJGqs0YnTntFcqN?=
 =?us-ascii?Q?MIU1dgugjhSTA4/6uUp/ln/EWTcf0CjHjIyKa/vFmi34h8JwL7kJSz8PSuzN?=
 =?us-ascii?Q?rs3aiHuIx+3j5SpLr6/O6xw5QGPI5qiZW1vwaYy0f5p9oP2fSWmQNxf+HfiY?=
 =?us-ascii?Q?yyK44IGNsnKh4syV1JD4hLMsPbLXqYHVZ01Fh7xRwk6nB8CrU0Kf/Qks0p4?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DAFB5040FC2C04CB9974DA169792986@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR05MB7618.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a49406da-9a0a-437e-a599-08dd827a3e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 15:19:29.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR05MB7661

I would like to have a service for a new e-mail, provider.
I would like to create a new e-mailaccount.
