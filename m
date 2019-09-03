Return-Path: <SRS0=4h59=W6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F70C3A5A2
	for <selinux@archiver.kernel.org>; Tue,  3 Sep 2019 14:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5C223697
	for <selinux@archiver.kernel.org>; Tue,  3 Sep 2019 14:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Q4Pl4MGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfICOaz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:30:55 -0400
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:52453
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729507AbfICOay (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 3 Sep 2019 10:30:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4SXdVRtA7klOY2czjUpxPCLjvLPCGY8xB71UTHVxHGCJjeSo4MiqDGcuF5o/onkG5muk7tfiU0eeCPK/MmJDXIAU9ZGog/eANA0oaTlsg9XS2YNUeksd8EDy42HJcTqnJZVvGrlId93X1UFsKANunLQRhO+RJY1mOmVreZwFpYQpi5WmRAIDw/A3CWhypU1N3QRApNuopX02I90dF3A75Ng8I7g926JjyObXWfwNNlJT+0cIxUQQ7gnMLp71kI28saiS20c7//8bmx3vgXcrByr15yMeLhHo0qJzy9RmjzPBXPzVtgb9UId43Rw++dHMCXQLvfs57EiKb3yCWjrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR6TNfIW+JiBF8OuuWg5tGUzkJnA3BkuoL8Mk8oDfCs=;
 b=gHeHbB8RBcP4AxMgqxA4DYkT2ntVIm01FXKo4GW/OMfShUhlBrx4qGq7VPg5Pi1NTq3TTy9CL3KpwO9S1yBZlscSRl9yRWawzr3qPNKq51j9L/ozC8z+oN+5RcJjviMH/D4hSoUppNJveJ6qgtqPIexxq925RYp4jioEOcx89Ywk7hQRrFB7nhlEN+lskIiE3vHrjoPaxzetcHR+sia3kWKEtabE12j7uYQqhbROLPgHsuEDr55v5a7CNByuZWVsJrt1PhHmPTnx9qkr3PystGMDKZmWytxwKLDkF213FlKpfjkFCMgKMzYHJzEEAQCw3Xo/8GQJMi/uwyGz4GMOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR6TNfIW+JiBF8OuuWg5tGUzkJnA3BkuoL8Mk8oDfCs=;
 b=Q4Pl4MGJstZqfbOfsW4GIzFya45kFDI8Xw2P4nPhTws2g1Rn5MzFS8BK+ZN8hcqm6mW2JebpCRWMdgg++UScE80o9GP7Vk/dAICdBeUZLuPjwbG3lEYIJNlr8MDplzXYQ2/HU7p6tqm8t8mJnJWN7aw+ulsLm7PzHK175w/FC/A=
Received: from AM0PR05MB5730.eurprd05.prod.outlook.com (20.178.115.152) by
 AM0PR05MB6035.eurprd05.prod.outlook.com (20.178.118.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Tue, 3 Sep 2019 14:30:51 +0000
Received: from AM0PR05MB5730.eurprd05.prod.outlook.com
 ([fe80::6d25:e52d:9387:610b]) by AM0PR05MB5730.eurprd05.prod.outlook.com
 ([fe80::6d25:e52d:9387:610b%6]) with mapi id 15.20.2220.020; Tue, 3 Sep 2019
 14:30:51 +0000
From:   Daniel Jurgens <danielj@mellanox.com>
To:     Paul Moore <paul@paul-moore.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "selinux-refpolicy@vger.kernel.org" 
        <selinux-refpolicy@vger.kernel.org>,
        Lukas Vrabec <lvrabec@redhat.com>,
        Chris PeBenito <pebenito@ieee.org>
Subject: Re: IB pkey policy problem found via the selinux-testsuite
Thread-Topic: IB pkey policy problem found via the selinux-testsuite
Thread-Index: AQHUw+QHP/kF8OXp6EiIBrvTCkmHXaX12c6AgRqW/ICACs/CAA==
Date:   Tue, 3 Sep 2019 14:30:49 +0000
Message-ID: <5817f158-9ba2-420d-3a9e-59ee43be3472@mellanox.com>
References: <CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsdbgxSL1v04mouWw@mail.gmail.com>
 <CAHC9VhR1ZNyZqGB3Si-z77zLwaTBf-pkQk19rVqofs4P_oVtFg@mail.gmail.com>
 <CAHC9VhSKxgCB_j-eT65tSvqFDbBe_Wu_b+XsvN0Si2eDrEROMQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSKxgCB_j-eT65tSvqFDbBe_Wu_b+XsvN0Si2eDrEROMQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0073.namprd05.prod.outlook.com
 (2603:10b6:803:22::11) To AM0PR05MB5730.eurprd05.prod.outlook.com
 (2603:10a6:208:11d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=danielj@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77dccc16-c538-425a-7180-08d7307b5089
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB6035;
x-ms-traffictypediagnostic: AM0PR05MB6035:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR05MB6035C2B90DFB472885048794C4B90@AM0PR05MB6035.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(53754006)(199004)(189003)(25786009)(110136005)(14454004)(6436002)(66946007)(14444005)(256004)(53936002)(186003)(316002)(66446008)(6506007)(5660300002)(53546011)(386003)(71200400001)(11346002)(64756008)(102836004)(71190400001)(26005)(476003)(66476007)(2616005)(6512007)(446003)(76176011)(66556008)(486006)(6246003)(3846002)(229853002)(305945005)(478600001)(6486002)(8676002)(81166006)(81156014)(2501003)(7736002)(99286004)(2906002)(8936002)(31696002)(2201001)(15974865002)(86362001)(66066001)(52116002)(36756003)(31686004)(6116002)(18886075002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6035;H:AM0PR05MB5730.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m1jj676g7oN669jgftJnJf3nFCW8nYAJ33ATcu8BL5p/QqXRtnVquwJcWLGhpvdainDNcjAskm2ro+UoDwsVMpJxuk/QgdeawIG3EZhSuLE2v7xm21ZeoRh9IBR3EzJBMzIwc7AOJXrlhQyZxf/fq9R0pwuz6lUFb90v01Jo6fgvvPwCKAFKkr73kXt3TKB4WkZ3RahaAuZA+yziUovurtEgk5kInJ+bnbjj3dnLo/ZEtD4aT4CAeb5GV0oK+pmpbLTXDQeBV6bHIcuqFWdCYzk6H1CIoROzrNnzwqXTw0XxcrHS8dHK4nn4TJs8SVs1nZVpos8YlozLU/mrV9GBGE/2mzBeE57ywv4q/7q6/ymVkiSFWBSf8v79gkzIbRffbbbOgqqmn6QYlhZ9z5Ll4j8dEWYCJoFjCjHYp1ihibw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A9D07847F3DEA41AB89A128E4235C03@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dccc16-c538-425a-7180-08d7307b5089
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 14:30:51.3694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1PYzhAZxI1ZjlO6c+ABZcCTypA8G03/gsyOZ0sdW6W2m3cIWXKiN3xxdgZfsVv9UyOQWzmSXCJ1EIbK4H9alw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6035
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQpPbiA4LzI3LzIwMTkgMTI6MjQgUE0sIFBhdWwgTW9vcmUgd3JvdGU6DQo+IE9uIFRodSwgRmVi
IDI4LCAyMDE5IGF0IDQ6NTggUE0gUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4gd3Jv
dGU6DQo+PiBPbiBXZWQsIEZlYiAxMywgMjAxOSBhdCA0OjM1IFBNIFBhdWwgTW9vcmUgPHBhdWxA
cGF1bC1tb29yZS5jb20+IHdyb3RlOg0KPj4+IEhlbGxvIGFsbCwNCj4+Pg0KPj4+IE9uIGEgZnVs
bHkgdXAtdG8tZGF0ZSBSYXdoaWRlIHN5c3RlbSB5b3UgbmVlZCB0aGUgZm9sbG93aW5nIGxpbmUg
YWRkZWQNCj4+PiB0byB0aGUgcG9saWN5L3Rlc3RfaWJwa2V5LnRlIGZpbGUgdG8gZ2V0IGEgY2xl
YW4gcnVuIG9mIHRoZQ0KPj4+IHNlbGludXgtdGVzdHN1aXRlOg0KPj4+DQo+Pj4gICBhbGxvdyB0
ZXN0X2licGtleV9hY2Nlc3NfdCBzZWxmOmNhcGFiaWxpdHkgeyBpcGNfbG9jayB9Ow0KPj4+DQo+
Pj4gVGhlIGJyZWFrYWdlIGRvZXNuJ3QgYXBwZWFyIHRvIGJlIGR1ZSB0byBhIGtlcm5lbCBjaGFu
Z2UgKHByZXZpb3VzbHkNCj4+PiB3b3JraW5nIGtlcm5lbHMgbm93IGZhaWwpLCBvciBhIEZlZG9y
YSBSYXdoaWRlIHBvbGljeSBjaGFuZ2UgKG5vdGhpbmcNCj4+PiByZWxldmFudCBjaGFuZ2VkIHNp
bmNlIHRoZSBsYXN0IGNsZWFuIHJ1biksIGJ1dCBJIGRpZCBub3RpY2UgdGhhdCBteQ0KPj4+IGxp
YmlidmVyYnMgcGFja2FnZSB3YXMgdXBkYXRlZCBqdXN0IHByaW9yIHRvIHRoZSBicmVha2FnZS4g
IEkgaGF2ZW4ndA0KPj4+IGhhZCB0aGUgdGltZSB0byBkaWcgaW50byB0aGUgbGlicmFyeSBjb2Rl
LCBidXQgSSBleHBlY3QgdGhhdCB0byBiZSB0aGUNCj4+PiBzb3VyY2Ugb2YgdGhlIHByb2JsZW0u
DQo+PiBKdXN0IHRvIGJlIGNsZWFyLCBJIGRvbid0IGJlbGlldmUgdGhpcyBicmVha2FnZSBpcyBs
aW1pdGVkIHRvIHRoZSB0ZXN0DQo+PiBzdWl0ZSwgSSBleHBlY3QgYW55IHVzZXJzIG9mIHRoZSBT
RUxpbnV4IElCIGhvb2tzIHdpbGwgcnVuIGludG8gdGhpcw0KPj4gcHJvYmxlbS4gIEkgYmVsaWV2
ZSB3ZSBuZWVkIHRvIHVwZGF0ZSB0aGUgdXBzdHJlYW0gYW5kIGRpc3Rybw0KPj4gcG9saWNpZXMu
DQo+IEEgcGluZyB0byBicmluZyB0aGlzIGlzc3VlIGJhY2sgdG8gdGhlIHRvcCBvZiB0aGUgbWFp
bGluZyBsaXN0Lg0KDQpIaSBQYXVsLCBJIGxvb2tlZCBpbiB0aGUgbGlicmFyaWVzIGFuZCBkb24n
dCBzZWUgZXhwbGljaXQgdXNlIG9mIG1sb2NrLiBNYXliZSB0aGVyZSB3YXMgYSBjaGFuZ2UgdG8g
dXNlIHRoYXQgYWNjZXNzIGNvbnRyb2wgZm9yIGdldF91c2VyX3BhZ2VzPyBUaGF0IGRvZXNuJ3Qg
cmVhbGx5IGppdmUgd2l0aCBwcmV2aW91c2x5IHdvcmtpbmcga2VybmVscyBubyBsb25nZXIgd29y
a2luZyB0aG91Z2guDQoNCg0KPiAtLQ0KPiBwYXVsIG1vb3JlDQo+IHd3dy5wYXVsLW1vb3JlLmNv
bQ0K
