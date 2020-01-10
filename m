Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50328C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 16:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8412072E
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 16:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="ODJHisWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgAJQqz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:46:55 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.1]:52963 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728868AbgAJQqy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 11:46:54 -0500
Received: from [67.219.246.111] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-east-1.aws.symcld.net id 74/EB-12313-B7AA81E5; Fri, 10 Jan 2020 16:46:51 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRWlGSWpSXmKPExsWS8eIhj27VKok
  4g9VNXBadD88yW6xbv5jJ4vKuOWwWH3oesVncnjSdxeLw7sXMFuePH2O3OH/hHLvFnqMdzA6c
  Htd2R3r0fE/2OPs1ymPt3heMHlun/2f1+LxJzuP8/X/sAexRrJl5SfkVCawZPSt/sRT08Vdsf
  rqCuYHxC18XIxeHkEADk8Slw+eYIJxXjBKfT29mg8ss6Wxk72LkBHJ+M0pc6xQESTAKLGWWmL
  N3JiOEc4xF4tHMj6wQzgZGie5fn8EyLAK7mSWuNE5kgRg2kUliy65nzBDObUaJj8/+soBMZhP
  QlDj55hpYQkTgBqPEpE37wIYxC/QwSVzYNxesSljAVeLqhT2sILaIgJvE4y3P2SFsPYlzb+8z
  g9gsAqoS0/evYgSxeQVigHoPgtUwCshKTHt0nwnEZhYQl5g7bRbYHAkBAYkle84zQ9iiEi8f/
  wOKcwDVB0m82xIHEVaS+HfhPwuELStxaX43I4TtK7Gnbys7SLmEgJbE2gVOEKaKxL9DlRAV2R
  JnNs+EGq4msefbEagpMhK3Wk+BfSghsI5FYn/TXfYJjPqzkBw3C2gUMzBY1u+CCitKTOl+yD4
  L7C9BiZMzn7AsYGRZxWiWVJSZnlGSm5iZo2toYKBraGika6xrZGihl1ilm6RXWqybmlhcomuo
  l1herFdcmZuck6KXl1qyiRGY5FIKmG/tYPz89a3eIUZJDiYlUV7OOPE4Ib6k/JTKjMTijPii0
  pzU4kOMMhwcShK8ySsk4oQEi1LTUyvSMnOACRcmLcHBoyTCywqS5i0uSMwtzkyHSJ1iNOaY8H
  LuImaOI3OXLmIWYsnLz0uVEudlWAlUKgBSmlGaBzcIlgkuMcpKCfMyMjAwCPEUpBblZpagyr9
  iFOdgVBLmXQGykCczrwRuHzDhAn0hwnvnjijIKSWJCCmpBqZQmT31OTE56cXFj42Flj+Qua1w
  8YX/ZtEZJx+bik6/lMiuUuTMXiUQIXQ4au6z5KNMSpP/Gc24Xti5TNhZT/bJFDMdCafjPfNrL
  q06JH5eR0En8Nr72UE+XCxfkw4VZDx85Jn4UvG09a/X+8rt3z+z12EILVQO8tYz4ZqezHTztM
  HLWQ55ekm1Mzs+71WIjvl1YsaXN90aFucP7LvQvzwkuPkFH/fRxZ223EtyhN6VFPS9C+gSeyr
  1v8cn5SPvkyNsNY3cB3xev9GYHvFux9Glj5QOSmU/d78X+/ZPFZPyzqriX/Oq3dsnWD0xn157
  7NsK/8br+p5XblVKenQe9OsLj2YpW97zVyxnu8d/AyWW4oxEQy3mouJEAIuLVN9/BAAA
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-33.tower-395.messagelabs.com!1578674809!1729330!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16667 invoked from network); 10 Jan 2020 16:46:50 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-33.tower-395.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Jan 2020 16:46:50 -0000
Received: from HKGWPEMAIL01.lenovo.com (unknown [10.128.3.69])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 18A2B6315A5F4D67F071;
        Fri, 10 Jan 2020 11:46:47 -0500 (EST)
