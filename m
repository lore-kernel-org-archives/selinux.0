Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022AC33C9E
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 03:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AE0206F0
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 03:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="oAzf206M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgAIDXG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 22:23:06 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.4]:41279 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727524AbgAIDXF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 22:23:05 -0500
Received: from [67.219.250.111] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.us-west-2.aws.symcld.net id F7/89-19887-59C961E5; Thu, 09 Jan 2020 03:23:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnl+JIrShJLcpLzFFi42JJl3vFrjtljli
  cwazrGhb3tv1is3jX9JvFYtrx/+wW69YvZrJY1qBqcaY71+LyrjlsFh96HrFZvJ1wlN3i9qTp
  LBbnjx9jt9hztIPZgcdjdsNFFo8Z/6Yyeiz89JXVo+d7ssfavS8YPd7vu8rmcXT/IjaPz5vkP
  M7f/8cewBnFmpmXlF+RwJrRd82nYKJjxf6utWwNjEscuhi5OIQEWpkkzh/bwgrhbGCUODXtPj
  uE85tR4s2+6YwgDqPAUmaJfVc3skM4x1gkNi96AOUA9XT/+gxUxsnBIrCbWWLN1xCI/j4miYV
  L9jNBOPcYJV5v28kKUsUmoClx8s01ZhBbRMBbYmJzKwtIEbNAN4vEh42fmEASwgJRErM6XzBC
  FEVLtK9/yQ5hG0l0zGxhhlinInH3y3Ywm1cgRmL21H9gNUICNRLT7+wBi3MKBEr8uv4UbA6jg
  KzEtEf3weYzC4hLzJ02C+wgCQEBiSV7zjND2KISLx//A4pzANUHSbzbEgdiSggoSaz8EQ9RIS
  txaX43I4TtK3Fx1RY2CFtLond7GztEuYrEv0OVEOFsiSXd76BK1CRuvOmAWiQjcXr+b9YJjAa
  zkNwzC6ibGRhA63fpQ4QVJaZ0P2SfBfaioMTJmU9YFjCyrGK0SCrKTM8oyU3MzNE1NDDQNTQ0
  0jU0stQ1MrHUS6zSTdQrLdYtTy0u0TXSSywv1iuuzE3OSdHLSy3ZxAhMiSkFjT93MHZ/eKt3i
  FGSg0lJlHfWDLE4Ib6k/JTKjMTijPii0pzU4kOMMhwcShK8+2YB5QSLUtNTK9Iyc4DpGSYtwc
  GjJMJrNRsozVtckJhbnJkOkTrFaM8x4eXcRcwcq/7PA5JNH5YAySNzly5iFmLJy89LlRLnLQW
  ZKgDSllGaBzcUlk8uMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmPQIyhSczrwRu9yugs5iA
  zrpzRxTkrJJEhJRUA1Oep5hUw/7ut/5pbjsW1AgqedpMUH8bKenH8evYbIHD9W8VXcwj1039Y
  ev0/K9ipu1n55Os4QcerOAuK9Ix+/57mT1fyAsRntyLX/XUViZFu5aVtBZ4HZl7fZqpLoP233
  3sfBHuCjcuipz+P2vBbd2Hf8/tWhwT9mMK/4EJnx58EZ5zX251xtk6kx/rPUrkisXu/OLf9Sx
  KRVtviVXijH+6mhdUJmanv5/07G222JRv8yb552wXPtv7JUEvurZVZFt8X1ZpzeSzx7pltlV2
  m78zbDmznzWKuUjL5f/Fhnd3eXcxWJ5RufSyIXq3mNPce9+l9jz5+7GGr6N6gbR2bxvH9gsqq
  7gY/iyYsyHk224lluKMREMt5qLiRADibhEuogQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-4.tower-335.messagelabs.com!1578540176!189884!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22546 invoked from network); 9 Jan 2020 03:23:00 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-4.tower-335.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 9 Jan 2020 03:23:00 -0000
Received: from USMAILCH03.lenovo.com (unknown [10.62.32.7])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 953E653C39C0BC0F2BF5;
        Thu,  9 Jan 2020 11:22:53 +0800 (CST)
