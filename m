Return-Path: <SRS0=OFWW=BF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46DBC433E0
	for <selinux@archiver.kernel.org>; Sun, 26 Jul 2020 18:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6902065F
	for <selinux@archiver.kernel.org>; Sun, 26 Jul 2020 18:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvIVII0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgGZSBv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGZSBv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 26 Jul 2020 14:01:51 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D73C0619D2
        for <selinux@vger.kernel.org>; Sun, 26 Jul 2020 11:01:50 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n24so10666847otr.13
        for <selinux@vger.kernel.org>; Sun, 26 Jul 2020 11:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pJKFcr9KYQj8UalKaF5ultTMs/CnCO0qBmkfZBniZDY=;
        b=DvIVII0CNdflvj7va7Y6L1ZXcu3e8yCvBlFy7FP3xYcQJtZY9yrqXNufEECTdxbeHY
         lEd44qoZwmIp1fhfqKwEWB89vnc2bot21BO73Ny1MvQo/Lr9JggGI4I+D3CueEy57PSX
         14BW3rYWuYJdBuNJgdGnN1zBP0ib1HE8gJgy7EDDg9xE0eyuV9QrJKAdqF1iQkMOCW10
         VAgZs3Z4m4L4P/qNyVtTub1amV6dZoNoR6avSV0CKsvMbgwCTqmem+nrpfxZQtI7pa95
         lgwhhvmVTZ27lOa//dAj1k0pkb54N4A4ozMXZgu2MRr7rJzwrCaQka2q0DyvnRv+feqT
         9vVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pJKFcr9KYQj8UalKaF5ultTMs/CnCO0qBmkfZBniZDY=;
        b=a0kE7g0aoblFCa8Gdr7FCzbtK0vXPRwqox18C6xxLZ2fmNTs3gtJeMODXMQSa5XzqW
         NQ0le4y3GirSu033I65vJnFxNw9o2YusfnCmko81LkvNsAqHfVtTQFYV8YQw4YFgQsRR
         Yui+hKMN3ra7/kie+Stbp4CJK3w8Od14bdhXDBRVyb3UIOaSDtXs40+lhpL+0bt4UoXv
         Wih1PB/BGTKM270WMWROpOOX8sfZffD6mVHcSDsvKBLfMKmT3LDJGzw4X167nEZznLcL
         AhCzQLVn5CbHtEcVNDhG9eqSx1yiwoiCHYK0zK1yn6MyGLxvHQ4HVtSspkfCdE+bApRn
         lmGw==
X-Gm-Message-State: AOAM531Yk41Rl9rNFjxksu3P02Gb0hxqP8xx1/ceHjZiGh8Bs97ZIq0f
        GPu0CQ/eNTxutoQ4p/qq0QIakuBr
X-Google-Smtp-Source: ABdhPJx02eJnVjyDNJ/L2nj/m0e1MwhZlwx51b8qjaexZwBLQ7sJhbNtBnOTmnh7XY5M2FBEnGEVLQ==
X-Received: by 2002:a9d:2787:: with SMTP id c7mr1110901otb.29.1595786509696;
        Sun, 26 Jul 2020 11:01:49 -0700 (PDT)
Received: from ian.penurio.us (cpe-70-119-169-186.tx.res.rr.com. [70.119.169.186])
        by smtp.gmail.com with ESMTPSA id r19sm2842394otn.28.2020.07.26.11.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 11:01:49 -0700 (PDT)
Subject: Re: File context rule not working
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <31fac4d5-3c2e-75b5-5759-52322d8dd733@gmail.com>
 <CAJfZ7=m7udOgTOcoR3wEEtxnAoaLmBaHSeVzBYxsQhmzmw2qGQ@mail.gmail.com>
From:   Ian Pilcher <arequipeno@gmail.com>
Message-ID: <35b8c022-3c40-4005-b188-9f004556e927@gmail.com>
Date:   Sun, 26 Jul 2020 13:01:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=m7udOgTOcoR3wEEtxnAoaLmBaHSeVzBYxsQhmzmw2qGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/26/20 11:01 AM, Nicolas Iooss wrote:
> I guess this is due the rule 3 documented in
> https://manpages.debian.org/experimental/libselinux1-dev/selabel_lookup_best_match_raw.3.en.html
> (source https://github.com/SELinuxProject/selinux/blob/master/libselinux/man/man3/selabel_lookup_best_match.3):
> 
>      The order of precedence for best match is:
>      1. An exact match for the real path (key) or
>      2. An exact match for any of the links (aliases), or
>      3. The longest fixed prefix match.
> 
> I guess that in your policy, there is a rule that states that
> /usr/bin(/.*)? is labeled bin_t. As both /usr/bin(/.*)? and
> /usr(/local)?/bin/raidcheck match /usr/bin/raidcheck, the order of
> precedence is determined by the number of characters before the first
> special characters (that indidate a regular expression). As
> /usr/bin(/.*)? has a longer "fixed prefix", it is the one that
> matches.

I can't find a '/usr/bin(/.*)?' rule.  'semanage fcontext --list' should
show it, right?

[root@n5550 files]# semanage fcontext --list | egrep '/usr/bin\('
/usr/lib/debug/usr/bin(/.*)?                       regular file 
system_u:object_r:bin_t:s0

But I suspect that your reasoning is still correct.  I wasn't aware of
the precedence rule.  The first "special character" does come pretty
early in my rule, so it's likely that something that's considered more
specific would match.

> Does using "/usr/bin/raidcheck
> system_u:object_r:raidcheck_exec_t:s0" fix your issue? If yes, you can
> either duplicate the line (by adding both /usr/bin/... and
> /usr/local/bin/...), or configure a substitution pattern such that
> /usr/local/bin... gets transformed into /usr/bin/... before searching
> for patterns.

'/usr/bin/raidcheck' and '/usr/local/bin/raidcheck' both work, so I'll
likely just go with that.

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
