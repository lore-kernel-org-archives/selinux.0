Return-Path: <SRS0=L9QR=3B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0631C33CA2
	for <selinux@archiver.kernel.org>; Sun, 12 Jan 2020 15:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DED21556
	for <selinux@archiver.kernel.org>; Sun, 12 Jan 2020 15:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="hOc4pwV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733064AbgALPpu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Jan 2020 10:45:50 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.3]:47576 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733062AbgALPpu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Jan 2020 10:45:50 -0500
Received: from [67.219.250.102] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.us-west-2.aws.symcld.net id 25/D6-12405-82F3B1E5; Sun, 12 Jan 2020 15:45:44 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTf0wTdxzl22t7V0bZUUr4ijKzGyMbWTtaoru
  BsiVbTM0w6gTNiKlcobaNbWl6JZSZaYlL/IEujDCBAnXTQQ2D4ZiMBSREpDAgLRMmYYPJD0kA
  R0GtFYcb7q6Hbvvr3vu+d+/7eZfPYYjkD2EcprXbtFYzZSSE4Xz9/HSE7LV3NqqTXT8R5OlpL
  0J+23yJR4601wjJe2dnhOR4WQWfvNFxCSGH+npRcuhnH0pe85xC3hWpRjs+Up1dyVV5g9mqps
  55oGqteCpQBVpeUg1NrqF70GyBwazJt+cI9OWBYtSyGmUfGfMIHWAi6gwIxyS4gwfrvilBOXI
  XwKUql5AjxTx45furjCJiyBMAf3DtYjHA6xDYsWRjTQDv5UPf1HcIR64AWLIaACzh4x0IdK98
  sZ5VyoOLgR7AkUkAG042ATZMiL8O+xdHERZL8Z1wfPSvUBaCr/DgubGb/DMAw6Lx/fDhZ0c4z
  wFYXvLruj8VVs11hzAffxUGXbOhTDF+EA42XxZwl7UAON1zK9RChO+F/okSHtciHp6fmQxhBI
  +FteedAhZDHIdfXxtCOBwDF+6sCdgZAP4hXLqqZiHECeiby+Ic8XD4Qgng8C5YXjO+jpNg8y9
  uIWdPgGvdRdzxEdj32IFyOBGOLZ5CSoHC+Z8ZnMwbCPNRmtvf5I5fZvpOo85QryjYXzXL/xLw
  GwCpsRp0epuJMhhliuRkmUKhlClSFMwzWU59LKPkBbSsUEvbZEo5VUjL6SJTrjFPbtbaWgCzc
  XmWE+YfwZOgX94NNmA8IkYsUseqJZGa/LwiPUXrD1kLjFq6G2zCMAKKW9M2qiVRVq1Oaz9sMD
  J7+0yGWAQhFa9uZ2QxbaFMtEHHSQMgBStdqL2IYD21dRcRCd+cb9bGxYpbWSvOWvUF5udBz/6
  BYRAfFy0GYWFhkgiL1moy2P6v3wWxGCCixa+kMykRBrPt+X3M3jItpOLwkQ3sKDbqXynOwZNH
  5qUlLJc+LdN8Ve2+I/x7X4PjLSro88U0KI/OvG89XJH559Qm10jrxGb/obY2w6OclUzCOLu7v
  XhgZ78mffSFYb/Ke7vs0Sf1OQ8GrzdWfi66Uf7p476jBmLrvdtpgy1utHcx9fpym3naGb4t0e
  HtMi1UBj174MlAFxq//cKtzAxPRpP+g4PyamnCifcS1J3SJHt7OnLsxUD2xA7dZd65gZRAeVX
  lG5l0XFduj6VRv1v3drF0/4HxiHpPzT6lv09Eb5Zm0Z39bmUw1Xuc7Jp50Dq/42bTctHc5N6M
  yLbK01uqjyunGrc9HPn9vnOroHBKEOZDs+rhb8fi729J9EwSfFpPKZIQK039A/AJ2lZ+BAAA
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-33.tower-326.messagelabs.com!1578843943!180301!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5993 invoked from network); 12 Jan 2020 15:45:44 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-33.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Jan 2020 15:45:44 -0000
Received: from HKGWPEMAIL03.lenovo.com (unknown [10.128.3.71])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 81920F740C1B8464CA9B;
        Sun, 12 Jan 2020 10:45:41 -0500 (EST)
