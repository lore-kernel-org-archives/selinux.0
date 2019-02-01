Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4796C282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 14:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFD3218AC
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 14:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="QgxRqyMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfBAORC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:17:02 -0500
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:30596
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfBAORB (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 1 Feb 2019 09:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFlq5Sg6ln8Fl51NMzDwIeZjjBAdLYKlXlYXFfiBUZo=;
 b=QgxRqyMev8jkpRRmiEC1+ly/4pfpnIiQrwl38uTOfUS5tSvDj7oEnDcW9WcBciscKsc4Ocr447oQNcHcYRMtnoR3zchH1FP8fFnKqW6fPcvfMFVZDNRt4nxblZnyfp+dhvbI8roFTgfJmgP5W2OwQdRSDoewPA2lx2hPEt2FADo=
Received: from AM0PR05MB5730.eurprd05.prod.outlook.com (20.178.115.152) by
 AM0PR05MB6097.eurprd05.prod.outlook.com (20.178.118.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Fri, 1 Feb 2019 14:16:57 +0000
Received: from AM0PR05MB5730.eurprd05.prod.outlook.com
 ([fe80::bdda:d0fc:7329:7322]) by AM0PR05MB5730.eurprd05.prod.outlook.com
 ([fe80::bdda:d0fc:7329:7322%3]) with mapi id 15.20.1558.026; Fri, 1 Feb 2019
 14:16:57 +0000
From:   Daniel Jurgens <danielj@mellanox.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     Don Dutile <ddutile@redhat.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM
 notifications
Thread-Topic: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM
 notifications
Thread-Index: AQHUthfGxQVMKr96QE+ydPBjEj2aBqXE4zsAgAAFqYCAAGZZAIAAQV4AgADz24CAAATvgIAABBKAgAAvBwCAAAHwAIAABEkAgAQ9NwCAAAVqgA==
Date:   Fri, 1 Feb 2019 14:16:57 +0000
Message-ID: <3c92c876-8ef7-aff9-59ab-966ee95978e6@mellanox.com>
References: <20190127081023.21124-1-leon@kernel.org>
 <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com>
 <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
 <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com>
 <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
 <1859ec04-d3d2-bffe-16ca-2ae602e5bbff@mellanox.com>
 <325d56d9-24d9-a850-57a7-47f12baa593c@mellanox.com>
 <CAHC9VhRWHzrR84ueJHzmBgyQviL-36-ezvDb0u-xRfQmBsBO2g@mail.gmail.com>
 <3cf233f6-4ca7-1667-7d09-0d2b6879046d@mellanox.com>
 <CAHC9VhQWG7z0dV4=bULLGdU3SXjQH-da9vkyZo6a+Wy5Bw29_A@mail.gmail.com>
 <CAHC9VhQc-_iYUid1PYnRA8_cJG+Ji5zkoz80Pg++C-wY_GKrvw@mail.gmail.com>
In-Reply-To: <CAHC9VhQc-_iYUid1PYnRA8_cJG+Ji5zkoz80Pg++C-wY_GKrvw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:104:3::28) To AM0PR05MB5730.eurprd05.prod.outlook.com
 (2603:10a6:208:11d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=danielj@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR05MB6097;6:+WvqFJXYQIwmf3q5L4V6uiUzqyLh3nGlvlRm9Q26d9bncB6X26QYJEBBTMA6n2BGRo7/nQRktVGoxhNTP8KEWvAK+TaXpYuAsTeq7wFZSK3Ev/kzXRYT5JNeUjn1UcESyM6LLx3BP8mRKhXoRnY/yTKHefrPxFOJDH1RUWcGrdwvOKN9DTpWS1kstqK6mumIT2KZAxpRYGCx1XhwBQzL31TCpYYa0NsftE7v45GMtkW2+y9J4rXlaYw8xjQTajEm41i8lWvZmpIlW8hfquWB/xpmMH9rACfEIG/ikhLtoi7168tBjDwn0riRDsAU+IGE7j3aQcCI7G7SFi1R+JlLEjpEVLceJ9vuKUpDd0pamKML1JhZskpebywX/iG+/aqnvGDzWZF5N9KS7y2HZXqWGBH6RImAy02MI3lcqzdisYA4nAr+k7WD5abxp80XzwKXyPod5JTw4zxpArfV9BSyRA==;5:W/KezQqGoGsDQym3fB4Sb6HVqj/aO4Rjr+59Byge3Ah4UV4h6oLcbTmVbDncO1uHxVTwTgsMZQa1oW8a5k/MGa15xCJVphjabQ9a3ksf94F8uEswIJx7vC7erGhEwfCB9pgPRWX5tc7gHDxda7Aj2BI4MLwAnwF0+J9rn6uhRwar3Y0MkfAE+1BTLYImzdjiqvTVRPG23EFHdyKfdpwOcg==;7:8/dLaIYtJxttnQg3fQ499aKYw6HtcjwSNwofHF9bRZ5zDkK2BVsJsuUuLqO8W+3u4zTiu+K9mWMzCQaAHk/wfDsBvWArbZZXpCvh/SFRA1de0oCHIO8RkZDntchVDLY/5CWNEV/1670ReuT/kKIp8A==
x-ms-office365-filtering-correlation-id: 3ed7a758-1716-4084-e61d-08d6884fec3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB6097;
x-ms-traffictypediagnostic: AM0PR05MB6097:
x-microsoft-antispam-prvs: <AM0PR05MB609769A69A06CB41BEA3BFFAC4920@AM0PR05MB6097.eurprd05.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(6506007)(31686004)(229853002)(2616005)(478600001)(7736002)(446003)(25786009)(11346002)(71200400001)(71190400001)(476003)(6436002)(14454004)(8936002)(105586002)(81156014)(81166006)(106356001)(6512007)(305945005)(386003)(8676002)(102836004)(486006)(68736007)(99286004)(53546011)(54906003)(186003)(6486002)(93886005)(26005)(66066001)(4326008)(97736004)(6916009)(76176011)(14444005)(3846002)(6116002)(52116002)(86362001)(31696002)(15650500001)(2906002)(53936002)(36756003)(256004)(107886003)(6246003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6097;H:AM0PR05MB5730.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yJIYc479hXD1sffb0Vd8VyCuR7NnaZowuUv9cAWLycJ2ywPjcHDvgns/lZUeu6Fmx/2A+gttFOk1egT3qJauGmoumwZ8eYB0F4KaFjWjA+3zp5mjq5LdxrQ1HQ/jFq+EKLKdg6IMWOBUhyB3lH0BugKcxasCUgPRa9EX3sP7leEfjF9ZXHdKybfBP+h9Wp2PgtwxdDNGVMXQa6KJGlaiGyGX65vp3e0gPhTH9KIFSMEE+eoYka1dbLMmmLeGi082Pj/axXCMmD6gFgVriFKc/txDpbx7YOEjfIBGK0yY2FEvUYCWcXYYn0X20scTpQlZ7r5BO5oj8t7Jp5rdVkfTetmmpbCsYzeJh4yyTi9wzcxYb3EVSHsUGs8gseojM9/MTuOda8CpP8iPFmKJErlKtMLu9CUqPIfeoQE2bapyhRY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BE2D0E7E3900544A66BE13B48BB60B7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed7a758-1716-4084-e61d-08d6884fec3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 14:16:54.6042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6097
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQpPbiAyLzEvMjAxOSA3OjU3IEFNLCBQYXVsIE1vb3JlIHdyb3RlOg0KPiBPbiBUdWUsIEphbiAy
OSwgMjAxOSBhdCA0OjEzIFBNIFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+IHdyb3Rl
Og0KPj4gT24gVHVlLCBKYW4gMjksIDIwMTkgYXQgMzo1OCBQTSBEYW5pZWwgSnVyZ2VucyA8ZGFu
aWVsakBtZWxsYW5veC5jb20+IHdyb3RlOg0KPj4+IE9uIDEvMjkvMjAxOSAyOjUxIFBNLCBQYXVs
IE1vb3JlIHdyb3RlOg0KPj4+PiBPa2F5LCBzbyBsZXQncyBhdHRlbXB0IHRoZSBjaGFuZ2UgYWJv
dmUgd2hlcmUgd2UganVzdCBkbyB0aGUgYWNjZXNzDQo+Pj4+IGNoZWNrIGRpcmVjdGx5LiAgQWx0
aG91Z2ggSSdtIGEgbGl0dGxlIGNvbmNlcm5lZCB0aGF0IHdpdGhvdXQgYQ0KPj4+PiByZXByb2R1
Y2VyIHdlIG1pZ2h0IG5vdCBlbmQgdXAgZml4aW5nIHRoZSBwcm9ibGVtIHdlJ3JlIHRyeWluZyB0
byBmaXguDQo+Pj4+IElzIGFueW9uZSBpbiB0b3VjaCB3aXRoIHRoZSBwZXJzb24gd2hvIG9yaWdp
bmFsbHkgcmVwb3J0ZWQgdGhlDQo+Pj4+IHByb2JsZW0/ICBJdCB3b3VsZCBiZSBncmVhdCBpZiB3
ZSBjb3VsZCBnZXQgdGhhdCBwZXJzb24gdG8gdmVyaWZ5IHRoZQ0KPj4+PiBjaGFuZ2UgLi4uDQo+
Pj4gSSBkZWNpZGVkIHRvIGdvIHdpdGggbWFpbnRhaW5pbmcgYSBsaXN0IGluIElCIGNvcmUuIFRo
ZSBub3RpZmllciBjYWxsIGlzIGRvbmUgdW5kZXIgcmN1X3JlYWRfbG9jayB2cyBzcGluX2xvY2tf
aXJxIGZvciByZWdpc3Rlci91bnJlZ2lzdGVyLCBzbyB3ZSBzaG91bGRuJ3QgaGF2ZSBhbnkgcHJv
YmxlbXMgaW4gdGhhdCBjYXNlLiBTbyBvbmx5IHJlZ2lzdGVyaW5nIG9uY2UgYmFzaWNhbGx5IGFj
aGlldmVzIHRoZSBzYW1lIHRoaW5nIGFzIHRha2luZyBpdCBhbGwgb3V0LiBJJ20gdGVzdGluZyBp
dCBub3cuIEknbGwgc2VuZCBpdCBmb3IgaW50ZXJuYWwgcmV2aWV3IHRvZGF5IGFzc3VtaW5nIGl0
IGNoZWNrcyBvdXQuIEhvcGVmdWxseSBMZW9uIGNhbiBnZXQgaXQgcG9zdGVkIHRvbW9ycm93LCBJ
IGtub3cgRG9uIGhhcyBzb21lIHNjaGVkdWxlIHByZXNzdXJlIGhlcmUuDQo+PiBPa2F5IHNvdW5k
cyBnb29kLiAgV2UncmUgc3RpbGwgYXQgLXJjNCBzbyBhcyBsb25nIGFzIHdlIGNhbiBnZXQNCj4+
IHNvbWV0aGluZyBwb3N0ZWQgdGhpcyB3ZWVrLCBvciBlYXJseSBuZXh0LCBJIHNlZSBubyByZWFz
b24gd2h5IGl0DQo+PiBjYW4ndCBtYWtlIHRoZSB1cGNvbWluZyBtZXJnZSB3aW5kb3cuDQo+Pg0K
Pj4gSSdtIGd1ZXNzaW5nIERvbidzIHNjaGVkdWxlIHByZXNzdXJlIGlzIG1vcmUgYSBSSCBkZWFk
bGluZSwgYW5kIG5vdCBhbg0KPj4gdXBzdHJlYW0gY29uc3RyYWludC4NCj4gSSBqdXN0IHdhbnRl
ZCB0byBjaGVjayBpbiBhbmQgc2VlIGhvdyB0aGlzIHdhcyBwcm9ncmVzc2luZz8gIEkgZGlkbid0
DQo+IHNlZSBhbnl0aGluZyBpbiBteSBpbmJveCwgYnV0IHBlcmhhcHMgSSBtaXNzZWQgaXQgLi4u
DQpJdCdzIHBhc3NlZCBpbnRlcm5hbCByZXZpZXcuIExlb24gc2hvdWxkIHNlbmQgaXQgc29vbiAo
U3VuZGF5IGF0IHRoZSBzb29uZXN0LCBJTCBoYXMgRnJpZGF5LVNhdHVyZGF5IHdlZWtlbmRzKSwg
aGUgbWF5IGJlIHdhaXRpbmcgZm9yIGEgcmVncmVzc2lvbiBydW4gdG8gZmluaXNoLg0K
