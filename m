Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8803FC83000
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 14:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58BC12076D
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 14:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Fpz9Uypi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgD3OYQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgD3OYP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 10:24:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67122C035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 07:24:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t3so5857569qkg.1
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 07:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Se/k9ryilAyuoG++T+gDjvESNib6WiuczsV9h49tZY=;
        b=Fpz9UypiTh/oHl0WXQkqkRHKSRuXQbmQB7m+Ek5dho+x+cXabsBYbvutpmdoJ98fLV
         5q7bT8OScjGJmTvc86D0lBmNe0Y+6V9KvYnSJjcQ6/6BrF3jVs14SCpaz+xCYMtZMuv0
         itj73fT0JHNQJiiHMEggzs/yFG51fw0v4sm1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Se/k9ryilAyuoG++T+gDjvESNib6WiuczsV9h49tZY=;
        b=NL2mxu73LxHa1dPmp93pUiBkJlk4J1dIvFX2KUJ5QWBFSKPDItBhbAtg6s2WPNEkOq
         flxZGCaGxydCcMQjWCBsVGXy/rUI0djNCTL2LunhJessTzbcv+cWgAPBJiKi/YQ01UKQ
         x6noIE28xVMnRfaUMIfTcYlm25Y6tWoC2caHr36eagSUuMZRrZr1RifD83Gdxoy5wOnr
         6p5t6Q4D4VsWTgNe3M47VjWSFWNgmIUYmqGzPzAVp3W0eGYGbcMQCW3mRqe9yfPacl8v
         0IhJejjVgtxgkEnbYquGBNS3vfEKgCz8bpnjCIvWiKxCZEbGMF/YKLf0LemSigQXrKIN
         zFrA==
X-Gm-Message-State: AGi0PubTSPdP0OUOrURvHQyWpaayvcOZfer5cR2uS0sCtpMO8GrT2ibP
        JVJEXxxV1b+IO9BaR16GEShVELTWC4o=
X-Google-Smtp-Source: APiQypLCWw9rycuqBa2V2S9L/08+0atxFRtnsTqf0nBiI8kLI9rbCLD34L2VmWBhwBaykcWMYVjlJw==
X-Received: by 2002:a37:9d08:: with SMTP id g8mr3803675qke.138.1588256654235;
        Thu, 30 Apr 2020 07:24:14 -0700 (PDT)
Received: from fedora.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id 10sm2509172qtp.4.2020.04.30.07.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:24:13 -0700 (PDT)
Subject: Re: [PATCH 0/2] userspace: Implement new format of filename trans
 rules
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        James Carter <jwcart2@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20200327152107.95915-1-omosnace@redhat.com>
 <daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov>
 <7549b0e2-f845-1c3a-d9d5-314cb2b9225f@ieee.org>
 <CAP+JOzRqVNLY67_FdP6MyaKqr=L0phaLEhjb=T4mtb+Dwwhhrg@mail.gmail.com>
 <CAEjxPJ5f9Lj8ZizfSYk6MwRamYAj=qAUa_dkc3fdV-a2S0ugXw@mail.gmail.com>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <121c1c0d-da7b-681a-ae6e-121228a046af@ieee.org>
Date:   Thu, 30 Apr 2020 10:24:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5f9Lj8ZizfSYk6MwRamYAj=qAUa_dkc3fdV-a2S0ugXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/30/20 9:22 AM, Stephen Smalley wrote:
> On Wed, Apr 29, 2020 at 3:01 PM James Carter <jwcart2@gmail.com> wrote:
>> I think the fact that the CIL, kernel to CIL, kernel to conf, and
>> module to CIL code is all in libsepol speaks to the fact of how
>> tightly integrated they are to the rest of libsepol. One argument that
>> could be made is that the policyrep stuff in setools really belongs in
>> libsepol.
>>
>> Thinking about how libsepol could be encapsulated leads me to a couple
>> of possibilities. One way would be functions that could return lists
>> of rules. The policy module code gives us avrule_t, role_trans_rule_t,
>> role_allow_t, filename_trans_rule_t, range_trans_rule_t, and others.
>> Those structures are probably unlikely to change and, at least in this
>> case, creating a function that walks the filename_trans hashtable and
>> returns a list of filename_trans_rule_t certainly seems like it
>> wouldn't be too hard. Another possible way to encapsulate would be
>> create a way to walk the various hashtables element by element (I
>> think hashtab_map() requires too much knowledge of the internal
>> structures), returning an opaque structure to track where you are in
>> the hashtable and functions that allow you to get each part of the
>> rule being stored. There are other ways that it could be done, but I
>> could rewrite kernel to and module to stuff with either of those. CIL
>> itself would require some functions to insert rules into the policydb
>> which probably wouldn't be too hard. None of this would be too hard,
>> but it would take some time. The real question is would it really be
>> valuable?
> 
> I don't think we want to directly expose the existing data structures
> from include/sepol/policydb/*.h (or at least not without a careful
> audit) since those are often tightly coupled to policy compiler
> internals and/or the kernel or module policy formats. Creating an
> abstraction for each with a proper API in new definitions in
> include/sepol/*.h would be preferable albeit more work. There was a
> proposal a long time ago from the setools developers to create an
> iterator interface and accessor functions for each data type, see
> https://lore.kernel.org/selinux/200603212246.k2LMkRNq028071@gotham.columbia.tresys.com/.

I agree.  The hardest thing with writing the policyrep in setools was stuff like 
the value_to_datum indirections, type_attr_map, etc. and knowing when to use 
value vs value-1.  An API that has a new set of structs would be ideal.

Unfortunately, since setools policyrep is now written in Cython, we can't simply 
move the code over to libsepol.  My guess is dispol has the most useful building 
blocks for making a new API.


-- 
Chris PeBenito
