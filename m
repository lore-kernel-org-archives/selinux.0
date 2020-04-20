Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C99C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 14:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B02421D94
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 14:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgDTOb3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:31:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:36768 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbgDTOb2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 20 Apr 2020 10:31:28 -0400
IronPort-SDR: xDMNnJ2mD9bR2dG5OhV0+onuxKar6QGEzjQdc5MsMKCS+i3ldftGDr5NkYOUlnQw7GYx2fXar1
 QNACMgUjH95g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 07:31:28 -0700
IronPort-SDR: 2M3A3RFqroIaFMCuatTck9V4szL11iaD8OJ6vdCM30y+CEQjLMpoukLyGxImh1sn2X6omLwVUa
 Jdq9xajbpfGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="243833301"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2020 07:31:28 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 07:31:28 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.140]) with mapi id 14.03.0439.000;
 Mon, 20 Apr 2020 07:31:27 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
CC:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: RE: Deprecated Annotations in libselinux
Thread-Topic: Deprecated Annotations in libselinux
Thread-Index: AQHWE2pcJQMaD8/wnku4WuMTjpiWDKiA7bKAgAEroLA=
Date:   Mon, 20 Apr 2020 14:31:27 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649ED3B8F@ORSMSX101.amr.corp.intel.com>
References: <CAFftDdpOQzZazxrEhZZR198GJBiuZOLBMkTnxN3_JnzyD01Kdg@mail.gmail.com>
 <CAJfZ7==7Q1ur3Jozo0XBovwh6XsM17pqb=CcGv4f6RLzHxbEmQ@mail.gmail.com>
