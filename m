Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7355AC433ED
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5352320674
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="ImDRu+t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgGXNaT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXNaS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 09:30:18 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 427D1C0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 06:30:18 -0700 (PDT)
Received: from [IPv6:2001:985:d55d::438] (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 49F012A1007;
        Fri, 24 Jul 2020 15:30:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 49F012A1007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595597417;
        bh=1vXrM1Nt6aevoKmXeReZ+ibY+GBz5uQX/PV6tPVPLPQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ImDRu+t3EBsP0148qBIJqpNRHGgd4zEDas9Px1dw/RPrgKA3E5u9OmrnCdoCLpKi2
         yClfu4mnY7zfz875v50KRAVcuqAZgfiCgkTqtFejBCOdn/pHb6A2qBpq+go3EZBhBe
         loXxmDPB3wlrseKj2Z4eFTaz0Wa+SvDsCkT0/tYI=
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
 <cf636a16-5f4c-99e7-f2a9-0fede46b233f@defensec.nl>
 <CAEjxPJ6e=FSV6xiuZQW1m8yxEg-zQ-VMk=iQQYNF9JiQb3XJag@mail.gmail.com>
 <0c0245c2-ece3-f772-1595-d8433ec36386@defensec.nl>
 <CAEjxPJ7KuNR3T60-4XrsjAL-Po1a0MUuaBh_f_iTEuEVTFw+qw@mail.gmail.com>
 <ba69dd5b-8a01-5850-9375-2c99a92fe994@defensec.nl>
 <CAEjxPJ5P7qGybMfhXaEVoUWWiRubhT=1NCNL-oKaY9CXjjqodg@mail.gmail.com>
 <fde88aa9-1f4d-fb60-b27e-0da093753cdf@defensec.nl>
 <CAEjxPJ4TsTfNELBGguF7+1asKTnMdkSdNMu+R15PC=ixgeOX7Q@mail.gmail.com>
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
Message-ID: <59c019cb-37b1-1dd2-6761-f6648a7f993e@defensec.nl>
Date:   Fri, 24 Jul 2020 15:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ4TsTfNELBGguF7+1asKTnMdkSdNMu+R15PC=ixgeOX7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 7/24/20 3:26 PM, Stephen Smalley wrote:
<snip>

> 
> Second, if your policy is changing these rules and the superblock has
> already been initialized, then the only way to get your new rule
> applied is if you can cause the old superblock to go away, e.g.
> unmount.  And that won't work while it is in use.  So rebooting if
> your only option if you cannot do that.  Rebooting with SELinux
> disabled and then running setfiles will be the safest when performing
> a complete policy changeover since you will then have no interference
> by the old policy.
> 

Thanks, I think this is the answer I was looking for. It is not entirely
elegant to say the least but I guess it will have to do.
