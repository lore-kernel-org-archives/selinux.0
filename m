Return-Path: <SRS0=bGuM=BB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F8DC433E3
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EAC2207E8
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 16:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="MkLDOWU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGVQ5f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:57:35 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:56496 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgGVQ5f (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 22 Jul 2020 12:57:35 -0400
Received: from [IPv6:2001:985:d55d::438] (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 515932A1010;
        Wed, 22 Jul 2020 18:57:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 515932A1010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595437053;
        bh=TZ37PNcqpsl4lQFIfwPo29+NxB4A8PtNyzar0nJtv34=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MkLDOWU3+nEAYsO6CzRmnD6TZKDuk9bd0m9g6GuYU+V85TySc2I0qaUwl9StKiVF4
         6cokkgwmL0SXXhwrX2jTXIPFZwJw66Ejbhi/OxNpJ6341Q2+p8ItP1xpDePB7zc3CF
         +IF8Lut8s911UnQkQzwXxpPCazEBkYMSArfZ4RAI=
Subject: Re: [SELinux-notebook PATCH v8] objects.md: some clarifications
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20200721195153.1974509-1-dominick.grift@defensec.nl>
 <20200721200230.1976501-1-dominick.grift@defensec.nl>
 <ypjl365kzkvb.fsf@defensec.nl>
 <CAEjxPJ6kVLAd41X9s7216+Svdo7his_WcQW52R04CztDEYr7fg@mail.gmail.com>
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
Message-ID: <39629738-f5db-e784-1f57-e6b8958b73ac@defensec.nl>
Date:   Wed, 22 Jul 2020 18:57:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6kVLAd41X9s7216+Svdo7his_WcQW52R04CztDEYr7fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 7/22/20 6:48 PM, Stephen Smalley wrote:
> On Tue, Jul 21, 2020 at 4:14 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>> +context for both subjects and objects when their label is invalidated
>>> +by a policy reload (their SID is unchanged but the SID is
>>> +transparently remapped to the unlabeled context).
>>
>> I will note here that I suspect there is currently something broken
>> with libselinux / unlabeled sids
>>
>> libselinux consumers still use *invalidated* contexts associated with
>> inodes to compute access vectors.
>>
>> for example rpm will not consistently work until the filesystems are
>> relabeled after a new policy is loaded that invalidates contexts
>> currently associated with /bin/sh (entrypoint for setfscreatecon to
>> "rpm_script_t")
>>
>> systemd will not consistently work until the filesystems are relabeled
>> after a new policy loaded that invalidates contexts currently associated
>> with (i suspect) parent directories for socket activated sock files
>> (maybe setfscreatecon?)
> 
> That's because userspace doesn't pass SIDs to the kernel (they aren't
> exported by the kernel); it passes security contexts, and the kernel
> refuses to accept invalid contexts. So a context previously used by
> userspace that is invalidated by a policy reload and then later passed
> in again to a kernel interface will produce an error.  IIRC, the

Can we not just assume that if that happens, that the kernel should just
treat the context as if it were the context of the unlabeled isid.

I mean that is what it boils down to anyway: everything always needs a
valid context. so might as well treat invalid contexts as unlabeled
isids? Not sure how "state" is relevant here as invalid is invalid.

Regardless, this current behavior makes things less robust. I wont
pretent that I am qualified to judge whether addressing this is
technically possible or not.

> security_get_initial_context() and avc_get_initial_sid() interfaces
> were added to allow userspace object managers like SEPostgreSQL to get
> the context associated with an initial SID like the unlabeled SID for
> their own internal use/handling, but libselinux doesn't try to remap
> like that internally and it wouldn't always know whether the context
> was previously valid unless it maintained state on all calls.
> 
