Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69A3C77B7A
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 01:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjFHBrP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 21:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjFHBrP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jun 2023 21:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4E9270E
        for <selinux@vger.kernel.org>; Wed,  7 Jun 2023 18:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686188725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HR6xXwvrxVA6jnBqv44ySjZkIoku+f17qkvkrOMUYx0=;
        b=IpqIrL6ImUZdhjrDqyzbH12WqKpdmT2uEKjIgx+okWsiKsOu0+GllgbZcCxk1XdSMJ9i6A
        zd2BxJLNYu2kNY5T+MQViwFDzWFFQddj/4UEhkG3fh6chp4T3Zg0Pn5DPy7JsK0meRKKuE
        TQiovIc225hqyP7UZ3VD8ej9eZ0Nj90=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-zcVRjk4CMl6ZU9vVDgI_3Q-1; Wed, 07 Jun 2023 21:45:21 -0400
X-MC-Unique: zcVRjk4CMl6ZU9vVDgI_3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91C24185A78E;
        Thu,  8 Jun 2023 01:45:21 +0000 (UTC)
Received: from localhost (unknown [10.64.240.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE58440CFD46;
        Thu,  8 Jun 2023 01:45:20 +0000 (UTC)
Date:   Thu, 08 Jun 2023 10:45:19 +0900 (JST)
Message-Id: <20230608.104519.1875360494381639294.yamato@redhat.com>
To:     jwcart2@gmail.com
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 1/4] dismod: add --help option
From:   Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <CAP+JOzTypfDmj1jF8o28dWUABuFyEUjq4DVMefTzwL-BkHVnDA@mail.gmail.com>
References: <20230531013224.1135775-1-yamato@redhat.com>
        <CAP+JOzTypfDmj1jF8o28dWUABuFyEUjq4DVMefTzwL-BkHVnDA@mail.gmail.com>
Organization: Red Hat Japan, K.K.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

PiBPbiBUdWUsIE1heSAzMCwgMjAyMyBhdCA5OjM24oCvUE0gTWFzYXRha2UgWUFNQVRPIDx5YW1h
dG9AcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWFzYXRha2UgWUFN
QVRPIDx5YW1hdG9AcmVkaGF0LmNvbT4NCj4gDQo+IEl0IG1pZ2h0IG1ha2Ugc2Vuc2UgdG8gYWRk
IHRoZSBhY3Rpb25zIG9wdGlvbiB0byBkaXNwb2wgYXMgd2VsbCwgYnV0IEkNCj4gYW0gbm90IHN1
cmUgaG93IG11Y2ggZGlzbW9kIGFuZCBkaXNwb2wgYXJlIGFjdHVhbGx5IHVzZWQuDQoNClNlZSBo
dHRwczovL3NlcnZlcmZhdWx0LmNvbS9xdWVzdGlvbnMvMzIxMzAxL2hvdy1kby1pLXZpZXctdGhl
LWNvbnRlbnRzLW9mLWEtc2VsaW51eC1wb2xpY3ktcGFja2FnZQ0KDQpUaGUgcGFnZSBpcyB2aWV3
ZWQgNDBLIHRpZW1zLiANClRoZXJlIGFyZSBhbHdhc3kgc29tZSBwZW9wbGUgaW50ZXJlc3RlZCBp
biB0aGUgYmFja3lhcmQgb2YgdGVjaG5vb2d5Lg0KDQpNYXNhdGFrZSBZQU1BVE8NCg0KPiANCj4g
Rm9yIHRoZXNlIGZvdXIgcGF0Y2hlczoNCj4gQWNrZWQtYnk6IEphbWVzIENhcnRlciA8andjYXJ0
MkBnbWFpbC5jb20+DQo+IA0KPj4gLS0tDQo+PiAgY2hlY2twb2xpY3kvdGVzdC9kaXNtb2QuYyB8
IDggKysrKysrLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9jaGVja3BvbGljeS90ZXN0L2Rpc21vZC5jIGIv
Y2hlY2twb2xpY3kvdGVzdC9kaXNtb2QuYw0KPj4gaW5kZXggOTI5ZWUzMDguLmViMDkwYTM2IDEw
MDY0NA0KPj4gLS0tIGEvY2hlY2twb2xpY3kvdGVzdC9kaXNtb2QuYw0KPj4gKysrIGIvY2hlY2tw
b2xpY3kvdGVzdC9kaXNtb2QuYw0KPj4gQEAgLTY2LDcgKzY2LDExIEBAIHN0YXRpYyBjb25zdCBj
aGFyICpzeW1ib2xfbGFiZWxzWzldID0gew0KPj4NCj4+ICBzdGF0aWMgX19hdHRyaWJ1dGVfXygo
X19ub3JldHVybl9fKSkgdm9pZCB1c2FnZShjb25zdCBjaGFyICpwcm9nbmFtZSkNCj4+ICB7DQo+
PiAtICAgICAgIHByaW50ZigidXNhZ2U6ICAlcyBiaW5hcnlfcG9sX2ZpbGVcblxuIiwgcHJvZ25h
bWUpOw0KPj4gKyAgICAgICBwdXRzKCJVc2FnZToiKTsNCj4+ICsgICAgICAgcHJpbnRmKCIgJXMg
W09QVElPTlNdIGJpbmFyeV9wb2xfZmlsZVxuXG4iLCBwcm9nbmFtZSk7DQo+PiArICAgICAgIHB1
dHMoIk9wdGlvbnM6Iik7DQo+PiArICAgICAgIHB1dHMoIiAtaCwgLS1oZWxwICAgICAgIHByaW50
IHRoaXMgaGVscCBtZXNzYWdlIik7DQo+PiArICAgICAgIHB1dHMoIlxuIik7DQo+PiAgICAgICAg
IGV4aXQoMSk7DQo+PiAgfQ0KPj4NCj4+IEBAIC04NzIsNyArODc2LDcgQEAgaW50IG1haW4oaW50
IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPj4gICAgICAgICBGSUxFICpvdXRfZnAgPSBzdGRvdXQ7DQo+
PiAgICAgICAgIGNoYXIgYW5zWzgxXSwgT3V0ZmlsZU5hbWVbMTIxXTsNCj4+DQo+PiAtICAgICAg
IGlmIChhcmdjICE9IDIpDQo+PiArICAgICAgIGlmIChhcmdjIDwgMiB8fCBzdHJjbXAoYXJndlsx
XSwgIi1oIikgPT0gMCB8fCBzdHJjbXAoYXJndlsxXSwgIi0taGVscCIpID09IDApDQo+PiAgICAg
ICAgICAgICAgICAgdXNhZ2UoYXJndlswXSk7DQo+Pg0KPj4gICAgICAgICAvKiByZWFkIHRoZSBi
aW5hcnkgcG9saWN5ICovDQo+PiAtLQ0KPj4gMi40MC4xDQo+Pg0KPiANCg==

