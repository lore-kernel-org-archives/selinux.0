Return-Path: <SRS0=7tXC=QF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D0DC169C4
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 17:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69251214DA
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 17:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="AX4wqsOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfA2RsU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:48:20 -0500
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:39753
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727492AbfA2RsU (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 29 Jan 2019 12:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP4kWoeO0sFUq1/yDdBRtToebykb5BpV1CqtN6ep/Mc=;
 b=AX4wqsOR0kwkHTLY2EQ+yhPdn+AymjuMzCp0tL9I35O9g6NblL25Eyb1pXUSteaAwzXH8gblPB3gySsyvnNeGUA92k6JAdl39VNvmq/rFbiEARMFouGZfIzJFfAGczpFwkQzu+Iv+y18dhM9ByL2fXVqVOsMXJcc6ZHzqb3uEj0=
Received: from AM0PR05MB5730.eurprd05.prod.outlook.com (20.178.115.152) by
 AM0PR05MB6529.eurprd05.prod.outlook.com (20.179.35.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 29 Jan 2019 17:48:13 +0000
Received: from AM0PR05MB5730.eurprd05.prod.outlook.com
 ([fe80::bdda:d0fc:7329:7322]) by AM0PR05MB5730.eurprd05.prod.outlook.com
 ([fe80::bdda:d0fc:7329:7322%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 17:48:13 +0000
From:   Daniel Jurgens <danielj@mellanox.com>
To:     Paul Moore <paul@paul-moore.com>, Don Dutile <ddutile@redhat.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM
 notifications
Thread-Topic: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM
 notifications
Thread-Index: AQHUthfGxQVMKr96QE+ydPBjEj2aBqXE4zsAgAAFqYCAAGZZAIAAQV4AgADz24CAAATvgA==
Date:   Tue, 29 Jan 2019 17:48:12 +0000
Message-ID: <1859ec04-d3d2-bffe-16ca-2ae602e5bbff@mellanox.com>
References: <20190127081023.21124-1-leon@kernel.org>
 <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com>
 <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
 <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com>
 <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR03CA0087.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::47) To AM0PR05MB5730.eurprd05.prod.outlook.com
 (2603:10a6:208:11d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=danielj@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR05MB6529;6:wcqJSU0BuxI++JdK9mz9NSt3acPPwNssnH90/nnOM19MRA0Wc40fysFD/uG27WXTNA1Y+Nu/69t36+B3ZZKYXDsEDZhb1k09k7084APc4BGnegB/qF7f3PIiYGs5l8CUvIMU4jG3BBGPcU1gyPeZe0x0fBqem5MAwh0guIxLgVfzVSgLULz1cKXFUPc/Xri+4pQWKl0klVfpZYJBDIQwCow6TxtzI4ReNkhOwogF2INdIv3xpP0zcz8ee9W7v+l6CyJdmEuwnHuLs7spOw4CgMlHHYPRb45lg9FleuvFUn9pehNOynoxu68r33CXMfQNJ4/8mHv7UQS5hrgELIDogZdbYdO9KV+Yj73TVvAVNJCSIN/bE5CbSVsSKvrobvkHHl1sLvILTOrziRwi90Gj+/Ft5axebyuGGZFjWTYW9s+qZK/eRexR2cg2XLD4lIvOnAYYK7FuMfU2Clmnz+dmjg==;5:6dfYOCPBTu2+x+1JyusvH3HZY5mXE9xHchoDLH3936JgROzJIPXG6ff7cIywyzJXDkytGY88ACmg5TcYLOpSFKflGj3ZsmEbhxldJzXfzXsfd7YtHYPJpV2pJvh2E6tNra1AHJWKiARErlTa+nVKo8Pj6vCNBvTvB1sGzsq+t6alKQ/l7x2kSMRK1dTqdDKseT4u4xYx7YPjJexjVfh/Rw==;7:vyP0PMcAsrkx7tO86Ovx7+RIKHdPUj6Wr5sbnYRwZPH/s279GWiXzvlDBvWgW5XoE4jiTQShcO1zdLaexEd50gq/inUvPXb7NO6bSJraq72zyL4d+tT0aYK5ZHBpexPG1YJduw0c41YnOWahqXzh4w==
x-ms-office365-filtering-correlation-id: e8f41a58-9736-4597-bba0-08d68611f05f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB6529;
x-ms-traffictypediagnostic: AM0PR05MB6529:
x-microsoft-antispam-prvs: <AM0PR05MB652927496A4AF28EB949DDE9C4970@AM0PR05MB6529.eurprd05.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(366004)(54094003)(52314003)(51444003)(189003)(199004)(53936002)(3846002)(6246003)(31696002)(36756003)(53546011)(52116002)(76176011)(6486002)(102836004)(14444005)(316002)(110136005)(54906003)(15650500001)(86362001)(256004)(386003)(486006)(446003)(11346002)(93886005)(478600001)(6436002)(6512007)(31686004)(106356001)(4326008)(229853002)(107886003)(105586002)(81166006)(8936002)(66066001)(25786009)(2906002)(2616005)(14454004)(97736004)(6506007)(305945005)(7736002)(476003)(26005)(8676002)(68736007)(71200400001)(81156014)(71190400001)(6116002)(186003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6529;H:AM0PR05MB5730.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S7SmDzZ6LH4aLtSeLy2k1SPIPz45bNrLWHA/vjnsGtIuyDSodMs20GEsZi10NC+OhztBJwalNInJ3VIZskMarUnBtA79kbPnV29yygzn61k1i6CYji2IsV/1+H7ZJLESnSmZQZFFMwO8S9SnZZjZ1/cpXWXCGAEVbWwjnX/CfaR+VWKjYZRMZzalZetTp3HKOO0HE/mVTr2Y6JXCzX65DBUjY/gGQQmFKD0+t3UxD23EuPd5M0+7UHbOj2tEUNHdFOPqkEExXaJEFf7iHqJFG60btZnDd4dx7FkUkyrwbBYYNuKcChxRhqfL4hcQ1RKGg869UiqCo8abFwPLzVZD0ViKYtfcHK7yCdiRwoqfUjFMRrzdqM6c4mTXlOxrXa1sUukc5d8U/keJi/v9PD3mEpm35P0UrXf6ROEwu6GAZTM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AD8C9A92A6C3948B5AF502D458115DF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f41a58-9736-4597-bba0-08d68611f05f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 17:48:11.1856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6529
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQpPbiAxLzI5LzIwMTkgMTE6MzAgQU0sIFBhdWwgTW9vcmUgd3JvdGU6DQo+IE9uIE1vbiwgSmFu
IDI4LCAyMDE5IGF0IDk6NTcgUE0gRG9uIER1dGlsZSA8ZGR1dGlsZUByZWRoYXQuY29tPiB3cm90
ZToNCj4+IE9uIDAxLzI4LzIwMTkgMDY6MDMgUE0sIFBhdWwgTW9vcmUgd3JvdGU6DQo+Pj4gT24g
TW9uLCBKYW4gMjgsIDIwMTkgYXQgMTE6NTcgQU0gRGFuaWVsIEp1cmdlbnMgPGRhbmllbGpAbWVs
bGFub3guY29tPiB3cm90ZToNCj4+Pj4gT24gMS8yOC8yMDE5IDEwOjM3IEFNLCBQYXVsIE1vb3Jl
IHdyb3RlOg0KPj4+Pj4gT24gU3VuLCBKYW4gMjcsIDIwMTkgYXQgMzoxMCBBTSBMZW9uIFJvbWFu
b3Zza3kgPGxlb25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+Pj4gRnJvbTogRGFuaWVsIEp1cmdl
bnMgPGRhbmllbGpAbWVsbGFub3guY29tPg0KPj4+Pj4+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICBk
cml2ZXJzL2luZmluaWJhbmQvY29yZS9zZWN1cml0eS5jIHwgMzQgKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+Pj4+Pj4gICBpbmNsdWRlL3JkbWEvaWJfbWFkLmggICAgICAgICAgICAg
IHwgIDMgLS0tDQo+Pj4+Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMzMg
ZGVsZXRpb25zKC0pDQo+Pj4+Pg0KPj4+IEknbSB0cnlpbmcgdG8gcXVpY2tseSB1bmRlcnN0YW5k
IHRoZSBNQUQgYWdlbnQgbGlmZWN5Y2xlLCBhbmQgaXQgbG9va3MNCj4+PiBsaWtlIHlvdSBoYXZl
IHlvdXIgb3duIHJlZ2lzdGVyL3VucmVnaXN0ZXIgcm91dGluZXMsIHdpdGggbG9ja2luZywgc28N
Cj4+PiBpcyBpdCByZWFzb25hYmxlIHRvIGFzc3VtZSB0aGF0IGl0IHdvdWxkIGJlIHBvc3NpYmxl
IHRvIGl0ZXJhdGUgb3Zlcg0KPj4+IHRoZSBNQUQgYWdlbnRzIGluIHRoZSBJQiBjb2RlPyAgSSB3
b25kZXIgaWYgaXQgd291bGQgYmUgcG9zc2libGUgdG8NCj4+PiBncm91cCBNQUQgYWdlbnRzIChw
ZXItcG9ydCBncm91cGluZywgZG9lcyB0aGF0IG1ha2Ugc2Vuc2U/KSBzdWNoIHRoYXQNCj4+PiBz
ZXZlcmFsIGFnZW50cyB3b3VsZCBzaGFyZSBhIHNpbmdsZSBMU00gbm90aWZpZXIgcmVnaXN0cmF0
aW9uPw0KPj4+DQo+PiBvbmUgY2FuIGhhdmUgbnVtZXJvdXMgTUFEIGFnZW50cy4gIGl0IGlzbid0
IGp1c3Qgb25lLg0KPiBDbGVhcmx5LiAgRGFuaWVsIGFscmVhZHkgbWVudGlvbmVkIGh1bmRyZWRz
IG9mIHRob3VzYW5kcyBvZiBNQUQgYWdlbnRzLg0KSnVzdCB0byBiZSBjbGVhciwgaXQgd2FzIGh1
bmRyZWRzIHRvIHRob3VzYW5kcywgbm90IGh1bmRyZWRzIG9mIHRob3VzYW5kcy4NCj4NCj4+IFRo
aW5rOiB5b3UgY2FuIGhhdmUgYW55IG51bWJlciBvZiBhcHBzIHNjYW5uaW5nIHRoZSBmYWJyaWMg
Zm9yIHZhcmlvdXMgc3RhdHMNCj4+ICAgICAgICAgdG8gZHJhdyBub2RlL2dyYXBoIHBpY3MsIGdh
dGhlciBwZXItcG9ydCBwYWNrZXQgY291bnRzLCBnYXRoZXIgYncgbnVtYmVycywNCj4+ICAgICAg
ICAgZXRjLiAgRm9yIElCLCBzY2FubmluZyB0aGUgZmFicmljIGludm9sdmVzICdtYWQgcGt0cycu
DQo+PiAgICAgICAgIEluIGFkZGl0aW9uIHRvIHNjYW5uaW5nLCBvbmUgY291bGQgZG8gJ2xlc3Mg
dGhlbiBuaWNlIHRoaW5ncycgdG8gc3dpdGNoZXMsDQo+PiAgICAgICAgIG5vdCBqdXN0IHJlYWQg
c3RhdHMgYnV0IHNldCBwYXJhbWV0ZXJzLi4uIGxpa2Ugcm91dGluZyB0YWJsZSBlbnRyaWVzLg0K
Pj4gICAgICAgICBhbmQgdGh1cywgdGhlIHNlY3VyaXR5IGxldmVsIGFkZGl0aW9uLg0KPj4gICAg
ICAgIE9uZSBpcyBoaWdobHkgdW5saWtlbHkgdG8gZ3JhbnQgYWNjZXNzIHRvIGFuIGFwcCB0byBk
byBtYWQgcGt0IGdlbmVyYXRpb24vdXNlLA0KPj4gICAgICAgIHRoZW4gY2hhbmdlIHlvdXIgbWlu
ZCAoc2VtaS0/KXJhbmRvbWx5IHRvIGVuYWJsZS9kaXNhYmxlIGl0Li4uLiBnZW5lcmFsbHkgYWx3
YXlzIGVuYWJsZWQsDQo+PiAgICAgICAgb3IgYWx3YXlzIGRpc2FibGVkLg0KPj4NCj4+IExldCdz
IHRha2UgdGhpcyBjYXNlIGFzIGEgY2F0YWx5c3QgdG8gcmVzb2x2ZSBhIHByZXZpb3VzbHkgdW5r
bm93biBwZXJmIGlzc3VlLA0KPj4gYW5kIG5vdCBob2xkIGl0IHVwIHRvIGEgaGlnaGVyIGZ1bmN0
aW9uYWwgcmVxdWlyZW1lbnQgdGhlbiBvdGhlciBhcHBzIHRoYXQgd2FudCB0byBiZSBzZWN1cmVk
Lg0KPiBTZWUgbXkgY29tbWVudCBhYm92ZS4gIEkgZG9uJ3QgZXZlbiBrbm93IHdoYXQgeW91IGFy
ZSB0YWxraW5nIGFib3V0DQo+IHJlZ2FyZGluZyAiaGlnaGVyIGZ1bmN0aW9uYWwgYXJndW1lbnRz
Iiwgd2hhdCBvdGhlciBzdWJzeXN0ZW1zPw0KPiBTZXJpb3VzbHkgRG9uLCBsYW5ndWFnZSBsaWtl
IHRoaXMgY2F1c2VzIGFuIGV4dHJlbWUgYWxsZXJnaWMgcmVhY3Rpb24uDQo+DQo+IEFueXdheSwg
bGV0J3MgbW92ZSBvbiB0byBzb21ldGhpbmcgYSBiaXQgbW9yZSBjb25zdHJ1Y3RpdmUsIHNoYWxs
IHdlPw0KPg0KPiBGcm9tIHdoYXQgSSd2ZSBnYXRoZXJlZCBmcm9tIHRoaXMgdGhyZWFkIHRoZSBp
c3N1ZSBzdGVtcyBmcm9tIHRoZQ0KPiBpYl9tYWRfYWdlbnRfc2VjdXJpdHlfc2V0dXAoKSB3aGVy
ZSB3ZSByZWdpc3RlciB0aGUNCj4gaWJfbWFkX2FnZW50X3NlY3VyaXR5X2NoYW5nZSgpIGNhbGxi
YWNrIHdpdGggdGhlIExTTSBub3RpZmljYXRpb24NCj4gbWVjaGFuaXNtLiAgTG9va2luZyBhdCB0
aGUgaWJfbWFkX2FnZW50X3NlY3VyaXR5X2NoYW5nZSgpIGZ1bmN0aW9uLA0KPiBhbGwgaXQgc2Vl
bXMgdG8gZG8gaXMgcGVyZm9ybSBhIExTTSBwZXJtaXNzaW9uIGNoZWNrDQo+IChzZWN1cml0eV9p
Yl9lbmRwb3J0X21hbmFnZV9zdWJuZXQoKSkgYW5kIHN0b3JlIHRoZSByZXN1bHQgaW4NCj4gaWJf
bWFkX2FnZW50LT5zbXBfYWxsb3dlZDsgcXVpY2tseSBncmVwJ2luZyB0aHJvdWdoIHRoZSBjb2Rl
LCB0aGUgb25seQ0KPiBwbGFjZSB3aGVyZSBJIHNlZSB0aGF0IHZhbHVlIHVzZWQgaXMgaW4gaWJf
bWFkX2VuZm9yY2Vfc2VjdXJpdHkoKS4NCj4NCj4gTG9va2luZyBhdCBpYl9tYWRfZW5mb3JjZV9z
ZWN1cml0eSgpLCBpdCBzZWVtcyB0byBoYXZlIGFjY2VzcyB0byB0aGUNCj4gbmVjZXNzYXJ5IE1B
RCBhZ2VudCBpbmZvcm1hdGlvbiwgdmlhIGliX21hZF9hZ2VudF9wcml2YXRlLT5hZ2VudCwgdG8N
Cj4gcGVyZm9ybSB0aGUgTFNNIHBlcm1pc3Npb24gY2hlY2sgZGlyZWN0bHkgaW4gdGhpcyBmdW5j
dGlvbi4gIENvdWxkIHdlDQo+IG5vdCBnZXQgcmlkIG9mIHRoZSBNQUQgYWdlbnQgTFNNIG5vdGlm
aWNhdGlvbiBjYWxsYmFjayBhbmQgc2ltcGx5IGRvDQo+IHRoZSBMU00gYWNjZXNzIGNoZWNrIGRp
cmVjdGx5IGluIGliX21hZF9lbmZvcmNlX3NlY3VyaXR5KCk/ICBXaGF0IGFtIEkNCj4gbWlzc2lu
Zz8NCj4NCj4gSSBkbyBzZWUgdGhhdCB0aGUgU0VMaW51eCBpbXBsZW1lbnRhdGlvbiBvZiB0aGUN
Cj4gc2VjdXJpdHlfaWJfZW5kcG9ydF9tYW5hZ2Vfc3VibmV0KCkgTFNNIGhvb2sgZG9lc24ndCBz
ZWVtIHRvIGNhY2hlIHRoZQ0KPiBJQiBlbmRwb3J0IGxhYmVscy4gIElmIHRoYXQgcHJvdmVzIHRv
IGJlIGEgcGVyZm9ybWFuY2UgaXNzdWUgd2UgY2FuDQo+IGNyZWF0ZSBhIGNhY2hlIGZvciB0aGF0
IChsaWtlIHdlIGRvIGZvciB0aGUgcGtleXMgYW5kIGEgZmV3IG90aGVyDQo+IG9iamVjdHMpLg0K
Pg0KPiBJIGJhcmVseSB1bmRlcnN0YW5kIElCLCBzbyBpdCBpcyB2ZXJ5IHBvc3NpYmxlIHRoZXJl
IGlzIGEgZnVuZGFtZW50YWwNCj4gZmxhdyBpbiB0aGUgbG9naWMgYWJvdmUsIGJ1dCBsZXQncyB0
cnkgdG8gd29yayB0b2dldGhlciBhbmQgZmlndXJlDQo+IHNvbWV0aGluZyBvdXQuICBUaGUgYWJv
dmUgbWF5IG5vdCBiZSBpdCwgYnV0IEknbSBub3QgcmVhZHkgdG8gdGhyb3cgaW4NCj4gdGhlIHRv
d2VsLg0KSSB0aGluayB0aGF0J3MgYSByZWFzb25hYmxlIGlkZWEsIGFsc28gaG9sZGluZyBhZ2Vu
dHMgbGlzdHMgaW4gdGhlIElCIGxheWVyIGFuZCBvbmx5IHJlZ2lzdGVyaW5nIGZvciBvbmUgbm90
aWZpZXIgY291bGQgd29yayBhcyB3ZWxsIChpdCdzIGFscmVhZHkgcmVnaXN0ZXJlZCBmb3IgdGhl
IFBLZXlzKS4gSmFzb24gaGFkIHN1Z2dlc3RlZCB0aGF0IGludGVybmFsbHksIGJ1dCB0aGUgcHJv
YmxlbSBpcyBJIHdhc24ndCByZWFsbHkgYWJsZSB0byByZXByb2R1Y2UgdGhlIHJlcG9ydGVkIGlz
c3VlLCBzbyB3ZSdyZSBraW5kIG9mIGZseWluZyBibGluZCBlaXRoZXIgd2F5IGluIHRlcm1zIG9m
IGtub3dpbmcgaWYgZWl0aGVyIGFwcHJvYWNoIGFkZHJlc3NlcyB0aGUgcGVyZiBwcm9ibGVtLg0K
