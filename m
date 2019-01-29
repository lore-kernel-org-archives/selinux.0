Return-Path: <SRS0=7tXC=QF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3329FC169C4
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 20:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25F020869
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 20:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="QXh5o0Bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfA2U6I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:58:08 -0500
Received: from mail-eopbgr20088.outbound.protection.outlook.com ([40.107.2.88]:40576
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726982AbfA2U6I (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 29 Jan 2019 15:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pTbLHhhkENFmsCqQF8wjWBhnK8NBg/O53S/joSR8F8=;
 b=QXh5o0BpahJMIiL+JWTAy3x9R62nN/ivf24XMtvJoAWGsC4m3rCWYY8AC4Vwj458fgW1L5tkLYID13zBqIMjpJUcdME6nlzVSrP7Y1XZXG3HzBySp6nPBG/r2nOFS2luDYsXAjnbe5GQPkmrcuLwEkZgNO4puNJfmLoxD10oHaE=
Received: from AM0PR05MB5730.eurprd05.prod.outlook.com (20.178.115.152) by
 AM0PR05MB5698.eurprd05.prod.outlook.com (20.178.116.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 20:58:04 +0000
Received: from AM0PR05MB5730.eurprd05.prod.outlook.com
 ([fe80::bdda:d0fc:7329:7322]) by AM0PR05MB5730.eurprd05.prod.outlook.com
 ([fe80::bdda:d0fc:7329:7322%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 20:58:04 +0000
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
Thread-Index: AQHUthfGxQVMKr96QE+ydPBjEj2aBqXE4zsAgAAFqYCAAGZZAIAAQV4AgADz24CAAATvgIAABBKAgAAvBwCAAAHwAA==
Date:   Tue, 29 Jan 2019 20:58:04 +0000
Message-ID: <3cf233f6-4ca7-1667-7d09-0d2b6879046d@mellanox.com>
References: <20190127081023.21124-1-leon@kernel.org>
 <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com>
 <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
 <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com>
 <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
 <1859ec04-d3d2-bffe-16ca-2ae602e5bbff@mellanox.com>
 <325d56d9-24d9-a850-57a7-47f12baa593c@mellanox.com>
 <CAHC9VhRWHzrR84ueJHzmBgyQviL-36-ezvDb0u-xRfQmBsBO2g@mail.gmail.com>
In-Reply-To: <CAHC9VhRWHzrR84ueJHzmBgyQviL-36-ezvDb0u-xRfQmBsBO2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0010.prod.exchangelabs.com (2603:10b6:a02:80::23)
 To AM0PR05MB5730.eurprd05.prod.outlook.com (2603:10a6:208:11d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=danielj@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR05MB5698;6:iNeaL2KaNXR7P1rnjG5lAKcqdKxA3gKZpR2MCrRmxdV9fMCg+UOcUGDKk8qvxVgyUB+Ml0qKeI+zS3A3WNNMrR2yV96LSPGiBvtR3IyDjCcSvNxCBzrXbdEOn2PG5dP/oKDPe8KC7Wf6yvbkwbByYZ8UcOC5orwXIbe3x8VxUkFU8C3U2oOIyTW2aNvXIHbP9IKcmLMFuw3mBvvv41lix6AEUC8hN+yLGryJvAG+0aBmjHm+oEwzlOhiIyna6NrdCav9E+jw9eC84uhjG11rCw1u/uU8b4YjNKKZBrxvUpzmyA2vprnDvzIZJNmox2Obn/C3qNQCAFHF2MRgRYS1kfrJJxCsJ0VDzkzf3oXf4qbIcV7F9JvAuRZOFLctZAc9DSOYZnBafkGKK1Beaa4ZOob65KLfpfrVsmo70Mvcew07XRLbeiBBGXNkAK00v9fEtODdNRX8i7eI3fWuS21+gw==;5:p5ovFskqp8npKCDgLQVpEOVFa/4gNET6sUX8NKfAt5TJHCElI95VKy7kba+Pg3af0lFsnzBE1D0k+MF0wiFU9sUfJjsS7VED5arLTDRum98zlGOshdoXVG20JMiita4+gu8e0XX4vxu1Cq4FOWsxX4RtexbUUjkHqWbQKwR0LAiT5M2C4IRBut6AbCavzQ5tL+uTFYx+yxTPLFu0xk4JOQ==;7:5wJQIFWUU8g5sCufdQfoDWOVUJNyWxp6ECuWGEO0p1biLJ8aHcWyVMBS73m5rZ6Q0xw27CN1ynGELfuUQZAiVxdsu4boLRsT0Tb47u4miceQgXl5/y8PUV9UGsq0CUP1rYwolVPzGAKUNLtfdl6Hcw==
x-ms-office365-filtering-correlation-id: 8a215ca4-9b6d-4e27-4126-08d6862c7641
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB5698;
x-ms-traffictypediagnostic: AM0PR05MB5698:
x-microsoft-antispam-prvs: <AM0PR05MB569887B068D4C6161DE2DAE0C4970@AM0PR05MB5698.eurprd05.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(189003)(199004)(71200400001)(15650500001)(7736002)(68736007)(8936002)(6116002)(53936002)(305945005)(97736004)(2906002)(81166006)(8676002)(256004)(106356001)(14444005)(81156014)(107886003)(105586002)(316002)(54906003)(3846002)(6916009)(6246003)(99286004)(6486002)(36756003)(2616005)(478600001)(66066001)(476003)(52116002)(86362001)(31696002)(446003)(26005)(71190400001)(4326008)(11346002)(14454004)(486006)(229853002)(93886005)(6512007)(6506007)(102836004)(31686004)(53546011)(25786009)(386003)(186003)(76176011)(4744005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5698;H:AM0PR05MB5730.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ETmgHIlmoDjOvi66b6k/Krvh5Wr5kryjfNes/isED95syol70sIaFps1q6na8Kr+kzBv8Z75pTTYLTNmQgrayqjjnAjn6IvxW2jUnDSp5dpyxHXQCUY0HjFkl1uydYUr0FGBhyvp4f3lG8Tc76mu06H7R4VJOUxcWjrasNQOxPWh4072CyVeqGDob5dhzBdb6xbTdYEYpv6YXt9Jb3VaFy0py1ulwZa8+B4k2j3h+uGwRCXh9IoSOR0mUITGpaReag50N56C0lTdbwY9eSAPO6FF079GTjBF0I4Ms8Aw2VOm6/llfddBbeHUKVkH24fN6Csk5m2kLkpUwh3FFbTMcC4t4GQ1NsRxNBz2eTnGhnH1gwa6v+XEwEOMxTESEOHX/SAed6C8HgtZoi6k7JTjrr0tvc8JOyOU48ffiLj7swY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B0CFC65415F3F4CBC9BCFA8F524588B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a215ca4-9b6d-4e27-4126-08d6862c7641
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 20:58:01.9960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5698
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQpPbiAxLzI5LzIwMTkgMjo1MSBQTSwgUGF1bCBNb29yZSB3cm90ZToNCj4NCj4gT2theSwgc28g
bGV0J3MgYXR0ZW1wdCB0aGUgY2hhbmdlIGFib3ZlIHdoZXJlIHdlIGp1c3QgZG8gdGhlIGFjY2Vz
cw0KPiBjaGVjayBkaXJlY3RseS4gIEFsdGhvdWdoIEknbSBhIGxpdHRsZSBjb25jZXJuZWQgdGhh
dCB3aXRob3V0IGENCj4gcmVwcm9kdWNlciB3ZSBtaWdodCBub3QgZW5kIHVwIGZpeGluZyB0aGUg
cHJvYmxlbSB3ZSdyZSB0cnlpbmcgdG8gZml4Lg0KPiBJcyBhbnlvbmUgaW4gdG91Y2ggd2l0aCB0
aGUgcGVyc29uIHdobyBvcmlnaW5hbGx5IHJlcG9ydGVkIHRoZQ0KPiBwcm9ibGVtPyAgSXQgd291
bGQgYmUgZ3JlYXQgaWYgd2UgY291bGQgZ2V0IHRoYXQgcGVyc29uIHRvIHZlcmlmeSB0aGUNCj4g
Y2hhbmdlIC4uLg0KDQpJIGRlY2lkZWQgdG8gZ28gd2l0aCBtYWludGFpbmluZyBhIGxpc3QgaW4g
SUIgY29yZS4gVGhlIG5vdGlmaWVyIGNhbGwgaXMgZG9uZSB1bmRlciByY3VfcmVhZF9sb2NrIHZz
IHNwaW5fbG9ja19pcnEgZm9yIHJlZ2lzdGVyL3VucmVnaXN0ZXIsIHNvIHdlIHNob3VsZG4ndCBo
YXZlIGFueSBwcm9ibGVtcyBpbiB0aGF0IGNhc2UuIFNvIG9ubHkgcmVnaXN0ZXJpbmcgb25jZSBi
YXNpY2FsbHkgYWNoaWV2ZXMgdGhlIHNhbWUgdGhpbmcgYXMgdGFraW5nIGl0IGFsbCBvdXQuIEkn
bSB0ZXN0aW5nIGl0IG5vdy4gSSdsbCBzZW5kIGl0IGZvciBpbnRlcm5hbCByZXZpZXcgdG9kYXkg
YXNzdW1pbmcgaXQgY2hlY2tzIG91dC4gSG9wZWZ1bGx5IExlb24gY2FuIGdldCBpdCBwb3N0ZWQg
dG9tb3Jyb3csIEkga25vdyBEb24gaGFzIHNvbWUgc2NoZWR1bGUgcHJlc3N1cmUgaGVyZS4NCg0K
