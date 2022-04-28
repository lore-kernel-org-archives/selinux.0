Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FE6C433FE
	for <selinux@archiver.kernel.org>; Thu, 28 Apr 2022 06:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbiD1G5R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Apr 2022 02:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244597AbiD1G5Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Apr 2022 02:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B694986C1
        for <selinux@vger.kernel.org>; Wed, 27 Apr 2022 23:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651128842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/taJ9sE0u0byJCX8Eni1IyaMwiCBepL38AsaKItU+M=;
        b=TL5IlQf/5/p9Dc/ZJ4bt+Pz1veIjz7Vnl2xGfNG8csxNdm2EVTj/BBnj6JzaU8n0M2BVB2
        XOIh6T11y4eneY8HD3SHpI7MS0PkyiNipk96QjVCY6JGodbD+Gcel4ZzpCFadMRnywGufJ
        ia2TrNMRSGsDN+FoZw6sHfB/FhaJcJI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-QlLvAVnnNjivq7i7qyRn_Q-1; Thu, 28 Apr 2022 02:54:00 -0400
X-MC-Unique: QlLvAVnnNjivq7i7qyRn_Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A764185A7A4
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 06:54:00 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.39.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A0F7416384;
        Thu, 28 Apr 2022 06:53:58 +0000 (UTC)
From:   Laszlo Ersek <lersek@redhat.com>
To:     SELinux List <selinux@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     "Richard W.M. Jones" <rjones@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH for-3.5 1/5] setfiles: fix up inconsistent indentation
Date:   Thu, 28 Apr 2022 08:53:50 +0200
Message-Id: <20220428065354.27605-2-lersek@redhat.com>
In-Reply-To: <20220428065354.27605-1-lersek@redhat.com>
References: <20220428065354.27605-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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

