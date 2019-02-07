Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8437EC282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 18:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AD92086C
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 18:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfBGSXA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:23:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:16230 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfBGSXA (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 7 Feb 2019 13:23:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 10:22:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="142445325"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga004.fm.intel.com with ESMTP; 07 Feb 2019 10:22:59 -0800
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 7 Feb 2019 10:22:58 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.140]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.44]) with mapi id 14.03.0415.000;
 Thu, 7 Feb 2019 10:22:58 -0800
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
CC:     Ondrej Mosnacek <omosnace@redhat.com>
Subject: RE: gcc 9.0.0 build issues
Thread-Topic: gcc 9.0.0 build issues
Thread-Index: AQHUvuJhk/X56/euxEuWv2uHzMSJg6XUnZywgACNX4D//3ovwIAAhuiA//96bpA=
Date:   Thu, 7 Feb 2019 18:22:58 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649CDF50E@ORSMSX101.amr.corp.intel.com>
References: <pjdtvhns3pq.fsf@redhat.com>
 <CAFqZXNt8Df0KX9qVmsGtxZroy6s1SFBt1Qmi5Psuv6z0+kTB7Q@mail.gmail.com>
 <pjdlg2rydoj.fsf@redhat.com>
 <476DC76E7D1DF2438D32BFADF679FC5649CDF45F@ORSMSX101.amr.corp.intel.com>
 <3a9f2281-aad4-58fd-ab8e-cb99a8da0fae@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC5649CDF4F5@ORSMSX101.amr.corp.intel.com>
 <4a32cbaa-4dfa-e4e7-d113-fd03d6225554@tycho.nsa.gov>
