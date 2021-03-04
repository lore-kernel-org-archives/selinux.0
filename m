Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE40FC433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 23:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E8564F59
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 23:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhCDX1j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:27:39 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48550 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhCDX1j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 18:27:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 418214D2D0CC8;
        Thu,  4 Mar 2021 15:27:37 -0800 (PST)
Date:   Thu, 04 Mar 2021 15:27:33 -0800 (PST)
Message-Id: <20210304.152733.1381456342956729385.davem@davemloft.net>
To:     paul@paul-moore.com
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, dvyukov@google.com
Subject: Re: [PATCH] cipso,calipso: resolve a number of problems with the
 DOI refcounts
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHC9VhTxfMOzABdAg=RO3k1cfyE2A2DEQ0gUQ9M6NVELpJVw7Q@mail.gmail.com>
References: <161489339182.63157.2775083878484465675.stgit@olly>
        <20210304.143347.415521310565498642.davem@davemloft.net>
        <CAHC9VhTxfMOzABdAg=RO3k1cfyE2A2DEQ0gUQ9M6NVELpJVw7Q@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Thu, 04 Mar 2021 15:27:37 -0800 (PST)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

RnJvbTogUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4NCkRhdGU6IFRodSwgNCBNYXIg
MjAyMSAxODoxMzoyMSAtMDUwMA0KDQo+IE9uIFRodSwgTWFyIDQsIDIwMjEgYXQgNTozMyBQTSBE
YXZpZCBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+IHdyb3RlOg0KPj4gRnJvbTogUGF1bCBN
b29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4NCj4+IERhdGU6IFRodSwgMDQgTWFyIDIwMjEgMTY6
Mjk6NTEgLTA1MDANCj4+DQo+PiA+ICtzdGF0aWMgdm9pZCBjYWxpcHNvX2RvaV9wdXRkZWYoc3Ry
dWN0IGNhbGlwc29fZG9pICpkb2lfZGVmKTsNCj4+ID4gKw0KPj4NCj4+IFRoaXMgaXMgYSBnbG9i
YWwgc3ltYm9sLCBzbyB3aHkgdGhlIHN0YXRpYyBkZWNsIGhlcmU/DQo+IA0KPiBUbyByZXNvbHZl
IHRoaXM6DQo+IA0KPiAgIENDICAgICAgbmV0L2lwdjYvY2FsaXBzby5vDQo+IG5ldC9pcHY2L2Nh
bGlwc28uYzogSW4gZnVuY3Rpb24goWNhbGlwc29fZG9pX3JlbW92ZaI6DQo+IG5ldC9pcHY2L2Nh
bGlwc28uYzo0NTM6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIKFj
YWxpcHNvX2RvaV9wDQo+IHV0ZGVmog0KPiANCj4gSSB0aGluayB0aGVyZSBhcmUgc29tZSBvZGQg
dGhpbmdzIHdpdGggaG93IHRoZSBDQUxJUFNPIHByb3RvdHlwZXMgYXJlDQo+IGhhbmRsZWQsIHNv
bWUgb2YgdGhhdCBJJ20gZ3Vlc3NpbmcgaXMgZHVlIHRvIGhhbmRsaW5nIElQdjYNCj4gYXMtYS1t
b2R1bGUsIGJ1dCByZWdhcmRsZXNzIG9mIHRoZSByZWFzb24gaXQgc2VlbWVkIGxpa2UgdGhlIHNt
YWxsZXN0DQo+IGZpeCB3YXMgdG8gYWRkIHRoZSBmb3J3YXJkIGRlY2xhcmF0aW9uIGF0IHRoZSB0
b3Agb2YgdGhlIGZpbGUuDQo+IENvbnNpZGVyaW5nIHRoYXQgSSBiZWxpZXZlIHRoaXMgc2hvdWxk
IGJlIHNlbnQgdG8gLXN0YWJsZSBJIGZpZ3VyZWQgYQ0KPiBzbWFsbGVyIHBhdGNoLCB3aXRoIGxl
c3MgY2hhbmNlIGZvciBtZXJnZSBjb25mbGljdHMsIHdvdWxkIGJlIG1vcmUNCj4gZGVzaXJhYmxl
Lg0KDQpUaGFua3MgZm9yIGV4cGxhaW5pbmcuLi4NCg0K
