Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2035.outbound.protection.outlook.com [40.92.19.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DDC81ACA
	for <selinux@vger.kernel.org>; Fri, 12 Sep 2025 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683758; cv=fail; b=R+9ofXsxj/PTe08jlTelrFztrGPkmK6S+9QdrY2pRrd93sTsspBULiQhhcQNSVsHIom6W+5fOv2/XP9pKlbuNdUTsRss77o5XFjvDY7YP3yoABRT5/AXee6D0PlUqaEP1NrrxX2Zw3F7TsMsqOpfp7H2qmOFlkOiYAg5bKB5wG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683758; c=relaxed/simple;
	bh=P6MeCIRpwBubqa7B4mt1u2x4set8j7TRl5V6wMn23q4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XGQ/dCovpv/9IgX9flj0Oe+PdKR0dyWk/qLzJxfwYdVN32w/4DV6XteZaz58YmUpxY/lxxiwW+SqN9k9nDpbMofiX71Ljol6t4yfW28h4BxgoXdf05jY8JPrORm6/bfbrJPGBa2Bz8xzoCf0gyjo2nbT2B5piaSUFmGZTNkrurU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Sj55vkgZ; arc=fail smtp.client-ip=40.92.19.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Sj55vkgZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Foc/KpeUJkemqI2weuM3NIBGWwkTjreAoDbwD2RYMPcBk2xdHwysmdqJ4UiKKr+/IHChBg03h1FzEgevw9j4MCYStKY43RsWmpKX9LXirAguu163Vmz/jVUwGqeBz/B4hgiqInXDpfpYxmSRmZ/HtBsfZjpwDs/NHtuNrPpzZCPACPC5QJ71jpBdz5KYzgufsR1w7+LHhWagU/VLFtT46MObhasVxQlx2tygA/70jAV1VNQ7IQKlbnI2z1kkGPzqlsctuZbX6RI1d+HDbMQv4KfvQLVeMdaW+dZgRqnXaYml+xwVxi2oPyMJxc6G4hcHkkEzv1+0583upGNJAHM/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6MeCIRpwBubqa7B4mt1u2x4set8j7TRl5V6wMn23q4=;
 b=YwOilPmdZ7Yv4JdB+a3w2gXk2G6tOh1bq5I9tXp31ELo4jD1q0widqJntNOq+2pStDUNqhT8x/T2ZcfhcTVQRIkN/sxyTuCWNodl9VBkMvoi73B/35L2pCYVb7Q2jSi4dgCA1NCfKEi3xw0+9mh4C/3iJWw9wUOrK/SpxFRpZcfd2lG1adtYFZ8GjV7356N5leAhjN7A+QxCzDd5N8eX7AOmAHXKbzyrtSCPRRB9rcgE2XNbRhwNLY9/9+oKUe8HLmIUbyEFVbzHnm5UneZiIvrxW4WlMCyYelwflEvgBYCm3lDX4Fewi4LM87cZM7l1CnCE3t0rKrB+3xYUtpRglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6MeCIRpwBubqa7B4mt1u2x4set8j7TRl5V6wMn23q4=;
 b=Sj55vkgZljKzCaGy7XiTsW+wearFjYfWt4q84kYtOubhaEqPBkhJdErBbJqiiHsCJmXg0G+ihLmMwPaHCmvwnw0rJ3HlEZm3KBrm3hzpvCIq4uXk9BYVO+O2SImUlDgMCEvoPyjul/vlWbxntBWE63Duxq1sQHSGTpGMxx9yZfZHhnjt9FAdgx0naIP1mFJqCGPnVd2r6lOZEAiRfEt13IFZwcs/o5CXr33FzwqLo0/ll76THQU71bcTHiEQPnTy7xrw37XCTv/i3xf/63Rt/BOc83Yx+LX3rCK9CarQ+FZV+HJyR8hWv7Cne+HQ4wLqHvQjBhXk24ZhQWZYp92H8A==
Received: from EA2P220MB1457.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:25d::15)
 by PH7P220MB1254.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 13:29:14 +0000