In-Reply-To: <4a32cbaa-4dfa-e4e7-d113-fd03d6225554@tycho.nsa.gov>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBTbWFsbGV5
IFttYWlsdG86c2RzQHR5Y2hvLm5zYS5nb3ZdDQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA3
LCAyMDE5IDEwOjIxIEFNDQo+IFRvOiBSb2JlcnRzLCBXaWxsaWFtIEMgPHdpbGxpYW0uYy5yb2Jl
cnRzQGludGVsLmNvbT47IFBldHIgTGF1dHJiYWNoDQo+IDxwbGF1dHJiYUByZWRoYXQuY29tPjsg
c2VsaW51eEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE9uZHJlaiBNb3NuYWNlayA8b21vc25hY2VA
cmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IGdjYyA5LjAuMCBidWlsZCBpc3N1ZXMNCj4gDQo+
IE9uIDIvNy8xOSAxOjE4IFBNLCBSb2JlcnRzLCBXaWxsaWFtIEMgd3JvdGU6DQo+ID4NCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBTdGVwaGVuIFNtYWxs
ZXkgW21haWx0bzpzZHNAdHljaG8ubnNhLmdvdl0NCj4gPj4gU2VudDogVGh1cnNkYXksIEZlYnJ1
YXJ5IDcsIDIwMTkgMTA6MTcgQU0NCj4gPj4gVG86IFJvYmVydHMsIFdpbGxpYW0gQyA8d2lsbGlh
bS5jLnJvYmVydHNAaW50ZWwuY29tPjsgUGV0ciBMYXV0cmJhY2gNCj4gPj4gPHBsYXV0cmJhQHJl
ZGhhdC5jb20+OyBzZWxpbnV4QHZnZXIua2VybmVsLm9yZw0KPiA+PiBDYzogT25kcmVqIE1vc25h
Y2VrIDxvbW9zbmFjZUByZWRoYXQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogZ2NjIDkuMC4wIGJ1
aWxkIGlzc3Vlcw0KPiA+Pg0KPiA+PiBPbiAyLzcvMTkgMTI6NTIgUE0sIFJvYmVydHMsIFdpbGxp
YW0gQyB3cm90ZToNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+Pj4gRnJvbTogUGV0ciBMYXV0cmJhY2ggW21haWx0bzpwbGF1dHJiYUByZWRoYXQu
Y29tXQ0KPiA+Pj4+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA3LCAyMDE5IDQ6NDAgQU0NCj4g
Pj4+PiBUbzogc2VsaW51eEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4+PiBDYzogUGV0ciBMYXV0cmJh
Y2ggPHBsYXV0cmJhQHJlZGhhdC5jb20+OyBSb2JlcnRzLCBXaWxsaWFtIEMNCj4gPj4+PiA8d2ls
bGlhbS5jLnJvYmVydHNAaW50ZWwuY29tPjsgT25kcmVqIE1vc25hY2VrDQo+ID4+Pj4gPG9tb3Nu
YWNlQHJlZGhhdC5jb20+DQo+ID4+Pj4gU3ViamVjdDogUmU6IGdjYyA5LjAuMCBidWlsZCBpc3N1
ZXMNCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gT25kcmVqIE1vc25hY2VrIDxvbW9zbmFjZUByZWRo
YXQuY29tPiB3cml0ZXM6DQo+ID4+Pj4NCj4gPj4+Pj4gT24gRnJpLCBGZWIgMSwgMjAxOSBhdCA4
OjM2IFBNIFBldHIgTGF1dHJiYWNoDQo+ID4+Pj4+IDxwbGF1dHJiYUByZWRoYXQuY29tPg0KPiA+
Pj4+PiB3cm90ZToNCj4gPj4+Pj4+IGdjYy05LjAuMC0wLjMuZmMzMC54ODZfNjQgZnJvbSBGZWRv
cmEgUmF3aGlkZToNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBnY2MgdmVyc2lvbiA5LjAuMCAyMDE5MDEx
OSAoUmVkIEhhdCA5LjAuMC0wLjMpIChHQ0MpDQo+ID4+Pj4+Pg0KPiA+Pj4+IC4uLg0KPiA+Pj4+
Pj4gV2hlbiBsaWJzZWxpbnV4IGlzIGJ1aWx0IHNlcGFyYXRlbHksIG90aGVyIENGTEFHUyBpcyB1
c2VkOg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICQgY2QgbGlic2VsaW51eA0KPiA+Pj4+Pj4NCj4gPj4+
Pj4+ICQgbWFrZSBERVNURElSPX4vb2JqIGluc3RhbGwgaW5zdGFsbC1weXdyYXAgLi4uDQo+ID4+
Pj4+Pg0KPiA+Pj4+Pj4gbWFrZVsxXTogRW50ZXJpbmcgZGlyZWN0b3J5DQo+ID4+Pj4+PiAnL2hv
bWUvYnVpbGQvU0VMaW51eFByb2plY3Qtc2VsaW51eC9saWJzZWxpbnV4L3NyYycNCj4gPj4+Pj4+
DQo+ID4+Pj4+PiBjYyAtTyAtV2FsbCAtVyAtV3VuZGVmIC1XZm9ybWF0LXkyayAtV2Zvcm1hdC1z
ZWN1cml0eSAtV2luaXQtc2VsZg0KPiA+Pj4+Pj4gLVdtaXNzaW5nLWluY2x1ZGUtZGlycyAtV3Vu
dXNlZCAtV3Vua25vd24tcHJhZ21hcw0KPiA+Pj4+Pj4gLVdzdHJpY3QtYWxpYXNpbmcgLVdzaGFk
b3cgLVdwb2ludGVyLWFyaXRoIC1XYmFkLWZ1bmN0aW9uLWNhc3QNCj4gPj4+Pj4+IC1XY2FzdC1h
bGlnbiAtV3dyaXRlLXN0cmluZ3MgLVdhZ2dyZWdhdGUtcmV0dXJuDQo+ID4+Pj4+PiAtV3N0cmlj
dC1wcm90b3R5cGVzIC1Xb2xkLXN0eWxlLWRlZmluaXRpb24gLVdtaXNzaW5nLXByb3RvdHlwZXMN
Cj4gPj4+Pj4+IC1XbWlzc2luZy1kZWNsYXJhdGlvbnMgLVdtaXNzaW5nLW5vcmV0dXJuDQo+ID4+
Pj4+PiAtV21pc3NpbmctZm9ybWF0LWF0dHJpYnV0ZSAtV3JlZHVuZGFudC1kZWNscyAtV25lc3Rl
ZC1leHRlcm5zDQo+ID4+Pj4+PiAtV2lubGluZSAtV2ludmFsaWQtcGNoIC1Xdm9sYXRpbGUtcmVn
aXN0ZXItdmFyDQo+ID4+Pj4+PiAtV2Rpc2FibGVkLW9wdGltaXphdGlvbiAtV2J1aWx0aW4tbWFj
cm8tcmVkZWZpbmVkIC1XYXR0cmlidXRlcw0KPiA+Pj4+Pj4gLVdtdWx0aWNoYXIgLVdkZXByZWNh
dGVkLWRlY2xhcmF0aW9ucyAtV2Rpdi1ieS16ZXJvDQo+ID4+Pj4+PiAtV2RvdWJsZS1wcm9tb3Rp
b24gLVdlbmRpZi1sYWJlbHMgLVdleHRyYSAtV2Zvcm1hdC1leHRyYS1hcmdzDQo+ID4+Pj4+PiAt
V2Zvcm1hdC16ZXJvLWxlbmd0aCAtV2Zvcm1hdD0yIC1XbXVsdGljaGFyIC1Xb3ZlcmZsb3cNCj4g
Pj4+Pj4+IC1XcG9pbnRlci10by1pbnQtY2FzdCAtV3ByYWdtYXMgLVduby1taXNzaW5nLWZpZWxk
LWluaXRpYWxpemVycw0KPiA+Pj4+Pj4gLVduby1zaWduLWNvbXBhcmUgLVduby1mb3JtYXQtbm9u
bGl0ZXJhbA0KPiA+Pj4+Pj4gLVdmcmFtZS1sYXJnZXItdGhhbj0zMjc2OA0KPiA+Pj4+Pj4gLWZz
dGFjay1wcm90ZWN0b3ItYWxsIC0tcGFyYW09c3NwLWJ1ZmZlci1zaXplPTQgLWZleGNlcHRpb25z
DQo+ID4+Pj4+PiAtZmFzeW5jaHJvbm91cy11bndpbmQtdGFibGVzIC1mZGlhZ25vc3RpY3Mtc2hv
dy1vcHRpb24NCj4gPj4+Pj4+IC1mdW5pdC1hdC1hLXRpbWUgLVdlcnJvciAtV25vLWFnZ3JlZ2F0
ZS1yZXR1cm4NCj4gPj4+Pj4+IC1Xbm8tcmVkdW5kYW50LWRlY2xzIC1maXBhLXB1cmUtY29uc3Qg
LVdsb2dpY2FsLW9wDQo+ID4+Pj4+PiAtV3BhY2tlZC1iaXRmaWVsZC1jb21wYXQgLVdzeW5jLW5h
bmQgLVdjb3ZlcmFnZS1taXNtYXRjaCAtV2NwcA0KPiA+Pj4+Pj4gLVdmb3JtYXQtY29udGFpbnMt
bnVsIC1Xbm9ybWFsaXplZD1uZmMgLVdzdWdnZXN0LWF0dHJpYnV0ZT1jb25zdA0KPiA+Pj4+Pj4g
LVdzdWdnZXN0LWF0dHJpYnV0ZT1ub3JldHVybiAtV3N1Z2dlc3QtYXR0cmlidXRlPXB1cmUNCj4g
Pj4+Pj4+IC1XdHJhbXBvbGluZXMgLVdqdW1wLW1pc3Nlcy1pbml0IC1Xbm8tc3VnZ2VzdC1hdHRy
aWJ1dGU9cHVyZQ0KPiA+Pj4+Pj4gLVduby1zdWdnZXN0LWF0dHJpYnV0ZT1jb25zdCAtVV9GT1JU
SUZZX1NPVVJDRQ0KPiA+Pj4+Pj4gLURfRk9SVElGWV9TT1VSQ0U9Mg0KPiA+Pj4+Pj4gLVdzdHJp
Y3Qtb3ZlcmZsb3c9NSAtSS4uL2luY2x1ZGUgLURfR05VX1NPVVJDRQ0KPiA+Pj4+Pj4gLUROT19B
TkRST0lEX0JBQ0tFTkQgICAtYyAtbyBib29sZWFucy5vIGJvb2xlYW5zLmMNCj4gPj4+Pj4+IGJv
b2xlYW5zLmM6IEluIGZ1bmN0aW9uIOKAmHNlY3VyaXR5X2dldF9ib29sZWFuX25hbWVz4oCZOg0K
PiA+Pj4+Pj4gYm9vbGVhbnMuYzozOTo1OiBlcnJvcjogYXNzdW1pbmcgc2lnbmVkIG92ZXJmbG93
IGRvZXMgbm90IG9jY3VyDQo+ID4+Pj4+PiB3aGVuIGNoYW5naW5nIFggKy0gQzEgY21wIEMyIHRv
IFggY21wIEMyIC0rIEMxIFstV2Vycm9yPXN0cmljdC0NCj4gb3ZlcmZsb3ddDQo+ID4+Pj4+PiAg
ICAgIDM5IHwgaW50IHNlY3VyaXR5X2dldF9ib29sZWFuX25hbWVzKGNoYXIgKioqbmFtZXMsIGlu
dCAqbGVuKQ0KPiA+Pj4+Pj4gICAgICAgICB8ICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fg0KPiA+Pj4+Pj4gY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCj4g
Pj4+Pj4NCj4gPj4+Pj4gVGhpcyBvbmUgaXMgcmVhbGx5IHdlaXJkLi4uIFBlcmhhcHMgYSBidWcg
aW4gR0NDPyBBdCB0aGUgdmVyeQ0KPiA+Pj4+PiBsZWFzdCB0aGUgd2FybmluZyBtZXNzYWdlIGFu
ZCBzb3VyY2UgY29kZSBsb2NhdGlvbiBhcmUgc3VwZXINCj4gPj4+Pj4gY29uZnVzaW5nLCB3aGlj
aCBpcyBhIGJ1ZyBvbiBpdHMgb3duLi4uDQo+ID4+Pj4NCj4gPj4+PiBJdCdzIGRldGVjdGVkIG9u
bHkgd2l0aCAtV3N0cmljdC1vdmVyZmxvdz0zIGFuZCBoaWdoZXIuIE1ha2VmaWxlIGluDQo+ID4+
Pj4gbGlic2VsaW51eCB1c2VzIGxldmVsIDUgd2hpY2ggd2FzIGFkZGVkIGJ5IGNvbW1pdA0KPiA+
Pj4+IDlmZTQzMDM0NSAoIk1ha2VmaWxlOiBhZGQgLVdzdHJpY3Qtb3ZlcmZsb3c9NSB0byBDRkxB
R1MpDQo+ID4+Pj4NCj4gPj4+PiBUaGUgcHJvYmxlbSBjb2RlIGlzIG9uIGxpbmVzIDg0IGFuZCA4
NSBpbg0KPiA+Pj4+IGxpYnNlbGludXgvc3JjL2Jvb2xlYW5zLmM6DQo+ID4+Pj4NCj4gPj4+PiA4
NDoJZm9yICgtLWk7IGkgPj0gMDsgLS1pKQ0KPiA+Pj4+IDg1OiAgICBmcmVlKG5baV0pOw0KPiA+
Pj4+DQo+ID4+Pj4NCj4gPj4+PiBJdCBjb3VsZCBiZSBzdXBwcmVzc2VkIGJ5IHNvbWV0aGluZyBs
aWtlIHRoaXM6DQo+ID4+Pj4NCj4gPj4+PiAtLS0gYS9saWJzZWxpbnV4L3NyYy9ib29sZWFucy5j
DQo+ID4+Pj4gKysrIGIvbGlic2VsaW51eC9zcmMvYm9vbGVhbnMuYw0KPiA+Pj4+IEBAIC0zOSw3
ICszOSw3IEBAIHN0YXRpYyBpbnQgZmlsZW5hbWVfc2VsZWN0KGNvbnN0IHN0cnVjdCBkaXJlbnQN
Cj4gPj4+PiAqZCkNCj4gPj4+PiAgICBpbnQgc2VjdXJpdHlfZ2V0X2Jvb2xlYW5fbmFtZXMoY2hh
ciAqKipuYW1lcywgaW50ICpsZW4pICB7DQo+ID4+Pj4gICAgICAgICAgIGNoYXIgcGF0aFtQQVRI
X01BWF07DQo+ID4+Pj4gLSAgICAgICBpbnQgaSwgcmM7DQo+ID4+Pj4gKyAgICAgICBpbnQgaSwg
aiwgcmM7DQo+ID4+Pj4gICAgICAgICAgIHN0cnVjdCBkaXJlbnQgKipuYW1lbGlzdDsNCj4gPj4+
PiAgICAgICAgICAgY2hhciAqKm47DQo+ID4+Pj4NCj4gPj4+PiBAQCAtODEsOCArODEsOCBAQCBp
bnQgc2VjdXJpdHlfZ2V0X2Jvb2xlYW5fbmFtZXMoY2hhciAqKipuYW1lcywgaW50DQo+ID4+ICps
ZW4pDQo+ID4+Pj4gICAgICAgICAgIGZyZWUobmFtZWxpc3QpOw0KPiA+Pj4+ICAgICAgICAgICBy
ZXR1cm4gcmM7DQo+ID4+Pj4gICAgICAgICAgYmFkX2ZyZWVuOg0KPiA+Pj4+IC0gICAgICAgZm9y
ICgtLWk7IGkgPj0gMDsgLS1pKQ0KPiA+Pj4+IC0gICAgICAgICAgICAgICBmcmVlKG5baV0pOw0K
PiA+Pj4+ICsgICAgICAgZm9yIChqID0gMDsgaiA8IGk7IGorKykNCj4gPj4+PiArICAgICAgICAg
ICAgICAgZnJlZShuW2pdKTsNCj4gPj4+PiAgICAgICAgICAgZnJlZShuKTsNCj4gPj4+PiAgICAg
ICAgICBiYWQ6DQo+ID4+Pj4gICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+Pj4+DQo+ID4+Pj4NCj4g
Pj4+PiBXaWxsaWFtLCB3aGF0IHdvdWxkIHlvdSBjb25zaWRlciB0byBiZSB0aGUgcmlnaHQgZml4
IGluIHRoaXMgY2FzZT8NCj4gPj4+DQo+ID4+PiBUaGUgcHJldmlvdXMgY29kZSBsb29rcyBjb3Jy
ZWN0IElNTywgSSBjYW4ndCBzZWUgYW4gYWN0dWFsIHByb2JsZW0uDQo+ID4+PiBMb29rcyBsaWtl
IEdDQyBjb21wbGFpbmluZyBpbmNvcnJlY3RseSBvciB3ZXJlIG1pc3Npbmcgc29tZXRoaW5nLiBJ
bg0KPiA+Pj4gdGhlIGNhc2Ugb2YgZ2NjIEluY29ycmVjdGx5IGNvbXBsYWluaW5nIEkgdXN1YWxs
eSB0YWtlIGEgY291cnNlIG9mDQo+ID4+PiBhY3Rpb24gdG8gd29yayBhcm91bmQgaXQsIGJ1dCBJ
bSBub3Qgc3VyZSBob3cgb3RoZXIgbWFpbnRhaW5lcnMgZmVlbA0KPiA+Pj4gYWJvdXQgdGhhdA0K
PiA+PiBAc2RzIGFueXRoaW5nPw0KPiA+Pg0KPiA+PiBBRkFJQ1MsIHRoZSBjb2RlIGlzIGNvcnJl
Y3QgYXMgaXMuICBOb3QgYSBmYW4gb2YgcmV3cml0aW5nIGNvZGUgdG8NCj4gPj4gYXBwZWFzZSBv
dmVybHkgemVhbG91cyBjb21waWxlcnMuLi4NCj4gPj4NCj4gPiBJIGd1ZXNzIHdob21ldmVyIGlz
IGJ1aWxkaW5nIGNhbiBvdmVycmlkZSBDRkxBR1MgYW5kIGRyb3AgdGhlIHZhbHVlDQo+ID4gZG93
bi4gV2Ugc2hvdWxkIFByb2JhYmx5IGZpbGUgYSBidWcgd2l0aCBnY2M/DQo+IA0KPiBZZXMsIHRo
YXQgd291bGQgYmUgaGVscGZ1bCBpZiBzb21lb25lIGNvdWxkIGRvIHRoYXQuDQo+IA0KT24gaXQN
Cg==
