Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E1C00140
	for <selinux@archiver.kernel.org>; Wed,  3 Aug 2022 01:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiHCB4L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Aug 2022 21:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiHCB4K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Aug 2022 21:56:10 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9698A1A06C;
        Tue,  2 Aug 2022 18:56:09 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DEFB13F12D;
        Wed,  3 Aug 2022 01:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1659491767;
        bh=SJUqPuHba6yVp9G2SsmIOAkU0HrGEe+r59bU8RLOVCE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=B4pKT0gkkKZkoKdgLjSih8n+prgt846evMQJVy/V3M70tPGS8Y8GwAa5+fzBPoaah
         IqU9ELe8ZYoySzYjRjd4yK8/DNJDY+dAWZgUks+qIo5GWqblIymmqmzlFnPmYqsMBC
         6d1hQiisQdtI0JESpMVyEpjWUzlB/d9Ic8m5l5hABdGcRArjnm8MSvFsngZDA12JfA
         Z2CEBPl1ajZa9KF5nN/te/4LyptlFok1dlNYmvAoYLvsMkjrtNfLg9DWBL7gcAw3/x
         LuV9OnLKre4wNsqq3yHWMoE6qoHh1F3hFcc4swAE8vcQQavqSm0sz9+MoObZvwPVca
         GT/wi8EYRlnqQ==
Message-ID: <5ad95e3a-b0ea-f619-7ef3-483356da550d@canonical.com>
Date:   Tue, 2 Aug 2022 18:56:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/2/22 17:56, Paul Moore wrote:
> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
>> patch set in the LSM next branch for 6.1. The audit changes have polished
>> up nicely and I believe that all comments on the integrity code have been
>> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
>> There are serious binder changes, but I think they address issues beyond
>> the needs of stacking. Changes outside these areas are pretty well limited
>> to LSM interface improvements.
> 
> The LSM stacking patches are near the very top of my list to review
> once the merge window clears, the io_uring fixes are in (bug fix), and
> SCTP is somewhat sane again (bug fix).  I'm hopeful that the io_uring
> and SCTP stuff can be finished up in the next week or two.
> 
> Since I'm the designated first stuckee now for the stacking stuff I
> want to go back through everything with fresh eyes, which probably
> isn't a bad idea since it has been a while since I looked at the full
> patchset from bottom to top.  I can tell you that I've never been
> really excited about the /proc changes, and believe it or not I've
> been thinking about those a fair amount since James asked me to start
> maintaining the LSM.  I don't want to get into any detail until I've
> had a chance to look over everything again, but just a heads-up that
> I'm not too excited about those bits.
> 

I am slowly working my way through the complete stack of patches again as
well. I have pulled them into a test branch for Ubuntu 22.10 and the
plan is to get them out into our -proposed kernels for broader testing in
the next couple of weeks

