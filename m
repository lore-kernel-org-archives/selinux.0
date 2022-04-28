Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7BEC43217
	for <selinux@archiver.kernel.org>; Thu, 28 Apr 2022 06:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244597AbiD1G5R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Apr 2022 02:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244625AbiD1G5R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Apr 2022 02:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A59C98F5C
        for <selinux@vger.kernel.org>; Wed, 27 Apr 2022 23:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651128840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zwX4PiGzcipWSNJvCybHe1EDP9yF7u/VOFfGLmOeC8g=;
        b=WnUEwP6PjpmvyROI73EPlYKleWU1squ/gYPH5/t1Yj/Rl5M9mAU0SJyRkiuoexYo/0XFJ/
        37nOlEPO/zuYGk0+JvYXAzkr1n5wVvcwYRuiAj/At5Sz5RwepN2k7HGE+xMo300ivFFFB5
        BC4wZf6UEPSq2VhFR/tJWLyEDz4z7YU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-dQzDunfMOnKVZDBTmt6bew-1; Thu, 28 Apr 2022 02:53:59 -0400
X-MC-Unique: dQzDunfMOnKVZDBTmt6bew-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC4BD3C0E182
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 06:53:58 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.39.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFECC416384;
        Thu, 28 Apr 2022 06:53:57 +0000 (UTC)
From:   Laszlo Ersek <lersek@redhat.com>
To:     SELinux List <selinux@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     "Richard W.M. Jones" <rjones@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH for-3.5 0/5] selinux_restorecon(3), setfiles(8): skip relabeling errors
Date:   Thu, 28 Apr 2022 08:53:49 +0200
Message-Id: <20220428065354.27605-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

