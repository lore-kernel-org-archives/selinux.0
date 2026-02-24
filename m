Received: from mx07-0015a003.pphosted.com (mx07-0015a003.pphosted.com [185.132.183.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3E3A1E96
	for <selinux@vger.kernel.org>; Tue, 24 Feb 2026 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947827; cv=fail; b=u7rT87NqmqOk5Mu6j9DI3JJJHqUQxLUqUGZh7AURBruOw+opQZ/VpwsLMMxdj4SrCRQvTZ5+8QN9VSwKk/5Qjvlhknl6JUhXyeBbIAaNLi6+9+XjSx4OjcGkbf7af2iavo2VYxUa600fUE46p6cGWexwFVh6JRKHZpEawF8gMtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947827; c=relaxed/simple;
	bh=RoscH8sSEzorpdYQpc9GY/DpTYtGBA0cl37A9UbBBx4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ISqcPiaq0kAoShbF14T4rXHld9q+YsCIVc9yBTrUKRDJ69vQGKk2V9mD4Uv9q03uCmufE/pgTFLuHG9p9xdZK+cjAjXaNlxmImC7ihFMrEFy+OkfNohbgklBq6HouvlZd594yv6Atggs7jv6EqA/tDRl4bk1vIoayQ5NXNEIBbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=entrust.com; spf=pass smtp.mailfrom=entrust.com; dkim=pass (2048-bit key) header.d=entrust.com header.i=@entrust.com header.b=iRsAJpwD; arc=fail smtp.client-ip=185.132.183.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=entrust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=entrust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=entrust.com header.i=@entrust.com header.b="iRsAJpwD"
Received: from pps.filterd (m0242864.ppops.net [127.0.0.1])
	by mx08-0015a003.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O73IYC4054369
	for <selinux@vger.kernel.org>; Tue, 24 Feb 2026 09:17:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=entrust.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=mail1; bh=Rosc
	H8sSEzorpdYQpc9GY/DpTYtGBA0cl37A9UbBBx4=; b=iRsAJpwD/CaEezYInQR2
	oYW/ibgi9FhaV6dykw1P8xFUgyHbOEjCtHxLHjtd6bxdh/bp3H+aLIcWe9egT/7X
	KJQimbsbLlxYUZjKj4uBtJ0zD0UEPa53hMWMcvObEt21tlcGENXVkMHmeu0iCmt6
	dxMiKWKeVspD3ffUiUPQ6xZUTktqHgQsn4CKELiKK47+GJvWyEAwsbSGsU/RA08w
	jqx5LQdEkIwZmQtgVkVpHJdZ8jBHo/FXF5qa5Rhyvew+ol08ukYaR4cRWiROSdbf
	IOfWQoOhuXVDsgJy8MJxCiZl1YZIntIx1yMbjUm2ZDkfalY0xp2zYZFSH1zK5hsj
	RA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022117.outbound.protection.outlook.com [52.101.43.117])
	by mx08-0015a003.pphosted.com (PPS) with ESMTPS id 4ch78p18dy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <selinux@vger.kernel.org>; Tue, 24 Feb 2026 09:17:47 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsCfdp1w/fksjJRX+BKhbwvfmy0iDjcoQlwMc4beifu0INKk6mGOcIcvlqbaFRp9g3Gf4i/kunQje5c2hi4Q0PSnNh/EdL7asDSi9dHoR3crMwPBamLIHIXixC2WT1dK+9ZbkaVNm4uyq1cILY2HfMLZsNygGMlPjLn/CpOsLnaylYcEfFICoBjn7J/cZljYjXymYOIXsVmBRfTrLGLuP48lttVMIK+eE0MzmMyw0GAAeT8RSgJsSYGwZeeKG3bBNQDUK2BBeyYQqzq648ae8FkeYB8quIbkG8UEJZuEu9IN5mrmHInYWTQbpcHI4b/t/5121AcCduOf9vEQIgstsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoscH8sSEzorpdYQpc9GY/DpTYtGBA0cl37A9UbBBx4=;
 b=irWYMd7DV6oNsylpgzcnKI/mGaaJG7ATgC0ha9fWI0q69W3ZXkFGUlymurkjt23YCJ9XTnudFuw5GPVsGLcMRTfA93Xn5GiJoO2qEdU1qdWraR8AiUhu3zN1D5eJlTVw+7VR6eUzgoRvNMy/CjlLvxtKGJA1EUI+ROO1yC4Yhlv/bUYE6WwR5H8Qc6JxwaY+nyecskOtcnohkZWykjI3vxJqa28Yas8hJin4FtIzr+trORZeGDym0mw988v6Hb1+epxdfr/6OgB3Yafs8CMv4zn9rq0k5PXytAzBVpR4sTAKXEBpPDSk/fQfzGtZORyt5f7366iSh1z4moiaBjLtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=entrust.com; dmarc=pass action=none header.from=entrust.com;
 dkim=pass header.d=entrust.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by LV4PR11MB9513.namprd11.prod.outlook.com
 (2603:10b6:408:2e4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 15:17:43 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::5b66:a716:98b5:3316]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::5b66:a716:98b5:3316%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 15:17:43 +0000
From: Martin Bonner <Martin.Bonner@entrust.com>
To: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Missing audits
Thread-Topic: [EXTERNAL] Re: Missing audits
Thread-Index: AdyU98MVl2YjIjwCQCOJLsJiRiO9TAAUp5qAABq6pAADztBAAAAsBR7g
Date: Tue, 24 Feb 2026 15:17:43 +0000
Message-ID:
 <PH3PPF7A88A980A03C24DC5B77D49DA02F2F374A@PH3PPF7A88A980A.namprd11.prod.outlook.com>
References:
 <PH3PPF7A88A980A236C1D23F1FDB87FAA2CF39BA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
 <CAEjxPJ4BP1isHT2T0sL1K58bLycwocG8FGFK2OSrkA6Qc3Pxag@mail.gmail.com>
 <PH3PPF7A88A980A2ECF46C2CF01AF290FEBF377A@PH3PPF7A88A980A.namprd11.prod.outlook.com>
 <CAEjxPJ6_kQDikuPi6uYZBg2UmPV0v5KR48N7rskBQ5HPnr22pQ@mail.gmail.com>
In-Reply-To:
 <CAEjxPJ6_kQDikuPi6uYZBg2UmPV0v5KR48N7rskBQ5HPnr22pQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|LV4PR11MB9513:EE_
x-ms-office365-filtering-correlation-id: 7e300a91-84bb-4827-4620-08de73b7dbca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7142099003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkN4dzNSQ01OdzFyVmJWM2VRR1VONkk2UEdCb24zUFVEMXg3YmhJVEU4NlZx?=
 =?utf-8?B?VE5sN29IMXhuczNEeHVCZUdGQ0pnUS9ldGdJVGNEUkNtT2t6QTdRa0ZOWFJ4?=
 =?utf-8?B?Z2xjVUJZMThicGQrTHlYVmdZMC9wWmFRY01mOWhNbXZEUFpmQWFnMWR5TFh4?=
 =?utf-8?B?MXZtaHBkSkNwUFBHYk9GQlFRdXBmTm13TWl4VGNHMU9DSHMvSlVZbjV0WWFM?=
 =?utf-8?B?b3d4U1Iwa1lyQ3hqSG5hSU82d29DYW9aTVdRVmZ2NzRjL1ZnVVE4dkgrUzR1?=
 =?utf-8?B?UDh6czhaSHR1aC9BZE9FMzhZb0htRUxqZ0JrL1k2SDBCSnVVSldWQTltendK?=
 =?utf-8?B?NWN5c1dzMVM5QVRETmNKMW52MWh6NG9mWGQ3WFZMK3h1cDY0K2EvdEx6eWov?=
 =?utf-8?B?bWFJcVJUZ3poVmdCeXBSM2kzajBEVGMxR2JPUWxSZ0xEUkZKdG5mMm1OWGRG?=
 =?utf-8?B?eStQZFQ1Q2Rpb0Y0dEtCR09VZVZ1STI5UWFUMFFLUlQwR05EcktZSndQZEQ0?=
 =?utf-8?B?NFovVFdOZDhuVXNoT2NCaFFYK3RYeGlkSkFIUFVML01sNHhhSE5KSjVCSEZM?=
 =?utf-8?B?Y1RQRjdIVmRTK1k4Rm1mc0dqbnBaUWkxWU12UWdaR2Jmb0s5citOU0dWVVhq?=
 =?utf-8?B?TDlNVGVvV1UrS0trOVlMNzZFWTBEa1RORWM4Sk5KY1JySFN1UjZLWjNnVFo4?=
 =?utf-8?B?NTlQZGJQaHR4SUdreVlXaG1VcGdJM25KNkpoOGtySGpPU0o1aUhKUnpTM1U1?=
 =?utf-8?B?MUhpNFFhQ292M0NzbU1DZFBSdURXcjd6Z3NwSlE1VDRnWVdOK1kvNmdkK1VS?=
 =?utf-8?B?SUE3bE5IT2xzbFExY2FWMENsWHlNajVtK2VGKzdZbllNTUI5UGZFOStJSkxZ?=
 =?utf-8?B?aitFY2FORS9neGU0WFVub1ZBekdiZTM4Wk5nSnFhT21Wbm0wRGE4Z0crU3l3?=
 =?utf-8?B?M1d3K3R3VFQwZGRIOHN0R05VQUpnZThzWDdJZDJLU1dvb0c5VWlGTjlPK0ZI?=
 =?utf-8?B?TjBzNjdaa0Ivb2tnblhCb1hJa3ova1F6TG44MTRjalQ1K3k3UTNmcUhSRHJR?=
 =?utf-8?B?YU5XNU5MRHV0VGdXZUFJMmlQcURUb21CcjV5eTZEUmt1ZFdrZVNiV1RMN0ls?=
 =?utf-8?B?dGtBMkM3d0p1MXVaYjBQMTl6U0VQYTR4QTFmMXo1cDFsbm1OVWgwWS9PdTR3?=
 =?utf-8?B?WWdoOVYwenpuZUVSWSsyWEJVdEQ4MXg4Z2ljYlVjeGQ1ZERjb0Z5Y3I2eUVq?=
 =?utf-8?B?YzlWUmUwOVZpODFpT0NVM0hOY3NtNk54MU94ekJQTWF0TzN2RUw2Rlg1aXJK?=
 =?utf-8?B?NmJ5MU03SVNmdElPK3VxVFM0ODBSN2pYNGkzOWdGN0xhUzdRRzZGMWRKOTdQ?=
 =?utf-8?B?cFd5NHU2SkhQVW9VRU4zSFJFeFFtbWtXbVRMOXRUVUg2STljYTFmckNXNHZ1?=
 =?utf-8?B?MFB6NmNvTW5oL3hUT0h6UUdVWFA0by9aazF3TXMwVUNNUXdCS0kwUlpSR2tE?=
 =?utf-8?B?WFdoTUt0ZG52VVdyTzlNMno4WTYwb2N2QXhKUHdQellZbjYxUFpVTHFUTGRT?=
 =?utf-8?B?QzF1V1c5T09NU3NaWElSRHhmTVhmbkR2akFSTmZ2bFRpRVFycVI5M3J2Wm4w?=
 =?utf-8?B?d3J4STRwbzlmTG1XREtKRWpEanJWVnEyVVVjZjNmZDZKUXdVWXY0eG5ZTVdG?=
 =?utf-8?B?bVVQanBCeFNZc0ZNR1JqRCtaKzd2U0hYVmlUcG0rbVNBWkdqTkEyVkJweVh6?=
 =?utf-8?B?amNaUWVWN0hXR1ZRMEZyS2RReWFGYXBud2dNSE05WWFwZStBM0dieitZcVA0?=
 =?utf-8?B?R20yYmQ1ejRNSHU4eWltZVdFWmMxUi80WHlOcmhoYmF4cXk4eHR5SHc2QUVh?=
 =?utf-8?B?ZW1rMW9aKzFUazcvU0NmUHh5RXUwcThCazc1Ym11bnF4QXQvWlBsbldPQkNn?=
 =?utf-8?B?dFFwWi9XZHNBNVlhSHdWVTQwUDlYSElzMmpvMC9CSEtDdUROQ0RHOGhzRzVj?=
 =?utf-8?B?NFUyS2hGWkVERHhiWTJxaENENXBLNzAzYUo1VXFneFZkWG1DZitEejk1VjZL?=
 =?utf-8?B?ZnJWYUU5NmtpWnRlR3F1YlBHNGgvT3dXTHB2MDZQdWxKRVNETytUN3pldFdl?=
 =?utf-8?B?ZWR3ZmlmYWV5R2hEOVVNV1JUd3dxWVk0Um1Rb3Fyd01LQTdPRW5PTkM3SnVy?=
 =?utf-8?Q?zUY3me5ZO4yYwHtHN5hdT24=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF7A88A980A.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVNwSjdRNEVBVzBEV2g1bWk3VGxIVDdLakFzUksvaHdDQUU0WjFjNkVWSHJp?=
 =?utf-8?B?VWhRbnB6VWFReVlKQ3dlaXkzYWpHU0lHYjBGdEpOTmFmSldaYjY1Ym1DdmxN?=
 =?utf-8?B?bmRSN2MzYWpEZTRQMjhnWHVBMzVDRExRUmt2dlphekJjZVQybjcvSEEvVTBI?=
 =?utf-8?B?bEliYVZCT2M0UVcxaEhYUXZha1JKY0pDbTJLU0RUcFhOS0JVZTVBYWNTU0N1?=
 =?utf-8?B?MWNyWFJGcnVxMngyRzRYM1JKMStmZTk0RVQ5UkpNRTBuV3VRK0lsWUxNWldq?=
 =?utf-8?B?SG9xaVRQUGVub0ZFQTF5SGtGUU9nM2g2ZEpKMjRnc3lXWFZWY3hHaUU2NHRY?=
 =?utf-8?B?SWpORWlxcG9TazI5ckNuRCtVY05OVzdQdVNGdk5VUFFMK3dUOWQ3V2FrS1dK?=
 =?utf-8?B?VHpUZVVjZ0VFR3JjTnpyZCs5OXJEQzRiTFpyL3F6bTNvci9uZHM2dEZyckRH?=
 =?utf-8?B?U3N1SzUrS28ydlRpMkpZRVhvMFgxaE9jN0hYblV5WVR5K0JFRFdqQzRFMklC?=
 =?utf-8?B?VW5pcE00NC9Tb0VGQUlJUXRMK205SDlJTmVjTlJUVVRTTTN1Uk5vNEcrK0RC?=
 =?utf-8?B?MFIzUUZXWVN3TW12cUFnTVBzZGJRTzJMaXE0d3lYd1hNdVh1N3RVWFpLTWhQ?=
 =?utf-8?B?TGxGNUdUeTA2WThjdXVSZ0lwd2dwWjZvN0VjcHBWeng5Nk1YQW55ZklwTS9l?=
 =?utf-8?B?SWpWQW9lQzNsNDZmTWo4bDAzZDBtMWc0bnVYY0xDWXlHdWs0R1JUK2tUZ3Q1?=
 =?utf-8?B?cjlvVEhFQW1UMTE4aVVnK1BBNytQZWVoZCtwWlBBZjRaMVpNWUJlemVsampz?=
 =?utf-8?B?WlJOWEpvdm5hN0dURU16WVVmUzhXcGdjcG5TeVBRWUhEbURTdnJBVFF4Zjk5?=
 =?utf-8?B?aWx0WHNtRU1PeitZanBJME90NjJidVB5NkREYm1Zdml2SFhhdDJqYlQwZVRi?=
 =?utf-8?B?Z2FSd0t0T2F2WU5ncWw0SXVCK3dxNkN4K2Y3NXhoZTkwZDYzeFB4ZnRNL0Fo?=
 =?utf-8?B?UXVqaHBoWk1zQ1dzTFN6ZzA1OFRSYkJJTFdNUXp5WUFmcmdNeDlrK3Q4S052?=
 =?utf-8?B?ekIwNW8yVjgycmEzZ0ZEbEh3S3BCTzVlcDJxVUxWdkN0aHh2YXdoVEJycVlE?=
 =?utf-8?B?MmVpajBXZjFtWjZrK2tGRWcxSm93bmlVQ1lTNFZGQmNDcWx3Mi8vWUxjVjFQ?=
 =?utf-8?B?UTU2Q2crMDFOcW5FVDg2dnptcVA1L3dYbGdZUDJYZURYTWV2MVlVUjFYRlVZ?=
 =?utf-8?B?WkE1MWtWeW02ck1YaGVaUlNaR2w1VTNyUCtWTzMzdUtCN1htZ0dLMlhpcmxC?=
 =?utf-8?B?SWRwTFoxbEVZY1BUbDJXOGJSc0MzbVI0SHBlSVVsK0NsK2J2bmpBdmh1WnA0?=
 =?utf-8?B?cloxeUZHYk1jM3VDWU1yYnI5MDU1TTVwRUZaV2o3U2ljZ2xDeE1YY3kxaXFn?=
 =?utf-8?B?Y1ZxRFZORGhjNWxxSkFFMEhJWUVBYTFqbUYyUngwNWluTWdVVlpVbUVNT25v?=
 =?utf-8?B?TEdkTHQ2ZHZaa0dwMGVOQ3ZoWkNGNlFZbHhpb3d0S2dzUFV2Rk9pMFZKNTg4?=
 =?utf-8?B?Z0VYUmV4bk9IYlhLNTF3dVA0Q1JMODl0aGJuODJDSk1Xb0RtK2ZGclNtbmFM?=
 =?utf-8?B?b0dYdG5Pc3gyZCtHMHo3bG5ZRi8wamR6SjhqbUhKVHpuTFM5SktxcUMzMmZ1?=
 =?utf-8?B?QlFYaUdkV1ZsNHF5RWxBcEFMQ25hOWxwaWx1STJBdkpmTGowVWtpWjV5bnMv?=
 =?utf-8?B?MC9oUnJHUEMrMG1vazMybytwa2huTHQ5RlhNVFVJTE5aU2VCT1llZ0RUaVpR?=
 =?utf-8?B?RkliZjZoeU1Tb1owMEl0MCtxUXhmaWo0bTh4dHR0UjY1dmN5a2VqclVzekZU?=
 =?utf-8?B?Z0pCa2hvcFc3Mkp5eXJmcjltbHg2b3hESmpHSGhDZUQ5S3YvSUlsTENwVExu?=
 =?utf-8?B?SmNIWnZNZEljNkxUVEpOTlJwQW5qdEtMdU92dE1ZOVFFN1NERXdodkRKak9R?=
 =?utf-8?B?TmYrdTZiU3BzVTQ4Z01WbERsQ0cwS1VPQjcvdlhKQWFpQnZucU1rekxUV29O?=
 =?utf-8?B?eFl0dnZtNHdoVXE2ZStYOHQ5U3BrOFNqK3VHSFI2QVRCUzBUYjNwd1Y1SWNX?=
 =?utf-8?B?YW5hL2FjTUpLUzMwbXV3L3loZXU1YUtCNWVuUG9obnIvbGVuUnpUMW8xbmQv?=
 =?utf-8?B?bjV4ZVRKdTk0dTJBYW41bmZXN3UyVmxXTlpNZkwwNXc1SzFxSEFWU2VRK1Bh?=
 =?utf-8?B?LzlVeEpPOTcwazg1NjE1ZUVQY0ZOK1VVMVdXK1diM0V4MTBNOHJmWkZlaXpp?=
 =?utf-8?B?T1NIM082WHBYRTZWN3AwSjRieVl3a0owdHdydm5FUWZha3d0UXdkZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e300a91-84bb-4827-4620-08de73b7dbca
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 15:17:43.6306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f46cf439-27ef-4acf-a800-15072bb7ddc1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dU9vA+fFBfstLyYVaexuRajTqecs/whBFb1tkM5yJRljYCLGEHnJL04K0cAo+YGs3exEYsBN4IdcQeZ7TfvLN8U7G8dKtWYoV3jR0m2skJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9513
X-Proofpoint-GUID: 6kNzfVcBAPY0jHtrbfHp8Vo_WgH-Dxpy
X-Proofpoint-ORIG-GUID: 6kNzfVcBAPY0jHtrbfHp8Vo_WgH-Dxpy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEyNiBTYWx0ZWRfX0xqUy3OBVTVW
 9kbRmZWU1KMrKyWujYjs2kAgD/IuEqdo+gcBz4FpOQI45XULw6boY0fXxmWmZD3Ov7E1nvJhdvE
 Zh63DBQULoy9XCuLDtqX4IWEghzCotceECasWIygd/EnPSyCaNjr4YNOE/LpD8gv78dLCIt3Hgz
 +fY0xDLhKHTcwMDnEZyVY3tJFesIQlRheqTkwYEMcr9WgxbOe6YT/wDSjTyLWAGZtDHzStMXOuz
 uqPc4D3HCyLg/jhMojHeWN42rEjEC0+2JJhcIsFOejlYlEE5qL1VX67tjhmnmAFFu5SVGtPK6Qg
 Fo0J8FKo6qsO3Rhfy59ArT62aY6UtnNLFxWbBxE2Qe8c6B7sGuSBzkgpWZ5vYV9qCu0dA5wK3Gu
 zqf+zl5hdu0pGEDP6HIi6+WD25qub3IpfYD2VsvK1e9US72kcvU3nvZgrrjIc0iHyzAUNr4U2Hv
 a6hy+IwYc+hqv0q0ybg==
X-Authority-Analysis: v=2.4 cv=Oq9CCi/t c=1 sm=1 tr=0 ts=699dc11b cx=c_pps
 a=iJiELcvq6ykPrekD1vp3Qg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=FEbzDYiKvWYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=h-oifH6qfStUR2Cxvazp:22 a=XchpXerGWSS0xoZXs9lB:22 a=XUe_gMu_AAAA:8
 a=pGLkceISAAAA:8 a=Tm318pJsuALW3gTpY6EA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=Hyxxk7IO8alR8e2HbrPC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240126

PiBGcm9tOiBTdGVwaGVuIFNtYWxsZXkgPHN0ZXBoZW4uc21hbGxleS53b3JrQGdtYWlsLmNvbT4N
Cj4gU2VudDogMjMgRmVicnVhcnkgMjAyNiAxODoxNw0KPg0KPj4gT24gTW9uLCBGZWIgMjMsIDIw
MjYgYXQgMTE6NDfigK9BTSBNYXJ0aW4gQm9ubmVyDQo+PiA8bWFpbHRvOk1hcnRpbi5Cb25uZXJA
ZW50cnVzdC5jb20+IHdyb3RlOg0KPj4+IEZyb206IFN0ZXBoZW4gU21hbGxleSA8bWFpbHRvOnN0
ZXBoZW4uc21hbGxleS53b3JrQGdtYWlsLmNvbT4NCj4+PiBTZW50OiAwMyBGZWJydWFyeSAyMDI2
IDIwOjE5DQo+Pj4NCj4+PiBPbiBUdWUsIEZlYiAzLCAyMDI2IGF0IDU6MjnigK9BTSBNYXJ0aW4g
Qm9ubmVyDQo+Pj4gPG1haWx0bzpNYXJ0aW4uQm9ubmVyQGVudHJ1c3QuY29tPiB3cm90ZToNCj4+
Pj4NCj4+Pj4gSSBhbSB3b3JraW5nIG9uIGFuIGVtYmVkZGVkIHN5c3RlbSB1c2luZyBidWlsZHJv
b3Qgd2l0aCBTRUxpbnV4LiAgSQ0KPj4+PiBoYXZlIGNoYW5nZWQgYSBkaXJlY3RvcnkgcGVybWlz
c2lvbiBmcm9tIHdvcmxkLXJlYWQtc2VhcmNoIHRvDQo+Pj4+IHdvcmxkLW5vLWFjY2VzcywgYW5k
IG15IGRldmljZSBub3cgZmFpbHMgdG8gc3RhcnQgdXAgY29ycmVjdGx5IGlmIFNFTGludXggaXMg
c2V0IHRvIGVuZm9yY2luZy4NCj4+Pj4gSSBrbm93IGl0IGlzIFNFTGludXggYmVjYXVzZSBpZiBJ
IGRvbid0IHNldCBlbmZvcmNpbmcsIGV2ZXJ5dGhpbmcNCj4+Pj4gaXMgcGVyZmVjdGx5IGhhcHB5
Lg0KPj4+Pg0KPj4+PiBPbmUgYWRkaXRpb25hbCBjb21wbGV4aXR5OiAgdGhlIGFjY2VzcyB0byB0
aGUgZGlyZWN0b3J5IGlzIChvcg0KPj4+PiBzaG91bGQgYmUpIGhhcHBlbmluZyBpbnNpZGUgYW4g
bHhjIGNvbnRhaW5lciAod2l0aCBsdWNrIHRoaXMgaXMgaXJyZWxldmFudCkuDQo+Pj4NCj4+PiBX
aGVuIHlvdSBzYXkgeW91IGxvb2tlZCBhdCB0aGUgYXVkaXQgbG9ncywgYXJlIHlvdSBvbmx5IGxv
b2tpbmcgYXQNCj4+PiB3aGF0IGF1ZGl0ZCBoYXMgd3JpdHRlbiBvdXQgdW5kZXIgL3Zhci9sb2cv
YXVkaXQgb3IgYWxzbyBjaGVja2luZw0KPj4+IGpvdXJuYWxjdGwsIGRtZXNnLCBvciBjYXQgL3By
b2Mva21zZyBmb3IgYW55IG1lc3NhZ2VzLg0KPj4NCj4+IEkgd2FzIG9ubHkgbG9va2luZyBhdCAv
dmFyL2xvZy9hdWRpdCAod2VsbCwgdGhlIGxvY2F0aW9uIHdlIHNoaWZ0ZWQgdGhhdCB0bykuDQo+
Pg0KPj4gZG1lc2csIGFuZCAvdmFyL2xvZy9tZXNzYWdlcywgYW5kIHRoZSBjb25zb2xlIG91dHB1
dCwgYWxsIHNob3cgdGhlDQo+PiBzYW1lIGZldw0KPj4gYXVkaXQ6IG1lc3NhZ2VzIC0gYnV0IG5v
bmUgb2YgdGhlbSBzZWVtIHRvIGJlIHJlbGV2YW50LCBhbmQgdGhleSBhcmUNCj4+IGFsbCBwcmVz
ZW50IHJlZ2FyZGxlc3Mgb2YgdGhlIGRpcmVjdG9yeSBtb2RlDQo+Pg0KPj4+IFdhcyB0aGUgc3lz
dGVtIHdvcmtpbmcgd2l0aCBTRUxpbnV4IGluIGVuZm9yY2luZyBtb2RlIGJlZm9yZSB5b3UNCj4+
PiBtYWRlIHRoZSBjaGFuZ2UgdG8gdGhlIGRpcmVjdG9yeSBtb2RlLCBvciB5b3UgaGFkbid0IHRy
aWVkIGl0IHlldD8NCj4+IFllcyBpdCB3YXMuICAoR29vZCBxdWVzdGlvbiB0aG91Z2guKQ0KPj4N
Cj4+Pg0KPj4+IERvZXMgeW91ciBzeXN0ZW0gbG9vayBiYXNpY2FsbHkgc2FuZSBpbiB0ZXJtcyBv
ZiBwcm9jZXNzIGFuZCBmaWxlDQo+Pj4gbGFiZWxzPyBJZiB5b3UgaGF2ZSBzZXN0YXR1cyBpbnN0
YWxsZWQsIHdoYXQgZG9lcyBzZXN0YXR1cyAtdiByZXBvcnQ/DQo+Pg0KPj4gWWVzLCB0aGUgbGFi
ZWxzIGxvb2sgcmVhc29uYWJsZS4NCj4+DQo+PiBJdCByZXBvcnRzIGFzIGZvbGxvd3M6ICBOb3Rl
LCBJIGFtIHJ1bm5pbmcgaW4gcGVybWlzc2l2ZSBtb2RlIGhlcmUNCj4+IGJlY2F1c2UgdGhhdCBt
YWtlcyBkZWJ1Z2dpbmcgbXVjaCBzaW1wbGVyLCBhbmQgSSBjdXJyZW50bHkganVzdCB3YW50DQo+
PiB0byBmaW5kIHRoZSB0ZXh0IG9mIHRoZSAqKioqKiBhdWRpdC4NCj4+DQo+PiAjIHNlc3RhdHVz
IC12DQo+PiBTRUxpbnV4IHN0YXR1czogICAgICAgICAgICAgICAgIGVuYWJsZWQNCj4+IFNFTGlu
dXhmcyBtb3VudDogICAgICAgICAgICAgICAgL3N5cy9mcy9zZWxpbnV4DQo+PiBTRUxpbnV4IHJv
b3QgZGlyZWN0b3J5OiAgICAgICAgIC9ldGMvc2VsaW51eA0KPj4gTG9hZGVkIHBvbGljeSBuYW1l
OiAgICAgICAgICAgICB0YXJnZXRlZA0KPj4gQ3VycmVudCBtb2RlOiAgICAgICAgICAgICAgICAg
ICBwZXJtaXNzaXZlDQo+PiBNb2RlIGZyb20gY29uZmlnIGZpbGU6ICAgICAgICAgIHBlcm1pc3Np
dmUNCj4+IFBvbGljeSBNTFMgc3RhdHVzOiAgICAgICAgICAgICAgZW5hYmxlZA0KPj4gUG9saWN5
IGRlbnlfdW5rbm93biBzdGF0dXM6ICAgICBkZW5pZWQNCj4NCj4gZGVueV91bmtub3duIG1lYW5z
IGRlbnkgYW55IHBlcm1pc3Npb25zIG5vdCBkZWZpbmVkIGJ5IHlvdXIgcG9saWN5Lg0KPiBEaWQg
eW91IGdldCBhbnkgU0VMaW51eDogbWVzc2FnZXMgZHVyaW5nIHBvbGljeSBsb2FkIGFib3V0IHVu
a25vd24NCj4gcGVybWlzc2lvbnM/IENhbiB5b3Ugc2hhcmUgYWxsIG1lc3NhZ2VzIHRoYXQgc3Rh
cnQgd2l0aCBTRUxpbnV4OiBvcg0KPiBhdmM6IGZyb20geW91ciBkbWVzZyBvciAvdmFyL2xvZy9t
ZXNzYWdlcyBvciBjb25zb2xlIG91dHB1dD8NCg0KSSBnZXQNCiMgZG1lc2cgfCBncmVwIFNFTGlu
dXg6DQpbICAgIDAuMDI1MDEzXSBTRUxpbnV4OiAgSW5pdGlhbGl6aW5nLg0KWyAgIDE0LjA3NTU5
NF0gU0VMaW51eDogIHBvbGljeSBjYXBhYmlsaXR5IG5ldHdvcmtfcGVlcl9jb250cm9scz0xDQpb
ICAgMTQuMDgwMjY2XSBTRUxpbnV4OiAgcG9saWN5IGNhcGFiaWxpdHkgb3Blbl9wZXJtcz0xDQpb
ICAgMTQuMDgzOTM3XSBTRUxpbnV4OiAgcG9saWN5IGNhcGFiaWxpdHkgZXh0ZW5kZWRfc29ja2V0
X2NsYXNzPTENClsgICAxNC4wODg1NjJdIFNFTGludXg6ICBwb2xpY3kgY2FwYWJpbGl0eSBhbHdh
eXNfY2hlY2tfbmV0d29yaz0wDQpbICAgMTQuMDkzMTAwXSBTRUxpbnV4OiAgcG9saWN5IGNhcGFi
aWxpdHkgY2dyb3VwX3NlY2xhYmVsPTENClsgICAxNC4wOTcyMTRdIFNFTGludXg6ICBwb2xpY3kg
Y2FwYWJpbGl0eSBubnBfbm9zdWlkX3RyYW5zaXRpb249MQ0KWyAgIDE0LjEwMTgzOF0gU0VMaW51
eDogIHBvbGljeSBjYXBhYmlsaXR5IGdlbmZzX3NlY2xhYmVsX3N5bWxpbmtzPTANClsgICAxNC4x
MDY2MzZdIFNFTGludXg6ICBwb2xpY3kgY2FwYWJpbGl0eSBpb2N0bF9za2lwX2Nsb2V4ZWM9MA0K
DQo+DQo+PiBNZW1vcnkgcHJvdGVjdGlvbiBjaGVja2luZzogICAgIGFjdHVhbCAoc2VjdXJlKQ0K
Pj4gTWF4IGtlcm5lbCBwb2xpY3kgdmVyc2lvbjogICAgICAzMw0KPj4NCj4+IFByb2Nlc3MgY29u
dGV4dHM6DQo+PiBDdXJyZW50IGNvbnRleHQ6ICAgICAgICAgICAgICAgIHJvb3Q6c3lzYWRtX3I6
c3lzYWRtX3Q6czANCj4+IEluaXQgY29udGV4dDogICAgICAgICAgICAgICAgICAgc3lzdGVtX3U6
c3lzdGVtX3I6a2VybmVsX3Q6czANCj4NCj4gVGhlIGluaXQgcHJvY2VzcyBzaG91bGQgcmUtZXhl
YyBvciBkeW5hbWljYWxseSBzd2l0Y2ggaXRzIGNvbnRleHQgdG8NCj4gaW5pdF90IGFmdGVyIGxv
YWRpbmcgcG9saWN5IHJhdGhlciB0aGFuIHN0YXlpbmcgaW4ga2VybmVsX3QuDQoNCldlIGFyZW4n
dCB1c2luZyBhIGxvYWRhYmxlIHBvbGljeSwgYXMgSSB1bmRlcnN0YW5kIGl0LCBpdCdzIGJ1aWx0
IGludG8gdGhlIGtlcm5lbCBhdCBidWlsZCB0aW1lLiAgSSBkb24ndCBrbm93IGlmIHRoYXQgbWFr
ZXMgYSBkaWZmZXJlbmNlLg0KDQpUaGUgY29kZSB3aGljaCBpcyBjcmVhdGluZyB0aGUgZGlyZWN0
b3J5IGlzIGFscmVhZHkgcnVubmluZyBpbiBhIGRpZmZlcmVudCBjb250ZXh0IGFueXdheS4NCj4N
Cj4+IC91c3Ivc2Jpbi9zc2hkICAgICAgICAgICAgICAgICAgc3lzdGVtX3U6c3lzdGVtX3I6c3No
ZF90OnMwDQo+Pg0KPj4gRmlsZSBjb250ZXh0czoNCj4+IENvbnRyb2xsaW5nIHRlcm1pbmFsOiAg
ICAgICAgICAgcm9vdDpvYmplY3Rfcjp1c2VyX3R0eV9kZXZpY2VfdDpzMA0KPj4gL2V0Yy9wYXNz
d2QgICAgICAgICAgICAgICAgICAgICBzeXN0ZW1fdTpvYmplY3RfcjpldGNfdDpzMA0KPj4gL2V0
Yy9zaGFkb3cgICAgICAgICAgICAgICAgICAgICBzeXN0ZW1fdTpvYmplY3RfcjpzaGFkb3dfdDpz
MA0KPj4gL2Jpbi9sb2dpbiAgICAgICAgICAgICAgICAgICAgICBzeXN0ZW1fdTpvYmplY3Rfcjps
b2dpbl9leGVjX3Q6czANCj4+IC9iaW4vc2ggICAgICAgICAgICAgICAgICAgICAgICAgc3lzdGVt
X3U6b2JqZWN0X3I6c2hlbGxfZXhlY190OnMwDQo+PiAvc2Jpbi9pbml0ICAgICAgICAgICAgICAg
ICAgICAgIHN5c3RlbV91Om9iamVjdF9yOmluaXRfZXhlY190OnMwDQo+PiAvdXNyL3NiaW4vc3No
ZCAgICAgICAgICAgICAgICAgIHN5c3RlbV91Om9iamVjdF9yOnNzaGRfZXhlY190OnMwDQoNCj4+
IEFueSBlbWFpbCBhbmQgZmlsZXMvYXR0YWNobWVudHMgW3lhZGEsIHlhZGEgeWFkYV0NCj4NCj4g
UGxlYXNlIHJlbW92ZSBzdWNoIHN0YXRlbWVudHMgZnJvbSBlbWFpbHMgeW91IHBvc3QgdG8gcHVi
bGljIG1haWxpbmcNCj4gbGlzdHMgaWYgeW91IGFyZSBhYmxlIHRvIGRvIHNvLg0KDQpTb3JyeSwg
SSBoYXZlIG5vIGNvbnRyb2wgb3ZlciB0aGF0IG5vbnNlbnNlLiAgSXQgZ2V0cyBhZGRlZCBhZnRl
ciBJIHByZXNzICJzZW5kIiA6LSgNCg0KLS0NCk1hcnRpbg0KQW55IGVtYWlsIGFuZCBmaWxlcy9h
dHRhY2htZW50cyB0cmFuc21pdHRlZCB3aXRoIGl0IGFyZSBpbnRlbmRlZCBzb2xlbHkgZm9yIHRo
ZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwgb3IgZW50aXR5IHRvIHdob20gdGhleSBhcmUgYWRkcmVz
c2VkLiBJZiB0aGlzIG1lc3NhZ2UgaGFzIGJlZW4gc2VudCB0byB5b3UgaW4gZXJyb3IsIHlvdSBt
dXN0IG5vdCBjb3B5LCBkaXN0cmlidXRlIG9yIGRpc2Nsb3NlIG9mIHRoZSBpbmZvcm1hdGlvbiBp
dCBjb250YWlucy4gUGxlYXNlIG5vdGlmeSBFbnRydXN0IGltbWVkaWF0ZWx5IGFuZCBkZWxldGUg
dGhlIG1lc3NhZ2UgZnJvbSB5b3VyIHN5c3RlbS4NCg0K
