Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E7DC433DB
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 17:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C792161981
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 17:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhC2Rkx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Mar 2021 13:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhC2Rkb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Mar 2021 13:40:31 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 366F3C061574
        for <selinux@vger.kernel.org>; Mon, 29 Mar 2021 10:40:31 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 2F3752A12B1;
        Mon, 29 Mar 2021 19:40:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 2F3752A12B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1617039630;
        bh=ojYq4DMgY8xj42PtLLT36hCof0YX53jZANwb/Rguh88=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DtDJeMplS5VexqhMToegt5bg8JlBFvuXwK7EaKvCHEAym3e0mVCJ0Nb1kIR0uhX2f
         9hJrPo+YhOy2uvcvycTsLvZ1W3fOHh8LWJY7uNj8u7l7y3/PYPq3hCZcVAzTufB+Ho
         DR1IKQrs/CEk6PJzgylWtDetabsSpCI/ChD+q4TE=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: typechange silently dropped in some cases
References: <ypjl8s65aprj.fsf@defensec.nl>
        <CAP+JOzR=ryK1sp+YNBKqBO3QaQTmRcyXt+Z4cn0-tmOEJetXcQ@mail.gmail.com>
Date:   Mon, 29 Mar 2021 19:40:26 +0200
In-Reply-To: <CAP+JOzR=ryK1sp+YNBKqBO3QaQTmRcyXt+Z4cn0-tmOEJetXcQ@mail.gmail.com>
        (James Carter's message of "Mon, 29 Mar 2021 13:13:04 -0400")
Message-ID: <ypjl1rbxamet.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Mon, Mar 29, 2021 at 12:29 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>>
>> typechange rules expect three types: sourcetype loginterminaltype
>> targettype
>>
>> 1. you can use typeattributes for loginterminaltype fine
>> 2. if you try to use typeattributes for targettype then cil wil refuse
>> to build it with a helpful message along the lines of: targettype cannot
>> be typeattribute
>> 3. if you try to use typeattributes for sourcetype then cil wil not
>> refuse to build it but it will result in the rule not being added
>>
>> scenario 3 is obviously less than optimal. although it would have been
>> nice if you could use typeattributes for not just loginterminaltype, it
>> should probably atleast fail to build with a helpful message such as in
>> scenario 2 when you try to use a type attribute for source type.
>
> I am not seeing that behavior.
>
> I took a minimal CIL policy and added the following lines:
>   (type t1a)
>   (type t1b)
>   (type t2a)
>   (type t2b)
>   (type t3)
>   (typeattribute a1)
>   (typeattributeset a1 (t1a t1b))
>   (typeattribute a2)
>   (typeattributeset a2 (t2a t2b))
>   (typealias ta3)
>   (typealiasactual ta3 t3)
>   (typechange a1 a2 CLASS ta3)
>
> After running:
>   secilc -o test.bin typeclass.cil
>   checkpolicy -C -b -o test.bin.cil test.bin
>
> I get the following typechange rules:
>   (typechange t1a t2a CLASS t3)
>   (typechange t1a t2b CLASS t3)
>   (typechange t1b t2a CLASS t3)
>   (typechange t1b t2b CLASS t3)
>
>
> Maybe there is something else going on?

Sorry, nevermind. it does work...



>
> Thanks,
> Jim
>
>>
>> --
>> gpg --locate-keys dominick.grift@defensec.nl
>> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
>> Dominick Grift

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
