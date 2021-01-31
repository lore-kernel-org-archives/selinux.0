Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50660C433DB
	for <selinux@archiver.kernel.org>; Sun, 31 Jan 2021 10:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1311E64E0E
	for <selinux@archiver.kernel.org>; Sun, 31 Jan 2021 10:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhAaKiG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 31 Jan 2021 05:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230479AbhAaK3V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 31 Jan 2021 05:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612088875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGgUtQy/EotPb4+t3c0I8Em3zgpFP6WAj0sA+HmRbnQ=;
        b=WoFEVlwBHgLICXFE/5TaAIIK9l1ovnVVZ1YZvHaklCP3GDXpuXBTUBA6myzzAVlJL1iaXC
        Uja4y93mVNCW0KZlh6/JBrZPISSE60zqk9mviwS4AVUr0CSGlsFO3+osza+PgOsTGRiU+y
        Y3Z3dUGuW9Lp0sHpVXYQKqD0LIu4CPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-IwJ-zNevMv2pPNPqw1p_og-1; Sun, 31 Jan 2021 05:27:52 -0500
X-MC-Unique: IwJ-zNevMv2pPNPqw1p_og-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99F4C10054FF
        for <selinux@vger.kernel.org>; Sun, 31 Jan 2021 10:27:51 +0000 (UTC)