Received: from HKGWPEMAIL03.lenovo.com (10.128.3.71) by
 HKGWPEMAIL03.lenovo.com (10.128.3.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1779.2; Sun, 12 Jan 2020 23:45:36 +0800
Received: from HKGWPEXCH02.lenovo.com (10.128.62.31) by
 HKGWPEMAIL03.lenovo.com (10.128.3.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1779.2
 via Frontend Transport; Sun, 12 Jan 2020 23:45:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.125.57)
 by mail.lenovo.com (10.128.62.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1779.2; Sun, 12 Jan
 2020 23:45:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1mXfR0G1Z8WpZXzbJEPbsTTV+Vuqz7Vfu2f9B2sq0QBKdq6FlRXZWfEpSkaBKw7sPLbURkVwEPKb6jfoWfghvg9yrlq54ZQlApTVH5L8aO0GyAbodGauD9S+gd3Jee0cqRsY66ALJ+QRks/AS+WGFBxZIXMpWz3d8jnN5vXQMXicL6is5/bGN5CkJHHI+2HIJzPuu2ZgwkpBNRyqug4EqBUTbOCh72AR+tq/Z2PQBsIwdJw3+VA+L1gA7MvFLv6vyPoT/PcrRtGvlJAyF3sKh5eiRaaFR73QhsjANLo7W9nbHshermBdjeSuD+9Ust2uKMI7GPYv4adklYAKNbBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwk4t3dUP8vqJN6ltteEd/5IeTBtpCC+WDpfyam7G4w=;
 b=a1v72NpnN+AXmEgMEbbP8R6UE7MNF1z/yA7zE/6F54wBoCwxwb+7FtHvskUcjPjkSZn6iwZQVqlBu3W67QLFvWSOBn6f7wCQIN/JdM60lZWT3FF1AFarFseuMYBZxXNMGjHnIS3BpM5aOpe0o2Wj+ttkmF0zmdz7SxvhfGWXjTbx5FdfQQT491RohoSC95rfmsZetnzh2ewcOBpiJqtUBc5beKh6W1uADhBXKtpyki7G8M0zoIIXOBecD3cruxJpu9kKIsY61pir87PDthVPpe791gElcnKCWlWa9KqfttHN4gsXikmQKkH78h5oX6iiU65/FycuYVbQ5Sn3qI/40g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwk4t3dUP8vqJN6ltteEd/5IeTBtpCC+WDpfyam7G4w=;
 b=hOc4pwV/0Je+HGpSPKWoBtpeE3EQ/5bb8f9WcMzG2u4MBdHiErb5tr3btrQylFAidsk+5L6aeP5sTC7FEJ4v8XpeansuCezWjxedGPiXVkR3ZUiehWHoRgTM3zS2brTK2Sk4t2PGdJuzbSWHvHnxIUb6EZw54kgod6M4vYIECMs=
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com (10.170.158.23) by
 HK2PR03MB4339.apcprd03.prod.outlook.com (10.170.158.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.10; Sun, 12 Jan 2020 15:45:37 +0000
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::99e2:67f9:507e:35a4]) by HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::99e2:67f9:507e:35a4%4]) with mapi id 15.20.2644.015; Sun, 12 Jan 2020
 15:45:37 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
CC:     Huaisheng Ye <yehs2007@zoho.com>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        "Tzu ting Yu1" <tyu1@lenovo.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External]  Re: [PATCH] selinux: remove redundant
 msg_msg_alloc_security
Thread-Topic: [External]  Re: [PATCH] selinux: remove redundant
 msg_msg_alloc_security
