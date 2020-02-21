Return-Path: <SRS0=FZ6t=4J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99726C35642
	for <selinux@archiver.kernel.org>; Fri, 21 Feb 2020 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703DF2468C
	for <selinux@archiver.kernel.org>; Fri, 21 Feb 2020 08:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctRYYlY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgBUI1D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:27:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48817 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388317AbgBUI1C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Feb 2020 03:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582273621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/YcYcUI0F0YhP/N/ioYl95SNILeZJqwdC1i8HL233r8=;
        b=ctRYYlY3764KLxC4SI2rM/mMSQnuZNO7fKFCWagG6WECWetXagjcgmS+lRDFQoPUQ6IRKm
        qcnL3xI0LiZb48IuE1QWtvmxfIsjZE3994FVOdOduYPraqlUPOHoNjN3FwgzaQIGE/yeup
        gxc/MUy0yt16zooemTnO0B2Sf0g8Rpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-6NNcik9dM9-QTJ_9ueD2DA-1; Fri, 21 Feb 2020 03:26:55 -0500
X-MC-Unique: 6NNcik9dM9-QTJ_9ueD2DA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88EDB8017CC;
        Fri, 21 Feb 2020 08:26:53 +0000 (UTC)
Received: from localhost (ovpn-205-44.brq.redhat.com [10.40.205.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E9D219481;
        Fri, 21 Feb 2020 08:26:52 +0000 (UTC)
References: <5d97fa0c-8a0d-b6e3-6108-f5e98b8a7078@rosalinux.ru>
 <pjdimk4lyjm.fsf@redhat.com>
User-agent: mu4e 1.2.0; emacs 27.0.60
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Subject: Re: [PATCH] libselinux: Fix Ru translation of failsafe context
In-reply-to: <pjdimk4lyjm.fsf@redhat.com>
Date:   Fri, 21 Feb 2020 09:26:49 +0100
Message-ID: <pjdblpsmjli.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQpQZXRyIExhdXRyYmFjaCA8cGxhdXRyYmFAcmVkaGF0LmNvbT4gd3JpdGVzOg0KDQo+IE1pa2hh
aWwgTm92b3N5b2xvdiA8bS5ub3Zvc3lvbG92QHJvc2FsaW51eC5ydT4gd3JpdGVzOg0KPg0KPj4g
RnJvbSBmYWlsc2FmZV9jb250ZXh0KDUpOg0KPj4gIlRoZSBmYWlsc2FmZV9jb250ZXh0IGZpbGUg
YWxsb3dzIFNFTGludXgtYXdhcmUgYXBwbGljYXRpb25zIHN1Y2ggYXMNCj4+IFBBTSg4KSB0byBv
YnRhaW4gYSBrbm93biB2YWxpZCBsb2dpbiBjb250ZXh0IGZvciBhbiBhZG1pbmlzdHJhdG9yIGlm
DQo+PiBubyB2YWxpZCBkZWZhdWx0IGVudHJpZXMgY2FuIGJlIGZvdW5kIGVsc2V3aGVyZS4iDQo+
Pg0KPj4gItCd0LDQtNGR0LbQvdGL0LkiIG1lYW5zICJyZWxpYWJsZSIsICLRgNC10LfQtdGA0LLQ
vdGL0LkiIG1lYW5zICJyZXNlcnZlIiwNCj4+IHRoZSBsYXN0IHZhcmlhbnQgaXMgbXVjaCBjbG9z
ZXIgdG8gd2hhdCAiZmFpbHNhZmUiIHJlYWxseSBkb2VzLg0KPj4NCj4+IERpc2N1c3NlZCB3aXRo
IGFuZCBhcHByb3ZlZCBieSBwcmV2aW91cyB0cmFuc2xhdG9yczoNCj4+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9TRUxpbnV4UHJvamVjdC9zZWxpbnV4L3B1bGwvMjAzDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogTWlraGFpbCBOb3Zvc3lvbG92IDxtLm5vdm9zeW9sb3ZAcm9zYWxpbnV4LnJ1Pg0KPg0KPg0K
PiBUaGFua3MhDQo+DQo+IEFja2VkLWJ5OiBQZXRyIExhdXRyYmFjaCA8cGxhdXRyYmFAcmVkaGF0
LmNvbT4NCg0KQXBwbGllZC4NCg0KPg0KPj4gLS0tDQo+PiAgbGlic2VsaW51eC9tYW4vcnUvbWFu
NS9mYWlsc2FmZV9jb250ZXh0LjUgfCA0ICsrLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9saWJzZWxpbnV4
L21hbi9ydS9tYW41L2ZhaWxzYWZlX2NvbnRleHQuNSBiL2xpYnNlbGludXgvbWFuL3J1L21hbjUv
ZmFpbHNhZmVfY29udGV4dC41DQo+PiBpbmRleCAwMWQ2YjBlYS4uNTRjZWNmMzkgMTAwNjQ0DQo+
PiAtLS0gYS9saWJzZWxpbnV4L21hbi9ydS9tYW41L2ZhaWxzYWZlX2NvbnRleHQuNQ0KPj4gKysr
IGIvbGlic2VsaW51eC9tYW4vcnUvbWFuNS9mYWlsc2FmZV9jb250ZXh0LjUNCj4+IEBAIC0xLDYg
KzEsNiBAQA0KPj4gIC5USCAiZmFpbHNhZmVfY29udGV4dCIgIjUiICIyOCDQvdC+0Y/QsdGA0Y8g
MjAxMSIgIlNlY3VyaXR5IEVuaGFuY2VkIExpbnV4IiAi0JrQvtC90YTQuNCz0YPRgNCw0YbQuNGP
IFNFTGludXgiDQo+PiAgLlNIICLQmNCc0K8iDQo+PiAtZmFpbHNhZmVfY29udGV4dCBcLSDRhNCw
0LnQuyDQutC+0L3RhNC40LPRg9GA0LDRhtC40Lgg0L3QsNC00ZHQttC90L7Qs9C+INC60L7QvdGC
0LXQutGB0YLQsCBTRUxpbnV4DQo+PiArZmFpbHNhZmVfY29udGV4dCBcLSDRhNCw0LnQuyDQutC+
0L3RhNC40LPRg9GA0LDRhtC40Lgg0YDQtdC30LXRgNCy0L3QvtCz0L4g0LrQvtC90YLQtdC60YHR
gtCwIFNFTGludXgNCj4+ICAuDQo+PiAgLlNIICLQntCf0JjQodCQ0J3QmNCVIg0KPj4gINCk0LDQ
udC7DQo+PiBAQCAtMTAsNyArMTAsNyBAQCBmYWlsc2FmZV9jb250ZXh0IFwtINGE0LDQudC7INC6
0L7QvdGE0LjQs9GD0YDQsNGG0LjQuCDQvdCw0LTRkdC20L3QvtCz0L4g0LrQvtC9DQo+PiAg0L/Q
vtC70YPRh9Cw0YLRjCDQuNC30LLQtdGB0YLQvdGL0Lkg0LTQtdC50YHRgtCy0LjRgtC10LvRjNC9
0YvQuSDQutC+0L3RgtC10LrRgdGCINCy0YXQvtC00LAg0LTQu9GPINCw0LTQvNC40L3QuNGB0YLR
gNCw0YLQvtGA0LAsINC10YHQu9C4INCyINC00YDRg9Cz0LjRhSDRgNCw0YHQv9C+0LvQvtC20LXQ
vdC40Y/RhSDQvtGC0YHRg9GC0YHRgtCy0YPRjtGCINC00LXQudGB0YLQstC40YLQtdC70YzQvdGL
0LUg0LfQsNC/0LjRgdC4INC/0L4g0YPQvNC+0LvRh9Cw0L3QuNGOLg0KPj4gIC5zcA0KPj4gIC5C
UiBzZWxpbnV4X2ZhaWxzYWZlX2NvbnRleHRfcGF0aCAiKDMpICINCj4+IC3QstC+0LfQstGA0LDR
idCw0LXRgiDQv9GD0YLRjCDQsNC60YLQuNCy0L3QvtC5INC/0L7Qu9C40YLQuNC60Lgg0Log0Y3R
gtC+0LzRgyDRhNCw0LnQu9GDLiDQpNCw0LnQuyDQvdCw0LTRkdC20L3QvtCz0L4g0LrQvtC90YLQ
tdC60YHRgtCwINC/0L4g0YPQvNC+0LvRh9Cw0L3QuNGOOg0KPj4gK9Cy0L7Qt9Cy0YDQsNGJ0LDQ
tdGCINC/0YPRgtGMINCw0LrRgtC40LLQvdC+0Lkg0L/QvtC70LjRgtC40LrQuCDQuiDRjdGC0L7Q
vNGDINGE0LDQudC70YMuINCk0LDQudC7INGA0LXQt9C10YDQstC90L7Qs9C+INC60L7QvdGC0LXQ
utGB0YLQsCDQv9C+INGD0LzQvtC70YfQsNC90LjRjjoNCj4+ICAuUlMNCj4+ICAuSSAvZXRjL3Nl
bGludXgve1NFTElOVVhUWVBFfS9jb250ZXh0cy9mYWlsc2FmZV9jb250ZXh0DQo+PiAgLlJFDQoN
Cg0KLS0gDQooKSAgYXNjaWkgcmliYm9uIGNhbXBhaWduIC0gYWdhaW5zdCBodG1sIGUtbWFpbCAN
Ci9cICB3d3cuYXNjaWlyaWJib24ub3JnICAgLSBhZ2FpbnN0IHByb3ByaWV0YXJ5IGF0dGFjaG1l
bnRzDQo=

