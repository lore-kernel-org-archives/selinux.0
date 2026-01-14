Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11011029.outbound.protection.outlook.com [40.107.57.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152C381703;
	Wed, 14 Jan 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383795; cv=fail; b=tZKpuBYGmFnVs1M4QjU61Mop3trBsD8zsJLy9j0FASclBe2Jg4ich9tBZUuSyw2YDSMVrgO8GxpP8EYNkfyU97KXKnWgS17y8UsrMJx3h1dsdadG4k7tfyx0qRpN4zgALSZRYIscdP6I5BW5dFu/HtH1Aoomc0vf5K9LR4c1pO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383795; c=relaxed/simple;
	bh=kiAWFwJviHTdpLScGhUO4omEnY5Cm6xrVd0MnJDC2nk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K4fvl7c3V4RsYSWWcfbTrRDlwCdAtUltl6a0lqtbNqiEO2RVTguCEIS+5Y9LtT8vlq2EJPEj1hv5VEcmIaGWJQxC+NRXRlPO0R4XhtD6V0gbjQPd9eUUVqfoAccBV231VhIcgk4KRmpBYtaHXLB3eZRnLbMLc9wqjuz9rwdMxIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kpit.com; spf=pass smtp.mailfrom=kpit.com; dkim=pass (1024-bit key) header.d=kpit.com header.i=@kpit.com header.b=IwvTSIpS; arc=fail smtp.client-ip=40.107.57.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kpit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kpit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpit.com header.i=@kpit.com header.b="IwvTSIpS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsMgVornraWGtd83/Tdpt8iLiKUc7Fu75MHBiO8MtomXK55sUqDUkLeAbPhKHGseRxyuwM9tnWz9oGv43yLQZVc6093Tn116vvrxYfaL9pSnX/QBsURJtGJrOst8dgWPBgLC5/s7gzg1EYtzobX14HBopvhAV0k56tWCOFXWDDmWFItmhdMETRpMn64uhy3m3fYqJ7fkgwXsjVTeundk7V3MinJ00VPYYkOVvrT4YMB5MiA12ADP/yurxc8WFxpF6+p3E5HIOA2qI7wklTDCAKWmBUCONXl5iarMcP8L5pz5Klg9fHZU3UiNN+upuGIoAQB4VKPOPc/3U+GtKTxYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtsp+4wWjNh7nQwP90bppZ8vNKdg6KIv7CKM2d25tWk=;
 b=LQBS24UESEGikxAIs3fwBpGcOBT5E75i08uJQXG8d4XYVfDGFnPgsuY2bwZTaaCgklAfZwguUETs3rMTVANazNWBknlwlmj5dX0GRadiZ8E5bi18Lstuz0C78h0DzQdg5Z14LdLx8ZoRL2mFIJlhD4raaTP55AHD3NOgIn13zs+iPLN8AvtlIyew0IEc1kTjkYj2ISj5uWi5pjfKmkoR6XwAFnxRGWQAE6EykChu3cfU+937dj/GzzlmR8gJ7J2Rb7vO8VhmOL/6k0eMe6UVEbu/fz7sH/8j0Fsp7lw4QZXGjp6DGWpqTAK6NYIG9jxDy8RJpEYMzSqIb+Lp8pVqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kpit.com; dmarc=pass action=none header.from=kpit.com;
 dkim=pass header.d=kpit.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kpit.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtsp+4wWjNh7nQwP90bppZ8vNKdg6KIv7CKM2d25tWk=;
 b=IwvTSIpSdqHqrQ3falcEaZeDPz20G+kmNojoxh/9LfoH8BBL5zijTGyuzrDjkJcO8qLncuTZ/Kd8/OmVMd21spp582bl89oJQyDw8RmuZwfObbSjp53fJs1Wq8cgUUD2QD65dEvYKKFBPkVvr12StwGRpscoX/OXuPFiQs9PeP4=
Received: from MA0PR01MB9793.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:ee::13)
 by PN6PR01MB12249.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 09:43:07 +0000
