Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53362C00A89
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 00:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAAC220719
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 00:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgJaAmd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 20:42:33 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:6819
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725960AbgJaAmd (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 30 Oct 2020 20:42:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dinDV5vkBzgViOVN7JMB/sNWEl3ZFjWLHqprhx81J2f+sk2tV05VEnGSWC9CqbL/JRagAWfRxnHc8TlhNd8l8wX8J54se0qh8ItaIfsBiwYofN3niwdEEO1Vm0nKYcMl2G4kPdnz9aF7Jp21PBb2B/01Q1z5nf1RX2M2VfuGcXGwN+qGE4YSIOHG7+WGq3P4edZ4kYqiVnwrJt9OCfeu2wFU0Pqv/fkMbmIxtLtDTEeC8+dTJDRDfGDrWfcD74VjHk5mC7pSTl2XgftDP+8BXfLYXDIN3vs8b+qZLPZjgju3v+EUKgU5pQAyMvtVH9ZjZ/rsTUGOc4IeAdR46w0H8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThrSpTZImWc979kUm6tnrsG8//mWIywxX9Qfio4CLVk=;
 b=BIIm+NSgvLn2SySp81Kr9nhRlRUsvbefbtMnwurDkdrG4BZ7oTWaRa8opMvpJbUXnZw7Bupw0xiElve4KFEZHlea6XT//TlfyURLDLoaoHKZFVnBeqDN0AlpZZITdjVf3W0ogoD1eG9f0cAZfGWuQeII1X/Xks0NF36JFmC2xyWxbFcxNUI0pNy9PxA0CbF7sZvecdRjVdfe67CznLAV9IRptDBOu4wN/PwKu+6ru+wbP1CJ9H0EllFFMO3hDFb/GLmOr5UFn5Mf4HzAS4oMSIST8wabPaFe0X4ZXHsyArsaBGiOFjcUhHBUZlnqIfgoV7QVNAdtR+wmbfd55BasGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThrSpTZImWc979kUm6tnrsG8//mWIywxX9Qfio4CLVk=;
 b=YDJFHQPOmovhaQBdSAO+yk6lkSxZqTmNMya/i10j2ZvPGvYLEqzunOYQPWiC08Tjwa69EWgvg+7CwUgeR98i9geDeNWoyEaUoyKjJuO860BOQ2P9JBoxeTa2mGAKTjNmZHy0F6Ce8cmfK44fdrwVBndROFZ3sjUMKMCRPnsvXvgzcq8lPmU3FqxBzx4LGlSMylTyN6paZpCJ9KH0TpE/Wmb3m6FiKTYU0EOGQBAZTy/2AHXZykzhg3uykMnHRAkC2lbWR0V0SymGpBTwf5yWQ1Bo5uIrhWxrprr28ShNMC4o5Q5NBYgS/fcx9StcDJ/A1Bpd6lmrI5xrq7woXnGfkg==
Received: from VI1PR06MB5519.eurprd06.prod.outlook.com (2603:10a6:803:d5::23)
 by VI1PR06MB5520.eurprd06.prod.outlook.com (2603:10a6:803:cd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Sat, 31 Oct
 2020 00:42:29 +0000
Received: from VI1PR06MB5519.eurprd06.prod.outlook.com
 ([fe80::4847:897d:1b48:f01]) by VI1PR06MB5519.eurprd06.prod.outlook.com
 ([fe80::4847:897d:1b48:f01%7]) with mapi id 15.20.3477.028; Sat, 31 Oct 2020
 00:42:29 +0000
From:   =?iso-8859-1?Q?Bj=F6rn_Bidar?= <bjorn.bidar@jolla.com>
To:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] libselinux: LABEL_BACKEND_ANDROID add option to enable,
 rebased
Thread-Topic: [PATCH] libselinux: LABEL_BACKEND_ANDROID add option to enable,
 rebased
Thread-Index: AQHWrx62xZkwj+ogT064YYQP3bNnHA==
Date:   Sat, 31 Oct 2020 00:42:29 +0000
Message-ID: <2475881.4AeNWvRDVU@odin>
References: <8651564.oA283WntVp@odin>
In-Reply-To: <8651564.oA283WntVp@odin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=jolla.com;
x-originating-ip: [85.76.102.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bba0bf04-ea48-470d-f850-08d87d35d8a4
x-ms-traffictypediagnostic: VI1PR06MB5520:
x-microsoft-antispam-prvs: <VI1PR06MB5520E669C46341E10AD29A87F8120@VI1PR06MB5520.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Jm+sFpGGQQeL+u1XEIy+k+o4aO4SXoil1cugQ8Jz3yaW9DGTF6QDhJ8x4UUCbMbCHk0hx5kONW0w62zGCGbBcTxVJyr9EkeeYMUJ3J4hSvSdKiVxyjCtut0/qBkGS19wfpgrTq9nJrEzE0yYUxpZWGZtarmXRevb3WKU4/x5aHN17a2gzKfgM5IxVDq35nHHAU+TKqvQ9wqGAn3zofzzPeMj0UnwecUVfM/zA24rw8Thb15nl7R2zRvNef11vFOzbYZzrpsbgvjG3TqdHIISX/uNn8LjD+JAjt+89S+0oK9zA1w5wP3UlGVbWAv4Tnm0ewSMSDL5XmmLJA6O9RxpeS76S/DT0kI55/D9lNzW+vGZ794Up9qVRRM1OyClfeq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR06MB5519.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(376002)(366004)(136003)(396003)(39830400003)(66476007)(6916009)(86362001)(5660300002)(71200400001)(6512007)(26005)(2906002)(316002)(6506007)(8676002)(66556008)(478600001)(186003)(83380400001)(8936002)(66446008)(33716001)(91956017)(76116006)(66946007)(6486002)(64756008)(9686003)(39026012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TJskLl9XRq2lBhcP2s1W1AKsM0hlgPm9GAwM1kqBjNQtCLCDebBBu9bHfdDjgNatxQQqN3Q/aTDUK2lO83qF7ZCSBw58/xr2dz3Bw3/E3LgLh5Xn6rYn8CX578dZ4ISEav26qDJiG7ONGtzfcOlcyDAg2NlJvMiXc7UzZnkA1Q4+9HW0XEq4+tHPDV2uke+HHPSEljyQCbfsZCqeecGstXjGFRCEort5sbr1IF4mZkdck0Vw69pMm4tWj16VQPov0TpfRxIhd0TyZHKzIJ7jQyE3wpwe6IZQt9ukNtx8i/T2Fs6cwwZ570svkgUarjRRhsKA4+LBpeuHQlE3BJ3BG73Gsm88fEgl3yxv3cWUNGIkQ3h+Guo/T69xoyiZTulNRRr8R9PwYA8iOffH7TI00bgFOZkKgPX9Jt9dBco/5UeSLjnhsKkvINBaaUDaOAzPKxMzqnEWI19KTrqfGj0LXDyLzYJppVUrop2lxa6tNtlghQiciPH6c0H/VHz1VLhvKnYBeI7WJIN/82aaCwMlBSrePpLjD0IgPmFcZ+BWc5zy46SpSGqW749P5tFQLB99fX2O1doBD04Ftmn8Fwhdod7FOMt8iCSObHeVe+cWxVoBB6WM05XyRtQl4eeJn8i+pyJ36Iwg+sIbCmbeYWEWUg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <601F8BF58C163D49A096C788A11E6749@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB5519.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba0bf04-ea48-470d-f850-08d87d35d8a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2020 00:42:29.3184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGW9rmBFFjOxCoQYU7UOFU5tpT6SuIZAmQ0JYHLBy+dgA4g3jZybYmVXVglhraYm4kvqIh+izy9kbV3NpDmcwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5520
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add option to just enable the android label backend without disabling=0A=
anything else eg. using ANDROID_HOST. Enable by default when using =0A=
ANDROID_HOST.=0A=
=0A=
Signed-off-by: Bj=F6rn Bidar <bjorn.bidar@jolla.com>=0A=
---=0A=
 libselinux/Makefile     | 3 ++-=0A=
 libselinux/src/Makefile | 6 +++++-=0A=
 2 files changed, 7 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/libselinux/Makefile b/libselinux/Makefile=0A=
index cb5872b7..ac16c15e 100644=0A=
--- a/libselinux/Makefile=0A=
+++ b/libselinux/Makefile=0A=
@@ -4,6 +4,7 @@ PKG_CONFIG ?=3D pkg-config=0A=
 DISABLE_SETRANS ?=3D n=0A=
 DISABLE_RPM ?=3D n=0A=
 ANDROID_HOST ?=3D n=0A=
+LABEL_BACKEND_ANDROID ?=3D n=0A=
 ifeq ($(ANDROID_HOST),y)=0A=
 	override DISABLE_SETRANS=3Dy=0A=
 	override DISABLE_BOOL=3Dy=0A=
@@ -20,7 +21,7 @@ endif=0A=
 ifeq ($(DISABLE_X11),y)=0A=
 	DISABLE_FLAGS+=3D -DNO_X_BACKEND=0A=
 endif=0A=
-export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST DISABLE_X11=
=0A=
+export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST DISABLE_X11 =
=0A=
LABEL_BACKEND_ANDROID=0A=
 =0A=
 USE_PCRE2 ?=3D n=0A=
 ifeq ($(USE_PCRE2),y)=0A=
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile=0A=
index be0b6eec..52c40f01 100644=0A=
--- a/libselinux/src/Makefile=0A=
+++ b/libselinux/src/Makefile=0A=
@@ -122,8 +122,12 @@ SRCS=3D callbacks.c freecon.c label.c label_file.c \=
=0A=
 	label_backends_android.c regex.c label_support.c \=0A=
 	matchpathcon.c setrans_client.c sha1.c booleans.c=0A=
 else=0A=
-DISABLE_FLAGS+=3D -DNO_ANDROID_BACKEND=0A=
+LABEL_BACKEND_ANDROID=3Dy=0A=
+endif=0A=
+=0A=
+ifneq ($(LABEL_BACKEND_ANDROIDT),y)=0A=
 SRCS:=3D $(filter-out label_backends_android.c, $(SRCS))=0A=
+DISABLE_FLAGS+=3D -DNO_ANDROID_BACKEND=0A=
 endif=0A=
 =0A=
 ifeq ($(DISABLE_X11),y)=0A=
-- =0A=
2.29.1=0A=
=0A=