Received: from HKGWPEMAIL01.lenovo.com (10.128.3.69) by
 HKGWPEMAIL01.lenovo.com (10.128.3.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1779.2; Sat, 11 Jan 2020 00:46:45 +0800
Received: from HKEXEDGE01.lenovo.com (10.128.62.71) by HKGWPEMAIL01.lenovo.com
 (10.128.3.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1779.2 via Frontend
 Transport; Sat, 11 Jan 2020 00:46:45 +0800
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (104.47.108.51)
 by mail.lenovo.com (10.128.62.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1779.2; Sat, 11 Jan
 2020 00:46:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy/Rvldhjr7Gv/WvUx7NgtkeKPF9v20QMfOTkqNGHE6NKtuVG3g+1uAblrMtrZHOY+od/2xGiidd1wL5vLwUCSxnA7WupASHPV5Nw1kZlxBdssYU2ddm7aXb4dOq0IBYA26M/VYKkUVPGUe6on1PzG2NmpHRv8oILAIAVyDUzUELxnaNhWm3gwqqncUOALgMgd54PzNsRCzUOcorJ+sfX18QLS3D8e7nBMTNBIhdlBJbFwhTUcrmq/PXXKWx1Kks+Iq8jb1Cr2wBj5uWzP1GvF3TK8xzHaOmgQo+V7mGSsWhH1rzcB1SavNOXHxtU/ZwhCIXyza+5oLnWr1wWtzE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Yqss8Xe3KoEG3yhdoxCDb1x+/XndZWBkHsxNIv8In0=;
 b=B0hK6kmOW+k4ju28VeVuz7lhx2GNKG/ntca+62mfw7wpQh0gVMDZCzf/vNon+9LSB3DYHaOnBArFjh99HlyxnqBcNgxZF6zmTib+WwOj6NvdlqS0ehRuO7Okd7tcUR1bdDtnEnPx6/ksd3x0URoqi9dWVHgDZ3FVbPkZxOXtGbgdUbzcKlbx/Gk8uUL9wodYoJzMByr6gyBQPDDXp3WO9DjPLN6RfWia9sAUEwiqjShbB6YvPTZ3VZmedzjPBuuDojSjufnXAcu7NSk/wSU8YY2vegH6IeFKp5kJdmkUotV1PeAjgHKJMwVskXVIAlUiiK4BnHyjAHXB067oHO/2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Yqss8Xe3KoEG3yhdoxCDb1x+/XndZWBkHsxNIv8In0=;
 b=ODJHisWhD6FXPT1DezFGRJr6ICG3KMjCVBbbyoItVfVXjwC/QY4pD6jYW4Xikc3Qtj2nxbkRz86F5Qel0AbmINOdjOzj8CJUq4hjWjPzNq7nTxJuIISBiCfdXVudCaAr1jvHdEE6j6C2fmMCRzPUt6EmPcmPK1psAVJTHMnRvJQ=
Received: from SL2PR03MB4425.apcprd03.prod.outlook.com (20.178.163.203) by
 SL2PR03MB4603.apcprd03.prod.outlook.com (20.178.162.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.5; Fri, 10 Jan 2020 16:46:34 +0000
Received: from SL2PR03MB4425.apcprd03.prod.outlook.com
 ([fe80::ac:7d71:eba7:1565]) by SL2PR03MB4425.apcprd03.prod.outlook.com
 ([fe80::ac:7d71:eba7:1565%7]) with mapi id 15.20.2644.010; Fri, 10 Jan 2020
 16:46:34 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "eparis@parisplace.org" <eparis@parisplace.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>
CC:     Tzu ting Yu1 <tyu1@lenovo.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huaisheng Ye <yehs2007@zoho.com>
Subject: Re: [PATCH] selinux: remove redundant msg_msg_alloc_security
Thread-Topic: [PATCH] selinux: remove redundant msg_msg_alloc_security
Thread-Index: AdXH1XutBMvy1rlaSm6SDVDC+PBSdw==
Date:   Fri, 10 Jan 2020 16:46:34 +0000
Message-ID: <SL2PR03MB4425F3C1A2DA9F0EC48B10A292380@SL2PR03MB4425.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [221.219.123.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 075230e7-37ba-4d40-f4c5-08d795eca70c
x-ms-traffictypediagnostic: SL2PR03MB4603:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SL2PR03MB4603C5E017018AFFCF4C8E2992380@SL2PR03MB4603.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(13464003)(51914003)(51444003)(86362001)(4326008)(76116006)(66946007)(316002)(81156014)(81166006)(52536014)(53546011)(71200400001)(9686003)(55016002)(186003)(26005)(7696005)(6506007)(110136005)(5660300002)(54906003)(33656002)(8936002)(66556008)(64756008)(66446008)(66476007)(8676002)(2906002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SL2PR03MB4603;H:SL2PR03MB4425.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GUM0331uUruvtWWgV/ki5DiU2Ld135yR6HDmZejJLnVdHV4XFRCcBEagkjYjX30Rc36UWXIadrnfdGtZ0UNtFxzzbsS7r9eYV0SWisH3dFz1HUasmZrRyeffC4nlKBpJIdoAv1Uvr3O87p5LrN0ErzEygdealpJ8zsLJ2ZutDoYpjk0gDimkK5FVjP6WOaPeTZyhHTT9fHj9GKzSpxub78oUuYfDnE+EGKWa+U8zuqqHWJXxIQWSoC9zYPuw7hd1+yFGse1DIcj8BM2eL191FUJsakn2vq7xXEKHT+vPFmhGu9A98AgXkfMW30o3lJU/rRbUIrsuiD3XWKgd8h42ztmTWoboq9vLSCGYR5mOXJIJB5sxNuPOpFGHZbaZbi8eQU7b3vm0Hmy0gdoH6Uj6X2SameA+dvDS0z43IMEH4NmqlZRWAkDLANFB4LvpAvt0Ln6YIE9xgvSFgRjHPqLppvDRlhRh8aEYpxHleoY2Ue2RX3G5z4jOOElvYOlM42ebu+Lv39S5uLBORxsECcK4LeasPDHZOMZlHzCYxmkl2v8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 075230e7-37ba-4d40-f4c5-08d795eca70c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 16:46:34.1950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmQw1Tvy4Gpyh3FqJ2YuRuwLTZmhQnLwhwvzGl5GbtVBYnPVN7/muKuI1twT66uVcaYejDE2ucg9NXCd0mXZEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR03MB4603
X-OriginatorOrg: lenovo.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZXBoZW4gU21hbGxleSA8
c2RzQHR5Y2hvLm5zYS5nb3Y+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMCwgMjAyMCAxMTox
NCBQTQ0KPiANCj4gT24gMS8xMC8yMCA0OjU4IEFNLCBIdWFpc2hlbmcgWWUgd3JvdGU6DQo+ID4g
RnJvbTogSHVhaXNoZW5nIFllIDx5ZWhzMUBsZW5vdm8uY29tPg0KPiA+DQo+ID4gc2VsaW51eF9t
c2dfbXNnX2FsbG9jX3NlY3VyaXR5IG9ubHkgY2FsbHMgbXNnX21zZ19hbGxvY19zZWN1cml0eSBi
dXQNCj4gPiBkbyBub3RoaW5nIGVsc2UuIEFuZCBhbHNvIG1zZ19tc2dfYWxsb2Nfc2VjdXJpdHkg
aXMganVzdCB1c2VkIGJ5IHRoZQ0KPiA+IGZvcm1lci4NCj4gPg0KPiA+IFJlbW92ZSB0aGUgcmVk
dW5kYW50IGZ1bmN0aW9uIHRvIHNpbXBsaWZ5IHRoZSBjb2RlLg0KPiANCj4gVGhpcyBzZWVtcyB0
byBhbHNvIGJlIHRydWUgb2Ygb3RoZXIgX2FsbG9jX3NlY3VyaXR5IGZ1bmN0aW9ucywgcHJvYmFi
bHkgZHVlIHRvDQo+IGhpc3RvcmljYWwgcmVhc29ucy4gIEZ1cnRoZXIsIGF0IGxlYXN0IHNvbWUg
b2YgdGhlc2UgZnVuY3Rpb25zIG5vIGxvbmdlciBwZXJmb3JtDQo+IGFueSBhbGxvY2F0aW9uOyB0
aGV5IGFyZSBqdXN0IGluaXRpYWxpemF0aW9uIGZ1bmN0aW9ucyBub3cgdGhhdCBhbGxvY2F0aW9u
IGhhcw0KPiBiZWVuIHRha2VuIHRvIHRoZSBMU00gZnJhbWV3b3JrLCBzbyBwb3NzaWJseSBjb3Vs
ZCBiZSByZW5hbWVkIGFuZCBtYWRlIHRvIHJldHVybg0KPiB2b2lkIGF0IHNvbWUgcG9pbnQuDQo+
IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSHVhaXNoZW5nIFllIDx5ZWhzMUBsZW5vdm8uY29t
Pg0KPiANCj4gQWNrZWQtYnk6IFN0ZXBoZW4gU21hbGxleSA8c2RzQHR5Y2hvLm5zYS5nb3Y+DQoN
Ck1hbnkgdGhhbmtzIGZvciB0aGUgQWNrZWQtYnkuDQoNClllcywgeW91IGFyZSByaWdodCwgc2Vs
aW51eF9tc2dfbXNnX2FsbG9jX3NlY3VyaXR5IG9ubHkgY2FuIHJldHVybiAwIGluIGFueSBjYXNl
Lg0KSSB0aGluayB0aGF0IHNob3VsZCBiZSBtb2RpZmllZCB0byB2b2lkIGluc3RlYWQgb2YgaW50
Lg0KDQpBbmQgYWxzbywgdGhlIGZhY3QgaXMgbm8gbW9kdWxlIG5lZWRzIHRvIGltcGxlbWVudCBt
c2dfbXNnX2ZyZWVfc2VjdXJpdHksIGJlY2F1c2UNCkxTTSB3b3VsZCB0YWtlIHRoZSByZXNwb25z
aWJpbGl0eSBmb3IgZnJlZWluZyBtc2ctPnNlY3VyaXR5Lg0KSSB0aGluayB3ZSBjb3VsZCBkZWxl
dGUgdGhlIGhvb2sgY2FsbCBvZiBtc2dfbXNnX2ZyZWVfc2VjdXJpdHksIGJ1dCBJIGFtIGNhdXRp
b3VzDQp0byBtb2RpZnkgdGhlIGV4aXN0aW5nIGludGVyZmFjZXMsIHRoYXQganVzdCB3b3JyeSB0
byBicmVhayB0cmFkaXRpb25hbCBydWxlcy4NCg0KQ2hlZXJzLA0KSHVhaXNoZW5nIFllDQpMZW5v
dm8NCg0K
