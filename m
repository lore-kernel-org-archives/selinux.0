Received: from mx08-0015a003.pphosted.com (mx08-0015a003.pphosted.com [185.183.30.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A834317709
	for <selinux@vger.kernel.org>; Tue,  3 Feb 2026 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114595; cv=fail; b=IKA7dmlhDM+taUO38ddDJKrXzSbtFUg0JULbJrJjw1u5R9vzZRgxBFUzcV1bRZOMp+e+SpkFhAPDfdwid/ZRJ4DQdmLJ35Vv2j/cbM6CG9DmkmUZh7YJutvHSa4RdX7Wy3YFZkgM9vakwEHBcQokvqnN4RlRyP9Izqr9Hx7oC7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114595; c=relaxed/simple;
	bh=qo0MdsQPfMTSfyaf9vpLtBP30HiBvv9IZPtEZ/b/P8Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A2vr0L5iPqLdKfa1351mslC6OGIKA14nlKpQ3OvqaR8EooZRLM7ZEcHn01/sg0KUBdIuu5HGz7AGrhMdiRHbCuCV9/92yl2vUH7KBhJZOczlDy/Uh7CWTFCSJ/4ep3XjpjXFABoYEzdYQwDkjbXKt+JVkhhBryg7e4lL274gkeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=entrust.com; spf=pass smtp.mailfrom=entrust.com; dkim=pass (2048-bit key) header.d=entrust.com header.i=@entrust.com header.b=G/BlPztr; arc=fail smtp.client-ip=185.183.30.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=entrust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=entrust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=entrust.com header.i=@entrust.com header.b="G/BlPztr"
Received: from pps.filterd (m0242863.ppops.net [127.0.0.1])
	by mx08-0015a003.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6134KYqq3566511
	for <selinux@vger.kernel.org>; Tue, 3 Feb 2026 04:29:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=entrust.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=mail1; bh=FfcYxeCeDHekP7U9idCqRP7koM
	l8Nxs8bCFSVoI3zHI=; b=G/BlPztrjZT9uW7iYFsqqy6/toV9px6G8s8FOPfWPv
	SZ3nyaOMoOreLozQhEGZHMn3upokZaxFvY7olqGSpJso0PNd7VOSRMygTPv5H50G
	sFk9cRfk8Q/1+klzNJ1qv9fAzt4fLLCe4ms1vwdsPDgeu+RUb/gR4htm2Xk/h7WF
	+LEOcWpkhSNay59nrfejGdYoID8QHjTep0W85++bfafbOzu0glzKop4d1N5CNqUl
	yNxBfxzD+YOAsa+szUoENYRMIco0J4Xs7zmp3yLMtP27QYNafJeIOFuZgEqAknsA
	Vjg4UOR0hWkis1uSbGKLCyfvW2lq4jObQRVi2GhMbvJw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022131.outbound.protection.outlook.com [52.101.53.131])
	by mx08-0015a003.pphosted.com (PPS) with ESMTPS id 4c39vtgpgf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <selinux@vger.kernel.org>; Tue, 03 Feb 2026 04:29:52 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5hPec34dW47rmciagaHR3bJZRCTCXWNQx2SGm1D458ueJzpdvX89GlcjtQ5YyC/LLSqZVU1DEXzP+WFTX4PMnn8F/JgMQ6wbN3NAkyYXC72WvJ874EAFtGTHapsz1HXYcfnWEn90+8T1UVUzhFaiPIhJ/izO5dLTn2Ro6wMyGdZwpLW/Wuyo4qzrJ6OjXvEwBxNNB6/y+8ZwMxYdUHNzjxvN+5wQWwe8IoZfy2JYfM63sN3/muVQSPAd9VO+3FgqvNqS3ZdfpwBlrBM4s6ufcyZnbkVVil9Zgif0Tsbdda/LgoIdr4eQyT16vI838lx0p9kgFVHiI1ogeNHS/Xw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfcYxeCeDHekP7U9idCqRP7koMl8Nxs8bCFSVoI3zHI=;
 b=XstCaSdQhqAi2vRFNKzC24KPIM15IlnMQObyvEtlPyw6d2eeKBRLC1WigZW7TyXWVdh1CUkiUj7/RKjlB/QG3BnEE9hd4Hfu5JWxx27TB3WPnszquDPj8mkTcneVNZo4cXo7TApoqyYbb2SueYbJ73Wa/AJmrI8DOe6mBX/tTqEWgjPO8zHCFxRrH7ejhE4OEpvpJKkCtitJ2aAbjJMU7OIqwRo1Ny2+I8jc02pqohCwpambTEtURUlKD6EgZdie/jm4r0bVckeNJJkqpJe0qHFI6qrwGZUTPUPAW/wyVFNw0O8PXSOU0zld8pmttu5ZkplBJOl7P+nvIchWA9HDJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=entrust.com; dmarc=pass action=none header.from=entrust.com;
 dkim=pass header.d=entrust.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by SJ0PR11MB6694.namprd11.prod.outlook.com
 (2603:10b6:a03:44d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:29:48 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::f7b3:4461:b4f9:1a0]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::f7b3:4461:b4f9:1a0%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 10:29:48 +0000
From: Martin Bonner <Martin.Bonner@entrust.com>
To: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Missing audits
Thread-Topic: Missing audits
Thread-Index: AdyU98MVl2YjIjwCQCOJLsJiRiO9TA==
Date: Tue, 3 Feb 2026 10:29:48 +0000
Message-ID:
 <PH3PPF7A88A980A236C1D23F1FDB87FAA2CF39BA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|SJ0PR11MB6694:EE_
x-ms-office365-filtering-correlation-id: 65a64cf4-8a3b-4bf3-c604-08de630f2867
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UswqlF2gaumv2JOICPow9EdJAqPij9uzYFSIGVrChRT5FZ68oPBDN3ggjOn+?=
 =?us-ascii?Q?+btGW/A9rBrh+DN3DDXSHXAD/oqWC27rMOqzr40xzScgQGryMiM7pDJLbFlA?=
 =?us-ascii?Q?PwHONtIvSM2V1Wr76ayqcCJK/ykb579r5ts4VcsSeAq0S7n2Lcp6x0jhELU8?=
 =?us-ascii?Q?DGN03YD8RcB1sDHrt7c3OcHq1Tb3uRQnBOaAnVBRnt2pO/C5xUiOSjAmvKRI?=
 =?us-ascii?Q?BG2bNxuZWXFaisRQBEGnZShqTlueMJvFy+4q5NgjVIpbKB7XejfkZFkgsDLL?=
 =?us-ascii?Q?QZb4gBqiGzLkZxjXTeYl69ZJ8oShyzvsMEbqjkkXAjWbFGhiPv1+ugRVvHKt?=
 =?us-ascii?Q?jfzZN1xYTUb2k9Cs3Gb6bzQINqNcP2Mu2feX+J4MwjBvMaI6zNJYYG/3kNnb?=
 =?us-ascii?Q?IqsYw7u5iRU38913TFMqWl6fwKTqaxZ33V7NB7MYv2tTL7WNVesobdN4DkJa?=
 =?us-ascii?Q?1DoMNh3DviuqMRWskcKrjTU1rVwJ4llAddzv28Vxf1eF2idECi1hEX8iHHas?=
 =?us-ascii?Q?4SVfRi386OHBC0vtjzxAataBRNHob+ApL5RgUTlvyfw/43SOS/eNmZXqYsE4?=
 =?us-ascii?Q?SpWdD0xp3g1+mBlHpCXDz6HvZeVhaP/CpmVFf+NgI8DytoCKjm3mfF8Ntwx5?=
 =?us-ascii?Q?BLbXsj7jF0GcW47Xk57/miI7MCioGsUy3hO8sG6KYuNBrt2fEbcnRvMPKvoo?=
 =?us-ascii?Q?Gah125yhIQ+uDhes1jDJdxQpnl7fJE3GsW7sP0iSXDNdCj5tskWDoyI3SP1A?=
 =?us-ascii?Q?Awi/9XuLehd51jgpTlYtg7PXfPGr2vvssDqlkC+kQktMKTSXN7TV1ACYWSIu?=
 =?us-ascii?Q?8uPgxW8RdKSgrO5i1IuX9PUYq+066quLxc/5NU+aXp56Nn/FvYRUAN4OLn/F?=
 =?us-ascii?Q?kSXBXSJGXFF0IN5MCtDn7UsbwCSIZYs0x2uAc64w2A9VkAFD8aCQjOS08Tf4?=
 =?us-ascii?Q?oHe3IaX37NWMSy4frxlJaRMK91PitmCRPkEZ1KVC7Npn+ngFunw/HGhHARHy?=
 =?us-ascii?Q?SMAgSs9kcJhgNqeVpS0sd8bPfLUS/eoqpsXHzPx6gA7oOXT8dKm9wRFPM3A2?=
 =?us-ascii?Q?OIkRFLsu9b68PwT0FbzRZ5whlvZlWyhw4igQVaoOqkVUlS3xPadJAx6DtKw5?=
 =?us-ascii?Q?eTpjNUp3On3x1qZFnq+fXbD+nOli3cp4P8mM3poMIsS7bfu04ILmTGE7ig5H?=
 =?us-ascii?Q?tuTGNLFvNbqjR0c+CQN0hQnF3COFWdh/iyUA6HMRzGKwLtxbCIM2ZQy8lEjb?=
 =?us-ascii?Q?2TSHqtNkWfViS5stoDHClKVHd4dX7fVA2Jg+SEqDKBrLiq2wqLr52YfbfPWZ?=
 =?us-ascii?Q?AVC9dFQhVgVtRflZhp9jre54bk67vlbbUpYuiA0rsZsJ9dHJAOyB8ckVMxTo?=
 =?us-ascii?Q?wzAIV5h04bjVHzWFLjmH5XQ3tV5tkBZ+3EI/gjY+oHIljA3f+5tZFMDL4NKx?=
 =?us-ascii?Q?l0gSQJlRmxwCYnGBLpSOoQtJQajBFG77F57zXFNWch6Q8+yT8K8cEE8XG80Q?=
 =?us-ascii?Q?84VyGHJLQzXqNstu9710tXi15sXggtDocYYCuSL1t2UDv+mpSnXv4pTiX6by?=
 =?us-ascii?Q?IoQg/iJEcs2tfaeHYDB6ML2mOGgciaGXB0izMotfqqtl/Jbpelkm2xI7CaLs?=
 =?us-ascii?Q?3Ma/mqOlJxj/unQH2jwl6Kk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF7A88A980A.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hCF5yLCeXyuiGv5li2dY/1hS1PbcQnmXWQ4CZ+wHPV0biJig8JxrW26fMJzW?=
 =?us-ascii?Q?pZrqd9JJ5MXl342dJ1mVeiVxMGVRi3CwXZrcYvN4Vp9vJUu+dPyUMa73546t?=
 =?us-ascii?Q?iDsjTgMW1gl4pT1sSJgQc9lQZdT+3nwVwILBm1yQecMQMlMItcvzzhU8g1aJ?=
 =?us-ascii?Q?JfMf13Y5S9CQL9u5GTL8vmxLfiy3rpJJZE7ocKWdwyE5D7+APHTfXw7xDQuD?=
 =?us-ascii?Q?kZZsi7peVqUf+iWe0SmHY4paWh9KozT514yVrPzDF63ACzd5R+lMNuPDFhfs?=
 =?us-ascii?Q?CAdC0naDaZKCUuPnWlUimGByjIUkJQ+17rYmKtEQqhDrWhxQh9Q22r2EzkeF?=
 =?us-ascii?Q?mmlB9EICqFQkBB4UFX/0rIqyStFiKCGR7VB+Ql4RTf1SfB1NnlPgRfjC9Sk0?=
 =?us-ascii?Q?GtxlIAOhufufwx645mMT+xaP80cOPcuR/SDz9WpmxGWXjlwt+aVVaMhFsbPu?=
 =?us-ascii?Q?FJlzD+UeWQsOR7guZwcYYSVo1bR4T5uK/Yu7HXhqdFH1kDgg5Y1sCyhWVgea?=
 =?us-ascii?Q?JuEunWxtV42VWfeVw5pMIhHTRIE8ILwCNHxdIlyl3HNPeFaTkHRMJcmdevqm?=
 =?us-ascii?Q?rful6dEXiAw41zs8XfRX2I3Zkrp/N6XxP9xKgSgxGyNtqcQXZmN7/4JcsXb8?=
 =?us-ascii?Q?EiI1CpwDBZlapRUeVh/Fd2D1keMPUUjjDjUEFg2PptEyA/hqiNLtEFTCWOK6?=
 =?us-ascii?Q?iPhe+cMgWwk00dRKyRT3ggvboY888qhpJrvyygkpgSI4jKk84nlXusc+A0qt?=
 =?us-ascii?Q?xOLBPVKAXuUwSQ6/6NO6VBcIPLNEZPZ52fYAzFD4MejxT6O28LpqhbuMjxjz?=
 =?us-ascii?Q?1IT87zmbRO/XZDDKFBrYtQoaUn2CFkBWUPdLez+d/bdCaE6KrGmENB2cV0eh?=
 =?us-ascii?Q?gxCrFexxr7Iyy10vch7HdEp4wM3/bB7jFSxuGRZ7soijPY/ezbueao/D2pAm?=
 =?us-ascii?Q?VNgtuRIii+qjDP4nQDs1VDxR2vkdy0XDXQTtLa7AAM2ekWwTJhIJJR91AgKk?=
 =?us-ascii?Q?xUkrQbv9aez2dGY9If1qt669JYlsHLIaoSdxDUyHVExaSR0otJMemxC/ZFBg?=
 =?us-ascii?Q?xvfHSf4shiZd2Da70c+08u8kxmw409AYXhbxWH15zvnLfU0EGY86BzbCev0C?=
 =?us-ascii?Q?zFYvDl0JlSa+7MIYvDwJ06XEoMVqrhS8RDmufCv2Oc8Lt75DM8VmrpWXdBsX?=
 =?us-ascii?Q?PcgY73tCil5Yys90lK7+W9UJffHoLWm0E4G0ada6jMULCH9ha/TPurToN3qj?=
 =?us-ascii?Q?v7Q5FVWNaadkxMLLBI7yWoHyL0z4L8QpSo8O+kMi8Cb5JpnhNZXeWOh6XmdY?=
 =?us-ascii?Q?zZBlOh8fY589SYy/fA4r9R+leoYninEixx7WN/kCugoPVoSqNqRAHKFLwyCP?=
 =?us-ascii?Q?MAuDV4RgryP+ofWg2JumBdAifUiOs1TvhbUZV/Nhhhf/h5vSvRWhrUoByabz?=
 =?us-ascii?Q?+YnYKCoTttF1hqSPmCPzjm4fLVseM9mV6hXS4dtBbqHarTIqoacbPZBNJsBB?=
 =?us-ascii?Q?iKAqvUFjY4ywiAeK7/BMC/GyzMSNCuj7Uz0VaLRvRgcEbHR/kTPiMJQ7z7PV?=
 =?us-ascii?Q?5kQQSZS+DtU/kLCD0DYRJN3l0JybRkQsa4wcrESePxyMJxsvdxlZuw8g+09r?=
 =?us-ascii?Q?NtyatLqpX/nrPki6cJRdlcnVqEhvDGmitSFWb4meVBpJa9UOZRQ9MyUdsOqY?=
 =?us-ascii?Q?OR9FkU9iSjUVc6RTHo7kHOeBW5pTR6QndVo6QF0cieSOkvOAMmn6wOJqabBV?=
 =?us-ascii?Q?cujc7rHCoA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: entrust.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF7A88A980A.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a64cf4-8a3b-4bf3-c604-08de630f2867
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 10:29:48.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f46cf439-27ef-4acf-a800-15072bb7ddc1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2F+yknzBdjIftak8zsNYJ7/n6cm8rlYT1yY6bj3nHC8jkDszyAE+uwMCSA7AZxScc3IsH9jCwTp+j7cXQr46W2p+BB35358R7Gubljg9tU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6694
X-Proofpoint-GUID: ilNg8jOYkWVnhZDdk-smBPfPRmprlrCA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA4MyBTYWx0ZWRfX+mhGe/49Yj/m
 ubhLgB6orjNoFlQvLWMhUho6h4ivHpZHlajFiv3/8ijUCuQY2ebA9Qu2XAAHs0D1ps/vl1vweLk
 D6wSoZIDd/YDbbd1vvGYo+a3rWLmU4yGO9pMywlFALywh5qU1zCkfZXGDTCQkrer1/yNe3nFwla
 Wknv2tvLSUTZeLpx4T1PeC5Hom0Lr3CY1pzUYeNqLvoOABdUJUW93FTFFgh/W2c9TiLvLGNWUuJ
 ppxif31hqrNU/EV5nCqxte7/5qlT5YOG2222TtgTaC4Li4jdECe7N2Lx8UrDR7pZDSDiZwlQ9GC
 QbUlpjgb8wIvTP4544Ro2tTwtzILXR6Ij2BgUw66yRXiYMjU80sRtaCnLCsefdXBwUMmABnD6sF
 31KHst9VK/EZdXbA6ob5RyeI94XkmtYdCioLVGRUTmLwpgnV1E0XFehV52eCMx6MLtAFKuYylCR
 jFn2nhENmQCJ/YFk/DA==
X-Proofpoint-ORIG-GUID: ilNg8jOYkWVnhZDdk-smBPfPRmprlrCA
X-Authority-Analysis: v=2.4 cv=cevfb3DM c=1 sm=1 tr=0 ts=6981ce20 cx=c_pps
 a=6tOaaN1fXmJE/LdyR88bKQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=FEbzDYiKvWYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XUe_gMu_AAAA:8 a=IJk7cfyfnQuHKrsdrD8A:9 a=CjuIK1q_8ugA:10
 a=Hyxxk7IO8alR8e2HbrPC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030083

Complete SELinux newbie here.  If I use a word that has a specific technica=
l meaning in the context of SELinux, please don't assume I understand what =
it means.

I am working on an embedded system using buildroot with SELinux.  I have ch=
anged a directory permission from world-read-search to world-no-access, and=
 my device now fails to start up correctly if SELinux is set to enforcing. =
 I know it is SELinux because if I don't set enforcing, everything is perfe=
ctly happy.

Well, this is easy to diagnose you say - just look at the audit logs.  The =
trouble is, that the only thing in the audit logs is a bunch of audits from=
 all the "ls -laR" commands I was invoking, trying to debug what was going =
wrong with the permissions.

Next try:  comment out all the "dontaudit" rules we had added (I left the o=
nes in the base rule set alone).  These were mostly rules concerning fifo a=
ccess -processes are invoking sub-processes, switching domains (is that the=
 right word?), and then they no longer have access to stdin/stdout/stderr o=
f the calling process (they don't actually need such access).  The freaky t=
hing here was that although I got lots of audits about fifo accesses, _all =
the audits about the debugging had disappeared_!

What is going on here?  Is there some sort of configuration that will suppr=
ess an audit if another audit has been sent "too recently"?  Any suggestion=
s to debug this?

One additional complexity:  the access to the directory is (or should be) h=
appening inside an lxc container (with luck this is irrelevant).


Martin Bonner (he/him)
Phone: +49 151 5046 3855
martin.bonner@entrust.com

Any email and files/attachments transmitted with it are intended solely for=
 the use of the individual or entity to whom they are addressed. If this me=
ssage has been sent to you in error, you must not copy, distribute or discl=
ose of the information it contains. Please notify Entrust immediately and d=
elete the message from your system.

