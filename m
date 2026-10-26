Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=23.103.209.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793036133;
	b=LcGzZMlVU6IoanJHW+kXqEimf6LX86rTw2KH8m9hzksVChzGm1d4Fksvqf/ok28p21El
	 0KmUfsl7dAdSA1kYB7cegeImDjcePlw0ZqkIljP4Bny4m+wCRKJf5koi2nemIJ773H6sk
	 EBzfjDo1astT12HAWW52ektRwEDS1panKkB//2X/ynZdHTn8FwRp8maN559Tzws0V2AZH
	 B6/cej1Np2Gy6E40IAyJofNw3ujIKyBS72zpN2g21+cywu3obmxXtznfdeRhVjetHf1rU
	 w/1+j1xx2TdXcmrOguW20cMIS+bexzZZUL/BFWVluK07vskw/nZHYFJN2uJnvLfz60A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036133;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=F6pS3Cr4UarszYyXSyIm68SCDn803WoNrv0MDBtbLPE=;
	b=pFUbQu6TwjRHeVwLh3y4JWftnqmzv9eMzDQ0KWeETqppJSosarfNokQ3A6uAuFEqxneF
	 JUuT9/JytxgPGZ706yvsv97hAaRs5RDtHKHYtFLymq5cZqvZOO6HJc/O2q9v7u/2+0HNf
	 wNP/2yvKroEGr40K4hnkC2buSZdyJ+nRd+URNgK2bVQqMX7e4b6Xt97RTwHfgdeN8WE1u
	 onjJxbb1ICyaRbT6rU0SLm//YJFz/NnXVtcyMkb2fusSkEzS/p3TXTOdOISmYcl9Puq3E
	 pUPQt4zd4NYrX0lWLH9frUaTypnDlG+VE5FTwR8ygJoKkTfrKhgNoGN9ZtggxKC9cew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=owlcyberdefense.com;
	spf=pass smtp.mailfrom=owlcyberdefense.com;
	dkim=pass header.d=owlcyberdefense.com header.i=@owlcyberdefense.com header.a=rsa-sha256 header.s=selector2 header.b=KkJfxbw9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=23.103.209.41
Received: from USG02-CY1-obe.outbound.protection.office365.us (mail-cy1usg02on0041.outbound.protection.office365.us [23.103.209.41])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF03606A31A
	for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 17:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDF03606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlcyberdefense.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlcyberdefense.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=owlcyberdefense.com header.i=@owlcyberdefense.com header.a=rsa-sha256 header.s=selector2 header.b=KkJfxbw9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=mk5fSIiuS0/1ZhJn2UkppGsDbRcuxG1GzQQSOxm2N173NLS5W5+XvNTLJ2G7VdkG+kS86pRHSyFfnKnIeBjTcmd7VWafHUFCCs0ZDsnUAa9CEHf4wvj9azvHxf8VJZ6ffCUPYT6zPGVGq9Mr1QdzDL/bTuPNf6M+5ub57HP5ZGF1Z1Sp9Suwz+UOulF0Bf59z4MwnwC0xXUzl1MTev6bRwtXstX1wy4uRD6vvwo4FgibuX7J24LRgstP+br6JLzfIkExK7PTwqlEXzjL+DR7RZn5jJV2gh6Swc/T6rM8CUFhqaW1CJwbfzw8naMtPmCTrHbr+wgkO2d35hmDENxhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6pS3Cr4UarszYyXSyIm68SCDn803WoNrv0MDBtbLPE=;
 b=dzXr/ZifOcJaD0wFwO33yDT0U1JxzW6wyDZMgwD7dh96hHMu/wkT3TTOvHLpgzKMbMmL0UrTgioYBmp9ZJtR24Ljo0E2VkkqVJqW2Vzt1Ekn4izqH8HvfHbF0LNFIePo2pWkiqkCt4P6ROwcv+I+HT5AD5DtTKkQMTGsN6iPHAwnC1ty4t3C2ZzJbB06a36u2ayaGOFYbp6wGzSq6adYVpt6JyrIWeREr9ZTSqvg8mkX9GQMnk73trDas38o/TMf04O0CQQJ5Hy8aFMZSq29S9udt1Zy3fA0XduMjBE8XmU9LwZOYByJawYfDd2pRQJv/IWlOQWVxleza76iLxy3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=owlcyberdefense.com; dmarc=pass action=none
 header.from=owlcyberdefense.com; dkim=pass header.d=owlcyberdefense.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlcyberdefense.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6pS3Cr4UarszYyXSyIm68SCDn803WoNrv0MDBtbLPE=;
 b=KkJfxbw9ZA1skBShOaWh3lSRHdwtOTupHf2VmQzPW/a7w0PSY5FKaEHFceyg8Rp874Nj48fiFlSiMzxUSeUMVIqshYxw9pkuETMt5//UJLBZEpU7SqAWJ0LIYlYn8gQE506HuIQzhKfaxS80P6tDUgZkbzV9bDbhLUW5KLYU35UPjMO7PL30yjR13fkvDSyvPCh4V6orHP6w/ElsNHg6xfRxMIj+KcfPZsvxglKNnetMnAWYe5nFMAAndM2DklB7LbAc+8YBuNte6JgPipGw/Qqgrntkg6SEZy34U9Oh/B7pT8c4gyV9ElMlka5ssJsvevlf9gLw627DnzGqViS6KQ==