Received: from MA0PR01MB9793.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::39e6:2dc3:9212:e591]) by MA0PR01MB9793.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::39e6:2dc3:9212:e591%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 09:43:07 +0000
From: Bhabu Bindu <Bhabu.Bindu@kpit.com>
To: "selinux-refpolicy@vger.kernel.org" <selinux-refpolicy@vger.kernel.org>
CC: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: [PATCH] udev: allow udevadmin to extend socket recv buffer
Thread-Topic: [PATCH] udev: allow udevadmin to extend socket recv buffer
Thread-Index: AQHchTf766yc9xhkeEqDE3c6+ku9IQ==
Date: Wed, 14 Jan 2026 09:43:07 +0000
Message-ID:
 <MA0PR01MB97933ED6DCFEADB1CB62BDB3958FA@MA0PR01MB9793.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kpit.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB9793:EE_|PN6PR01MB12249:EE_
x-ms-office365-filtering-correlation-id: 39fcc57b-eaaa-44bb-5282-08de535152b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|4053099003|38070700021|8096899003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QYpeyoofAUsq4/9CQ7DggOPRLRgNJDlLkpE3Z2qaqwp0LvdB7aP/RulNGd?=
 =?iso-8859-1?Q?Gb2gXLUZIpoeSG5OT6C/netoZBoqWWfxWEfDgox/ty1HkBESTTEhgIzvin?=
 =?iso-8859-1?Q?bzdPdujoWOoMxydjKKbAcMVgj5c6H2gi1o3wl+LIwQsIvzd71DsuR7RFk4?=
 =?iso-8859-1?Q?2/oYh5WpZFXfHdIJIhauRedbZjx/8P5Pss4MpfZyszFCdzFnRwY04afNUw?=
 =?iso-8859-1?Q?JvfkAGMrGfW9DRjS2XxAX1TOHh9gU6pHg4BnY3NjZFBqK7ZOk4P7BMbG0S?=
 =?iso-8859-1?Q?GItZGRdNqZufzuQQmfe4apoGu2Hl+3ETznAsOHsLBjaKpTthXqitHUvgMG?=
 =?iso-8859-1?Q?jAygi4JATajXz6BMTrizCHreW0mCkDIBXgdLGmayEoLsbsSk3sV7Tydkn5?=
 =?iso-8859-1?Q?osY06m6f/25TQsLNA8s92yMITopO1M8MkozeCtH4D87LQMAaFWrCjVzFdO?=
 =?iso-8859-1?Q?CdCvrq/8BMHaZJeNFN81rip4HRtEhaAVRCjyRsTFzFs9M5KVptsCRk5ZVT?=
 =?iso-8859-1?Q?4ZQz8cqGeJ8xIrAfaEkARgae7KDxBRzGnhEe2Pt3RtqEv7H2w/nI1jIv5Z?=
 =?iso-8859-1?Q?WqTSSo1H0S1us8JyxjNfUotGRkMr0Js3sUSZ1aYtj+xcswm+Gj8/JemK2R?=
 =?iso-8859-1?Q?Q2MpUi8Le9dGpozijLZMqQK8D3uUETlnbfofkYGTJqs6JoAMMIQGmEGNie?=
 =?iso-8859-1?Q?+laS2qscX/lhv0iIqfDKydyIPm+DORiSJpxsAS7qi5EqnfKLqlE3/f4Dt/?=
 =?iso-8859-1?Q?6MWycxRwDm+Yhg0i9XDXsD1BbHj08RV8yN1Zc7V2DL9XVojMGHuEKhnSxA?=
 =?iso-8859-1?Q?hEQ2K/caRTe3kTtjnJGEL6stmBNhD5B2JXDKl3Gv7QjeAwiv7qjRviBWdW?=
 =?iso-8859-1?Q?yaJ6AEu/21zwLStn4Ds4yNHe6sUUC3dDROGUS9hRw28Y8FjkV/J+seOONj?=
 =?iso-8859-1?Q?I9mAsor9x/yrHDTuGGpFAXGWiHElhnelykDCw41Mu+9CgRDs2qs/HOZsFx?=
 =?iso-8859-1?Q?ugHZGJwN2IaW+easitj6cgW6ACBryVvIoRNm1Q2IqBUVi/fWdVKGDh0MQQ?=
 =?iso-8859-1?Q?kPBvOGSq5glWXK4R4W5GurMNVZCy/tlrN4QeKt2ve9fmxgTr4tDVwj9kjj?=
 =?iso-8859-1?Q?DAQ5Rg/PIHOkymaJJxJsfHjo8cEc4maPdgy06/9vjyLEJH1A6ma759vKVD?=
 =?iso-8859-1?Q?KN8+Rf18nmJBKz2LT+jCuxxUuDQqH6Tz2TpL8Oo+fKmwMT4Zk4jZsowzSJ?=
 =?iso-8859-1?Q?H1h+h7gmW7T9lODJ8yrTXhisDWq8TNveDy6iAnR8GRCmmQ0ShSjsUbiUHE?=
 =?iso-8859-1?Q?p5oKBtue0zmT0DTSmvJpkwKcQ/sgA2OfKjPdkxkqHhmn1q4DDMCAnXSDen?=
 =?iso-8859-1?Q?Y9JsnDupmw0+xCGcCeipWbFUuKut3hUhzgRIdioypitq6Uj7AGmoMM3tn9?=
 =?iso-8859-1?Q?IfkANoVk8+xlWGqW+t9lQ3xHdlAGVEOs5AzoViuhXLZYEd+EGUzUw0T25K?=
 =?iso-8859-1?Q?vcoq5xTBdZrSweFmIIsB26Ohl1BvMDaVUqB7hGxhZiOJ9E4cT/zWqmdh52?=
 =?iso-8859-1?Q?kiLdE0TU375x/GCCWvcxq6FmHNVN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB9793.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4053099003)(38070700021)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7VuUckr199VN/63XQmDTwiAKFEDmS0NOoQQV2XPq3bCADwixpmV37HpZKC?=
 =?iso-8859-1?Q?cj7jep92cZBgmcAyCyQz3kYchrqoxZ/obBPRIFoSMqqpC5esW8G691Hd2O?=
 =?iso-8859-1?Q?6ph73NHX+1cG1ux6WX9A9A+WFz1xEFYuizSAFPwaCEvhrJES0uGyLoMy8d?=
 =?iso-8859-1?Q?/o/GXSiPkp+UKdHS7hQbv2qt0cmVYA3bxlji/ILMxtFYSZ9C1hM8MHQWks?=
 =?iso-8859-1?Q?Xk6cGyGCMOcvYi9wM0dT2ZLUO2sZIcz07uSTx65jAKAORhKTdHFbc9EuJN?=
 =?iso-8859-1?Q?cMpKA4L2Gh1lzcvi3Dq0cjLfPHbnXhDGEKdELYqb4BQ9bs6z9aaMlym/tW?=
 =?iso-8859-1?Q?NMsxP6jQZaT0FI/FKyPmbJp2IIYbJLpqh17t55uncL20c0W+Lr6GLx2358?=
 =?iso-8859-1?Q?eimh9NC0S3tYOQTIJ2sc9wCbtinu/BGtrGALE0VkvFymL3rWQgVv3TcLtN?=
 =?iso-8859-1?Q?YqW8u405NZxcTe9hNEVr7V7Lv7m6A4NWl/b0ZxSRj6eJ6f6Eug9rEunebl?=
 =?iso-8859-1?Q?PoWBcmBrv3pDF2h/VboL+ylfmmdWgXtJQQGhtm+NajpRvsLr5xMlnCl1ey?=
 =?iso-8859-1?Q?Xf1IllPNsDxCFqseZOhmUSyO2cM3nLvvnnnwLH/V3Ql82QhJTBPick3AEb?=
 =?iso-8859-1?Q?J3Ak1aew5o+CCRLHuvGrp1glbzFwh96yzcnn2vipK6NoWfsFCXmWHGLyqe?=
 =?iso-8859-1?Q?/zBx0BSwtCg+V8izm6eSDbtYtB1wsUkH6/5tEHAGZwQMXTcZSE1JBNKEHq?=
 =?iso-8859-1?Q?m5WXHk8R/7giT5yNRD+XIVgyI4JCk4s/gGmH3xEINWDEm+1e9ZmcF3Bxtb?=
 =?iso-8859-1?Q?Rm1J0BfnN6iI6PZ36XQZzxZhCakRGF8aGeYmoiZ/i/gW6w77GUtx63tJoL?=
 =?iso-8859-1?Q?Gxf4vV1BGLqIp3Dm05j1Xts+90NF7c+N6tmU5ucmoXW+DSAKKzTfbvwxil?=
 =?iso-8859-1?Q?/Poru2AZ604cUJSsWrfjQDMJGro8FwrhjllHWesGMpBnrrLwEibB2bZtV4?=
 =?iso-8859-1?Q?larJHhfDHis9TU9HkrRYlziZ92y2PP21tLAiP82K8ex5NkQvSZjYYLmQtu?=
 =?iso-8859-1?Q?KNy/YwHY6TbZMiQV5UQuZjIxT/jYBKSW90FEOWPxON2p06PxPJZVMbA4P7?=
 =?iso-8859-1?Q?xnldZlnL2vfz78dpdDjsKekIq6pIoDSVA8gow8f1hE9We3tDWCgbs+EQB2?=
 =?iso-8859-1?Q?gWuh8XL6k/ZwbrXTdgs+23bgDlXuHZUVqwK9Nc69Q//zsRVA4abD03giWR?=
 =?iso-8859-1?Q?cdgvumPDBmDJQy9J5PTmm0h9Wt+RdN4vmDm9Sd17yAstuEiQQMdG6uf6jz?=
 =?iso-8859-1?Q?aQEDBL3wdjprYpSidQV2JlaxeHv9SSPxSRSFZXa1nl6g5jZA73CFZsfEgt?=
 =?iso-8859-1?Q?te8Blki2xO8VJF/4gALPb9sP0Va++7Ki253yOHQ5Y2GOR0aOCd+67zgwH7?=
 =?iso-8859-1?Q?AOp5Qdl/THpfw7qtYdKvNmJcTBap9vJwXXY9FAVSFvvsq+CRGMFMgjoTs1?=
 =?iso-8859-1?Q?3oP/U/T5JpPRivWJT/p9MgrrGMZJgMOrd0oXcN3oiEeXBPH2B5hCOGCfED?=
 =?iso-8859-1?Q?4v6E8p4kKrygv/H+M2aXNn4cL8YjCatJwn/elHtAWARJsCZyDfOTh4VOML?=
 =?iso-8859-1?Q?W1Q3kFYgiYYGwm/QpLPY05myr1W8dOpwz6Cg6eYade382lMW28JOmXihVZ?=
 =?iso-8859-1?Q?FAlg7frKu5GoiInyCEcYrZ9FGvMYStrYX/vedhsxyAU4kmmwV1TEsWuVEk?=
 =?iso-8859-1?Q?9ikVjkxSmsnUJL+ENvnCFT9LCdwdbeAUeUjSkt5XxHHzep?=
