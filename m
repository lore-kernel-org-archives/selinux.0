Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92694C33CAD
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9502084D
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 15:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="v/02O3OR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAMPAT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:00:19 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.6]:40431 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728512AbgAMPAS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 10:00:18 -0500
Received: from [67.219.246.102] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.us-east-1.aws.symcld.net id 2A/E5-07075-0068C1E5; Mon, 13 Jan 2020 15:00:16 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTfUwbZRjnvbu2V+yRo4XwgsC0kxnQdrSO5KJ
  k0phpXTRs6zSsmroyOlpXSumVSTFOEjfH+IikCgiBQAabhm6wkcFYYXN2jMo2VgSDsmZBPkS6
  OWV2QlaEedfLUP/7fTzv73neN8+Lo+IAPwE3lNgNNoveLOVHYsaFaUL26EiiLr13UE4dmx5Bq
  c6uNoQadzfxqcWqGT7ld9Zj1JX+NpTyeYcElG/0poAauFqOZgnVE/171FXL+9Qjf2nVpy8uAH
  VP/SOeOtidrPZNrQl2CLQ8kyW3sGQvz9hxewCx3haUVA+X88vAqKACROJisgyBri4XxpE7ANZ
  4p9F1p22+k8eRFQCv93rCZwB5AoX9zlqMI0MYdAd/BBw5A2BlKBgmGNmPwtrrDUyakAmoQeDc
  ipULmwLw24YbfNbgk6lw+LeJcMsY8icAnd2Xwi1RsgqBo5eaMbZKQu6CrRc7eCyOITXwQv+qg
  MNKeOP8ImAxRqbA6tBnjI7jBPkuXF76iOtshn2ts+EYIamCPaGz4XJAJsG6mSmExSgZB5vrGs
  PxkCRh+4AP5XAsDMyu8dhIwIzw+zkdJ2+ENz2nEA4nwbGWSsDhN+GRxe8wDqdB96cBPnsUks/
  ANY+Dkw/AM7cWEE5OgaddBTVA0fifGRoZB2Uepcu9mZOfhl9UTgtYTJDRcLhhDmsFWAfIyLWZ
  8o32Ar3JLFOkp8sUCqVMKduyRa4vleXKi2mZQU/bZQq5/gNaTjsK9pnz5BaDvRsw+5ZnRZ7vA
  38/uCf3gHgckcYSE289qRNH5RbmOYx62vierdhsoD0gEcelkDj4SaJOHG0z5BtK9pvMzNY+ti
  EuksYQGYcZm6Ct+gLalM9Z18ALeE2g+TiKDzafOI6KMUuhxZAQR0QzKy4m2VJjsWU96PEPGAN
  JCRICREREiEVWg63AZP+/fwfE4UAqIXayKSKTxb7ej9la5hYxROR4PDuKXf+vlVCG1K1+07mh
  umJJU/0w8I5NGdUkqY/Q3GoX8ttVOcsdg+UDqo9Ls++u/PHwNfLQSLn5amUIoWa9u3vKjk4W5
  7dd6/06NdQefeX+s9qfxZEHNxlXt39epEl2Hq0qPSS0q9ze4tWtd4sydjs2pbk/fDlQ3e4/1Q
  W/v9yyvy7zCSTGllqfszlFGaudrBU5Lr+4I/j26/QenmnM+dQv25JU2rrsUv/MSb9ENnlveu7
  YeaErQdG58f6SZNtg8nhFpnvIu9M5odW8sXXMOOR3/Fr0iu5clmi0z/eSujA+v8+pzBQ9+GE7
  Cr7aoPnyz72uDmlOVmWL9+x88PCFqAPzTc+9b515NXt4UYrRRr0iDbXR+n8A2y8SZ3wEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-21.tower-386.messagelabs.com!1578927615!1802625!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21818 invoked from network); 13 Jan 2020 15:00:15 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-21.tower-386.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 13 Jan 2020 15:00:15 -0000
Received: from HKGWPEMAIL03.lenovo.com (unknown [10.128.3.71])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 6166790A4872B86E27ED;
        Mon, 13 Jan 2020 10:00:13 -0500 (EST)
