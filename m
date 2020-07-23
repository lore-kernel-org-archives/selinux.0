Return-Path: <SRS0=Vikk=BC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EFDC433DF
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 13:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0F920792
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 13:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="hqGunFLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgGWNEd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:04:33 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:56902 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGWNEd (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 23 Jul 2020 09:04:33 -0400
Received: from [IPv6:2001:985:d55d::438] (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 6101D2A1007;
        Thu, 23 Jul 2020 15:04:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 6101D2A1007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595509472;
        bh=1UzbJ2vd7c11nwdhAkRLu4Z+8alqUmZIBZNd90ciA9U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hqGunFLY4N8Rmr/YovfPPoDPu/rKZ4l7168+pm6s2H/eb+f3uXp8bLM/Z/SwpqVDC
         EDDhBNncDPAlRJk3Mi832/S/yf7Ob6SFQ+MnfeXho4sNOW/E1EzSvsALiLZHmTJa7/
         NgXx7V0M48mbMMHTQjIZM7c+PzrgGgNeaBvZ4t0w=
Subject: Re: [SELinux-notebook PATCH v8] objects.md: some clarifications
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20200721195153.1974509-1-dominick.grift@defensec.nl>
 <20200721200230.1976501-1-dominick.grift@defensec.nl>
 <ypjl365kzkvb.fsf@defensec.nl>
 <CAEjxPJ6kVLAd41X9s7216+Svdo7his_WcQW52R04CztDEYr7fg@mail.gmail.com>
 <39629738-f5db-e784-1f57-e6b8958b73ac@defensec.nl>
 <CAEjxPJ4x_JM0B01NoLHZexwA9DWerDPDxP0TJaJgGT=GSBBT7A@mail.gmail.com>
 <a87a0d28-aa9c-ea6a-9f63-fe2f01d56e23@defensec.nl>
 <CAEjxPJ7YfUkhej=aMObg7c42KgHpmX_qBdC+30BmuhJ9-LtBJg@mail.gmail.com>
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
Message-ID: <cf636a16-5f4c-99e7-f2a9-0fede46b233f@defensec.nl>
Date:   Thu, 23 Jul 2020 15:04:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7YfUkhej=aMObg7c42KgHpmX_qBdC+30BmuhJ9-LtBJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 7/23/20 2:22 PM, Stephen Smalley wrote:
> On Thu, Jul 23, 2020 at 4:13 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>>
>>
>> On 7/22/20 7:32 PM, Stephen Smalley wrote:
>>> On Wed, Jul 22, 2020 at 12:57 PM Dominick Grift
>>> <dominick.grift@defensec.nl> wrote:
>>>> Can we not just assume that if that happens, that the kernel should just
>>>> treat the context as if it were the context of the unlabeled isid.
>>>
>>> No, because then a simple typo or other error in a context provided by
>>> a user or application would end up being handled as the unlabeled
>>> context instead of producing an error return that can be handled by
>>> the application or user.
>>
>> So are you saying that it is up to the libselinux consumers to deal with
>> this? what do you suggest they do in these situations?
> 
> libselinux cannot handle it in the general case.  If using the
> userspace AVC and SIDs obtained via avc_context_to_sid(), then
> libselinux could transparently re-map those to the unlabeled context
> if they cease to be valid.  Otherwise, it is up to the callers to deal
> with and the correct handling is application-specific.  SEPostgreSQL
> does this for example:
> https://github.com/postgres/postgres/blob/master/contrib/sepgsql/label.c#L460
> 
> However, I don't think that would help something like systemd; even if
> you re-map the context to the unlabeled context, you aren't going to
> get a useful result from security_compute_create() or similar to use
> in labeling sockets, processes, files, etc.>

I suppose systemd probably should not fail "hard" when getfilecon (or
whatever) fails and returns with "invalid argument", and it should then
just not use setfilecon rather than not create the object at all (as it
seems to be doing now)