Received: from va32wusexedge02.lenovo.com (10.62.123.117) by
 USMAILCH03.lenovo.com (10.62.32.7) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 9 Jan 2020 01:22:51 -0200
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.125.51)
 by mail.lenovo.com (10.62.123.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1779.2; Thu, 9 Jan 2020 11:22:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ed2JPK+3Q1A6Yx+xXTuZw8tk9RjclhAShTbjGp61wLY/1kyAaulj+AhEwNzwwIDYukNhjVk+/VqxQFDg02eXT65j18sgIiv5BUkoT7e0jmyw9nErjR5/qy3ibKa2RqJqNI9bPN1cfF8M64Bz+BL9WRcMP/yEwR4MtOQRle+EbT71YPbDwe7Jd8w/8tCqm+B5htNUrg5/PdsymrEKU2k4YuHkBxwRHHqutk16pucGfSilmwzO4uEYL5eqjbXkAgGGJt7LKH6P9PmLuL6OpA1kQy8wWRoEEMwokSne7QELfs78UdqzPRnW8Y0rLF2qAJKnvu3Al4xq9+3uHGsRu6ur6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+qURpWpXLVu0b0OAMOQywFE80TABGsz1TfxkG8/EuY=;
 b=b9bBTtXOPuVfuKIZ4NUDgts9pMd93xcieVu49Esm8Nr7VsaA0bBd/Ub06myT6uDp5etHUdoD0DlDaS+fAG6oeTZnhJuTCObRGaUdyAQpvAimudWqidLIjBYqpf9LP7NxJzhbGJRZ0I1y+PPrqEHcOc7H0NzyKhpC6LMNrvn4hew5smQ9r+423t6nZYU79qWacX84H8wQvqZynj88zR+4x56M/SUwgyd/5bUh0SLHKZolG4rlSxALnzDBr93i9VAdboMuSYKUfMUDqQ9zMbzfmWWdU6vkydvtaxgHy21APJzoaR307y+5jKsY95+5rZ1dHW+IEgMxP36Ddws27szjNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+qURpWpXLVu0b0OAMOQywFE80TABGsz1TfxkG8/EuY=;
 b=oAzf206Mvzj1ZlANH1jJKuWJGCQ6C9AU/Asxo82l7gcimPZEMHwcrLEadTH9e0s0pWLf8hiFkuNdAHBHEDXOjfXP5ukyqZTpOGmwgBgjP4hPio2n4g4+CQp9SyIlLFRICdDdsUrcPUuZx+Wf/JFob4pRDLlKiq51O2RFJNSqq6k=
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com (10.170.158.23) by
 HK2PR03MB4532.apcprd03.prod.outlook.com (10.170.159.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.3; Thu, 9 Jan 2020 03:22:48 +0000
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::99e2:67f9:507e:35a4]) by HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::99e2:67f9:507e:35a4%4]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 03:22:48 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        James Morris <jmorris@namei.org>
CC:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "efremov@ispras.ru" <efremov@ispras.ru>,
        Paul Moore <paul@paul-moore.com>,
        David Howells <dhowells@redhat.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        Tzu ting Yu1 <tyu1@lenovo.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Huaisheng Ye <yehs2007@zoho.com>,
        Chris McDermott2 <lmcdermott@lenovo.com>
Subject: RE: [External]  Re: [PATCH] LSM: Delete hooks in reverse order for
 avoiding race
Thread-Topic: [External]  Re: [PATCH] LSM: Delete hooks in reverse order for
 avoiding race
Thread-Index: AQHVxhjQZSypKez7l06Eu0u8IcnCKafhp8ig
Date:   Thu, 9 Jan 2020 03:22:47 +0000
Message-ID: <HK2PR03MB4418FD9D44EA2C95F1A8115792390@HK2PR03MB4418.apcprd03.prod.outlook.com>
References: <20200108083430.57412-1-yehs2007@zoho.com>
 <CAFqZXNujo1px1=JVc+Chr_trVDRpwcXv7pqWVSxi+yifvWoMuA@mail.gmail.com>
