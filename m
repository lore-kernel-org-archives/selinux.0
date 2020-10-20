Return-Path: <SRS0=Dhgn=D3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF74AC5517F
	for <selinux@archiver.kernel.org>; Tue, 20 Oct 2020 12:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE022222F
	for <selinux@archiver.kernel.org>; Tue, 20 Oct 2020 12:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405899AbgJTMVv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Oct 2020 08:21:51 -0400
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:30182
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394212AbgJTMVu (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 20 Oct 2020 08:21:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAsaWl4/c+UBde8fSEG+dAmkF4TVaIA5x1jNzhqmapEHo2GRDHW1eIUCGNqVMrCBm12y+jKxeuNjvkOy/Ts5pOJyK+PzwU0QbM6ZranQP+LB8ksYgFXUc8VgxEU+VvRC2mkm5SrFwubDflHoq9r41j74BRm7hI0LqRtfz0kooVIyPcEMKz9jiLTihOtAOPER7S8RrrLYCSkpkXYHBac9madgcle412TQyCWw7+3k+vKwstL+5kTqFftJrG+UgDCYmaTQ8LiKTFYP5QUlSHVspalymXuODEuP43ZublEnknoc7bXxZAPXaATBLUj2x6XOw6GZ7VtVtMriV0c6ryawmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NsDvTmsueR5H4kbUwD++GLW7FH3eJEnWy6aA+DS8dY=;
 b=KuSFXwjOcraEK/ij+IZxFzSltACBDDxHObNeOTrwfIz5teWEjgg818HO0tdvyRLA3FUg2YXVVNGf75IrxHobh0c+E3BB0LptC6HDHKKR18DM1yiD1vCUOwt0hYGrAiAkzRFaoIMytxUiGMX0qxvmFqNwZ6CLJywhkHFllPN+uSAviS0l+/QAspW3gLFTBZF881loI7QrWTY9Wkd+OVmEv7sIpUHGAaMOivP778wbvo+lb8soUwnU5z8zaySe2v8bDRNFkRU61rM2svm0wTOiLW8lqoKHfHb9TKNwFvYCtwoYvJWxctHF05bgadLeyAVxemdQ2OlkFAb3HtO8zC7+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NsDvTmsueR5H4kbUwD++GLW7FH3eJEnWy6aA+DS8dY=;
 b=xaVQBxmXblbFdCr1uTnK8qmCte+Qap/bRC+HyMlBbY5U8s6t2QAHylPxjLQ8KggYA/60dl2O+hd4SetTEZiDEsQ7q/OiXgNPTqSzFmbyKnsqckqdie3zrryGClbZI/jOIAv0DE6Svceojxq8vQJL5m6xvaKSEqYwkjFim56rByiJe48RNPeXNUQwAALw5s9L6y4rcY+dT9tYA7Bl6hz0JSX1L4Cztnde85S67F43Kc8H3EU86LDDgLZC4igL9gOBrbejZrpANhT5iw4D5QvLEL7nsCBbki1JPKUz+SCGdcYw64gPJOUZfe/YZFvA9b69qpnj84Xf/Zsp9fsmepBNsw==
Received: from VI1PR06MB5519.eurprd06.prod.outlook.com (2603:10a6:803:d5::23)
 by VE1PR06MB6110.eurprd06.prod.outlook.com (2603:10a6:803:11a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 12:21:43 +0000
Received: from VI1PR06MB5519.eurprd06.prod.outlook.com
 ([fe80::4847:897d:1b48:f01]) by VI1PR06MB5519.eurprd06.prod.outlook.com
 ([fe80::4847:897d:1b48:f01%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 12:21:43 +0000
From:   =?iso-8859-1?Q?Bj=F6rn_Bidar?= <bjorn.bidar@jolla.com>
To:     SElinux list <selinux@vger.kernel.org>
Subject: [PATCH] libselinux: LABEL_BACKEND_ANDROID add option to enable it
Thread-Topic: [PATCH] libselinux: LABEL_BACKEND_ANDROID add option to enable
 it
Thread-Index: AQHWptuS43v9yqIBpECdiQOTcILqqw==
Date:   Tue, 20 Oct 2020 12:21:43 +0000
Message-ID: <8651564.oA283WntVp@odin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=jolla.com;
x-originating-ip: [85.76.102.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e369b97-30cc-481e-70df-08d874f2b4d5
x-ms-traffictypediagnostic: VE1PR06MB6110:
x-microsoft-antispam-prvs: <VE1PR06MB611043C6D40D0CBC49F12161F81F0@VE1PR06MB6110.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ayt58UUaEBMFkOhC+7YjYVutyDN1v2lOtZXTay1d0TA2FWbG39l50pVXYgPvEE74oOaOH34WlP6/oENw1gDDl0JQyrFDeGYwAKmRe6TRW+dva6wEkkvDcwH3bOijCRXhmxlq3lV9Zq1hKEK/kPoVVs0XFzA67H0OE8IRz6b2b497DHn2RCjbak8EeFW7D4n7jwnHdOB3rEFto8eRTtr5bzk6u5ZbKNvpPS/MBkK9zlzHk4IemUlRwF+duHBbRzk4LzKu3Y39No7cTxkw0+SgcxW1cH5cZ0g3OvSsWm0xpIPBt5PtITb33ggm5GGvwVCh1bsekPSA0hspKoQMOK6HDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR06MB5519.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(346002)(33716001)(26005)(64756008)(66446008)(66556008)(2906002)(186003)(6486002)(83380400001)(8676002)(66946007)(71200400001)(76116006)(66476007)(6916009)(91956017)(6512007)(86362001)(6506007)(9686003)(5660300002)(508600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XFwB71FzKOP2zOxPpaS/+4OtdIiazVHL/sIztJmMsfRsnjR9lCfTsaA0h1nWG6k74TwqWOcHsLdB2/BHbEwDir9d5ob6F9tPef7SFflkoElrOldDSpdL8NGy0o4053CKMRD2S9qySDWEoe792ZfjI4VKxWZIZ+tMXBJ2FK17uKK85vGZ9gWhIt8a3fhjdWLcAYr3IkchQGYjlgz4zSUS9MzuchooHuL/qqLOr+fdM7OoDVVKhGnjmQF7Hh0xyLMrcuO2N8a/Mo3RCn2rVaXRe2R1x8IDu8Rf09aF4hTrvHp8TIst6VcCwGD/xVu72D0uUo+eB+CohacWow9LbVD7GW/CLhHW4p/L4jHOfbnGxQl/LvFGDs17ecWFkADSFQM87GkCpFs0vbwsJyouCUeS1Uo9HCWdloNnKIOFSdmwjFOilQAfZRnkjtP/TJMNonhB1WPoBQDOprrHVXFiKH0njgJ3Z0++lAVooNoIGFXb/Odfp4rd1pzVGf0IIub4qvCuUmHMDmJOXJoiealckLXxdR5YV3JKQ1+C0bIc7bHPCF52vtUhCbUre7YPjdAb2E6STV7FgGL4JIdbRyhV7OoIJ858xGLWXCDTs0l5xy2GQ7/MVG+NfxXxHRIwm0enhaZTk7LbM7flOhVRDpC4uEX2LQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B3E2E9D536F61346B5B792DFC0D6FE5B@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB5519.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e369b97-30cc-481e-70df-08d874f2b4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 12:21:43.6000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+n5GbP4E4DVnGzJwo7FFwipBM+E/TIQcisI3P1j/8tW3UIB+85HpDxj16Oq9azIrDja4n+zfZwLonZcB4ZnIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6110
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add option to just enable the android label backend without disabling=0A=
anything else.=0A=
=0A=
Signed-off-by: Bj=F6rn Bidar <bjorn.bidar@jolla.com>=0A=
---=0A=
 libselinux/Makefile     | 3 ++-=0A=
 libselinux/src/Makefile | 6 +++++-=0A=
 2 files changed, 7 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/libselinux/Makefile b/libselinux/Makefile=0A=
index 6a43b243..17226758 100644=0A=
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
@@ -17,7 +18,7 @@ endif=0A=
 ifeq ($(DISABLE_BOOL),y)=0A=
 	DISABLE_FLAGS+=3D -DDISABLE_BOOL=0A=
 endif=0A=
-export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST=0A=
+export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST =0A=
LABEL_BACKEND_ANDROID=0A=
 =0A=
 USE_PCRE2 ?=3D n=0A=
 ifeq ($(USE_PCRE2),y)=0A=
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile=0A=
index 190016e2..2f7c0401 100644=0A=
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
 SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAG=
S)=0A=
-- =0A=
2.28.0=0A=
=0A=
