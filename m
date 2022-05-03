Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BB2C433F5
	for <selinux@archiver.kernel.org>; Tue,  3 May 2022 08:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiECI1F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 May 2022 04:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiECI1E (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 May 2022 04:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE38F2A266
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 01:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651566211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13LIhIH8ENFwdPN6Fw6ExK/xjeONIgl/fIJM5yJ7c7Q=;
        b=Ot66y3fupU8LfeutWM524++gf8B0KxOx6salyY97CSjIOHCPbacjvTG8Dt24Oeh4wuwa64
        SpJcgVzK9j0gvPIUXQbvvCVoibM490J1aryQyV8s/7NnfKKtvI+MREIPT77Re14KfZIU1L
        O52Dh8khOgM5Zo+07P9I0L3zKBrsUnw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-hXGeRQElPiCxsc7nUG_jqw-1; Tue, 03 May 2022 04:23:30 -0400
X-MC-Unique: hXGeRQElPiCxsc7nUG_jqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A710185A5A8
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 08:23:30 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF21340CF8F9;
        Tue,  3 May 2022 08:23:29 +0000 (UTC)
From:   Laszlo Ersek <lersek@redhat.com>
To:     SELinux List <selinux@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     "Richard W.M. Jones" <rjones@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 2/5] setfiles: remove useless assignment and comment (after RHBZ#1926386)
Date:   Tue,  3 May 2022 10:23:23 +0200
Message-Id: <20220503082326.11621-3-lersek@redhat.com>
In-Reply-To: <20220503082326.11621-1-lersek@redhat.com>
References: <20220503082326.11621-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Q29tbWl0IDkyMDc4MjNjOGZmMCAoInNldGZpbGVzOiBEbyBub3QgYWJvcnQgb24gbGFiZWxpbmcg
ZXJyb3IiLAoyMDIxLTAyLTAxKSBob2lzdGVkIHRoZSB6ZXJvaW5nIG9mICJyX29wdHMuYWJvcnRf
b25fZXJyb3IiIGFib3ZlIHRoZQpicmFuY2hpbmcgb24gInNldGZpbGVzIHZzLiByZXN0b3JlY29u
Ii4gQ2xlYW4gdXAgdHdvIGFzcGVjdHM6CgotICJyX29wdHMiIGlzIGFsdG9nZXRoZXIgemVyb2Vk
IGEgYml0IGhpZ2hlciB1cCwgc28gcmVtb3ZlIHRoZSBleHBsaWNpdAogIHplcm8tYXNzaWdubWVu
dDsKCi0gbmVpdGhlciAic2V0ZmlsZXMiIG5vciAicmVzdG9yZWNvbiIgYWJvcnRzIG9uIGVycm9y
cyBkdXJpbmcgdGhlIGZpbGUKICB0cmVlIHdhbGsgbm93LCBzbyByZW1vdmUgdGhlIGNvbW1lbnQg
IkRvIG5vdCBhYm9ydCBvbiBlcnJvcnMgZHVyaW5nIHRoZQogIGZpbGUgdHJlZSB3YWxrIiBmcm9t
IHRoZSAicmVzdG9yZWNvbiIgYnJhbmNoIGFzIHdlbGwuCgpDYzogIlJpY2hhcmQgVy5NLiBKb25l
cyIgPHJqb25lc0ByZWRoYXQuY29tPgpDYzogUGV0ciBMYXV0cmJhY2ggPHBsYXV0cmJhQHJlZGhh
dC5jb20+CkJ1Z3ppbGxhOiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dp
P2lkPTE3OTQ1MTgKU2lnbmVkLW9mZi1ieTogTGFzemxvIEVyc2VrIDxsZXJzZWtAcmVkaGF0LmNv
bT4KLS0tCiBwb2xpY3ljb3JldXRpbHMvc2V0ZmlsZXMvc2V0ZmlsZXMuYyB8IDIgLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3BvbGljeWNvcmV1dGlscy9z
ZXRmaWxlcy9zZXRmaWxlcy5jIGIvcG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3NldGZpbGVzLmMK
aW5kZXggYmU4OGJlNWQ1NDk3Li5jZjUwNDYxOGQzOGYgMTAwNjQ0Ci0tLSBhL3BvbGljeWNvcmV1
dGlscy9zZXRmaWxlcy9zZXRmaWxlcy5jCisrKyBiL3BvbGljeWNvcmV1dGlscy9zZXRmaWxlcy9z
ZXRmaWxlcy5jCkBAIC0xNjIsNyArMTYyLDYgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiph
cmd2KQogCXJlcXVlc3RfZGlnZXN0ID0gMDsKIAlwb2xpY3lmaWxlID0gTlVMTDsKIAotCXJfb3B0
cy5hYm9ydF9vbl9lcnJvciA9IDA7CiAJaWYgKCFhcmd2WzBdKSB7CiAJCWZwcmludGYoc3RkZXJy
LCAiQ2FsbGVkIHdpdGhvdXQgcmVxdWlyZWQgcHJvZ3JhbSBuYW1lIVxuIik7CiAJCWV4aXQoLTEp
OwpAQCAtMTk3LDcgKzE5Niw2IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAkJ
ICogcmVzdG9yZWNvbjoKIAkJICogTm8gcmVjdXJzaXZlIGRlc2NlbnQgdW5sZXNzIC1yLy1SLAog
CQkgKiBFeHBhbmRzIHBhdGhzIHZpYSByZWFscGF0aCwKLQkJICogRG8gbm90IGFib3J0IG9uIGVy
cm9ycyBkdXJpbmcgdGhlIGZpbGUgdHJlZSB3YWxrLAogCQkgKiBEbyBub3QgdHJ5IHRvIHRyYWNr
IGlub2RlIGFzc29jaWF0aW9ucyBmb3IgY29uZmxpY3QgZGV0ZWN0aW9uLAogCQkgKiBGb2xsb3dz
IG1vdW50cywKIAkJICogRG9lcyBsYXp5IHZhbGlkYXRpb24gb2YgY29udGV4dHMgdXBvbiB1c2Uu
Ci0tIAoyLjE5LjEuMy5nMzAyNDdhYTVkMjAxCgoK