In-Reply-To: <CAFqZXNujo1px1=JVc+Chr_trVDRpwcXv7pqWVSxi+yifvWoMuA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.74.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1c301be-a811-460d-4f9b-08d794b33398
x-ms-traffictypediagnostic: HK2PR03MB4532:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR03MB453273FA3BEB7539BD215F1592390@HK2PR03MB4532.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(396003)(136003)(189003)(199004)(13464003)(966005)(4326008)(66556008)(66446008)(26005)(86362001)(8676002)(2906002)(64756008)(66476007)(186003)(5660300002)(66946007)(316002)(9686003)(76116006)(110136005)(55016002)(52536014)(54906003)(107886003)(8936002)(81166006)(33656002)(81156014)(7696005)(7416002)(478600001)(71200400001)(6506007)(53546011)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB4532;H:HK2PR03MB4418.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ovVnMntKPDdU/JU4O9SKipFJYlUoItAML9qsCcDldr7Gq8nbQliGFCFCnZ1VLwf9naAbRmctBkiA3aaji1YvGjmIXTZzEa5n37OGB8dr9ojmRBlnlU0Sj561wTHoQJO0bAeY9lOLQT8fJQF9urDd8fHLDi6MuZM7LTT8BAV49Nkq5hlYI4woH9LhjNdfIgVCWkAjzuWm3sZ9wQIsQa6ulmmv9O/VNm9H9VLtyYSDVU7v6IsgUFv+cdZzFHcQGmEtJ48wCDaO3U7Kq19lNfSSgQRuNKhDcj60xN8sdQAGip8CPD+yBGpVGI94fy/2ljg6Yd2wI9UUfOG9NQ+EymWIjEN7Dg/jaxRi6uQWONAFa3Gpd7Sg3n0Didi/jk7DL3BQhNN3IXwX+vwmvqQgICS7zRH6jP0z2gYYwPL1wgoYFetn3VNkvj2vRdT7Ju1EGvgWX8B+nCEznBPxlDViMYpjWq0dfnwfN3aJLRNDIvJtbZNyTftA8gM2JdriFgOIvJaiDdW0iDHUSug1cBjVEN+KRRqAJUMO0khk8a5BVW/yHs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c301be-a811-460d-4f9b-08d794b33398
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 03:22:47.9832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tffBwmOT8vjCzzoDYcUaZz40Pk6+8rPORm+bNfEiMcGrEe33p2LyxJ6nqYiCO4jF+U9d4x9rXdR9Exi4RYA90Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB4532
X-OriginatorOrg: lenovo.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE9uZHJlaiBNb3NuYWNlayA8
b21vc25hY2VAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDgsIDIwMjAg
Nzo0MyBQTQ0KPiANCj4gSGksDQo+IA0KPiBPbiBXZWQsIEphbiA4LCAyMDIwIGF0IDk6NTEgQU0g
SHVhaXNoZW5nIFllIDx5ZWhzMjAwN0B6b2hvLmNvbT4gd3JvdGU6DQo+ID4gRnJvbTogSHVhaXNo
ZW5nIFllIDx5ZWhzMUBsZW5vdm8uY29tPg0KPiA+DQo+ID4gVGhlcmUgaXMgc21hbGwgcG9zc2li
aWxpdHkgYXMgcmFjZSBjb25kaXRpb24gd2hlbiBzZWxpbnV4X2Rpc2FibGUgaGFzDQo+ID4gYmVl
biB0cmlnZ2VyZWQuIHNlY3VyaXR5X2RlbGV0ZV9ob29rcyBkZWxldGVzIGFsbCBzZWxpbnV4IGhv
b2tzIGZyb20NCj4gPiBzZWN1cml0eV9ob29rX2hlYWRzLCBidXQgdGhlcmUgYXJlIHNvbWUgc2Vs
aW51eCBmdW5jdGlvbnMgd2hpY2ggYXJlDQo+ID4gYmVpbmcgY2FsbGVkIGF0IHRoZSBzYW1lIHRp
bWUuDQo+ID4NCj4gPiBIZXJlIGlzIGEgcGFuaWMgYWNjaWRlbnQgc2NlbmUgZnJvbSA0LjE4IGJh
c2VkIGtlcm5lbCwNCj4gPg0KPiA+IFsgICAyNi42NTQ0OTRdIFNFTGludXg6ICBEaXNhYmxlZCBh
dCBydW50aW1lLg0KPiA+IFsgICAyNi42NTQ1MDddIEJVRzogdW5hYmxlIHRvIGhhbmRsZSBrZXJu
ZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlDQo+ID4gYXQgMDAwMDAwMDAwMDAwMDAyMA0KPiA+
IFsgICAyNi42NTQ1MDhdIFBHRCAwIFA0RCAwDQo+ID4gWyAgIDI2LjY1NDUxMF0gT29wczogMDAw
MiBbIzFdIFNNUCBOT1BUSQ0KPiA+IFsgICAyNi42NTQ1MTJdIENQVTogNTMgUElEOiAyNjE0IENv
bW06IHN5c3RlbWQtY2dyb3VwcyBUYWludGVkOiBHDQo+ID4gICAgICBPRSAgICAtLS0tLS0tLS0g
LSAgLSA0LjE4LjAtODAuZWw4Lng4Nl82NCAjMQ0KPiA+IFsgICAyNi42NTQ1MTJdIEhhcmR3YXJl
IG5hbWU6IExlbm92byBUaGlua1N5c3RlbSBTUjg1MFANCj4gPiAgLVs3RDJIXS0vLVs3RDJIXS0s
IEJJT1MgLVtURUUxNDVQLTEuMTBdLSAxMi8wNi8yMDE5DQo+ID4gWyAgIDI2LjY1NDUxOV0gUklQ
OiAwMDEwOnNlbGludXhfc29ja2V0X3Bvc3RfY3JlYXRlKzB4ODAvMHgzOTANCj4gPiBbICAgMjYu
NjU0NTIwXSBDb2RlOiBlOSA5NSA2YSA4OSAwMCBiZCAxNiAwMCAwMCAwMCBjNyA0NCAyNCAwNCAw
MQ0KPiA+ICAwMCAwMCAwMCA0NSA4NSBjMCAwZiA4NSBmNiAwMCAwMCAwMCA4YiA1NiAxNCA4NSBk
MiAwZiA4NCAyNiAwMSAwMA0KPiA+ICAwMCA4OSA1NCAyNCAwNCA8NjY+IDQxIDg5IDZjIDI0IDIw
IDMxIGMwIDQxIDg5IDU0IDI0IDFjIDQxIGM2IDQ0DQo+ID4gIDI0IDIyIDAxIDQ5IDhiIDRkDQo+
ID4gWyAgIDI2LjY1NDUyMV0gUlNQOiAwMDE4OmZmZmZiZjUxNWNjNjNlNDggRUZMQUdTOiAwMDAx
MDI0Ng0KPiA+IFsgICAyNi42NTQ1MjJdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAw
MDAwMDAwMDAwMDEgUkNYOg0KPiAwMDAwMDAwMDAwMDAwMDE5DQo+ID4gWyAgIDI2LjY1NDUyMl0g
UkRYOiAwMDAwMDAwMDAwMDAwMDAxIFJTSTogMDAwMDAwMDAwMDAwMDAwMSBSREk6DQo+IGZmZmZm
ZmZmYWI0NmY2ODANCj4gPiBbICAgMjYuNjU0NTIzXSBSQlA6IDAwMDAwMDAwMDAwMDAwMTkgUjA4
OiAwMDAwMDAwMDAwMDAwMDAwIFIwOToNCj4gZmZmZmJmNTE1Y2M2M2U0Yw0KPiA+IFsgICAyNi42
NTQ1MjNdIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOg0K
PiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gWyAgIDI2LjY1NDUyNF0gUjEzOiBmZmZmOTdkN2JiNmNi
YzgwIFIxNDogMDAwMDAwMDAwMDAwMDAwMSBSMTU6DQo+IGZmZmY5N2Q3YmI2Y2JjODANCj4gPiBb
ICAgMjYuNjU0NTI1XSBGUzogIDAwMDA3ZjVjNjA4ZWEzODAoMDAwMCkgR1M6ZmZmZjk3ZDdiZjE0
MDAwMCgwMDAwKQ0KPiBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+ID4gWyAgIDI2LjY1NDUyNV0g
Q1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiA+IFsg
ICAyNi42NTQ1MjZdIENSMjogMDAwMDAwMDAwMDAwMDAyMCBDUjM6IDAwMDAwMTFlYmM5MzQwMDQg
Q1I0Og0KPiAwMDAwMDAwMDAwNzYwNmUwDQo+ID4gWyAgIDI2LjY1NDUyN10gRFIwOiAwMDAwMDAw
MDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6DQo+IDAwMDAwMDAwMDAwMDAwMDAN
Cj4gPiBbICAgMjYuNjU0NTI4XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZm
ZmUwZmYwIERSNzoNCj4gMDAwMDAwMDAwMDAwMDQwMA0KPiA+IFsgICAyNi42NTQ1MjhdIFBLUlU6
IDU1NTU1NTU0DQo+ID4gWyAgIDI2LjY1NDUyOF0gQ2FsbCBUcmFjZToNCj4gPiBbICAgMjYuNjU0
NTM1XSAgc2VjdXJpdHlfc29ja2V0X3Bvc3RfY3JlYXRlKzB4NDIvMHg2MA0KPiA+IFsgICAyNi42
NTQ1MzddIFNFTGludXg6ICBVbnJlZ2lzdGVyaW5nIG5ldGZpbHRlciBob29rcw0KPiA+IFsgICAy
Ni42NTQ1NDJdICBfX3NvY2tfY3JlYXRlKzB4MTA2LzB4MWEwDQo+ID4gWyAgIDI2LjY1NDU0NV0g
IF9fc3lzX3NvY2tldCsweDU3LzB4ZTANCj4gPiBbICAgMjYuNjU0NTQ3XSAgX194NjRfc3lzX3Nv
Y2tldCsweDE2LzB4MjANCj4gPiBbICAgMjYuNjU0NTUxXSAgZG9fc3lzY2FsbF82NCsweDViLzB4
MWIwDQo+ID4gWyAgIDI2LjY1NDU1NF0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsw
eDY1LzB4Y2ENCj4gPg0KPiA+IFRoZSByb290IGNhdXNlIGlzIHRoYXQsIHNlbGludXhfaW5vZGVf
YWxsb2Nfc2VjdXJpdHkgaGFzIGJlZW4gZGVsZXRlZA0KPiA+IGZpcnN0bHkgZnJvbSBzZWN1cml0
eV9ob29rX2hlYWRzLCBzbyBzZWN1cml0eV9pbm9kZV9hbGxvYyBkaXJlY3RseQ0KPiA+IHJldHVy
biAwLCB0aGF0IG1lYW5zIHRoZSB2YWx1ZSBvZiBwb2ludGVyIGlub2RlLT5pX3NlY3VyaXR5IGVx
dWFsbGluZw0KPiA+IHRvIE5VTEwuDQo+ID4NCj4gPiBCdXQgc2VsaW51eF9zb2NrZXRfcG9zdF9j
cmVhdGUgaGFzbid0IGJlZW4gZGVsZXRlZCBhdCB0aGF0IG1vbWVudCwgc28NCj4gPiB3aGljaCB3
b3VsZCBpbnZvbGtlZCBieSBtaXN0YWtlLiBJbnNpZGUgdGhlIGZ1bmN0aW9uLCBwb2ludGVyIGlz
ZWMNCj4gPiBuZWVkcyB0byBwb2ludCB0byBpbm9kZS0+aV9zZWN1cml0eSwgdGhlbiBhIE5VTEwg
cG9pbnRlciBkZWZlY3QgaGFwcGVucy4NCj4gPg0KPiA+IEZvciBjdXJyZW50IHVwc3RyZWFtIGtl
cm5lbCwgYmVjYXVzZSBvZiBjb21taXQNCj4gPiBhZmIxY2JlMzc0NDBjN2YzOGI5Y2Y0NmZjMzMx
Y2M5ZGZkNWNjZTIxDQo+ID4gdGhlIGlub2RlIHNlY3VyaXR5IGhhcyBiZWVuIG1vdmVkIG91dCB0
byBMU00gaW5mcmFzdHJ1Y3R1cmUgZnJvbQ0KPiA+IGluZGl2aWR1YWwgc2VjdXJpdHkgbW9kdWxl
cyBsaWtlIHNlbGludXguDQo+ID4NCj4gPiBCdXQgdGhpcyBwYXRjaCBzdGlsbCBjYW4gYmUgYXBw
bGllZCBmb3Igc29sdmluZyBzaW1pbGFyIGlzc3VlIHdoZW4NCj4gPiBzZWN1cml0eV9kZWxldGVf
aG9va3MgaGFzIGJlZW4gdXNlZC4gQWxzbyBmb3Igc3RhYmxlIGJyYW5jaCB2NC4xOSwgdGhlDQo+
ID4gaW5vZGUgc2VjdXJpdHkgc3RpbGwgbmVlZCB0byBiZSBjcmVhdGVkIGluIGluZGl2aWR1YWwg
bW9kdWxlcy4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLCBob3dldmVyIHRoZXJlIGFy
ZSBhbHJlYWR5IGV4aXN0aW5nIHByb3Bvc2VkIHBhdGNoZXMgdG8NCj4gZml4IHRoaXMgaXNzdWUs
IHNlZSBbMV0sIFsyXSwgYW5kIFszXS4gQXQgdGhlIG1vbWVudCBpdCBsb29rcyBsaWtlIHRoZSBT
RUxpbnV4DQo+IGhvb2tzIHJlb3JkZXIgYXBwcm9hY2ggKFsxXSkgd2lsbCBiZSBhY2NlcHRlZCBh
cyBhIHRlbXBvcmFyeSBzb2x1dGlvbiAodGhlIFNFTGludXgNCj4gcnVudGltZSBkaXNhYmxlIGlz
IGJlaW5nIGRlcHJlY2F0ZWQgWzRdIGluIGZhdm9yIG9mIHByb3Blcmx5IGRpc2FibGluZyBTRUxp
bnV4DQo+IGJ5IHNldHRpbmcNCj4gc2VsaW51eD0wIG9uIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5l
KS4NCg0KSGkgT25kcmVqLA0KDQpUaGFua3MgZm9yIGludHJvZHVjdGlvbiwgYW5kIHllcyAic2Vs
aW51eD0wIiBpcyB0aGUgc2ltcGxlc3QgYW5kIGVmZmVjdGl2ZSB3b3JrYXJvdW5kDQpmb3IgdGhp
cyBkZWZlY3QuDQpJIHVzZWQgaXQgYmVmb3JlIGFzIHdvcmthcm91bmQgYW5kIHRoZSBwYW5pYyBp
c3N1ZSBjb3VsZG4ndCBiZSByZXByb2R1Y2VkIGFnYWluLg0KDQo+IA0KPiBZb3VyIGFwcHJvYWNo
IHVuZm9ydHVuYXRlbHkgaXNuJ3Qgcm9idXN0IChkZXBlbmRzIG9uIGFzc3VtcHRpb25zIGFib3V0
IGhvdyBob29rcw0KPiBhcmUgb3JkZXJlZCBieSBMU01zKSBub3IgY29tcGxldGUgKGV2ZW4gdGhl
IGludmVyc2Ugb3JkZXIgc3RpbGwgaGFzIHNvbWUgcmFjZQ0KPiBjb25kaXRpb25zIHRoYXQgbWF5
IGxlYWQgdG8gYSBjcmFzaCAtIGUuZy4NCj4gc2VsaW51eF9icGZfbWFwKCkgdnMuIHNlbGludXhf
YnBmX21hcF9hbGxvYygpKS4NCj4gDQo+IEFsc28sIHBsZWFzZSwgZG9uJ3QgZm9yZ2V0IHRvIENj
IHRoZSBMU00vU0VMaW51eCBtYWlsaW5nIGxpc3RzDQo+IChsaW51eC1zZWN1cml0eS1tb2R1bGVA
dmdlci5rZXJuZWwub3JnL3NlbGludXhAdmdlci5rZXJuZWwub3JnLA0KPiByZXNwZWN0aXZlbHkp
IGZvciBwYXRjaGVzIHJlbGF0ZWQgdG8gdGhlIExTTSBmcmFtZXdvcmsvU0VMaW51eC4NCg0KR290
IGl0LCBJIGFtIG5ldyB0byBzZWxpbnV4IG1vZHVsZS4NCg0KQ2hlZXJzLA0KSHVhaXNoZW5nIFll
DQpMZW5vdm8NCg0KPiANCj4gWzFdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3NlbGludXgv
MjAxOTEyMDkwNzU3NTYuMTIzMTU3LTEtb21vc25hY2VAcmVkaGF0LmNvbS8NCj4gVC8NCj4gWzJd
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3NlbGludXgvMjAxOTEyMTExNDA4MzMuOTM5ODQ1
LTEtb21vc25hY2VAcmVkaGF0LmNvbS8NCj4gVC8NCj4gWzNdDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3NlbGludXgvMjAyMDAxMDcxMzMxNTQuNTg4OTU4LTEtb21vc25hY2VAcmVkaGF0LmNv
bS8NCj4gVC8NCj4gWzRdDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3BjbW9vcmUvc2VsaW51eC5naXQvY29tbWl0Lz8NCj4gaD1uZXh0JmlkPTg5YjIy
M2JmYjhhODk3MzFiZWE0Yzg0OTgyYjVkMmFkN2JhNDYwZTMNCj4gDQo+ID4NCj4gPiBUaGUgcGF0
Y2ggaGFzIGJlZW4gdmVyaWZpZWQgYnkgTGVub3ZvIFNSODUwUCBzZXJ2ZXIgdGhyb3VnaCBvdmVy
bmlnaHQNCj4gPiByZWJvb3QgY3ljbGVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSHVhaXNo
ZW5nIFllIDx5ZWhzMUBsZW5vdm8uY29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2xz
bV9ob29rcy5oIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2xzbV9ob29r
cy5oIGIvaW5jbHVkZS9saW51eC9sc21faG9va3MuaA0KPiA+IGluZGV4IDIwZDhjZjEuLjU3Y2Iy
YWMgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9sc21faG9va3MuaA0KPiA+ICsrKyBi
L2luY2x1ZGUvbGludXgvbHNtX2hvb2tzLmgNCj4gPiBAQCAtMjE2NCw3ICsyMTY0LDcgQEAgc3Rh
dGljIGlubGluZSB2b2lkIHNlY3VyaXR5X2RlbGV0ZV9ob29rcyhzdHJ1Y3QNCj4gc2VjdXJpdHlf
aG9va19saXN0ICpob29rcywNCj4gPiAgICAgICAgIGludCBpOw0KPiA+DQo+ID4gICAgICAgICBm
b3IgKGkgPSAwOyBpIDwgY291bnQ7IGkrKykNCj4gPiAtICAgICAgICAgICAgICAgaGxpc3RfZGVs
X3JjdSgmaG9va3NbaV0ubGlzdCk7DQo+ID4gKyAgICAgICAgICAgICAgIGhsaXN0X2RlbF9yY3Uo
Jmhvb2tzW2NvdW50IC0gMSAtIGldLmxpc3QpOw0KPiA+ICB9DQo+ID4gICNlbmRpZiAvKiBDT05G
SUdfU0VDVVJJVFlfU0VMSU5VWF9ESVNBQkxFICovDQo+ID4NCj4gPiAtLQ0KPiA+IDEuOC4zLjEN
Cj4gPg0KPiA+DQo+IA0KPiAtLQ0KPiBPbmRyZWogTW9zbmFjZWsgPG9tb3NuYWNlIGF0IHJlZGhh
dCBkb3QgY29tPiBTb2Z0d2FyZSBFbmdpbmVlciwgU2VjdXJpdHkNCj4gVGVjaG5vbG9naWVzIFJl
ZCBIYXQsIEluYy4NCg0K