Content-Type: multipart/mixed;
	boundary="_004_MA0PR01MB97933ED6DCFEADB1CB62BDB3958FAMA0PR01MB9793INDP_"
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kpit.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB9793.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fcc57b-eaaa-44bb-5282-08de535152b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 09:43:07.8015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3539451e-b46e-4a26-a242-ff61502855c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKu8CovSNS1uuOO7YiLSDZ0iN2py2Czj5osacp+/VH2PamdNa2Q9M7t73dOBYAqv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN6PR01MB12249

--_004_MA0PR01MB97933ED6DCFEADB1CB62BDB3958FAMA0PR01MB9793INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0PR01MB97933ED6DCFEADB1CB62BDB3958FAMA0PR01MB9793INDP_"

--_000_MA0PR01MB97933ED6DCFEADB1CB62BDB3958FAMA0PR01MB9793INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

Udevadm-trigger and sd-device-monitor unconditionally increase the receive =
buffer size on netlink sockets. This helps avoid failures under high event =
loads, as below:
wait-for-udev: Failed to increase receive buffer size, ignoring: Operation =
not permitted

To address this, we need to allow udevadm to increase the buffer.
This may fix the issue that udevadm trigger hangs while processing the even=
ts
References:
- https://github.com/systemd/systemd/pull/29872