Received: from HKGWPEMAIL01.lenovo.com (10.128.3.69) by
 HKGWPEMAIL03.lenovo.com (10.128.3.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1779.2; Mon, 13 Jan 2020 23:00:08 +0800
Received: from HKEXEDGE02.lenovo.com (10.128.62.72) by HKGWPEMAIL01.lenovo.com
 (10.128.3.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1779.2 via Frontend
 Transport; Mon, 13 Jan 2020 23:00:11 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (104.47.126.54)
 by mail.lenovo.com (10.128.62.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1779.2; Mon, 13 Jan
 2020 23:00:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1l5EBuOTxZbA6RRuK9mWlBYnfttbGCPtU4xk1oOG4EiQxmTgHto9OmS+QYm9C/AH9u9dp5hbSZ02s5BR81QIMVWnpbmfzRhjMKBnqGk0ybWAK3LPuzKLqz3yslsoaoIj6aL6ipLUvhg5dSZ/Y2ytTQiHeGcSlGozmRxiD7eKRvQHQAKO7dFbZUY5muTkbHKcMC+vo4Lm892bz9Z8azJ8o8OB/qI590WFL7tJlTU70+509z/xpC5GjW5lZk01KsOg6TROZYTKHd9xzwNEHDRMGqtZf7xH0fS8Fb9ID608mWzO6ncdvfnY50G8QjRuAKUSUa9gNus4a7piIMd7PoyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixYcvQ+ybrbOG4bM1OU1/hqFcCje5r9U2pXk0xJS/Mc=;
 b=ZzCJRwvUfAQLLxmGORYK4ZLgP/MEGUQXWAvWHhjKY/no/HfRUybOaRLYgpCRNSYx2F3tdSsqWJiZ7rKq4uXmIlkaiMBPySN0p7CuqdIhBx7k3RCRJMuuaWhGRwanRcoZm9ufHMjug3lVC+NaQ/uKtsjOSrJjdXLpXiXrHsv8qRhoQmVv1RIl0GhkqaZ3bqeQv3LBQ+dYAbJqOxKnIWhiQLvaZTYi5wswCh8Mr+Ixs8XC7h/fdZsBIrupWD4hccz7GMNs06E1GS8RYZj2GHC9yq5YU9rOGHOb0Ef233pVKcy41aVHDVIjnoOx9/8R7SQ79nFAu0UQch+ElX+2FILvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixYcvQ+ybrbOG4bM1OU1/hqFcCje5r9U2pXk0xJS/Mc=;
 b=v/02O3ORNvRvLHSgfdzBctI9NId4kAJhWbfD7YFRDhLwbSZraRT3uwzXGocuhTVs1aRIiXYqHd3yzR1WulZzCpeu53nJpun8cjgRuRMTW8bqyngztx1ABaaJA1jQUz4NKkMX5fD1r8ml7NeBnMJs1TyJC6VpE3JyMNyUVu5CwKg=
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com (10.170.158.23) by
 HK2PR03MB4563.apcprd03.prod.outlook.com (10.170.158.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.8; Mon, 13 Jan 2020 15:00:06 +0000
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::99e2:67f9:507e:35a4]) by HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::99e2:67f9:507e:35a4%4]) with mapi id 15.20.2644.015; Mon, 13 Jan 2020
 15:00:06 +0000
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
Subject: RE: [External]  Re: [PATCH] selinux: remove redundant
 selinux_nlmsg_perm
Thread-Topic: [External]  Re: [PATCH] selinux: remove redundant
 selinux_nlmsg_perm
Thread-Index: AQHVyhfqa7vURHm83kmn561ZnK9rJqforBLA
Date:   Mon, 13 Jan 2020 15:00:06 +0000
Message-ID: <HK2PR03MB4418B5D2AB089629A1FFC8AF92350@HK2PR03MB4418.apcprd03.prod.outlook.com>
References: <20200112154216.46992-1-yehs2007@zoho.com>
 <e7ec908e-01c1-b76d-f797-545b70a49075@tycho.nsa.gov>
