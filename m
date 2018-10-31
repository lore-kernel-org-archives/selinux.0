Return-Path: <SRS0=k0zu=NL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E17FECDE46
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 09:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBE82054F
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 09:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSjfF0W9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBE82054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJaSGU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:06:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33888 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeJaSGU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Oct 2018 14:06:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id g8-v6so11203706ljk.1;
        Wed, 31 Oct 2018 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QD0MfFcL+J8v5HV9LHvSPkbSgcqdAx+RmzUsUT+ma5U=;
        b=NSjfF0W9FO7AIkZnidBeSOvaQVvf/hSGohs70J5K3FJnMtGVhSQZfr7Poj2eQDDNDY
         TiVbkFB6e0sHLhqRJwdPER1stCKRUkU9bz3L8e+cMfbM4Tdhl5EPvAtyrrXAG5zOq24A
         JJrolU3l4IAiOGTw9TxIvlu4YorCbmm+2msWiRF2vEG9vJO5pVg0W4cUnl+Vv2jYyq4r
         AzEfV2I5DhGzImrDxqiKKwVxJ1G4heiDpiN3qcBU/gH+spLB3ugFIjfesAQRp/PMCLkc
         A0R3vG+XpOwBxIA8/KiuCZyA6izbsrjzqmSj6q74Wh+pW4SUtRr8xdzyU5HWPKLJemCR
         W0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QD0MfFcL+J8v5HV9LHvSPkbSgcqdAx+RmzUsUT+ma5U=;
        b=K1esYRmkmeC3F+1nU7QlR9+mO3PD9WchgN4xgRb5QsjOq7nhcUwYkBPCmdI5NLFMdT
         mcSYWa5H0gRxUiZzvu7eqYXqwe9wV9eEQR4Qc3Co0EHkuINDM/5wRF70zndlY1Ej0l1B
         uwYFxQk0wXuJshHacplye8xiB4zs4VgtNnI6E0rh7uInIZ8LCE5f8iIOI9s11n+zo0/a
         dIW+j5ojIZRpb6rZXBURkNvC5oDAeLW23q5mA1JMU1lMmCRunlBQfPwDPQnTAsmv/YNg
         hk/VAxfyvHEcBPIvN+UsJr1bHMtzuQ3k1ailfY7qsR1T/QAyMipkYfIoYMwh49e6p5F5
         PGyA==
X-Gm-Message-State: AGRZ1gJZgGvsGg1rDHsVX+730ghUIlgv80V7G16dDKaVINgOnXxwj7br
        fpscSGsgrgeHf967RhQPxS8UruoZ5zc=
X-Google-Smtp-Source: AJdET5cJVyjx+cZh1KeOGWKOVn98BdFCUPxuypWmLna+nn9+cLgQhFhtAXAqKRuDNVxXn06Pk7CtSQ==
X-Received: by 2002:a2e:93ca:: with SMTP id p10-v6mr1552095ljh.158.1540976941692;
        Wed, 31 Oct 2018 02:09:01 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-242.elisa-laajakaista.fi. [91.159.62.242])
        by smtp.gmail.com with ESMTPSA id m14-v6sm713463lji.29.2018.10.31.02.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 02:09:01 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, selinux@vger.kernel.org
References: <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org> <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
 <20181030213557.GE10491@bombadil.infradead.org>
 <CALCETrW1FcT88u0QY9k_PMOeZj0G8H6KNb5Bnreo-12NvmmCEQ@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <1d8e2d20-ba18-763e-03ff-d061e98d86ff@gmail.com>
Date:   Wed, 31 Oct 2018 11:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALCETrW1FcT88u0QY9k_PMOeZj0G8H6KNb5Bnreo-12NvmmCEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Adding SELinux folks and the SELinux ml

I think it's better if they participate in this discussion.

