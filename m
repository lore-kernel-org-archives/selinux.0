Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58278C433FE
	for <selinux@archiver.kernel.org>; Tue,  3 May 2022 08:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiECI1F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 May 2022 04:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiECI1E (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 May 2022 04:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06A0F2980A
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 01:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651566209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JWWAcnDySCtldags5m/3bGqlDmlMSLlq7nqRiIzMD+k=;
        b=Ic7shHxfNBpKu0qMt83bJaX5P+MMtJjCT1uGZo4gFgtOEecPcUwNffwj1RgN/RpvERF6fV
        7U3Q8f/g9x+fy+lIsLqiHvs8mYXLIMqtq91G9xN5CovV8Lq0jmlBPWiAdLY6IxVhuJFd21
        EqI9CuXQ7IR5sRhJHJ3O3G9liZsVal0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-QVjlbtkXMMCWr-XdQ2NxMQ-1; Tue, 03 May 2022 04:23:28 -0400
X-MC-Unique: QVjlbtkXMMCWr-XdQ2NxMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5215F833942
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 08:23:28 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69E29400E896;
        Tue,  3 May 2022 08:23:27 +0000 (UTC)
From:   Laszlo Ersek <lersek@redhat.com>
To:     SELinux List <selinux@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     "Richard W.M. Jones" <rjones@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 0/5] selinux_restorecon(3), setfiles(8): skip relabeling errors
Date:   Tue,  3 May 2022 10:23:21 +0200
Message-Id: <20220503082326.11621-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

QnVnemlsbGE6IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTc5
NDUxOAp2MTogICAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc2VsaW51eC8yMDIyMDQyODA2
NTM1NC4yNzYwNS0xLWxlcnNla0ByZWRoYXQuY29tLwoKSW4gdmVyc2lvbiAyLCBJJ3ZlIHBpY2tl
ZCB1cCBEYW5pZWwgQnVyZ2VuZXIncyBSLWIgZm9yIHBhdGNoIzMsIGFuZAptb3ZlZCB0aGUgbmV3
IHN5bWJvbCAic2VsaW51eF9yZXN0b3JlY29uX2dldF9za2lwcGVkX2Vycm9ycyIgdG8gc2VjdGlv
bgpMSUJTRUxJTlVYXzMuNCBvZiAibGlic2VsaW51eC5tYXAiIGluIHBhdGNoIzQsIGFjY29yZGlu
ZyB0byBQZXRyJ3MKZmVlZGJhY2suCgpQbGVhc2UgQ0MgbWUgb24gYWxsIHJlcGxpZXMgdG8gdGhl
IHNlcmllczsgSSdtIG5vdCBzdWJzY3JpYmVkIHRvIHRoZQpTRUxpbnV4IG1haWxpbmcgbGlzdC4g
KCJDT05UUklCVVRJTkcubWQiIGRvZXMgbm90IHNheSB0aGF0IHN1YnNjcmliaW5nCmlzIGEgcmVx
dWlyZW1lbnQuKQoKQ2M6ICJSaWNoYXJkIFcuTS4gSm9uZXMiIDxyam9uZXNAcmVkaGF0LmNvbT4K
Q2M6IFBldHIgTGF1dHJiYWNoIDxwbGF1dHJiYUByZWRoYXQuY29tPgoKVGhhbmtzLApMYXN6bG8K
Ckxhc3psbyBFcnNlayAoNSk6CiAgc2V0ZmlsZXM6IGZpeCB1cCBpbmNvbnNpc3RlbnQgaW5kZW50
YXRpb24KICBzZXRmaWxlczogcmVtb3ZlIHVzZWxlc3MgYXNzaWdubWVudCBhbmQgY29tbWVudCAo
YWZ0ZXIgUkhCWiMxOTI2Mzg2KQogIHNldGZpbGVzOiByZW1vdmUgdXNlbGVzcyAiaWFtcmVzdG9y
ZWNvbiIgY2hlY2tzIGluIG9wdGlvbiBwYXJzaW5nCiAgc2VsaW51eF9yZXN0b3JlY29uOiBpbnRy
b2R1Y2UgU0VMSU5VWF9SRVNUT1JFQ09OX0NPVU5UX0VSUk9SUwogIHNldGZpbGVzOiBpbnRyb2R1
Y2UgdGhlIC1DIG9wdGlvbiBmb3IgZGlzdGluZ3Vpc2hpbmcgZmlsZSB0cmVlIHdhbGsKICAgIGVy
cm9ycwoKIGxpYnNlbGludXgvaW5jbHVkZS9zZWxpbnV4L3Jlc3RvcmVjb24uaCAgICAgICAgICAg
ICAgICAgICAgIHwgMTUgKysrKysrKysKIGxpYnNlbGludXgvbWFuL21hbjMvc2VsaW51eF9yZXN0
b3JlY29uLjMgICAgICAgICAgICAgICAgICAgIHwgMjIgKysrKysrKysrKystCiBsaWJzZWxpbnV4
L21hbi9tYW4zL3NlbGludXhfcmVzdG9yZWNvbl9nZXRfc2tpcHBlZF9lcnJvcnMuMyB8IDI4ICsr
KysrKysrKysrKysrKwogbGlic2VsaW51eC9zcmMvbGlic2VsaW51eC5tYXAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMSArCiBsaWJzZWxpbnV4L3NyYy9zZWxpbnV4X3Jlc3RvcmVj
b24uYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDM0ICsrKysrKysrKysrKysrKy0tLQogcG9s
aWN5Y29yZXV0aWxzL3NldGZpbGVzL3Jlc3RvcmUuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgOCArKystLQogcG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3Jlc3RvcmUuaCAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgNCArKy0KIHBvbGljeWNvcmV1dGlscy9zZXRmaWxlcy9zZXRmaWxl
cy44ICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjIgKysrKysrKysrKysrCiBwb2xpY3ljb3Jl
dXRpbHMvc2V0ZmlsZXMvc2V0ZmlsZXMuYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDM2ICsr
KysrKysrKy0tLS0tLS0tLS0tCiA5IGZpbGVzIGNoYW5nZWQsIDE0MSBpbnNlcnRpb25zKCspLCAy
OSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWJzZWxpbnV4L21hbi9tYW4zL3Nl
bGludXhfcmVzdG9yZWNvbl9nZXRfc2tpcHBlZF9lcnJvcnMuMwoKCmJhc2UtY29tbWl0OiAyYTE2
N2QxMTU2NTc4ZmMyOTU0MWY2ZmI2MGFmNjU0NTJmNDMxYWFlCi0tIAoyLjE5LjEuMy5nMzAyNDdh
YTVkMjAxCgo=

