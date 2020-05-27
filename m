Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A801AC433E0
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EF42075A
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 18:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391813AbgE0SF6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 14:05:58 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:56563 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389069AbgE0SF5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 14:05:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id 49XJfW6xgJz7t8y;
        Wed, 27 May 2020 18:05:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qUylFl1ppg4g; Wed, 27 May 2020 18:05:55 +0000 (UTC)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id 49XJfW65r7z3wZ5;
        Wed, 27 May 2020 18:05:55 +0000 (UTC)
Received: from EXMBDFT11.ad.twosigma.com (172.23.162.14) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 May 2020 18:05:55 +0000
Received: from EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9]) by
 EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9%19]) with mapi id
 15.00.1497.000; Wed, 27 May 2020 18:05:55 +0000
From:   Nicolas Viennot <Nicolas.Viennot@twosigma.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Adrian Reber <areber@redhat.com>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
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
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
Subject: RE: [PATCH] capabilities: Introduce CAP_RESTORE
Thread-Topic: [PATCH] capabilities: Introduce CAP_RESTORE
Thread-Index: AQHWM2XfaDM8D7CUOUK8NWcR6t6ZmKi7+1qAgAAVMoCAACZxcA==
Date:   Wed, 27 May 2020 18:05:55 +0000
Message-ID: <d5ecde0c94014a4fad090e44377e9852@EXMBDFT11.ad.twosigma.com>
References: <20200522055350.806609-1-areber@redhat.com>
 <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
 <20200525080541.GF104922@dcbz.redhat.com>
 <877dwybxvi.fsf@x220.int.ebiederm.org>
 <20200527141403.GC250149@dcbz.redhat.com>
 <20200527152955.jbbipgb6icb4nwgv@wittgenstein>
In-Reply-To: <20200527152955.jbbipgb6icb4nwgv@wittgenstein>
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

