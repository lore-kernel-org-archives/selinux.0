Return-Path: <SRS0=Dhgn=D3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB4AC43457
	for <selinux@archiver.kernel.org>; Tue, 20 Oct 2020 12:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AA822265
	for <selinux@archiver.kernel.org>; Tue, 20 Oct 2020 12:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405915AbgJTM1U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Oct 2020 08:27:20 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:38379
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405865AbgJTM1U (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 20 Oct 2020 08:27:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqcgXfER0Z2N46mDGfUwsigm8hJ7aAej0hHC5i53W+mrjKNa6xPv/HxurjJHUWBi5XJavw8dYi+lVZ0LEl3pE0jGN8RLJakcyzV32HT9eI33oO1L/JYbUSEmRDpDQiR+fVtg15mSaLughuwzlD6TKJT5GMoZ4DzzlFyepuaHWgLjynZX5eDcVrfuKTDUHTpSDus2+aXEbQcxISuChoSGA+JjZMc7SDm/nPUBM0whxA/0TS26wc9FJPrs9IQlgQn1ros1cVdaOeT4E/BFKYg5rqLeZ2DqlbC2+GzQFiiO84KLRagUX5k04Z8FNJtog0DBl96/WJxdgOsbzAJ8EXhPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEUa0/aafSNSt9QKEkq+YGu7HkRWl5UdXgL9mfYy3fM=;
 b=DezEhSrxXRLJR40MVmG/f4ci3y3qyrFFLXZaaxSwjE3e/pmgFCEaOgw1lA3C64U89jdgbVBBM444jqhADN7XWWz3IYO0wC2aSTo5z7cfNpzOA/gbdrODd9nlovtHtOVtwmhiC8lKTOdYyoClmgSfk5X/FRL83lzjHC5z7bkt0M050tgraV8LN2Yj23P9wjg+mE0DulG8n15SlVGBdnUclSdnKpWEc09KE2Yh9v35EQVQKwxuU2dVMmSIkpHpbhtiRpdbowdas5KJRRPz6zhsFVGi7wIG6Vn6PkgegqWmal9HR8usgZn1Uo3oXKB9rvtEkumP/x2taKhMsYGtYQHZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEUa0/aafSNSt9QKEkq+YGu7HkRWl5UdXgL9mfYy3fM=;
 b=Drq1tbTIxianXXKC9mdFt4ll/wWpNk+fIQDQGCbTfVqFg18ysOrzCxwW3kgV/7OUH/D8DWjxVh3wC74sSmap0iNyv59Vt1z2I5Hvyd84T0GxMI9x8jjpSMkmg9Rr9ce0H3rLA71YEwkJVopM/p871mJOPSRgOdZxM1LAtwHVhl0iXDrNEHpbRMMXx+fsCLEQT8uTTwRh6ifDTBhCipA6d33gKAOA3yB12uyuMyWTG1zt/zCZVEzgr4Uswzbl5uEWhRXpOHRTOBVof2+DxJ/j9spq4JEknJ6/SHntKLfVg8+Ysi/+GGM3avx9dlJjMxNehAKzcHK+CyV/AN3ugUvMjA==
Received: from VI1PR06MB5519.eurprd06.prod.outlook.com (2603:10a6:803:d5::23)
 by VI1PR06MB3934.eurprd06.prod.outlook.com (2603:10a6:802:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 20 Oct
 2020 12:27:15 +0000
Received: from VI1PR06MB5519.eurprd06.prod.outlook.com
 ([fe80::4847:897d:1b48:f01]) by VI1PR06MB5519.eurprd06.prod.outlook.com
 ([fe80::4847:897d:1b48:f01%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 12:27:15 +0000
From:   =?iso-8859-1?Q?Bj=F6rn_Bidar?= <bjorn.bidar@jolla.com>
To:     SElinux list <selinux@vger.kernel.org>
Subject: [PATCH] libselinux: Add build option to disable X11 backend
Thread-Topic: [PATCH] libselinux: Add build option to disable X11 backend
Thread-Index: AQHWptxXMS9rsPWquEWVgiS/EbRT+A==
Date:   Tue, 20 Oct 2020 12:27:15 +0000
Message-ID: <5825612.FvA7u9GNv5@odin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=jolla.com;
x-originating-ip: [85.76.102.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d44dfc07-25b2-4d36-27cf-08d874f37a84
x-ms-traffictypediagnostic: VI1PR06MB3934:
x-microsoft-antispam-prvs: <VI1PR06MB393493C8CD5AEAA283CCD86AF81F0@VI1PR06MB3934.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BESS4LacMHB3Ty90lxJ03gQQu6NTfDPlbt0m31FUAT+IhkW/y5I2OOkKgVUdx4oCVP6xtIVwbRTtPRldjV0D1Ka61wDuGCeImrdK8GJ7lhHjz/N+Z/7k8lsCj199/jBly3x5C0wODpfzK/mVM35Ju9/+ox7dFcBfcFZpd1flqUH9f87pTmXYXI5/3u+SrdQxPSjegvrxnM8HXAGVvKnORFncWjkVzW0yge7bm3Lf33brb+Rlw1/S950bT3HO8jDXzGXuo2ZxVU1di21Zsts+Qi1yvvpm68KoxrsgYQ6LrRcyvuqG4VkUK0sD+GNWvqCGE2Pr/4Ulv3bQOvj8K6PdUsi/DpbDSbhKZ8CgBGgBXKctELl/GiO2PxPu+v9Zta0V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR06MB5519.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(366004)(6916009)(8676002)(71200400001)(508600001)(86362001)(33716001)(83380400001)(2906002)(186003)(6486002)(66574015)(64756008)(66556008)(26005)(6506007)(5660300002)(66446008)(66946007)(9686003)(91956017)(8936002)(76116006)(6512007)(66476007)(39026012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tdxsO4tKeHXsoifYFUPZF7TpvGpAK4SXnmU3kgjG3toqIYcNx5oqmmMl8rWEYT67LOUnOXFEN7egfLYbfNuH3Uz5ny5LmLqYHntXUvY1gXAIDhsL9wnfVd5vz2gocvM895xQLZ9wCLDxrYeZWCjb6gN9iSI/DSEFzYoU0qPSwzRf4kcyoO/dd3d1jCpH+RQFM4USuKGswJozh+yf780T6lrLJqDDgQFZa8gJUw8Pd9+1yB/ES2MuZivW3P85vBo10Vbz/keDKw3ALbEwsDxzaCYNMc0VYW5oJp6EF0G7puOktI5QgW/tPtbdQMPA+uixFKLmu1u/kRElWyZwb/d+cBWe2G7NvGOuzPL/mr/Epp2+Ly+LBZrC003pUrPcd8KoWKIunPpyfmlVd00ZTa1L/rpovgAH93IxQCUj12ne+7mqygHqDNvVr9ztBk7pzxQ/EVzZyL3fsnK6nQXUK128RW7wZc4UPNk6GJYyXkCaxSX7rBmLL0xxS3KFIVMXA0To1FVF+ZR2F5EoiD4Z7iZOv19WCO7RFZJZe11F8kfMs47rZzOhMzqJjuOfeC0XV/KSvw9r6oplfDb1Brc9JYgBfA0x0BmLCDy3Cb8xWWQP1IafiKSs5e6qOPZWCAoDfNjjrDbd6bwj84vdFtVafbk7Ow==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5000141DBDC7DB479A7F512322691203@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB5519.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44dfc07-25b2-4d36-27cf-08d874f37a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 12:27:15.2802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nZSFplFKBSNfeXwYTkbUgodGxjzrtJu1m8ra4Q8+iqGJTS758+vjzdk5GjqI7cblM9BktytaM8Y2peVlcd/Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB3934
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add build option to libselinux to disable the X11 backend without using =0A=
ANDROID_HOST.=0A=
=0A=
Signed-off-by: Bj=F6rn Bidar <bjorn.bidar@jolla.com>=0A=
---=0A=
 libselinux/Makefile     | 5 ++++-=0A=
 libselinux/src/Makefile | 4 ++++=0A=
 2 files changed, 8 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/libselinux/Makefile b/libselinux/Makefile=0A=
index 6a43b243..cb5872b7 100644=0A=
--- a/libselinux/Makefile=0A=
+++ b/libselinux/Makefile=0A=
@@ -17,7 +17,10 @@ endif=0A=
 ifeq ($(DISABLE_BOOL),y)=0A=
 	DISABLE_FLAGS+=3D -DDISABLE_BOOL=0A=
 endif=0A=
-export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST=0A=
+ifeq ($(DISABLE_X11),y)=0A=
+	DISABLE_FLAGS+=3D -DNO_X_BACKEND=0A=
+endif=0A=
+export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST DISABLE_X11=
=0A=
 =0A=
 USE_PCRE2 ?=3D n=0A=
 ifeq ($(USE_PCRE2),y)=0A=
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile=0A=
index 190016e2..be0b6eec 100644=0A=
--- a/libselinux/src/Makefile=0A=
+++ b/libselinux/src/Makefile=0A=
@@ -126,6 +126,10 @@ DISABLE_FLAGS+=3D -DNO_ANDROID_BACKEND=0A=
 SRCS:=3D $(filter-out label_backends_android.c, $(SRCS))=0A=
 endif=0A=
 =0A=
+ifeq ($(DISABLE_X11),y)=0A=
+SRCS:=3D $(filter-out label_x.c, $(SRCS))=0A=
+endif=0A=
+=0A=
 SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAG=
S)=0A=
 =0A=
 all: $(LIBA) $(LIBSO) $(LIBPC)=0A=
-- =0A=
2.28.0=0A=
=0A=