Received: from SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:195::18)
 by PH3P110MB1988.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 17:35:24 +0000
Received: from SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM
 ([fe80::1bbe:c51b:38ca:2a40]) by SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM
 ([fe80::1bbe:c51b:38ca:2a40%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 17:35:24 +0000
From: "Sloane, Brandon" <bsloane@owlcyberdefense.com>
To: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: [PATCH] libselinux: Allow unknown permissions in permissive mode
Thread-Topic: [PATCH] libselinux: Allow unknown permissions in permissive mode
Thread-Index: Ad1lcGBM37W2q52QQMuz9tEkixFn5Q==
Date: Mon, 26 Oct 2026 17:35:24 +0000
Message-ID:
 <SA1P110MB166157581CF3D150601ED288AC61A@SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=owlcyberdefense.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P110MB1661:EE_|PH3P110MB1988:EE_
x-ms-office365-filtering-correlation-id: f5b39d44-a2bb-48d0-6c41-08df33878431
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|23010399003|41320700013|366016|261026140227099003|38070700021|5023799004|56012099006|261026121527099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|10067099003|55112099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 0WHiN4brHSGdzzKktsqjz3YMnOmPyhkqLvG9TCThCTc/xly2iN9IxDgHA9pYTttuFyqJx8HqLAck0RbpQ4ndPgoUGYYEjWTDVzkbjNN9chsiJeaQOPZ6bz9Mop1JeKPSWE8ulZgOGwiq7VLoWDCoTGrzfg7UUE82guvUHGbe35p4ohycmWQTTyPq1oplq9njmQUT3T1tkbgiO+94QssT6nWdcUcvM5FdAn4PyChjAk064ncDKe2jexOzAjeZl8GWrPaqhqJw4gXatrGzOxE8iqrMfTSCgZA/AVKHhDbKGYcCo2RrRzy7nO3NgDcfGm1r4E28z+0D4dmWC0kUf4gObXTX9sXRh3SQdHbIYfu/APYxxovlYVebKeGuKKdXEANaI+dh/YLNVvjavSsNu6sjyGsh5wbAI0G7/GdHoidet2IasSG91LmjDzxsgBei6hJfJB7rGgPYdM157hii+cZFI3/opCDrNFIpYBkizSQpBzmeW8EqhjVFwXiLeQxEitFmIvOv7vy7/pAd4hjEWQY6GT92PzvafgmGETYgCbezz2Vl9szmGoHN4dojCrPuPo6Bk8Rx2PEUZ37GLTGAQ9pS9p69fKDzK1s0TdXo1FzErlTakae9S5NMiaxn9a3bDN5ngZIAglcdw5EGuJ1nC/JvO5dslmmIWGNQnEq1nNDDQir7zmnqceOMuYVbyqsRT4z26b4lXwHWJkalCO2MLEjWOmyIMXj3v6PpX/Wuy1XU6Og=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P110MB1661.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(23010399003)(41320700013)(366016)(261026140227099003)(38070700021)(5023799004)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MU26D6SSJjZm8PG4JuZQ2R6Xs9t9JlahGvGoV/BpDbTsAA8nBg51kYAQH33P?=
 =?us-ascii?Q?cFrI33NFG8FSsV0lalFCQSSffB5oykM3dn4BP2FYp1VDoR/xUf3Drf1U8TVs?=
 =?us-ascii?Q?UlrZ8WlKzXo0r9vTtQ3IkwxR1l9aL7594KVd58wNXzX+Hbh2QyWpjRYP815j?=
 =?us-ascii?Q?6bij5PF2zzSUFZ7pnXvyrHVCj5rWFJEVm6oepANA5d7VFBG7G0gH4utA093F?=
 =?us-ascii?Q?l5To1k7uPci8ndVu7DAeP8l92pTUGIDoPqIIVStkc2rwoxJLEl6MClmdk7Yi?=
 =?us-ascii?Q?bRTyzx72mNNIb9BKKPec0orfeRQPCm2AG14+c9xnqiz1G8K8JDXdJS8QjoR1?=
 =?us-ascii?Q?fQXlkcdRH+jFYdVDucgu1mU7ABM1xGzk036LCYiNuI/IfeathjktxHAUO72z?=
 =?us-ascii?Q?Z4pi1hyG0wj2kDGoWalKz896lPrn0iEEvvXyOZxaN5n3FTrvpjxGfabLFuAn?=
 =?us-ascii?Q?noD13I9GpE+m3sI0LmGTiLzZAxh1navLNi7S9OmAdurcTgzdiF36oYNT8Mbh?=
 =?us-ascii?Q?e+2vOVtnBH0vebu/OUwbPCXuNWDHLXLi9nV7kUxCs4/UGyMLjmITEVj9YMPB?=
 =?us-ascii?Q?OSFNF7/UkC/uFU58EZtTM6ScN/8+XiEYYqOZYCO55JbUhh+DXFL19TYtKCR3?=
 =?us-ascii?Q?fnc1emOxa5zjV6JZi+kf45XzZNGvNro+picO27K15GtuEigDhz+fNrenyKrk?=
 =?us-ascii?Q?VYjzOuzIDp1SerFyvhjdaNhY1HgcQQVVU9tDA2ZtA9L1YF7Raoa4NBv55STi?=
 =?us-ascii?Q?BvyHBBnhi9Y3xGnCeqRqZ+wxmWmc6+bFF7UbF2nruG9M2Smnc35o0/uNtFEu?=
 =?us-ascii?Q?isFYvBqqctxcVecualETkhcSMn1a0s/2WY91aMNELlvVSZMQfDdcZ021egL4?=
 =?us-ascii?Q?pt0jZYVwvc3OrbcYEQWGHC8EpEoAzV92249P8tUYIhZ7/s0I21VO8dcBdD8h?=
 =?us-ascii?Q?nqCS4Owo9KDEQ729G7gxzAxc/WHCmIOCWIjxRI1oyZJRpgt5tnj7W8CZn2/n?=
 =?us-ascii?Q?CDdsnrBp3BGf+srvF9H0+zcjb/32aVoz34UPQ2KA3uRuvJcY2bc/skdQuEU+?=
 =?us-ascii?Q?cFSJNIU3uihYULa2Tml9a7AqQXHusi7rwSro+bWhpbBB/2Mcv0Ins6KVOGN9?=
 =?us-ascii?Q?yrIXdyOe5zlM2mw1U06vb4TSv0mje/dMMCVqiBDrW2AlEzsoISg/USa2A2kX?=
 =?us-ascii?Q?sEJL/NFJAM9iutCscTG+d5nUpnBKipooeL/jGk94ra3gBL0jG/8hF2mTrsR3?=
 =?us-ascii?Q?rJGG9vnRsBTv1aTd3HqxptwVFWZHfffNgNUtxG25TYk/Nf/qkTzaQlaPZ6Q8?=
 =?us-ascii?Q?WjALe20AC2E8ttXfc3KmB9TvXj98ieE+3gMDLW8b+7IzfUDZqwRy0CJHJAUe?=
 =?us-ascii?Q?ot+A4M+unsJm+ryDfa3XOTgV6+oyLiGgQ7RxgBmQlFghUy+FJB+eZwy73vVf?=
 =?us-ascii?Q?+hwoF/fEzKNcUAhxzcdQ4NYKqQhv/V0PPeIXuDPBTGaRUKiJtw21H23IzJHl?=
 =?us-ascii?Q?hmeH2M+7k/+LxbypcCg4Ha/HveM3ZfKqJIPBvhYniyAjBL4HzeHYopLEsWLF?=
 =?us-ascii?Q?XMHfza0fi6juWQuyE4QOz/6SI50QPZqUCsr4upzyTj+t3SpYwrL4OPDgc+Cl?=
 =?us-ascii?Q?wMGwRvQiI+syobp31LT7mDTLowr46bhVEs4rKy+zxxmd/Sxhyov/PbdFyQwG?=
 =?us-ascii?Q?2bBAjEpxR9ztB/8n8DXOGy1oboikuz3U93dtSXSyGVtfwPYa0Sz/Jg4w7SdG?=
 =?us-ascii?Q?exNg2TDYbA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b39d44-a2bb-48d0-6c41-08df33878431
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 17:35:24.0868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0c7a5d8a-53f7-44d2-b6c9-63bab40ba995
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3P110MB1988

In selinux_check_access, we first check security_deny_unknown, and allow
unknown permissions if that is not set. If the permission is known, we=20
proceed to invoke avc_has_perm, which handles permissive mode.=20

The above leaves a gap when security_deny_unknown is set and the system
is in permissive mode. Under such a configuration, selinux_check_access=20
would fail on unknown permissions prior to invoking avc_has_perm. This=20
commit updates that behaviour so that selinux_check_access treats=20
security_deny_unknown as unset when in permissive mode.=20

This new behaviour is consistent with the Linux kernel's behaviour,=20
which allows access in permissive mode for unknown permissions, even=20
when deny_unknown is set.=20

Signed-off-by: Brandon Sloane <bsloane@owlcyberdefense.com>=20
---=20
 libselinux/src/checkAccess.c | 7 +++++--=20
 1 file changed, 5 insertions(+), 2 deletions(-)=20

diff --git a/libselinux/src/checkAccess.c
b/libselinux/src/checkAccess.c=20
index 3cdd2413..18e4abda 100644=20
--- a/libselinux/src/checkAccess.c=20
+++ b/libselinux/src/checkAccess.c=20
@@ -26,6 +26,7 @@ int selinux_check_access(const char *scon, const char
*tcon, const char *class,=20
        security_id_t tcon_id;=20
        security_class_t sclass;=20
        access_vector_t av;=20
+       bool allow_unknown;=20
 =20
        __selinux_once(once, avc_init_once);=20
 =20
@@ -47,11 +48,13 @@ int selinux_check_access(const char *scon, const
char *tcon, const char *class,=20
 =20
        (void)selinux_status_updated();=20
 =20
+       allow_unknown =3D !security_deny_unknown() ||
!security_getenforce();=20
+=20
        sclass =3D string_to_security_class(class);=20
        if (sclass =3D=3D 0) {=20
                rc =3D errno;=20
                avc_log(SELINUX_ERROR, "Unknown class %s", class);=20
-               if (security_deny_unknown() =3D=3D 0)=20
+               if (allow_unknown)=20
                        return 0;=20
                errno =3D rc;=20
                return -1;=20
@@ -62,7 +65,7 @@ int selinux_check_access(const char *scon, const char
*tcon, const char *class,=20
                rc =3D errno;=20
                avc_log(SELINUX_ERROR, "Unknown permission %s for class
%s",=20
                        perm, class);=20
-               if (security_deny_unknown() =3D=3D 0)=20
+               if (allow_unknown)=20
                        return 0;=20
                errno =3D rc;=20
                return -1;=20
--=20
2.55.0.windows.5=20

