Return-Path: <SRS0=pD7g=VW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329EBC76190
	for <selinux@archiver.kernel.org>; Thu, 25 Jul 2019 18:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14446206DD
	for <selinux@archiver.kernel.org>; Thu, 25 Jul 2019 18:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfGYS6f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:58:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:15219 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfGYS6f (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 25 Jul 2019 14:58:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 11:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="164277231"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2019 11:58:34 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 25 Jul 2019 11:58:34 -0700
Received: from BGSMSX107.gar.corp.intel.com (10.223.4.191) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 25 Jul 2019 11:58:33 -0700
Received: from bgsmsx101.gar.corp.intel.com ([169.254.1.176]) by
 BGSMSX107.gar.corp.intel.com ([169.254.9.209]) with mapi id 14.03.0439.000;
 Fri, 26 Jul 2019 00:28:28 +0530
From:   "Gote, Nitin R" <nitin.r.gote@intel.com>
To:     Jann Horn <jannh@google.com>, Ondrej Mosnacek <omosnace@redhat.com>
CC:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [PATCH] selinux: avoid atomic_t usage in sidtab
Thread-Topic: [PATCH] selinux: avoid atomic_t usage in sidtab
Thread-Index: AQHVQvE4rlvESAbbQE2d4U56CmypaabbEPSAgACZUmA=
Date:   Thu, 25 Jul 2019 18:58:27 +0000
Message-ID: <12356C813DFF6F479B608F81178A561587B055@BGSMSX101.gar.corp.intel.com>
References: <20190725135933.30046-1-omosnace@redhat.com>
 <CAG48ez3ii7wFyX9BLrehGwHAPERnR3EY49Ky-3M=yJKsY-xkXg@mail.gmail.com>
In-Reply-To: <CAG48ez3ii7wFyX9BLrehGwHAPERnR3EY49Ky-3M=yJKsY-xkXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTk5ZDU1NDctZGZjNC00ZjkyLWFhYWYtNDNmNzhmZDBjYjFhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZUd3N2lYK1pmZzVQMkRcL1pubkpHc25aWWJpdUlITjBRZlRJdURVSCt3OThIZUlBNG5oZ1BuT0JQNVlFcXJIdGkifQ==
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFubiBIb3JuIFttYWls
dG86amFubmhAZ29vZ2xlLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgMjUsIDIwMTkgODoy
OSBQTQ0KPiBUbzogT25kcmVqIE1vc25hY2VrIDxvbW9zbmFjZUByZWRoYXQuY29tPg0KPiBDYzog
U0VsaW51eCBsaXN0IDxzZWxpbnV4QHZnZXIua2VybmVsLm9yZz47IFBhdWwgTW9vcmUgPHBhdWxA
cGF1bC0NCj4gbW9vcmUuY29tPjsgR290ZSwgTml0aW4gUiA8bml0aW4uci5nb3RlQGludGVsLmNv
bT47IEtlZXMgQ29vaw0KPiA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBzZWxpbnV4OiBhdm9pZCBhdG9taWNfdCB1c2FnZSBpbiBzaWR0YWINCj4gDQo+IE9u
IFRodSwgSnVsIDI1LCAyMDE5IGF0IDM6NTkgUE0gT25kcmVqIE1vc25hY2VrIDxvbW9zbmFjZUBy
ZWRoYXQuY29tPg0KPiB3cm90ZToNCj4gPiBBcyBub3RlZCBpbiBEb2N1bWVudGF0aW9uL2F0b21p
Y190LnR4dCwgaWYgd2UgZG9uJ3QgbmVlZCB0aGUgUk1XDQo+ID4gYXRvbWljIG9wZXJhdGlvbnMs
IHdlIHNob3VsZCBvbmx5IHVzZSBSRUFEX09OQ0UoKS9XUklURV9PTkNFKCkgKw0KPiA+IHNtcF9y
bWIoKS9zbXBfd21iKCkgd2hlcmUgbmVjZXNzYXJ5IChvciB0aGUgY29tYmluZWQgdmFyaWFudHMN
Cj4gPiBzbXBfbG9hZF9hY3F1aXJlKCkvc21wX3N0b3JlX3JlbGVhc2UoKSkuDQo+ID4NCj4gPiBU
aGlzIHBhdGNoIGNvbnZlcnRzIHRoZSBzaWR0YWIgY29kZSB0byB1c2UgcmVndWxhciB1MzIgZm9y
IHRoZSBjb3VudGVyDQo+ID4gYW5kIHJldmVyc2UgbG9va3VwIGNhY2hlIGFuZCB1c2UgdGhlIGFw
cHJvcHJpYXRlIG9wZXJhdGlvbnMgaW5zdGVhZCBvZg0KPiA+IGF0b21pY19nZXQoKS9hdG9taWNf
c2V0KCkuIE5vdGUgdGhhdCB3aGVuIHJlYWRpbmcvdXBkYXRpbmcgdGhlIHJldmVyc2UNCj4gPiBs
b29rdXAgY2FjaGUgd2UgZG9uJ3QgbmVlZCBtZW1vcnkgYmFycmllcnMgYXMgaXQgZG9lc24ndCBu
ZWVkIHRvIGJlDQo+ID4gY29uc2lzdGVudCBvciBhY2N1cmF0ZS4gV2UgY2FuIG5vdyBhbHNvIHJl
cGxhY2Ugc29tZSBhdG9taWMgb3BzIHdpdGgNCj4gPiByZWd1bGFyIGxvYWRzICh3aGVuIHVuZGVy
IHNwaW5sb2NrKSBhbmQgc3RvcmVzIChmb3IgY29udmVyc2lvbiB0YXJnZXQNCj4gPiBmaWVsZHMg
dGhhdCBhcmUgYWx3YXlzIGFjY2Vzc2VkIHVuZGVyIHRoZSBtYXN0ZXIgdGFibGUncyBzcGlubG9j
aykuDQo+ID4NCj4gPiBXZSBjYW4gbm93IGFsc28gYnVtcCBTSURUQUJfTUFYIHRvIFUzMl9NQVgg
YXMgd2UgY2FuIHVzZSB0aGUgZnVsbA0KPiB1MzINCj4gPiByYW5nZSBhZ2Fpbi4NCj4gPg0KPiA+
IFN1Z2dlc3RlZC1ieTogSmFubiBIb3JuIDxqYW5uaEBnb29nbGUuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE9uZHJlaiBNb3NuYWNlayA8b21vc25hY2VAcmVkaGF0LmNvbT4NCj4gDQo+IExvb2tz
IGdvb2QgdG8gbWU7IHlvdSBjYW4gYWRkICJSZXZpZXdlZC1ieTogSmFubiBIb3JuDQo+IDxqYW5u
aEBnb29nbGUuY29tPiIgaWYgeW91IHdhbnQuDQoNCkxvb2tzIGdvb2QgdG8gbWUgYWxzbzsNCk1h
eSBiZSB0aGVyZSBhcmUgbWFueSBwbGFjZXMgaW4ga2VybmVsIHdoZXJlLCBhdG9taWNfdCBpcyBu
b3QgcmVxdWlyZWQsIGFzIHdlIGNhbWUgdG8ga25vdyBpbiBzaWR0YWIuYyAuIA0KDQpUaGFua3Ms
DQpOaXRpbg0KDQoNCg==
