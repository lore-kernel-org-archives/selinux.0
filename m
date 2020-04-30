Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4ADC47247
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 14:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E2520775
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 14:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="ZNYWrFX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgD3O61 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbgD3O61 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 10:58:27 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE27C035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 07:58:26 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s30so5218670qth.2
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lBAQFp2UzwN+1Z0io0Id0cdskXJRdo0vmvHnF4ou/m8=;
        b=ZNYWrFX3QUVJqu+C3A/FgdwA2vQOK9rFtTmiMOD+4l68pVAYSRu8sZwcNFIAE5iKgF
         xEVXOJJzrVVd+KPUyH8VkbW3bJaKiKWQVY2ie3xyTeV6tzMvCa+wY3Tg7gZzR15Q5UrO
         Fmb29Yxz1j6azHykPZFczWc65p2MMKGNg5tLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lBAQFp2UzwN+1Z0io0Id0cdskXJRdo0vmvHnF4ou/m8=;
        b=bQblzTj10O5mVA9ayTYghteRe28Jk7D1NQDTO7IliqRVVKajMNmXMR4FfrWF8psK2o
         Mezg7uRWe3jdXLcpuQB9nBU8+sQeWici/GEbmFl95hLcjd1gqSeakSmxFcwScVHpmnpm
         0d2RvR9ESSGyskwn78DXvG3hyjC0vzZM7Yzs0HQSpeY+nWpNUbK+CLxj5tKXg0Qi3iGB
         EW8/SlhHjAVOKwDpqlqLVYBfF1MjlZ/HA1vGqS1AbhFByFpnu21gkAIveTgfkmXXpXVv
         B3G7whAwI0MAr1whhdTbmEal+UrAELaig3HQW2ayIwoeavUzuaxX6z/cPexsmeCvoSLW
         l6JA==
X-Gm-Message-State: AGi0Pub9rrUXofxoYlj0bUInog6ef+0+MY5g1AEfAvLRvQYTZH4oyChv
        RcVt0rAaW/R/NDXhs5daH0GLcT1m8f0=
X-Google-Smtp-Source: APiQypJfV+Fl0d9sO2rL4Rbs6YThA0XziJHSoLiZae3PRmrQo/Iipd3nLs4wk54Ncc5uIeZmQgKJhg==
X-Received: by 2002:ac8:1b97:: with SMTP id z23mr4003039qtj.294.1588258705696;
        Thu, 30 Apr 2020 07:58:25 -0700 (PDT)
Received: from fedora.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id u27sm2296011qtc.73.2020.04.30.07.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:58:24 -0700 (PDT)
Subject: Re: [PATCH 0/2] userspace: Implement new format of filename trans
 rules
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
References: <20200327152107.95915-1-omosnace@redhat.com>
 <daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov>
 <7549b0e2-f845-1c3a-d9d5-314cb2b9225f@ieee.org>
 <CAP+JOzRqVNLY67_FdP6MyaKqr=L0phaLEhjb=T4mtb+Dwwhhrg@mail.gmail.com>
 <CAEjxPJ5f9Lj8ZizfSYk6MwRamYAj=qAUa_dkc3fdV-a2S0ugXw@mail.gmail.com>
 <CAFqZXNuLhpOQLk54QNExgnwKZXM=nBKGg9YFxuVhUo1U+sF_jA@mail.gmail.com>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <789178c6-3c52-c620-2d2f-ae2927a2fa86@ieee.org>
Date:   Thu, 30 Apr 2020 10:58:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNuLhpOQLk54QNExgnwKZXM=nBKGg9YFxuVhUo1U+sF_jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/30/20 10:20 AM, Ondrej Mosnacek wrote:
> On Thu, Apr 30, 2020 at 3:23 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Wed, Apr 29, 2020 at 3:01 PM James Carter <jwcart2@gmail.com> wrote:
>>> I think the fact that the CIL, kernel to CIL, kernel to conf, and
>>> module to CIL code is all in libsepol speaks to the fact of how
>>> tightly integrated they are to the rest of libsepol. One argument that
>>> could be made is that the policyrep stuff in setools really belongs in
>>> libsepol.
>>>
>>> Thinking about how libsepol could be encapsulated leads me to a couple
>>> of possibilities. One way would be functions that could return lists
>>> of rules. The policy module code gives us avrule_t, role_trans_rule_t,
>>> role_allow_t, filename_trans_rule_t, range_trans_rule_t, and others.
>>> Those structures are probably unlikely to change and, at least in this
>>> case, creating a function that walks the filename_trans hashtable and
>>> returns a list of filename_trans_rule_t certainly seems like it
>>> wouldn't be too hard. Another possible way to encapsulate would be
>>> create a way to walk the various hashtables element by element (I
>>> think hashtab_map() requires too much knowledge of the internal
>>> structures), returning an opaque structure to track where you are in
>>> the hashtable and functions that allow you to get each part of the
>>> rule being stored. There are other ways that it could be done, but I
>>> could rewrite kernel to and module to stuff with either of those. CIL
>>> itself would require some functions to insert rules into the policydb
>>> which probably wouldn't be too hard. None of this would be too hard,
>>> but it would take some time. The real question is would it really be
>>> valuable?
>>
>> I don't think we want to directly expose the existing data structures
>> from include/sepol/policydb/*.h (or at least not without a careful
>> audit) since those are often tightly coupled to policy compiler
>> internals and/or the kernel or module policy formats. Creating an
>> abstraction for each with a proper API in new definitions in
>> include/sepol/*.h would be preferable albeit more work. There was a
>> proposal a long time ago from the setools developers to create an
>> iterator interface and accessor functions for each data type, see
>> https://lore.kernel.org/selinux/200603212246.k2LMkRNq028071@gotham.columbia.tresys.com/.
> 
> We could also partially mitigate the problem by linking libsepol
> statically into setools at build time. I suggested this in [1] for
> Fedora at least, but in general there is the problem that you need to
> know the exact path to libsepol.a in setup.py [2]. I don't have enough
> experience with python libraries to know if this can be implemented
> directly in the upstream setup.py script in a reasonably generic way.
> 
> If linked statically, at least it wouldn't segfault after an update to
> an incompatible libsepol.so. It would still fail to build with the new
> headers, but at least this turns from a user-visible bug to only
> packager's & maintainer's problem.

It used to be static and people complained about that.  I moved it to dynamic 
knowing this would be an issue, but an uncommon one.


-- 
Chris PeBenito