QnVnemlsbGE6IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTc5
NDUxOAoKVGhlIGZpcnN0IHRocmVlIHBhdGNoZXMgaW4gdGhlIHNlcmllcyBhcmUgY2xlYW51cHMu
CgpUaGUgZm91cnRoIHBhdGNoIGludHJvZHVjZXMgYSBuZXcgZmVhdHVyZSAoYW5kIEFQSSkgdG8g
bGlic2VsaW51eCwgYW5kCnRoZSBmaWZ0aCBwYXRjaCBleHBvc2VzIHRoZSBmZWF0dXJlIHRocm91
Z2ggYSBuZXcgc2V0ZmlsZXMoOCkgY29tbWFuZApsaW5lIG9wdGlvbi4KCkluIGxpYmd1ZXN0ZnMs
IHdlIGludm9rZSBzZXRmaWxlcyg4KSBvbiBtYXNzZXMgb2YgZGlyZWN0b3J5IHRyZWVzIChpbiBh
CmxhcmdlIGFtb3VudCBvZiB2aXJ0dWFsIG1hY2hpbmVzKS4gV2UgZG9uJ3QgY2FyZSBpZiByZWxh
YmVsaW5nIGZhaWxzIG9uCmEgZmV3IGluZGl2aWR1YWwgZmlsZXMsIGJ1dCB3ZSBzdGlsbCB3YW50
IHRvIGNhdGNoIGZhdGFsIGVycm9ycy4KQ3VycmVudGx5IHRoZXNlIGVycm9yIGNvbmRpdGlvbnMg
YXJlIGltcG9zc2libGUgdG8gdGVsbCBhcGFydCwgYmVjYXVzZQpzZWxpbnV4X3Jlc3RvcmVjb25b
X3BhcmFsbGVsKCldLCBldmVuIHRob3VnaCBpdCBpcyBjYXBhYmxlIG9mIGNvbnRpbnVpbmcKdGhy
b3VnaCByZWxhYmVsaW5nIGVycm9ycywgdWx0aW1hdGVseSByZXBvcnRzIGV2ZW4gdGhlIGNhc2Ug
b2YgKm9ubHkqCnJlbGFiZWxpbmcgZXJyb3JzLCB3aXRoIHJldHVybiB2YWx1ZSAoLTEpLiBTZXRm
aWxlcyg4KSB0aGVuIGhhcyBubwpjaG9pY2UgYnV0IHRvIGV4aXQgd2l0aCBzdGF0dXMgMjU1IGlu
IHRoaXMgY2FzZSBhcyB3ZWxsLgoKVGhlIGZvdXJ0aCBwYXRjaCBpbnRyb2R1Y2VzIGEgbmV3IHNl
bGludXhfcmVzdG9yZWNvbltfcGFyYWxsZWwoKV0gZmxhZywKbmFtZWx5IFNFTElOVVhfUkVTVE9S
RUNPTl9DT1VOVF9FUlJPUlMsIHdoaWNoIGNvdW50cywgYnV0IG90aGVyd2lzZQppZ25vcmVzLCBy
ZWxhYmVsaW5nIGVycm9ycyBlbmNvdW50ZXJlZCBkdXJpbmcgdGhlIGZpbGUgdHJlZSB3YWxrLiBJ
bgpjYXNlIHRoZSBmdW5jdGlvbiBzdWNjZWVkcywgdGhlIHNraXBwZWQgZXJyb3IgY291bnQgY2Fu
IGJlIGZldGNoZWQgd2l0aAphIG5ldyBBUEksIHNlbGludXhfcmVzdG9yZWNvbl9nZXRfc2tpcHBl
ZF9lcnJvcnMoKS4gVGhpcyByZWxpZXMgb24Kc3RhdGljIGxpYnJhcnkgZGF0YSwgd2hpY2ggaXMg
aW5zcGlyZWQgYnkgZXhpc3RlbnQgQVBJcyBzdWNoIGFzCnNlbGludXhfcmVzdG9yZWNvbl9zZXRf
c2VoYW5kbGUoMykgYW5kCnNlbGludXhfcmVzdG9yZWNvbl9zZXRfZXhjbHVkZV9saXN0KDMpIC0t
IHRob3NlIGRvIHRoZSBzYW1lIChhbGJlaXQKYmVmb3JlIGNhbGxpbmcgc2VsaW51eF9yZXN0b3Jl
Y29uW19wYXJhbGxlbCgpXSwgbm90IGFmdGVyKS4KClRoZSBmaWZ0aCBwYXRjaCB3aXJlcyB0aGUg
bmV3IGZsYWcgdG8gdGhlIG5ldyBzZXRmaWxlcyg4KSBvcHRpb24gIi1DIi4KClBsZWFzZSBDQyBt
ZSBvbiBhbGwgcmVwbGllcyB0byB0aGUgc2VyaWVzOyBJJ20gbm90IHN1YnNjcmliZWQgdG8gdGhl
ClNFTGludXggbWFpbGluZyBsaXN0LiAoIkNPTlRSSUJVVElORy5tZCIgZG9lcyBub3Qgc2F5IHRo
YXQgc3Vic2NyaWJpbmcKaXMgYSByZXF1aXJlbWVudC4pCgpDYzogIlJpY2hhcmQgVy5NLiBKb25l
cyIgPHJqb25lc0ByZWRoYXQuY29tPgpDYzogUGV0ciBMYXV0cmJhY2ggPHBsYXV0cmJhQHJlZGhh
dC5jb20+CgpUaGFua3MsCkxhc3psbwoKTGFzemxvIEVyc2VrICg1KToKICBzZXRmaWxlczogZml4
IHVwIGluY29uc2lzdGVudCBpbmRlbnRhdGlvbgogIHNldGZpbGVzOiByZW1vdmUgdXNlbGVzcyBh
c3NpZ25tZW50IGFuZCBjb21tZW50IChhZnRlciBSSEJaIzE5MjYzODYpCiAgc2V0ZmlsZXM6IHJl
bW92ZSB1c2VsZXNzICJpYW1yZXN0b3JlY29uIiBjaGVja3MgaW4gb3B0aW9uIHBhcnNpbmcKICBz
ZWxpbnV4X3Jlc3RvcmVjb246IGludHJvZHVjZSBTRUxJTlVYX1JFU1RPUkVDT05fQ09VTlRfRVJS
T1JTCiAgc2V0ZmlsZXM6IGludHJvZHVjZSB0aGUgLUMgb3B0aW9uIGZvciBkaXN0aW5ndWlzaGlu
ZyBmaWxlIHRyZWUgd2FsawogICAgZXJyb3JzCgogbGlic2VsaW51eC9pbmNsdWRlL3NlbGludXgv
cmVzdG9yZWNvbi5oICAgICAgICAgICAgICAgICAgICAgfCAxNSArKysrKysrKwogbGlic2VsaW51
eC9tYW4vbWFuMy9zZWxpbnV4X3Jlc3RvcmVjb24uMyAgICAgICAgICAgICAgICAgICAgfCAyMiAr
KysrKysrKysrKy0KIGxpYnNlbGludXgvbWFuL21hbjMvc2VsaW51eF9yZXN0b3JlY29uX2dldF9z
a2lwcGVkX2Vycm9ycy4zIHwgMjggKysrKysrKysrKysrKysrCiBsaWJzZWxpbnV4L3NyYy9saWJz
ZWxpbnV4Lm1hcCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA1ICsrKwogbGlic2Vs
aW51eC9zcmMvc2VsaW51eF9yZXN0b3JlY29uLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAz
NCArKysrKysrKysrKysrKystLS0KIHBvbGljeWNvcmV1dGlscy9zZXRmaWxlcy9yZXN0b3JlLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDggKysrLS0KIHBvbGljeWNvcmV1dGlscy9zZXRm
aWxlcy9yZXN0b3JlLmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKystCiBwb2xpY3lj
b3JldXRpbHMvc2V0ZmlsZXMvc2V0ZmlsZXMuOCAgICAgICAgICAgICAgICAgICAgICAgICB8IDIy
ICsrKysrKysrKysrKwogcG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3NldGZpbGVzLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAzNiArKysrKysrKystLS0tLS0tLS0tLQogOSBmaWxlcyBjaGFu
Z2VkLCAxNDUgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2
NDQgbGlic2VsaW51eC9tYW4vbWFuMy9zZWxpbnV4X3Jlc3RvcmVjb25fZ2V0X3NraXBwZWRfZXJy
b3JzLjMKCgpiYXNlLWNvbW1pdDogMmExNjdkMTE1NjU3OGZjMjk1NDFmNmZiNjBhZjY1NDUyZjQz
MWFhZQotLSAKMi4xOS4xLjMuZzMwMjQ3YWE1ZDIwMQoK

