Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793ACC433DF
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 13:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542E620792
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 13:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="bj88fYYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgGUNfF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:35:05 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:55990 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgGUNfE (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 21 Jul 2020 09:35:04 -0400
Received: from [IPv6:2001:985:d55d::438] (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 643AD2A1010;
        Tue, 21 Jul 2020 15:35:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 643AD2A1010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595338502;
        bh=RUSDIeqWyGWQdjfV077B3233AUiG0Rr4EP7sA3YPTrQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bj88fYYG9M8ZVZrHVRIhXGOiIpYVub18xb1t+jS+EzKNM1cDPm+7FLLTxKMoMBSzp
         MdY82boscimNQjj9wjneSpkKqixzT825fcb38FAYVaetD8g3HqRSrONHGlR6NGECJP
         9SQiP7ytgZElTu59qPAwW6SDneJesFM3UmTbx6ZE=
Subject: Re: [PATCH] policycoreutils: fix inaccurate description in sestatus
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20200721112512.1906547-1-dominick.grift@defensec.nl>
 <CAEjxPJ6swWoPG_55QT8=GsoXkgiQD29=F1BhjHo2xLo6w-agXQ@mail.gmail.com>
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
Message-ID: <5c8747d7-067d-1a5d-5bdd-5cfe7d38dd3b@defensec.nl>
Date:   Tue, 21 Jul 2020 15:34:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6swWoPG_55QT8=GsoXkgiQD29=F1BhjHo2xLo6w-agXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 7/21/20 3:08 PM, Stephen Smalley wrote:
> On Tue, Jul 21, 2020 at 7:27 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> strdup(selinux_policy_root()) does not return a path that can be used to derive "Loaded policy name"
>> instead if returns a path that can be used to derive "Policy name from config file".
>>
>> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> 
> My only concern with this is whether it might break scripts that
> extract bits of information from sestatus output by matching on the
> existing prefix, especially since it has been this way for a long time
> (approaching 9 years?).  OTOH, it looks like it was labeled "Policy
> from config file" prior to that commit.  No strong feelings either way
> except that we don't want to break things for users unnecessarily.

Thanks

I think I argee. pity that this slipped through the cracks in the first
place. Probably best to leave this be. I will just make a mental note
not to use sestatus in from of a camera to avoid embarrassment.

> 
>> ---
>>  policycoreutils/sestatus/sestatus.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
>> index b37f0353..8b03b028 100644
>> --- a/policycoreutils/sestatus/sestatus.c
>> +++ b/policycoreutils/sestatus/sestatus.c
>> @@ -268,7 +268,7 @@ int main(int argc, char **argv)
>>         free(root_path);
>>
>>         /* Dump all the path information */
>> -       printf_tab("Loaded policy name:");
>> +       printf_tab("Policy name from config file:");
>>         pol_path = strdup(selinux_policy_root());
>>         if (pol_path) {
>>                 pol_name = basename(pol_path);
>> --
>> 2.27.0
>>
