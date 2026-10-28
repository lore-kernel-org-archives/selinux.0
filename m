Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=23.103.208.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793193080;
	b=ICi5L8rw++MZcmdWuaa1/7ZSinMvK58Hp+OlYGA9nlkrk6xd8r6/vD2O1z2eSaDhoiJB
	 dTdSS3sPTahurWWsJVqycg6C+59rmRKlikXjHpXYt116amoxrwaalOVkc5Lr73WlRcD6Q
	 rjX0JCjo81hKkhhQ+HvGPZraJKM44orGzHUvDhb72Z7+f2+y/0myMBNsKRVYOeV1cAueb
	 04ZheuWpFLmXDopJeta2++PySPBX7GjtmuVf2UVYMDPHoY0U4mxrVUYstqUvCjMWjqYas
	 0dNItMEe1Sm2kPca5ijtQwHbqUw2vKlyDX8oSCtwoTSh6dc+1R0mAqKfs0jXGI8xWGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193080;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0bM9R2RK55bRKwNL7tRoHLcnSP0WLeFaaTCwqnieI3I=;
	b=LAFmPKNXaMo9Z2O7uICF7UWuDgd9t/kz6BhRgLDWMLGjnb9mLbFUlN6exEl8XzHRdket
	 oBRFXtnasnAFUymBcbXC+2GkoSDSJRHJmEG/uyZ8DisGweV2u5/Xkn4v6RisXUVJZY8/n
	 raLynZqticvYTJIC3atigo8zhRlignK/d/TA7vu16I889hYQTpC8Tefmi840cWkMvRt9H
	 UnOv/Tu+GLKulis2t5lvXeF2UeytUXKeazlX9P/HsjD0EeGRhUKCzd4GA6CtYCBMQXx2C
	 8R0HjRIweWkw8ZX5x/hIfKsjVyMiRydkMAdlNIezVpm+paT3r1fjqWMOh4jDHYTv8mA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=owlcyberdefense.com;
	spf=pass smtp.mailfrom=owlcyberdefense.com;
	dkim=pass header.d=owlcyberdefense.com header.i=@owlcyberdefense.com header.a=rsa-sha256 header.s=selector2 header.b=AwbUEiIz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=23.103.208.74
Received: from USG02-BN3-obe.outbound.protection.office365.us (mail-bn3usg02on0074.outbound.protection.office365.us [23.103.208.74])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF6606A31A
	for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 13:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2DF6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlcyberdefense.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlcyberdefense.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=owlcyberdefense.com header.i=@owlcyberdefense.com header.a=rsa-sha256 header.s=selector2 header.b=AwbUEiIz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=gDVfQbodeRE44VgqJbX+6DVgXZLsmZgJDfC3OYf6+Ubc4ZlEVTIBk/8wFWn4hk5lbphqz8Ay6sDUmEItJmi5M5bwmSv9jo1AIuj1sza5jJ1WQKZbJX0jjAeptPERqk20Fcrcoc44sWyFYM0/tQ4NlHnaPFC3wsEGdYaGv15KVgASkfQXI0jPoYjGje9O3vffFRS+B3JkC3XtJURdz3uTbFB17i+nmpHZ+9djI/c3LtpJxDncfsQKLQdDIq5YtHdDaoWk6ZzhF2ZmvA3gkBzx3oPkHXxHWdOry0sgeUvbpqVWmH25H/JDK2u8AE4bkkX/jmyW2NKzeLVMsKK7mLOy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bM9R2RK55bRKwNL7tRoHLcnSP0WLeFaaTCwqnieI3I=;
 b=dFEoR19bNaX4wzE27euNrcJn0xqXS1AIq/HLEfP08eI1Hm2lfD1oHJGMRcrz4ztcXpPHjL+rAJ+/0coAsdDaHw6xiSMBNQlBEJqSAWI9NwFpXknHEOjOtyKNkdHbRltxCsoCtaUnTMarpLxbU3VZod/Nb2JdKb0znW/ijqwKvH8cBWexrSrk/R+q4EO6jceCUCyYeRhcZOJEnd4Jk8a/nsM0/6wa0x/HrrD64PT2BDiO1Zza9kom22O3H9+lLyor57fB3cqTz3CDLFIUm4HBY0aJMwl5vbRgwNirrKpheqngr3Xsmp9yKn++Oz8NIXUg8gzZMegXPg8Rw87S1DnJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=owlcyberdefense.com; dmarc=pass action=none
 header.from=owlcyberdefense.com; dkim=pass header.d=owlcyberdefense.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlcyberdefense.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bM9R2RK55bRKwNL7tRoHLcnSP0WLeFaaTCwqnieI3I=;
 b=AwbUEiIzz+82+6A6W5piaUclKReW+se6s5G1zQ1mkA0ILz4UUkL/Q0TjfCKYotO/JOa1pzfrDdSvt9/0cbFe2VYJ3gvds5JDnW04ZbFWgVrxF89xZY0sN+QAYcwKWKDJfdY3ysALT6kHx+8uEpZ27ruF57Bpyk2ct+rwoTa6lG+J+cOEkD1YDU/Wk3If8S4W1wWb/7O9n1SECwfvJWNXwaObC7bJ4APeNqKgzvAU53QJh2yWAxmYmf5mxLdBGBcQjVI+X6QUkrkP9OqJ8nf/JJzhruVomecpeRmkTqyjaZWh+krg61m9Gra/t06JQZaNjIZ6/m6XOWmc9h2IeoBieg==