Thread-Index: AQHVx8iSgzluGOOK0EiHsOluBBLrM6fkHIUAgAMR9eA=
Date:   Sun, 12 Jan 2020 15:45:37 +0000
Message-ID: <HK2PR03MB4418F8333938ECB1920F813D923A0@HK2PR03MB4418.apcprd03.prod.outlook.com>
References: <20200110095856.76612-1-yehs2007@zoho.com>
 <e71932ce-0687-02e5-5f34-980c0cad4ae9@tycho.nsa.gov>
 <CAHC9VhT-8R4iT-V-A+6NvZgG=bh4Knieif2fuKwybnDuXvC6ug@mail.gmail.com>
In-Reply-To: <CAHC9VhT-8R4iT-V-A+6NvZgG=bh4Knieif2fuKwybnDuXvC6ug@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.59.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4e9c6fa-30fa-4933-7095-08d797767861
x-ms-traffictypediagnostic: HK2PR03MB4339:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR03MB4339BE7AF0774F8E9C816B3D923A0@HK2PR03MB4339.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02801ACE41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39850400004)(199004)(189003)(8936002)(8676002)(81166006)(81156014)(316002)(9686003)(55016002)(4326008)(66556008)(64756008)(66446008)(66946007)(66476007)(76116006)(86362001)(5660300002)(52536014)(6506007)(53546011)(2906002)(33656002)(71200400001)(478600001)(54906003)(110136005)(7696005)(26005)(186003)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB4339;H:HK2PR03MB4418.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6JQFZKtMtCyd6YmqzjmeBaq7ksrKA/z0oYyMVPrZwqdLFAU10g2bUaxNsHje5uRFuI1W/mSPvTUZf8vO26Q7Mmf7ZaHWO8pcohZKXvmItot/tR2lREAQ3eO5Ofm91mdqurb7IA93VDTYc+nrbKgwFY9xHdl3dXLdsaeJXKfHSEEznzj8oYj66ZYjnM6l4uix9ajllQ1LacFqecBPaMA7F6rGYAzP3fW81ha42Y6QEa549KVwUaUZqOqFnh5IYM26KnlTEcxd0zfNIN2UxcodDbPm3J1TTGvvgjkGs41ZBdIIWztoO/1lzTOEY1P0CVbLpWg+y+TAX3O5Fu5qTPRQ5cVb5pAwyM/X+G0K76Ia0IkNSj1HqfRMWSG8xCHHhWYG7mYZrgZcRCsrwQYAtOf22S1AUdvGAntdZSL5NYerN5DfMaCwnIYtU233xrGrvbNI0tDFl1B+idFOtKfRPpLA+yMQuynXx+YV8t7o8jbHlcU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e9c6fa-30fa-4933-7095-08d797767861
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2020 15:45:37.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9910WOdZXcztAj6JbgCuZXTHMRpivbRKGhCgz4f3P1LSE0l3NxF29XYFNNmYMPmMx+sQ6zv5/qEtuo4zaT2/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB4339
X-OriginatorOrg: lenovo.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdWwgTW9vcmUgPHBhdWxA
cGF1bC1tb29yZS5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKYW51YXJ5IDExLCAyMDIwIDEyOjUw
IEFNDQo+IE9uIEZyaSwgSmFuIDEwLCAyMDIwIGF0IDEwOjEzIEFNIFN0ZXBoZW4gU21hbGxleSA8
c2RzQHR5Y2hvLm5zYS5nb3Y+IHdyb3RlOg0KPiA+IE9uIDEvMTAvMjAgNDo1OCBBTSwgSHVhaXNo
ZW5nIFllIHdyb3RlOg0KPiA+ID4gRnJvbTogSHVhaXNoZW5nIFllIDx5ZWhzMUBsZW5vdm8uY29t
Pg0KPiA+ID4NCj4gPiA+IHNlbGludXhfbXNnX21zZ19hbGxvY19zZWN1cml0eSBvbmx5IGNhbGxz
IG1zZ19tc2dfYWxsb2Nfc2VjdXJpdHkgYnV0DQo+ID4gPiBkbyBub3RoaW5nIGVsc2UuIEFuZCBh
bHNvIG1zZ19tc2dfYWxsb2Nfc2VjdXJpdHkgaXMganVzdCB1c2VkIGJ5IHRoZQ0KPiA+ID4gZm9y
bWVyLg0KPiA+ID4NCj4gPiA+IFJlbW92ZSB0aGUgcmVkdW5kYW50IGZ1bmN0aW9uIHRvIHNpbXBs
aWZ5IHRoZSBjb2RlLg0KPiA+DQo+ID4gVGhpcyBzZWVtcyB0byBhbHNvIGJlIHRydWUgb2Ygb3Ro
ZXIgX2FsbG9jX3NlY3VyaXR5IGZ1bmN0aW9ucywNCj4gPiBwcm9iYWJseSBkdWUgdG8gaGlzdG9y
aWNhbCByZWFzb25zLiAgRnVydGhlciwgYXQgbGVhc3Qgc29tZSBvZiB0aGVzZQ0KPiA+IGZ1bmN0
aW9ucyBubyBsb25nZXIgcGVyZm9ybSBhbnkgYWxsb2NhdGlvbjsgdGhleSBhcmUganVzdA0KPiA+
IGluaXRpYWxpemF0aW9uIGZ1bmN0aW9ucyBub3cgdGhhdCBhbGxvY2F0aW9uIGhhcyBiZWVuIHRh
a2VuIHRvIHRoZSBMU00NCj4gPiBmcmFtZXdvcmssIHNvIHBvc3NpYmx5IGNvdWxkIGJlIHJlbmFt
ZWQgYW5kIG1hZGUgdG8gcmV0dXJuIHZvaWQgYXQgc29tZSBwb2ludC4NCj4gDQo+IEkndmUgbm90
aWNlZCB0aGUgc2FtZSB0aGluZyBvbiBhIGZldyBvY2Nhc2lvbnMsIEkndmUganVzdCBuZXZlciBi
b3RoZXJlZCB0byBwdXQNCj4gdGhlIGZpeGVzIGludG8gYSBwYXRjaC4gIFdlIG1pZ2h0IGFzIHdl
bGwgZG8gdGhhdCBub3csIGF0IGxlYXN0IGZvciB0aGUgcmVkdW5kYW50DQo+IGNvZGUgYml0czsg
SSdsbCBsZWF2ZSB0aGUgcmV0dXJuIGNvZGUgaXNzdWUgZm9yIGFub3RoZXIgdGltZSBhcyB0aGF0
IHdvdWxkIGNyb3NzDQo+IExTTSBib3VuZGFyaWVzIGFuZCB0aGF0IHJlYWxseSBpc24ndCBhcHBy
b3ByaWF0ZSBpbiB0aGUgLXJjNSB0aW1lZnJhbWUgSU1ITy4NCj4gDQo+IEknbGwgcHV0IHNvbWV0
aGluZyB0b2dldGhlciBvbmNlIEkgZmluaXNoIHVwIHRoZSBwYXRjaC9yZXZpZXcgYmFja2xvZyBm
cm9tIHRoZQ0KPiBwYXN0IGZldyBkYXlzLiAgTG9va2luZyBxdWlja2x5IHdpdGggYSByZWdleCwg
aXQgd291bGQgYXBwZWFyIHRoYXQNCj4gaW5vZGVfYWxsb2Nfc2VjdXJpdHkoKSwgZmlsZV9hbGxv
Y19zZWN1cml0eSgpLCBhbmQNCj4gc3VwZXJibG9ja19hbGxvY19zZWN1cml0eSgpIGFyZSBhbGwg
Y2FuZGlkYXRlcy4gIFdoaWxlIG5vdCBhbiBhbGxvY2F0b3IsIHdlIGNhbg0KPiBwcm9iYWJseSBn
ZXQgcmlkIG9mIGlub2RlX2RvaW5pdCgpIGFzIHdlbGwuDQoNCkJlc2lkZXMsIGl0IGxvb2tzIGxp
a2Ugc2VsaW51eF9ubG1zZ19wZXJtIGlzIGNhbmRpZGF0ZSB0b28uDQpKdXN0IHNlbmQgYSBwYXRj
aCBmb3IgdGhpcyBmdW5jdGlvbi4NCg0KQ2hlZXJzLA0KSHVhaXNoZW5nIFllDQo=