PiA+IEFsc28gaW4gdGhpcyB0aHJlYWQgS2FtaWwgbWVudGlvbmVkIHRoYXQgdGhleSBhbHNvIG5l
ZWQgY2FsbGluZyBwcmN0bCANCj4gPiB3aXRoIFBSX1NFVF9NTSBkdXJpbmcgcmVzdG9yZSBpbiB0
aGVpciBwcm9kdWN0aW9uIHNldHVwLg0KPg0KPiBXZSdyZSB1c2luZyB0aGF0IGFzIHdlbGwgYnV0
IGl0IHJlYWxseSBmZWVscyBsaWtlIHRoaXM6DQo+DQo+CXByY3RsX21hcCA9IChzdHJ1Y3QgcHJj
dGxfbW1fbWFwKXsNCj4JICAgIC5zdGFydF9jb2RlID0gc3RhcnRfY29kZSwNCj4JICAgIC5lbmRf
Y29kZSA9IGVuZF9jb2RlLA0KPgkgICAgLnN0YXJ0X3N0YWNrID0gc3RhcnRfc3RhY2ssDQo+CSAg
ICAuc3RhcnRfZGF0YSA9IHN0YXJ0X2RhdGEsDQo+CSAgICAuZW5kX2RhdGEgPSBlbmRfZGF0YSwN
Cj4JICAgIC5zdGFydF9icmsgPSBzdGFydF9icmssDQo+CSAgICAuYnJrID0gYnJrX3ZhbCwNCj4J
ICAgIC5hcmdfc3RhcnQgPSBhcmdfc3RhcnQsDQo+CSAgICAuYXJnX2VuZCA9IGFyZ19lbmQsDQo+
CSAgICAuZW52X3N0YXJ0ID0gZW52X3N0YXJ0LA0KPgkgICAgLmVudl9lbmQgPSBlbnZfZW5kLA0K
PgkgICAgLmF1eHYgPSBOVUxMLA0KPgkgICAgLmF1eHZfc2l6ZSA9IDAsDQo+CSAgICAuZXhlX2Zk
ID0gLTEsDQo+CX07DQo+DQo+IHNob3VsZCBiZWxvbmcgdW5kZXIgbnNfY2FwYWJsZShDQVBfU1lT
X0FETUlOKS4gV2h5IGlzIHRoYXQgbmVjZXNzYXJ5IHRvIHJlbGF4Pw0KDQpXaGVuIHRoZSBwcmN0
bChQUl9TRVRfTU1fTUFQLi4uKSwgdGhlIG9ubHkgcHJpdmlsZWdlZCBvcGVyYXRpb24gaXMgdG8g
Y2hhbmdlIHRoZSBzeW1saW5rIG9mIC9wcm9jL3NlbGYvZXhlIHZpYSBzZXRfbW1fZXhlX2ZpbGUo
KS4NClNlZSBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi80NDRmYzVjZGU2
NDMzMDY2MWJmNTk5NDRjNDM4NDRlN2Q0YzJjY2Q4L2tlcm5lbC9zeXMuYyNMMjAwMS1MMjAwNA0K
SXQgbmVlZHMgQ0FQX1NZU19BRE1JTiBvZiB0aGUgY3VycmVudCBuYW1lc3BhY2UuDQoNCkkgd291
bGQgYXJndWUgdGhhdCBzZXR0aW5nIHRoZSBjdXJyZW50IHByb2Nlc3MgZXhlIGZpbGUgY2hlY2sg
c2hvdWxkIGp1c3QgYmUgcmVkdWNlZCB0byBhICJjYW4geW91IHB0cmFjZSBhIGNoaWxkcmVuIiBj
aGVjay4NCkhlcmUncyB3aHk6IGFueSBwcm9jZXNzIGNhbiBtYXNxdWVyYWRlIGludG8gYW5vdGhl
ciBleGVjdXRhYmxlIHdpdGggcHRyYWNlLg0KT25lIGNhbiBmb3JrIGEgY2hpbGQsIHB0cmFjZSBp
dCwgaGF2ZSB0aGUgY2hpbGQgZXhlY3ZlKCJ0YXJnZXRfZXhlIiksIHRoZW4gcmVwbGFjZSBpdHMg
bWVtb3J5IGNvbnRlbnQgd2l0aCBhbiBhcmJpdHJhcnkgcHJvZ3JhbS4NCldpdGggQ1JJVSdzIGxp
YmNvbXBlbCBwYXJhc2l0ZSBtZWNoYW5pc20gKGh0dHBzOi8vY3JpdS5vcmcvQ29tcGVsKSB0aGlz
IGlzIGZhaXJseSBlYXN5IHRvIGltcGxlbWVudC4NCkluIGZhY3QsIHdlIGNvdWxkIG1vZGlmeSBD
UklVIHRvIGRvIGp1c3QgdGhhdCAoYnV0IHdpdGggYSBmYWlyIGFtb3VudCBvZiBlZmZvcnRzIGR1
ZSB0byB0aGUgd2F5IENSSVUgaXMgd3JpdHRlbiksDQphbmQgbm90IHJlbHkgb24gYmVpbmcgYWJs
ZSB0byBTRVRfTU1fRVhFX0ZJTEUgdmlhIHByY3RsKCkuIEluIHR1cm4sIHRoYXQgd291bGQgZ2l2
ZSBhbiBlYXN5IHdheSB0byBtYXNxdWVyYWRlIGFueSBwcm9jZXNzDQppbnRvIGFub3RoZXIgb25l
LCBwcm92aWRlZCB0aGF0IG9uZSBjYW4gcHRyYWNlIGEgY2hpbGQuDQoNCldoZW4gbm90IHVzaW5n
IFBSX1NFVF9NTV9NQVAsIGJ1dCB1c2luZyBTRVRfTU1fRVhFX0ZJTEUsIHRoZSBDQVBfUkVTT1VS
Q0VTIGF0IHRoZSByb290IG5hbWVzcGFjZSBsZXZlbCBpcyByZXF1aXJlZDoNCmh0dHBzOi8vZ2l0
aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iLzQ0NGZjNWNkZTY0MzMwNjYxYmY1OTk0NGM0Mzg0
NGU3ZDRjMmNjZDgva2VybmVsL3N5cy5jI0wyMTA5DQpUaGlzIHNlZW1zIGluY29uc2lzdGVudC4g
QWxzbyBmb3Igc29tZSByZWFzb24gY2hhbmdpbmcgYXV4diBpcyBub3QgcHJpdmlsZWdlZCBpZiB1
c2luZyBwcmN0bCB2aWEgdGhlIE1NX01BUCBtZWNoYW5pc20sIGJ1dCBpcyBwcml2aWxlZ2VkIG90
aGVyd2lzZS4NCg==
