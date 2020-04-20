Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C79C3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 14:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6DF120735
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 14:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgDTOe4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:34:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:41953 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbgDTOe4 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 20 Apr 2020 10:34:56 -0400
IronPort-SDR: 0z4lHzkKjcXKipMAHG5W0s+mQ5JtLhEvlo1ZrlBB3ZVTDEst6iZPONaiOxByafT3dCpIenjZ8Z
 jxe1GFacjkQw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 07:34:55 -0700
IronPort-SDR: mIQP8/GbLMCBwvX0ZQGkyFusireXfh1gFw2V5qWChyAuow4dO52ij5aKCDkmI7L8QkKxchoXE3
 Nxdy5k3ikguQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="273198876"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2020 07:34:55 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 07:34:54 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.87]) with mapi id 14.03.0439.000;
 Mon, 20 Apr 2020 07:34:54 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        William Roberts <bill.c.roberts@gmail.com>
CC:     SElinux list <selinux@vger.kernel.org>
Subject: RE: Annotate Deprecated Functions in libselinux
Thread-Topic: Annotate Deprecated Functions in libselinux
Thread-Index: AQHWFAXq+NdaXpOJJkWnQSc+HI/A2KiA7zAAgAEpxEA=
Date:   Mon, 20 Apr 2020 14:34:54 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649ED3BA6@ORSMSX101.amr.corp.intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200416154352.21619-1-william.c.roberts@intel.com>
 <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