Received: from localhost (unknown [10.40.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BB8D5DA2E
        for <selinux@vger.kernel.org>; Sun, 31 Jan 2021 10:27:50 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setfiles: drop ABORT_ON_ERRORS and related code
In-Reply-To: <20210113210948.217575-2-plautrba@redhat.com>
References: <20210113210948.217575-1-plautrba@redhat.com>
 <20210113210948.217575-2-plautrba@redhat.com>
Date:   Sun, 31 Jan 2021 11:27:50 +0100
Message-ID: <875z3do0yh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

UGV0ciBMYXV0cmJhY2ggPHBsYXV0cmJhQHJlZGhhdC5jb20+IHdyaXRlczoNCg0KPiBgc2V0Zmls
ZXMgLWRgIGRvZXNuJ3QgaGF2ZSBhbnkgaW1wYWN0IG9uIG51bWJlciBvZiBlcnJvcnMgYmVmb3Jl
IGl0DQo+IGFib3J0cy4gSXQgYWx3YXlzIGFib3J0cyBvbiBmaXJzdCBpbnZhbGlkIGNvbnRleHQg
aW4gc3BlYyBmaWxlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIExhdXRyYmFjaCA8cGxhdXRy
YmFAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBwb2xpY3ljb3JldXRpbHMvc2V0ZmlsZXMvTWFrZWZp
bGUgICAgICB8ICAzIC0tLQ0KPiAgcG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3J1L3NldGZpbGVz
LjggfCAgMiArLQ0KPiAgcG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3NldGZpbGVzLjggICAgfCAg
MyArLS0NCj4gIHBvbGljeWNvcmV1dGlscy9zZXRmaWxlcy9zZXRmaWxlcy5jICAgIHwgMTggLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMjQg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9wb2xpY3ljb3JldXRpbHMvc2V0ZmlsZXMv
TWFrZWZpbGUgYi9wb2xpY3ljb3JldXRpbHMvc2V0ZmlsZXMvTWFrZWZpbGUNCj4gaW5kZXggYmM1
YThkYjc4OWE1Li5hM2JiYmUxMTZiN2YgMTAwNjQ0DQo+IC0tLSBhL3BvbGljeWNvcmV1dGlscy9z
ZXRmaWxlcy9NYWtlZmlsZQ0KPiArKysgYi9wb2xpY3ljb3JldXRpbHMvc2V0ZmlsZXMvTWFrZWZp
bGUNCj4gQEAgLTUsOCArNSw2IEBAIFNCSU5ESVIgPz0gL3NiaW4NCj4gIE1BTkRJUiA9ICQoUFJF
RklYKS9zaGFyZS9tYW4NCj4gIEFVRElUSCA/PSAkKHNoZWxsIHRlc3QgLWYgL3Vzci9pbmNsdWRl
L2xpYmF1ZGl0LmggJiYgZWNobyB5KQ0KPiAgDQo+IC1BQk9SVF9PTl9FUlJPUlM9JChzaGVsbCBn
cmVwICJeXCNkZWZpbmUgQUJPUlRfT05fRVJST1JTIiBzZXRmaWxlcy5jIHwgYXdrIC1TICd7IHBy
aW50ICQkMyB9JykNCj4gLQ0KPiAgQ0ZMQUdTID89IC1nIC1XZXJyb3IgLVdhbGwgLVcNCj4gIG92
ZXJyaWRlIExETElCUyArPSAtbHNlbGludXggLWxzZXBvbA0KPiAgDQo+IEBAIC0yNiw3ICsyNCw2
IEBAIHJlc3RvcmVjb25feGF0dHI6IHJlc3RvcmVjb25feGF0dHIubyByZXN0b3JlLm8NCj4gIA0K
PiAgbWFuOg0KPiAgCUBjcCAtYWYgc2V0ZmlsZXMuOCBzZXRmaWxlcy44Lm1hbg0KPiAtCUBzZWQg
LWkgInMvQUJPUlRfT05fRVJST1JTLyQoQUJPUlRfT05fRVJST1JTKS9nIiBzZXRmaWxlcy44Lm1h
bg0KPiAgDQo+ICBpbnN0YWxsOiBhbGwNCj4gIAlbIC1kICQoREVTVERJUikkKE1BTkRJUikvbWFu
OCBdIHx8IG1rZGlyIC1wICQoREVTVERJUikkKE1BTkRJUikvbWFuOA0KPiBkaWZmIC0tZ2l0IGEv
cG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3J1L3NldGZpbGVzLjggYi9wb2xpY3ljb3JldXRpbHMv
c2V0ZmlsZXMvcnUvc2V0ZmlsZXMuOA0KPiBpbmRleCAyNzgxNWEzZjFlZWUuLjkxMDEwMTQ1MjYy
NSAxMDA2NDQNCj4gLS0tIGEvcG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3J1L3NldGZpbGVzLjgN
Cj4gKysrIGIvcG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3J1L3NldGZpbGVzLjgNCj4gQEAgLTQ3
LDcgKzQ3LDcgQEAgc2V0ZmlsZXMgXC0g0YPRgdGC0LDQvdC+0LLQuNGC0YwgU0VMaW51eC3QutC+
0L3RgtC10LrRgdGC0Ysg0LHQtdC30L7Qv9Cw0YHQvdC+0YENCj4gINC/0YDQvtCy0LXRgNC40YLR
jCDQtNC10LnRgdGC0LLQuNGC0LXQu9GM0L3QvtGB0YLRjCDQutC+0L3RgtC10LrRgdGC0L7QsiDQ
vtGC0L3QvtGB0LjRgtC10LvRjNC90L4g0YPQutCw0LfQsNC90L3QvtC5INC00LLQvtC40YfQvdC+
0Lkg0L/QvtC70LjRgtC40LrQuC4NCj4gIC5UUA0KPiAgLkIgXC1kDQo+IC3Qv9C+0LrQsNC30LDR
gtGMLCDQutCw0LrQsNGPINGB0L/QtdGG0LjRhNC40LrQsNGG0LjRjyDRgdC+0L7RgtCy0LXRgtGB
0YLQstGD0LXRgiDQutCw0LbQtNC+0LzRgyDQuNC3INGE0LDQudC70L7QsiAo0L3QtSDQv9GA0LXQ
utGA0LDRidCw0YLRjCDQv9GA0L7QstC10YDQutGDINC/0L7RgdC70LUg0L/QvtC70YPRh9C10L3Q
uNGPINC+0YjQuNCx0L7QuiBBQk9SVF9PTl9FUlJPUlMpLg0KPiAr0L/QvtC60LDQt9Cw0YLRjCwg
0LrQsNC60LDRjyDRgdC/0LXRhtC40YTQuNC60LDRhtC40Y8g0YHQvtC+0YLQstC10YLRgdGC0LLR
g9C10YIg0LrQsNC20LTQvtC80YMg0LjQtyDRhNCw0LnQu9C+0LIuDQo+ICAuVFANCj4gIC5CSSBc
LWUgXCBkaXJlY3RvcnkNCj4gINC40YHQutC70Y7Rh9C40YLRjCDQutCw0YLQsNC70L7QsyAo0YfR
gtC+0LHRiyDQuNGB0LrQu9GO0YfQuNGC0Ywg0LHQvtC70LXQtSDQvtC00L3QvtCz0L4g0LrQsNGC
0LDQu9C+0LPQsCwg0Y3RgtC+0YIg0L/QsNGA0LDQvNC10YLRgCDQvdC10L7QsdGF0L7QtNC40LzQ
viDQuNGB0L/QvtC70YzQt9C+0LLQsNGC0Ywg0YHQvtC+0YLQstC10YLRgdGC0LLRg9GO0YnQtdC1
INC60L7Qu9C40YfQtdGB0YLQstC+INGA0LDQtykuDQo+IGRpZmYgLS1naXQgYS9wb2xpY3ljb3Jl
dXRpbHMvc2V0ZmlsZXMvc2V0ZmlsZXMuOCBiL3BvbGljeWNvcmV1dGlscy9zZXRmaWxlcy9zZXRm
aWxlcy44DQo+IGluZGV4IGUzMjhhNTYyODY4Mi4uNGQyOGJjOWE5NWMxIDEwMDY0NA0KPiAtLS0g
YS9wb2xpY3ljb3JldXRpbHMvc2V0ZmlsZXMvc2V0ZmlsZXMuOA0KPiArKysgYi9wb2xpY3ljb3Jl
dXRpbHMvc2V0ZmlsZXMvc2V0ZmlsZXMuOA0KPiBAQCAtNTcsOCArNTcsNyBAQCBvcHRpb24gd2ls
bCBmb3JjZSBhIHJlcGxhY2VtZW50IG9mIHRoZSBlbnRpcmUgY29udGV4dC4NCj4gIGNoZWNrIHRo
ZSB2YWxpZGl0eSBvZiB0aGUgY29udGV4dHMgYWdhaW5zdCB0aGUgc3BlY2lmaWVkIGJpbmFyeSBw
b2xpY3kuDQo+ICAuVFANCj4gIC5CIFwtZA0KPiAtc2hvdyB3aGF0IHNwZWNpZmljYXRpb24gbWF0
Y2hlZCBlYWNoIGZpbGUgKGRvIG5vdCBhYm9ydCB2YWxpZGF0aW9uDQo+IC1hZnRlciBBQk9SVF9P
Tl9FUlJPUlMgZXJyb3JzKS4NCj4gK3Nob3cgd2hhdCBzcGVjaWZpY2F0aW9uIG1hdGNoZWQgZWFj
aCBmaWxlLg0KPiAgLlRQDQo+ICAuQkkgXC1lIFwgZGlyZWN0b3J5DQo+ICBkaXJlY3RvcnkgdG8g
ZXhjbHVkZSAocmVwZWF0IG9wdGlvbiBmb3IgbW9yZSB0aGFuIG9uZSBkaXJlY3RvcnkpLg0KPiBk
aWZmIC0tZ2l0IGEvcG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3NldGZpbGVzLmMgYi9wb2xpY3lj
b3JldXRpbHMvc2V0ZmlsZXMvc2V0ZmlsZXMuYw0KPiBpbmRleCAxMDY5MmQ2ZDk0YTAuLjkyNjE2
NTcxZWYyYSAxMDA2NDQNCj4gLS0tIGEvcG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3NldGZpbGVz
LmMNCj4gKysrIGIvcG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3NldGZpbGVzLmMNCj4gQEAgLTIz
LDE0ICsyMyw2IEBAIHN0YXRpYyBpbnQgbmVycjsNCj4gIA0KPiAgI2RlZmluZSBTVEFUX0JMT0NL
X1NJWkUgMQ0KPiAgDQo+IC0vKiBzZXRmaWxlcyB3aWxsIGFib3J0IGl0cyBvcGVyYXRpb24gYWZ0
ZXIgcmVhY2hpbmcgdGhlDQo+IC0gKiBmb2xsb3dpbmcgbnVtYmVyIG9mIGVycm9ycyAoZS5nLiBp
bnZhbGlkIGNvbnRleHRzKSwNCj4gLSAqIHVubGVzcyBpdCBpcyB1c2VkIGluICJkZWJ1ZyIgbW9k
ZSAoLWQgb3B0aW9uKS4NCj4gLSAqLw0KPiAtI2lmbmRlZiBBQk9SVF9PTl9FUlJPUlMNCj4gLSNk
ZWZpbmUgQUJPUlRfT05fRVJST1JTCTEwDQo+IC0jZW5kaWYNCj4gLQ0KPiAgI2RlZmluZSBTRVRG
SUxFUyAic2V0ZmlsZXMiDQo+ICAjZGVmaW5lIFJFU1RPUkVDT04gInJlc3RvcmVjb24iDQo+ICBz
dGF0aWMgaW50IGlhbXJlc3RvcmVjb247DQo+IEBAIC01NiwxNSArNDgsNiBAQCBzdGF0aWMgX19h
dHRyaWJ1dGVfXygoX19ub3JldHVybl9fKSkgdm9pZCB1c2FnZShjb25zdCBjaGFyICpjb25zdCBu
YW1lKQ0KPiAgCWV4aXQoLTEpOw0KPiAgfQ0KPiAgDQo+IC12b2lkIGluY19lcnIodm9pZCkNCj4g
LXsNCj4gLQluZXJyKys7DQo+IC0JaWYgKG5lcnIgPiBBQk9SVF9PTl9FUlJPUlMgLSAxICYmICFy
X29wdHMuZGVidWcpIHsNCj4gLQkJZnByaW50ZihzdGRlcnIsICJFeGl0aW5nIGFmdGVyICVkIGVy
cm9ycy5cbiIsIEFCT1JUX09OX0VSUk9SUyk7DQo+IC0JCWV4aXQoLTEpOw0KPiAtCX0NCj4gLX0N
Cj4gLQ0KPiAgdm9pZCBzZXRfcm9vdHBhdGgoY29uc3QgY2hhciAqYXJnKQ0KPiAgew0KPiAgCWlm
IChzdHJsZW4oYXJnKSA9PSAxICYmIHN0cm5jbXAoYXJnLCAiLyIsIDEpID09IDApIHsNCj4gQEAg
LTk3LDcgKzgwLDYgQEAgaW50IGNhbm9uY29uKGNoYXIgKipjb250ZXh0cCkNCj4gIAkJKmNvbnRl
eHRwID0gdG1wY29uOw0KPiAgCX0gZWxzZSBpZiAoZXJybm8gIT0gRU5PRU5UKSB7DQo+ICAJCXJj
ID0gLTE7DQo+IC0JCWluY19lcnIoKTsNCj4gIAl9DQo+ICANCj4gIAlyZXR1cm4gcmM7DQo+IC0t
IA0KPiAyLjMwLjANCg0KDQpJZiB0aGVyZSdzIG5vIG9iamVjdGlvbiBJJ2QgbGlrZSB0byBtZXJn
ZSBib3RoIHBhdGNoZXMgYmVmb3JlIFdlZG5lc2RheQ0Kc28gdGhleSdsbCBwYXJ0IG9mIHJjMi4N
Cg0K