In-Reply-To: <CAJfZ7==7Q1ur3Jozo0XBovwh6XsM17pqb=CcGv4f6RLzHxbEmQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc2VsaW51eC1vd25lckB2
Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpzZWxpbnV4LW93bmVyQHZnZXIua2VybmVsLm9yZ10NCj4g
T24gQmVoYWxmIE9mIE5pY29sYXMgSW9vc3MNCj4gU2VudDogU3VuZGF5LCBBcHJpbCAxOSwgMjAy
MCA4OjM3IEFNDQo+IFRvOiBXaWxsaWFtIFJvYmVydHMgPGJpbGwuYy5yb2JlcnRzQGdtYWlsLmNv
bT47IFNFbGludXggbGlzdA0KPiA8c2VsaW51eEB2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBTdGVw
aGVuIFNtYWxsZXkgPHNkc0B0eWNoby5uc2EuZ292Pg0KPiBTdWJqZWN0OiBSZTogRGVwcmVjYXRl
ZCBBbm5vdGF0aW9ucyBpbiBsaWJzZWxpbnV4DQo+IA0KPiBPbiBXZWQsIEFwciAxNSwgMjAyMCBh
dCAxMToxMCBQTSBXaWxsaWFtIFJvYmVydHMgPGJpbGwuYy5yb2JlcnRzQGdtYWlsLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPiBTbyBJIGFtIHJldml2aW5nIHRoZSB3b3JrIHRvIGxvb2sgYXQgYW5u
b3RhdGluZyBkZXByZWNhdGVkIGZ1bmN0aW9ucy4NCj4gPiBJIHdhcyB3b25kZXJpbmcgd2hhdCBm
b2xrcyBhcmUgdGhpbmtpbmcgYXJvdW5kIHRoZSB1dGlsaXR5IHByb2dyYW0NCj4gPiBtYXRjaHBh
dGhjb24sIHNpbmNlIHRoYXQgaW50ZXJmYWNlIGlzIGRlcHJlY2F0ZWQsIGRvIHdlIHdhbnQgdG86
DQo+ID4NCj4gPiAxLiBsaW5rIHRoYXQgc3RhdGljYWxseSBzbyB3ZSBjYW4gdXNlIGludGVybmFs
IChub24tZGVwcmVjYXRlZCkNCj4gPiBmdW5jdGlvbnMgMi4gdXBkYXRlIGl0IHRvIHVzZSBzZWxh
YmVsX29wZW4gYW5kIGZyaWVuZHMuDQo+ID4gMy4gS2VlcCBpdCBidXQgaGF2ZSBpdCBwcmludCBv
dXQgImRlcHJlY2F0ZWQiIGFuZCByZXR1cm4gMS4NCj4gPiA0LiBTb21lIG1peCBvZiBvcHRpb25z
IDMgYW5kIDENCj4gDQo+IEhlbGxvLA0KPiBJIGRpZCBub3QgcmVhbGx5IGZvbGxvdyBjbG9zZWx5
IHdoeSBmdW5jdGlvbnMgYXJlIGdldHRpbmcgZGVwcmVjYXRlZC4NCj4gPkZyb20gdGhlIHBhdGNo
IHNlcmllcywgaXQgYXBwZWFycyB0aGF0IG1hdGNocGF0aGNvbl9pbml0KCkgaXMgYmVpbmcNCj4g
ZGVwcmVjYXRlZCBpbiBmYXZvciBvZiBzZWxhYmVsX29wZW4oKS4gVGhhdCBjYW4gbWFrZSBzZW5z
ZS4NCg0KVGhleSBoYXZlIGJlZW4gZGVwcmVjYXRlZCBmb3IgYSBsb25nIHRpbWUsIEltIGp1c3Qg
aW52ZXN0b2dhdGluZ3VzaW5nIHRoZSBkZXByZWNhdGVkDQpBbm5vdGF0aW9uIHRvIGVuY291cmFn
ZSBmb2xrcyB0byBtb3ZlIHRvIHRoZSBuZXcgaW50ZXJmYWNlcyBhbmQgc3VnZ2VzdCB0aGUgbmV3
DQpJbnRlcmZhY2UgaW4gdGhlIHdhcm5pbmcgbWVzc2FnZS4NCg0KPiANCj4gPkZyb20gYSBDTEkg
cGVyc3BlY3RpdmUsIHRoZSBpbnRlcmZhY2Ugb2Ygc2VsYWJlbF9sb29rdXAgc2VlbXMgdG8gYmUN
Cj4gbW9yZSBjb21wbGV4IHRvIHVzZSB0aGF0IG1hdGNocGF0aGNvbjoNCj4gDQo+ICQgbWF0Y2hw
YXRoY29uIC9ldGMvc2hhZG93DQo+IC9ldGMvc2hhZG93IHN5c3RlbV91Om9iamVjdF9yOnNoYWRv
d190DQo+ICQgc2VsYWJlbF9sb29rdXAgLWIgZmlsZSAtayAvZXRjL3NoYWRvdw0KPiBEZWZhdWx0
IGNvbnRleHQ6IHN5c3RlbV91Om9iamVjdF9yOnNoYWRvd190DQo+IA0KPiBNb3Jlb3ZlciwgbG9v
a2luZyBhdCBzZWxhYmVsX2xvb2t1cCAtLWhlbHAsIGl0IHdhcyBub3QgY2xlYXIgdGhhdCB0aGUg
ZmlsZSBmb3Igd2hpY2gNCj4gSSB3YW50ZWQgdGhlIGNvbnRleHQgbmVlZHMgdG8gYmUgZ2l2ZW4g
YXMgYSAtayBvcHRpb24sIGJlY2F1c2UgdGhlIHVzYWdlIGxpbmUNCj4gc3RhdGVzICJbLWYgZmls
ZV0iICh0aGF0IG1lYW5zIHNvbWV0aGluZyBlbHNlKS4NCj4gVGhpcyBpbmNyZWFzZXMgdGhlIGRp
ZmZpY3VsdHkgb2YgdXNpbmcgc2VsYWJlbF9sb29rdXAgaW5zdGVhZCBvZiBtYXRjaHBhdGhjb24u
DQo+IFRoZXJlZm9yZSBhcyBhIFNFTGludXggdXNlciwgSSB3b3VsZCByYXRoZXIga2VlcCBtYXRj
aHBhdGhjb24gcHJvZ3JhbS4gV291bGQNCj4gaXQgYmUgZGlmZmljdWx0IHRvIGltcGxlbWVudCBv
cHRpb24gMiAidXBkYXRlIG1hdGNocGF0aGNvbiB0byB1c2Ugc2VsYWJlbF9vcGVuKCkNCj4gYW5k
IGZyaWVuZHMiPw0KDQpJJ20gbGVhdmluZyB0aGUgaW50ZXJmYWNlcyB0aGUgc2FtZSBpbiB0aGlz
IHNlcmllcywgYW5kIHdlIGNhbiB1cGRhdGUgbWF0Y2hwYXRoY29uIGxhdGVyLg0KVGhlIG9ubHkg
dGhpbmcgSSBhbSBhZGRpbmcgaXMgYSBkZXByZWNhdGVkIG1lc3NhZ2UgdG8gc3RkZXJyIGZvciB0
aGUgbWF0Y2hwYXRoY29uIHV0aWwsDQp3aGljaCB3ZSBjYW4gZHJvcC4NCg0KPiANCj4gVGhhdCBi
ZWluZyBzYWlkLCBpZiBhbm90aGVyIG9wdGlvbiBpcyBjaG9zZW4sIEkgd2lsbCBhZGQgImFsaWFz
DQo+IG1hdGNocGF0aGNvbj1zZWxhYmVsX2xvb2t1cCAtYiBmaWxlIC1rIiB0byBteSBzaGVsbCBj
b25maWd1cmF0aW9uIGFuZCBiZSBnb29kDQo+IHdpdGggaXQuIFRoaXMgd291bGQgd29yayBmb3Ig
bWUgYmVjYXVzZSBJIG5ldmVyIHVzZWQgYW55IG9wdGlvbiB0aGF0DQo+IG1hdGNocGF0aGNvbiBw
cm92aWRlcy4NCj4gDQo+IEFueXdheSwgdGhhbmtzIGZvciB3b3JraW5nIG9uIHRoaXMgc3ViamVj
dCENCj4gTmljb2xhcw0KDQo=
