Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE9C433E2
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 13:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7AE207D3
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 13:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="GcfB9nsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390427AbgE1N3p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 09:29:45 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:36516 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390384AbgE1N2q (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 28 May 2020 09:28:46 -0400
Received: from [IPv6:2001:985:d55d::438] (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 2B5342A0018;
        Thu, 28 May 2020 15:28:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 2B5342A0018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1590672519;
        bh=GKOSKnpoP6yG1aUFhb6FqKP0vjJV9oceFaiboGsEhxk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GcfB9nsUMyPcpezLA9rdMYaAKP/B4acq/EkMzj/AwoC2+d01z8BNinJ+wKCNjZq4m
         NPXXSsIV7SUophqTxt+BLCrcemhgiqI7hM9mUeKW7G/hfSqxLfv514TGNdwYWx+dh+
         6STlCiD6FtfylhR3umBnTnK5arAwVPgW1HvRQghk=
Subject: Re: CIL typealiases
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <ypjlsgfk71po.fsf@defensec.nl>
 <CAP+JOzRQzA=PU+djvZmyA_RtdcduMQuyhZPvNSpNodpE_G4xGg@mail.gmail.com>
From:   Dominick Grift <dominick.grift@defensec.nl>
Message-ID: <520dd447-7ba4-9ea5-0353-425a7da4497b@defensec.nl>
Date:   Thu, 28 May 2020 15:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAP+JOzRQzA=PU+djvZmyA_RtdcduMQuyhZPvNSpNodpE_G4xGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 5/28/20 3:19 PM, James Carter wrote:
> On Thu, May 28, 2020 at 7:21 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>>
>> tl;dr typalias (and possibly typealiasactual) statement does not like periods
>>
>> systemd plans to consolidate systemd-udevd and udevadm and so I was
>> looking to consolidate the policy. For compatibility I wanted to add a
>> (typealias .udev.udevadm.exec) and (typealiasactual .udev.udevadm.exec
>> .udev.daemon.exec)
>>
>> That reminded me that it does not like the period name space
>> delimiter in at least the typealias statement.
>>
>> Example:
>>
>> [root@brutus ~]# echo "(block test (type test1) (typealias test2.test1)
>> (typealiasactual test2.test1 test.test1))" > mytest.cil
>> [root@brutus ~]# semodule -vvv -i mytest.cil
>>
>> <snip>
>> Building AST from Parse Tree
>> Invalid character "." in test2.test1
>> Invalid name
>> Failed to create node
>> Bad typealias declaration at
>> /var/lib/selinux/mydssp3-mcs/tmp/modules/400/mytest/cil:1
>> Problem at /var/lib/selinux/mydssp3-mcs/tmp/modules/400/mytest/cil:1
>> Failed to build ast
>> semodule:  Failed!
>>
> 
> CIL doesn't like "." in any name used in a declaration.
> 
> If you want an alias with a "." in it, then use blocks.
> (block udev
>   (block daemon
>      (type exec)
>   )
>   (block udevadm
>      (typealias exec)
>      (typealiasactual exec .udev.daemon.exec)
>   )
> )
> 
> Or something like that.

Right, thanks that works and sorry about that. Feels like deja vu, must
have not been the first time I encountered this.

Feels kind of un-intuitive but makes perfect sense thinking about it.
Just need to get used to it.


> 
> Jim
> 