In-Reply-To: <e7ec908e-01c1-b76d-f797-545b70a49075@tycho.nsa.gov>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.197.254.155]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff409fd2-bb48-4b26-3186-08d7983946cc
x-ms-traffictypediagnostic: HK2PR03MB4563:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR03MB4563901E09BB2172F3D8AF6092350@HK2PR03MB4563.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(366004)(396003)(346002)(189003)(199004)(26005)(86362001)(186003)(53546011)(6506007)(71200400001)(110136005)(316002)(54906003)(9686003)(2906002)(7696005)(55016002)(33656002)(8676002)(81156014)(81166006)(66946007)(66476007)(66446008)(66556008)(64756008)(4744005)(8936002)(52536014)(4326008)(76116006)(478600001)(5660300002)(13296004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB4563;H:HK2PR03MB4418.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3/ZKZ9KDs93l3L61LBCmq8DXm26Suodg+cNDbFeEJldo12xatBq2FXGKYoHCFAYMW1sKtzFmWBCCcuoEVnWhSCXLuVYrPExpc+P7lqas6bBnYpweqArheAQGQl+JLZe5bA/r4PmmgIZvrc+RZa11hKj1SyO5p6gVlRJhfzRoz+LRceL0cOMn3Tgv0AuV9SFhCxNQCm/7GpvxVgTztCQKFSmg8xj7cUiTO3vQ3xkbKtrqXKeRKCCu+byMlSOEdRUwV2RrbIxd6pv+6vo0wXQyNDsCg8WWYx78ZpgcEBgH/o66Z4HaI4baiwPSi0kezQQ8rZoO4Kun6t550IYqXhIFGlkYA5sbrmTR0MoorhdZz2d/dicscCT5b7UpaKI55IkmT3xKzCPa443Ke4/iKQuYQexW66iWvRH16Q9LS/Us+9kJ7QkIz/+WnzZ11WPbjCXKaNgM0MJtSnx9E9sjhJ7D/R+OaDxcVgCsuyi6k9QQNR8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ff409fd2-bb48-4b26-3186-08d7983946cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 15:00:06.2270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/N8P+Xult4idYfj8BjGMyCd+exUDq48eQRy8a8BSXWPTmCAILtUhA19DNpAoCZZ6BKVPYjbhTF18/HtGcV52w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB4563
X-OriginatorOrg: lenovo.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZXBoZW4gU21hbGxleSA8
c2RzQHR5Y2hvLm5zYS5nb3Y+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxMywgMjAyMCA5OjQ3
IFBNDQo+IA0KPiBPbiAxLzEyLzIwIDEwOjQyIEFNLCBIdWFpc2hlbmcgWWUgd3JvdGU6DQo+ID4g
RnJvbTogSHVhaXNoZW5nIFllIDx5ZWhzMUBsZW5vdm8uY29tPg0KPiA+DQo+ID4gc2VsaW51eF9u
bG1zZ19wZXJtIGlzIHVzZWQgZm9yIG9ubHkgYnkgc2VsaW51eF9uZXRsaW5rX3NlbmQuIFJlbW92
ZQ0KPiA+IHRoZSByZWR1bmRhbnQgZnVuY3Rpb24gdG8gc2ltcGxpZnkgdGhlIGNvZGUuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBIdWFpc2hlbmcgWWUgPHllaHMxQGxlbm92by5jb20+DQo+IA0K
PiBUaGUgcGF0Y2ggaXRzZWxmIHNlZW1zIGZpbmUgYnV0IGl0IGxvb2tzIGxpa2Ugc29tZW9uZSBh
Y2NpZGVudGFsbHkgcHV0IHBpZz0gaW4NCj4gdGhlIGxvZyBtZXNzYWdlIHdoZW4gdGhleSBtZWFu
dCBwaWQ9OyB0aGF0IGNhbiBiZSBmaXhlZCB2aWEgYSBzZXBhcmF0ZSBwYXRjaC4NCj4gDQo+IEFj
a2VkLWJ5OiBTdGVwaGVuIFNtYWxsZXkgPHNkc0B0eWNoby5uc2EuZ292Pg0KDQpUaGFua3MgZm9y
IHRoZSBBY2tlZC1ieS4NCkFoYSwgeWVzIGl0IGlzLiBJIHdpbGwgb2ZmZXIgdGhlIHBhdGNoIHYy
IHRvIGZpeCB0aGlzIHR5cG8uDQoNCkNoZWVycywNCkh1YWlzaGVuZyBZZQ0KDQo=
