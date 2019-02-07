Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D05C282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 17:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52812083B
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 17:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfBGRwf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:52:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:34082 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfBGRwf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 7 Feb 2019 12:52:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 09:52:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="273284097"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga004.jf.intel.com with ESMTP; 07 Feb 2019 09:52:33 -0800
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 7 Feb 2019 09:52:34 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.140]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.240]) with mapi id 14.03.0415.000;
 Thu, 7 Feb 2019 09:52:34 -0800
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     Petr Lautrbach <plautrba@redhat.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>
CC:     Ondrej Mosnacek <omosnace@redhat.com>
Subject: RE: gcc 9.0.0 build issues
Thread-Topic: gcc 9.0.0 build issues
Thread-Index: AQHUvuJhk/X56/euxEuWv2uHzMSJg6XUnZyw
Date:   Thu, 7 Feb 2019 17:52:32 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649CDF45F@ORSMSX101.amr.corp.intel.com>
References: <pjdtvhns3pq.fsf@redhat.com>
 <CAFqZXNt8Df0KX9qVmsGtxZroy6s1SFBt1Qmi5Psuv6z0+kTB7Q@mail.gmail.com>
 <pjdlg2rydoj.fsf@redhat.com>
In-Reply-To: <pjdlg2rydoj.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ciBMYXV0cmJhY2gg
W21haWx0bzpwbGF1dHJiYUByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkg
NywgMjAxOSA0OjQwIEFNDQo+IFRvOiBzZWxpbnV4QHZnZXIua2VybmVsLm9yZw0KPiBDYzogUGV0
ciBMYXV0cmJhY2ggPHBsYXV0cmJhQHJlZGhhdC5jb20+OyBSb2JlcnRzLCBXaWxsaWFtIEMNCj4g
PHdpbGxpYW0uYy5yb2JlcnRzQGludGVsLmNvbT47IE9uZHJlaiBNb3NuYWNlayA8b21vc25hY2VA
cmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IGdjYyA5LjAuMCBidWlsZCBpc3N1ZXMNCj4gDQo+
IA0KPiBPbmRyZWogTW9zbmFjZWsgPG9tb3NuYWNlQHJlZGhhdC5jb20+IHdyaXRlczoNCj4gDQo+
ID4gT24gRnJpLCBGZWIgMSwgMjAxOSBhdCA4OjM2IFBNIFBldHIgTGF1dHJiYWNoIDxwbGF1dHJi
YUByZWRoYXQuY29tPg0KPiA+IHdyb3RlOg0KPiA+PiBnY2MtOS4wLjAtMC4zLmZjMzAueDg2XzY0
IGZyb20gRmVkb3JhIFJhd2hpZGU6DQo+ID4+DQo+ID4+IGdjYyB2ZXJzaW9uIDkuMC4wIDIwMTkw
MTE5IChSZWQgSGF0IDkuMC4wLTAuMykgKEdDQykNCj4gPj4NCj4gLi4uDQo+ID4+IFdoZW4gbGli
c2VsaW51eCBpcyBidWlsdCBzZXBhcmF0ZWx5LCBvdGhlciBDRkxBR1MgaXMgdXNlZDoNCj4gPj4N
Cj4gPj4gJCBjZCBsaWJzZWxpbnV4DQo+ID4+DQo+ID4+ICQgbWFrZSBERVNURElSPX4vb2JqIGlu
c3RhbGwgaW5zdGFsbC1weXdyYXAgLi4uDQo+ID4+DQo+ID4+IG1ha2VbMV06IEVudGVyaW5nIGRp
cmVjdG9yeQ0KPiA+PiAnL2hvbWUvYnVpbGQvU0VMaW51eFByb2plY3Qtc2VsaW51eC9saWJzZWxp
bnV4L3NyYycNCj4gPj4NCj4gPj4gY2MgLU8gLVdhbGwgLVcgLVd1bmRlZiAtV2Zvcm1hdC15Mmsg
LVdmb3JtYXQtc2VjdXJpdHkgLVdpbml0LXNlbGYNCj4gPj4gLVdtaXNzaW5nLWluY2x1ZGUtZGly
cyAtV3VudXNlZCAtV3Vua25vd24tcHJhZ21hcyAtV3N0cmljdC1hbGlhc2luZw0KPiA+PiAtV3No
YWRvdyAtV3BvaW50ZXItYXJpdGggLVdiYWQtZnVuY3Rpb24tY2FzdCAtV2Nhc3QtYWxpZ24NCj4g
Pj4gLVd3cml0ZS1zdHJpbmdzIC1XYWdncmVnYXRlLXJldHVybiAtV3N0cmljdC1wcm90b3R5cGVz
DQo+ID4+IC1Xb2xkLXN0eWxlLWRlZmluaXRpb24gLVdtaXNzaW5nLXByb3RvdHlwZXMgLVdtaXNz
aW5nLWRlY2xhcmF0aW9ucw0KPiA+PiAtV21pc3Npbmctbm9yZXR1cm4gLVdtaXNzaW5nLWZvcm1h
dC1hdHRyaWJ1dGUgLVdyZWR1bmRhbnQtZGVjbHMNCj4gPj4gLVduZXN0ZWQtZXh0ZXJucyAtV2lu
bGluZSAtV2ludmFsaWQtcGNoIC1Xdm9sYXRpbGUtcmVnaXN0ZXItdmFyDQo+ID4+IC1XZGlzYWJs
ZWQtb3B0aW1pemF0aW9uIC1XYnVpbHRpbi1tYWNyby1yZWRlZmluZWQgLVdhdHRyaWJ1dGVzDQo+
ID4+IC1XbXVsdGljaGFyIC1XZGVwcmVjYXRlZC1kZWNsYXJhdGlvbnMgLVdkaXYtYnktemVybw0K
PiA+PiAtV2RvdWJsZS1wcm9tb3Rpb24gLVdlbmRpZi1sYWJlbHMgLVdleHRyYSAtV2Zvcm1hdC1l
eHRyYS1hcmdzDQo+ID4+IC1XZm9ybWF0LXplcm8tbGVuZ3RoIC1XZm9ybWF0PTIgLVdtdWx0aWNo
YXIgLVdvdmVyZmxvdw0KPiA+PiAtV3BvaW50ZXItdG8taW50LWNhc3QgLVdwcmFnbWFzIC1Xbm8t
bWlzc2luZy1maWVsZC1pbml0aWFsaXplcnMNCj4gPj4gLVduby1zaWduLWNvbXBhcmUgLVduby1m
b3JtYXQtbm9ubGl0ZXJhbA0KPiA+PiAtV2ZyYW1lLWxhcmdlci10aGFuPTMyNzY4DQo+ID4+IC1m
c3RhY2stcHJvdGVjdG9yLWFsbCAtLXBhcmFtPXNzcC1idWZmZXItc2l6ZT00IC1mZXhjZXB0aW9u
cw0KPiA+PiAtZmFzeW5jaHJvbm91cy11bndpbmQtdGFibGVzIC1mZGlhZ25vc3RpY3Mtc2hvdy1v
cHRpb24NCj4gPj4gLWZ1bml0LWF0LWEtdGltZSAtV2Vycm9yIC1Xbm8tYWdncmVnYXRlLXJldHVy
biAtV25vLXJlZHVuZGFudC1kZWNscw0KPiA+PiAtZmlwYS1wdXJlLWNvbnN0IC1XbG9naWNhbC1v
cCAtV3BhY2tlZC1iaXRmaWVsZC1jb21wYXQgLVdzeW5jLW5hbmQNCj4gPj4gLVdjb3ZlcmFnZS1t
aXNtYXRjaCAtV2NwcCAtV2Zvcm1hdC1jb250YWlucy1udWwgLVdub3JtYWxpemVkPW5mYw0KPiA+
PiAtV3N1Z2dlc3QtYXR0cmlidXRlPWNvbnN0IC1Xc3VnZ2VzdC1hdHRyaWJ1dGU9bm9yZXR1cm4N
Cj4gPj4gLVdzdWdnZXN0LWF0dHJpYnV0ZT1wdXJlIC1XdHJhbXBvbGluZXMgLVdqdW1wLW1pc3Nl
cy1pbml0DQo+ID4+IC1Xbm8tc3VnZ2VzdC1hdHRyaWJ1dGU9cHVyZSAtV25vLXN1Z2dlc3QtYXR0
cmlidXRlPWNvbnN0DQo+ID4+IC1VX0ZPUlRJRllfU09VUkNFDQo+ID4+IC1EX0ZPUlRJRllfU09V
UkNFPTINCj4gPj4gLVdzdHJpY3Qtb3ZlcmZsb3c9NSAtSS4uL2luY2x1ZGUgLURfR05VX1NPVVJD
RQ0KPiA+PiAtRE5PX0FORFJPSURfQkFDS0VORCAgIC1jIC1vIGJvb2xlYW5zLm8gYm9vbGVhbnMu
Yw0KPiA+PiBib29sZWFucy5jOiBJbiBmdW5jdGlvbiDigJhzZWN1cml0eV9nZXRfYm9vbGVhbl9u
YW1lc+KAmToNCj4gPj4gYm9vbGVhbnMuYzozOTo1OiBlcnJvcjogYXNzdW1pbmcgc2lnbmVkIG92
ZXJmbG93IGRvZXMgbm90IG9jY3VyIHdoZW4NCj4gPj4gY2hhbmdpbmcgWCArLSBDMSBjbXAgQzIg
dG8gWCBjbXAgQzIgLSsgQzEgWy1XZXJyb3I9c3RyaWN0LW92ZXJmbG93XQ0KPiA+PiAgICAzOSB8
IGludCBzZWN1cml0eV9nZXRfYm9vbGVhbl9uYW1lcyhjaGFyICoqKm5hbWVzLCBpbnQgKmxlbikN
Cj4gPj4gICAgICAgfCAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gPj4gY2MxOiBh
bGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCj4gPg0KPiA+IFRoaXMgb25lIGlz
IHJlYWxseSB3ZWlyZC4uLiBQZXJoYXBzIGEgYnVnIGluIEdDQz8gQXQgdGhlIHZlcnkgbGVhc3QN
Cj4gPiB0aGUgd2FybmluZyBtZXNzYWdlIGFuZCBzb3VyY2UgY29kZSBsb2NhdGlvbiBhcmUgc3Vw
ZXIgY29uZnVzaW5nLA0KPiA+IHdoaWNoIGlzIGEgYnVnIG9uIGl0cyBvd24uLi4NCj4gDQo+IEl0
J3MgZGV0ZWN0ZWQgb25seSB3aXRoIC1Xc3RyaWN0LW92ZXJmbG93PTMgYW5kIGhpZ2hlci4gTWFr
ZWZpbGUgaW4gbGlic2VsaW51eCB1c2VzDQo+IGxldmVsIDUgd2hpY2ggd2FzIGFkZGVkIGJ5IGNv
bW1pdA0KPiA5ZmU0MzAzNDUgKCJNYWtlZmlsZTogYWRkIC1Xc3RyaWN0LW92ZXJmbG93PTUgdG8g
Q0ZMQUdTKQ0KPiANCj4gVGhlIHByb2JsZW0gY29kZSBpcyBvbiBsaW5lcyA4NCBhbmQgODUgaW4N
Cj4gbGlic2VsaW51eC9zcmMvYm9vbGVhbnMuYzoNCj4gDQo+IDg0Oglmb3IgKC0taTsgaSA+PSAw
OyAtLWkpDQo+IDg1OiAgICBmcmVlKG5baV0pOw0KPiANCj4gDQo+IEl0IGNvdWxkIGJlIHN1cHBy
ZXNzZWQgYnkgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gDQo+IC0tLSBhL2xpYnNlbGludXgvc3Jj
L2Jvb2xlYW5zLmMNCj4gKysrIGIvbGlic2VsaW51eC9zcmMvYm9vbGVhbnMuYw0KPiBAQCAtMzks
NyArMzksNyBAQCBzdGF0aWMgaW50IGZpbGVuYW1lX3NlbGVjdChjb25zdCBzdHJ1Y3QgZGlyZW50
DQo+ICpkKQ0KPiAgaW50IHNlY3VyaXR5X2dldF9ib29sZWFuX25hbWVzKGNoYXIgKioqbmFtZXMs
IGludCAqbGVuKSAgew0KPiAgICAgICAgIGNoYXIgcGF0aFtQQVRIX01BWF07DQo+IC0gICAgICAg
aW50IGksIHJjOw0KPiArICAgICAgIGludCBpLCBqLCByYzsNCj4gICAgICAgICBzdHJ1Y3QgZGly
ZW50ICoqbmFtZWxpc3Q7DQo+ICAgICAgICAgY2hhciAqKm47DQo+IA0KPiBAQCAtODEsOCArODEs
OCBAQCBpbnQgc2VjdXJpdHlfZ2V0X2Jvb2xlYW5fbmFtZXMoY2hhciAqKipuYW1lcywgaW50ICps
ZW4pDQo+ICAgICAgICAgZnJlZShuYW1lbGlzdCk7DQo+ICAgICAgICAgcmV0dXJuIHJjOw0KPiAg
ICAgICAgYmFkX2ZyZWVuOg0KPiAtICAgICAgIGZvciAoLS1pOyBpID49IDA7IC0taSkNCj4gLSAg
ICAgICAgICAgICAgIGZyZWUobltpXSk7DQo+ICsgICAgICAgZm9yIChqID0gMDsgaiA8IGk7IGor
KykNCj4gKyAgICAgICAgICAgICAgIGZyZWUobltqXSk7DQo+ICAgICAgICAgZnJlZShuKTsNCj4g
ICAgICAgIGJhZDoNCj4gICAgICAgICBnb3RvIG91dDsNCj4gDQo+IA0KPiBXaWxsaWFtLCB3aGF0
IHdvdWxkIHlvdSBjb25zaWRlciB0byBiZSB0aGUgcmlnaHQgZml4IGluIHRoaXMgY2FzZT8NCg0K
VGhlIHByZXZpb3VzIGNvZGUgbG9va3MgY29ycmVjdCBJTU8sIEkgY2FuJ3Qgc2VlIGFuIGFjdHVh
bCBwcm9ibGVtLiBMb29rcyBsaWtlDQpHQ0MgY29tcGxhaW5pbmcgaW5jb3JyZWN0bHkgb3Igd2Vy
ZSBtaXNzaW5nIHNvbWV0aGluZy4gSW4gdGhlIGNhc2Ugb2YgZ2NjDQpJbmNvcnJlY3RseSBjb21w
bGFpbmluZyBJIHVzdWFsbHkgdGFrZSBhIGNvdXJzZSBvZiBhY3Rpb24gdG8gd29yayBhcm91bmQg
aXQsIGJ1dA0KSW0gbm90IHN1cmUgaG93IG90aGVyIG1haW50YWluZXJzIGZlZWwgYWJvdXQgdGhh
dCBAc2RzIGFueXRoaW5nPw0KDQoNCg==
