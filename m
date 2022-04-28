Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CEFC43217
	for <selinux@archiver.kernel.org>; Thu, 28 Apr 2022 06:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244609AbiD1G5X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Apr 2022 02:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbiD1G5W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Apr 2022 02:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA83F986D3
        for <selinux@vger.kernel.org>; Wed, 27 Apr 2022 23:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651128847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j5P3QQCBVFmvpvzvvmEtb7v9iZ+7+hORPzXOO8l8ZjM=;
        b=gDFOXSaxA7MyIe311GCPJfHS1/OC+Nuo9TRLWZ9qr4dvmwwA0qWgf6U3GCMqVhejHdULex
        1mBDSg+CzOZe42RWvTxyoGWc0twZUDmda5hpzkUWjmkIoyN4qp6VfhmAhdBwJDfJMuES8N
        ZOFRiWnHbmzImVOwjHAAVhVvRAbrEhA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-385sfyk_Pe6KeBsSdjaVGw-1; Thu, 28 Apr 2022 02:54:06 -0400
X-MC-Unique: 385sfyk_Pe6KeBsSdjaVGw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C482E811E90
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 06:54:05 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.39.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE1E1416384;
        Thu, 28 Apr 2022 06:54:04 +0000 (UTC)
From:   Laszlo Ersek <lersek@redhat.com>
To:     SELinux List <selinux@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     "Richard W.M. Jones" <rjones@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH for-3.5 3/5] setfiles: remove useless "iamrestorecon" checks in option parsing
Date:   Thu, 28 Apr 2022 08:53:52 +0200
Message-Id: <20220428065354.27605-4-lersek@redhat.com>
In-Reply-To: <20220428065354.27605-1-lersek@redhat.com>
References: <20220428065354.27605-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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
ClNpZ25lZC1vZmYtYnk6IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhhdC5jb20+Ci0tLQogcG9s
aWN5Y29yZXV0aWxzL3NldGZpbGVzL3NldGZpbGVzLmMgfCAxMSArLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9w
b2xpY3ljb3JldXRpbHMvc2V0ZmlsZXMvc2V0ZmlsZXMuYyBiL3BvbGljeWNvcmV1dGlscy9zZXRm
aWxlcy9zZXRmaWxlcy5jCmluZGV4IGNmNTA0NjE4ZDM4Zi4uYWVlYzFmZGNjMmFiIDEwMDY0NAot
LS0gYS9wb2xpY3ljb3JldXRpbHMvc2V0ZmlsZXMvc2V0ZmlsZXMuYworKysgYi9wb2xpY3ljb3Jl
dXRpbHMvc2V0ZmlsZXMvc2V0ZmlsZXMuYwpAQCAtMjI3LDkgKzIyNyw2IEBAIGludCBtYWluKGlu
dCBhcmdjLCBjaGFyICoqYXJndikKIAkJCXsKIAkJCQlGSUxFICpwb2xpY3lzdHJlYW07CiAKLQkJ
CQlpZiAoaWFtcmVzdG9yZWNvbikKLQkJCQkJdXNhZ2UoYXJndlswXSk7Ci0KIAkJCQlwb2xpY3lm
aWxlID0gb3B0YXJnOwogCiAJCQkJcG9saWN5c3RyZWFtID0gZm9wZW4ocG9saWN5ZmlsZSwgInIi
KTsKQEAgLTI2Nyw4ICsyNjQsNiBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJ
CQlpbnB1dF9maWxlbmFtZSA9IG9wdGFyZzsKIAkJCWJyZWFrOwogCQljYXNlICdkJzoKLQkJCWlm
IChpYW1yZXN0b3JlY29uKQotCQkJCXVzYWdlKGFyZ3ZbMF0pOwogCQkJcl9vcHRzLmRlYnVnID0g
MTsKIAkJCXJfb3B0cy5sb2dfbWF0Y2hlcyA9CiAJCQkJCSAgIFNFTElOVVhfUkVTVE9SRUNPTl9M
T0dfTUFUQ0hFUzsKQEAgLTM2NywxMSArMzYyLDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
Kiphcmd2KQogCQkJbnVsbF90ZXJtaW5hdGVkID0gMTsKIAkJCWJyZWFrOwogCQljYXNlICd4JzoK
LQkJCWlmIChpYW1yZXN0b3JlY29uKSB7Ci0JCQkJcl9vcHRzLnhkZXYgPSBTRUxJTlVYX1JFU1RP
UkVDT05fWERFVjsKLQkJCX0gZWxzZSB7Ci0JCQkJdXNhZ2UoYXJndlswXSk7Ci0JCQl9CisJCQly
X29wdHMueGRldiA9IFNFTElOVVhfUkVTVE9SRUNPTl9YREVWOwogCQkJYnJlYWs7CiAJCWNhc2Ug
J1QnOgogCQkJbnRocmVhZHMgPSBzdHJ0b3VsbChvcHRhcmcsICZlbmRwdHIsIDEwKTsKLS0gCjIu
MTkuMS4zLmczMDI0N2FhNWQyMDEKCgo=

