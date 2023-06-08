Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563F3C7EE25
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 01:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjFHBWr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 21:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjFHBWq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jun 2023 21:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7FE210C
        for <selinux@vger.kernel.org>; Wed,  7 Jun 2023 18:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686187321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DI9ixvzYp3UbpIuXfAHnWxwocbt3v0vJCe+VD2Q9ec=;
        b=ei6lVZRIFtYaVKZQuNZQwXzvrsdlkB+W1EIjpUCt9drzQKYOO9VxuMkw66F+QKiH7L6uV6
        iPYJIwliCS8p7IeSMU9eJWxnrmf0OtFlZviagJyTGVvOsbvWhFWLnaumW+2YoXaiYc6qIF
        yzdop9vOlD00MKGuCONXfLAa3kAG0Tg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-L4YIbmqNO0eNuc7FMnFC8w-1; Wed, 07 Jun 2023 21:22:00 -0400
X-MC-Unique: L4YIbmqNO0eNuc7FMnFC8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D1ED801182
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 01:22:00 +0000 (UTC)
Received: from localhost (unknown [10.64.240.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88B6FC1603B;
        Thu,  8 Jun 2023 01:21:59 +0000 (UTC)
Date:   Thu, 08 Jun 2023 10:21:58 +0900 (JST)
Message-Id: <20230608.102158.2017984322450073700.yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: Re: [PATCH] Makefile: expand ~ in DESTDIR
From:   Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20230531011548.1133249-1-yamato@redhat.com>
References: <20230531011548.1133249-1-yamato@redhat.com>
Organization: Red Hat Japan, K.K.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

SSB3b3VsZCBsaWtlIHRvIHdpdGhkcmF3IG15IHBhdGNoLg0KSXQgc2VlbXMgdGhhdCBJIHNraXBw
ZWQgaW5zdGFsbCB0YXJnZXQgYmVmb3JlIHJ1bm5pbmcgdGhlIHRlc3QgdGFyZ2V0Lg0KU28gSSBn
b3QgdGhlIGVycm9yLg0KDQpTb3JyeSBmb3IgbWFraW5nIG5vaXNlLg0KDQpNYXNhdGFrZSBZQU1B
VE8NCg0KPiBUaG91Z2ggaW5zdHJ1Y3RlZCBhcw0KPiANCj4gICAgIERFU1RESVI9fi9vYmogLi9z
Y3JpcHRzL2Vudl91c2VfZGVzdGRpciBtYWtlIHRlc3QNCj4gDQo+IGluIFJFQURNRS5tZCwgY29t
cGlsaW5nIHBvbGljeV9kZWZpbmUuYyB3YXMgZmFpbGVkIHdpdGggZm9sbG93aW5nIGVycm9yczoN
Cj4gDQo+ICAgICBtYWtlWzFdOiBFbnRlcmluZyBkaXJlY3RvcnkgJy9ob21lL3lhbWF0by92YXIv
c2VsaW51eC9jaGVja3BvbGljeScNCj4gICAgIGNjIC1PMiAtV2Vycm9yIC1XYWxsIC1XZXh0cmEg
LVdmbG9hdC1lcXVhbCAtV2Zvcm1hdD0yIC1XaW5pdC1zZWxmIFwNCj4gICAgICAgIC1XbWlzc2lu
Zy1mb3JtYXQtYXR0cmlidXRlIC1XbWlzc2luZy1ub3JldHVybiAtV21pc3NpbmctcHJvdG90eXBl
cyBcDQo+ICAgICAgICAtV251bGwtZGVyZWZlcmVuY2UgLVdwb2ludGVyLWFyaXRoIC1Xc2hhZG93
IC1Xc3RyaWN0LXByb3RvdHlwZXMgXA0KPiAgICAgICAgLVd1bmRlZiAtV3VudXNlZCAtV3dyaXRl
LXN0cmluZ3MgLWZuby1jb21tb24gLUl+L29iai91c3IvaW5jbHVkZSBcDQo+ICAgICAgICAtbyBw
b2xpY3lfZGVmaW5lLm8gLWMgcG9saWN5X2RlZmluZS5jDQo+ICAgICBwb2xpY3lfZGVmaW5lLmM6
IEluIGZ1bmN0aW9uIKFkZWZpbmVfdGVfYXZ0YWJfeHBlcm1zX2hlbHBlcqI6DQo+ICAgICBwb2xp
Y3lfZGVmaW5lLmM6MjA4Mzo2MTogZXJyb3I6IKFSVUxFX05PVFNFTEaiIHVuZGVjbGFyZWQgKGZp
cnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuIKFSVUxFX1NFTEaiPw0KPiAg
ICAgIDIwODMgfCAgICAgICAgICAgICAgICAgICAgICAgICBhdnJ1bGUtPmZsYWdzIHw9IChhZGQg
PyBSVUxFX1NFTEYgOiBSVUxFX05PVFNFTEYpOw0KPiAJICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fg0KPiAJ
ICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFJVTEVfU0VMRg0KPiANCj4gYmVjYXVzZSBjYyBjYW5ub3QgZmluZCB0aGUgZGlyZWN0
b3J5IH4vb2JqL3Vzci9pbmNsdWRlIHBhc3NlZCB2aWEgLUkgb3B0aW9uLg0KPiANCj4gY2MgZG9l
c24ndCBleHBhbmQgIn4iLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFzYXRha2UgWUFNQVRPIDx5
YW1hdG9AcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBNYWtlZmlsZSB8IDYgKysrLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUNCj4gaW5kZXggMmZmYmE4ZTkuLjA1M2M2ZDNkIDEw
MDY0NA0KPiAtLS0gYS9NYWtlZmlsZQ0KPiArKysgYi9NYWtlZmlsZQ0KPiBAQCAtMjYsMTEgKzI2
LDExIEBAIGVsc2UNCj4gIGVuZGlmDQo+ICANCj4gIGlmbmVxICgkKERFU1RESVIpLCkNCj4gLQlM
SUJESVIgPz0gJChERVNURElSKSQoUFJFRklYKS9saWINCj4gKwlMSUJESVIgPz0gJCh3aWxkY2Fy
ZCAkKERFU1RESVIpKSQoUFJFRklYKS9saWINCj4gIAlMSUJTRVBPTEEgPz0gJChMSUJESVIpL2xp
YnNlcG9sLmENCj4gIA0KPiAtCUNGTEFHUyArPSAtSSQoREVTVERJUikkKFBSRUZJWCkvaW5jbHVk
ZQ0KPiAtCUxERkxBR1MgKz0gLUwkKERFU1RESVIpJChQUkVGSVgpL2xpYiAtTCQoTElCRElSKQ0K
PiArCUNGTEFHUyArPSAtSSQod2lsZGNhcmQgJChERVNURElSKSkkKFBSRUZJWCkvaW5jbHVkZQ0K
PiArCUxERkxBR1MgKz0gLUwkKHdpbGRjYXJkICQoREVTVERJUikpJChQUkVGSVgpL2xpYiAtTCQo
TElCRElSKQ0KPiAgCWV4cG9ydCBDRkxBR1MNCj4gIAlleHBvcnQgTERGTEFHUw0KPiAgCWV4cG9y
dCBMSUJTRVBPTEENCj4gLS0gDQo+IDIuNDAuMQ0KPiANCg==

