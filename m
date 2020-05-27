Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7E0C433DF
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 16:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE05220721
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 16:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391427AbgE0QpD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 12:45:03 -0400
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:39683 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387952AbgE0QpD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 12:45:03 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 May 2020 12:45:02 EDT
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 49XGhW4ZTxz7t8v;
        Wed, 27 May 2020 16:37:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HfevtT7Awm11; Wed, 27 May 2020 16:37:31 +0000 (UTC)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 49XGhW3mXNz3wZB;
        Wed, 27 May 2020 16:37:31 +0000 (UTC)
Received: from EXMBDFT11.ad.twosigma.com (172.23.162.14) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 May 2020 16:37:31 +0000
Received: from EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9]) by
 EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9%19]) with mapi id
 15.00.1497.000; Wed, 27 May 2020 16:37:31 +0000
From:   Nicolas Viennot <Nicolas.Viennot@twosigma.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Adrian Reber <areber@redhat.com>
CC:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        "Dirk Petersen" <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        "Cyrill Gorcunov" <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        "Stephen Smalley" <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
Subject: RE: [PATCH] capabilities: Introduce CAP_RESTORE
Thread-Topic: [PATCH] capabilities: Introduce CAP_RESTORE
Thread-Index: AQHWL/2VaDM8D7CUOUK8NWcR6t6ZmKi0T3WAgAQnIICAALWDAIACzv0AgAAj3gCAAAp/wA==
Date:   Wed, 27 May 2020 16:37:31 +0000
Message-ID: <ac167440b8b64f02a034dd94687b8aee@EXMBDFT11.ad.twosigma.com>
References: <20200522055350.806609-1-areber@redhat.com>
 <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
 <20200525080541.GF104922@dcbz.redhat.com>
 <a75f3f71-66cf-e615-2cd5-86ac65a3bbdc@schaufler-ca.com>
 <20200527134842.GA250149@dcbz.redhat.com>
 <f43921ac-2e55-7d9d-406a-d0f4cfd8ff93@schaufler-ca.com>
In-Reply-To: <f43921ac-2e55-7d9d-406a-d0f4cfd8ff93@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.118.183]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

PiA+IElmIEkgdW5kZXJzdGFuZCBwYXJ0IG9mIENSSVUgY29ycmVjdGx5LCB0aGVuIHdlIG9ubHkg
bmVlZCByZWFkLWFjY2VzcyANCj4gPiBmb3IgdGhlIGN1cnJlbnQgdXNlci4gSSBhbSBzdXJlIEFu
ZHJlaSwgUGF2ZWwgb3IgQ3lyaWxsIHdpbGwgY29ycmVjdCANCj4gPiBtZSBpZiBJIGFtIHdyb25n
IGNvbmNlcm5pbmcgbWFwX2ZpbGVzLg0KPiBJZiBJIGRvICJscyAtbCAvcHJvYy9zZWxmL21hcF9m
aWxlcyIgSSBnZXQgdGhlIGxpbmsgbmFtZSBhbmQgbGluayBjb250ZW50Lg0KPiBXaGlsZSBJIGNh
bid0IG9wZW4gL3Byb2Mvc2VsZi9tYXBfZmlsZXMvN2ZiZGUwYzMyMDAtN2ZiZGUwYzMzMDAgSSBj
YW4gcmVhZCB0aGF0IGl0IHBvaW50cyB0byAvdXNyL2xpYjY0L2xkLTIuMzAuc28sIHdoaWNoIGlz
IHNvbWV0aGluZyBJIGNhbiBvcGVuIGFuZCByZWFkLiBTdXJlLCBpdCdzIGFuIGV4dHJhIHN0ZXAs
IGJ1dCBpdCdzIG5vIGJpZyBkZWFsLiBJdCBkb2VzIHJhaXNlIHRoZSBxdWVzdGlvbiBvZiB3aGF0
IHZhbHVlIGNvbWVzIGZyb20gZGlzYWxsb3dpbmcgb3BlbiB2aWEgdGhlIHN5bWxpbmsuDQoNClJl
YWRpbmcgdGhlIHN5bWxpbmsgZG9lc24ndCB3b3JrIGluIHR3byBjYXNlczoNCjEpIFRoZSBmaWxl
IGhhcyBiZWVuIGRlbGV0ZWQNCjIpIFRoZSBmaWxlIGlzIGEgbWVtZmQgZmlsZQ0K