Received: from EA2P220MB1457.NAMP220.PROD.OUTLOOK.COM
 ([fe80::1fda:4fdd:ca02:4a82]) by EA2P220MB1457.NAMP220.PROD.OUTLOOK.COM
 ([fe80::1fda:4fdd:ca02:4a82%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 13:29:14 +0000
From: Caleb Xu <calebcenter@live.com>
To: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
CC: Caleb Xu <calebcenter@live.com>
Subject: [PATCH] libsepol: fix TARGET and LIBSO on Darwin
Thread-Topic: [PATCH] libsepol: fix TARGET and LIBSO on Darwin
Thread-Index: AQHcI+k7zvGlY6hutkSjxr/EKGiPzw==
Date: Fri, 12 Sep 2025 13:29:14 +0000
Message-ID: <20250912132911.63623-1-calebcenter@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.39.5 (Apple Git-154)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EA2P220MB1457:EE_|PH7P220MB1254:EE_
x-ms-office365-filtering-correlation-id: 7114f5f0-cdf2-40c0-cc4b-08ddf2005dd4
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15080799012|8062599012|19110799012|461199028|8060799015|38102599003|52005399003|3412199025|40105399003|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?FW47zvsQLHuPnMMPpiGYBpOHx8NWa7b6lrhcC6nEc1BTxc/CT2pdnn0QRf?=
 =?iso-8859-1?Q?aVQo44fUjoKjvqWZuKxpGNgDyMdbOTx4scYXZKX7qtOaW8H95sZ4WHGev2?=
 =?iso-8859-1?Q?h5AaRcvQTuV7KDkXzCC1Dp4aumQx7ncYafh4JR08Ad91RuUF4w6Ox04GoZ?=
 =?iso-8859-1?Q?1Jy+ikzA7GYSYLa4xLxT0aQX9uAzW2JjOZ3NkHaqFtQeD8YD7j01BMGzCa?=
 =?iso-8859-1?Q?8+zjyzxhWGGwhm1IAx6NmCArjF7zNLdx4T2j0b+KV7cWUqlIKegncUHNm6?=
 =?iso-8859-1?Q?t22eM/xmov5XI022VanugaS70kD9Yy0V3ESFX5MjZj1jJCe/jQBLVW/ynX?=
 =?iso-8859-1?Q?t1hf7ACMSWNZPIiBTwMMw+0vOs6x1FaWI3FCFt1JDfiHd/fRW15mXJpRdz?=
 =?iso-8859-1?Q?CwnD1KMqJBEq4yMZoRYtuCXRaVs7Bb5BnQhJX/WUw0bPO3akYofPXfjSGl?=
 =?iso-8859-1?Q?f/qHwYTRYX8Bz/njDexKGGiX0JvhJP39TuZ+Hdqy/vx2NReAF5TprEFR4p?=
 =?iso-8859-1?Q?TUhvi6ba97L1NX5XQctb843FyajsZCnhLBifKDGRAwvaTKbZFVXy6hGpXT?=
 =?iso-8859-1?Q?TVRt3Fh/VWgapP1yeooIQBLkuJhgY1kb0w8/MLEGDkiS7lXYax11GVboRf?=
 =?iso-8859-1?Q?IwRNClQtyusGuIPiF4TxaHvlg3qEmy8Bp1Tz98Z2H4fX57Cs+zkHw+rrua?=
 =?iso-8859-1?Q?5m1ZOljxAIEcCG4MkziCXmON1m2K1nuaola+estaIeMhabqHmYnhce3lLe?=
 =?iso-8859-1?Q?6C093Uk66PA4O3WXQD9vEvFROXYUVYMe+B3wKyaTm37+nvH+GtyEvfUwng?=
 =?iso-8859-1?Q?HbX/1iLZlnENpL0jetLkNNxlczp267KsXP1aQm7eC65uU/fMIBtIVH5plJ?=
 =?iso-8859-1?Q?TK0m7ODi/qSZb0/sWxuub+2vpoYSELM0ReCfl35FT8gC2eZgpMjivxZFkH?=
 =?iso-8859-1?Q?QWUKZtUWmQKlZxBfMTyQJVAH8vYrCu6S2J23ZFm7TAQEEMhYEbvgpQpbu/?=
 =?iso-8859-1?Q?byoTVG4ccqpdqBflRbxMM+GMGzbJpGYuTC12bPV/dUSOq0OKp5cYk6+zeX?=
 =?iso-8859-1?Q?zj7CZppK5U8/mMzdKL95g9Xp/2W0vcQ3yPb0+EksyA+OwpzVqfjLnG9tKM?=
 =?iso-8859-1?Q?PCj0we4zjQOO1cjcSCXX5KbCCoyXHPHGLjAWS02/hmYVJHqCL8EkG7bwR2?=
 =?iso-8859-1?Q?XgtzBNnFVbnpHelVg02dKe1gqwvcJtWYbj0TXfZ3kbLPkpCqylS76/Wjb0?=
 =?iso-8859-1?Q?0s1QbwIKK/JaMJdrLSpyC4W25YyUyf5tl/Q32creI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?s3RHNKLNa9NLJZk37kLIESbkdQVc8FMw686DWLWryUWSIiMMDFxL78eoH8?=
 =?iso-8859-1?Q?3BTPwESA5NeSxcQ5Ld9/yPjUPuYpisdjgXK88OqVzpd26SKv/186VRekip?=
 =?iso-8859-1?Q?KOANChuLjc/R2uQoTk1ZqVunKkhEIim5oeNJXqW+4T515+a0RTfIsHQaHt?=
 =?iso-8859-1?Q?xkoyLHps5bls3HAq9iJq8+spIeAZOOO6FriTkfjnduayea/spYlYq/voip?=
 =?iso-8859-1?Q?7QdPMxv6tIGcurHvPbVoeZJBlgZw8H1aow94yjGJ8zBT59PHDuSDnG1CyY?=
 =?iso-8859-1?Q?xjrAK8x8bg2saLs+ZmwkXN84lI2BJDw73KRUIGp9W9boN5OFyEIcMZpNEh?=
 =?iso-8859-1?Q?oic2po5Nme8L9ALlkDmOBKjAkmGVOnC2uT5m9/s0iyVBJSvM/xJmdyw6X7?=
 =?iso-8859-1?Q?wFapxigkQtgx0hMGIVCvdVBl66yjebr+/0FVovruort4Q+p0I4ejkIQgFR?=
 =?iso-8859-1?Q?mcXxRNHVZwJ15vipkkLMrxFbJLW9XoaY69HKcGzYrhB4SNx+9c6aiaDMI8?=
 =?iso-8859-1?Q?0ZysQCNtSLbDSaKtyuk0X+ol4MHmEETrRPSfFoigetJzJbAu61++lpxcwi?=
 =?iso-8859-1?Q?3lJO4GfcJrtt71P0phkWl9P6iMHifvS6t8SvAMMqG2eQUh3QWPqKkGoeQJ?=
 =?iso-8859-1?Q?P1o6+PTTDjWnd/tWiorZQwNhz++xSNdkxbV0M+/UZghW6VhsbM2x9K1usC?=
 =?iso-8859-1?Q?nvTXHOeo6JrC4bycJZBHe0ONq2sAaET90UXIRwJYs5sK5OfW3zWp/F+/IB?=
 =?iso-8859-1?Q?ok2+eRDMW8b79uLqNA7JqLo1i6AH4hVM/gSkI1wQmaHfAShAOTya+0jnKd?=
 =?iso-8859-1?Q?vmN3lhTO9UUx4SoiMXi7dN05c00eURRHpB8/SuoX0Mp/IwExJ8XWM+XZkX?=
 =?iso-8859-1?Q?OUgjyMCl7vdLGf+KqeAra0tZdxuIaN2jBwfbYscTol8Fduimoit0rz8Uza?=
 =?iso-8859-1?Q?63/kbDD0wb5UNp3b+avnGdbYANTxB4lOcztk7AmabXVCDEqnN+mddxJy35?=
 =?iso-8859-1?Q?ZAIuohtdRq4cBqBU4lMBYnVowAaw3Wv+rdUHqnveqtxf6RKf1lHWioBnUI?=
 =?iso-8859-1?Q?cClIOI7VaJSdfljPyDHmHjL4zZfihxGJBHBhH/zEY3gM1UV69fZW1/5AAA?=
 =?iso-8859-1?Q?5psldVA2taHjnkZpdfqPvGcmPeTZslyGarz+3rz5SrCwZm2iuRfitQTWWi?=
 =?iso-8859-1?Q?RvsmR/0AO0ioWQxDafHYE4hvQoahJbVNVQ9pIsL3sUIaNSLzJOLxjw7lrL?=
 =?iso-8859-1?Q?NZGtqPINwK8ZO4tr8PpQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-ebba8.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EA2P220MB1457.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7114f5f0-cdf2-40c0-cc4b-08ddf2005dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 13:29:14.4322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P220MB1254

On macOS (Darwin), shared libraries have the extension .dylib and the
soversion is between the basename and the extension, e.g. libfoo.1.2.3.dyli=
b,
which differs from the usual libfoo.so.1.2.3 scheme in Linux.

This change sets the TARGET and LIBSO variables appropriately in the Makefi=
le
for libsepol when building on macOS.

Signed-off-by: Caleb Xu <calebcenter@live.com>
---
 libsepol/src/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index a1aed072..90aed394 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -40,6 +40,8 @@ LD_SONAME_FLAGS=3D-soname,$(LIBSO),--version-script=3D$(L=
IBMAP),-z,defs
 LN=3Dln
 OS :=3D $(shell uname)
 ifeq ($(OS), Darwin)
+TARGET=3Dlibsepol.dylib
+LIBSO=3Dlibsepol.$(LIBVERSION).dylib
 LD_SONAME_FLAGS=3D-install_name,$(LIBSO)
 LDFLAGS +=3D -undefined dynamic_lookup
 LN=3Dgln
--=20
2.39.5 (Apple Git-154)

