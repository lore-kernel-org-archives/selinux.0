Return-Path: <SRS0=0U01=5I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28172C4332E
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 19:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086CF2051A
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 19:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCWTDR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:03:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:44856 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbgCWTDR (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 23 Mar 2020 15:03:17 -0400
IronPort-SDR: SWbx3oD2g8pS+TPa/2p1DYSUTnc5jbT+cGxcYzOLPeSO1SqHyTU0aiqgR6F2gGKjGYILpzJbf+
 9dzUFnFD19yQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 12:03:16 -0700
IronPort-SDR: fEoAA5WUkPHxYysKzPQaVNiO0l3pqlZbM4IeIDQSyPk8Nfpl0MurA49cphlhsfQZbdj6t3wU+o
 T1bJ7/8E25xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="235310263"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2020 12:03:15 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 12:03:14 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.225]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.22]) with mapi id 14.03.0439.000;
 Mon, 23 Mar 2020 12:03:14 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEfDtnR0c2NoZQ==?= <cgzones@googlemail.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH] checkpolicy: add missing forward declaration
Thread-Topic: [PATCH] checkpolicy: add missing forward declaration
Thread-Index: AQHWAUCmIv1byiS0n0CNNbrNXO8rDqhWiM/w
Date:   Mon, 23 Mar 2020 19:03:14 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649EB1BAF@ORSMSX101.amr.corp.intel.com>
References: <20200323182633.12384-1-cgzones@googlemail.com>
In-Reply-To: <20200323182633.12384-1-cgzones@googlemail.com>
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
ZWhhbGYgT2YgQ2hyaXN0aWFuIEfDtnR0c2NoZQ0KPiBTZW50OiBNb25kYXksIE1hcmNoIDIzLCAy
MDIwIDE6MjcgUE0NCj4gVG86IHNlbGludXhAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQ
QVRDSF0gY2hlY2twb2xpY3k6IGFkZCBtaXNzaW5nIGZvcndhcmQgZGVjbGFyYXRpb24NCj4gDQo+
IHBvbGljeV9zY2FuLmw6Mjk0OjM6IHdhcm5pbmc6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1
bmN0aW9uICd5eWVycm9yJyBpcw0KPiANCj4gICAgICAgaW52YWxpZCBpbiBDOTkgWy1XaW1wbGlj
aXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+IA0KPiB7IHl5ZXJyb3IoInVucmVjb2duaXplZCBj
aGFyYWN0ZXIiKTt9DQo+IA0KPiAgIF4NCj4gDQo+IHBvbGljeV9zY2FuLmw6Mjk0OjM6IHdhcm5p
bmc6IHRoaXMgZnVuY3Rpb24gZGVjbGFyYXRpb24gaXMgbm90IGEgcHJvdG90eXBlDQo+IA0KPiAg
ICAgICBbLVdzdHJpY3QtcHJvdG90eXBlc10NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlh
biBHw7Z0dHNjaGUgPGNnem9uZXNAZ29vZ2xlbWFpbC5jb20+DQo+IC0tLQ0KPiAgY2hlY2twb2xp
Y3kvcG9saWN5X3NjYW4ubCB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvY2hlY2twb2xpY3kvcG9saWN5X3NjYW4ubCBiL2NoZWNrcG9s
aWN5L3BvbGljeV9zY2FuLmwgaW5kZXgNCj4gMDk0NjQ1ZDEuLjQwNjcyNjhiIDEwMDY0NA0KPiAt
LS0gYS9jaGVja3BvbGljeS9wb2xpY3lfc2Nhbi5sDQo+ICsrKyBiL2NoZWNrcG9saWN5L3BvbGlj
eV9zY2FuLmwNCj4gQEAgLTM3LDYgKzM3LDcgQEAgdHlwZWRlZiBpbnQgKCogcmVxdWlyZV9mdW5j
X3QpKHZvaWQpOyAgc3RhdGljIGNoYXINCj4gbGluZWJ1ZlsyXVsyNTVdOyAgc3RhdGljIHVuc2ln
bmVkIGludCBsbm8gPSAwOyAgaW50IHdlcnJvciA9IDA7DQo+ICtpbnQgeXllcnJvcihjb25zdCBj
aGFyICptc2cpOw0KPiAgaW50IHl5d2Fybihjb25zdCBjaGFyICptc2cpOw0KPiANCj4gIHZvaWQg
c2V0X3NvdXJjZV9maWxlKGNvbnN0IGNoYXIgKm5hbWUpOw0KPiAtLQ0KPiAyLjI2LjAucmMyDQoN
CkFja2VkLWJ5OiBXaWxsaWFtIFJvYmVydHMgPHdpbGxpYW0uYy5yb2JlcnRzQGludGVsLmNvbT4N
Cg==
