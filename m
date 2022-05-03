Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1305FC433EF
	for <selinux@archiver.kernel.org>; Tue,  3 May 2022 08:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiECI1G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 May 2022 04:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiECI1F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 May 2022 04:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F64529800
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 01:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651566213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkB2byG/+RiO8UzmhxFyDyj62m+Q0hOEl8imykBOP0Q=;
        b=XNhWZfUHskU0IiezHvNIeByuWTofrt3AtoOsC/ap78pzdXGTFJZINbjbPpEclo0ueC5guY
        yLsj16b5hRYrWKb8GtUpM+cZbt6jVDQwSFAcHLzuHvZnRsxkKbMLMnyO8lzAQ6SXEM8oFB
        rtQ8n9MoqBPIvQPlvykczycrbq6mNxY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-JaEnwrD9OfS4ZpXvumhxcw-1; Tue, 03 May 2022 04:23:32 -0400
X-MC-Unique: JaEnwrD9OfS4ZpXvumhxcw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E66D0833965
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 08:23:31 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F058A40CFD29;
        Tue,  3 May 2022 08:23:30 +0000 (UTC)
From:   Laszlo Ersek <lersek@redhat.com>
To:     SELinux List <selinux@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     "Richard W.M. Jones" <rjones@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 3/5] setfiles: remove useless "iamrestorecon" checks in option parsing
Date:   Tue,  3 May 2022 10:23:24 +0200
Message-Id: <20220503082326.11621-4-lersek@redhat.com>
In-Reply-To: <20220503082326.11621-1-lersek@redhat.com>
References: <20220503082326.11621-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Q29tbWl0IDIxOWVlYTgzY2VhOSAoInBvbGljeWNvcmV1dGlsczogc2V0ZmlsZXMvcmVzdG9yZWNv
bjogZml4IC1yLy1SCm9wdGlvbiIsIDIwMTUtMDQtMTYpIHNwbGl0IHRoZSBvcHRpb24gc3RyaW5n
cyBiZXR3ZWVuICJzZXRmaWxlcyIgYW5kCiJyZXN0b3JlY29uIi4gU2luY2UgdGhhdCBjb21taXQs
IGFuICJpYW1yZXN0b3JlY29uIiBjaGVjayBoYXMgb25seSBiZWVuCm5lY2Vzc2FyeSBmb3IgYW4g
b3B0aW9uIHRoYXQgaXMgKGEpIGFjY2VwdGVkIGJ5IGJvdGggInNldGZpbGVzIiBhbmQKInJlc3Rv
cmVjb24iLCBidXQgKGIpIGJlaGF2ZXMgZGlmZmVyZW50bHkgYmV0d2VlbiAic2V0ZmlsZXMiIGFu
ZAoicmVzdG9yZWNvbiIuIEN1cnJlbnRseSwgdGhlIG9ubHkgc3VjaCBvcHRpb25zIGFyZSAiLXIi
IGFuZCAiLVIiLiBSZW1vdmUKdGhlICJpYW1yZXN0b3JlY29uIiBjaGVja3MgZnJvbSB0aGUgInNl
dGZpbGVzIi1vbmx5ICItYyIgYW5kICItZCIgb3B0aW9ucywKYW5kIGZyb20gdGhlICJyZXN0b3Jl
Y29uIi1vbmx5ICIteCIgb3B0aW9uLgoKQ2M6ICJSaWNoYXJkIFcuTS4gSm9uZXMiIDxyam9uZXNA
cmVkaGF0LmNvbT4KQ2M6IFBldHIgTGF1dHJiYWNoIDxwbGF1dHJiYUByZWRoYXQuY29tPgpCdWd6
aWxsYTogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNzk0NTE4
ClNpZ25lZC1vZmYtYnk6IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhhdC5jb20+ClJldmlld2Vk
LUJ5OiBEYW5pZWwgQnVyZ2VuZXIgPGRidXJnZW5lckBsaW51eC5taWNyb3NvZnQuY29tPgotLS0K
Ck5vdGVzOgogICAgdjI6CiAgICAKICAgIC0gcGljayB1cCBEYW5pZWwgQnVyZ2VuZXIncyBSLWIK
CiBwb2xpY3ljb3JldXRpbHMvc2V0ZmlsZXMvc2V0ZmlsZXMuYyB8IDExICstLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3BvbGljeWNvcmV1dGlscy9zZXRmaWxlcy9zZXRmaWxlcy5jIGIvcG9saWN5Y29yZXV0aWxz
L3NldGZpbGVzL3NldGZpbGVzLmMKaW5kZXggY2Y1MDQ2MThkMzhmLi5hZWVjMWZkY2MyYWIgMTAw
NjQ0Ci0tLSBhL3BvbGljeWNvcmV1dGlscy9zZXRmaWxlcy9zZXRmaWxlcy5jCisrKyBiL3BvbGlj
eWNvcmV1dGlscy9zZXRmaWxlcy9zZXRmaWxlcy5jCkBAIC0yMjcsOSArMjI3LDYgQEAgaW50IG1h
aW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCQkJewogCQkJCUZJTEUgKnBvbGljeXN0cmVhbTsK
IAotCQkJCWlmIChpYW1yZXN0b3JlY29uKQotCQkJCQl1c2FnZShhcmd2WzBdKTsKLQogCQkJCXBv
bGljeWZpbGUgPSBvcHRhcmc7CiAKIAkJCQlwb2xpY3lzdHJlYW0gPSBmb3Blbihwb2xpY3lmaWxl
LCAiciIpOwpAQCAtMjY3LDggKzI2NCw2IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJn
dikKIAkJCWlucHV0X2ZpbGVuYW1lID0gb3B0YXJnOwogCQkJYnJlYWs7CiAJCWNhc2UgJ2QnOgot
CQkJaWYgKGlhbXJlc3RvcmVjb24pCi0JCQkJdXNhZ2UoYXJndlswXSk7CiAJCQlyX29wdHMuZGVi
dWcgPSAxOwogCQkJcl9vcHRzLmxvZ19tYXRjaGVzID0KIAkJCQkJICAgU0VMSU5VWF9SRVNUT1JF
Q09OX0xPR19NQVRDSEVTOwpAQCAtMzY3LDExICszNjIsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpCiAJCQludWxsX3Rlcm1pbmF0ZWQgPSAxOwogCQkJYnJlYWs7CiAJCWNhc2Ug
J3gnOgotCQkJaWYgKGlhbXJlc3RvcmVjb24pIHsKLQkJCQlyX29wdHMueGRldiA9IFNFTElOVVhf
UkVTVE9SRUNPTl9YREVWOwotCQkJfSBlbHNlIHsKLQkJCQl1c2FnZShhcmd2WzBdKTsKLQkJCX0K
KwkJCXJfb3B0cy54ZGV2ID0gU0VMSU5VWF9SRVNUT1JFQ09OX1hERVY7CiAJCQlicmVhazsKIAkJ
Y2FzZSAnVCc6CiAJCQludGhyZWFkcyA9IHN0cnRvdWxsKG9wdGFyZywgJmVuZHB0ciwgMTApOwot
LSAKMi4xOS4xLjMuZzMwMjQ3YWE1ZDIwMQoKCg==