In-Reply-To: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
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
MCA4OjQ3IEFNDQo+IFRvOiBXaWxsaWFtIFJvYmVydHMgPGJpbGwuYy5yb2JlcnRzQGdtYWlsLmNv
bT4NCj4gQ2M6IFNFbGludXggbGlzdCA8c2VsaW51eEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1Ympl
Y3Q6IFJlOiBBbm5vdGF0ZSBEZXByZWNhdGVkIEZ1bmN0aW9ucyBpbiBsaWJzZWxpbnV4DQo+IA0K
PiBIZWxsbywNCj4gDQo+IERvZXMgIm1ha2UgaW5zdGFsbCAmJiBtYWtlIGluc3RhbGwtcHl3cmFw
IiB3b3JrcyBmb3IgeW91PyBPbiBib3RoIG15DQoNCk5vIGJlY2F1c2UgSSBkaWRuJ3QgYnVpbGQg
dGhlIHB5dGhvbiBiaW5kaW5ncywgSSB0b3RhbCBmb3Jnb3QuDQoNCj4gZGV2ZWxvcG1lbnQgc3lz
dGVtIChBcmNoIExpbnV4IHdpdGggc3dpZyA0LjAuMSkgYW5kIFRyYXZpcy1DSSAoaHR0cHM6Ly90
cmF2aXMtDQo+IGNpLm9yZy9naXRodWIvZmlzaGlsaWNvL3NlbGludXgvam9icy82NzU4NDI3MTkp
LCBzd2lnIGZhaWxzIHRvIGJ1aWxkIGxpYnNlbGludXgNCj4gUHl0aG9uIGJpbmRpbmdzICh3aXRo
IHlvdXIgcGF0Y2hlcyk6DQo+IA0KPiBidWlsZGluZyAnc2VsaW51eC5fc2VsaW51eCcgZXh0ZW5z
aW9uDQo+IHN3aWdnaW5nIHNlbGludXhzd2lnX3B5dGhvbi5pIHRvIHNlbGludXhzd2lnX3B5dGhv
bl93cmFwLmMgc3dpZyAtcHl0aG9uIC1vDQo+IHNlbGludXhzd2lnX3B5dGhvbl93cmFwLmMgc2Vs
aW51eHN3aWdfcHl0aG9uLmkNCj4gLi4vaW5jbHVkZS9zZWxpbnV4L2F2Yy5oOjY3OiBFcnJvcjog
U3ludGF4IGVycm9yIC0gcG9zc2libHkgYSBtaXNzaW5nIHNlbWljb2xvbi4NCj4gZXJyb3I6IGNv
bW1hbmQgJ3N3aWcnIGZhaWxlZCB3aXRoIGV4aXQgc3RhdHVzIDENCj4gTWFrZWZpbGU6MTMzOiBy
ZWNpcGUgZm9yIHRhcmdldCAncHl3cmFwJyBmYWlsZWQNCj4gDQo+IFRoZSBwcm9ibGVtYXRpYyBs
aW5lIGlzOg0KPiANCj4gZXh0ZXJuIGludCBzaWRnZXQoc2VjdXJpdHlfaWRfdCBzaWQpIF9fYXR0
cmlidXRlX18gKChkZXByZWNhdGVkKSk7DQo+IA0KPiBJdCBzZWVtcyB0aGF0IHN3aWcgZG9lcyBu
b3QgdW5kZXJzdGFuZCB0aGlzIGF0dHJpYnV0ZS4NCg0KWWVhaCwgSSBhZ3JlZSB3aXRoIHlvdXIg
dHJpYWdlIG9mIHRoZSBpc3N1ZS4gSSB0aGluayBJJ2xsIGhhdmUgdG8gZGVmaW5lIGENCkRFUFJF
Q0FURUQoKSBtYWNybyBhbmQgdHVybiBpdCBvZmYgd2hlbiBTV0lHIGlzIGRlZmluZWQuDQoNCldl
IGFsc28gbWlnaHQgZXZlbiB3YW50IHRvIGNvbnNpZGVyIHVzaW5nOg0KaHR0cHM6Ly9weXBpLm9y
Zy9wcm9qZWN0L0RlcHJlY2F0ZWQvDQoNCg0KPiANCj4gTmljb2xhcw0KPiANCj4gT24gVGh1LCBB
cHIgMTYsIDIwMjAgYXQgNTo0NCBQTSA8YmlsbC5jLnJvYmVydHNAZ21haWwuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IFYyOg0KPiA+IC0gU2ltcGxpZmllZCBub3cgdGhhdCBkc28uaCBzdHVmZiBoYXMg
YmVlbiByZW1vdmVkLg0KPiA+IC0gc2VsaW51eF9jaGVja19wYXNzd2RfYWNjZXNzIGhhcyBiZWVu
IGRlcHJlY2F0ZWQgYW5kIG5vdw0KPiA+ICAgYm90aCBzZWxpbnV4X2NoZWNrX3Bhc3N3ZF9hY2Nl
c3MgYW5kIGNoZWNrUGFzc3dkQWNjZXNzDQo+ID4gICBhcmUgcmVjb21lbmRpbmcgc2VsaW51eF9j
aGVja19hY2Nlc3MuDQo+ID4gLSBtYXRjaHBhdGhjb24gaXMgbGlua2VkIHN0YXRpY2FsbHkgdG8g
Z2V0IGFjY2VzcyB0byBkZXByZWNhdGVkDQo+ID4gICByb3V0aW5lcyBhbmQgcHJpbnRzIGEgZGVw
cmVjYXRlZCB3YXJuaW5nIHRvIHN0ZGVyci4NCj4gPg0KPiA+IFYxOg0KPiA+IEkgd2VudCB0aHJv
dWdoIGFuZCBhbm5vdGF0ZWQgZGVwcmVjYXRlZCByb3V0aW5lcyB3ZSBoYXZlIGluIGxpYnNlbGlu
dXgNCj4gPiB0aGF0IGFyZSBtZW50aW9uZWQgdG8gYmUgZGVwcmVjYXRlZCBlaXRoZXIgaW4gY29k
ZSBjb21tZW50cyBhbmQvb3INCj4gPiBtYW5wYWdlcy4NCj4gPg0KPiA+IEV4dGVybmFsIHVzZXJz
LCB3aGVuIGNvbXBpbGluZyB3aWxsIHNlZSBhIHdhcm5pbmcgc2ltaWxhaXIgdG8gc29tZQ0KPiA+
IHNhbXBsZSBvdXRwdXQ6DQo+ID4NCj4gPiBhLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6DQo+
ID4gYS5jOjE4OjI6IHdhcm5pbmc6IOKAmGZvb+KAmSBpcyBkZXByZWNhdGVkOiBmb28gYmFyIG1z
ZyBbLVdkZXByZWNhdGVkLWRlY2xhcmF0aW9uc10NCj4gPiAgIGZvbygpOw0KPiA+ICAgXn5+DQo+
ID4gYS5jOjU6NTogbm90ZTogZGVjbGFyZWQgaGVyZQ0KPiA+ICBpbnQgZm9vKHZvaWQpIHsNCj4g
PiAgICAgIF5+fg0KPiA+IGEuYzoxOToyOiB3YXJuaW5nOiDigJhib2/igJkgaXMgZGVwcmVjYXRl
ZCBbLVdkZXByZWNhdGVkLWRlY2xhcmF0aW9uc10NCj4gPiAgIGJvbygpOw0KPiA+ICAgXn5+DQo+
ID4gYS5jOjExOjU6IG5vdGU6IGRlY2xhcmVkIGhlcmUNCj4gPiAgaW50IGJvbyh2b2lkKSB7DQo+
ID4NCj4gPiBbUEFUQ0ggdjIgMDEvMThdIHNlY3VyaXR5X2xvYWRfYm9vbGVhbnM6IHVwZGF0ZSBy
ZXR1cm4gY29tbWVudCBbUEFUQ0gNCj4gPiB2MiAwMi8xOF0gc2VjdXJpdHlfbG9hZF9ib29sZWFu
czogYW5ub3RhdGUgZGVwcmVjYXRlZCBbUEFUQ0ggdjIgMDMvMThdDQo+ID4gc2VsaW51eF9ib29s
ZWFuc19wYXRoOiBhbm5vdGF0ZSBkZXByZWNhdGVkIFtQQVRDSCB2MiAwNC8xOF0NCj4gPiBzZWxp
bnV4X3VzZXJzX3BhdGg6IGFubm90YXRlIGRlcHJlY2F0ZWQgW1BBVENIIHYyIDA1LzE4XSBycG1f
ZXhlY2NvbjoNCj4gPiBhbm5vdGF0ZSBkZXByZWNhdGVkIFtQQVRDSCB2MiAwNi8xOF0gc2lkZ2V0
OiBhbm5vdGF0ZSBkZXByZWNhdGVkDQo+ID4gW1BBVENIIHYyIDA3LzE4XSBzaWRwdXQ6IGFubm90
YXRlIGRlcHJlY2F0ZWQgW1BBVENIIHYyIDA4LzE4XQ0KPiA+IGNoZWNrUGFzc3dkQWNjZXNzOiBh
bm5vdGF0ZSBkZXByZWNhdGVkIFtQQVRDSCB2MiAwOS8xOF0NCj4gPiBtYXRjaHBhdGhjb25faW5p
dDogYW5ub3RhdGUgZGVwcmVjYXRlZCBbUEFUQ0ggdjIgMTAvMThdDQo+ID4gbWF0Y2hwYXRoY29u
X2Zpbmk6IGFubm90YXRlIGRlcHJlY2F0ZWQgW1BBVENIIHYyIDExLzE4XSBtYXRjaHBhdGhjb246
DQo+ID4gYW5ub3RhdGUgZGVwcmVjYXRlZCBbUEFUQ0ggdjIgMTIvMThdIGF2Y19pbml0OiBhbm5v
dGF0ZSBkZXByZWNhdGVkDQo+ID4gW1BBVENIIHYyIDEzLzE4XSBhdmM6IGNyZWF0ZSBpbnRlcm5h
bCBhdmNfaW5pdCBpbnRlcmZhY2UgW1BBVENIIHYyDQo+ID4gMTQvMThdIG1hdGNocGF0aGNvbjog
Y3JlYXRlIGludGVybmFsIG1hdGNocGF0aGNvbl9maW5pIFtQQVRDSCB2Mg0KPiA+IDE1LzE4XSBt
YXRjaHBhdGhjb246IGNyZWF0ZSBpbnRlcm5hbCBtYXRjaHBhdGhjb24gaW50ZXJmYWNlIFtQQVRD
SCB2Mg0KPiA+IDE2LzE4XSBzZWxpbnV4X2NoZWNrX3Bhc3N3ZF9hY2Nlc3M6IGFubm90YXRlIGRl
cHJlY2F0ZWQgW1BBVENIIHYyDQo+ID4gMTcvMThdIHV0aWxzOiBtYXRjaHBhdGhjb24gdG8gdXNl
IGludGVyYWwgaW50ZXJmYWNlcyBbUEFUQ0ggdjIgMTgvMThdDQo+ID4gdXRpbHM6IG1hdGNocGF0
aGNvbiBhZGQgZGVwcmVjYXRlZCB3YXJuaW5nDQo+ID4NCg0K
