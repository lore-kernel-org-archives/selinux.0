Return-Path: <SRS0=7tXC=QF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AED8C282C7
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 18:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4508A21848
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 18:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="mTVTC+Eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfA2SDg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:03:36 -0500
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:35488
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727229AbfA2SDf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 29 Jan 2019 13:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QTDRGJAiOc29y6yLkgGnZSUwMWf0xFFj97PkqJafjc=;
 b=mTVTC+EqXJD03xa2a+EjXYHoa3zwRmZRIPoV5rE4BzjA22RF/95V7IW7PgTnaPCeTguXbmbaUQk3IuqY4vaDB+2/Xq9wrYY2ucPuyWzmbgOvsmZXMUS4p+6cl1yaos1Fqb1Zj2Nq5dGjqGOSVNQNYS+lbTTCS/BG1C6/hSLGQiE=
Received: from AM0PR05MB5730.eurprd05.prod.outlook.com (20.178.115.152) by
 AM0PR05MB5348.eurprd05.prod.outlook.com (20.178.18.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 18:02:51 +0000
Received: from AM0PR05MB5730.eurprd05.prod.outlook.com
 ([fe80::bdda:d0fc:7329:7322]) by AM0PR05MB5730.eurprd05.prod.outlook.com
 ([fe80::bdda:d0fc:7329:7322%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 18:02:51 +0000
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
Thread-Index: AQHUthfGxQVMKr96QE+ydPBjEj2aBqXE4zsAgAAFqYCAAGZZAIAAQV4AgADz24CAAATvgIAABBKA
Date:   Tue, 29 Jan 2019 18:02:51 +0000
Message-ID: <325d56d9-24d9-a850-57a7-47f12baa593c@mellanox.com>
References: <20190127081023.21124-1-leon@kernel.org>
 <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com>
 <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
 <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com>
 <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
 <1859ec04-d3d2-bffe-16ca-2ae602e5bbff@mellanox.com>
In-Reply-To: <1859ec04-d3d2-bffe-16ca-2ae602e5bbff@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To AM0PR05MB5730.eurprd05.prod.outlook.com
 (2603:10a6:208:11d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=danielj@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR05MB5348;6:thQWwvs9EgmcSvIjyzP0G8mfd1CIv80P5gbOIXTPe7DSMNga30sUGg5cMFY8b3Fyuo9G0xcsCmFlrsxHBfLNV9prBy/qruTfu1p+VEqexJsgFnlo8fme1Tz8wZHUY0+osP4Jrou/vMAw3KiMe2N1bKLMRTtDwGqz7hUNcYuNqhDZwexwoWKmRlLJBClnWarx/OfNSeY4dp6UHULgzW2fDQmcSE2ynHzl59AKl9dmKiFgRwSAE/ukaMyPtZIRTNv4utUnGxckPxSehOvQ/O+BgSXywA51POBSH16EsRQwHqs3NgmEgGiANpAOcJNiy9I5wYnziS4Gyb6tQsXayyBK0F2Uum/6tcES+/7FglVAr5x6SA8vsPHoxCaiSqP+gb/gD+yj/5gD2iPJior+dYuvSLGyGsepflhxtxpia3Dwwri15t9U1Fbmc7aTwPT3+o8QXLTlb0Kcj8SmiFesWpZqrA==;5:0NdmGkB8eNG/XB8FAHNua7gZLz83u6IUIWFS0OfdSWaMjDB/m5az1f5+UC3OW3UJeQGPYzMuryTkgo53S/KocMoKTviGoit2544Yzv8u/qN4QnDDCUoSx3B4daJCOHiqx2RAAPo1oue1VQlN0XyL8IeZoOTVEyLJKEgxif9tldoCC975WERBTUDWn1pJ3UwMdyt7zDZSu7z6+soOOO01+Q==;7:LcwRlBfG2TaUuB093l17ujQgetVWnFiii8MVsnet0qMg7/oh9IUTB5+PC1D/LP9l7kY/rmChXPv0w6N+V9GfKKrXyqyd9VEpJCZ0JbguwQBkMA7px2OSyOKXbcCVJf5ZOn4thotH5pI1OSTWctaYWg==
x-ms-office365-filtering-correlation-id: 303568d9-d5b2-41ac-6500-08d68613fbe0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB5348;
x-ms-traffictypediagnostic: AM0PR05MB5348:
x-microsoft-antispam-prvs: <AM0PR05MB53484D6C96247548A9A6E1B0C4970@AM0PR05MB5348.eurprd05.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(366004)(396003)(346002)(54094003)(52314003)(51444003)(189003)(199004)(107886003)(4326008)(6246003)(186003)(53546011)(229853002)(6486002)(53936002)(6436002)(14444005)(256004)(2906002)(15650500001)(97736004)(386003)(316002)(66066001)(6512007)(54906003)(26005)(110136005)(102836004)(76176011)(52116002)(99286004)(6506007)(36756003)(81166006)(11346002)(8676002)(93886005)(478600001)(8936002)(81156014)(476003)(25786009)(106356001)(68736007)(14454004)(71190400001)(71200400001)(7736002)(6116002)(305945005)(86362001)(2616005)(486006)(446003)(31686004)(3846002)(31696002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5348;H:AM0PR05MB5730.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mEDoFJ+mc5iWjPw63WdpTFv1ZEyK3C0QEg8cNyomHJ18BWyHL9ugy7WKKD9RrQs3GQ15nCpZ4qSm1YYT88qWgFvi8uNRk47876iZdZ18faeSYyteMXAvIZKkCU1KysiD4/D4Vf/gqRhrltg0pKu3Q3GgeLCFslUjlQkO2KXpJErX61W2HM3HToiQI8usP99H/kM1FBCm5mzSRvs1FwBy4uyOw+1jepWkZ0K8qZg00U595bnzitN9lP1RAPkVvCA/EqFSWlNf6NvYWTGij1cGxDe0Y+bWj6JG8P3ErAS9+fV8b9sizSkF0vpoNkBbxaOCDgqX9JTlOCiBTlcNCNvcA9S+dNBrJ4Lg4yUxb92qjto9MqQDrUg924L4cV44h+PS3FhvQr3QNOTNCAIyuln9OqJvSZ/okqloqoaShuxJHXA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B55C08C6236C9D40ADC986D1810EDB1F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303568d9-d5b2-41ac-6500-08d68613fbe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 18:02:48.8268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5348
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQpPbiAxLzI5LzIwMTkgMTE6NDggQU0sIERhbmllbCBKdXJnZW5zIHdyb3RlOg0KPiBPbiAxLzI5
LzIwMTkgMTE6MzAgQU0sIFBhdWwgTW9vcmUgd3JvdGU6DQo+PiBPbiBNb24sIEphbiAyOCwgMjAx
OSBhdCA5OjU3IFBNIERvbiBEdXRpbGUgPGRkdXRpbGVAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4g
T24gMDEvMjgvMjAxOSAwNjowMyBQTSwgUGF1bCBNb29yZSB3cm90ZToNCj4+Pj4gT24gTW9uLCBK
YW4gMjgsIDIwMTkgYXQgMTE6NTcgQU0gRGFuaWVsIEp1cmdlbnMgPGRhbmllbGpAbWVsbGFub3gu
Y29tPiB3cm90ZToNCj4+Pj4+IE9uIDEvMjgvMjAxOSAxMDozNyBBTSwgUGF1bCBNb29yZSB3cm90
ZToNCj4+Pj4+PiBPbiBTdW4sIEphbiAyNywgMjAxOSBhdCAzOjEwIEFNIExlb24gUm9tYW5vdnNr
eSA8bGVvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4+Pj4gRnJvbTogRGFuaWVsIEp1cmdlbnMg
PGRhbmllbGpAbWVsbGFub3guY29tPg0KPj4+Pj4+Pg0KPj4+Pj4+PiAtLS0NCj4+Pj4+Pj4gICBk
cml2ZXJzL2luZmluaWJhbmQvY29yZS9zZWN1cml0eS5jIHwgMzQgKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+Pj4+Pj4+ICAgaW5jbHVkZS9yZG1hL2liX21hZC5oICAgICAgICAgICAg
ICB8ICAzIC0tLQ0KPj4+Pj4+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAz
MyBkZWxldGlvbnMoLSkNCj4+Pj4gSSdtIHRyeWluZyB0byBxdWlja2x5IHVuZGVyc3RhbmQgdGhl
IE1BRCBhZ2VudCBsaWZlY3ljbGUsIGFuZCBpdCBsb29rcw0KPj4+PiBsaWtlIHlvdSBoYXZlIHlv
dXIgb3duIHJlZ2lzdGVyL3VucmVnaXN0ZXIgcm91dGluZXMsIHdpdGggbG9ja2luZywgc28NCj4+
Pj4gaXMgaXQgcmVhc29uYWJsZSB0byBhc3N1bWUgdGhhdCBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0
byBpdGVyYXRlIG92ZXINCj4+Pj4gdGhlIE1BRCBhZ2VudHMgaW4gdGhlIElCIGNvZGU/ICBJIHdv
bmRlciBpZiBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0bw0KPj4+PiBncm91cCBNQUQgYWdlbnRzIChw
ZXItcG9ydCBncm91cGluZywgZG9lcyB0aGF0IG1ha2Ugc2Vuc2U/KSBzdWNoIHRoYXQNCj4+Pj4g
c2V2ZXJhbCBhZ2VudHMgd291bGQgc2hhcmUgYSBzaW5nbGUgTFNNIG5vdGlmaWVyIHJlZ2lzdHJh
dGlvbj8NCj4+Pj4NCj4+PiBvbmUgY2FuIGhhdmUgbnVtZXJvdXMgTUFEIGFnZW50cy4gIGl0IGlz
bid0IGp1c3Qgb25lLg0KPj4gQ2xlYXJseS4gIERhbmllbCBhbHJlYWR5IG1lbnRpb25lZCBodW5k
cmVkcyBvZiB0aG91c2FuZHMgb2YgTUFEIGFnZW50cy4NCj4gSnVzdCB0byBiZSBjbGVhciwgaXQg
d2FzIGh1bmRyZWRzIHRvIHRob3VzYW5kcywgbm90IGh1bmRyZWRzIG9mIHRob3VzYW5kcy4NCj4+
PiBUaGluazogeW91IGNhbiBoYXZlIGFueSBudW1iZXIgb2YgYXBwcyBzY2FubmluZyB0aGUgZmFi
cmljIGZvciB2YXJpb3VzIHN0YXRzDQo+Pj4gICAgICAgICB0byBkcmF3IG5vZGUvZ3JhcGggcGlj
cywgZ2F0aGVyIHBlci1wb3J0IHBhY2tldCBjb3VudHMsIGdhdGhlciBidyBudW1iZXJzLA0KPj4+
ICAgICAgICAgZXRjLiAgRm9yIElCLCBzY2FubmluZyB0aGUgZmFicmljIGludm9sdmVzICdtYWQg
cGt0cycuDQo+Pj4gICAgICAgICBJbiBhZGRpdGlvbiB0byBzY2FubmluZywgb25lIGNvdWxkIGRv
ICdsZXNzIHRoZW4gbmljZSB0aGluZ3MnIHRvIHN3aXRjaGVzLA0KPj4+ICAgICAgICAgbm90IGp1
c3QgcmVhZCBzdGF0cyBidXQgc2V0IHBhcmFtZXRlcnMuLi4gbGlrZSByb3V0aW5nIHRhYmxlIGVu
dHJpZXMuDQo+Pj4gICAgICAgICBhbmQgdGh1cywgdGhlIHNlY3VyaXR5IGxldmVsIGFkZGl0aW9u
Lg0KPj4+ICAgICAgICBPbmUgaXMgaGlnaGx5IHVubGlrZWx5IHRvIGdyYW50IGFjY2VzcyB0byBh
biBhcHAgdG8gZG8gbWFkIHBrdCBnZW5lcmF0aW9uL3VzZSwNCj4+PiAgICAgICAgdGhlbiBjaGFu
Z2UgeW91ciBtaW5kIChzZW1pLT8pcmFuZG9tbHkgdG8gZW5hYmxlL2Rpc2FibGUgaXQuLi4uIGdl
bmVyYWxseSBhbHdheXMgZW5hYmxlZCwNCj4+PiAgICAgICAgb3IgYWx3YXlzIGRpc2FibGVkLg0K
Pj4+DQo+Pj4gTGV0J3MgdGFrZSB0aGlzIGNhc2UgYXMgYSBjYXRhbHlzdCB0byByZXNvbHZlIGEg
cHJldmlvdXNseSB1bmtub3duIHBlcmYgaXNzdWUsDQo+Pj4gYW5kIG5vdCBob2xkIGl0IHVwIHRv
IGEgaGlnaGVyIGZ1bmN0aW9uYWwgcmVxdWlyZW1lbnQgdGhlbiBvdGhlciBhcHBzIHRoYXQgd2Fu
dCB0byBiZSBzZWN1cmVkLg0KPj4gU2VlIG15IGNvbW1lbnQgYWJvdmUuICBJIGRvbid0IGV2ZW4g
a25vdyB3aGF0IHlvdSBhcmUgdGFsa2luZyBhYm91dA0KPj4gcmVnYXJkaW5nICJoaWdoZXIgZnVu
Y3Rpb25hbCBhcmd1bWVudHMiLCB3aGF0IG90aGVyIHN1YnN5c3RlbXM/DQo+PiBTZXJpb3VzbHkg
RG9uLCBsYW5ndWFnZSBsaWtlIHRoaXMgY2F1c2VzIGFuIGV4dHJlbWUgYWxsZXJnaWMgcmVhY3Rp
b24uDQo+Pg0KPj4gQW55d2F5LCBsZXQncyBtb3ZlIG9uIHRvIHNvbWV0aGluZyBhIGJpdCBtb3Jl
IGNvbnN0cnVjdGl2ZSwgc2hhbGwgd2U/DQo+Pg0KPj4gRnJvbSB3aGF0IEkndmUgZ2F0aGVyZWQg
ZnJvbSB0aGlzIHRocmVhZCB0aGUgaXNzdWUgc3RlbXMgZnJvbSB0aGUNCj4+IGliX21hZF9hZ2Vu
dF9zZWN1cml0eV9zZXR1cCgpIHdoZXJlIHdlIHJlZ2lzdGVyIHRoZQ0KPj4gaWJfbWFkX2FnZW50
X3NlY3VyaXR5X2NoYW5nZSgpIGNhbGxiYWNrIHdpdGggdGhlIExTTSBub3RpZmljYXRpb24NCj4+
IG1lY2hhbmlzbS4gIExvb2tpbmcgYXQgdGhlIGliX21hZF9hZ2VudF9zZWN1cml0eV9jaGFuZ2Uo
KSBmdW5jdGlvbiwNCj4+IGFsbCBpdCBzZWVtcyB0byBkbyBpcyBwZXJmb3JtIGEgTFNNIHBlcm1p
c3Npb24gY2hlY2sNCj4+IChzZWN1cml0eV9pYl9lbmRwb3J0X21hbmFnZV9zdWJuZXQoKSkgYW5k
IHN0b3JlIHRoZSByZXN1bHQgaW4NCj4+IGliX21hZF9hZ2VudC0+c21wX2FsbG93ZWQ7IHF1aWNr
bHkgZ3JlcCdpbmcgdGhyb3VnaCB0aGUgY29kZSwgdGhlIG9ubHkNCj4+IHBsYWNlIHdoZXJlIEkg
c2VlIHRoYXQgdmFsdWUgdXNlZCBpcyBpbiBpYl9tYWRfZW5mb3JjZV9zZWN1cml0eSgpLg0KPj4N
Cj4+IExvb2tpbmcgYXQgaWJfbWFkX2VuZm9yY2Vfc2VjdXJpdHkoKSwgaXQgc2VlbXMgdG8gaGF2
ZSBhY2Nlc3MgdG8gdGhlDQo+PiBuZWNlc3NhcnkgTUFEIGFnZW50IGluZm9ybWF0aW9uLCB2aWEg
aWJfbWFkX2FnZW50X3ByaXZhdGUtPmFnZW50LCB0bw0KPj4gcGVyZm9ybSB0aGUgTFNNIHBlcm1p
c3Npb24gY2hlY2sgZGlyZWN0bHkgaW4gdGhpcyBmdW5jdGlvbi4gIENvdWxkIHdlDQo+PiBub3Qg
Z2V0IHJpZCBvZiB0aGUgTUFEIGFnZW50IExTTSBub3RpZmljYXRpb24gY2FsbGJhY2sgYW5kIHNp
bXBseSBkbw0KPj4gdGhlIExTTSBhY2Nlc3MgY2hlY2sgZGlyZWN0bHkgaW4gaWJfbWFkX2VuZm9y
Y2Vfc2VjdXJpdHkoKT8gIFdoYXQgYW0gSQ0KPj4gbWlzc2luZz8NCj4+DQo+PiBJIGRvIHNlZSB0
aGF0IHRoZSBTRUxpbnV4IGltcGxlbWVudGF0aW9uIG9mIHRoZQ0KPj4gc2VjdXJpdHlfaWJfZW5k
cG9ydF9tYW5hZ2Vfc3VibmV0KCkgTFNNIGhvb2sgZG9lc24ndCBzZWVtIHRvIGNhY2hlIHRoZQ0K
Pj4gSUIgZW5kcG9ydCBsYWJlbHMuICBJZiB0aGF0IHByb3ZlcyB0byBiZSBhIHBlcmZvcm1hbmNl
IGlzc3VlIHdlIGNhbg0KPj4gY3JlYXRlIGEgY2FjaGUgZm9yIHRoYXQgKGxpa2Ugd2UgZG8gZm9y
IHRoZSBwa2V5cyBhbmQgYSBmZXcgb3RoZXINCj4+IG9iamVjdHMpLg0KPj4NCj4+IEkgYmFyZWx5
IHVuZGVyc3RhbmQgSUIsIHNvIGl0IGlzIHZlcnkgcG9zc2libGUgdGhlcmUgaXMgYSBmdW5kYW1l
bnRhbA0KPj4gZmxhdyBpbiB0aGUgbG9naWMgYWJvdmUsIGJ1dCBsZXQncyB0cnkgdG8gd29yayB0
b2dldGhlciBhbmQgZmlndXJlDQo+PiBzb21ldGhpbmcgb3V0LiAgVGhlIGFib3ZlIG1heSBub3Qg
YmUgaXQsIGJ1dCBJJ20gbm90IHJlYWR5IHRvIHRocm93IGluDQo+PiB0aGUgdG93ZWwuDQo+IEkg
dGhpbmsgdGhhdCdzIGEgcmVhc29uYWJsZSBpZGVhLCBhbHNvIGhvbGRpbmcgYWdlbnRzIGxpc3Rz
IGluIHRoZSBJQiBsYXllciBhbmQgb25seSByZWdpc3RlcmluZyBmb3Igb25lIG5vdGlmaWVyIGNv
dWxkIHdvcmsgYXMgd2VsbCAoaXQncyBhbHJlYWR5IHJlZ2lzdGVyZWQgZm9yIHRoZSBQS2V5cyku
IEphc29uIGhhZCBzdWdnZXN0ZWQgdGhhdCBpbnRlcm5hbGx5LCBidXQgdGhlIHByb2JsZW0gaXMg
SSB3YXNuJ3QgcmVhbGx5IGFibGUgdG8gcmVwcm9kdWNlIHRoZSByZXBvcnRlZCBpc3N1ZSwgc28g
d2UncmUga2luZCBvZiBmbHlpbmcgYmxpbmQgZWl0aGVyIHdheSBpbiB0ZXJtcyBvZiBrbm93aW5n
IGlmIGVpdGhlciBhcHByb2FjaCBhZGRyZXNzZXMgdGhlIHBlcmYgcHJvYmxlbS4NCg0KwqBJIGd1
ZXNzIEkgc2hvdWxkIGNsYXJpZnkuIE9idmlvdXNseSBpZiB3ZSBvbmx5IHJlZ2lzdGVyIGZvciB0
aGUgbm90aWZpZXIgb25jZSBhbmQgaG9sZCB0aGUgbGlzdChzKSBpbiB0aGUgSUIgbGF5ZXIgd2Ug
d29uJ3QgaGF2ZSBpc3N1ZXMgd2l0aCByZWdpc3Rlci91bnJlZ2lzdGVyLCBidXQgdGhlcmUgbWF5
IHN0aWxsIGJlIGEgcHJvYmxlbSBsdXJraW5nIGR1cmluZyBhIG5vdGlmaWNhdGlvbiBldmVudC4g
U28gdGhpcyBpcyBsZXNzIGJhZCwgYXQgbGVhc3QgaXQgd291bGRuJ3QgYWZmZWN0IG5vbiBTRWxp
bnV4IHVzZXJzLg0KDQo=
