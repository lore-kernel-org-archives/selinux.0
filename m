Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F2C3403D
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD6E207FD
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 15:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrdwnA5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBRPMm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:12:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22126 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726697AbgBRPMm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 10:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582038761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QcYGBsErRId+xumzuFV1Noq/TCOwxtQZbOPKxvIeW4=;
        b=GrdwnA5eu6kuHSgMrhe75qENbBRQMaNvZPi0itykP5ClHmcCeF4B67BOHnpZiEzGJIVC/D
        z47oWwS1o3i9o1ftAM8dcpOVRRJlZQNiQDucXIXRMHX3rwz1bivdthyNWScm9yd8p8tJt6
        Dnwcrgd3Qtsy09C16O6u9JeKq19kIR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-ZB_ftrmYMRmaeaus8fea6w-1; Tue, 18 Feb 2020 10:12:35 -0500
X-MC-Unique: ZB_ftrmYMRmaeaus8fea6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2ACF132BD2;
        Tue, 18 Feb 2020 15:12:33 +0000 (UTC)
Received: from localhost (ovpn-204-115.brq.redhat.com [10.40.204.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D13519756;
        Tue, 18 Feb 2020 15:12:32 +0000 (UTC)
References: <5d97fa0c-8a0d-b6e3-6108-f5e98b8a7078@rosalinux.ru>
User-agent: mu4e 1.2.0; emacs 27.0.60
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Subject: Re: [PATCH] libselinux: Fix Ru translation of failsafe context
In-reply-to: <5d97fa0c-8a0d-b6e3-6108-f5e98b8a7078@rosalinux.ru>
Date:   Tue, 18 Feb 2020 16:12:29 +0100
Message-ID: <pjdimk4lyjm.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQpNaWtoYWlsIE5vdm9zeW9sb3YgPG0ubm92b3N5b2xvdkByb3NhbGludXgucnU+IHdyaXRlczoN
Cg0KPiBGcm9tIGZhaWxzYWZlX2NvbnRleHQoNSk6DQo+ICJUaGUgZmFpbHNhZmVfY29udGV4dCBm
aWxlIGFsbG93cyBTRUxpbnV4LWF3YXJlIGFwcGxpY2F0aW9ucyBzdWNoIGFzDQo+IFBBTSg4KSB0
byBvYnRhaW4gYSBrbm93biB2YWxpZCBsb2dpbiBjb250ZXh0IGZvciBhbiBhZG1pbmlzdHJhdG9y
IGlmDQo+IG5vIHZhbGlkIGRlZmF1bHQgZW50cmllcyBjYW4gYmUgZm91bmQgZWxzZXdoZXJlLiIN
Cj4NCj4gItCd0LDQtNGR0LbQvdGL0LkiIG1lYW5zICJyZWxpYWJsZSIsICLRgNC10LfQtdGA0LLQ
vdGL0LkiIG1lYW5zICJyZXNlcnZlIiwNCj4gdGhlIGxhc3QgdmFyaWFudCBpcyBtdWNoIGNsb3Nl
ciB0byB3aGF0ICJmYWlsc2FmZSIgcmVhbGx5IGRvZXMuDQo+DQo+IERpc2N1c3NlZCB3aXRoIGFu
ZCBhcHByb3ZlZCBieSBwcmV2aW91cyB0cmFuc2xhdG9yczoNCj4gaHR0cHM6Ly9naXRodWIuY29t
L1NFTGludXhQcm9qZWN0L3NlbGludXgvcHVsbC8yMDMNCj4NCj4gU2lnbmVkLW9mZi1ieTogTWlr
aGFpbCBOb3Zvc3lvbG92IDxtLm5vdm9zeW9sb3ZAcm9zYWxpbnV4LnJ1Pg0KDQoNClRoYW5rcyEN
Cg0KQWNrZWQtYnk6IFBldHIgTGF1dHJiYWNoIDxwbGF1dHJiYUByZWRoYXQuY29tPg0KDQoNCj4g
LS0tDQo+ICBsaWJzZWxpbnV4L21hbi9ydS9tYW41L2ZhaWxzYWZlX2NvbnRleHQuNSB8IDQgKyst
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2xpYnNlbGludXgvbWFuL3J1L21hbjUvZmFpbHNhZmVfY29udGV4dC41
IGIvbGlic2VsaW51eC9tYW4vcnUvbWFuNS9mYWlsc2FmZV9jb250ZXh0LjUNCj4gaW5kZXggMDFk
NmIwZWEuLjU0Y2VjZjM5IDEwMDY0NA0KPiAtLS0gYS9saWJzZWxpbnV4L21hbi9ydS9tYW41L2Zh
aWxzYWZlX2NvbnRleHQuNQ0KPiArKysgYi9saWJzZWxpbnV4L21hbi9ydS9tYW41L2ZhaWxzYWZl
X2NvbnRleHQuNQ0KPiBAQCAtMSw2ICsxLDYgQEANCj4gIC5USCAiZmFpbHNhZmVfY29udGV4dCIg
IjUiICIyOCDQvdC+0Y/QsdGA0Y8gMjAxMSIgIlNlY3VyaXR5IEVuaGFuY2VkIExpbnV4IiAi0JrQ
vtC90YTQuNCz0YPRgNCw0YbQuNGPIFNFTGludXgiDQo+ICAuU0ggItCY0JzQryINCj4gLWZhaWxz
YWZlX2NvbnRleHQgXC0g0YTQsNC50Lsg0LrQvtC90YTQuNCz0YPRgNCw0YbQuNC4INC90LDQtNGR
0LbQvdC+0LPQviDQutC+0L3RgtC10LrRgdGC0LAgU0VMaW51eA0KPiArZmFpbHNhZmVfY29udGV4
dCBcLSDRhNCw0LnQuyDQutC+0L3RhNC40LPRg9GA0LDRhtC40Lgg0YDQtdC30LXRgNCy0L3QvtCz
0L4g0LrQvtC90YLQtdC60YHRgtCwIFNFTGludXgNCj4gIC4NCj4gIC5TSCAi0J7Qn9CY0KHQkNCd
0JjQlSINCj4gINCk0LDQudC7DQo+IEBAIC0xMCw3ICsxMCw3IEBAIGZhaWxzYWZlX2NvbnRleHQg
XC0g0YTQsNC50Lsg0LrQvtC90YTQuNCz0YPRgNCw0YbQuNC4INC90LDQtNGR0LbQvdC+0LPQviDQ
utC+0L0NCj4gINC/0L7Qu9GD0YfQsNGC0Ywg0LjQt9Cy0LXRgdGC0L3Ri9C5INC00LXQudGB0YLQ
stC40YLQtdC70YzQvdGL0Lkg0LrQvtC90YLQtdC60YHRgiDQstGF0L7QtNCwINC00LvRjyDQsNC0
0LzQuNC90LjRgdGC0YDQsNGC0L7RgNCwLCDQtdGB0LvQuCDQsiDQtNGA0YPQs9C40YUg0YDQsNGB
0L/QvtC70L7QttC10L3QuNGP0YUg0L7RgtGB0YPRgtGB0YLQstGD0Y7RgiDQtNC10LnRgdGC0LLQ
uNGC0LXQu9GM0L3Ri9C1INC30LDQv9C40YHQuCDQv9C+INGD0LzQvtC70YfQsNC90LjRji4NCj4g
IC5zcA0KPiAgLkJSIHNlbGludXhfZmFpbHNhZmVfY29udGV4dF9wYXRoICIoMykgIg0KPiAt0LLQ
vtC30LLRgNCw0YnQsNC10YIg0L/Rg9GC0Ywg0LDQutGC0LjQstC90L7QuSDQv9C+0LvQuNGC0LjQ
utC4INC6INGN0YLQvtC80YMg0YTQsNC50LvRgy4g0KTQsNC50Lsg0L3QsNC00ZHQttC90L7Qs9C+
INC60L7QvdGC0LXQutGB0YLQsCDQv9C+INGD0LzQvtC70YfQsNC90LjRjjoNCj4gK9Cy0L7Qt9Cy
0YDQsNGJ0LDQtdGCINC/0YPRgtGMINCw0LrRgtC40LLQvdC+0Lkg0L/QvtC70LjRgtC40LrQuCDQ
uiDRjdGC0L7QvNGDINGE0LDQudC70YMuINCk0LDQudC7INGA0LXQt9C10YDQstC90L7Qs9C+INC6
0L7QvdGC0LXQutGB0YLQsCDQv9C+INGD0LzQvtC70YfQsNC90LjRjjoNCj4gIC5SUw0KPiAgLkkg
L2V0Yy9zZWxpbnV4L3tTRUxJTlVYVFlQRX0vY29udGV4dHMvZmFpbHNhZmVfY29udGV4dA0KPiAg
LlJFDQoNCg0KLS0gDQooKSAgYXNjaWkgcmliYm9uIGNhbXBhaWduIC0gYWdhaW5zdCBodG1sIGUt
bWFpbCANCi9cICB3d3cuYXNjaWlyaWJib24ub3JnICAgLSBhZ2FpbnN0IHByb3ByaWV0YXJ5IGF0
dGFjaG1lbnRzDQo=

