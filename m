Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022FC433E0
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF9E2065F
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="De+Y4x4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgGXNGS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:06:18 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:57548 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgGXNGS (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 24 Jul 2020 09:06:18 -0400
Received: from [IPv6:2001:985:d55d::438] (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 3D3822A1007;
        Fri, 24 Jul 2020 15:06:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 3D3822A1007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595595975;
        bh=6uNpDF6sJTiXZveoi5FeV+uaOrBLuhJ+VhRkP4akfTk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=De+Y4x4hYtHdfoY1x8+ImLfIua/XulPdi9EtxvB8w8rLmdYoCEZDham/y7b8XhEur
         ioeNTweHd7GnW7qyZtX4apqBL6d3jSKrKFlpfB5kTwFtVYH1kl/Uk66dfloIVZToYV
         MUJ++nDZO+m7dGZ8c1kfvcmAlNRhn+XX9/K/PYP0=
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
Message-ID: <fde88aa9-1f4d-fb60-b27e-0da093753cdf@defensec.nl>
Date:   Fri, 24 Jul 2020 15:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5P7qGybMfhXaEVoUWWiRubhT=1NCNL-oKaY9CXjjqodg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 7/24/20 2:56 PM, Stephen Smalley wrote:
> On Fri, Jul 24, 2020 at 8:29 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>>
>>
>> On 7/24/20 2:23 PM, Stephen Smalley wrote:
>>> On Fri, Jul 24, 2020 at 3:54 AM Dominick Grift
>>> <dominick.grift@defensec.nl> wrote:
>>>>
>>>>
>>>>
>>>> On 7/23/20 3:24 PM, Stephen Smalley wrote:
>>>>  > There is a tension there with fail-closed versus fail-open and the
>>>>> potential for a security vulnerability to arise if it proceeds.  Would
>>>>> have to look at the specifics to evaluate how it should be handled.
>>>>> Of course, in practice, one really shouldn't be removing contexts
>>>>> while they are still in use (or else use aliases to preserve some
>>>>> degree of compatibility).
>>>>>
>>>>
>>>> I guess if there is tension be between GNU/Linux use of libselinux and
>>>> SEAndroids use of libselinux, where SE for Android is implemented by the
>>>> vendor to be immutable by the device owner, and where GNU/Linux
>>>> leverages SELinux to empower device owners, then any tension can be
>>>> alleviated if Google forks libselinux. In GNU/Linux it should just be
>>>> possible to switch policies.
>>>
>>> I wasn't talking about Android, just about the tension of
>>> fail-closed/secure versus fail-open/insecure in general.
>>> I don't have any problem with someone installing a new policy that
>>> completely changes the set of file contexts; I just don't think they
>>> should do that at runtime without a reboot in between and expect
>>> things to work seamlessly.
>>>
>>
>> Yes but that is not what I am saying. It does not work even when you
>> reboot. I tried to explain that:
>>
>> You install a new policy and run fixfiles -F onboot && reboot (as one
>> should)
>>
>> systemd will fail to compute create socket activated sockets. and so
>> these socket activated daemon fail to start.
>>
>> One of the daemons is device-mapper, and so if you use LVM type stuff
>> you may end up with with a system that is only partially relabeled.
>>
>> Not to mention that in the relabel target various other services that
>> are socket activated fail to start, and so  who know how else that may
>> affect things.
>>
>> There is also this (however this might no longer be accurate):
>>
>> systemd computes whether it can dynamically transition on boot. If the
>> systemd executable file has an invalid label and this computation fails
>> then systemd might just freeze in the first place.
> 
> I think for this kind of complete policy changeover, you need to
> relabel prior to rebooting.

I think i tried that, but the extended attribute filesystems need to be
re-initialized AFAIK else fixfiles just returns with "Operation not
supported". Not sure if that strictly speaking requires a reboot or if
you can somehow do that with mount -o remount?

Is there a way to enable labeling support of extended attribute
filesystems without rebooting?

I think there was a patch recently by the Red Hat ContainerOS people to
enable labeling from the initramfs (ie labeling when SELinux is
disabled) How does that relate to the issue where I am seemingly not
able to relabel the filesystem after adding a fsuse trans rule without
rebooting? (ie SELinux is enabled, there is a fsuse xattr but the
filesystem hasnt been re-initialized yes and setfiles reports "operation
not supported")

  Obviously that carries its own set of
> challenges; you'd at least have to switch to permissive mode first and
> potentially run setfiles in a domain (e.g. setfiles_mac_t) that is
> allowed to get/set contexts unknown to the current policy
> (CAP_MAC_ADMIN + capability2 mac_admin permission) or load the new
> policy prior to running setfiles.  Or boot with SELinux disabled,
> label via setfiles, and then boot with the new policy.  The preferred
> model of course is to install with the desired policy in the first
> place. IIUC Android upgrades are a bit different in that they reboot
> into recovery mode, create the new filesystem (required anyway for
> dm-verity) with the correct labels for its policy, and then reboot
> into normal mode.
> 
> I don't think the separate autorelabel service can work for whole
> policy changeovers; it would need to be done directly by systemd
> itself prior to any other actions.  I think Android's init does
> something like that for the userdata partition since that doesn't get
> replaced on upgrades.
> 