To support this in SELinux, this patch allows udevadm to use CAP_NET_ADMIN =
to extend
the socket receive buffer to hold more events.

Please review.

Regards,
Bhabu Bindu
This message contains information that may be privileged or confidential an=
d is the property of the KPIT Technologies Ltd. It is intended only for the=
 person to whom it is addressed. If you are not the intended recipient, you=
 are not authorized to read, print, retain copy, disseminate, distribute, o=
r use this message or any part thereof. If you receive this message in erro=
r, please notify the sender immediately and delete all copies of this messa=
ge. KPIT Technologies Ltd. does not accept any liability for virus infected=
 mails.

--_000_MA0PR01MB97933ED6DCFEADB1CB62BDB3958FAMA0PR01MB9793INDP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hello,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Udevadm-trigger and sd-device-monitor unconditionally increase the receive =
buffer size on netlink sockets. This helps avoid failures under high event =
loads, as below:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
wait-for-udev: Failed to increase receive buffer size, ignoring: Operation =
not permitted</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
To address this, we need to allow udevadm to increase the buffer.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This may fix the issue that udevadm trigger hangs while processing the even=
ts</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
References:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- https://github.com/systemd/systemd/pull/29872</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
To support this in SELinux, this patch allows udevadm to use CAP_NET_ADMIN =
to extend</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
the socket receive buffer to hold more events.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Please review.<br>
<br>
Regards,<br>
Bhabu Bindu</div>
This message contains information that may be privileged or confidential an=
d is the property of the KPIT Technologies Ltd. It is intended only for the=
 person to whom it is addressed. If you are not the intended recipient, you=
 are not authorized to read, print,
 retain copy, disseminate, distribute, or use this message or any part ther=
