Return-Path: <SRS0=nwiU=QE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B025C282C8
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E4B20844
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="EfrG7HJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387923AbfA1Q5h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:57:37 -0500
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:34400
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728354AbfA1Q5g (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 28 Jan 2019 11:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fpIkGwQ+uJKC0DaTEk0RDV+EgBvxgP+Q/gcDMiePAY=;
 b=EfrG7HJTnb4Cc4rKXZyRiB9S9Bz7facAKD46RRDA3HdzeOvqkFuvcRtzOwUNHj1SKaitBHQivz9T75Ci7fwambifuF15pVQIwRjm3p4f2IURsuR9EegVmWwYnXTcURif0TQZ2xCGpBdgXpoVJG2KRqspIawOjzBpVTqmJbebBh0=
Received: from AM0PR05MB5730.eurprd05.prod.outlook.com (20.178.115.152) by
 AM0PR05MB5219.eurprd05.prod.outlook.com (20.178.18.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Mon, 28 Jan 2019 16:57:32 +0000
Received: from AM0PR05MB5730.eurprd05.prod.outlook.com
 ([fe80::bdda:d0fc:7329:7322]) by AM0PR05MB5730.eurprd05.prod.outlook.com
 ([fe80::bdda:d0fc:7329:7322%3]) with mapi id 15.20.1558.021; Mon, 28 Jan 2019
 16:57:32 +0000
From:   Daniel Jurgens <danielj@mellanox.com>
To:     Paul Moore <paul@paul-moore.com>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM
 notifications
Thread-Topic: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM
 notifications
Thread-Index: AQHUthfGxQVMKr96QE+ydPBjEj2aBqXE4zsAgAAFqYA=
Date:   Mon, 28 Jan 2019 16:57:32 +0000
Message-ID: <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com>
References: <20190127081023.21124-1-leon@kernel.org>
 <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
In-Reply-To: <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:104:7::24) To AM0PR05MB5730.eurprd05.prod.outlook.com
 (2603:10a6:208:11d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=danielj@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR05MB5219;6:JvXRAc9qjUb9YLh8LmY7HKNiQPiImQU8bSxZcdk4M5cpLm+4yjo1catfBoxA9kET1u5ZG8c6ZZwOgSdblOtSvYFDoEomVELkzS0qEATYzV0UTvuggHPYhj5OAFpS7jSO/VHt5H3ehJOilbhK1edeR0TuzGq/QQNxy4qujqeH9naEVzehnZnMKv2qW8kqY2CodHoa1Mmuuw9a/4pivQ4D0XoaUrvtb6Rk9ySMU7mLBSr/uGEOo+SevJCOiJJpwSkQznzCLSt0kijKE1w8ObRF38ljWUjnFZhZxL83fZTXhFQ115oEvunohScqcfKN0kqkXCZVj5wzRivNVVsgBlRv5sAVSxDlbBNbvbRNPURmorL4iX+dVWObg9IjHqFbanUP4/sBlxdMkweVbvVgVMvXEZfzlqLvr/SycO7ufOncj0HFEXphpMLx3EF6xb1uXVWlxXi8VyuM14dd73z5M8gGWw==;5:g1QXxhdl3YzYNk82+NQSwCrsUOIsQX39/C1vMwE1GV4edv9GIIRySwiE96QJhG0Oh3eVxXzBkCb7MNEXbufkFuAtDhXH1s4UTa8ybq/wTJxqLjOOY2cpVAxCWexEZcTO5mnhSQQTroOnHTvgwvJU/covFq4qkbgwhiV+q537hbKh+KPMHcXeA49GeEXZJrz/hE7byS93vghMPDqSzO3buw==;7:LsJZ6BKKq9Yzeqe3tXwd8UXHihvJx2KXKKLuRhQNMytSPcvzmgpNS5Pr1tZBW3paYAr/S6qwzcYKBN4LW6uQxcVx1S4z1TAQu8EAu8B8AhYa7+sj58k3/f1TnqqsE3HgZ95rT1EnOCsnkF71lEE6GQ==
x-ms-office365-filtering-correlation-id: 2ca8c246-7513-436c-7f14-08d68541b1bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB5219;
x-ms-traffictypediagnostic: AM0PR05MB5219:
x-microsoft-antispam-prvs: <AM0PR05MB52198741372A7C5BF2F234D0C4960@AM0PR05MB5219.eurprd05.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(186003)(478600001)(107886003)(15650500001)(102836004)(6512007)(31686004)(8676002)(6506007)(386003)(53546011)(81156014)(6436002)(26005)(106356001)(316002)(14444005)(86362001)(256004)(4326008)(6246003)(8936002)(36756003)(97736004)(105586002)(53936002)(54906003)(110136005)(31696002)(25786009)(99286004)(2906002)(52116002)(14454004)(66066001)(71200400001)(6116002)(7736002)(3846002)(71190400001)(81166006)(229853002)(476003)(6486002)(2616005)(305945005)(76176011)(446003)(68736007)(11346002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5219;H:AM0PR05MB5730.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2dJO5FGFhf8ZLmTWTQzAESmsmAta5o5SQg/13SZjyKKMrheDwK31oyRclSU/ViquT9JEUtSiBOEEpqY8sGgn5XD9HRoNx2TS8Q5NI4UTTndOzFAziXu4sdfmcouT5sLacHAs1RU2zlR8/TQouFehrikqMhaQM+lpzI/+GJcc2zBgO+ccImdFx7BFydEZcZVvTxfQJck3cmFPXk+XlLWUu8Iz4jBhCTS0iKD8eWFYs/xrKdc2x7AM5Da+ubFMo6957/wQr3Y0hGgNR7EgbSf4VyxUkjOaG/DjHP/5OUdMKcohv2sG2xD+5rYdSUyrFpV+Rw+VRqTJ/lS1J/UHXx0CzPZ8MSTdqv1JQPC8zQvO95Ysc8xgeznbgexnYOTrErb+hfTPb4SGhLMyzbLdEtzCJqBYddrykYD+5Ks1F1HN6QM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <971F04A3596A2C41941419A833EE334D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca8c246-7513-436c-7f14-08d68541b1bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 16:57:29.9798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5219
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQpPbiAxLzI4LzIwMTkgMTA6MzcgQU0sIFBhdWwgTW9vcmUgd3JvdGU6DQo+IE9uIFN1biwgSmFu
IDI3LCAyMDE5IGF0IDM6MTAgQU0gTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdy
b3RlOg0KPj4gRnJvbTogRGFuaWVsIEp1cmdlbnMgPGRhbmllbGpAbWVsbGFub3guY29tPg0KPj4N
Cj4+IC0tLQ0KPj4gIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3NlY3VyaXR5LmMgfCAzNCArKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICBpbmNsdWRlL3JkbWEvaWJfbWFkLmggICAg
ICAgICAgICAgIHwgIDMgLS0tDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDMzIGRlbGV0aW9ucygtKQ0KPiBQZXJoYXBzIHByZWRpY3RhYmx5LCBJJ20gbm90IHZlcnkgZXhj
aXRlZCBhYm91dCB0aGlzIGNoYW5nZS4gIEhhdmUgeW91DQo+IGxvb2tlZCBjbG9zZXIgaW50byB0
aGUgc2xvd2Rvd24gdG8gc2VlIHdoZXJlIHRoZSBjeWNsZXMgYXJlIGJlaW5nDQo+IHNwZW50PyAg
SSdtIHdvbmRlcmluZyBpZiB0aGUgaXNzdWUgaXMgdGhhdCBhIGxhcmdlIG51bWJlciBvZiBub3Rp
ZmllcnMNCj4gYXJlIGJlaW5nIHJlZ2lzdGVyZWQgd2l0aCB0aGUgc2FtZSBwcmlvcml0eSBjYXVz
aW5nIHRoZSB3aGlsZSBsb29wIGluDQo+IG5vdGlmaWVyX2NoYWluX3JlZ2lzdGVyKCkgdG8gdGFr
ZSBhIHNpZ25pZmljYW50IGFtb3VudCBvZiB0aW1lLg0KDQpUaGF0J3Mgd2hhdCdzIGhhcHBlbmlu
ZywgZWFjaCBNQUQgYWdlbnQgaXMgcmVnaXN0ZXJpbmcgaXQncyBvd24gbm90aWZpZXIuIFRoZSBi
dWcgcmVwb3J0ZXIgd2FzIGNyZWF0aW5nIGh1bmRyZWRzIG9yIHRob3VzYW5kcyBvZsKgIHNob3J0
IGxpdmVkIE1BRCBhZ2VudHMuIFdpdGggSVJRcyBkaXNhYmxlZCB0b28gbG9uZyBpdCByZXN1bHRl
ZCBpbiB0aW1lb3V0cy4NCg0KV2hlbiBJIGluaXRpYWxseSBhZGRlZCB0aGUgbm90aWZpZXIgbWVj
aGFuaXNtIEkgdGhvdWdodCBpdCB3YXMgeW91IHRoYXQgc2FpZCBpdCB3YXNuJ3QgcmVhbGx5IG5l
ZWRlZCwgc2luY2UgYWNjZXNzIHdhc24ndCBnZW5lcmFsbHkgcmV2b2tlZCBpbiB0aGVzZSB0eXBl
cyBvZiBzY2VuYXJpb3MuIEdpdmVuIHRoYXQgSSBkaWRuJ3QgdGhpbmsgdGhpcyB3b3VsZCBiZSBl
c3BlY2lhbGx5IGNvbnRyb3ZlcnNpYWwuIEl0IHdhcyBuaWNlIHRvIGhhdmUsIHVuZm9ydHVuYXRl
bHkgaXQgY2F1c2VzIHByb2JsZW1zIGV2ZW4gZm9yIHVzZXJzIHRoYXQgZG9uJ3QgZW5hYmxlIFNF
TGludXguDQoNCg==