On 31/10/2018 06:41, Andy Lutomirski wrote:
> On Tue, Oct 30, 2018 at 2:36 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Tue, Oct 30, 2018 at 10:43:14PM +0200, Igor Stoppa wrote:
>>> On 30/10/2018 21:20, Matthew Wilcox wrote:
>>>>>> So the API might look something like this:
>>>>>>
>>>>>>          void *p = rare_alloc(...);      /* writable pointer */
>>>>>>          p->a = x;
>>>>>>          q = rare_protect(p);            /* read-only pointer */
>>>
>>> With pools and memory allocated from vmap_areas, I was able to say
>>>
>>> protect(pool)
>>>
>>> and that would do a swipe on all the pages currently in use.
>>> In the SELinux policyDB, for example, one doesn't really want to
>>> individually protect each allocation.
>>>
>>> The loading phase happens usually at boot, when the system can be assumed to
>>> be sane (one might even preload a bare-bone set of rules from initramfs and
>>> then replace it later on, with the full blown set).
>>>
>>> There is no need to process each of these tens of thousands allocations and
>>> initialization as write-rare.
>>>
>>> Would it be possible to do the same here?
>>
>> What Andy is proposing effectively puts all rare allocations into
>> one pool.  Although I suppose it could be generalised to multiple pools
>> ... one mm_struct per pool.  Andy, what do you think to doing that?
> 
> Hmm.  Let's see.
> 
> To clarify some of this thread, I think that the fact that rare_write
> uses an mm_struct and alias mappings under the hood should be
> completely invisible to users of the API.  

I agree.

> No one should ever be
> handed a writable pointer to rare_write memory (except perhaps during
> bootup or when initializing a large complex data structure that will
> be rare_write but isn't yet, e.g. the policy db).

The policy db doesn't need to be write rare.
Actually, it really shouldn't be write rare.

Maybe it's just a matter of wording, but effectively the policyDB can be 
trated with this sequence:

1) allocate various data structures in writable form

2) initialize them

3) go back to 1 as needed

4) lock down everything that has been allocated, as Read-Only
The reason why I stress ReadOnly is that differentiating what is really 
ReadOnly from what is WriteRare provides an extra edge against attacks, 
because attempts to alter ReadOnly data through a WriteRare API could be 
detected

5) read any part of the policyDB during regular operations

6) in case of update, create a temporary new version, using steps 1..3

7) if update successful, use the new one and destroy the old one

8) if the update failed, destroy the new one

The destruction at points 7 and 8 is not so much a write operation, as 
it is a release of the memory.

So, we might have a bit different interpretation of what write-rare 
means wrt destroying the memory and its content.

To clarify: I've been using write-rare to indicate primarily small 
operations that one would otherwise achieve with "=", memcpy or memset 
or more complex variants, like atomic ops, rcu pointer assignment, etc.

Tearing down an entire set of allocations like the policyDB doesn't fit 
very well with that model.

The only part which _needs_ to be write rare, in the policyDB, is the 
set of pointers which are used to access all the dynamically allocated 
data set.

These pointers must be updated when a new policyDB is allocated.

> For example, there could easily be architectures where having a
> writable alias is problematic.  On such architectures, an entirely
> different mechanism might work better.  And, if a tool like KNOX ever
> becomes a *part* of the Linux kernel (hint hint!)

Something related, albeit not identical is going on here [1]
Eventually, it could be expanded to deal also with write rare.

> If you have multiple pools and one mm_struct per pool, you'll need a
> way to find the mm_struct from a given allocation. 

Indeed. In my patchset, based on vmas, I do the following:
* a private field from the page struct points to the vma using that page
* inside the vma there is alist_head used only during deletion
   - one pointer is used to chain vmas fro mthe same pool
   - one pointer points to the pool struct
* the pool struct has the property to use for all the associated 
allocations: is it write-rare, read-only, does it auto protect, etc.

> Regardless of how
> the mm_structs are set up, changing rare_write memory to normal memory
> or vice versa will require a global TLB flush (all ASIDs and global
> pages) on all CPUs, so having extra mm_structs doesn't seem to buy
> much.

1) it supports differnt levels of protection:
   temporarily unprotected vs read-only vs write-rare

2) the change of write permission should be possible only toward more 
restrictive rules (writable -> write-rare -> read-only) and only to the 
point that was specified while creating the pool, to avoid DOS attacks, 
where a write-rare is flipped into read-only and further updates fail
(ex: prevent IMA from registering modifications to a file, by not 
letting it store new information - I'm not 100% sure this would work, 
but it gives the idea, I think)

3) being able to track all the allocations related to a pool would allow 
to perform mass operations, like reducing the writabilty or destroying 
all the allocations.

> (It's just possible that changing rare_write back to normal might be
> able to avoid the flush if the spurious faults can be handled
> reliably.)

I do not see the need for such a case of degrading the write permissions 
of an allocation, unless it refers to the release of a pool of 
allocations (see updating the SELinux policy DB)

[1] https://www.openwall.com/lists/kernel-hardening/2018/10/26/11

--
igor
