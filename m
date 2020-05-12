Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0C3CA90AF
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 18:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034AB20714
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 18:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgELSDm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 14:03:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:59351 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELSDm (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 12 May 2020 14:03:42 -0400
IronPort-SDR: Q1aIOtIzUisiAqYwQzpCTt771T7JFJS5FllHtYRM2+ziZ7DbKvCS7AnyKStrZfdGZL4J1n4g5O
 Pa6Ykixw+0og==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 11:03:41 -0700
IronPort-SDR: Q80k8Bc+NXeNq7d93kJzPFjR6F/h43K/+CinJeJdlI8LpthtHGAVPr3HkIDxp3FepUZABhwXvT
 PNzil8/aLlDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="340984491"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga001.jf.intel.com with ESMTP; 12 May 2020 11:03:41 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 May 2020 11:03:41 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.64]) with mapi id 14.03.0439.000;
 Tue, 12 May 2020 11:03:40 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     bauen1 <j2468h@googlemail.com>, selinux <selinux@vger.kernel.org>
Subject: RE: [PATCH] mcstransd: fix memory leak in new_context_str
Thread-Topic: [PATCH] mcstransd: fix memory leak in new_context_str
Thread-Index: AQHWKIYzi7HT0SdYV02i7lI50t3vKqikvijA
Date:   Tue, 12 May 2020 18:03:39 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649EDD3FF@ORSMSX101.amr.corp.intel.com>
References: <6f2dc066-1f5b-1ea8-be48-73ae2b977b44@gmail.com>
In-Reply-To: <6f2dc066-1f5b-1ea8-be48-73ae2b977b44@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzZWxpbnV4LW93bmVyQHZnZXIu
a2VybmVsLm9yZyBbbWFpbHRvOnNlbGludXgtb3duZXJAdmdlci5rZXJuZWwub3JnXQ0KPiBPbiBC
ZWhhbGYgT2YgYmF1ZW4xDQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAxMiwgMjAyMCAxMjo1MyBQTQ0K
PiBUbzogc2VsaW51eCA8c2VsaW51eEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtQQVRD
SF0gbWNzdHJhbnNkOiBmaXggbWVtb3J5IGxlYWsgaW4gbmV3X2NvbnRleHRfc3RyDQo+IA0KPiBU
aGUgcmV0dXJuIHZhbHVlIG9mIGNvbnRleHRfbmV3IG5lZWRzIHRvIGJlIGZyZWUgd2l0aCBjb250
ZXh0X2ZyZWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBiYXVlbjEgPGoyNDY4aEBnbWFpbC5jb20+
DQo+IC0tLQ0KPiAgbWNzdHJhbnMvc3JjL21jc3RyYW5zLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21jc3RyYW5zL3NyYy9tY3N0
cmFucy5jIGIvbWNzdHJhbnMvc3JjL21jc3RyYW5zLmMgaW5kZXgNCj4gOTZiZGJkZmYuLjIxMTZi
MTYxIDEwMDY0NA0KPiAtLS0gYS9tY3N0cmFucy9zcmMvbWNzdHJhbnMuYw0KPiArKysgYi9tY3N0
cmFucy9zcmMvbWNzdHJhbnMuYw0KPiBAQCAtOTE5LDYgKzkxOSw3IEBAIG5ld19jb250ZXh0X3N0
cihjb25zdCBzZWN1cml0eV9jb250ZXh0X3QgaW5jb24sIGNvbnN0DQo+IGNoYXIgKnJhbmdlKSB7
DQo+ICAJfQ0KPiAgCWNvbnRleHRfcmFuZ2Vfc2V0KGNvbiwgcmFuZ2UpOw0KPiAgCXJjb24gPSBz
dHJkdXAoY29udGV4dF9zdHIoY29uKSk7DQo+ICsJY29udGV4dF9mcmVlKGNvbik7DQo+ICAJaWYg
KCFyY29uKSB7DQo+ICAJCWdvdG8gZXhpdDsNCj4gIAl9DQo+IC0tDQo+IDIuMjYuMg0KDQpBY2tl
ZC1ieTogV2lsbGlhbSBSb2JlcnRzIDx3aWxsaWFtLmMucm9iZXJ0c0BpbnRlbC5jb20+DQo=
