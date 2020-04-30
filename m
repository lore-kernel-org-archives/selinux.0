Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771EAC47247
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4552076D
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgD3Pbh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:31:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:15431 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgD3Pbg (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 30 Apr 2020 11:31:36 -0400
IronPort-SDR: bThQG0fU/4hAUb+erLYoPveP9eX9yKJIMISEOFdbWkhj4sroUx7kt3B8KyP2p1AHX0Jndw+qrW
 oExi0Ordop7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 08:31:36 -0700
IronPort-SDR: lmuoaWp9Gyo7WLDuFSlqLrn8xBd2JWdWrn0KFKI0kWsrR1navOZttdzKC46eYHvVN8T9Mr6J4p
 q9OhENQWUf1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="261817795"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga006.jf.intel.com with ESMTP; 30 Apr 2020 08:31:35 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Apr 2020 08:31:35 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.34]) with mapi id 14.03.0439.000;
 Thu, 30 Apr 2020 08:31:35 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEfDtnR0c2NoZQ==?= <cgzones@googlemail.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH v2] libselinux: mark security_context_t typedef as
 deprecated
Thread-Topic: [PATCH v2] libselinux: mark security_context_t typedef as
 deprecated
Thread-Index: AQHWHwCUS2T6nDItlEOtOVxdUdlq1qiRyj5A
Date:   Thu, 30 Apr 2020 15:31:34 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649ED8BA3@ORSMSX101.amr.corp.intel.com>
References: <20200420114650.19093-1-cgzones@googlemail.com>
 <20200430150318.6406-1-cgzones@googlemail.com>
In-Reply-To: <20200430150318.6406-1-cgzones@googlemail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzZWxpbnV4LW93bmVyQHZnZXIu
a2VybmVsLm9yZyBbbWFpbHRvOnNlbGludXgtb3duZXJAdmdlci5rZXJuZWwub3JnXQ0KPiBPbiBC
ZWhhbGYgT2YgQ2hyaXN0aWFuIEfDtnR0c2NoZQ0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMzAs
IDIwMjAgMTA6MDMgQU0NCj4gVG86IHNlbGludXhAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFtQQVRDSCB2Ml0gbGlic2VsaW51eDogbWFyayBzZWN1cml0eV9jb250ZXh0X3QgdHlwZWRlZiBh
cyBkZXByZWNhdGVkDQo+IA0KPiBGb2xsb3ctdXAgb2Y6IDllYjljOTMyNzU2MzAxNGFkNmE4MDc4
MTRlNzk3NTQyNDY0MmQ1YjkgKCJHZXQgcmlkIG9mDQo+IHNlY3VyaXR5X2NvbnRleHRfdCBhbmQg
Zml4IGNvbnN0IGRlY2xhcmF0aW9ucy4iKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFu
IEfDtnR0c2NoZSA8Y2d6b25lc0Bnb29nbGVtYWlsLmNvbT4NCj4gLS0tDQo+IHYyOiB1c2UgdGhl
IGNvbW1vbiBkZXByZWNhdGlvbiBzdHlsZQ0KPiANCj4gIGxpYnNlbGludXgvaW5jbHVkZS9zZWxp
bnV4L3NlbGludXguaCB8IDYgKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGlic2VsaW51eC9pbmNsdWRl
L3NlbGludXgvc2VsaW51eC5oDQo+IGIvbGlic2VsaW51eC9pbmNsdWRlL3NlbGludXgvc2VsaW51
eC5oDQo+IGluZGV4IGFhZjI4ZmZkLi5jMjI4MzRlNSAxMDA2NDQNCj4gLS0tIGEvbGlic2VsaW51
eC9pbmNsdWRlL3NlbGludXgvc2VsaW51eC5oDQo+ICsrKyBiL2xpYnNlbGludXgvaW5jbHVkZS9z
ZWxpbnV4L3NlbGludXguaA0KPiBAQCAtMTQsNyArMTQsMTEgQEAgZXh0ZXJuIGludCBpc19zZWxp
bnV4X2VuYWJsZWQodm9pZCk7ICBleHRlcm4gaW50DQo+IGlzX3NlbGludXhfbWxzX2VuYWJsZWQo
dm9pZCk7DQo+IA0KPiAgLyogTm8gbG9uZ2VyIHVzZWQ7IGhlcmUgZm9yIGNvbXBhdGliaWxpdHkg
d2l0aCBsZWdhY3kgY2FsbGVycy4gKi8gLXR5cGVkZWYgY2hhcg0KPiAqc2VjdXJpdHlfY29udGV4
dF90Ow0KPiArdHlwZWRlZiBjaGFyICpzZWN1cml0eV9jb250ZXh0X3QNCj4gKyNpZmRlZiBfX0dO
VUNfXw0KPiArX19hdHRyaWJ1dGVfXyAoKGRlcHJlY2F0ZWQpKQ0KPiArI2VuZGlmDQo+ICs7DQo+
IA0KPiAgLyogRnJlZSB0aGUgbWVtb3J5IGFsbG9jYXRlZCBmb3IgYSBjb250ZXh0IGJ5IGFueSBv
ZiB0aGUgYmVsb3cgZ2V0KiBjYWxscy4gKi8NCj4gZXh0ZXJuIHZvaWQgZnJlZWNvbihjaGFyICog
Y29uKTsNCj4gLS0NCj4gMi4yNi4yDQoNCkFja2VkLWJ5OiBXaWxsaWFtIFJvYmVydHMgPHdpbGxp
YW0uYy5yb2JlcnRzQGludGVsLmNvbT4NCg==
