Return-Path: <SRS0=bGuM=BB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A986C433DF
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 17:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF61207BB
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 17:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="fmPqgLTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgGVR3z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:29:55 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:56506 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgGVR3y (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 22 Jul 2020 13:29:54 -0400
Received: from [IPv6:2001:985:d55d::438] (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 2CA582A06FB;
        Wed, 22 Jul 2020 19:29:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 2CA582A06FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595438992;
        bh=XoUeG53ZYYERU1nSyBH0n1ARK2mdhF76j+xXAuHFFEY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fmPqgLTtXLIKmW/bN0vwM2U+LBuF70ITwTRXqMMAWn652aY1HT2AkQAHQDEgNhT7e
         LmEwtnS6JHoHB39/Y7a47aAnz646FUvN1SKI6I5tRNrFV/e232c6HJsXduuFhW15yO
         x1gPsmMJsfnySvZ9S2c1qVViTB66beX0aqhMEsmE=
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
Message-ID: <0f80d70d-2add-a00f-608b-d6f2f048234c@defensec.nl>
Date:   Wed, 22 Jul 2020 19:29:47 +0200
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
> security_get_initial_context() and avc_get_initial_sid() interfaces
> were added to allow userspace object managers like SEPostgreSQL to get
> the context associated with an initial SID like the unlabeled SID for
> their own internal use/handling, but libselinux doesn't try to remap
> like that internally and it wouldn't always know whether the context
> was previously valid unless it maintained state on all calls.
> 

This issue will also, in some cases, cause selinux-autorelabel to fail.


systemd can't compute the contexts for socket activated daemons, and so
these daemons fail to start. device mapper seems to be one of them, and
so partitions might not get mounted in the autorelabel target
effectively that means that autorelabel wont be able to relabel
everything (because its not mounted because device-mapper failed to
start, because systemd was unable to compute.