Received: from SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:195::18)
 by PH1P110MB1202.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 13:11:11 +0000
Received: from SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM
 ([fe80::1bbe:c51b:38ca:2a40]) by SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM
 ([fe80::1bbe:c51b:38ca:2a40%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 13:11:11 +0000
From: "Sloane, Brandon" <bsloane@owlcyberdefense.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
CC: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH] libselinux: Allow unknown permissions in permissive mode
Thread-Topic: [PATCH] libselinux: Allow unknown permissions in permissive mode
Thread-Index: Ad1lcGBM37W2q52QQMuz9tEkixFn5QAFgiOAAFXBvNA=
Date: Wed, 28 Oct 2026 13:11:11 +0000
Message-ID:
 <SA1P110MB1661894742797CD6BE2618ACAC6FA@SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM>
References:
 <SA1P110MB166157581CF3D150601ED288AC61A@SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM>
 <CAEjxPJ56sJtPYT7nptEcMTP3HKh_dfyMOdfGQnxsQn3uaWZn8g@mail.gmail.com>
In-Reply-To:
 <CAEjxPJ56sJtPYT7nptEcMTP3HKh_dfyMOdfGQnxsQn3uaWZn8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=owlcyberdefense.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P110MB1661:EE_|PH1P110MB1202:EE_
x-ms-office365-filtering-correlation-id: 6a73d2b9-86e3-44b2-8b8d-08df34f4effd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|10070799003|1800799024|41320700013|261026135527099003|261026140227099003|261026130827099003|38070700021|5023799004|4143699003|56012099006|261026121527099003|261021135927099003|261022105027099003|261021130227099003|261021123027099003|261021121427099003|261022113327099003|261009223027099003|261021133027099003|261022075727099003|261022115727099003|10067099003|55112099003|22082099003|18002099003|4133799003|6133799003|18092099006;
x-microsoft-antispam-message-info:
 /ieH1JbmSIWoqJWLllZWVfsnAG3JLdJpgJqWgstXNgIiXge2IB2kDEhs4IPuEauAjYv4qEZAlysjqS32ccC5qcmh7hNqEnloftpJ+gZc8I7CtZxoEmcN/HZTVz3ttagFOaM/WfIToSbHDHwMm5w0rFodhtu8mQL3mrchGrWMPdWg6J35HckDDKCMDcMAz4SD1jd0/3O5Q8Y885pjvCAcTq+uPMcnX9SComeZWGibqX+HgA7WlaLgM20Ljs57h/u1b+LQ3pVsMICTBYB50QFTAneUzQFqVXcqRSOYH+1LB2Ixo+cxMNuXj0zn12jNP3ImB1V8nE3kpblLlJ14Jw6jTnRwPFWMrFf1Txjin8s2+x/KI4bUbnrbciW3rKfrIWkGntdfxuRCprDLCx40AS1nnekqT1dhw6215XI8OIzLDA/ZUr9vhEOObN7FHHHSHbQe0V87Ga2mDjwepugjiDdAjxDCmeK94Ib95N8883jqfMSBi5Yh2JfwKGa0LWAiFolgoAy97IiUdCqKYJXUs4NP1veE9JndIj9Iu70s6OgM2zD9sf+zV9V5hdAAbFpWA3raG8ePJy77uVlzZIJddK/+mNoIu8vJw/r2aysbc58LH20nPoxXYAvx6qLT4LdfCXD9ta95DJx/EE7owme0d+2JJSIievgQ4TGVmVanKs+OLeS5v84aZzCf4WhovPQe3s2W2hF+KTKzpeZ+sSLEhcwjDTrjmX4rYl8nE6pdqD6OAfE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(41320700013)(261026135527099003)(261026140227099003)(261026130827099003)(38070700021)(5023799004)(4143699003)(56012099006)(261026121527099003)(261021135927099003)(261022105027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261022113327099003)(261009223027099003)(261021133027099003)(261022075727099003)(261022115727099003)(10067099003)(55112099003)(22082099003)(18002099003)(4133799003)(6133799003)(18092099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjBaaDJTMmk0MHFicnJyb2RwdzNTZTVaZ3U5K3NveWZGaURUYzdzdzJ0Mk4w?=
 =?utf-8?B?L1RsNjc3NEo2Q2lxNlZVbk1UdURCeFRCVHFOTmx5bWlrRzM2K3ZOd2NKRlNL?=
 =?utf-8?B?VlJPWnI5WkM2YUJRaXNRVmtKeUhzdjVtTFpJOXhwYzZleDVPRm5JNVpwU2xB?=
 =?utf-8?B?R0pWaEt4MlVsWGU2Q0dQRFdiU2cyMGxqc3FnRlFRUUo2TCtHUmRzVWp4bkJF?=
 =?utf-8?B?Y0xtNHJrdlFDWWwxU2swSTVaNVNCSFYwWmE3TEkxQm9WVkFhM0g3YXJ3MUkv?=
 =?utf-8?B?SCsxNEtueWI0WVFtSnBNa2orSk1sRjJLTjdud1JEZmp4REc0Z2dFeSttVHds?=
 =?utf-8?B?TW1qKzN1a2VUeGJQN3ZTbi8wYW9uMndpY0xIQkFqRTgxcmpTZUpaR3k3TmE2?=
 =?utf-8?B?QVBaalFwR3BZTEtmR01ZalU0Z2J3OEZ6K1d1cFU3NVJsZlZPbFhlbmRwRXZ4?=
 =?utf-8?B?aWprb1VaWkVZS1lPV0NjM2pkWEFXc21aMVVJU2U5S1ZGUlFlUEloNld0UTIy?=
 =?utf-8?B?ZlpEdE0wMkYrMHBXNDZHRGhGV28zU3MyWGxkd3VwUzliaDhnSXltVVJBWDJT?=
 =?utf-8?B?ditmV2JBdGtvM0FWakpicDJQMHMzeERtZzBOWDQ0N2ZYcUJKTzFrWlZiVkg0?=
 =?utf-8?B?ZWo5QUJLSjFWU3pRU0I5T1lpdmtNQnhERG0xNllVQ1RmcjA4VGNNQnBqTXhL?=
 =?utf-8?B?enBMUEx6OXdtRW10bmxMVFlFMzdYWHdXOHU0QmJtWTh3ZkJiMWVDSjU1Tnds?=
 =?utf-8?B?MHFRODlNL2RlNStDSXZrMWJzeHN2a0FmUWxZMDRjT3N1MVE1WitRZ0VoRHQw?=
 =?utf-8?B?bkd4VmNxbENRZmRITWFKaEJpb0JGbVBlVGttQUxsRmw5WXhtVnBSa0ppa2Mr?=
 =?utf-8?B?Tm9qVGxrd0lGbzVsbk1vUWpFOU1URXBaYUlJOFVaVDZUc1dmUk82TExxYzJE?=
 =?utf-8?B?ZEhicHZDRzFVVmJFK1gvWjB1djhHenRVVUxiYndJb3g1SzNFNnp4SjZhQ2dB?=
 =?utf-8?B?Mmora3lKZWR6S09ROHdiQlZpU1ZqMFZaVzJVeE1nUC9oWWpZRXpGWlVnbmlk?=
 =?utf-8?B?eVNzM0VEY1QwTnJVNkxkeksrYXNmb0tORXd5dzFpYWQySjd1dS9WNG9Pbmdm?=
 =?utf-8?B?c1dIRUM0aGd5THZMMzhpQU5LT3JmcFp5R0JvdHlqbWdEZnFNcnJhK3F5Y1Fz?=
 =?utf-8?B?YkxJaUJWVmlNOHh0RHFqdGNEbUVYUmNsTjQvb29lVnhzT1NwbnBQU0lXS0FP?=
 =?utf-8?B?VlBRbVZJUlMzZUZ1dlU2d1l4eGhhNURVdFdxYnVXRUVhQmVsNmNaU3hGSDhK?=
 =?utf-8?B?MTk5U2VsUm1KUGZoMnBPVHNaSkZtNjQ0TGhNek1sbVQ1ZFpQS2VkMTJDbWRw?=
 =?utf-8?B?b1pwdU1IbnZGUnZGalduK2l3QU5JSndyVmMyUkphK2FtSHNiZnpLVG0xNGZJ?=
 =?utf-8?B?dXNvTzU3dDM3OWhUNDFvS0E0MVFPemFkRUN0NDYweDJ5OXVNVEE5clpiYmEw?=
 =?utf-8?B?blNqRkdsMUt5QklxVi96ZFZIdFA3clg0REdSRHQ1VkpPQ3BoclNsWm1aWFli?=
 =?utf-8?B?bS8valExRUM5UmxTUStnYy9MbkUvMDF4ZmE1RUV4MUFyQlpvdnNwRm1Qc3lE?=
 =?utf-8?B?b09kWUNvMUNTWUo1MTVseW5jd2ZETDFqNmNnNlRaUTNiaDdZMnNxNzc2Nm9m?=
 =?utf-8?B?cmNkbks1VFVWKzZZdTRNQmRkdlVUWHlVTVltVGxIOUhTZXg0S2c5M0ZuL2ty?=
 =?utf-8?B?c1RXNGZQM2M0RFlFd2dOWWJ0d0sxMjN3b0ZDNkJwdm9sY2pRYld0TWxuUDZq?=
 =?utf-8?B?YnliVjYyU1llYmlEcDBSVkI4clNKcXVMZUVLYjNVc3RTdXB4QUNjOXVJQzFa?=
 =?utf-8?B?bEFJR25sTHY3WXdoRkFWNXpCRkJRWXgyanhzdzlLQWMzbzRJRkxsM2F4THJy?=
 =?utf-8?B?UE5kMFNTN29iL3Z2RkVqNmNEMGRUZldsUk5IS2JNNGdsUk16ZndRNTRlWVNE?=
 =?utf-8?B?OVZVd0RBV3RBdW5YTFg1NkVUdXZrWDJLN0xzdWRJcnJrZ0FWbmxVZ2xHeUJl?=
 =?utf-8?B?a0lTZ2t0eGFKd1dHQnBiUU1oWFlpekUyY1B4bndGamM2Y1lJQ2RvY0RNUTN4?=
 =?utf-8?B?UEc2U3NVRlh1Um9GaXg2VkVucFB5RHpBYXp4WHZRUzBHTWxzS0YwN2NMcFJp?=
 =?utf-8?B?SDU0b1NmTVczOGZweGRuaU5nMExtZmtsUFRzcGRZbWs0ajYrMHlkcGNXQ0pr?=
 =?utf-8?B?TlNZcjlHMDBlL0ZjQ2U0Y3daMWNOVUNuNjUxOS95NjR2Q1VtQXRhMHlpYnE0?=
 =?utf-8?B?OUhVaTBFVzVRNGh5OFJMdUh6OGVlVmJ1UmVsYjMzMk52N0lxYXBoZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: owlcyberdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a73d2b9-86e3-44b2-8b8d-08df34f4effd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 13:11:11.2912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0c7a5d8a-53f7-44d2-b6c9-63bab40ba995
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1202

VGhhbmtzIGZvciBsb29raW5nIGF0IHRoaXMuIEknbSBoYXZpbmcgc29tZSB0cm91YmxlIGdldHRp
bmcgb3VyIGNvcnBvcmF0ZSBlbWFpbCBzZXJ2ZXIgdG8gcGxheSBuaWNlbHkgd2l0aCBnaXQgc2Vu
ZC1lbWFpbC4gSSdsbCBzZW5kIGEgcmV2aXNlZCBwYXRjaCBvbmNlIHdlIHdvcmsgdGhhdCBvdXQu
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBTbWFsbGV5
IDxzdGVwaGVuLnNtYWxsZXkud29ya0BnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2Jl
ciAyNiwgMjAyNiA0OjEzIFBNDQo+IFRvOiBTbG9hbmUsIEJyYW5kb24gPGJzbG9hbmVAb3dsY3li
ZXJkZWZlbnNlLmNvbT4NCj4gQ2M6IHNlbGludXhAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGxpYnNlbGludXg6IEFsbG93IHVua25vd24gcGVybWlzc2lvbnMgaW4gcGVy
bWlzc2l2ZQ0KPiBtb2RlDQo+IA0KPiBPbiBNb24sIE9jdCAyNiwgMjAyNiBhdCAxOjM34oCvUE0g
U2xvYW5lLCBCcmFuZG9uDQo+IDxic2xvYW5lQG93bGN5YmVyZGVmZW5zZS5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gSW4gc2VsaW51eF9jaGVja19hY2Nlc3MsIHdlIGZpcnN0IGNoZWNrIHNlY3VyaXR5
X2RlbnlfdW5rbm93biwgYW5kDQo+ID4gYWxsb3cgdW5rbm93biBwZXJtaXNzaW9ucyBpZiB0aGF0
IGlzIG5vdCBzZXQuIElmIHRoZSBwZXJtaXNzaW9uIGlzDQo+ID4ga25vd24sIHdlIHByb2NlZWQg
dG8gaW52b2tlIGF2Y19oYXNfcGVybSwgd2hpY2ggaGFuZGxlcyBwZXJtaXNzaXZlDQo+IG1vZGUu
DQo+ID4NCj4gPiBUaGUgYWJvdmUgbGVhdmVzIGEgZ2FwIHdoZW4gc2VjdXJpdHlfZGVueV91bmtu
b3duIGlzIHNldCBhbmQgdGhlDQo+ID4gc3lzdGVtIGlzIGluIHBlcm1pc3NpdmUgbW9kZS4gVW5k
ZXIgc3VjaCBhIGNvbmZpZ3VyYXRpb24sDQo+ID4gc2VsaW51eF9jaGVja19hY2Nlc3Mgd291bGQg
ZmFpbCBvbiB1bmtub3duIHBlcm1pc3Npb25zIHByaW9yIHRvDQo+ID4gaW52b2tpbmcgYXZjX2hh
c19wZXJtLiBUaGlzIGNvbW1pdCB1cGRhdGVzIHRoYXQgYmVoYXZpb3VyIHNvIHRoYXQNCj4gPiBz
ZWxpbnV4X2NoZWNrX2FjY2VzcyB0cmVhdHMgc2VjdXJpdHlfZGVueV91bmtub3duIGFzIHVuc2V0
IHdoZW4gaW4NCj4gcGVybWlzc2l2ZSBtb2RlLg0KPiA+DQo+ID4gVGhpcyBuZXcgYmVoYXZpb3Vy
IGlzIGNvbnNpc3RlbnQgd2l0aCB0aGUgTGludXgga2VybmVsJ3MgYmVoYXZpb3VyLA0KPiA+IHdo
aWNoIGFsbG93cyBhY2Nlc3MgaW4gcGVybWlzc2l2ZSBtb2RlIGZvciB1bmtub3duIHBlcm1pc3Np
b25zLCBldmVuDQo+ID4gd2hlbiBkZW55X3Vua25vd24gaXMgc2V0Lg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQnJhbmRvbiBTbG9hbmUgPGJzbG9hbmVAb3dsY3liZXJkZWZlbnNlLmNvbT4NCj4g
DQo+IFlvdXIgcGF0Y2ggd2FzIGNvcnJ1cHRlZDsgcGxlYXNlIHN1Ym1pdCB1c2luZyBnaXQgc2Vu
ZC1lbWFpbCwgc2VlDQo+IGh0dHBzOi8vdXNnMDIuc2FmZWxpbmtzLnByb3RlY3Rpb24ub2ZmaWNl
MzY1LnVzLz91cmw9aHR0cHMlM0ElMkYlMkZnaXRodQ0KPiBiLmNvbSUyRlNFTGludXhQcm9qZWN0
JTJGc2VsaW51eCUyRndpa2klMkZDb250cmlidXRpbmcmZGF0YT0wNSU3QzANCj4gMiU3Q2JzbG9h
bmUlNDBvd2xjeWJlcmRlZmVuc2UuY29tJTdDYTdlY2MzMzRhODRiNGZlOTA3ZGYwOGRmMzM5DQo+
IGQ5MjFhJTdDMGM3YTVkOGE1M2Y3NDRkMmI2Yzk2M2JhYjQwYmE5OTUlN0MwJTdDMCU3QzYzOTI4
NjQNCj4gMjQwMDM3NTM3ODQlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0dr
aU9uUnlkVw0KPiBVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9p
VFdGcGJDSXNJbGRVSWpveWZRJTNEDQo+ICUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9ajdmaEF3dzRm
JTJGUTRPT1M2dkszVW92N05RVWtveG04DQo+IG9Xd0Fpd1dWZ1duSSUzRCZyZXNlcnZlZD0wLg0K
PiBBbHNvLCBzZWUgYmVsb3cuDQo+IA0KPiA+IC0tLQ0KPiA+ICBsaWJzZWxpbnV4L3NyYy9jaGVj
a0FjY2Vzcy5jIHwgNyArKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbGlic2VsaW51eC9zcmMv
Y2hlY2tBY2Nlc3MuYw0KPiA+IGIvbGlic2VsaW51eC9zcmMvY2hlY2tBY2Nlc3MuYyBpbmRleCAz
Y2RkMjQxMy4uMThlNGFiZGEgMTAwNjQ0DQo+ID4gLS0tIGEvbGlic2VsaW51eC9zcmMvY2hlY2tB
Y2Nlc3MuYw0KPiA+ICsrKyBiL2xpYnNlbGludXgvc3JjL2NoZWNrQWNjZXNzLmMNCj4gPiBAQCAt
MjYsNiArMjYsNyBAQCBpbnQgc2VsaW51eF9jaGVja19hY2Nlc3MoY29uc3QgY2hhciAqc2Nvbiwg
Y29uc3QNCj4gPiBjaGFyICp0Y29uLCBjb25zdCBjaGFyICpjbGFzcywNCj4gPiAgICAgICAgIHNl
Y3VyaXR5X2lkX3QgdGNvbl9pZDsNCj4gPiAgICAgICAgIHNlY3VyaXR5X2NsYXNzX3Qgc2NsYXNz
Ow0KPiA+ICAgICAgICAgYWNjZXNzX3ZlY3Rvcl90IGF2Ow0KPiA+ICsgICAgICAgYm9vbCBhbGxv
d191bmtub3duOw0KPiANCj4gSWYgeW91IGFyZSBnb2luZyB0byB1c2UgYSBib29sIHZhcmlhYmxl
LCB5b3UgbmVlZCB0byBhZGQgI2luY2x1ZGUgPHN0ZGJvb2wuaD4NCj4gdG8gdGhpcyBmaWxlIGFz
IHdlbGwuDQo+IA0KPiA+DQo+ID4gICAgICAgICBfX3NlbGludXhfb25jZShvbmNlLCBhdmNfaW5p
dF9vbmNlKTsNCj4gPg0KPiA+IEBAIC00NywxMSArNDgsMTMgQEAgaW50IHNlbGludXhfY2hlY2tf
YWNjZXNzKGNvbnN0IGNoYXIgKnNjb24sIGNvbnN0DQo+ID4gY2hhciAqdGNvbiwgY29uc3QgY2hh
ciAqY2xhc3MsDQo+ID4NCj4gPiAgICAgICAgICh2b2lkKXNlbGludXhfc3RhdHVzX3VwZGF0ZWQo
KTsNCj4gPg0KPiA+ICsgICAgICAgYWxsb3dfdW5rbm93biA9ICFzZWN1cml0eV9kZW55X3Vua25v
d24oKSB8fA0KPiA+ICFzZWN1cml0eV9nZXRlbmZvcmNlKCk7DQo+IA0KPiBUaGlzIGlzIGEgZmFz
dCBwYXRoIHJlZ3Jlc3Npb247IHdlIHN3aXRjaGVkIG92ZXIgdG8gdXNpbmcgdGhlIFNFTGludXgg
c3RhdHVzDQo+IHBhZ2UgdG8gYXZvaWQgcmVxdWlyaW5nIGV4dHJhIHN5c2NhbGxzIHRvIGNoZWNr
IHN1Y2ggdGhpbmdzLg0KPiBVc2UgdGhlIHN0YXR1cyBwYWdlIGludGVyZmFjZXMgaW5zdGVhZC4N
Cj4gDQo+ID4gKw0KPiA+ICAgICAgICAgc2NsYXNzID0gc3RyaW5nX3RvX3NlY3VyaXR5X2NsYXNz
KGNsYXNzKTsNCj4gPiAgICAgICAgIGlmIChzY2xhc3MgPT0gMCkgew0KPiA+ICAgICAgICAgICAg
ICAgICByYyA9IGVycm5vOw0KPiA+ICAgICAgICAgICAgICAgICBhdmNfbG9nKFNFTElOVVhfRVJS
T1IsICJVbmtub3duIGNsYXNzICVzIiwgY2xhc3MpOw0KPiA+IC0gICAgICAgICAgICAgICBpZiAo
c2VjdXJpdHlfZGVueV91bmtub3duKCkgPT0gMCkNCj4gPiArICAgICAgICAgICAgICAgaWYgKGFs
bG93X3Vua25vd24pDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IA0K
PiBUaGlzIGNyZWF0ZSBhIG1pc21hdGNoIHdoZW4gYSBjYWxsZXIgc3BlY2lmaWVkIEFWQ19PUFRf
U0VURU5GT1JDRSB1cG9uDQo+IGF2Y19vcGVuKDMpOyBpbiB0aGF0IGNhc2UgdGhlIGNhbGxlcnMg
d2FudHMgdG8gaWdub3JlIHN5c3RlbSBlbmZvcmNpbmcgbW9kZS4NCg==
