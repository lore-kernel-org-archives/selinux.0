Return-Path: <SRS0=Vikk=BC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA71C433E1
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 08:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4E22086A
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 08:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="hQFeN+jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgGWINM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:13:12 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:56822 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgGWINL (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 23 Jul 2020 04:13:11 -0400
Received: from [IPv6:2001:985:d55d::438] (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 06DBA2A06FB;
        Thu, 23 Jul 2020 10:13:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 06DBA2A06FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595491990;
        bh=1034Svdsl8CSODxqPoIheGDPGppTP/GrMs6du/sGdjg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hQFeN+jn9eCVZ2DGh66lnW+TQ1JDDUnlJ8KaR9SQn66evl31Vec2XZgFIiJRqI98K
         vHXzK7kSQAJSZEurz4bCupWQIEWEfphQC3mBfUNAXmQTQb0SbD5KkseOz/c5zh850r
         j+5fC9rmRZTog7NNBuaEl2t0kUO9OAwr6CeXzl0Y=
Subject: Re: [SELinux-notebook PATCH v8] objects.md: some clarifications
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20200721195153.1974509-1-dominick.grift@defensec.nl>
 <20200721200230.1976501-1-dominick.grift@defensec.nl>
 <ypjl365kzkvb.fsf@defensec.nl>
 <CAEjxPJ6kVLAd41X9s7216+Svdo7his_WcQW52R04CztDEYr7fg@mail.gmail.com>
 <39629738-f5db-e784-1f57-e6b8958b73ac@defensec.nl>
 <CAEjxPJ4x_JM0B01NoLHZexwA9DWerDPDxP0TJaJgGT=GSBBT7A@mail.gmail.com>
From:   Dominick Grift <dominick.grift@defensec.nl>
Autocrypt: addr=dominick.grift@defensec.nl; keydata=
 mDMEXpatqRYJKwYBBAHaRw8BAQdAJfdyO5XDdJ1R0DhG9EIDgaPAH3IcDxwCMAMX+BNXEi20
 K0RvbWluaWNrIEdyaWZ0IDxkb21pbmljay5ncmlmdEBkZWZlbnNlYy5ubD6IlgQTFggAPhYh
 BPFdMErUJbkJPwIOqdoAaTu+GpgJBQJelq2pAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJENoAaTu+GpgJN5cBAPpUgfvLek9pJ1o3zIxN0GBNs1OxIAqxeCvNxrdts3WN
 AP0T2QRpO9ti7JMWXkd3AXR7uCiYeU25PuepfRyjsUAYDLg4BF6WrakSCisGAQQBl1UBBQEB
 B0DRoS9PVlLY/xm36SxVLVbVLIKtdmTzM95muFiqEtI0LQMBCAeIfgQYFggAJhYhBPFdMErU
 JbkJPwIOqdoAaTu+GpgJBQJelq2pAhsMBQkJZgGAAAoJENoAaTu+GpgJhmYA/0NnwIlVEgyd
 6NRnjqrpkSZTiGVGIItP3ukxXYQ424drAP9LVU1SyOTNIL+S6OYYEIMosEFDjffjz6jXmsv7
 WXFbDA==
Message-ID: <a87a0d28-aa9c-ea6a-9f63-fe2f01d56e23@defensec.nl>
Date:   Thu, 23 Jul 2020 10:13:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ4x_JM0B01NoLHZexwA9DWerDPDxP0TJaJgGT=GSBBT7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 7/22/20 7:32 PM, Stephen Smalley wrote:
> On Wed, Jul 22, 2020 at 12:57 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>> Can we not just assume that if that happens, that the kernel should just
>> treat the context as if it were the context of the unlabeled isid.
> 
> No, because then a simple typo or other error in a context provided by
> a user or application would end up being handled as the unlabeled
> context instead of producing an error return that can be handled by
> the application or user.

So are you saying that it is up to the libselinux consumers to deal with
this? what do you suggest they do in these situations?

> 
>> I mean that is what it boils down to anyway: everything always needs a
>> valid context. so might as well treat invalid contexts as unlabeled
>> isids? Not sure how "state" is relevant here as invalid is invalid.
> 
> The state is whether the context was previously valid and used by the
> application.
> 