eof. If you receive this message in error, please notify the sender immedia=
tely and delete all copies of this message. KPIT Technologies Ltd. does not=
 accept any liability for virus
 infected mails.
</body>
</html>

--_000_MA0PR01MB97933ED6DCFEADB1CB62BDB3958FAMA0PR01MB9793INDP_--

--_004_MA0PR01MB97933ED6DCFEADB1CB62BDB3958FAMA0PR01MB9793INDP_
Content-Type: text/x-patch;
	name="0001-udev-allow-udevadmin-to-extend-socket-recv-buffer.patch"
Content-Description:
 0001-udev-allow-udevadmin-to-extend-socket-recv-buffer.patch
Content-Disposition: attachment;
	filename="0001-udev-allow-udevadmin-to-extend-socket-recv-buffer.patch";
	size=1556; creation-date="Wed, 14 Jan 2026 09:42:57 GMT";
	modification-date="Wed, 14 Jan 2026 09:43:07 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyN2VjZWIxNzk3ZTJhYTk0ODQ5OGIwZDI0MzQ5NzlhODFhYWI5N2E5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCaGFidSBCaW5kdSA8QmhhYnUuQmluZHVAa3BpdC5jb20+CkRh
dGU6IFdlZCwgMTQgSmFuIDIwMjYgMTQ6MTY6MzYgKzA1MzAKU3ViamVjdDogW1BBVENIXSB1ZGV2
OiBhbGxvdyB1ZGV2YWRtaW4gdG8gZXh0ZW5kIHNvY2tldCByZWN2IGJ1ZmZlcgoKVXBzdHJlYW0g
c3lzdGVtZCBjb21taXQgW2ViYTQ0OWZhODFmNl0gKFBSICMyOTg3MikgbW9kaWZpZXMgdWRldmFk
bS10cmlnZ2VyCmFuZCBzZC1kZXZpY2UtbW9uaXRvciB0byB1bmNvbmRpdGlvbmFsbHkgaW5jcmVh
c2UgdGhlIHJlY2VpdmUgYnVmZmVyIHNpemUKb24gbmV0bGluayBzb2NrZXRzLiBUaGlzIGhlbHBz
IGF2b2lkIGZhaWx1cmVzIHVuZGVyIGhpZ2ggZXZlbnQgbG9hZHMsCnN1Y2ggYXM6CndhaXQtZm9y
LXVkZXY6IEZhaWxlZCB0byBpbmNyZWFzZSByZWNlaXZlIGJ1ZmZlciBzaXplLCBpZ25vcmluZzog
T3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQKClRvIGFkZHJlc3M6ICJ3YWl0LWZvci11ZGV2OiBGYWls
ZWQgdG8gaW5jcmVhc2UgcmVjZWl2ZSBidWZmZXIgc2l6ZSwgaWdub3Jpbmc6Ck9wZXJhdGlvbiBu
b3QgcGVybWl0dGVkIiwgd2UgbmVlZCB0byBhbGxvdyB1ZGV2YWRtIHRvIGluY3JlYXNlIHRoZSBi
dWZmZXIuClRoaXMgbWF5IGZpeCB0aGUgaXNzdWUgdGhhdCB1ZGV2YWRtIHRyaWdnZXIgaGFuZ3Mg
d2hpbGUgcHJvY2Vzc2luZyB0aGUgZXZlbnRzClJlZmVyZW5jZXM6Ci0gaHR0cHM6Ly9naXRodWIu
Y29tL3N5c3RlbWQvc3lzdGVtZC9wdWxsLzI5ODcyCgpUbyBzdXBwb3J0IHRoaXMgaW4gU0VMaW51
eCwgQWxsb3cgdWRldmFkbSB0byB1c2UgQ0FQX05FVF9BRE1JTiB0byBleHRlbmQKdGhlIHNvY2tl
dCByZWNlaXZlIGJ1ZmZlciB0byBob2xkIG1vcmUgZXZlbnRzLgoKU2lnbmVkLW9mZi1ieTogQmhh
YnUgQmluZHUgPEJoYWJ1LkJpbmR1QGtwaXQuY29tPgotLS0KIHBvbGljeS9tb2R1bGVzL3N5c3Rl
bS91ZGV2LnRlIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vdWRldi50ZSBiL3BvbGljeS9tb2R1bGVzL3N5
c3RlbS91ZGV2LnRlCmluZGV4IGUyNDVhNjZhNC4uODJmZTgzNTRkIDEwMDY0NAotLS0gYS9wb2xp
Y3kvbW9kdWxlcy9zeXN0ZW0vdWRldi50ZQorKysgYi9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vdWRl
di50ZQpAQCAtNDQ3LDMgKzQ0Nyw2IEBAIHNldXRpbF9yZWFkX2ZpbGVfY29udGV4dHModWRldmFk
bV90KQogc3RvcmFnZV9nZXRhdHRyX2ZpeGVkX2Rpc2tfZGV2KHVkZXZhZG1fdCkKIAogdXNlcmRv
bV91c2VfdXNlcl90ZXJtaW5hbHModWRldmFkbV90KQorCisjIEFsbG93IHVkZXZhZG0gdG8gdXNl
IENBUF9ORVRfQURNSU4gdG8gZXh0ZW5kIHRoZSBzb2NrZXQgcmVjZWl2ZSBidWZmZXIgdG8gaG9s
ZCBtb3JlIGV2ZW50cworYWxsb3cgdWRldmFkbV90IHNlbGY6Y2FwYWJpbGl0eSB7IG5ldF9hZG1p
biB9OwotLSAKMi4zNC4xCgo=

--_004_MA0PR01MB97933ED6DCFEADB1CB62BDB3958FAMA0PR01MB9793INDP_--
