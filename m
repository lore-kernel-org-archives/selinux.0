Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11602C433EF
	for <selinux@archiver.kernel.org>; Tue,  3 May 2022 08:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiECI1E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 May 2022 04:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiECI1D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 May 2022 04:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28EE329800
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651566211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/taJ9sE0u0byJCX8Eni1IyaMwiCBepL38AsaKItU+M=;
        b=T1dGFpa30N0qS9yDUGqeY6yaHkFl7UBhQ4/XpUnrEyC5j8yPuX6ZDxDaJHG/677tiF2nkg
        qBAkc97NaQz/kLQLcsOdNizeDsy3uQbRzSlscM+az00Vgo/xf4hDgi4fjR4QHbNzCA7mSR
        zzQNB3NuavJhUvXhg/NmX1zQt4YioUk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-DU14Ls9PMcmspjwsah5qNg-1; Tue, 03 May 2022 04:23:29 -0400
X-MC-Unique: DU14Ls9PMcmspjwsah5qNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78FA71C01E83
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 08:23:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95C9940CFD29;
        Tue,  3 May 2022 08:23:28 +0000 (UTC)
From:   Laszlo Ersek <lersek@redhat.com>
To:     SELinux List <selinux@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     "Richard W.M. Jones" <rjones@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 1/5] setfiles: fix up inconsistent indentation
Date:   Tue,  3 May 2022 10:23:22 +0200
Message-Id: <20220503082326.11621-2-lersek@redhat.com>
In-Reply-To: <20220503082326.11621-1-lersek@redhat.com>
References: <20220503082326.11621-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Q29tbWl0IDdhZDg0ZTdjOGQ0ZiAoIkFkZCByZXN0b3JlY29uIC14IG9wdGlvbiB0byBub3QgY3Jv
c3MgRlMKYm91bmRhcmllcyIsIDIwMjAtMDYtMTgpIHVzZWQgc3BhY2VzIHZzLiBUQUJzIGluY29u
c2lzdGVudGx5OyBydW4KInVuZXhwYW5kIiBvbiB0aGUgYWZmZWN0ZWQgbGluZXMgdG8gbWFrZSB0
aGUgaW5kZW50YXRpb24gY29uZm9ybSB0byB0aGUKcmVzdCBvZiB0aGUgc291cmNlIGNvZGUuCgpD
YzogIlJpY2hhcmQgVy5NLiBKb25lcyIgPHJqb25lc0ByZWRoYXQuY29tPgpDYzogUGV0ciBMYXV0
cmJhY2ggPHBsYXV0cmJhQHJlZGhhdC5jb20+CkJ1Z3ppbGxhOiBodHRwczovL2J1Z3ppbGxhLnJl
ZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE3OTQ1MTgKU2lnbmVkLW9mZi1ieTogTGFzemxvIEVy
c2VrIDxsZXJzZWtAcmVkaGF0LmNvbT4KLS0tCiBwb2xpY3ljb3JldXRpbHMvc2V0ZmlsZXMvc2V0
ZmlsZXMuYyB8IDEwICsrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3Nl
dGZpbGVzLmMgYi9wb2xpY3ljb3JldXRpbHMvc2V0ZmlsZXMvc2V0ZmlsZXMuYwppbmRleCBhYjcw
MTZhY2E5YTYuLmJlODhiZTVkNTQ5NyAxMDA2NDQKLS0tIGEvcG9saWN5Y29yZXV0aWxzL3NldGZp
bGVzL3NldGZpbGVzLmMKKysrIGIvcG9saWN5Y29yZXV0aWxzL3NldGZpbGVzL3NldGZpbGVzLmMK
QEAgLTM2OCwxMyArMzY4LDEzIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAkJ
Y2FzZSAnMCc6CiAJCQludWxsX3Rlcm1pbmF0ZWQgPSAxOwogCQkJYnJlYWs7Ci0gICAgICAgICAg
ICAgICAgY2FzZSAneCc6Ci0gICAgICAgICAgICAgICAgICAgICAgICBpZiAoaWFtcmVzdG9yZWNv
bikgeworCQljYXNlICd4JzoKKwkJCWlmIChpYW1yZXN0b3JlY29uKSB7CiAJCQkJcl9vcHRzLnhk
ZXYgPSBTRUxJTlVYX1JFU1RPUkVDT05fWERFVjsKLSAgICAgICAgICAgICAgICAgICAgICAgIH0g
ZWxzZSB7CisJCQl9IGVsc2UgewogCQkJCXVzYWdlKGFyZ3ZbMF0pOwotICAgICAgICAgICAgICAg
ICAgICAgICAgfQotICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7CisJCQl9CisJCQlicmVh
azsKIAkJY2FzZSAnVCc6CiAJCQludGhyZWFkcyA9IHN0cnRvdWxsKG9wdGFyZywgJmVuZHB0ciwg
MTApOwogCQkJaWYgKCpvcHRhcmcgPT0gJ1wwJyB8fCAqZW5kcHRyICE9ICdcMCcpCi0tIAoyLjE5
LjEuMy5nMzAyNDdhYTVkMjAxCgoK

