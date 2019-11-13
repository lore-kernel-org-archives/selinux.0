Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F39CC43331
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 06:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAB321A49
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 06:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfKMG65 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 01:58:57 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:40062 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbfKMG65 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 13 Nov 2019 01:58:57 -0500
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id A3BFC19E0E9B5018228F;
        Wed, 13 Nov 2019 14:58:54 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.243]) by
 DGGEML404-HUB.china.huawei.com ([fe80::b177:a243:7a69:5ab8%31]) with mapi id
 14.03.0439.000; Wed, 13 Nov 2019 14:58:52 +0800
From:   kongbaichuan <kongbaichuan@huawei.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHJlc3RvcmVjb25kOiBGaXggcmVkdW5kYW50IGNv?=
 =?utf-8?Q?nsole_log_output_error?=
Thread-Topic: [PATCH] restorecond: Fix redundant console log output error
Thread-Index: AQHVmXCwInfkntC5gUO+YpYlnRZb7aeHKfqAgAF3dCCAAAnD8A==
Date:   Wed, 13 Nov 2019 06:58:51 +0000
Message-ID: <29DB54BD44962C418560B9F4D8E964C41B2BED27@DGGEML522-MBX.china.huawei.com>
References: <20191112012328.2314-1-kongbaichuan@huawei.com>
 <fac0b04d-7d96-eedd-c083-31bc9b00597f@tycho.nsa.gov>
 <acce2e1f-1deb-7a4a-9fca-6cc6c0a71c70@tycho.nsa.gov> 
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.101.91]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

bGludXhfc3VzZV9zcDRfd29yazovdG1wICMgcmVhZGVsZiAtcyBzZXRmaWxlcyB8IGdyZXAgcl9v
cHRzDQogICAgNTM6IDAwMDAwMDAwMDAwMTQwMjAgICAxMjAgT0JKRUNUICBMT0NBTCAgREVGQVVM
VCAgIDIyIHJfb3B0cw0KICAgMTE0OiAwMDAwMDAwMDAwMDE0MGMwICAgICA4IE9CSkVDVCAgR0xP
QkFMIERFRkFVTFQgICAyMiByX29wdHMNCmxpbnV4X3N1c2Vfc3A0X3dvcms6L3RtcCAjIHJlYWRl
bGYgLXMgcmVzdG9yZWNvbmQgfCBncmVwIHJfb3B0cw0KICAgMTAxOiAwMDAwMDAwMDAwMDA2MGMw
ICAgMTI4IE9CSkVDVCAgR0xPQkFMIERFRkFVTFQgICAyMyByX29wdHMNCg0KVGhpcyBpcyB0aGUg
ZW50cmllcyBvZiByX29wdHMgaW4gc3ltYm9sIHRhYmxlIG9mIHNldGZpbGVzIGFuZCByZXN0b3Jl
Y29uZC4gVGhlcmUgaXMgb25lIHJfb3B0cyBpcyANCmNvdmVyZCBieSBhbm90aGVyIGluIHJlc3Rv
cmVjb25kLCBidXQgaXQgbm90IGhhcHBlbmVkIHRvIHNldGZpbGVzLg0K
