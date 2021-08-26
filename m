Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EC1C432BE
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 12:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC38610A3
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 12:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbhHZMjZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241129AbhHZMjW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Aug 2021 08:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629981514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mZmDNA4TCPgzjlg69smmc06iaibRS76gTsXqMM9ugmM=;
        b=cXhdlLfiAcd1s1gsO+46Ntvd4E7jhzFYOplwC9ihMReS96wpZL9MbG8RcqunVLAoo7aeiB
        0CYvBTFQqTvO+UCOFiINnGjNwVg7FApy4WHuVioW9f+lHI9nPXPJ1+g7OwdYt+1BiXmxiw
        3OMUtFpQ21/TIdytE9n1LkrG3mOhS4w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-cNqWZ1SONsu0b7AYhvYw2w-1; Thu, 26 Aug 2021 08:38:33 -0400
X-MC-Unique: cNqWZ1SONsu0b7AYhvYw2w-1
Received: by mail-wm1-f71.google.com with SMTP id f128-20020a1c3886000000b002e887c95e07so825362wma.1
        for <selinux@vger.kernel.org>; Thu, 26 Aug 2021 05:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mZmDNA4TCPgzjlg69smmc06iaibRS76gTsXqMM9ugmM=;
        b=Jae46WxmGLoZ/kAzNW8SytvDym2MLOBQngiKGD0QxB0Ei6htHSiKoCZ58+DTx+babf
         +w1u92f7Aeb1R07Hh+lKa9CNbMDfe9X+nE1ikL2eeSmc59FoUuhzMLu4B/KxbjvdSWzi
         forgFMquYvvJLg920xQJRuy93+R+zz93xgd1Ja5q40YUnFlbbT+qKqxM0hi2LdGCJGRb
         /1c5UzuILC3Oz10EYoGX0LSICjo9yk68PWG9k16ydEDy5sIK9h0tJpLXn9J3/08tw3+4
         1DfitbMKmMZI/zgeD6omfzweyghLZio7XtmMd41W027696AUeT0SJe9t0idaHwGiyQLM
         3OoA==
X-Gm-Message-State: AOAM531RSq4aW96XRh7DA1OYI2hKoGcPcvta2yYWCGq2NXA3o7cgrbEz
        Z7gMwFcbONZ5mMqT786tvIK59/GAXoSGBqPmErCWqVcqjrws4D6VXKTEQtDkbgef5+jo0tjhZmR
        twSPF+ZBZNlLUhU5sTg==
X-Received: by 2002:a1c:a7d2:: with SMTP id q201mr3434672wme.77.1629981511619;
        Thu, 26 Aug 2021 05:38:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVIOroQxahRZhpQHOv3JmsalF72+9Ju2Yxz7Oyzv/SbLpqP3I1/jb5wLwHjyKXFj/EjlyFXg==
X-Received: by 2002:a1c:a7d2:: with SMTP id q201mr3434658wme.77.1629981511432;
        Thu, 26 Aug 2021 05:38:31 -0700 (PDT)
Received: from [192.168.0.108] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id z13sm3082075wrs.71.2021.08.26.05.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 05:38:31 -0700 (PDT)
Subject: Re: Cil block inheritance
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org, Lukas Vrabec <lvrabec@redhat.com>
References: <81ea2624-ace9-4d86-9506-d6527a770cf6@redhat.com>
 <877dg8l83w.fsf@defensec.nl>
From:   Vit Mojzis <vmojzis@redhat.com>
Message-ID: <ce82e933-ceb8-a293-c57e-6dd6f8c31254@redhat.com>
Date:   Thu, 26 Aug 2021 14:38:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <877dg8l83w.fsf@defensec.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 26. 08. 21 14:10, Dominick Grift wrote:
> Vit Mojzis <vmojzis@redhat.com> writes:
>
>> Hi,
>> recent changes in block inheritance broke our use case where we use
>> block inheritance for generating container policies
>> (https://github.com/containers/udica/tree/main/udica/templates). Basically
>> the policy is composed by inheriting selected "template" blocks, all
>> of which inherit "container" block, so that they can use types defined
>> there.
>>
>> Reproducer:
>> (block template1 (type t) )
>> (block template2 (blockinherit template1))
>> (block b (blockinherit template1) (blockinherit template2))
> In this example there is no point in inheriting template1, because
> template2 already inherits it.
>
> (block template1
>         (type t))
> (block template2
>         (blockinherit template1))
> (block b (blockinherit template2)
>         (allow t t (file (read))))
>
> semodule -i test.cil
> seinfo -t b.t
Sure, but with more templates (as we have in udica) we get the same issue.

(block template1 (type t) )
(block template2 (blockinherit template1))
(block template3 (blockinherit template1))
(block b (blockinherit template2) (blockinherit template3))

# semodule -i test.cil
Re-declaration of type t
Previous declaration of type at /var/lib/selinux/targeted/tmp/modules/400/test/cil:1
Failed to copy block contents into blockinherit
Failed to resolve AST
semodule:  Failed!


Template2 and template3 mostly inherit template1 for the type defined there (so that they can define rules containing the type).

>
>> #semodule -i test.cil
>> Re-declaration of type t
>> Previous declaration of type at
>> /var/lib/selinux/targeted/tmp/modules/400/test/cil:1
>> Failed to copy block contents into blockinherit
>> Failed to resolve AST
>> semodule: Failed!
>>
>> This used to work just fine.
>>
>> The following workaround seems to be working as intended, but I'm not
>> sure if it's the best approach. Types are only defined in template1
>> and the rest contains "optional" block, so that I can use types
>> defined in template1).
>>
>> (block template1 (type t))
>> (block template2
>>       (optional o
>>           (allow t t ( file ( read )))
>>       )
>> )
>> (block b (blockinherit template1) (blockinherit template2))
> You can just do something like this:
>
> (block template1 (type t))
> (block template2 (blockinherit template1) (optional o (allow t t (file
> (read))))
> (block b (blockinherit template2))
> semodule -i test.cil
> sesearch -A -t b.t
With more templates, this break as well.

But the following works:

(block template1 (type t))
(block template2 (optional o (allow t t (file (read)))))
(block template3 (optional o (allow t t (file (write)))))
(block b (blockinherit template1) (blockinherit template2) (blockinherit template3))

#semodule -i test.cil
#sesearch -A -s b.t
allow b.t b.t:file { read write };

Again, I'm not sure if this is the best solution, just the only one I managed to get working.

Vit

>> #semodule -i test.cil
>> #sesearch -A -s b.t
>> allow b.t b.t:file read;
>>
>> Any pointers would be appreciated.
>>
>> Thank you.
>>
>> Vit
>>

